# Networking config. Will be expanded later.
{ inputs, ... }:
{
  flake.modules.nixos.networking =
  { ... }:
  {
    networking.networkmanager.enable = true;
    services.tailscale.enable = true;
  };

  flake.modules.homeManager.networking =
  { ... }:
  {
    services.network-manager-applet.enable = true;
  };
}
