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
      cava
      claude-code
      element-desktop
      firefox
      freecad
      gimp
      obsidian
      obs-studio
      protonmail-bridge
      proton-vpn
      qbittorrent
      vesktop
      vlc
      wl-clipboard
      inputs.oxicord.packages.${pkgs.stdenv.hostPlatform.system}.default
      inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}
