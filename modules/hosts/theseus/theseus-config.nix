{ inputs, ... }:
{
  systems = [ "x86_64-linux" ];

  flake.nixosConfigurations.theseus =
    inputs.nixpkgs.lib.nixosSystem {
      modules = [
        inputs.self.modules.nixos.theseus
        inputs.agenix.nixosModules.default
      ];
  };

flake.modules.nixos.theseus =
{
  networking.hostName = "theseus";
  nixpkgs.hostPlatform = "x86_64-linux";

imports = with inputs.self.modules.nixos;
    [
      system-desktop
      ghil
      ghil-hm
      ghil-keys
      fonts
      gaming
      locale
      nvidia
      security
      boot
      touchpad
      nix-ld
      nightly-update
      vpn
      # kanata
    ];
  };
}
