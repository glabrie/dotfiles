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
      extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
      shell = pkgs.nushell;
    };
  };

  flake.modules.nixos."${username}-hm" =
  { ... }:
  {
    home-manager.users."${username}" = {
      imports = [
        inputs.self.modules.homeManager."${username}"
      ];
    };
  };

  flake.modules.nixos."${username}-keys" =
  { ... }:
  {
    users.users."${username}".openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBV9vWWWG5h/Lg9ar+6Qena77JtMELm0xbO8BaqwI46Z ghil@theseus"
    ];
  };

  flake.modules.homeManager."${username}" = {
    imports = with inputs.self.modules.homeManager;
    [
      system-desktop
      nushell
      nushell-book
      helium
    ];
  home.username = "${username}";

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    setSessionVariables = false;
    desktop = null;
    documents = "/home/${username}/documents";
    download = "/home/${username}/downloads";
    music = "/home/${username}/music";
    pictures = "/home/${username}/images";
    projects = "/home/${username}/projects";
    publicShare = null;
    templates = null;
    videos = "/home/${username}/videos";
  };

  };
}
