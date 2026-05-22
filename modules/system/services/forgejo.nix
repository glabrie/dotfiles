{ ... }:
{
  flake.modules.nixos.forgejo =
  { ... }:
  {
    services.forgejo = {
      enable = true;
      domain = "git.ghil.dev";
      settings = {
        server = {
          HTTP_PORT = 3000;
          ROOT_URL = "https://git.ghil.dev/";
          DOMAIN = "git.ghil.dev";
        };
        service = {
          DISABLE_REGISTRATION = true;
        };
      };
    };
  };
}
