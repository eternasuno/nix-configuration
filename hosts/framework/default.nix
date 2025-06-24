host:
{ nixpkgs, ... }@inputs:
let
  vars = {
    inherit host;
    username = "eternasuno";
    email = "22316214+eternasuno@users.noreply.github.com";
    keyboardLayout = "us";
    model = "framework-13-7040-amd";
    timeZone = "Asia/Tokyo";
    version = "25.05";
  };
in
nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  specialArgs = { inherit inputs vars; };
  modules = [
    ./configuration.nix
    ./hardware-configuration.nix
  ];
}
