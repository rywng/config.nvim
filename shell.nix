let
  pkgs = import <nixpkgs> {};
in 
pkgs.mkShellNoCC {
	packages = with pkgs; [
	lua-language-server
	];
}
