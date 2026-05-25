{ ... }:
{
  flake.modules.homeManager.emacs = { pkgs, ... }: {
    programs.emacs = {
      enable = true;
      package = pkgs.emacs-pgtk.pkgs.withPackages (e: [
        e.ghostel
        e.mu4e
        e.treesit-grammars.with-all-grammars
      ]);
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
      pkgs.graphviz
      pkgs.libertinus
      pkgs.imagemagick
      (pkgs.texlive.combine { inherit (pkgs.texlive) scheme-small dvipng; })
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
