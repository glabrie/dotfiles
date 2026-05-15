{ ... }:
{
  flake.modules.nixos.virtualisation =
  { ... }:
  {
    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;
  };
}
