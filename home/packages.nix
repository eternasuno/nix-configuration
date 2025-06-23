{ pkgs, ... }: {
  home.packages = with pkgs; [ 
    cliphist 
    jaq 
    networkmanagerapplet
    pavucontrol
    playerctl 
    seatd 
    swww 
    wl-clipboard 
  ];
}
