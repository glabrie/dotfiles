# Niri system config.
{ ... }:
{
  flake.modules.nixos.niri =
  { pkgs, ... }:
  {
    programs.niri.enable = true;

    # NixOS's niri module sets the portal config (niri → gnome;gtk);
    # ensure gtk portal is present.
    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };

    environment.systemPackages = [ pkgs.xwayland-satellite ];

  };
}
