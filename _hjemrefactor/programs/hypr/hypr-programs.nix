# Necessary packages to make hyprland a proper environment
{
  flake.modules.homeManager.hyprland =
  { pkgs, ... }:
  {
    home.packages = with pkgs;
    [
      hyprpolkitagent
      hyprshot
      satty
      wl-clipboard
      thunar
      thunar-archive-plugin
      xarchiver
    ];
  };
}

