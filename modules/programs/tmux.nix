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
      plugins = with pkgs.tmuxPlugins; [
        {
          plugin = catppuccin;
          extraConfig = ''
            set -g @catppuccin_flavor "mocha"
            set -g @catppuccin_window_status_style "rounded"
            set -g @catppuccin_status_modules_right "application date_time"
            set -g @catppuccin_date_time_text " %H:%M"
          '';
        }
      ];
      extraConfig = ''
        set-option -g status-position top
        set -g status-right-length 100
        set -g status-left-length 100
      '';
    };
  };
}
