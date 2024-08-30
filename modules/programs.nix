{
  programs = {
    dconf.enable = true;
    zsh = {
      enable = true;
    };

    # Enable the android-debug-bridge
    adb.enable = true; # User must be added to the "adbusers" group
  };
}
