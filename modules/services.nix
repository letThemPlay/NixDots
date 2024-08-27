{lib, ... }:
{
  # Enable sound and other services
  services = {
    # Enable GUI for bluetooth pairing
    blueman.enable = true;

    # Enable CUPS to print documents
    printing.enable = true;
    
    # Enable pipewire audio services
	  pipewire = {
      enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
     	alsa = {
			  enable = true;
			  support32Bit = true;
		  };
		  jack.enable = true;
   	};

    # Enable touchpad services 
	  libinput.enable = true;

    # Enable gvfs for virtual filesystem
    gvfs.enable = true;

    # Enable tumbler for thumbnailer service
    tumbler.enable = true;

    # Enable power-profiles-daemon for waybar
    power-profiles-daemon = {
      enable = true;
    };

    # Enable sddm login manager 
    displayManager.sddm = {
      enable = true;
      wayland = {
        enable = true;
      };

      # Theme settings 
      sugarCandyNix = {
        enable = true;
        settings = {
          Background = lib.cleanSource ../home/Wallpapers/houses.png;
          ScreenWidth = 1920;
          ScreenHeight = 1080;
          FormPosition = "left";
          HaveFormBackground = true;
          PartialBlur = true;
        };
      };
    };

    # Set journal size to 2g 
    journald.extraConfig = ''
      SystemMaxUse=2G
    '';

    # start udev 
    udev = {
      enable = true;
    };
  };
}
