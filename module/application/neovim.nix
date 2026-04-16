{ pkgs, vars, inputs, ... }:
let
  inherit (vars) username;
in
{
  home-manager.users.${username} = {
    imports = [ inputs.nvf.homeManagerModules.default ];

    home.packages = with pkgs; [
      ripgrep 
      fd
      github-copilot-cli 
    ];

    programs.nvf = {
      enable = true;
      settings = {
        vim = {
          viAlias = true;
          vimAlias = true;

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

          filetree.neo-tree = {
            enable = true;
          };

          telescope = {
            enable = true;
          };

          binds.whichKey = {
            enable = true;
          };

          git = {
            enable = true;
            gitsigns = {
              enable = true;
              codeActions.enable = true;
            };
            lazygit.enable = true; 
          };

          terminal.toggleterm = {
            enable = true;
            setupOpts = {
              direction = "float";
              open_mapping = "[[<c-t>]]";
            };
          };

          languages = {
            enableLSP = true;
            enableTreesitter = true;
            enableFormat = true;

            nix.enable = true;
            rust.enable = true;
            ts.enable = true;
            css.enable = true;
            html.enable = true;
          };

          lsp.formatOnSave = true;

          autocomplete.nvim-cmp = {
            enable = true;
          };

          extraPlugins = with pkgs.vimPlugins; {
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
      };
    };
  };
}
