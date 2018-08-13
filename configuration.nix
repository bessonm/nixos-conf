# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./secrets.nix
      ./development.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";

  # VirtualBox
  boot.initrd.checkJournalingFS = false;
  virtualisation.virtualbox.guest.enable = true;
  fileSystems."/home/bessonm/shared" = {
    fsType = "vboxsf";
    device = "vbox_shared";
    mountPoint = "/home/bessonm/shared";
    noCheck = true;
    options = [ "defaults" ];
  };

  # Fix issue with RNG Daemon
  security.rngd.enable = false;

  networking.hostName = "nixos-vm";

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "fr";
    defaultLocale = "fr_FR.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  fonts = {
    enableDefaultFonts = true;
    fonts = with pkgs; [
      fira-code
      fira-code-symbols
      dina-font
      proggyfonts
      hasklig
    ];
  };

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
    unar
    vim
    unzip
    wget
    zip

    # Compositing
    compton

    # Browser
    firefox

    # WindowManager
    openbox obconf

    # Theme (GTK+)
    adapta-gtk-theme
    arc-theme
    materia-theme
    numix-gtk-theme
    numix-sx-gtk-theme
    paper-gtk-theme

    # Icons
    arc-icon-theme
    numix-icon-theme
    numix-icon-theme-circle
    numix-icon-theme-square
    paper-icon-theme
    papirus-icon-theme

    # Panel
    polybar
    tint2

    # App launcher
    albert

    # System information
    conky
    neofetch

    # Wallpaper
    nitrogen

    ## file explorer
    pcmanfm lxmenu-data gvfs

    # Terminal emulator
    termite

    # Terminal shell
    oh-my-zsh
    powerline-fonts
    python36Packages.powerline
    zsh

    # Terminal multiplexer
    tmux
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "fr";
  services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support.
  services.xserver.libinput.enable = true;
  services.xserver.synaptics.twoFingerScroll = true;

  # Enable Desktop Environment.
  services.xserver.windowManager.openbox.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.bessonm = {
     isNormalUser = true;
     uid = 4280;
     initialPassword = "changeme";
     createHome = true;
     home = "/home/bessonm";
     extraGroups = [ "bessonm" "wheel" "networkmanager" "vboxsf" ];
     shell = pkgs.zsh;
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.03"; # Did you read the comment?

}
