let
	font = "JetBrainsMono Nerd Font";
in
{
	programs.kitty = {
		enable = true;
		font = {
			name = font;
			size = 14;
		};
		shellIntegration = {
			enableBashIntegration = true;
      enableZshIntegration = true;
		};

    # Uncomment background_opacity and background_blur to
    # Enable blur and transparency.
    extraConfig = '' 
      confirm_os_window_close 0
    '';

		theme = "Catppuccin-Mocha";
	};
}
