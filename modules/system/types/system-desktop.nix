# Building upon the base, we're now building a desktop with graphical userland
{ inputs, ... }:
{
  flake.modules.nixos.system-desktop =
  {
    services.dbus.implementation = "broker";

    imports = with inputs.self.modules.nixos;
      [
        system-base

        audio
        bluetooth
        flatpak
        greetd
        networking
        niri
        storage
      ];
  };

  flake.modules.homeManager.system-desktop =
  {
    imports = with inputs.self.modules.homeManager;
      [
        system-base

        bluetooth
        emacs
        gtk
        kitty
        networking
        niri
        noctalia
      ];
  };
}
