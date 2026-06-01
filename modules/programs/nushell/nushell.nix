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

        def nix-gen-diff [] {
            let gens = (ls /nix/var/nix/profiles/
                | where name =~ 'system-\d+-link'
                | insert n { |r| $r.name | path basename | parse "system-{n}-link" | get n.0 | into int }
                | sort-by n
                | last 2)

            let prev = ($gens | first | get name)
            let curr = ($gens | last | get name)
            let prev_n = ($gens | first | get n)
            let curr_n = ($gens | last | get n)
            let ts = ($gens | last | get modified | format date "%Y-%m-%d %H:%M")

            print $"gen ($prev_n) -> ($curr_n)  \(($ts)\)"
            print ""
            nix store diff-closures $prev $curr
        }

        source ~/.dotfiles/rebuild.nu
      '';

      shellAliases = {
        dots = "cd ~/.dotfiles/";
        flup = "nix flake update";
        jjs = "jj status";
        v = "emacsclient -t";
        vpn-on = "sudo systemctl start wg-quick-protonvpn";
        vpn-off = "sudo systemctl stop wg-quick-protonvpn";
        deploy-hilbert = "nixos-rebuild switch --flake path:/home/ghil/.dotfiles#hilbert --target-host ghil@178.156.220.220 --use-remote-sudo";
      };

    };

    programs = {

      carapace.enable = true;
      carapace.enableNushellIntegration = true;

      direnv = {
        enable = true;
        nix-direnv.enable = true;
      };

      zoxide = {
        enable = true;
        enableNushellIntegration = true;
      };

    };
  };
}
