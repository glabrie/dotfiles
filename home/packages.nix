{ config, pkgs, inputs, ... }:
{
 # Packages without options
  home.packages = with pkgs; [
    # Apps
    atuin
    bootdev-cli
    bottom
    cava
    claude-code
    cliphist
    direnv
    discordo
    dunst
    element-desktop
    eza
    firefox
    gh
    ghostty
    grim
    hey-mail
    hypridle
    hyprlock
    hyprpolkitagent
    hyprpaper
    hyprshot
    nchat
    ncspot
    obsidian
    ranger
    rofi-wayland
    satty
    slack
    slurp
    tana
    telegram-desktop
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
