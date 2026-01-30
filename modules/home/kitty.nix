{ config, pkgs, lib, ... }:
{
  programs.kitty = lib.mkForce {
    enable = true;
    themeFile = "GruvboxMaterialDarkMedium";
    shellIntegration.enableZshIntegration = true;
    font = {
      name = "JetBrains Mono";
      size = 14;
    };
    settings = {
      confirm_os_window_close = 0;
      dynamic_background_opacity = true;
      enable_audio_bell = false;
      background_opacity = "0.8";
      background_blur = 5;
      cursor_trail = 8;
    };
  };
}
