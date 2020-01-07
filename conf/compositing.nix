{ config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [ compton ];

  services = {
    compton = {
      enable = true;

      backend = "glx";
      vSync = "opengl-swc";
      refreshRate = 0;

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

      # Window type settings
      wintypes = { tooltip = { fade = true; shadow = false; }; };

      settings =
        {
          # Tear-free configuration
          # @see https://github.com/chjj/compton/wiki/perf-guide
          # @see https://github.com/chjj/compton/wiki/vsync-guide
          glx-no-stencil = true;
          glx-copy-from-front = false;
          glx-swap-method = "undefined";
          paint-on-overlay = true;
          dbe = false;

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
