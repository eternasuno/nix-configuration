{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    networkmanagerapplet
    sbctl
    git
    neovim

  ];
}
