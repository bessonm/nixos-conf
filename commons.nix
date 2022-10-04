{ config, pkgs, ... }:

let
  username = (import ./variables.nix).username;
  unstableTarball = builtins.fetchTarball https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz;
in
{

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true;

  nixpkgs.config.packageOverrides = pkgs: {
    unstable = import unstableTarball { config = config.nixpkgs.config; };
  };

  time.timeZone = "Europe/Paris";
  location.latitude = 48.8502;
  location.longitude = 2.3488;

  i18n.defaultLocale = "fr_FR.UTF-8";

  console.useXkbConfig = true;
  #console.font = "Lat2-Terminus16";

  fonts = {
    enableDefaultFonts = true;
    fontDir.enable = true;
    fonts = with pkgs; [
      dina-font
      emojione
      fira-code
      fira-code-symbols
      font-awesome
      font-awesome_5
      hasklig
      proggyfonts
    ];
  };

  services = {
    openssh.enable = true;
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [

    acpi
    alsaUtils
    brightnessctl
    direnv
    dnsutils
    efibootmgr
    gnupg
    lm_sensors
    lsof
    mkpasswd
    ntfs3g
    neofetch
    p7zip
    pciutils
    powertop
    sct
    tmux
    unar
    unzip
    usbutils
    vim
    wget
    zip
    zsh antibody

  ];

  programs = {
    gnupg.agent.enable = true;

    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
    };
  };

  users = {

    defaultUserShell = pkgs.zsh;

    extraUsers.${username} = {
      isNormalUser = true;
      uid = 4280;
      initialPassword = "changeme";
      createHome = true;
      home = "/home/${username}";
      extraGroups = [ "${username}" "wheel" "networkmanager" "video" "input" ];
   };

  };

}
