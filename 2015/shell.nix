{ pkgs ? import <nixpkgs> {} }:

let
  python = pkgs.python312;
in
pkgs.mkShell {
  packages = [
    python
    pkgs.ruff
    pkgs.mypy
  ];

  shellHook = ''
    if [ ! -d .venv ]; then
      ${python.interpreter} -m venv .venv
    fi
    source .venv/bin/activate
    if [ ! -f .venv/installed ]; then
      pip install --quiet pytest syrupy
      touch .venv/installed
    fi
  '';
}
