_: {
  programs.firefox = {
    enable = true;
    languagePacks = [ "zh-CN" ];
    policy = {
      "DisableAppUpdate" = true;
      "DisableFirefoxAccounts" = true;
      "DisablePocket" = true;
      "DisableTelemetry" = true;
      "DonotCheckDefaultBrowser" = true;
      "ExtensionSettings" = {
        "adguardadblocker@adguard.com" = {
          "installation_mode" = "force_installed";
          "install_url" =
            "https://addons.mozilla.org/firefox/downloads/latest/adguardadblocker@adguard.com/latest.xpi";
        };
      };
    };
    profile = {
      name = "default";
      # settings = {
      #   "browser.startup.homepage" = "https://www.google.com";
      #   "browser.startup.page" = 1; // 0: blank page, 1: homepage, 2: last visited pages
      #   "browser.tabs.loadInBackground" = true;
      #   "browser.search.defaultenginename" = "Google";
      #   "browser.search.suggest.enabled" = true;
      #   "privacy.trackingprotection.enabled" = true;
      #   "privacy.donottrackheader.enabled" = true;
      # };
    };
  };
}
