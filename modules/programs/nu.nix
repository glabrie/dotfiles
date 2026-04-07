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
          # Common ls aliases and sort them by type and then name
        # Inspired by https://github.com/nushell/nushell/issues/7190
        def lla [...args] { ls -la ...(if $args == [] {["."]} else {$args}) | sort-by type name -i }
        def la  [...args] { ls -a  ...(if $args == [] {["."]} else {$args}) | sort-by type name -i }
        def ll  [...args] { ls -l  ...(if $args == [] {["."]} else {$args}) | sort-by type name -i }
        def l   [...args] { ls     ...(if $args == [] {["."]} else {$args}) | sort-by type name -i }

        # Completions
        # mainly pieced together from https://www.nushell.sh/cookbook/external_completers.html

        # carapace completions https://www.nushell.sh/cookbook/external_completers.html#carapace-completer
        # + fix https://www.nushell.sh/cookbook/external_completers.html#err-unknown-shorthand-flag-using-carapace
        # enable the package and integration bellow
        let carapace_completer = {|spans: list&lt;string&gt;|
          carapace $spans.0 nushell ...$spans
          | from json
          | if ($in | default [] | where value == $"($spans | last)ERR" | is-empty) { $in } else { null }
        }
        # some completions are only available through a bridge
        # eg. tailscale
        # https://carapace-sh.github.io/carapace-bin/setup.html#nushell
        $env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense'

        # fish completions https://www.nushell.sh/cookbook/external_completers.html#fish-completer
        let fish_completer = {|spans|
          ${lib.getExe pkgs.fish} --command $'complete "--do-complete=($spans | str join " ")"'
          | $"value(char tab)description(char newline)" + $in
          | from tsv --flexible --no-infer
        }

        # zoxide completions https://www.nushell.sh/cookbook/external_completers.html#zoxide-completer
        let zoxide_completer = {|spans|
            $spans | skip 1 | zoxide query -l ...$in | lines | where {|x| $x != $env.PWD}
        }

        # multiple completions
        # the default will be carapace, but you can also switch to fish
        # https://www.nushell.sh/cookbook/external_completers.html#alias-completions
        let multiple_completers = {|spans|
          ## alias fixer start https://www.nushell.sh/cookbook/external_completers.html#alias-completions
          let expanded_alias = scope aliases
          | where name == $spans.0
          | get -i 0.expansion

          let spans = if $expanded_alias != null {
            $spans
            | skip 1
            | prepend ($expanded_alias | split row ' ' | take 1)
          } else {
            $spans
          }
          ## alias fixer end

          match $spans.0 {
            __zoxide_z | __zoxide_zi =&gt; $zoxide_completer
            _ =&gt; $carapace_completer
          } | do $in $spans
        }

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

