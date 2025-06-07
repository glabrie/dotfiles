# core home manager config for theseus
{ config, pkgs, inputs, ... }:
{
  imports = [
    ./kitty.nix
  ];
  # Settings
  home.username = "ghil";
  home.homeDirectory = "/home/ghil";
  home.stateVersion = "25.05";
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Package management
  home.packages = with pkgs; [
    # Apps
    atuin
    bottom
    brave
    cava
    cliphist
    discord
    dunst
    element-desktop
    gh
    ghostty
    hyprpaper
    ncspot
    obsidian
    ranger
    slack
    tana
    telegram-desktop
    waybar
    wofi
  ];

  programs.home-manager.enable = true;

  programs.neovim.extraLuaPackages = true;

 # nh, because I like my fingies
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/ghil/.dotfiles";
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
      ll = "ls -l";
      v = "nvim";
      update = "sudo nixos-rebuild switch --flake /home/ghil/.dotfiles";
    };
  };
}
