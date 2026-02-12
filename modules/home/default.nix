# core home manager config for theseus
{ config, pkgs, inputs, ... }:

# Imports - Use this to modularize!

{
  imports = [
    inputs.spicetify-nix.homeManagerModules.spicetify
    ./kitty.nix
    ./hyprland/hyprland.nix
    ./noctalia.nix
    ./packages.nix
    ./services.nix
    ./spotify.nix
    ./zsh.nix
  ];

  # Settings
  home = {
    username = "ghil";
    homeDirectory = "/home/ghil";
    stateVersion = "25.11";
    sessionVariables = {
      EDITOR = "nvim";
      };
    };
  fonts.fontconfig.enable = true;
  
  # Home Manager
  programs.home-manager = {
    enable = true;
  };


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
