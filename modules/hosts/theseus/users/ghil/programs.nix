# programs that belong only on that system, with only that user.
{ inputs, ... }:
{
  flake.modules.homeManager.ghil =
  { pkgs, ... }:
  {
    imports = with inputs.self.modules.homeManager;
      [
        spotify
      ];

    home.packages = with pkgs;
    [
      bootdev-cli # <- learning backend!
      cava
      element-desktop
      firefox
      freecad
      gimp
      hey-mail # <- worst email client, but the @hey.com adress is really fun to have. RAH.
      obsidian
      obs-studio
      # The proton block, because they can't just have one step. Love them though.
      protonmail-bridge
      protonmail-bridge-gui
      protonmail-desktop
      proton-vpn
      qbittorrent
      satty
      thunar
      thunar-archive-plugin
      vesktop # <- Better than Discord at being discord. Still would rather do without discord though.
      vlc
      wl-clipboard
      xarchiver
      yt-dlp
      
      # using flakes:
      inputs.oxicord.packages.${pkgs.stdenv.hostPlatform.system}.default # <- Love this TUI for text channels.
      inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default # <- Browser of choice. SO NICE.
    ];
  };
}
