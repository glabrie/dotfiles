{ ... }:
{
  flake.modules.homeManager.nushell-book =
  { pkgs, ... }:
  {
    home.packages = [ pkgs.miniserve ];
    systemd.user.services.nushell-book = {
      Unit.Description = "Nushell Book offline server";
      Service = {
        ExecStart = "${pkgs.miniserve}/bin/miniserve --port 8585 %h/documents/nushell-book/.vuepress/dist";
        Restart = "on-failure";
      };
      Install.WantedBy = [ "default.target" ];
    };
  };
}
