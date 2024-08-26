{ pkgs, ... }:

{
  # fonts
  fonts = {
	  packages = with pkgs; [
		  # icon fonts
		  material-design-icons
		
		  # Normal Fonts
		  noto-fonts
		  noto-fonts-emoji
		
		  # Awesome-fonts
	    font-awesome	
		  # nerdfonts
		  (nerdfonts.override {fonts = [ "FiraCode" "JetBrainsMono" ]; })

      roboto
      helvetica-neue-lt-std

	  ];

    # To disable the system from using default packages
	  enableDefaultPackages = false;
	
	  # Settings default user fonts
	  fontconfig.defaultFonts = {
		  serif = [ "Noto Serif" "Noto Color Emoji" ];
		  sansSerif = [ "Noto Sans" "Noto Color Emoji" ];
		  monospace = [ "JetBrainsMono" "Noto Color Emoji" ];
		  emoji = [ "Noto Color Emoji" ];
	  };
  };
}
