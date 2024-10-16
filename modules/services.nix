{ pkgs, ... }:

{
  # Enable sound and other services
  services = {
    # IDK why zathura complained of missing this....
    avahi = {
      enable = true;
    };
    # Enable CUPS to print documents
    # hardware.printing in the hardware.nix
    # printing = {
    #   enable = true;
    #   drivers = with pkgs; [
    #     hplip
    #     hplipWithPlugin
    #   ];
    # };

    # Enable pipewire audio services
    pipewire = {
      enable = true;
      package = pkgs.pipewire;
      audio.enable = true;
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

    # For greetd tuigreet greeter
    greetd = {
      enable = true;
      vt = 1;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway";
          user = "greeter";
        };
      };
    };
  };
}
