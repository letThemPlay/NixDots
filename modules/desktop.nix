{ 
pkgs,
... 
}: {
  programs = {
    dconf.enable = true;
    
     sway = {
       enable = true;
       package = pkgs.sway;
       extraPackages = [ ];
     };

    # Enable the android-debug-bridge
    adb.enable = true; # User must be added to the "adbusers" group
  };

}
