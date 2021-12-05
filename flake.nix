{
	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		home-manager.url = "github:nix-community/home-manager";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";
	};

	outputs = { self, nixpkgs, home-manager, ... }@inputs:
		{
			nixosConfigurations = {
				aspire = nixpkgs.lib.nixosSystem {
					system = "x86_64-linux";
					modules = [
						(import ./config/common.nix inputs)
						./config/aspire.nix
						./config/aspire_hardware.nix
					];
				};
			};

			customPkgs = import ./pkg;
			secrets = import ./secrets/secrets.nix;
		};
}
