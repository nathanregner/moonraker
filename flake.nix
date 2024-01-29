{
  description = "A basic flake with a shell";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs =
    { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        python = pkgs.python310.withPackages (
          packages: with packages; [
            # tornado
            # pyserial-asyncio
            pillow
            # lmdb
            streaming-form-data
            # distro
            # inotify-simple
            libnacl
            # paho-mqtt
            # pycurl
            # zeroconf
            # preprocess-cancellation
            # jinja2
            # dbus-fast
            # apprise
            # python-periphery
            # ldap3
            # importlib-metadata
          ]
        );
        pythonPkgs = python.pkgs;

        pkg = pythonPkgs.buildPythonPackage {
          pname = "toolz";
          version = "0.10.0";
          format = "pyproject";

          src = ./.;
        };
      in
      {
        devShells.default = pkgs.mkShell {
          venvDir = "./.venv";
          inputsFrom = [
            # pkg
            pkgs.moonraker
          ];
          packages = [
            pkgs.zlib
            python
            pkgs.pdm
            pkgs.pyright
            pythonPkgs.venvShellHook

            pythonPkgs.pillow
            pythonPkgs.streaming-form-data
            pythonPkgs.libnacl
          ];
        };
      }
    );
}
