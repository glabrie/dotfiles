{ inputs, ... }:
{
  flake.modules.nixos.fonts =
  { pkgs, ...}:
  {
    fonts.packages = with pkgs; [
      jetbrains-mono
      nerd-fonts.jetbrains-mono
      font-awesome
      font-awesome_5
    ];
  };
  flake.modules.homeManager.fonts = {
    fonts.fontconfig.enable = true;
  };
}
