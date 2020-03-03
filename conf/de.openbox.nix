{ config, pkgs, ... }:

let
  unstableTarball = fetchTarball https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz;
  username = (import ../variables.nix).username;
in
{

  imports = [
    ./x.nix
    ./compositing.nix
  ];

  nixpkgs.config.packageOverrides = pkgs: {
    unstable = import unstableTarball { config = config.nixpkgs.config; };
  };

  services.xserver.displayManager.slim = {
    enable = true;
    defaultUser = "${username}";
    autoLogin = false;
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
    klavaro
    peek

    # Chat
    unstable.zulip

  ];
}
