{vars, ...}: let
  inherit (vars) username;
in {
  home-manager.users.${username}.programs.nvf.settings.vim = {
    filetree.neo-tree.enable = true;
    telescope.enable = true;
    binds.whichKey.enable = true;

    keymaps = [
      {
        key = "<leader>e";
        mode = ["n" "v"];
        action = "<cmd>Neotree toggle<CR>";
        silent = true;
        desc = "Toggle Explorer (Neo-tree)";
      }
    ];
  };
}
