{ inputs, pkgs, ... }:
{
  imports = [
    inputs.dankMaterialShell.homeModules.dankMaterialShell.default
    inputs.dankMaterialShell.homeModules.dankMaterialShell.niri
    inputs.niri.homeModules.niri
  ];

  home.packages = with pkgs; [

  ];

  programs.dankMaterialShell = {
    enable = true;

    # Core features
    # enableSystemd = false; # Systemd service for auto-start
    # enableSystemMonitoring = true; # System monitoring widgets (dgop)
    # enableClipboard = true; # Clipboard history manager
    # enableVPN = false; # VPN management widget
    # enableBrightnessControl = true; # Backlight/brightness controls
    # enableColorPicker = true; # Color picker tool
    # enableDynamicTheming = true; # Wallpaper-based theming (matugen)
    # enableAudioWavelength = true; # Audio visualizer (cava)
    # enableCalendarEvents = false; # Calendar integration (khal)
    # enableSystemSound = true; # System sound effects

    niri = {
      enableKeybinds = true;
      enableSpawn = true;
    };
  };

  programs.niri = {
    enable = true;
    settings = {
      environment = {
        QT_QPA_PLATFORM = "wayland;xcb";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        QT_QPA_PLATFORMTHEME = "gtk3";
        QT_ICON_THEME = "Adwaita";
      };
    };
  };
}
