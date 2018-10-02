{ config, pkgs, ... }:

{

  imports = [

  ];

  environment.systemPackages = with pkgs; [

    # Email
    mutt
    alpine

    # todo list
    devtodo

    # Browser
    elinks
    links2

    # Panel

    # App launcher

    # System information
    htop

    # File explorer
    vifm

    # Terminal emulator

    # text editor
    vim

    # wiki and diary
    vimwiki

    # music player
    cmus

    # irc client
    irssi

    # terminal/screen manager
    dvtm -
    tmux

    # video
    mplayer

    # torrent
    rtorrent

    # weather
    weather

    # spreadsheet
    sc

    # Shell
    powerline-fonts
    python36Packages.powerline

  ];
}
