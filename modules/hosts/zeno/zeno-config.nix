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
{ modulesPath, ... }:
{
  networking.hostName = "zeno";
  nixpkgs.hostPlatform = "x86_64-linux";

  imports = with inputs.self.modules.nixos;
  [
    system-server
    ghil
    ghil-keys
    "${modulesPath}/profiles/qemu-guest.nix"
  ];

  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  security.sudo.wheelNeedsPassword = false;

  nix.settings.trusted-users = [ "root" "ghil" ];

  services.tailscale.enable = true;
  services.openssh.openFirewall = false;
  networking.firewall.interfaces.tailscale0.allowedTCPPorts = [ 22 ];

disko.devices.disk.main = {
      device = "/dev/sda";
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          bios = {
            size = "1M";
            type = "EF02";
          };
          esp = {
            size = "500M";
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
