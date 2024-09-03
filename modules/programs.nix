{ inputs, pkgs, ... }:
{
  programs = {
    dconf.enable = true;
    zsh = {
      enable = true;
    };

    # Enable hyprland here to be read by SDDM 
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    }; 

    # Enable the android-debug-bridge
    adb.enable = true; # User must be added to the "adbusers" group
  };
}
