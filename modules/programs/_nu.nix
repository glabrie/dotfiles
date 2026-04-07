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
        $env.config = {
          show_banner: false,
          completions: {
            case_sensitive: false # case-sensitive completions
            quick: true           # set to false to prevent auto-selecting completions
            partial: true         # set to false to prevent partial filling of the prompt
            algorithm: "fuzzy"    # prefix or fuzzy
            external: {
              # set to false to prevent nushell looking into $env.PATH to find more suggestions
              enable: true 
              # set to lower can improve completion performance at the cost of omitting some options
              max_results: 100 
              completer: $multiple_completers
            }
          }
        } 
        $env.PATH = ($env.PATH | 
          split row (char esep) |
          prepend /home/myuser/.apps |
          append /usr/bin/env
        )
      '';
   
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
        update = "$HOME/.dotfiles/rebuild.sh";
      };

    };
      
    programs = {

      carapace.enable = true;
      carapace.enableNushellIntegration = true;

      starship = {
        enable = true;
        settings = {
          add_newline = true;
          character = {
            success_symbol = "[➜](bold green)";
            error_symbol = "[➜](bold red)";
          };
        };
      };
    };
  };
}

