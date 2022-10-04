{ config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [

    git
    maven
    jdk
    vscode

    # Editor
    sublime4
    jetbrains.idea-ultimate

  ];
}
