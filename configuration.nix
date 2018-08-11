# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./secrets.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";

  # VirtualBox
  boot.initrd.checkJournalingFS = false;
  virtualisation.virtualbox.guest.enable = true;
  fileSystems."/virtualboxshare" = {
    fsType = "vboxsf";
    device = "source";
    options = [ "rw" ];
  };

  # Fix issue with RNG Daemon
  # security.rngd = {
  #  config = {
  #    systemd.services.rngd.serviceConfig.ExecStart = "${pkgs.rng_tools}/sbin/rngd -f -v -r /dev/urandom" + (if config.services.tcsd.enable then "--no-tpm=1" else "");
  #  };
  #};
  security.rngd.enable = false;

  networking.hostName = "nixos-vm";
  # change me in secrets.nix
  networking.proxy = {
    # default = "http://proxy.domain:port/";
    # noProxy = "domain";
  };

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
    };
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [

    mkpasswd
    vim
    wget
    unar zip unzip

    git

    # X desktop configuration

    ## Internet
    firefox

    ## WindowManager
    openbox obconf

    ## Panel
    tint2

    ## App launcher
    albert

    ## System monitor
    conky

    ## Composing manager
    compton

    ## wallpaper
    feh
    nitrogen

    ## file explorer
    pcmanfm lxmenu-data gvfs

    ## editor
    atom

    ## terminal emulator
    termite

    # terminal shell
    oh-my-zsh
    powerline-fonts
    python36Packages.powerline
    zsh

    ## terminal multiplexer
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
     extraGroups = [ "bessonm" "media" "wheel" "networkmanager" "vboxsf" ];
     shell = pkgs.zsh;
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.03"; # Did you read the comment?

}
