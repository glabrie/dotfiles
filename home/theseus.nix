# core home manager config for theseus
{ config, pkgs, inputs, ... }:
{

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
    kitty
    ncspot
    obsidian
    ranger
    slack
    tana
    telegram-desktop
    waybar
  ];

  programs.home-manager.enable = true;

  programs.neovim.extraLuaPackages = true;

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
