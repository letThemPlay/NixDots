{ inputs, ... }:
{
	imports = [
    inputs.nix-colors.homeManagerModules.default
		./Programs
     ./Sway

    # Import the xdg settings here (makes file managers know which folder is meant for what )
    ./xdgSettings.nix
	];

  colorScheme = inputs.nix-colors.colorSchemes.gruvbox-material-dark-hard;
	
	home = {
		username = "chris";
		homeDirectory = "/home/chris";

		stateVersion = "24.11";
	};

	programs.home-manager.enable = true;
}
