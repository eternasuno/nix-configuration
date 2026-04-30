{vars, ...}: let
  inherit (vars) username;
in {
  users.users.${username} = {
    home = "/Users/${username}";
  };

  security.pam.services.sudo_local.touchIdAuth = true;

  system.defaults = {
    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      AppleShowAllExtensions = true;
      "com.apple.mouse.tapBehavior" = 1;
      "com.apple.keyboard.fnState" = true;
      InitialKeyRepeat = 15;
      KeyRepeat = 2;
    };

    dock = {
      autohide = true;
      show-recents = false;
      mru-spaces = false;
      orientation = "bottom";
      show-process-indicators = false;
    };

    finder = {
      AppleShowAllFiles = true;
      _FXShowPosixPathInTitle = true;
      FXPreferredViewStyle = "Nlsv";
      ShowPathbar = true;
      ShowStatusBar = true;
    };

    trackpad = {
      Clicking = true;
      TrackpadRightClick = true;
      TrackpadThreeFingerDrag = true;
    };

    loginwindow = {
      GuestEnabled = false;
    };
  };
}
