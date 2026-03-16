{ pkgs, vars, inputs, ... }:
let
  inherit (vars) username;
in
{
  environment.sessionVariables = {
    BROWSER = "${pkgs.firefox}/bin/firefox";
  };

  home-manager.users.${username} = {
    imports = [ inputs.textfox.homeManagerModules.default ];

    textfox = {
      enable = true;
      profiles = ["default"];
      config = {
        tabs = {
          vertical.enable = false;
        };
        displayTitles = false;
        displayUrlbarIcons = true;
      };
    };

    programs.firefox = {
      enable = true;
      package = pkgs.firefox;
      policies = {
        AutofillAddressEnabled = false;
        AutofillCreditCardEnabled = false;
        DisableFirefoxAccounts = true;
        DisableAppUpdate = true;
        DisableTelemetry = true;
        DontCheckDefaultBrowser = true;
        ExtensionSettings = {
          "extension@tabliss.io" = {
            installation_mode = "force_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/extension@tabliss.io/latest.xpi";
          };
          "uBlock0@raymondhill.net" = {
            installation_mode = "force_installed";
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/uBlock0@raymondhill.net/latest.xpi";
          };
        };
        RequestedLocales = [ "zh-CN" ];
      };
      profiles.default = {
        id = 0;
        name = "default";
        isDefault = true;
        search = {
          force = true;
          default = "ddg";
        };
        settings = {
          "intl.locale.requested" = "zh-CN";
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "svg.context-properties.content.enabled" = true;
          "font.size.variable.x-western" = 18;
          "font.size.monospace.x-western" = 16;
          "font.minimum-size.x-western" = 14;
        };
      };
    };
  };
}
