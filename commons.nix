{ config, pkgs, ... }:

let
  unstableTarball = fetchTarball https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz;
  username = (import ./variables.nix).username;
in
{

  nixpkgs.config.allowUnfree = true;
  system.autoUpgrade.enable = true;

  nixpkgs.config.packageOverrides = pkgs: {
    unstable = import unstableTarball { config = config.nixpkgs.config; };
  };

  time.timeZone = "Europe/Paris";

  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "fr";
    defaultLocale = "fr_FR.UTF-8";
  };

  fonts = {
    enableDefaultFonts = true;
    enableFontDir = true;
    fonts = with pkgs; [
      dina-font
      emojione
      fira-code
      fira-code-symbols
      font-awesome-ttf
      font-awesome_5
      hasklig
      proggyfonts
    ];
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [

    direnv
    mkpasswd
    neofetch
    powertop
    tmux
    unar
    unzip
    vim
    wget
    zip
    zsh

    unstable.antibody

  ];

  boot.plymouth.enable = true;
  services.openssh.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
  };

  users.defaultUserShell = pkgs.zsh;

  users.extraUsers.${username} = {
     isNormalUser = true;
     uid = 4280;
     initialPassword = "changeme";
     createHome = true;
     home = "/home/${username}";
     extraGroups = [ "${username}" "wheel" "networkmanager" ];
  };

}
