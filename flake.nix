{
  description = "My Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

		# Home-manager setup
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hyprland url flake 
    # hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    # Gruvbox GRUB theme
    tartarus-grub = {
      url = "github:AllJavi/tartarus-grub";
      flake = false;
    };

    # Nix colors for a good and easy rice
    nix-colors.url = "github:misterio77/nix-colors";

    # AGS for awesome widgets
    ags.url = "github:Aylur/ags";

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
          ];
        };
      };
    };
}
