{ pkgs, python3 }:

python3.pkgs.buildPythonApplication {
  pname = "keymap-drawer";
  version = "0.4.0";
  format = "pyproject";

  src = pkgs.fetchFromGitHub {
    owner = "caksoylar";
    repo = "keymap-drawer";
    rev = "v0.4.0";
    hash = "sha256-FAiQHbuc3LKOp56vKablKMI/0hMpY5tStN4h50VlImE=";
  };

  nativeBuildInputs = with python3.pkgs; [
    poetry-core
  ];

  propagatedBuildInputs = with python3.pkgs; [
    pydantic_1
    pyyaml
    tree-sitter
    pcpp
    pyparsing
  ];

  meta = with pkgs.lib; {
    description = "Convert keyboard layout maps into pretty SVG drawings";
    homepage = "https://github.com/caksoylar/keymap-drawer";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
  };
}
