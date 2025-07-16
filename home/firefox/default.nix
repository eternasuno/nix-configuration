{ pkgs, ... }:
{
  imports = [
    ./policies.nix
    ./profiles.nix
  ];

  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
    languagePacks = [ "zh-CN" ];
    nativeMessagingHosts = [ pkgs.firefoxpwa ];
  };

  stylix.targets.firefox.enable = false;
}
