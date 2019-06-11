{ config, pkgs, ... }:

{

  imports = [
    ./gaming.small.nix
  ];

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

      # N64
      enableParallelN64 = true;
      enableMupen64Plus = true;

      # Gamecube / Wii
      enableDolphin = true;

      # Saturn
      enableBeetleSaturn = true;

      # Dreamcast
      enableReicast = true;

    };

  };

  environment.systemPackages = with pkgs; [
    pcsx2
  ];
}
