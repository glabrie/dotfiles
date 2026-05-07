{ inputs, ... }:
{
  flake.modules.homeManager.noctalia =
  { ... }:
  {
    imports = [ inputs.noctalia.homeModules.default ];
    programs.noctalia-shell = {
      enable = true;

settings = {
  bar = {
    barType = "floating";
    density = "default";
    position = "top";
    showCapsule = false;
    backgroundOpacity = 1;
    useSeparateOpacity = false;
    floating = true;
    marginVertical = 4;
    marginHorizontal = 12;
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
        hideUnoccupied = true;
        id = "Workspace";
        labelMode = "name";
        characterCount = 10;
        fontWeight = "bold";
        pillSize = 0.8;
        showLabelsOnlyWhenOccupied = true;
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
  radiusRatio = 0.30;
  dimmerOpacity = 0.2;
  showScreenCorners = true;
  forceBlackScreenCorners = true;
  enableShadows = true;
  telemetryEnabled = false;
  autoStartAuth = false;
};

ui = {
  fontDefault = "JetBrainsMono Nerd Font";
  fontFixed = "JetBrainsMono Nerd Font";
  panelBackgroundOpacity = 1;
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
          overviewEnabled = true;
          directory = "$HOME/images/walls/art/";
          automationEnabled = true;
          wallpaperChangeMode = "random";
          randomIntervalSec = 1800;
        };
        dock = {
          enabled = false;
        };

      };

    };
  };
}
