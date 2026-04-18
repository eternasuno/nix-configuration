{ pkgs, vars, ... }:
let
  inherit (vars) username;
in
{
  home-manager.users.${username}.programs.vscode = {
    package = pkgs.emptyDirectory;
  };

  homebrew.casks = [ "visual-studio-code" ];
}
