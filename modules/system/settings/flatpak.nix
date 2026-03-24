# Simple aspect for supporting flatpaks.
{ ... }:
{
  flake.modules.nixos.flatpak =
  { ... }:
  {
    services.flatpak.enable = true;
  };
}
