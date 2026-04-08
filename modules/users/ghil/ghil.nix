{ inputs, ... }:
let
  username = "ghil";
in
{
  flake.modules.nixos."${username}" =
  { pkgs, ... }:
  {
    users.users."${username}" = {
      name = "${username}";
      isNormalUser = true;
      description = "Guillaume Labrie";
      extraGroups = [ "networkmanager" "wheel" ];
      shell = pkgs.nushell;
    };

    home-manager.users."${username}" = {
      imports = [
        inputs.self.modules.homeManager."${username}"
      ];
    };
  };
    
  flake.modules.homeManager."${username}" = {
    imports = with inputs.self.modules.homeManager;
    [
      system-desktop
      nushell
    ];
  home.username = "${username}";

  };
}
