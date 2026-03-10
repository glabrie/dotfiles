# Boot config file.
{ ... }:
{
  flake.modules.nixos.boot =
  { config, pkgs, ... }:
  {
    boot = {
      kernelPackages = pkgs.linuxPackages_latest;
      extraModprobeConfig = "options bluetooth disable_ertm=Y\n";
      loader.systemd-boot.enable = true;
      loader.efi.canTouchEfiVariables = true;
    };
  };
}
