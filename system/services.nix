_: {
  services = {
    blueman.enable = true; # Bluetooth Support
    fprintd.enable = true;
    fwupd.enable = true;
    gnome.gnome-keyring.enable = true;
    gvfs.enable = true; # For Mounting USB & More
    libinput.enable = true; # Input Handling
    logind = {
      lidSwitch = "suspend-then-hibernate";
      powerKey = "suspend-then-hibernate";
      powerKeyLongPress = "poweroff";
    };
    openssh.enable = true; # Enable SSH
    smartd = {
      enable = true;
      autodetect = true;
    };
    tumbler.enable = true; # Image/video preview
  };
}
