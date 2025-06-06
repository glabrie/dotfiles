{ pkgs, lib, ... }:

{
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        theme = {
          enable = true;
          name = "gruvbox";
          style = "dark";
        };

      # Settings and plugins
        globals.mapleader = " ";
        viAlias = false;
        vimAlias = true;
        statusline.lualine.enable = true;
        telescope.enable = true;
        autocomplete.nvim-cmp.enable = true;
        languages = {
          lsp.enable = true;
          enableTreesitter = true;
          # Languages 
          nix.enable = true;
          python.enable = true;
          go.enable = true;
          rust.enable = true;
      # Options
        options = {
          tabstop = 2;
          softtabstop = 2;
          shiftwidth = 2;
        };
      # Binds
        }; 
      };
    };
  };
}
