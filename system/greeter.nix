{
  inputs,
  vars,
  ...
}:
let
  inherit (vars) username;
in
{
  imports = [
    inputs.dankMaterialShell.nixosModules.greeter
  ];

  programs.dconf.enable = true;

  programs.dankMaterialShell.greeter = {
    enable = true;
    compositor.name = "niri";
    configHome = "/home/${username}";
    logs.save = true;
  };

  programs.niri.enable = true;
}
