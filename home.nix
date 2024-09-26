{ lib, pkgs, pkgs-unstable, ... }:
{
  home = {
    packages = with pkgs; [
    	# language
    	gleam
    	go
    	gopls
    	pnpm

    	# apps
	    brave
		jetbrains.rider

		# etc
		wget

		# for micro plugins
		ctags
		fzf
    ];

    username = "naton";
    homeDirectory = "/home/naton";

    stateVersion = "24.05";
  };

  programs.vscode-fhs = {
  	enable = true;
  	package = pkgs-unstable.vscode-fhs;
  };
}

