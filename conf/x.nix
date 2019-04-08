{ config, pkgs, ... }:

{

  services.xserver = {
    enable = true;
    layout = "fr";
    xkbOptions = "eurosign:e";
    exportConfiguration = true; # usefull for debug

    libinput.enable = true;
    synaptics.twoFingerScroll = true;

    desktopManager.xterm.enable = false;
  };

  environment.systemPackages = with pkgs; [

    xfontsel
    xorg.xbacklight
    xorg.xdpyinfo
    xorg.xev
    xorg.xrandr

  ];

}
