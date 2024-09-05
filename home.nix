{ lib, pkgs, pkgs-unstable, ... }:
{
  home = {
    packages = with pkgs; [
    	gleam
    	go
    	luarocks
    	fd
    	ripgrep
    	lazygit
    	gcc
	    tree-sitter
	    fzf
	    brave
		jetbrains.rider
    ];

    username = "naton";
    homeDirectory = "/home/naton";

    stateVersion = "24.05";
  };

  programs.vscode = {
  	enable = true;
  	package = pkgs-unstable.vscode;
  };
}

