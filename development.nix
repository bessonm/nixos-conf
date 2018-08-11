{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [

    git
    maven
    openjdk

    # Editor
    atom
    emacs
    jetbrains.idea-community

  ];
}
