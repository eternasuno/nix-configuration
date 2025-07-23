{
  config,
  lib,
  pkgs,
  ...
}:
{
  boot = {
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
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = lib.mkDefault true;
        configurationLimit = 3;
      };
      timeout = 0;
    };
    plymouth = {
      enable = true;
      theme = "glitch";
      themePackages = with pkgs; [
        (adi1090x-plymouth-themes.override {
          selected_themes = [ "glitch" ];
        })
      ];
    };
    tmp.cleanOnBoot = true;
  };
}
