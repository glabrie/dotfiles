# Networking config. Will be expanded later.
{ inputs, ... }:
{
  flake.modules.nixos.networking =
  { pkgs, config, ... }:
  {
    networking.networkmanager.enable = true;
    systemd.services.tailscale-resume = {
      description = "Restart tailscaled after resume from suspend";
      wantedBy = [ "suspend.target" "hibernate.target" "hybrid-sleep.target" ];
      after = [ "suspend.target" "hibernate.target" "hybrid-sleep.target" ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.systemd}/bin/systemctl restart tailscaled.service";
      };
    };
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
