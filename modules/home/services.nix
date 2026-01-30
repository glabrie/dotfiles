{ config, pkgs, inputs, ... }:
{
  # Services, access to applets
  services.network-manager-applet.enable = true;
  services.blueman-applet.enable = true;
}
