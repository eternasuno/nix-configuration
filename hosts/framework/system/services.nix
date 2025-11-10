{ pkgs, vars, ... }:
let
  inherit (vars) username;
in
{
  services = {
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    # greetd = {
    #   enable = true;
    #   settings = {
    #     default_session = {
    #       command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --remember-user-session --asterisks --greeting Hello --cmd ${pkgs.niri}/bin/niri-session";
    #       user = username;
    #     };
    #   };
    # };
    upower = {
      enable = true;
      percentageLow = 20;
      percentageCritical = 5;
      percentageAction = 3;
      criticalPowerAction = "PowerOff";
    };
    openssh.enable = true;
  };
}
