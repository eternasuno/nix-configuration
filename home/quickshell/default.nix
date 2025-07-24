{
  inputs,
  pkgs,
  ...
}:
{
  home.file.".config/quickshell" = {
    source = ./config;
    recursive = true;
  };

  home.packages = with pkgs; [
    inputs.quickshell.packages.${pkgs.system}.default
    cava
    gpu-screen-recorder
    material-symbols
    qt6Packages.qt5compat
  ];
}
