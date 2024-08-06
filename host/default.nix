# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot = {
	kernelParams = [ "i915.force_probe=a7a0" ];
	loader = {
		grub = {
			enable = true;
			efiSupport = true;
			device = "nodev";
		};
			
		efi = {
			canTouchEfiVariables = true;
		};
	};
  };

  networking.hostName = "mynixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
   time.timeZone = "Asia/Kolkata";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;


  

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";


  # Enable sound.
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
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.chris = {
     isNormalUser = true;
     extraGroups = [ "wheel" "input" "video" "networkmanager" ]; # Enable ‘sudo’ for the user.
     packages = with pkgs; [
       #firefox
       tree
     ];
     shell = pkgs.zsh;
   };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     wget
     git
     gparted
     xorg.xhost
   ];

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?

  nix = {

    optimise = {
      automatic = true;
      dates = [ "03:45" ];
    };

    # Enable experimental features
  	settings = {
		  experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };

    # Enable space optimisation by setting automatic deletion of older generations
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 4d";
    };
  };

  # for Hyprland graphics rendering
  hardware = {
	  graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
        intel-vaapi-driver
        libvdpau-va-gl
      ];
    };
    bluetooth = {
      enable = true;
      package = pkgs.bluez;
      settings = {
        General = {
          Experimental = true;
        };
      };
    };

    cpu = {
      intel = {
        updateMicrocode = true;
      };
    };
  };
  
  # For hyprland, gtk and some other apps
  programs = {
	  dconf.enable = true;
	  zsh.enable = true;
  };

  # Security and hyprlock
  security = {
  	rtkit.enable = true;
	  polkit.enable = true;
	  pam.services.hyprlock = {};
  };

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

	  enableDefaultPackages = false;
	
	  # Settings default user fonts
	  fontconfig.defaultFonts = {
		  serif = [ "Noto Serif" "Noto Color Emoji" ];
		  sansSerif = [ "Noto Sans" "Noto Color Emoji" ];
		  monospace = [ "JetBrainsMono" "Noto Color Emoji" ];
		  emoji = [ "Noto Color Emoji" ];
	  };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # For hyprland functioning
  environment.sessionVariables = {
	  WLR_NO_HARDWARE_CURSORS="1";
	  NIXOS_OZONE_WL="1";
  };


  # systemd services
  systemd.user.services.mpris-proxy = {
    description = "Mpris proxy";
    after = [ "network.target" "sound.target" ];
    wantedBy = [ "default.target" ];
    serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
  };
}

