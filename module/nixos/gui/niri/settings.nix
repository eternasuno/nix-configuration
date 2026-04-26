{ pkgs, inputs, vars, ... }:
let
  inherit (vars) username;
in
{
  programs.niri.enable = true;

  home-manager.users.${username} = {
    imports = [
      inputs.niri.homeModules.niri
    ];

    programs.niri = {
      enable = true;
      package = pkgs.niri;
      settings = {
        input = {
          touchpad = {
            natural-scroll = false;
            dwt = true;
            accel-speed = 0.2;
            scroll-factor = 1.0;
          };
          mouse.natural-scroll = false;
        };
        hotkey-overlay.skip-at-startup = true;
        layout = {
          background-color = "#00000000";
        };
        layer-rules = [
          {
            matches = [{ namespace = "^quickshell$"; }];
            place-within-backdrop = true;
          }
        ];
      };
    };
  };
}
