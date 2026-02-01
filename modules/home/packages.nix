{ config, pkgs, inputs, ... }:
{
 # Packages without options
  home.packages = with pkgs; [
    # Apps
    p7zip
    appimage-run
    atuin
    bootdev-cli
    bottom
    cava
    claude-code
    cliphist
    direnv
    discord
    discordo
    dunst
    element-desktop
    eza
    firefox
    gearlever
    gh
    ghostty
    grim
    hey-mail
    hyprpolkitagent
    hyprshot
    nchat
    ncspot
    obsidian
    ranger
    rofi
    satty
    slack
    slurp
    tana
    telegram-desktop
    thunar
    waybar
    wl-clipboard
    yazi
    zellij

    # Fonts
    jetbrains-mono
    nerd-fonts.jetbrains-mono
    font-awesome
    font-awesome_5
  ];
}
