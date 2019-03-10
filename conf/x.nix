{ config, pkgs, ... }:

{

  services.xserver = {
    enable = true;
    layout = "fr";
    xkbOptions = "eurosign:e";

    libinput.enable = true;
    synaptics.twoFingerScroll = true;

    desktopManager.xterm.enable = false;
  };

  environment.systemPackages = with pkgs; [

    xfontsel
    xorg.xbacklight
    xorg.xev
    xorg.xrandr

  ];

}
