{ ... }:
{
  flake.modules.homeManager.gtk = 
  { pkgs, lib, ...}:
  {
    gtk = {
      enable = true;
      theme = {
        name = "Tokyonight-Dark";
        package = pkgs.tokyonight-gtk-theme;
      };
    };
  };
}
