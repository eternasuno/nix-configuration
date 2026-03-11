{ pkgs, vars, ... }:
let
  inherit (vars) username;
in
{
  home-manager.users.${username} = {
    gtk = {
      enable = true;
      font = {
        name = "Sans";
        size = 12;
      };
      iconTheme = {
        name = "Adwaita";
        package = pkgs.adwaita-icon-theme;
      };
      theme = {
        name = "Adwaita";
        package = pkgs.gnome-themes-extra;
      };
    };
  };
}
