{ inputs, ... }:
{
  home.file.".config/quickshell" = {
    source = ./config;
    recursive = true;
  };

  environment.systemPackages = [
    inputs.quickshell.packages.${pkgs.system}.default.override
    {
      withJemalloc = true;
      withQtSvg = true;
      withWayland = true;
      withX11 = false;
      withPipewire = true;
      withPam = true;
      withHyprland = false;
      withI3 = false;
    }
  ];
}
