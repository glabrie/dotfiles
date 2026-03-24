# Gaming related config, all conveniently placed in the same spot!
{ ... }:
{
  flake.modules.nixos.gaming =
  { ... }:
  {
    # Steam
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    };
    # Enable xbox controller support
    hardware.xpadneo.enable = true;
    hardware.xone.enable = true;
  };
}
