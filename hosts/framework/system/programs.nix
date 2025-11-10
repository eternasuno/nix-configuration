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
  # programs.dconf.enable = true;

  imports = [
    inputs.dankMaterialShell.nixosModules.greeter
  ];

  environment.systemPackages = [ pkgs.niri ];

  # 必须先设置 greetd 用户，dankMaterialShell.greeter 模块需要这个
  services.greetd.settings.default_session.user = username;

  programs.dankMaterialShell.greeter = {
    enable = true;
    compositor.name = "niri";
    configHome = "/home/${username}";
  };
}
