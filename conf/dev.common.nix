{ config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [

    git
    maven
    jdk11

    # Editor
    sublime3
    unstable.jetbrains.idea-ultimate

    # misc
    travis

  ];
}
