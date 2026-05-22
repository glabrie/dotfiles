# Lean server layer -- no desktop, no HM
{ inputs, ... }:
{
  flake.modules.nixos.system-server =
  {
    imports = with inputs.self.modules.nixos; [ system-base ];
  };
}
