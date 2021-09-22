{ config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [

    git
    maven
    jdk11

    # Editor
    sublime3
    downgrade.jetbrains.idea-ultimate

    # misc
    travis

  ];
}
