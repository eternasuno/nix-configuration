{
  inputs,
  pkgs,
  ...
}:
{
  programs.quickshell = {
    enable = true;
    configs = {
      DankMaterialShell = ./DankMaterialShell;
    };
    activeConfig = "DankMaterialShell";
    systemd = {
      enable = false;
    };
  };

  home.packages = with pkgs; [
    brightnessctl
    cava
    cliphist
    ddcutil
    kdePackages.qt6ct
    libsForQt5.qt5ct
    material-symbols
    matugen
    wl-clipboard
  ];
}
