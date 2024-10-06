{ 
inputs,
pkgs,
... 
}: {
  programs = {
    dconf.enable = true;

    # Mesa drivers have to be loaded for good performance
    # see hardware.nix ./modules
    # For all the substituters see ./nixsystem.nix
    #hyprland = {
    #  enable = true;
    #  package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    #  portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    #  xwayland.enable = true;
    #  systemd.setPath.enable = true;
    #};
    
     sway = {
       enable = true;
       package = pkgs.sway;
       extraPackages = [ ];
     };

    # Enable the android-debug-bridge
    adb.enable = true; # User must be added to the "adbusers" group
  };

}
