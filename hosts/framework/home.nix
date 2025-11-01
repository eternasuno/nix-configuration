{
  inputs,
  pkgs,
  config,
  vars,
  ...
}:
let
  noctalia =
    cmd:
    [
      "noctalia-shell"
      "ipc"
      "call"
    ]
    ++ (pkgs.lib.splitString " " cmd);
in
{
  imports = [
    inputs.niri.homeModules.niri
    inputs.noctalia.homeModules.default
  ];

  home.packages = with pkgs; [
    inputs.noctalia.packages.${pkgs.system}.default
    # Screen recording tools
    grim
    slurp
    wl-clipboard
  ];

  gtk = {
    enable = true;
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    theme = {
      name = "Adwaita";
      package = pkgs.gnome-themes-extra;
    };
  };

  programs = {
    firefox = {
      enable = true;
      package = pkgs.firefox;
    };

    niri = {
      enable = true;
      package = pkgs.niri;
      settings = {
        spawn-at-startup = [ { command = [ "noctalia-shell" ]; } ];

        binds = with config.lib.niri.actions; {
          "Mod+Space".action.spawn = noctalia "launcher toggle";
          "Mod+S".action.spawn = noctalia "controlCenter toggle";
          "Mod+Comma".action.spawn = noctalia "settings toggle";

          "Mod+V".action.spawn = noctalia "launcher clipboard";
          "Mod+C".action.spawn = noctalia "launcher calculator";
          "Mod+L".action.spawn = noctalia "lockScreen lock";

          "XF86AudioLowerVolume".action.spawn = noctalia "volume decrease";
          "XF86AudioRaiseVolume".action.spawn = noctalia "volume increase";
          "XF86AudioMute".action.spawn = noctalia "volume muteOutput";
          "XF86MonBrightnessUp".action.spawn = noctalia "brightness increase";
          "XF86MonBrightnessDown".action.spawn = noctalia "brightness decrease";

          "Mod+T".action.spawn = "foot";
        };

        environment = {
          QT_QPA_PLATFORM = "wayland;xcb";
          QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
          QT_QPA_PLATFORMTHEME = "gtk3";
          QT_ICON_THEME = "Adwaita";
        };
      };
    };

    foot = {
      enable = true;
    };

    git = {
      enable = true;
      userName = "${vars.username}";
      userEmail = "${vars.email}";
    };

    noctalia-shell = {
      enable = true;
    };

    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };

  };

  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5 = {
      addons = with pkgs; [
        fcitx5-rime
      ];
      waylandFrontend = true;
    };
  };

  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      desktop = "${config.home.homeDirectory}/Desktop";
      documents = "${config.home.homeDirectory}/Documents";
      download = "${config.home.homeDirectory}/Download";
      music = "${config.home.homeDirectory}/Music";
      pictures = "${config.home.homeDirectory}/Pictures";
      publicShare = "${config.home.homeDirectory}/Public";
      templates = "${config.home.homeDirectory}/Templates";
      videos = "${config.home.homeDirectory}/Videos";
    };
    portal = {
      enable = true;
      config = {
        common = {
          default = [
            "gnome"
            "gtk"
          ];
          "org.freedesktop.impl.portal.ScreenCast" = "gnome";
          "org.freedesktop.impl.portal.Screenshot" = "gnome";
          "org.freedesktop.impl.portal.RemoteDesktop" = "gnome";
        };
      };
      xdgOpenUsePortal = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gnome
        xdg-desktop-portal-gtk
      ];
    };
  };
}
