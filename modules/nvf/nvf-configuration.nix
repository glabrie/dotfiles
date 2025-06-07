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

        # Visuals
        visuals = {
          nvim-cursorline.enable = true;
          fidget-nvim.enable = true;
          indent-blankline.enable = true;
          nvim-web-devicons.enable = true;
        };
        
        # Settings and plugins
        globals.mapleader = " ";
        viAlias = false;
        vimAlias = true;
        statusline.lualine.enable = true;
        telescope.enable = true;
        autocomplete.blink-cmp.enable = true;
        projects.project-nvim.enable = true;
        notify.nvim-notify.enable = true;
        presence.neocord.enable = true;
        lsp.enable = true;
        languages = {
          enableTreesitter = true;
          # Languages 
          nix.enable = true;
          python.enable = true;
          go.enable = true;
          rust.enable = true;
        };

        # Options
        options = {
          tabstop = 2;
          softtabstop = 2;
          shiftwidth = 2;
        };

        # Binds
        binds.whichKey.enable = true;
      };
    };
  };
}
