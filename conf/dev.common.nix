{ config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [

    git
    maven
    jdk

    # Editor
    sublime3
    unstable.jetbrains.idea-ultimate

    # misc
    travis

  ];
}
