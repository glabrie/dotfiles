# Niri feature
{ ... }:
{
  flake.modules.nixos.niri =
  { pkgs, ... }:
  {
    programs.niri.enable = true;

    xdg.portal = {
      enable = true;
      extraPortals = [ 
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
      ];
      config = {
        common.default = [ "gnome" ];
      };
    };

    environment.systemPackages = [ pkgs.xwayland-satellite ];

  };
}
