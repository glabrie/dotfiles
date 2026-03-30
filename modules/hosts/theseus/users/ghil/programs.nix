# programs that belong only on that system, with only that user.
{ inputs, ... }:
{
  flake.modules.homeManager.ghil =
  { pkgs, ... }:
  {
    imports = with inputs.self.modules.homeManager;
      [
        discord
        spotify
      ];

    home.packages = with pkgs;
    [
      cava
      claude-code
      element-desktop
      firefox
      hey-mail
      obsidian
      protonmail-bridge
      protonmail-bridge-gui
      protonmail-desktop
      proton-vpn
      vesktop
      
      # using flakes:
      inputs.oxicord.packages.${pkgs.stdenv.hostPlatform.system}.default
      inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}
