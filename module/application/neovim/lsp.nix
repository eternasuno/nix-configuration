{ vars, ... }:
let
  inherit (vars) username;
in
{
  home-manager.users.${username}.programs.nvf.settings.vim = {
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
  };
}
