# storage config to automount USB drives.
{ ... }:
{
  flake.modules.nixos.storage =
  { ... }:
  {
    services.gvfs.enable = true; 
    services.udisks2.enable = true;
    services.devmon.enable = true;
  };
}
