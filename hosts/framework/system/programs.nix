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

  # services.greetd = {
  #   enable = true;
  #   settings = {
  #     default_session = {
  #       command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --remember-user-session --asterisks --greeting Hello --cmd ${pkgs.niri}/bin/niri-session";
  #       user = username;
  #     };
  #   };
  # };

  programs.niri = {
    enable = true;
    package = pkgs.niri;
  };

  programs.dankMaterialShell.greeter = {
    enable = true;
    compositor.name = "niri";
    configHome = "/home/${username}";
    logs.save = true;
  };
}
