{ pkgs, ... }:

{
  # for wayland graphics rendering
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

    # Printer settings (see services.printing.enable )
    # printers = {
    #   ensurePrinters = [
    #     {
    #       name = "HP_LaserJet_Professional_M1136_MFP";
    #       location = "Home";
    #       deviceUri = "usb://HP/LaserJet%20Professional%20M1136%20MFP?serial=000000000QH97FCFPR1a";
    #       ppdOptions = {
    #         PageSize = "A4";
    #       };
    #       model = "HP_LaserJet_Professional_M1136_MFP";
    #     }
    #   ];
    # };
  };
}
