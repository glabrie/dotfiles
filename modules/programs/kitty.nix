{ ... }:
{
  flake.modules.homeManager.kitty =
  {
    programs.kitty = {
      enable = true;
      themeFile = "GruvboxMaterialDarkMedium";
      shellIntegration.enableZshIntegration = true;
      font = {
        name = "JetBrains Mono";
        size = 12;
      };
      settings = {
        confirm_os_window_close = 0;
        dynamic_background_opacity = true;
        enable_audio_bell = false;
        background_opacity = "1";
        background_blur = 5;
        cursor_trail = 8;
      };
    };
  };
}
