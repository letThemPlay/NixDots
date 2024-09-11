{ pkgs, ... }:
{
  programs = {
    # A beautiful (if you make it) calendar
    khal = {
      enable = true;
    };

    # For effective neovim
    ripgrep = {
      enable = true;
      package = pkgs.ripgrep-all;
      arguments = [
        "--smart-case"
        "--colors=match:bg:black"
        "--colors=match:fg:magenta"
        "--colors=line:fg:green"
      ];
    };
    fd = {
      enable = true;
      package = pkgs.fd;
    };

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
        default-fg = "rgba(205,214,244,1)";
        default-bg = "rgba(30,30,46,1)";
        
        completion-bg	= "rgba(49,50,68,1)";
        completion-fg	= "rgba(205,214,244,1)";
        completion-highlight-bg = "rgba(87,82,104,1)";
        completion-highlight-fg = "rgba(205,214,244,1)";
        completion-group-bg	= "rgba(49,50,68,1)";
        completion-group-fg	= "rgba(137,180,250,1)";
        
        statusbar-fg = "rgba(205,214,244,1)";
        statusbar-bg = "rgba(49,50,68,1)";
        
        notification-bg	= "rgba(49,50,68,1)";
        notification-fg	= "rgba(205,214,244,1)";
        notification-error-bg	= "rgba(49,50,68,1)";
        notification-error-fg	= "rgba(243,139,168,1)";
        notification-warning-bg = "rgba(49,50,68,1)";
        notification-warning-fg = "rgba(250,227,176,1)";
        
        inputbar-fg	= "rgba(205,214,244,1)";
        inputbar-bg = "rgba(49,50,68,1)";
        
        recolor = true;
        recolor-lightcolor =   "rgba(30,30,46,1)";
        recolor-darkcolor	=   "rgba(205,214,244,1)";
        
        index-fg = "rgba(205,214,244,1)";
        index-bg = "rgba(30,30,46,1)";
        index-active-fg = "rgba(205,214,244,1)";
        index-active-bg = "rgba(49,50,68,1)";
        
        render-loading-bg	= "rgba(30,30,46,1)";
        render-loading-fg	= "rgba(205,214,244,1)";
        
        highlight-color = "rgba(87,82,104,0.5)";
        highlight-fg = "rgba(245,194,231,0.5)";
        highlight-active-color = "rgba(245,194,231,0.5)";
      };
    };

    # Enable imv for image viewing
    imv = {
      enable = true;
      package = pkgs.imv;
      settings = {
        options = {
          background = "#1e1e2e";
          overlay_text_color = "#cdd6f4";
          overlay_background_color = "#11111b";
        };
        aliases = {
          j = "next";
          k = "prev";
        };
      };
    };

    # Enable btop for system monitor
    btop = {
      enable = true;
      package = pkgs.btop;

      settings = {
        color_theme = "catppuccin_mocha";
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
      sl # You know it
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
