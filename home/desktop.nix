{
  pkgs,
  config,
  inputs,
  ...
}:
{
  imports = [
    inputs.niri.homeModules.niri
    inputs.dankMaterialShell.homeModules.dank-material-shell
    inputs.dankMaterialShell.homeModules.niri
  ];

  programs.dankMaterialShell = {
    enable = true;
    niri = {
      enableSpawn = true;
    };
  };

  programs.niri = {
    enable = true;
    package = pkgs.niri;
    settings = {
      input = {
        touchpad = {
          natural-scroll = false;
          dwt = true;
          accel-speed = 0.5;
          scroll-factor = 1.5;
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
      window-rules = [
        {
          matches = [{ app-id = "^foot$"; }];
          draw-border-with-background = false;
        }
      ];
      binds = with config.lib.niri.actions; {
        # Window management
        "Mod+Q".action = close-window;
        "Mod+F".action = maximize-column;
        "Mod+Shift+F".action = fullscreen-window;

        # Navigation
        "Mod+Left".action = focus-column-left;
        "Mod+Right".action = focus-column-right;
        "Mod+Up".action = focus-window-up;
        "Mod+Down".action = focus-window-down;
        "Mod+H".action = focus-column-left;
        "Mod+L".action = focus-column-right;
        "Mod+K".action = focus-window-up;
        "Mod+J".action = focus-window-down;

        # Moving
        "Mod+Ctrl+Left".action = move-column-left;
        "Mod+Ctrl+Right".action = move-column-right;
        "Mod+Ctrl+Up".action = move-window-up;
        "Mod+Ctrl+Down".action = move-window-down;
        "Mod+Ctrl+H".action = move-column-left;
        "Mod+Ctrl+L".action = move-column-right;
        "Mod+Ctrl+K".action = move-window-up;
        "Mod+Ctrl+J".action = move-window-down;

        # Workspaces
        "Mod+1".action = focus-workspace 1;
        "Mod+2".action = focus-workspace 2;
        "Mod+3".action = focus-workspace 3;
        "Mod+4".action = focus-workspace 4;
        "Mod+5".action = focus-workspace 5;
        "Mod+6".action = focus-workspace 6;
        "Mod+7".action = focus-workspace 7;
        "Mod+8".action = focus-workspace 8;
        "Mod+9".action = focus-workspace 9;

        # Sizing
        "Mod+R".action = switch-preset-column-width;
        "Mod+Shift+R".action = switch-preset-window-height;
        "Mod+Minus".action = set-column-width "-10%";
        "Mod+Equal".action = set-column-width "+10%";

        # Apps & System
        "Mod+T".action = spawn "foot";
        "Mod+B".action = spawn "firefox";
        
        # Screenshots
        "Print".action = spawn ["dms" "ipc" "call" "niri" "screenshot"];
        "Ctrl+Print".action = spawn ["dms" "ipc" "call" "niri" "screenshotScreen"];
        "Alt+Print".action = spawn ["dms" "ipc" "call" "niri" "screenshotWindow"];

        # DankMaterialShell Bindings
        "Mod+Space" = {
          action = spawn ["dms" "ipc" "call" "spotlight" "toggle"];
          hotkey-overlay.title = "Toggle Application Launcher";
        };
        "Mod+N" = {
          action = spawn ["dms" "ipc" "call" "notifications" "toggle"];
          hotkey-overlay.title = "Toggle Notification Center";
        };
        "Mod+Comma" = {
          action = spawn ["dms" "ipc" "call" "settings" "toggle"];
          hotkey-overlay.title = "Toggle Settings";
        };
        "Mod+P" = {
          action = spawn ["dms" "ipc" "call" "notepad" "toggle"];
          hotkey-overlay.title = "Toggle Notepad";
        };
        "Super+Alt+L" = {
          action = spawn ["dms" "ipc" "call" "lock" "lock"];
          hotkey-overlay.title = "Toggle Lock Screen";
        };
        "Mod+X" = {
          action = spawn ["dms" "ipc" "call" "powermenu" "toggle"];
          hotkey-overlay.title = "Toggle Power Menu";
        };
        "Mod+Alt+N" = {
          allow-when-locked = true;
          action = spawn ["dms" "ipc" "call" "night" "toggle"];
          hotkey-overlay.title = "Toggle Night Mode";
        };
        "Mod+V" = {
          action = spawn ["dms" "ipc" "call" "clipboard" "toggle"];
          hotkey-overlay.title = "Toggle Clipboard Manager";
        };
        "Mod+M" = {
          action = spawn ["dms" "ipc" "call" "processlist" "toggle"];
          hotkey-overlay.title = "Toggle Process List";
        };

        # Audio
        "XF86AudioRaiseVolume" = {
          allow-when-locked = true;
          action = spawn ["dms" "ipc" "call" "audio" "increment" "3"];
        };
        "XF86AudioLowerVolume" = {
          allow-when-locked = true;
          action = spawn ["dms" "ipc" "call" "audio" "decrement" "3"];
        };
        "XF86AudioMute" = {
          allow-when-locked = true;
          action = spawn ["dms" "ipc" "call" "audio" "mute"];
        };
        "XF86AudioMicMute" = {
          allow-when-locked = true;
          action = spawn ["dms" "ipc" "call" "audio" "micmute"];
        };
        "XF86AudioPlay" = {
          allow-when-locked = true;
          action = spawn ["dms" "ipc" "call" "mpris" "playPause"];
        };
        "XF86AudioPrev" = {
          allow-when-locked = true;
          action = spawn ["dms" "ipc" "call" "mpris" "previous"];
        };
        "XF86AudioNext" = {
          allow-when-locked = true;
          action = spawn ["dms" "ipc" "call" "mpris" "next"];
        };

        # Brightness
        "XF86MonBrightnessUp" = {
          allow-when-locked = true;
          action = spawn ["dms" "ipc" "call" "brightness" "increment" "5" ""];
        };
        "XF86MonBrightnessDown" = {
          allow-when-locked = true;
          action = spawn ["dms" "ipc" "call" "brightness" "decrement" "5" ""];
        };
      };
    };
  };

  home.sessionVariables = {
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    QT_QPA_PLATFORMTHEME = "gtk3";
    QT_ICON_THEME = "Adwaita";
  };
}
