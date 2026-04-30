{ pkgs, vars, ... }:
let
  inherit (vars) username;
in
{
  home-manager.users.${username} = {
    i18n.inputMethod = {
      type = "fcitx5";
      enable = true;
      fcitx5 = {
        addons = with pkgs; [
          fcitx5-rime
        ];
        settings = {
          addons = {
            classicui.globalSection = {
              "Vertical Candidate List" = true;
            };
          };
        };
        waylandFrontend = true;
      };
    };

    xdg.configFile."fcitx5/rime/default.custom.yaml".text = ''
      patch:
        ascii_composer/switch_key/Caps_Lock: noop
    '';
  };
}
