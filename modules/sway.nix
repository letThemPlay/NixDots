{ 
#inputs,
  pkgs,
  ... 
}:
{
  programs = {
    dconf.enable = true;
    zsh = {
      enable = true;
    };

    sway = {
      enable = true;
      package = pkgs.sway;
      extraPackages = [ ];
    };

    # Enable the android-debug-bridge
    adb.enable = true; # User must be added to the "adbusers" group
  };

  # The xdg settings are in ./home/Sway/xdgSettings.nix
  xdg = {
    portal = {
      enable = true;
      wlr = {
        enable = true;
      };
    };
  };
}
