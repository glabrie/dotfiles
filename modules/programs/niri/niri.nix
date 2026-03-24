# Niri system config.
{ ... }:
{
  flake.modules.nixos.niri =
  { ... }:
  {
    programs.niri.enable = true;
  };
}
