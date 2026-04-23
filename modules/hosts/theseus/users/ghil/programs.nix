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
      claude-code
      element-desktop
      firefox
      freecad
      gimp
      mpv
      obsidian
      obs-studio
      protonmail-bridge
      proton-vpn
      qbittorrent
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
