{ config, pkgs, ... }:

{

  fonts.fonts = with pkgs; [
    fira-code
    fira-code-symbols
    dina-font
    proggyfonts
    hasklig
  ];

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
