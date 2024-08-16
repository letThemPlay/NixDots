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

    # Sddm sugar candy
    sddm-sugar-candy-nix = {
      url = "gitlab:Zhaith-Izaliel/sddm-sugar-candy-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    hyprland,
    sddm-sugar-candy-nix,
    ...}@inputs: {
      nixosConfigurations = {
        mynixos = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {inherit inputs;};

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

            # for sddm
            sddm-sugar-candy-nix.nixosModules.default
            {
              nixpkgs = {
                overlays = [
                  sddm-sugar-candy-nix.overlays.default
                ];
              };
            }
					];
				};
			};
		};
}
