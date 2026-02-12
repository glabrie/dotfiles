{ config, pkgs, inputs, ... }:
{
 # Packages without options
  home.packages = with pkgs; [
    # Apps
    p7zip
    atuin
    bootdev-cli
    bottom
    cava
    cider-2
    claude-code
    cliphist
    direnv
    discord
    element-desktop
    eza
    firefox
    gh
    ghostty
    grim
    inputs.oxicord.packages.${pkgs.stdenv.hostPlatform.system}.default
    hey-mail
    hyprpolkitagent
    hyprshot
    obsidian
    ranger
    rofi
    satty
    slurp
    tana
    telegram-desktop
    thunar
    thunar-archive-plugin
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
