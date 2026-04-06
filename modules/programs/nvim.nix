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

          luaConfigRC.orgmode-grammar-fix = lib.mkOrder 100 ''
            do
              local orig_require = require
              local patched = false
              require = function(modname)
                local mod = orig_require(modname)
                if modname == "orgmode" and not patched then
                  patched = true
                  local orig_setup = mod.setup
                  mod.setup = function(opts)
                    -- Replace install_grammar before it runs
                    local install_mod = orig_require("orgmode.utils.treesitter.install")
                    if install_mod and install_mod.install then
                      install_mod.install = function(cb) if cb then cb() end end
                    end
                    if install_mod and install_mod.install_grammar then
                      install_mod.install_grammar = function(cb) if cb then cb() end end
                    end
                    return orig_setup(opts)
                  end
                end
                return mod
              end
            end
          '';

          # Binds
          binds.whichKey.enable = true;
        };
      };
    };
  };
}
