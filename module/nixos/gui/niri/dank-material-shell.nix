{
  inputs,
  vars,
  ...
}: let
  inherit (vars) username;
in {
  programs.niri.enable = true;

  home-manager.users.${username} = {
    imports = [
      inputs.dankMaterialShell.homeModules.dank-material-shell
      inputs.dankMaterialShell.homeModules.niri
    ];

    programs.dank-material-shell = {
      enable = true;
      enableCalendarEvents = false;
      systemd = {
        enable = true;
        restartIfChanged = true;
      };
      niri = {
        #enableKeybinds = true;
        includes = {
          enable = true;
          override = true;
          originalFileName = "hm";
          filesToInclude = [
            "alttab"
            "binds"
            "colors"
            "cursor"
            "layout"
            "outputs"
            "windowrules"
            "wpblur"
          ];
        };
      };
    };
  };
}
