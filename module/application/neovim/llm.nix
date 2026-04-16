{ pkgs, vars, ... }:
let
  inherit (vars) username;
in
{
  home-manager.users.${username} = {
    home.packages = with pkgs; [ github-copilot-cli ];

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

      codecompanion = {
        package = codecompanion-nvim;
        setup = ''
          require("codecompanion").setup({
            strategies = {
              chat = { adapter = "copilot_cli" },
              inline = { adapter = "copilot_cli" },
              agent = { adapter = "copilot_cli" },
            },
            display = {
              chat = {
                window = {
                  layout = "vertical",
                  width = 40,
                },
              },
            },
          })

          vim.keymap.set({'n', 'v'}, '<leader>cc', '<cmd>CodeCompanionChat Toggle<CR>', { desc = 'Toggle AI Chat' })
          vim.keymap.set({'n', 'v'}, '<leader>ca', '<cmd>CodeCompanionActions<CR>', { desc = 'AI Actions' })
          vim.keymap.set('v', '<leader>ce', '<cmd>CodeCompanionChat Explain<CR>', { desc = 'Explain Code' })
        '';
      };
    };
  };
}
