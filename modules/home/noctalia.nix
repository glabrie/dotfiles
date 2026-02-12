{ pkgs, inputs, ... }:
{
  # import the home manager module
  imports = [
    inputs.noctalia.homeModules.default
  ];

  # configure options
  programs.noctalia-shell = {
    enable = true;
    systemd.enable = true;
    settings = {
      # Bar options
      bar = {
        barType = "framed";
        density = "comfortable";
        position = "left";
        showCapsule = false;
        backgroundOpacity = 0.6;
        useSeparateOpacity = true;
        floating = false;
        marginVertical = 4;
        marginHorizontal = 4;
        frameThickness = 8;
        frameRadius = 12;
        outerCorners = true;
        exclusive = true;
        widgets = {
          left = [
            {
              id = "ControlCenter";
              useDistroLogo = true;
            }
          ];
          center = [
            {
              hideUnoccupied = false;
              id = "Workspace";
              labelMode = "none";
            }
          ];
          right = [
            {
              alwaysShowPercentage = false;
              id = "Battery";
              warningThreshold = 30;
            }
            {
              id = "Network";
            }
            {
              id = "Bluetooth";
            }
            {
              formatHorizontal = "HH:mm";
              formatVertical = "HH mm";
              id = "Clock";
              useMonospacedFont = true;
              usePrimaryColor = true;
            }
          ];
        };
      };
      colorSchemes = {
        predefinedScheme = "Gruvbox";
        darkMode = true;
      };
      general = {
        avatarImage = "/home/ghil/.face";
        radiusRatio = 0.2;
        dimmerOpacity = 0.2;
        showScreenCorners = true;
        forceBlackScreenCorners = true;
        enableShadows = true;
        telemetryEnabled = false;
        autoStartAuth = false;
      };
      ui = {
        fontDefault = "JetBrains Mono";
        fontFixed = "monospace";
        panelBackgroundOpacity = 0.93;
        boxBorderEnabled = false;
      };
      location = {
        monthBeforeDay = false;
        name = "Quebec, Canada";
        useFahrenheit = false;
        firstDayOfWeek = -1;
      };
      wallpaper = {
        enabled = true;
        directory = "$HOME/images/walls";
      };
      dock = {
        enabled = false;
      };

    };
    
  };
}
