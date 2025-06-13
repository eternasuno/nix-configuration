host:
{ nixpkgs, ... }@inputs:
let
  vars = {
    inherit host;
    username = "eternasuno";
    email = "22316214+eternasuno@users.noreply.github.com";
    keyboardLayout = "us";
    timeZone = "Asia/Tokyo";
    version = "25.05";
  };
in nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  specialArgs = { inherit inputs vars; };
  modules = [ ./hardware.nix ./home.nix ./system.nix ];
}
