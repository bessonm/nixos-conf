{ config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [ compton ];

  services = {
    compton = {
      enable = true;

      # Shadow
      shadow = true;
      shadowOffsets =  [ (-6) (-6) ];
      shadowOpacity = "0.3";
      shadowExclude = [
        "! name~=''"
        "n:w:*Firefox*"
        "class_g = 'albert'"
      ];

      # Fading
      fade = true;
      fadeDelta = 4;
      fadeSteps = [ "0.09" "0.09" ];
      fadeExclude = [
        "class_g = 'albert'"
      ];

      extraOptions =
        ''
          # Shadow Misc
          no-dnd-shadow = true;
          no-dock-shadow = true;
          clear-shadow = true;
          shadow-radius = 7;
          shadow-ignore-shaped = false;

          detect-client-opacity = true;

          # Window type settings
          wintypes:
          {
            tooltip = { fade = true; shadow = false; };
          };
        '';
    };
  };

}
