{
  description = "Ghil's very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    nvf.url = "github:notashelf/nvf";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { 
    self, 
    nixpkgs,
    noctalia,
    home-manager,
    nvf,
    stylix,
    ...
  } @ inputs: {
    nixosConfigurations.theseus = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs self;};
      modules = [
        ./modules/core/configuration.nix
        ./modules/hardware/nvidia.nix
	      nvf.nixosModules.default
        ./modules/home/nvf/nvf-configuration.nix
        stylix.nixosModules.stylix
        ./modules/core/greetd/greetd.nix
        ./modules/home/noctalia.nix
	      home-manager.nixosModules.home-manager
	      {
	        home-manager.useGlobalPkgs = true;
	        home-manager.useUserPackages = true;
	        home-manager.users.ghil = ./modules/home/default.nix;
	        home-manager.extraSpecialArgs = {
	          inherit inputs;
	          system = "x86_64-linux";
	        };
	      }
      ];
    };
  };
}
