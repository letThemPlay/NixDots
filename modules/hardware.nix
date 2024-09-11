{ pkgs, ... }:

{
  # for Hyprland graphics rendering
  hardware = {
	  graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-compute-runtime
        intel-media-driver
        intel-vaapi-driver
        libvdpau-va-gl
      ];
    };
    bluetooth = {
      enable = true;
      powerOnBoot = false;
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
}
