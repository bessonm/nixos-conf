{ config, pkgs, ... }:
let
  username = (import ../variables.nix).username;
in
{

  users.users.${username}.extraGroups = [ "docker" ];

  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  environment.systemPackages = with pkgs; [

    docker

    git
    gradle
    jdk
    maven

    jetbrains.idea-community
    vscodium

  ];
}
