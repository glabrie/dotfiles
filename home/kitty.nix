{ config, pkgs, lib, ... }:
{
  programs.kitty = lib.mkForce {
    enable = true;
    themeFile = "GruvboxMaterialDarkSoft";
    settings = {
      confirm_os_window_close = 0;
      dynamic_background_opacity = true;
      enable_audio_bell = false;
      background_opacity = "0.5";
      background_blur = 5;
      cursor_trail = 8;
      font-family = "JetBrains Mono";
    };
  };
}
