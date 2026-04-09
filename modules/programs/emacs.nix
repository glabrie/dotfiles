# Yup, switched to emacs. Was it a good idea? I'll see in 6 to 12 years.
# If you want to have a terminal in emacs, you need to package it with vterm.
# We're also using the pgtk version for wayland support (because I wanted transparency. I know.)
{ ... }:
{
  flake.modules.homeManager.emacs =
  { pkgs, ... }:
  {
    programs.emacs = {
      enable = true;
      package = pkgs.emacs-pgtk.pkgs.withPackages (e: [ e.vterm ]);
    };
    services.emacs = {
      enable = true;
    };
  };
}
