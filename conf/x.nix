{ config, pkgs, ... }:

{

  services.xserver.enable = true;
  services.xserver.layout = "fr";
  services.xserver.xkbOptions = "eurosign:e";

  services.xserver.libinput.enable = true;
  services.xserver.synaptics.twoFingerScroll = true;

}
