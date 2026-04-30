{
  pkgs,
  vars,
  ...
}: let
  inherit (vars) username;
in {
  home-manager.users.${username} = {
    programs.nvf.settings.vim.extraPlugins = with pkgs.vimPlugins; {
      supermaven = {
        package = supermaven-nvim;
        setup = ''
          require("supermaven-nvim").setup({
            keymaps = {
              accept_suggestion = "<Tab>",
              clear_suggestion = "<C-]>",
              accept_word = "<C-j>",
            },
          })
        '';
      };
    };
  };
}
