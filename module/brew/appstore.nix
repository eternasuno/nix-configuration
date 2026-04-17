{pkgs, ...}: {
  environment.systemPackages = [pkgs.mas];

  homebrew = {
    masApps = {
      "uBlock Origin Lite" = 6745342698;
      "Tampermonkey" = 6738342400;
    };
  };
}
