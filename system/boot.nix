{
  pkgs,
  config,
  inputs,
  ...
}:
{
  imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];

  boot = {
    binfmt.registrations.appimage = {
      interpreter = "${pkgs.appimage-run}/bin/appimage-run";
      magicOrExtension = "\\x7fELF....AI\\x02";
      mask = "\\xff\\xff\\xff\\xff\\x00\\x00\\x00\\x00\\xff\\xff\\xff";
      offset = 0;
      recognitionType = "magic";
      wrapInterpreterInShell = false;
    };
    consoleLogLevel = 3;
    extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
    initrd.systemd.enable = true;
    kernel.sysctl = {
      "vm.max_map_count" = 2147483642;
    };
    kernelModules = [ "v4l2loopback" ];
    kernelPackages = pkgs.linuxPackages_zen;
    kernelParams = [
      "plymouth.use-simpledrm"
      "quiet"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "splash"
      "udev.log_priority=3"
    ];
    lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
    };
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = pkgs.lib.mkForce false;
        configurationLimit = 3;
      };
      timeout = 0;
    };
    plymouth = {
      enable = true;
      theme = pkgs.lib.mkForce "glitch";
      themePackages = with pkgs; [
        (adi1090x-plymouth-themes.override {
          selected_themes = [ "glitch" ];
        })
      ];
    };
    tmp.cleanOnBoot = true;
  };

  environment.systemPackages = with pkgs; [
    sbctl
  ];
}
