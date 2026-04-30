{ vars, ... }:
let
  inherit (vars) username;
in
{
  home-manager.users.${username}.programs.niri.settings.window-rules = [
    {
      matches = [
        {
          app-id = "^firefox$";
          title = "^Picture-in-Picture$";
        }
      ];
      open-floating = true;
    }

    {
      matches = [ { app-id = "^firefox$"; } ];
      default-column-width = { proportion = 1.0; };
    }

    {
      matches = [ { app-id = "^kitty$"; } ];
      default-column-width = { proportion = 0.6; };
    }
  ];
}
