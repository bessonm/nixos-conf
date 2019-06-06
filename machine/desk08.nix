{ config, pkgs, ... }:

let
  username = (import ../variables.nix).username;
in
{

  # Version
  system.stateVersion = "19.03";

  # Imports
  imports = [
    ../conf/de.openbox.nix
    ../conf/dev.common.nix
    ../conf/music.nix
  ];

  # Boot
  boot.loader.grub = {
    enable = true;
    version = 2;
    device = "/dev/sdb";
    useOSProber = true;
  };

  # Host
  networking.hostName = "desk08";

  # Groups
  users.groups = {
    audio.members = [ "${username}" ];
  };

  # File System
 fileSystems."/mnt/windows" = {
    device = "/dev/disk/by-uuid/CABE67A8BE678C2F";
    fsType = "ntfs";
  };

  ## Specific ##

  networking.wireless.enable = false;
  networking.networkmanager.enable = true;

  # Audio
  hardware.pulseaudio.enable = true;

  # Graphics
  hardware.opengl.driSupport32Bit = true;

  services = {
    xserver.videoDrivers = [ "nvidiaLegacy340" ];

    # Compositing
    compton = {
      backend = "glx";
      vSync = "opengl-swc";
      refreshRate = 0;
      extraOptions =
        ''
          # Tear-free configuration
          # @see https://github.com/chjj/compton/wiki/perf-guide
          # @see https://github.com/chjj/compton/wiki/vsync-guide
          glx-no-stencil = true;
          glx-copy-from-front = false;
          glx-swap-method = "undefined";
          paint-on-overlay = true;
          dbe = false;
        '';
    };

    # Screen
    redshift = {
      enable = true;
      latitude = "48.8502";
      longitude = "2.3488";
      brightness.day = "0.9";
      brightness.night = "0.75";
      temperature.day = 5700;
      temperature.night = 4200;
    };

    mpd = {
      enable = true;
      musicDirectory = "/home/${username}/Music";
      group = "users";
      extraConfig =
        ''
        follow_outside_symlinks "yes"
        follow_inside_symlinks  "yes"

          audio_output {
            type       "pulse"
            name       "pulse audio"
            device     "pulse"
            mixer_type "hardware"
          }

          audio_output {
            type   "fifo"
            name   "my_fifo"
            path   "/tmp/mpd.fifo"
            format "44100:16:2"
          }
        '';
    };
  };

  nixpkgs.config.zathura.useMupdf = true;

  # USB mounting support @see https://nixos.wiki/wiki/PCManFM
  environment.variables.GIO_EXTRA_MODULES = [ "${pkgs.gvfs}/lib/gio/modules" ];

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [

    # Media
    beets
    clerk
    mpc_cli
    mpd
    mpv
    mpvc
    ncmpcpp

    # Reader
    calibre
    zathura

    # Torrent
    transmission-gtk

    # Virtualization
    virtualbox
  ];

}
