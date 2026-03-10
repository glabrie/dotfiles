# Laptop configuration. Fun fact, it's called Theseus because
# I repaired it so often, I don't think there's a piece that's original in there.
{ ... }:
{
  flake.modules.nixos.theseus = 
  { ... }:
  {
    networking.hostName = "theseus";
    
    # Home-manager settings so that I don't have to manually erase the hyprland config everytime -_-
    home-manager.backupFileExtension = "";
    home-manager.overwriteBackup = true;

    # Please for the love of all that is holy, don't touch
    system.stateVersion = "25.11";
  };
}
