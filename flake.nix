{
  description = "My Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    
		# Hyprland setup
		hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    # Hy3 plugin for sway like tiling in hyprland
    #hy3 = {
    #  url = "github:outfoxxed/hy3";
    #  inputs.hyprland.follows = "hyprland";
    #};

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

    # Nix colors for a good and easy rice
    # nix-colors.url = "github:misterio77/nix-colors";

    # Neovim toggleterm plugin by akinsho
    plugin-terminal = {
      url = "github:akinsho/toggleterm.nvim";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    sddm-sugar-candy-nix,
    ...}@inputs: {
      nixosConfigurations = {
        mynixos = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {inherit inputs;};

					modules = [
            ./host

						home-manager.nixosModules.home-manager
						{
							home-manager = {
								useGlobalPkgs = true;
								useUserPackages = true;
								extraSpecialArgs = {inherit inputs;};
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
