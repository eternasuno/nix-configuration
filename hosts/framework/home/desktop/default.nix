{ inputs, pkgs, ... }:
{
  imports = [
    inputs.niri.homeModules.niri
    inputs.noctalia.homeModules.default
    ./niri.nix
    ./noctalia.nix
  ];

  home.packages = with pkgs; [
    inputs.noctalia.packages.${pkgs.system}.default
    grim
    slurp
    wl-clipboard
  ];
}
