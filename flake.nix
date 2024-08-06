{
  description = "My Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    
		# Hyprland setup
		hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

		# Home-manager setup
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { 
		self, 
		nixpkgs, 
		home-manager, 
    hyprland,
		... }: {
			nixosConfigurations = {
				mynixos = nixpkgs.lib.nixosSystem {
					system = "x86_64-linux";

					modules = [
            ./host

						hyprland.nixosModules.default
						{
							programs.hyprland.enable = true;
						}

						home-manager.nixosModules.home-manager
						{
							home-manager = {
								useGlobalPkgs = true;
								useUserPackages = true;
								extraSpecialArgs = inputs;
								users."chris" = import ./home;
							};
						}
					];
				};
			};
		};
}
