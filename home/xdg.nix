{ config, ... }: {
  xdg = {
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
    mimeApps = {
      enable = true;
      defaultApplications = {
        # "text/html" = "firefox.desktop";
        # "x-scheme-handler/http" = "firefox.desktop";
        # "x-scheme-handler/https" = "firefox.desktop";
        # "application/pdf" = "org.gnome.Evince.desktop";
        # "image/jpeg" = "org.gnome.eog.desktop";
        # "video/mp4" = "mpv.desktop"; 
        # "inode/directory" = "org.gnome.Nautilus.desktop";
      };
    };
  };
}
