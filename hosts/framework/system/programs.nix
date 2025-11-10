{ inputs, vars, ... }:
let
  inherit (vars) username;
in
{
  # programs.dconf.enable = true;

  imports = [
    inputs.dankMaterialShell.nixosModules.greeter
  ];

  programs.dankMaterialShell.greeter = {
    enable = true;
    compositor.name = "niri";
    configHome = "/home/${username}";
  };
}
