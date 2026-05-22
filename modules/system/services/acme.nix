{ config, ... }:
{
  flake.modules.nixos.acme =
  { config, ... }:
  {
    age.secrets.namecheap-acme = {
      file = ../../../secrets/namecheap-acme.age;
      owner = "acme";
      group = "acme";
    };

    security.acme = {
      acceptTerms = true;
      defaults.email = "glabrie85@gmail.com";
      certs."git.ghil.dev" = {
        dnsProvider = "namecheap";
        environmentFile = config.age.secrets.namecheap-acme.path;
      };
    };
  };
}
