{ config, pkgs, inputs, ... }:
{
  # Zsh, my shell of choice, with aliases because I care about my fingies
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
      update = "~/.dotfiles/rebuild.sh";
    };
  };
}
