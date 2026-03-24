host:
{
  darwin,
  home-manager,
  ...
}@inputs:
let
  vars = {
    inherit host;
    username = "eternasuno";
    email = "22316214+eternasuno@users.noreply.github.com";
    keyboardLayout = "us";
    timeZone = "Asia/Tokyo";
    version = "25.05";
  };
in
darwin.lib.darwinSystem {
  system = "aarch64-darwin";
  specialArgs = { inherit inputs vars; };
  modules = [
    ./configuration.nix
    home-manager.darwinModules.home-manager
  ];
}
