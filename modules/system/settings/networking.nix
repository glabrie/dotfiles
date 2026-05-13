# Networking config. Will be expanded later.
{ inputs, ... }:
{
  flake.modules.nixos.networking =
  { pkgs, config, ... }:
  {
    networking.networkmanager.enable = true;
    services.tailscale.enable = true;
    networking.firewall = {
      enable = true;
      trustedInterfaces = [ "tailscale0" ];
      allowedUDPPorts = [ config.services.tailscale.port ];
    };
  };

  flake.modules.homeManager.networking =
  { ... }:
  {
    services.network-manager-applet.enable = true;
  };
}
