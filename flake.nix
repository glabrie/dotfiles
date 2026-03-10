{
  description = "Ghil's NixOS adventures";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";

    import-tree.url = "github:vic/import-tree";

    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    nvf.url = "github:notashelf/nvf";

    oxicord.url = "github:linuxmobile/oxicord";

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } ({ inputs, withSystem, ...}: {
      imports = [
        inputs.flake-parts.flakeModules.modules
        (inputs.import-tree ./modules)
      ];

      systems = [ "x86_64-linux" ];

      flake = {
        nixosConfigurations.theseus = inputs.nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
          };
          modules = [
            ./modules/hosts/theseus/_hardware-configuration.nix
            inputs.self.modules.nixos.audio
            inputs.self.modules.nixos.boot
            inputs.self.modules.nixos.nix
            inputs.self.modules.nixos.bluetooth
            inputs.self.modules.nixos.networking
            inputs.self.modules.nixos.locale
            inputs.self.modules.nixos.hyprland
            inputs.self.modules.nixos.gaming
            inputs.self.modules.nixos.security
            inputs.self.modules.nixos.touchpad
            inputs.self.modules.nixos.storage
            inputs.self.modules.nixos.flatpak
            inputs.self.modules.nixos.theseus
            inputs.self.modules.nixos.greetd
            inputs.self.modules.nixos.ghil
            inputs.self.modules.nixos.nvidia
            ./legacy/home/nvf/nvf-configuration.nix
            inputs.nvf.nixosModules.default
            inputs.home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.ghil = ./legacy/home/default.nix;
              home-manager.extraSpecialArgs = {
                inherit inputs;
                system = "x86_64-linux";
              };
            }
          ];
        };
      };
    });
}
