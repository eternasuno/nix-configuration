{ vars, ... }:
let
  inherit (vars) username;
in
{
  home-manager.users.${username}.programs.nvf.settings.vim = {
    theme = {
      enable = true;
      name = "onedark";
      style = "deep";
    };

    statusline.lualine = {
      enable = true;
      theme = "onedark";
    };

    dashboard.alpha.enable = true;

    visuals = {
      enable = true;
      nvimWebDevicons.enable = true;
      lineNumbers = {
        enable = true;
        relativenumber = true;
      };
      cursorline.enable = true;
    };

    options = {
      tabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      mouse = "a";
    };

    autopairs.nvim-autopairs.enable = true;
  };
}
