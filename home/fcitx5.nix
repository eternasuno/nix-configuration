{ pkgs, ... }:
{
  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5 = {
      addons = with pkgs; [
        rime-data
        fcitx5-rime
        fcitx5-gtk
        fcitx5-mozc
      ];
      waylandFrontend = true;
    };
  };
}
