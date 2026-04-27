{ inputs, ... }:
{
  flake.modules.homeManager.emacs = { pkgs, ... }: {
    imports = [ inputs.nix-doom-emacs-unstraightened.homeModule.default ];

    programs.doom-emacs = {
      enable = true;
      doomDir = ./doom.d;
      emacs = pkgs.emacs-pgtk;
      extraPackages = epkgs: [
        epkgs.vterm
        epkgs.mu4e
      ];
    };

services = {
  emacs.enable = true;
  mbsync.enable = true;
};

home.packages = [
      pkgs.mu
      pkgs.isync
      pkgs.hunspell
      pkgs.hunspellDicts.en_US
      pkgs.hunspellDicts.fr-any
    ];
    systemd.user.services.protonmail-bridge = {
      Unit = {
        Description = "ProtonMail Bridge";
        After = [ "network-online.target" ];
      };
      Service = {
        ExecStart = "${pkgs.protonmail-bridge}/bin/protonmail-bridge --noninteractive";
        Restart = "always";
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
    };
  };
}
