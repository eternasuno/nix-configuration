{ pkgs, vars, ... }:
let
  inherit (vars) username;
in
{
  # ====================================================
  # Home Manager Level
  # ====================================================
  home-manager.users.${username} = {
    programs.vscode = {
      enable = true;
      package = pkgs.vscode;
    };
  };
}
