{ config, pkgs, ... }:

let
  unstableTarball = fetchTarball https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz;
in
{

  nixpkgs.config.allowUnfree = true;

  nixpkgs.config.packageOverrides = pkgs: {
    unstable = import unstableTarball { config = config.nixpkgs.config; };
  };

  time.timeZone = "Europe/Paris";

  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "fr";
    defaultLocale = "fr_FR.UTF-8";
  };

  fonts.enableDefaultFonts = true;

  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [

    direnv   
    mkpasswd
    neofetch
    tmux
    unar
    unzip
    vim
    wget
    zip
    zsh

    unstable.antibody

  ];

  services.openssh.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
  };

  users.defaultUserShell = pkgs.zsh;

  users.extraUsers.bessonm = {
     isNormalUser = true;
     uid = 4280;
     initialPassword = "changeme";
     createHome = true;
     home = "/home/bessonm";
     extraGroups = [ "bessonm" "wheel" "networkmanager" ];
  };

}
