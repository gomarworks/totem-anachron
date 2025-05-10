{
  description = "Totem keyboard firmware";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Official Zephyr RTOS
    zephyr.url = "github:zephyrproject-rtos/zephyr/v3.7.0";
    zephyr.flake = false;

    # Use theol's ZMK fork for Anachron features
    zmk.url = "github:theol0403/zmk";
    zmk.flake = false;

    # Zephyr sdk and toolchain.
    zephyr-nix.url = "github:urob/zephyr-nix";
    zephyr-nix.inputs.zephyr.follows = "zephyr";
    zephyr-nix.inputs.nixpkgs.follows = "nixpkgs";

    # Nodefree config for ZMK
    zmk-nodefree-config.url = "github:urob/zmk-nodefree-config";
    zmk-nodefree-config.flake = false;
  };

  outputs = { self, nixpkgs, zephyr, zmk, zephyr-nix, zmk-nodefree-config }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    in
    {
      devShells = forAllSystems (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          zephyrEnv = zephyr-nix.packages.${system}.sdk;
          keymap-drawer = pkgs.callPackage ./nix/keymap-drawer.nix { };
        in
        {
          default = pkgs.mkShell {
            buildInputs = with pkgs; [
              zephyrEnv
              keymap-drawer
              tree-sitter
              python3Packages.west
              cmake
              ninja
              dtc
            ];
            shellHook = ''
              export ZMK_CONFIG="$(pwd)/config"
              export ZMK_NODEFREE_CONFIG="${zmk-nodefree-config}"
              
              # Set up build directory in user's home
              export BUILD_DIR="$HOME/.zmk-build"
              mkdir -p "$BUILD_DIR"
              
              # Set up Zephyr SDK environment
              export ZEPHYR_TOOLCHAIN_VARIANT="gnuarmemb"
              export GNUARMEMB_TOOLCHAIN_PATH="${pkgs.gcc-arm-embedded}"
              
              # Clean up and recreate ZMK directory with proper permissions
              rm -rf "$BUILD_DIR/zmk"
              git clone https://github.com/theol0403/zmk.git "$BUILD_DIR/zmk"
              chmod -R u+w "$BUILD_DIR/zmk"
              export ZMK_SRC_DIR="$BUILD_DIR/zmk/app"
              
              # Initialize west workspace first
              cd "$BUILD_DIR/zmk"
              west init -l app
              west update
              cd - > /dev/null
              
              # Now copy our files with proper permissions
              mkdir -p "$BUILD_DIR/zmk/app/boards/shields/totem"
              cp -r config/boards/shields/totem/* "$BUILD_DIR/zmk/app/boards/shields/totem/"
              chmod -R u+w "$BUILD_DIR/zmk/app/boards/shields/totem"
              
              mkdir -p "$BUILD_DIR/zmk/app/include/zmk-nodefree-config"
              cp -r "$ZMK_NODEFREE_CONFIG/include/zmk-helpers"/* "$BUILD_DIR/zmk/app/include/zmk-nodefree-config/"
              chmod -R u+w "$BUILD_DIR/zmk/app/include/zmk-nodefree-config"
              
              mkdir -p "$BUILD_DIR/zmk/app/include/zmk-nodefree-config/keypos_def"
              cp config/boards/shields/totem/keypos_36keys.h "$BUILD_DIR/zmk/app/include/zmk-nodefree-config/keypos_def/"
              chmod u+w "$BUILD_DIR/zmk/app/include/zmk-nodefree-config/keypos_def/keypos_36keys.h"
              
              mkdir -p "$BUILD_DIR/zmk/app/include/dt-bindings/zmk"
              cp config/boards/shields/totem/dynamic-macros.h "$BUILD_DIR/zmk/app/include/dt-bindings/zmk/"
              chmod u+w "$BUILD_DIR/zmk/app/include/dt-bindings/zmk/dynamic-macros.h"
              
              # Update west workspace one final time
              cd "$BUILD_DIR/zmk" && west update
              cd - > /dev/null
              
              # Custom prompt
              export PS1="\[\033[1;32m\]AnachronShell\[\033[0m\]@\[\033[1;34m\]\h\[\033[0m\]:\[\033[1;33m\]\w\[\033[0m\]\$ "
              export PROMPT_COMMAND=""

              # Function to build split keyboard
              build_split_keyboard() {
                # Create firmware output directory
                mkdir -p "$BUILD_DIR/firmware"
                
                # Change to ZMK directory
                cd "$BUILD_DIR/zmk"
                
                echo -e "\n\033[1;33mBuilding left side...\033[0m"
                west build -s app -d build/left -p -b xiao_ble -- -DSHIELD=totem_left
                cp build/left/zephyr/zmk.uf2 "$BUILD_DIR/firmware/totem_left.uf2"
                
                echo -e "\n\033[1;33mBuilding right side...\033[0m"
                west build -s app -d build/right -p -b xiao_ble -- -DSHIELD=totem_right
                cp build/right/zephyr/zmk.uf2 "$BUILD_DIR/firmware/totem_right.uf2"
                
                # Return to original directory
                cd - > /dev/null
                
                echo -e "\n\033[1;32mBuild complete! Firmware files:\033[0m"
                echo -e "  \033[1;36mLeft:\033[0m  $BUILD_DIR/firmware/totem_left.uf2"
                echo -e "  \033[1;36mRight:\033[0m $BUILD_DIR/firmware/totem_right.uf2"
              }

              # Show welcome message
              echo -e "\n\033[1;32m=== Welcome to AnachronShell! ===\033[0m"
              echo -e "\n\033[1;33mTo build your split keyboard firmware:\033[0m"
              echo -e "  \033[1;36mRun:\033[0m build_split_keyboard"
              echo -e "\n\033[1;33mFirmware files will be in:\033[0m $BUILD_DIR/firmware/"
              echo -e "\n\033[1;33mHappy building! 🎮\033[0m\n"
            '';
          };
        }
      );
    };
}