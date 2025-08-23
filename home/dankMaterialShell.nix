{ inputs, ... }:
{
  imports = [ inputs.dankMaterialShell.homeModules.dankMaterialShell ];

  programs.dankMaterialShell = {
    enable = true;
    enableSystemd = true;
  };
}
