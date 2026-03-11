{ pkgs, vars, ... }:
let
  inherit (vars) username;
in
{
  home-manager.users.${username} = {
    programs.vscode = {
      enable = true;
      package = pkgs.vscode;
      profiles.default.userSettings = {
        "editor.fontSize" = 16;
        "terminal.integrated.fontSize" = 15;
        "workbench.colorTheme" = "One Dark Pro";
        "window.menuBarVisibility" = "hidden";
      };
    };
  };
}
