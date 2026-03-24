# simple touchpad config.
{ ... }:
{
  flake.modules.nixos.touchpad =
  { ... }:
  {
    services.libinput.enable = true;
  };
}
