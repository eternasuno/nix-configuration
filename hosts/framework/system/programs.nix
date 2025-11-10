{
  inputs,
  vars,
  pkgs,
  ...
}:
let
  inherit (vars) username;
in
{
  programs.dconf.enable = true;

  imports = [
    inputs.dankMaterialShell.nixosModules.greeter
  ];

  greetd = {
    enable = true;
  };

  programs.dankMaterialShell.greeter = {
    enable = true;
    compositor.name = "niri";
    configHome = "/home/${username}";
  };
}
