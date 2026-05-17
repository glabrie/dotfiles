{ ... }:
{
  flake.modules.homeManager.mpd =
  { ... }:
  {
    services.mpd = {
      enable = true;
      musicDirectory = "~/music/";
      extraConfig = ''
        audio_output {
          type "pipewire"
          name "PipeWire Output"
        }
      '';
    };
  };
}
