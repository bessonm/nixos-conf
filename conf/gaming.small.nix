{ config, pkgs, ... }:

{

  services.udev.extraRules = ''
      # retroarch + blissbox 4-play fw.2.230
      SUBSYSTEM=="usb", ATTRS{idVendor}=="16d0", MODE="0666"
  '';

  nixpkgs.config = {
    retroarch = {

      # NES / Famicom
      enableNestopia = true;

      # SNES / SFC
      enableHiganSFC = true;
      enableSnes9xNext = true;
      enableBsnesMercury = true;

      # GB color
      enableGambatte = true;

      # GB Advance
      enableMGBA = true;
      enableVbaNext = true;

      # NDS
      enableDesmume = true;

      # Arcade
      enableMAME = true;

      # MegaDrive/MegaCD/32x
      # PS One
      enableBeetlePSX = true;

      # PSP
      enablePPSSPP = true;

    };

  };

  environment.systemPackages = with pkgs; [
    retroarch
  ];
}
