{ ... }:
{
  flake.modules.homeManager.nushell =
  { lib, pkgs, ... }:
  {
    programs.nushell = {
      enable = true;
      extraEnv = ''
        $env.PATH = ($env.PATH | prepend $"($env.HOME)/.config/emacs/bin")
      '';
      extraConfig = ''
        $env.config.show_banner = false
        $env.config.completions.case_sensitive = false
        $env.config.completions.quick = true
        $env.config.completions.partial = true
        $env.config.completions.algorithm = "fuzzy"
        $env.config.completions.external.enable = true
        $env.config.completions.external.max_results = 100

        def ll [path?: string = "."] { ls $path | sort-by type name }
      '';

      shellAliases = {
        dots = "cd ~/.dotfiles/";
        flup = "nix flake update";
        jjs = "jj status";
        update = "nu /home/ghil/.dotfiles/rebuild.nu";
        v = "emacsclient -t";
      };

    };

    programs = {

      carapace.enable = true;
      carapace.enableNushellIntegration = true;

      direnv = {
        enable = true;
        nix-direnv.enable = true;
      };

    };
  };
}
