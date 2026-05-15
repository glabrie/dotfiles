{ ... }:
{
  flake.modules.homeManager.tmux =
  { pkgs, ... }:
  {
    programs.tmux = {
      enable = true;
      terminal = "tmux-256color";
      historyLimit = 10000;
      mouse = true;
      keyMode = "vi";
      extraConfig = ''
        set-option -g status-position top
        set -g status-right-length 100
        set -g status-left-length 100
        set -g automatic-rename on
        set -g allow-rename off
        set -g automatic-rename-format "#{s/nu/nushell/:pane_current_command}"
        set -ga terminal-overrides ",*256col*:Tc"
        set -ga terminal-features ",*256col*:bce"
        set -g extended-keys on
        set -g window-style 'bg=default'
        set -g window-active-style 'bg=default'

        set -g @catppuccin_flavor "mocha"
        set -g @catppuccin_window_status_style "rounded"
        set -g @catppuccin_date_time_text "%H:%M"

        run-shell ${pkgs.tmuxPlugins.catppuccin.rtp}

        set -g status-left "#{E:@catppuccin_status_session}"
        set -g status-right "#{E:@catppuccin_status_application}#{E:@catppuccin_status_date_time}"
      '';
    };
  };
}
