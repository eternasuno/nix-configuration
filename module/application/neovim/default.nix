{ pkgs, vars, inputs, ... }:
let
  inherit (vars) username;
in
{
  imports = [
    ./git.nix
    ./llm.nix
    ./lsp.nix
    ./navigation.nix
    ./ui.nix
  ];

  home-manager.users.${username} = {
    imports = [ inputs.nvf.homeManagerModules.default ];

    home.packages = with pkgs; [
      ripgrep
      fd
    ];

    programs.nvf = {
      enable = true;
      settings = {
        vim = {
          viAlias = true;
          vimAlias = true;
        };
      };
    };
  };
}
