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
      size = 25;
    };
  };

  # GTK theming for apps
  gtk = {
    enable = true;

    theme = {
      package = pkgs.gruvbox-gtk-theme.override {
        colorVariants = [ "dark" ];
        sizeVariants = [ "standard" ];
        themeVariants = [ "default" ];
        tweakVariants = [
          "black"
          "outline"
        ];
        iconVariants = [ "Dark" ];
      };
      name = "Gruvbox-Dark";
    };

    iconTheme = {
      package = pkgs.gruvbox-plus-icons;
      name = "Gruvbox-Plus-Dark";
    };

    font = {
      name = "FantasqueSansMono Nerd Font Mono";
      size = 12;
    };
  };

  # Enable qt theming and match it with gtk
  qt = {
    enable = true;
    platformTheme.name = "gtk";
  };
}
