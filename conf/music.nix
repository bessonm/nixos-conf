{ config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    unstable.musescore
  ];
}
