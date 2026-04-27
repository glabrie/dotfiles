{ ... }:
{
  flake.modules.nixos.zsh =
  { ... }:
  {
    programs.zsh.enable = true;
    programs.zsh.enableCompletion = true;
  };

  flake.modules.homeManager.zsh =
  { ... }:
  {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      shellAliases = {
        boot-garbage = "sudo /run/current-system/bin/switch-to-configuration boot";
        collect-garbage = "sudo nix-collect-garbage -d";
        dots ="cd ~/.dotfiles/";
        flup = "nix flake update";
        ga = "git add *";
        gc = "git commit --verbose";
        gp = "git push";
        ll = "eza";
        v = "emacsclient -t";
        update = "$HOME/.dotfiles/rebuild.sh";
      };
    };
  };
}
