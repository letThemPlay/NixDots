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
}
