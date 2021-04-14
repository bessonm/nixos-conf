{ config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [

    unstable.youtube-dl

  ];
}
