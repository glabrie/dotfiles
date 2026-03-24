# Add a keyring to keep all of your secrets...secret.
{ ... }:
{
  flake.modules.nixos.security =
  { ... }:
  {
    programs.gnupg.agent.enable = true;
    services.gnome.gnome-keyring.enable = true;
  };
}
