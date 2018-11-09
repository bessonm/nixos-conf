{ config, pkgs, ... }:

{

  imports = [
    ./x.nix
    ./compositing.nix
  ];

  services.xserver.displayManager.slim = {
    enable = true;
    defaultUser = "bessonm";
    autoLogin = false;
    theme = /home/bessonm/.config/slim/themes/slim-hud;
  };

  services.xserver.windowManager.openbox.enable = true;

  environment.systemPackages = with pkgs; [

    # Window Manager
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

    # Cursors
    unstable.bibata-cursors
    numix-cursor-theme
    xbanish

    # Notification
    dunst

    # Panel
    ( polybar.override {
        pulseSupport = true;
        mpdSupport = true;
      }
    )

    # Colors
    pywal

    # Lock
    i3lock-color

    # System information
    conky

    # Wallpaper
    feh

    # Applications

    # App launcher
    albert

    # Browser
    firefox

    # File explorer
    pcmanfm lxmenu-data gvfs

    # Terminal emulator
    termite

  ];
}
