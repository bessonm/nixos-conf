{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    musescore
  ];
}
