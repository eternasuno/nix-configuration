{ vars, ... }:
let
  inherit (vars) username;
in
{
  home-manager.users.${username}.programs.niri.settings.window-rules = [
    {
      matches = [{ app-id = "^foot$"; }];
      draw-border-with-background = false;
    }
  ];
}
