# Slowly switching to Nu because it is BEAUTIFUL
{ ... }:
{
  flake.modules.homeManager.nushell =
  { lib, pkgs, ... }:
  {
    programs.nushell = {
      enable = true;
      # configFile.source = ./config.nu;
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
        boot-garbage = "sudo /run/current-system/bin/switch-to-configuration boot";
        collect-garbage = "sudo nix-collect-garbage -d";
        dots ="cd ~/.dotfiles/";
        flup = "nix flake update";
        v = "emacsclient -t";
      };

    };
      
    programs = {

      carapace.enable = true;
      carapace.enableNushellIntegration = true;

    };
  };
}

