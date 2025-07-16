_: {
  programs.firefox.policies = {
    AutofillAddressEnabled = false;
    AutofillCreditCardEnabled = false;
    DisableAppUpdate = true;
    DisableFeedbackCommands = true;
    DisableFirefoxAccounts = true;
    DisableFirefoxStudies = true;
    DisablePocket = true;
    DisableTelemetry = true;
    ExtensionSettings = {
      "adguardadblocker@adguard.com" = {
        installation_mode = "force_installed";
        install_url = "https://addons.mozilla.org/firefox/downloads/latest/adguardadblocker@adguard.com/latest.xpi";
      };
      "extension@tabliss.io" = {
        installation_mode = "force_installed";
        install_url = "https://addons.mozilla.org/firefox/downloads/latest/extension@tabliss.io/latest.xpi";
      };
    };
  };
}
