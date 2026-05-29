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
      loader.systemd-boot.extraEntries = {
        "guix.conf" = ''
          title Guix
          efi /EFI/Guix/grubx64.efi
        '';
      };
      loader.efi.canTouchEfiVariables = true;
    };
  };
}
