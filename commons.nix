{ config, pkgs, ... }:

let
  username = (import ./variables.nix).username;
in
{

  nixpkgs.config.allowUnfree = true;
  system.autoUpgrade.enable = true;

  time.timeZone = "Europe/Paris";
  location.latitude = 48.8502;
  location.longitude = 2.3488;

  i18n = {
    defaultLocale = "fr_FR.UTF-8";
    consoleUseXkbConfig = true;
  };

  fonts = {
    enableDefaultFonts = true;
    enableFontDir = true;
    fonts = with pkgs; [
      dina-font
      emojione
      fira-code
      fira-code-symbols
      font-awesome-ttf
      font-awesome_5
      hasklig
      proggyfonts
    ];
  };

  services = {
    # Screen color temperature
    redshift = {
      enable = true;
      brightness.day = "0.9";
      brightness.night = "0.7";
      temperature.day = 4700;
      temperature.night = 3500;
    };
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [

    alsaUtils
    direnv
    mkpasswd
    ntfs3g
    neofetch
    p7zip
    pciutils
    powertop
    redshift
    tmux
    unar
    unzip
    usbutils
    vim
    wget
    zip
    zsh antibody

  ];

  services.openssh.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
  };

  users.defaultUserShell = pkgs.zsh;

  users.extraUsers.${username} = {
     isNormalUser = true;
     uid = 4280;
     initialPassword = "changeme";
     createHome = true;
     home = "/home/${username}";
     extraGroups = [ "${username}" "wheel" "networkmanager" "video" "input" ];
  };

}
