# Niri feature
{ ... }:
{
  flake.modules.nixos.niri =
  { pkgs, ... }:
  {
    programs.niri.enable = true;

    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };

    environment.systemPackages = [ pkgs.xwayland-satellite ];

  };
}
