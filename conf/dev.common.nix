{ config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [

    git
    gradle
    jdk
    maven

    jetbrains.idea-ultimate
    sublime4
    vscode

  ];
}
