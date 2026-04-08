{
  darwin,
  home-manager,
  ...
}@inputs:
let
  vars = {
    host = "MacBook-Air";
    username = "eternasuno";
    flakePath = "/Users/eternasuno/.nix";
    email = "22316214+eternasuno@users.noreply.github.com";
    timeZone = "Asia/Tokyo";
    version = "25.05";
  };
in
{
  ${vars.host} = darwin.lib.darwinSystem {
    system = "aarch64-darwin";
    specialArgs = { inherit inputs vars; };
    modules = [
      ./configuration.nix
      home-manager.darwinModules.home-manager
    ];
  };
}
