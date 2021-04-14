{ config, pkgs, ... }:

{

  services.xserver = {
    enable = true;
    layout = "fr";
    xkbOptions = "eurosign:e,ctrl:nocaps";
    exportConfiguration = true; # usefull for debug

    libinput.enable = true;
    synaptics.twoFingerScroll = true;

    # Disable mouse acceleration
    libinput.accelProfile = "flat";
    config = ''
      Section "InputClass"
        Identifier "mouse accel"
        Driver "libinput"
        MatchIsPointer "on"
        Option "AccelProfile" "flat"
        Option "AccelSpeed" "0"
      EndSection
    '';

    desktopManager.xterm.enable = false;
  };

  environment.systemPackages = with pkgs; [

    acpilight
    glxinfo
    libnotify
    xfontsel
    xorg.xdpyinfo
    xorg.xev
    xorg.xrandr

  ];

}
