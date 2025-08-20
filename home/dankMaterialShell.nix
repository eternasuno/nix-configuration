{ inputs, ... }:
{
  imports = [ inputs.dankMaterialShell.homeModules.dankMaterialShell ];

  programs.dankMaterialShell = {
    enable = true;
    enableKeybinds = true;
    enableSystemd = true;
  };
}
