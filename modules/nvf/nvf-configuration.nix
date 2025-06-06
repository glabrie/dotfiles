{ pkgs, lib, ... }:

{
  programs.nvf = {
    enable = true;
    settings = {
      vim.theme = {
        enable = true;
        name = "gruvbox";
        style = "dark";
      };

      vim.statusline.lualine.enable = true;
      vim.telescope.enable = true;
      vim.autocomplete.nvim-cmp.enable = true;

      vim.languages = {
        enableLSP = true;
        enableTreesitter = true;
      
        nix.enable = true;
        python.enable = true;
        go.enable = true;
        rust.enable = true;
      };
    };
  };
}
