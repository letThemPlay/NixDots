{ pkgs, ...}:

{
  home.packages = with pkgs;
  [
    # vlc media player
    vlc
  ];

  # For media player hot-keys.
  # See hyprland.nix keybinds
  services = {
    playerctld = {
      enable = true;
      package = pkgs.playerctl;
    };
  };

  # Here goes mpv and mpd
  programs = {
    mpv = {
      enable = true;

      # Config options
      config = {
        sub-auto = "fuzzy";
        sub-font = "Iosevka Nerd Font";
        profile = "high-quality";
        video-sync = "display-resample";
      };

      # Run mpris script
      scripts = with pkgs.mpvScripts; [
        mpris
      ];
    };
  };
}
