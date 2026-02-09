{ config, lib, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    settings = {

      "$mainMod" = "SUPER";
      "$terminal" = "kitty";
      "$fileManager" = "thunar";
      "$menu" = "rofi -show drun";
      "$ipc" = "noctalia-shell ipc call";

      # Monitors
      monitor = [ 
        "eDP-1, disable"
        "DP-4, 3440x1440@119.99Hz, 0x0, 1"
      ];

      # Input
      input = {
        kb_layout = "us,ca";
        kb_options = "grp:alt_shift_toggle";

        follow_mouse = 1;

        touchpad = {
          disable_while_typing = false;
          natural_scroll = true;
        };
      };

      general = {
        layout = "dwindle";

        gaps_in = 6;
        gaps_out = 20;
        border_size = 2;

        "col.active_border" = "rgb(282828) rgb(ebdbb2) 45deg";
        "col.inactive_border" = "ebdbb2";
      };
      
      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
      };

      dwindle = {
        force_split = 2;
        preserve_split = true;
        use_active_for_splits = true;
      };

      master = {
        new_status = "master";
      };

      decoration = {
        rounding = 10;
        rounding_power = 2;

        blur = {
          enabled = true;

          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };

        shadow = {
          enabled = true;
          
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };
      };

      animations = {
        enabled = true;

        bezier = [
          "fluent_decel, 0, 0.2, 0.4, 1"
          "easeOutCirc, 0, 0.55, 0.45, 1"
          "easeOutCubic, 0.33, 1, 0.68, 1"
          "fade_curve, 0, 0.55, 0.45, 1"
        ];

        animation = [
          # name, enable, speed, curve, style

          # Windows
          "windowsIn,   0, 4, easeOutCubic,  popin 20%" # window open
          "windowsOut,  0, 4, fluent_decel,  popin 80%" # window close.
          "windowsMove, 1, 2, fluent_decel, slide" # everything in between, moving, dragging, resizing.

          # Fade
          "fadeIn,      1, 3,   fade_curve" # fade in (open) -> layers and windows
          "fadeOut,     1, 3,   fade_curve" # fade out (close) -> layers and windows
          "fadeSwitch,  0, 1,   easeOutCirc" # fade on changing activewindow and its opacity
          "fadeShadow,  1, 10,  easeOutCirc" # fade on changing activewindow for shadows
          "fadeDim,     1, 4,   fluent_decel" # the easing of the dimming of inactive windows
          "workspaces,  1, 4,   easeOutCubic, fade" # styles: slide, slidevert, fade, slidefade, slidefadevert
        ];
      };
    };
  };
}
