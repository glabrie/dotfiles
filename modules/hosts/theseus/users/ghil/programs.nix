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
      miracode
      monocraft
      nerd-fonts.symbols-only
      claude-code
      firefox
      freecad
      gimp
      guile
      obsidian
      obs-studio
      protonmail-bridge
      proton-vpn
      qbittorrent
      vesktop
      vlc
      wl-clipboard
      inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}
