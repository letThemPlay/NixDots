{
  description = "My Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    stable.url = "github:nixos/nixpkgs/nixos-24.05";

    # Home-manager setup
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Gruvbox GRUB theme
    tartarus-grub = {
      url = "github:AllJavi/tartarus-grub";
      flake = false;
    };

    # Gruvy Bat
    gruvbox-bat = {
      url = "github:molchalin/gruvbox-material-bat";
      flake = false;
    };

    # Nix colors for a good and easy rice
    nix-colors.url = "github:misterio77/nix-colors";

    # Neovim toggleterm plugin by akinsho
    plugin-terminal = {
      url = "github:akinsho/toggleterm.nvim";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import inputs.nixpkgs {
        inherit system;

        config = {
          allowUnfree = true;
          allowBroken = true;
        };

        overlays = [
          (import ./overlays)
        ];
      };
    in
    {
      nixosConfigurations = {
        mynixos = nixpkgs.lib.nixosSystem {
          inherit system pkgs;
          specialArgs = {
            inherit inputs;
          };

          modules = [
            ./host

            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = {
                  inherit inputs;
                };
                users."chris" = import ./home;
              };
            }
          ];
        };
      };
    };
}
