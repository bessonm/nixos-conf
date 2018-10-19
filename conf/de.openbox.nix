{ config, pkgs, ... }:

{

  imports = [
    ../conf/x.nix
  ];

#  services.xserver.displayManager.job.environment = {
#    SLIM_CFGFILE = "/home/bessonm/.config/slim/slim.conf";
#    SLIM_THEMESDIR = "/home/bessonm/.config/slim/themes/";
#  };

  services.xserver.displayManager.slim = {
      enable = true;
      defaultUser = "bessonm";
      autoLogin = false;
      theme = /home/bessonm/.config/slim/themes/slim-hud;
  };

  services.xserver.windowManager.openbox.enable = true;

  environment.systemPackages = with pkgs; [

    # Appearance

    # Window Manager
    openbox obconf

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

    # Notification
    dunst

    # Panel
    ( polybar.override {
        pulseSupport = true;
        mpdSupport = true;
      }
    )
    tint2

    # Colors
    pywal

    # Lock
    i3lock-color
 
    # System information
    conky

    # Wallpaper
    feh
    nitrogen

    # Applications

    # App launcher
    albert
    rofi

    # Browser
    firefox

    # File explorer
    pcmanfm lxmenu-data gvfs

    # Screen capture
    maim

    # Terminal emulator
    termite

  ];
}
