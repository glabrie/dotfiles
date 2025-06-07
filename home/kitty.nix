{ config, pkgs, ... }:
{
  programs.kitty = lib.mkForce {
    enable = true;
    settings = {
      confirm_os_window_close = 0;
      dynamic_background_opacity = true;
      enable_audio_bell = false;
      background_opacity = "0.5";
      background_blur = 5;
    };
  };
}
