{ config, pkgs, ... }:

let
  username = (import ../variables.nix).username;
in
{

  # Version
  system.stateVersion = "19.03";

  # Imports
  imports = [
    ../conf/de.console.nix
    ../conf/de.openbox.nix
    ../conf/dev.common.nix
    ../conf/music.nix
    ../conf/gaming.small.nix
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
    fsType = "ntfs-3g";
  };

  fileSystems."/mnt/games" = {
    device = "/dev/disk/by-uuid/aa74abf5-1221-4801-858b-763dd1ae6c7a";
    fsType = "ext4";
  };

  ## Specific ##

  networking.wireless.enable = false;
  networking.networkmanager.enable = true;
  time.hardwareClockInLocalTime = true;

  hardware = {

    cpu.intel.updateMicrocode = true;

    # Audio
    pulseaudio = {
      enable = true;
      support32Bit = true;
    };

    # Graphics
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };

  };

  services = {
    # Graphics
    xserver.videoDrivers = [ "nvidiaLegacy340" ];

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
    deluge-gtk

    # Virtualization
    virtualbox
  ];

}
