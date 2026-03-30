{ ... }:
{
  flake.modules.homeManager.discord =
  { pkgs, ... }:
  {
    home.packages = [
      (pkgs.symlinkJoin {
        name = "discord";
        paths = [ pkgs.discord ];
        nativeBuildInputs = [ pkgs.makeWrapper ];
        postBuild = ''
          wrapProgram $out/bin/discord --add-flags "--use-gl=desktop"
        '';
      })
    ];
  };
}
