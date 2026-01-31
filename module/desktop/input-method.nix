{ pkgs, vars, ... }:
let
  inherit (vars) username;
in
{
  # ====================================================
  # Home Manager Level
  # ====================================================
  home-manager.users.${username} = {
    i18n.inputMethod = {
      type = "fcitx5";
      enable = true;
      fcitx5 = {
        addons = with pkgs; [
          fcitx5-rime
        ];
        waylandFrontend = true;
      };
    };
  };
}
