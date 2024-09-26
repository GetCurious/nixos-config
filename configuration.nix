# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      # modules
      ./modules/sh.nix

      # Include the results of the hardware scan.
      ./hardware-configuration.nix

	  # vscode-server
      # (fetchTarball "https://github.com/nix-community/nixos-vscode-server/tarball/master")
    ];

  # vscode-server
  # services.vscode-server.enable = true;

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/nvme0n1";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  
  # Allow to install unfree vscode package in nixos.
  nixpkgs.config.allowUnfree = true;
    
  # Set your time zone.
  time.timeZone = "Asia/Kuala_Lumpur";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ms_MY.UTF-8";
    LC_IDENTIFICATION = "ms_MY.UTF-8";
    LC_MEASUREMENT = "ms_MY.UTF-8";
    LC_MONETARY = "ms_MY.UTF-8";
    LC_NAME = "ms_MY.UTF-8";
    LC_NUMERIC = "ms_MY.UTF-8";
    LC_PAPER = "ms_MY.UTF-8";
    LC_TELEPHONE = "ms_MY.UTF-8";
    LC_TIME = "ms_MY.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # remove preinstall or  unused package in gnome
  services.xserver.excludePackages = with pkgs; [xterm];
      
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.naton = {
    isNormalUser = true;
    description = "Naton";
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDJosNrAuFWyYoL4vbALkG8ig6cLb6rXubyvU+RAubQYi9MWNL0eOHAnfudsmQSIElREhKiKde5MCxOKdVfyXb66IK0MA05GtPkiMWFK7sL4zo8khnCgJ18t2sX8MUR5GevwAWjObeRopDet2n72Up7MtjlKopjed0mBDHq+4fto1rE3J+v74Ufu4gQNOfKNYK2wHUR15ppC5aT91kCj6nBLG5lc5ZK/lvae52zN7lV/IlupigFCSRRjpe7KaFBWtqQPmbM8bVdC5eiZrPCtfUT0wz85E1fT27SyWKEoM1LOQeuX+dF/kkCT9AhR8WMMdjHghCHv/+pv0nEdsefgXinzBGXSMuKyNn2Av/urEf7PrMywjJa5MfqOily2Jv2niNrOUQ5chzc7TPqK+WAj5SI7lNaqSPA8TBC1cCpQL5JYatIoizR8oL9006EPf0QdGhLGrdlwx+IYHxe2KJemb4uyq46Dpi2LC8ZKI5PyaGEsSTZa4H1EM2/OuEzisX5BqDRE6iFnrK0isrlm8vWN7K23bTNyMfXlgzde6PiScd82s0HDveZtD+GClcv5JxXnB+3ZTrEkuOY/NKDSdwrlwC4pt4srRYC90e1Wl7XZF4csrFle/BwxK3aA+J0AeNtrfwet+iIQzgXyx2Ahc2DxG6jOZczVYcuib4zCqPF5eGGzQ== naton@home-pc"
    ];
    extraGroups = [ "networkmanager" "wheel" "docker"];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Enable automatic login for the user.
  # services.displayManager.autoLogin.enable = true;
  # services.displayManager.autoLogin.user = "naton";

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # Install docker.
  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    bat
    eza
    git
    home-manager
    micro
    tmux
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      X11Forwarding = true;
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [
    80
    443
  ];
  networking.firewall.allowedUDPPorts = [
  	10000
  ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # nginx
  services.nginx = {
  	enable = true;
    virtualHosts = {
      "192.168.0.195" = {
        listen = [ { addr = "0.0.0.0"; port = 80; } ];
        locations."/" = {
          proxyPass = "http://localhost:8080/";
          extraConfig = ''
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection "upgrade";
          '';
        };
      };
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

  # Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # tmux
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    baseIndex = 1;
    newSession = true;
    terminal = "screen-256color";
    escapeTime = 0;
  };

  # env variables
  environment.variables = {
  	EDITOR = "micro";
  };

  # git
  programs.git = {
  	enable = true;
  	config = {
  		user.name = "Naton";
  		user.email = "N_t_N@live.com";
  		init.defaultBranch = "main";
  		safe.directory = "/etc/nixos";
  	};
  };
}
