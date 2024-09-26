{ pkgs, ... }:
let
  myAliases = {
    sudo = "sudo ";
    cat = "bat";
    ls = "eza";
    ll = "eza -l";
    tree = "eza --tree";
    micro = "TERM=xterm-256color micro"; # fix alt+arrow in tmux
    nix-config = "sudo micro /etc/nixos/configuration.nix";
    nix-home = "sudo micro /etc/nixos/home.nix";
    nix-update = "sudo nixos-rebuild switch --flake /etc/nixos#nixos";
    nix-update-home = "home-manager switch --flake '/etc/nixos#naton@nixos'";
  };
in
{
  # bash
  programs.bash.shellAliases = myAliases;

  # zsh
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = myAliases;
    ohMyZsh = {
  	  enable = true;
  	  theme = "robbyrussell";
  	  plugins = [
        "git"
        "history"
  	  ];
  	};
  };

  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [zsh];
}
