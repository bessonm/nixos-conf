{ config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [

    git
    maven
    openjdk

    # Editor
    jetbrains.idea-community
    sublime3
    vscode

  ];
}
