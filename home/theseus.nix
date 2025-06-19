# core home manager config for theseus
# TODO: modularize, refactor and comment
{ config, pkgs, inputs, ... }:
{
  imports = [
    ./kitty.nix
  ];
  # Settings
  home.username = "ghil";
  home.homeDirectory = "/home/ghil";
  home.stateVersion = "25.05";
  fonts.fontconfig.enable = true;
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Package management
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
  
  # Applets for bluetooth and network manager
  services.network-manager-applet.enable = true;

  services.blueman-applet.enable = true;

  # Home Manager
  programs.home-manager.enable = true;

  programs.neovim.extraLuaPackages = true;

  programs.vesktop.enable = true;

  programs.iamb = {
    enable = true;
    settings = {
       profiles.user = {
        user_id = "@ghil_:matrix.org";
        };
    };
  };
    
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
    };
  };


  programs.zsh = {
    enable = true;
    shellAliases = {
      boot-garbage = "sudo /run/current-system/bin/switch-to-configuration boot";
      collect-garbage = "sudo nix-collect-garbage -d";
      dots ="cd ~/.dotfiles/";
      flup = "nix flake update";
      ga = "git add *";
      gc = "git commit --verbose";
      gp = "git push";
      ll = "eza";
      v = "nvim";
      update = "sudo nixos-rebuild switch --flake /home/ghil/.dotfiles";
    };
  };
}
