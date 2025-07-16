_: {
  programs.firefox.profiles."default" = {
    isDefault = true;
    settings = {
      "browser.ctrlTab.sortByRecentlyUsed" = true;
      "intl.accept_languages" = [
        "zh-CN"
        "en-US"
      ];
      "svg.context-properties.content.enabled" = true;
      "sidebar.main.tools" = [
        "bookmarks"
        "history"
      ];
      "sidebar.verticalTabs" = true;
      "sidebar.visibility" = "expand-on-hover";
      "tabs.browser.tabs.allow_transparent_browser" = true;
      "tabs.browser.tabs.closeWindowWithLastTab" = false;
      "tabs.warnOnClose" = true;
      "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
    };
  };
}
