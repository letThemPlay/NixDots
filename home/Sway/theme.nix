{ pkgs, ... }:

{
  home = {
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
      package = pkgs.catppuccin-gtk.override {
        accents = [ "blue" ];
        size = "standard";
        tweaks = [ "black" "rimless" ];
        variant = "mocha";
      };
      name = "catppuccin-mocha-blue-standard+black,rimless";
    };

    iconTheme = {
      package = pkgs.tela-circle-icon-theme.override {
        circularFolder = true;
        colorVariants = [ "ubuntu" ];
      };
      name = "Tela-circle-ubuntu-dark";
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
