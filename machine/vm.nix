{ config, pkgs, ... }:

let
  username = (import ../variables.nix).username;
in
{

  # Version
  system.stateVersion = "18.03";

  # Imports
  imports = [
    ../conf/secrets.nix
    ../conf/de.openbox.nix
    ../conf/dev.common.nix
  ];

  # Boot
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";
  boot.initrd.checkJournalingFS = false;

  # Host
  networking.hostName = "nixos-vm";

  # Groups
  users.groups = {
    vboxsf.members = [ "${username}" ];
  };

  # File System
  fileSystems."/home/${username}/shared" = {
    fsType = "vboxsf";
    device = "vbox_shared";
    mountPoint = "/home/${username}/shared";
    noCheck = true;
    options = [ "defaults" ];
  };

  ## Specific ##

  # Fix issue with RNG Daemon
  security.rngd.enable = false;

  # Dual Screen
  services.xserver.xrandrHeads = [ "VGA-2" "VGA-1"];

  environment.systemPackages = with pkgs; [

  ];

}
