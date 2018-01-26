# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only

  # VirtualBox
  boot.initrd.checkJournalingFS = false;
  virtualisation.virtualbox.guest.enable = true;
  fileSystems."/virtualboxshare" = {
    fsType = "vboxsf";
    device = "sources";
    options = [ "rw" ];
  };

  networking.hostName = "nixos-vm"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "fr";
    defaultLocale = "fr_FR.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  services.xserver.displayManager = {
    slim = {
      enable = true;
      defaultUser = "bessonm";
      autoLogin = false;
      theme = /home/bessonm/.config/slim/themes/slim-hud;
    };
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [

    mkpasswd
    vim
    wget
    zip unzip

    git

    # X desktop configuration

    ## Internet
    firefox

    ## Media
    vlc
    clementine

    ## WindowManager
    openbox obconf

    ## Panel
    tint2

    ## App launcher
    albert
    # synapse
    # zazu, kupfer, ulauncher, alawalk

    ## System monitor
    conky

    ## Composing manager
    compton

    ## wallpaper
    feh
    nitrogen

    ## file explorer
    pcmanfm

    ## editor
    emacs
    atom

    ## terminal emulator
    rxvt_unicode
    # hyper
    # pantheon.pantheon-terminal
    # alacritty

    # terminal shell
    zsh

    ## terminal multiplexer
    tmux
  ];

  # Some programs need SUID wrappers, can be
  # configured further or are
  # started in user sessions.
  # programs.bash.enableCompletion = true;
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
  };
  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "fr";
  services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support.
  services.xserver.libinput.enable = true;
  services.xserver.synaptics.twoFingerScroll = true;

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.windowManager.openbox.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.bessonm = {
     isNormalUser = true;
     uid = 1000;
     initialPassword = "changeme";
     home = "/home/bessonm";
     extraGroups = [ "media" "wheel" "networkmanager" "vboxsf" ];
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "17.09"; # Did you read the comment?

}
