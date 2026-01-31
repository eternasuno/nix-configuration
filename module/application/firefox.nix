{ pkgs, vars, inputs, ... }:
let
  inherit (vars) username;
in
{
  home-manager.users.${username} = {
    imports = [ inputs.textfox.homeManagerModules.default ];

    textfox = {
      enable = true;
      profiles = ["default"];
      config = {
        tabs = {
          vertical.enable = false;
        };
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
        RequestedLocales = [ "zh-CN" ];
      };
      profiles.default = {
        id = 0;
        name = "default";
        isDefault = true;
        settings = {
          "intl.locale.requested" = "zh-CN";
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "svg.context-properties.content.enabled" = true;
        };
      };
    };
  };
}
