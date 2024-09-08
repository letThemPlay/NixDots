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

    extraConfig = '' 
      confirm_os_window_close 0
      background_opacity 0.8
      background_blur 3
    '';

		theme = "Gruvbox Dark Hard";
	};
}
