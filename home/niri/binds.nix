{ config, pkgs, ... }: {
  programs.niri.settings.binds = with config.lib.niri.actions;
    let playerctl = spawn "${pkgs.playerctl}/bin/playerctl";
    in {
      "XF86AudioMute" = {
        allow-when-locked = true;
        action.spawn =
          [ "qs" "-c" "DankMaterialShell" "ipc" "call" "audio" "mute" ];
      };
      "XF86AudioRaiseVolume" = {
        allow-when-locked = true;
        action.spawn = [
          "qs"
          "-c"
          "DankMaterialShell"
          "ipc"
          "call"
          "audio"
          "increment"
          "3"
        ];
      };
      "XF86AudioLowerVolume" = {
        allow-when-locked = true;
        action.spawn = [
          "qs"
          "-c"
          "DankMaterialShell"
          "ipc"
          "call"
          "audio"
          "decrement"
          "3"
        ];
      };
      "XF86AudioPrev" = {
        allow-when-locked = true;
        action.spawn =
          [ "qs" "-c" "DankMaterialShell" "ipc" "call" "mpris" "previous" ];
      };
      "XF86AudioPlay" = {
        allow-when-locked = true;
        action.spawn =
          [ "qs" "-c" "DankMaterialShell" "ipc" "call" "mpris" "playpause" ];
      };
      "XF86AudioNext" = {
        allow-when-locked = true;
        action.spawn =
          [ "qs" "-c" "DankMaterialShell" "ipc" "call" "mpris" "next" ];
      };
      "XF86MonBrightnessDown" = {
        allow-when-locked = true;
        action.spawn = [
          "qs"
          "-c"
          "DankMaterialShell"
          "ipc"
          "call"
          "brightness"
          "decrement"
          "10"
	  ""
        ];
      };
      "XF86MonBrightnessUp" = {
        allow-when-locked = true;
        action.spawn = [
          "qs"
          "-c"
          "DankMaterialShell"
          "ipc"
          "call"
          "brightness"
          "increment"
          "10"
	  ""
        ];
      };

      "Mod+Space".action.spawn =
        [ "qs" "-c" "DankMaterialShell" "ipc" "call" "spotlight" "toggle" ];
      "Mod+V".action.spawn =
        [ "qs" "-c" "DankMaterialShell" "ipc" "call" "clipboard" "toggle" ];
      "Mod+P".action.spawn =
        [ "qs" "-c" "DankMaterialShell" "ipc" "call" "processlist" "toggle" ];
      "Mod+Comma".action.spawn =
        [ "qs" "-c" "DankMaterialShell" "ipc" "call" "settings" "toggle" ];
      "Super+Alt+L".action.spawn =
        [ "qs" "-c" "DankMaterialShell" "ipc" "call" "lock" "lock" ];

      "Mod+Alt+Print".action.screenshot-screen = { write-to-disk = true; };
      "Mod+Print".action.screenshot-window = { write-to-disk = true; };
      "Print".action.screenshot = { show-pointer = false; };

      "Mod+Q".action = close-window;

      "Mod+Ctrl+S".action = switch-preset-column-width;

      "Mod+F".action = toggle-window-floating;
      "Mod+M".action = fullscreen-window;

      "Mod+H".action = focus-column-left;
      "Mod+L".action = focus-column-right;
      "Mod+J".action = focus-window-or-workspace-down;
      "Mod+K".action = focus-window-or-workspace-up;
      "Mod+Left".action = focus-column-left;
      "Mod+Right".action = focus-column-right;
      "Mod+Down".action = focus-workspace-down;
      "Mod+Up".action = focus-workspace-up;

      "Mod+Shift+H".action = move-column-left;
      "Mod+Shift+L".action = move-column-right;
      "Mod+Shift+K".action = move-column-to-workspace-up;
      "Mod+Shift+J".action = move-column-to-workspace-down;
      "Mod+Shift+Left".action = move-column-left;
      "Mod+Shift+Right".action = move-column-right;
      "Mod+Shift+Up".action = move-column-to-workspace-up;
      "Mod+Shift+Down".action = move-column-to-workspace-down;

      "Mod+Shift+Alt+J".action = move-column-to-monitor-down;
      "Mod+Shift+Alt+K".action = move-column-to-monitor-up;

      "Mod+T".action = spawn "foot";
      "Mod+B".action = spawn "firefox";
    };
}
