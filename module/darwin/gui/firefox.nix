{ pkgs, vars, ... }:
let
  inherit (vars) username;
in
{
  home-manager.users.${username}.programs.firefox = {
    package = pkgs.emptyDirectory;
  };

  homebrew.casks = [ "firefox" ];
}
