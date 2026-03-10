# Networking config. Will be expanded later.
{ ... }:
{
  flake.modules.nixos.networking =
    { ... }:
    {
      networking.networkmanager.enable = true;
    };
}
