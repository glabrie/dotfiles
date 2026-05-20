{ inputs, ... }:
{
  flake.modules.homeManager.helium =
  { pkgs, ... }:
  {
    imports = [ inputs.helium.homeModules.default ];
    programs.helium = {
      enable = true;
    };
  };
}
