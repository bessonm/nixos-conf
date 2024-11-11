{ config, pkgs, ... }:

let
  username = (import ./variables.nix).username;
in
{

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true;

  time.timeZone = "Europe/Paris";
  location.latitude = 48.8502;
  location.longitude = 2.3488;

  i18n.defaultLocale = "fr_FR.UTF-8";

  console.useXkbConfig = true;

  fonts = {
    enableDefaultPackages = true;
    fontDir.enable = true;
    packages = with pkgs; [
      dina-font
      emojione
      fira-code
      fira-code-symbols
      font-awesome
      font-awesome_5
      hasklig
      proggyfonts
    ];
  };

  services = {
    openssh.enable = true;
    udisks2.enable = true;
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [

    acpi
    alsaUtils
    brightnessctl
    direnv
    dnsutils
    efibootmgr
    gnupg
    lm_sensors
    lsof
    mkpasswd
    ntfs3g
    neofetch
    p7zip
    pciutils
    powertop
    sct
    tmux
    udisks
    unar
    unzip
    usbutils
    vim
    wget
    zip
    zsh antibody

  ];

  programs = {
    gnupg.agent.enable = true;

    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
    };
  };

  users = {

    defaultUserShell = pkgs.zsh;

    extraUsers.${username} = {
      isNormalUser = true;
      uid = 4280;
      initialPassword = "changeme";
      createHome = true;
      home = "/home/${username}";
      extraGroups = [ "${username}" "wheel" "networkmanager" "video" "input" ];
   };

  };

}
