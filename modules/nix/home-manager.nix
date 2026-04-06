# We are a home-manager house here son. Kidding, I want to switch to hjem. but muh nvf -_-
{ inputs, ... }:
let
  home-manager-config =
    { lib, ... }:
    {
      home-manager = {
        verbose = true;
        useUserPackages = true;
        useGlobalPkgs = true;
        backupFileExtension = "backup";
        backupCommand = "rm";
        overwriteBackup = true;
      };
    };
in
  {
    imports = 
    [ 
      inputs.flake-parts.flakeModules.modules
      inputs.home-manager.flakeModules.home-manager 
    ];

    flake.modules.nixos.home-manager = {
      imports = [
        inputs.home-manager.nixosModules.home-manager
        home-manager-config
      ];
    };
}
