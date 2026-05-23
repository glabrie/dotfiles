{ ... }:
{
  flake.modules.homeManager.kitty =
  {
    programs.kitty = {
      enable = true;
      themeFile = "ayu_light";
      font = {
        name = "JetBrainsMono Nerd Font";
        size = 12;
      };
      settings = {
        confirm_os_window_close = 0;
        dynamic_background_opacity = true;
        enable_audio_bell = false;
        background_opacity = "0.9";
        cursor_trail = 8;
        color7 = "#5b6673";
        color15 = "#5b6673";
        symbol_map = "U+23FB-U+23FE,U+2665,U+26A1,U+2B58,U+E000-U+E00A,U+E0A0-U+E0A3,U+E0B0-U+E0C8,U+E0CA,U+E0CC-U+E0D7,U+E0D9,U+E0DB-U+E0DF,U+E200-U+E2A9,U+E300-U+E3E3,U+E5FA-U+E6B1,U+E700-U+E7C5,U+EA60-U+EBEB,U+F000-U+F2E0,U+F300-U+F372,U+F400-U+F532,U+F0001-U+F1AF0 Symbols Nerd Font Mono";


      };
    };
  };
}
