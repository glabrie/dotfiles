{ ... }:
{
  flake.modules.homeManager.fastfetch =
  { ... }:
  {
    xdg.configFile."fastfetch/config.jsonc".source = ./config.jsonc;
  };
}
