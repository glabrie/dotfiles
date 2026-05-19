# Gaming related config, all conveniently placed in the same spot!
{ ... }:
{
  flake.modules.nixos.gaming =
  { pkgs, ... }:
  {
    # Steam
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      extraPackages = [ pkgs.libxmu pkgs.catppuccin-cursors.mochaDark pkgs.extest pkgs.pkgsi686Linux.extest ];
    };

    # Enable xbox controller support
    hardware.xpadneo.enable = true;
    hardware.xone.enable = true;
  };

  flake.modules.homeManager.gaming =
  { pkgs, ... }:
  {
    xdg.desktopEntries.steam = {
      name = "Steam";
      exec = "env LD_PRELOAD=${pkgs.extest}/lib/libextest.so steam -system-composer %U";
      icon = "steam";
      terminal = false;
      categories = [ "Network" "FileTransfer" "Game" ];
    };
  };
}
