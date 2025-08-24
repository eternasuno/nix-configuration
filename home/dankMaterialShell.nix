{ inputs, pkgs, ... }:
{
  imports = [ inputs.dankMaterialShell.homeModules.dankMaterialShell ];

  programs.dankMaterialShell = {
    enable = true;
    enableSystemd = true;
  };
  
  home.packages = with pkgs; [
    inputs.dgop.packages.${pkgs.system}.default
    brightnessctl
  ];
}
