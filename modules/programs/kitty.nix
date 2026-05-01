{ ... }:
{
  flake.modules.homeManager.kitty =
  {
    programs.kitty = {
      enable = true;
      themeFile = "tokyo_night_night";
      shellIntegration.enableZshIntegration = true;
      font = {
        name = "JetBrainsMono Nerd Font";
        size = 12;
      };
      settings = {
        confirm_os_window_close = 0;
        dynamic_background_opacity = true;
        enable_audio_bell = false;
        background_opacity = "0.8";
        cursor_trail = 8;
      };
    };
  };
}
