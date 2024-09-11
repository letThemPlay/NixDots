{ inputs, ... }:
{
	imports = [
    inputs.nix-colors.homeManagerModules.default
		./Programs
    #./Hyprland
    ./Sway
	];

  colorScheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;
	
	home = {
		username = "chris";
		homeDirectory = "/home/chris";

		stateVersion = "24.11";
	};

	programs.home-manager.enable = true;
}
