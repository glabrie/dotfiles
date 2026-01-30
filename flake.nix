{
  description = "Ghil's very basic flake";

  inputs = {
    hyprland.url = "github:hyprwm/Hyprland";
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
  };

  outputs = { 
    hyprland
    self, 
    nixpkgs,
    home-manager,
    nvf,
    stylix,
    ...
  } @ inputs: {
    nixosConfigurations.theseus = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs self;};
      modules = [
        ./modules/theseus/configuration.nix
        ./modules/theseus/graphics.nix
	      nvf.nixosModules.default
        ./modules/nvf/nvf-configuration.nix
        stylix.nixosModules.stylix
        ./modules/greetd/greetd.nix
	      home-manager.nixosModules.home-manager
	      {
	        home-manager.useGlobalPkgs = true;
	        home-manager.useUserPackages = true;
	        home-manager.users.ghil = ./home/theseus.nix;
	        home-manager.extraSpecialArgs = {
	          inherit inputs;
	          system = "x86_64-linux";
	        };
	      }
      ];
    };
  };
}
