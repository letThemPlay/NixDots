{ pkgs, ... }:

{

  home = {
    # Define packages to install here
    packages = with pkgs; [
      brightnessctl
      libnotify

      # The whole hyprland ecosystem
      #hyprcursor # for amazing mouse cursors
      #hyprpicker # for color picking

      # For clipboard management
      wl-clipboard # Clip hist uses this

      # For Bluetooth gui and tui
      bluetuith # TUI
      overskride # GUI

      # For screenshot utility
      grimblast

      # For Pipewire volume control
      # See services in /etc/nixos/modules
      pwvucontrol
    ];

    # Declare session variables for Hyprland here
    sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1";
      EDITOR = "nvim";
    };

    # cursor settings
    pointerCursor = {
      gtk.enable = true;
      # x11.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 20;
    };
  };

  # GTK theming for apps
  gtk = {
    enable = true;

    theme = {
      package = pkgs.magnetic-catppuccin-gtk;
      name = "Catppuccin-GTK-Dark";
    };

    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };

    font = {
      name = "FantasqueSansMono Nerd Font Mono";
      size = 13;
    };
  };

  # Enable qt theming and match it with gtk
  qt = {
    enable = true;
    platformTheme.name = "gtk";
  };
}
