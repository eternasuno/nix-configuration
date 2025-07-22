{
  inputs,
  pkgs,
  ...
}: {
  home.file.".config/quickshell" = {
    source = ./config;
    recursive = true;
  };

  home.packages = [
    inputs.quickshell.packages.${pkgs.system}.default
    pkgs.qt6Packages.qt5compat
  ];
}
