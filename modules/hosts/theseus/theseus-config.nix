# Laptop config. Fun fact, it's called Theseus because
# I repaired it so often, I don't think there's an original piece left in there.
{ inputs, ... }:
{
  systems = [ "x86_64-linux" ];
  
  flake.nixosConfigurations.theseus = 
    inputs.nixpkgs.lib.nixosSystem {
      modules = [ inputs.self.modules.nixos.theseus ];
  };

  flake.modules.nixos.theseus =
  {
    networking.hostName = "theseus";

    nixpkgs.hostPlatform = "x86_64-linux";

    imports = with inputs.self.modules.nixos;
    [
      # System-type first
      system-desktop

      # The users on this host
      ghil

      # Settings we need on this config
      bluetooth
      fonts
      gaming # <- Steam and a few settings
      locale
      niri
      nvidia # <- The devil itself, Optimus laptop
      security
      boot
      touchpad
    ];
  };
}
