{ config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [

    git
    maven
    openjdk

    # Editor
    atom
    jetbrains.idea-community
    sublime3
    vscode

  ];
}
