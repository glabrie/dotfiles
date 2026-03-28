  # Hyprland system config.
  { inputs, ... }:
  {
    flake.modules.nixos.hyprland =
    { ... }:
    {
      programs.hyprland.enable = true;
      programs.hyprland.withUWSM = true;
      environment.sessionVariables.NIXOS_OZONE_WL = "1";
    };
  }

