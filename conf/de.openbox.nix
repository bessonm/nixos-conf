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

    xdotool wmctrl

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
    ( polybar.override {
        pulseSupport = true;
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

    # Sound
    pavucontrol

    # Camera
    guvcview

    # Launcher
    albert

    # Browser
    firefox

    # File explorer
    pcmanfm lxmenu-data gvfs udiskie

    # Terminal emulator
    termite

    # Misc
    keepassxc
    peek
    gnumeric

    # Learn
    klavaro
    anki

  ];
}
