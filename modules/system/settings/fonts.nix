{ inputs, ... }:
{
  flake.modules.nixos.fonts =
  { pkgs, ...}:
  {
    fonts.packages = with pkgs; [
      maple-mono.NF
      font-awesome
      font-awesome_5
    ];
  };
  flake.modules.homeManager.fonts = {
    fonts.fontconfig.enable = true;
  };
}
