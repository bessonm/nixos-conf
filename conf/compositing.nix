{ config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [ picom ];

  services = {
    picom = {
      enable = true;

      backend = "glx";
      vSync = true;

      # Shadow
      shadow = true;
      shadowOffsets =  [ (-6) (-6) ];
      shadowOpacity = 0.3;

      # Fading
      fade = true;
      fadeDelta = 4;
      fadeSteps = [ 0.09 0.09 ];

      # Window type settings
      wintypes = { tooltip = { fade = true; shadow = false; }; };

      settings =
        {
          unredir-if-possible = false;

          # Shadow Misc
          no-dnd-shadow = true;
          no-dock-shadow = true;
          clear-shadow = true;
          shadow-radius = 7;
          shadow-ignore-shaped = false;

          detect-client-opacity = true;
        };
    };
  };

}
