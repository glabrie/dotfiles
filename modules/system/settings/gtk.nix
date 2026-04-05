{ ... }:
{
  flake.modules.homeManager.gtk = 
  { pkgs, lib, ...}:
  {
    gtk = {
      enable = true;
      theme = {
        name = "gruvbox-dark-gtk";
        package = pkgs.gruvbox-dark-gtk;
      };
    };
  };
}
