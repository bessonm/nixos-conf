{ config, pkgs, ... }:

let
  username = (import ../variables.nix).username;
in
{

  imports = [
    ./x.nix
    ./compositing.nix
  ];

  services.xserver.displayManager.lightdm = {
    enable = true;
  };

  services.xserver.windowManager.openbox.enable = true;

  environment.systemPackages = with pkgs; [

    # Window Manager
    openbox obconf

    # Theme (GTK+)
    numix-gtk-theme

    # Icons
    numix-icon-theme-circle

    # Cursors
    numix-cursor-theme
    xbanish

    # Notification
    dunst

    # Panel
    polybar

    # Colors
    pywal

    # System information
    conky

    # Wallpaper
    feh

    ## Applications

    # App launcher
    albert

    # Browser
    firefox

    # File explorer
    pcmanfm lxmenu-data gvfs

    # Terminal emulator
    termite

    # Misc
    peek

  ];
}
