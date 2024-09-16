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
      noto-fonts-cjk
		
		  # Awesome-fonts
	    font-awesome	
		  # nerdfonts
		  (nerdfonts.override {fonts = [ "FantasqueSansM" ]; })
	  ];

    # To disable the system from using default packages
	  enableDefaultPackages = false;

    # Settings default user fonts
    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "Noto Serif" ];
        sansSerif = [ "FantasqueSansM" ];
        monospace = [ "FantasqueSansM" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
