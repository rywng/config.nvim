let
  pkgs = import <nixpkgs> {};
in
  pkgs.mkShellNoCC {
    packages = with pkgs; [
      alejandra
      lua-language-server
      selene
    ];
  }
