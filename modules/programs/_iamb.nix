{ ... }:
{
  flake.modules.homeManager.iamb =
  { ... }:
  {
    programs.iamb = {
      enable = true;
      settings = {
         profiles.user = {
          user_id = "@ghil_:matrix.org";
          };
      };
    };
  };
}
