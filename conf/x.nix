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

  hardware.brightnessctl.enable = true;

  environment.systemPackages = with pkgs; [

    acpilight
    glxinfo
    xfontsel
    xorg.xdpyinfo
    xorg.xev
    xorg.xrandr

  ];

}
