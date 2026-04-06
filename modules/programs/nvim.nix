{ inputs, ... }:
{
  flake.modules.homeManager.nvim = { pkgs, lib, ... }: {
    imports = [
      inputs.nvf.homeManagerModules.default
    ];
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
          notes.todo-comments.enable = true;
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

          # Org-mode in neovim!
          notes.orgmode = {
            enable = true;
            treesitter.enable = true;
            setupOpts = {
              org_agenda_files = [ "~/org/**/*" ];
              org_default_notes_file = "~/org/refile.org";
            };
          };

          luaConfigRC.orgmode-grammar-fix = lib.mkBefore ''
            do
              local config = require("orgmode.config")
              config.install_grammar = function() return true end
            end
          '';

          # Binds
          binds.whichKey.enable = true;
        };
      };
    };
  };
}
