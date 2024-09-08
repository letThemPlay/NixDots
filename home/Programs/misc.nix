{ pkgs, ... }:
{
  programs = {

    # Enable fastfetch
    fastfetch = {
      enable = true;
      package = pkgs.fastfetch;
    };

    # Enable Zathura pdf reader
    zathura = {
      enable = true;
      package = pkgs.zathura;
      options = {
        # This is Gruvbox theming
        notification-error-bg = "#282828";
        notification-error-fg = "#fb4934";
        notification-warning-bg = "#282828";
        notification-warning-fg = "#fabd2f";
        notification-bg = "#282828";
        notification-fg = "#b8bb26";

        completion-bg = "#504945";
        completion-fg = "#ebdbb2";
        completion-group-bg = "#3c3836";
        completion-group-fg = "#928374";
        completion-highlight-bg = "#83a598";
        completion-highlight-fg = "#504945";

        index-bg = "#504945";
        index-fg = "#ebdbb2";
        index-active-bg = "#83a598";
        index-active-fg = "#504945";

        inputbar-bg = "#282828";
        inputbar-fg = "#ebdbb2";

        statusbar-bg = "#504945";
        statusbar-fg = "#ebdbb2";

        highlight-color = "#fabd2f";
        highlight-active-color = "#fe8019";
        default-bg = "#282828";
        default-fg = "#ebdbb2";
        render-loading  = true;
        render-loading-bg = "#282828";
        render-loading-fg = "#ebdbb2";

        recolor-lightcolor = "#282828";
        recolor-darkcolor = "#ebdbb2";
        recolor = true;
        recolor-keephue = true;
      };
    };

    # Enable imv for image viewing
    imv = {
      enable = true;
      package = pkgs.imv;
    };
    
    # Enable btop for system monitor
    btop = {
      enable = true;
      package = pkgs.btop;

      settings = {
        color_theme = "gruvbox_material_dark";
        theme_background = false;
      };
    };
  };

  # Other packages
  home = {
    packages = with pkgs;[
      qbittorrent
      libreoffice-fresh

      # For screensharing with android
      scrcpy # But adb must be enabled in configuration.nix. See mynixos.com

      # For development purpose
      gcc14

    ];

    # Source some files here
    file = {
      ".config/btop/themes/" = {
        source = ./../Themes/btop;
        recursive = true;
      };
    };
  };

  # Service based programs
  services = {
    # KDE Connect for mobile connection
    kdeconnect = {
      enable = true;
      indicator = true;
    };
  };
}
