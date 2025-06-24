{ pkgs, ... }:
{
  services.desktopManager = {
    cosmic = {
      enable = true;
      excludePackages = with pkgs; [
        cosmic-term
        cosmic-edit
        cosmic-store
      ];
    };
    cosmic-greeter = {
      enable = true;
    };
  };
}
