{ inputs, vars, ... }:
let inherit (vars) username version;
in {
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  home-manager = {
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs vars; };
    users.${username} = {
      imports = [
        ../../home/foot.nix
        ../../home/librewolf.nix
        ../../home/niri
        ../../home/nushell.nix
        ../../home/stylix.nix
        ../../home/swayidle.nix
        ../../home/hyprlock.nix
        ../../home/waybar.nix
        ../../home/wlogout
        ../../home/xdg.nix
      ];
      home = {
        homeDirectory = "/home/${username}";
        stateVersion = version;
        username = "${username}";
      };
    };
  };
}
