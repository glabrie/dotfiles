{ ... }:
{
  flake.modules.nixos.nginx =
  { ... }:
  {
    services.nginx = {
      enable = true;
      virtualHosts."git.ghil.dev" = {
        locations."/" = {
          proxyPass = "http://localhost:3000";
          proxyWebsockets = true;
        };
      };
    };
  };
}
