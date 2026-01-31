{ pkgs, vars, ... }:
let
  inherit (vars) username;
in
{
  # ====================================================
  # Home Manager Level
  # ====================================================
  home-manager.users.${username} = {
    gtk = {
      enable = true;
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
