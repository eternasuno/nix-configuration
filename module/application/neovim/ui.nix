{vars, ...}: let
  inherit (vars) username;
in {
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
      nvim-web-devicons.enable = true;
    };

    options = {
      tabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      mouse = "a";
      number = true;
      relativenumber = true;
      cursorline = true;
    };

    autopairs.nvim-autopairs.enable = true;
    utility.multicursors.enable = true;

    keymaps = [
      {
        key = "<C-n>";
        mode = ["n" "v"];
        action = "<cmd>MCstart<cr>";
        silent = true;
        desc = "Create a selection for selected text or word under the cursor";
      }
      {
        key = "<leader>m";
        mode = "n";
        action = "<cmd>MCpattern<cr>";
        silent = true;
        desc = "Create a selection for the current word using the pattern";
      }
    ];
  };
}
