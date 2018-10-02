{ config, pkgs, ... }:

{

  imports = [
    ../conf/x.nix
  ];

  services.xserver.displayManager.slim = {
      enable = true;
      defaultUser = "bessonm";
      autoLogin = false;
      theme = /home/bessonm/.config/slim/themes/slim-hud;
  };

  services.xserver.windowManager.awesome.enable = true;

  environment.systemPackages = with pkgs; [

    # Compositing
    compton

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

    # Browser
    firefox

    # Panel
    polybar
    tint2

    # App launcher
    albert

    # System information
    conky

    # Wallpaper
    nitrogen

    # File explorer
    pcmanfm lxmenu-data gvfs

    # Terminal emulator
    termite

    # Shell
    powerline-fonts
    python36Packages.powerline

    calibre

  ];
}
