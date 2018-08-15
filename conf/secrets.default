# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  networking.proxy = {
    default = "http://domain:port/";
    noProxy = "localhost, 127.0.0.*, 192.168.*";
  };
}
