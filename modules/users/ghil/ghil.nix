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
