# core home manager config for theseus
{ config, pkgs, inputs, ... }:

# Imports - Use this to modularize!

{
  imports = [
    ./kitty.nix
    ./noctalia.nix
    ./services.nix
    ./packages.nix
    ./zsh.nix
  ];

  # Settings
  home.username = "ghil";
  home.homeDirectory = "/home/ghil";
  home.stateVersion = "25.11";
  fonts.fontconfig.enable = true;
  home.sessionVariables = {
    EDITOR = "nvim";
  };
  # Home Manager
  programs.home-manager.enable = true;

  # Neovim
  programs.neovim.extraLuaPackages = true;

  # Noctalia Shell, the shell of the gods
  programs.noctalia-shell.systemd.enable = true;

  # Iamb, a TUI matrix client. I prefer it to Element
  programs.iamb = {
    enable = true;
    settings = {
       profiles.user = {
        user_id = "@ghil_:matrix.org";
        };
    };
  };
    
  # Starship, my prompt of choice.
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
    };
  };

}
