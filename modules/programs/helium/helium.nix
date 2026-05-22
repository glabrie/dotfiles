{ inputs, ... }:
{
  flake.modules.homeManager.helium =
  { pkgs, ... }:
  {
    imports = [ inputs.helium.homeModules.default ];
    programs.helium = {
      enable = true;
    };

    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "text/html" = "helium.desktop";
        "x-scheme-handler/http" = "helium.desktop";
        "x-scheme-handler/https" = "helium.desktop";
        "x-scheme-handler/about" = "helium.desktop";
        "x-scheme-handler/unknown" = "helium.desktop";
      };
    };
  };
}
