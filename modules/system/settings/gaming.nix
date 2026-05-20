{ ... }:
{
  flake.modules.nixos.gaming =
  { pkgs, ... }:
  {
    # Steam
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      extraPackages = [ pkgs.libxmu pkgs.catppuccin-cursors.mochaDark ];
      extest.enable = true;
    };
  };

  flake.modules.homeManager.gaming =
  { ... }:
  {
    xdg.desktopEntries.steam = {
      name = "Steam";
      exec = "steam -system-composer %U";
      icon = "steam";
      terminal = false;
      categories = [ "Network" "FileTransfer" "Game" ];
    };
  };
}
