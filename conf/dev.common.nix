{ config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [

    git
    maven
    openjdk

    # Editor
    sublime3

    # misc
    travis

  ];
}
