{
  description = "Advent of Code 2015 - Python";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        python = pkgs.python312;
      in
      {
        devShells.default = pkgs.mkShell {
          packages = [
            python
            pkgs.ruff
            pkgs.mypy
            pkgs.basedpyright
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
        };
      });
}
