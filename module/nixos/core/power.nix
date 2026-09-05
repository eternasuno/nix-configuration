{ vars, ... }:
{
  boot.resumeDevice = vars.resumeDevice;

  services.logind.settings.Login = {
    HandlePowerKey = "suspend-then-hibernate";
    HandlePowerKeyLongPress = "poweroff";
  };

  systemd.sleep.settings.Sleep.HibernateDelaySec = "1h";
}
