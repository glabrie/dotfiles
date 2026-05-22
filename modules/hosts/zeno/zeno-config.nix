{ inputs, ... }:
{
  systems = [ "x86_64-linux" ];

  flake.nixosConfigurations.zeno =
    inputs.nixpkgs.lib.nixosSystem {
      modules = [
        inputs.self.modules.nixos.zeno
        inputs.disko.nixosModules.disko
      ];
    };

flake.modules.nixos.zeno =
{
  networking.hostName = "zeno";
  nixpkgs.hostPlatform = "x86_64-linux";

  imports = with inputs.self.modules.nixos;
  [
    system-server
    ghil
    ghil-keys
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  security.sudo.wheelNeedsPassword = false;

disko.devices.disk.main = {
      device = "/dev/sda";
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          ESP = {
            size = "512M";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
            };
          };
          root = {
            size = "100%";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/";
            };
          };
        };
      };
    };
  };
}
