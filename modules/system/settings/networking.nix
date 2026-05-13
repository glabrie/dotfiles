# Networking config. Will be expanded later.
{ inputs, ... }:
{
  flake.modules.nixos.networking =
  { pkgs, ... }:
  {
    networking.networkmanager.enable = true;
    services.tailscale.enable = true;

    systemd.services.tailscale-resume = {
      description = "Restart tailscaled after resume";
      wantedBy = [ "post-resume.target" ];
      after = [ "post-resume.target" ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.systemd}/bin/systemctl restart tailscaled.service";
      };
    };
  };

  flake.modules.homeManager.networking =
  { ... }:
  {
    services.network-manager-applet.enable = true;
  };
}
