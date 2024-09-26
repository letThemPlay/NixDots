{lib, pkgs, ... }:
{
  # Enable sound and other services
  services = {
    # IDK why zathura complained of missing this....
    avahi = {
      enable = true;
    };
    # Enable CUPS to print documents
    # hardware.printing in the hardware.nix
    printing = {
      enable = true;
      drivers = with pkgs; [
        hplip
        hplipWithPlugin
      ];
    };
    
    # Enable pipewire audio services
	  pipewire = {
      enable = true;
      pulse.enable = true;
      wireplumber = {
        enable = true;
        package = pkgs.wireplumber;
      };
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
          Background = lib.cleanSource ../home/Wallpapers/village.jpg;
          ScreenWidth = 1920;
          ScreenHeight = 1080;
          FormPosition = "left";
          HaveFormBackground = true;
          PartialBlur = true;
          FullBlur = false;
          Font = "Iosevka Nerd Font";
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

    # Enable thermald for intel cpus 
    thermald = {
      enable = true;
    };
  };
}
