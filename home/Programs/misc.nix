{ config, pkgs, ... }:
let
  themix = config.colorScheme.palette;
in 
{
  programs = {
    # For note taking
    # joplin-desktop = {
    #   enable = true;
    #   package = pkgs.joplin-desktop;
    #   sync = {
    #     target = "file-system";
    #     interval = "1d";
    #   };
    #   general.editor = "nvim";
    # };

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

      settings = {
        logo = {
          type = "kitty";
          source = "${./nixos_fastfetch.png}";
          width = 30;
          height = 15;
        };
        display = {
          separator = "->";
          constants = [
            "──────────────────────────────"
          ];
        };
        modules = [
          {
            type = "os";
            key = " ";
            keyColor = "yellow";
          }
          {
            type = "kernel";
            key = " ";
            keyColor = "red";
          }
          "host"
          "bios"
          "board"
          "chassis"
          "uptime"
          "processes"
          "packages"
          {
            type = "shell";
            key = " ";
            keyColor = "blue";
          }
          "display"
          {
            type = "wm";
            key = " ";
            keyColor = "violet";
          }
          {
            type = "theme";
            key = " ";
            keyColor = "purple";
          }
          "icons"
          {
            theme = "font";
            key = " ";
            keyColor = "lavender";
          }
          "cursor"
          {
            type = "terminal";
            key = " ";
            keyColor = "yellow";
          }
          {
            type = "cpu";
            key = " ";
            keyColor = "green";
          }
          "gpu"
          "disk"
          "wifi"
          "locale"
          "vulkan"
          "opengl"
          "opencl"
          "users"
          "sound"
        ];
      };
    };

    # Enable Zathura pdf reader
    zathura = {
      enable = true;
      package = pkgs.zathura;
      options = {
        notification-error-bg = "rgba(29,32,33,1)";
        notification-error-fg = "rgba(251,73,52,1)";
        notification-warning-bg = "rgba(29,32,33,1)" ;
        notification-warning-fg = "rgba(250,189,47,1)"   ;
        notification-bg = "rgba(29,32,33,1)" ;
        notification-fg = "rgba(184,187,38,1)"   ;

        completion-bg = "rgba(80,73,69,1)" ;
        completion-fg = "rgba(235,219,178,1)"  ;
        completion-group-bg = "rgba(60,56,54,1)" ;
        completion-group-fg = "rgba(146,131,116,1)"  ;
        completion-highlight-bg = "rgba(131,165,152,1)"  ;
        completion-highlight-fg = "rgba(80,73,69,1)" ;

        index-bg = "rgba(80,73,69,1)" ;
        index-fg = "rgba(235,219,178,1)"  ;
        index-active-bg = "rgba(131,165,152,1)"  ;
        index-active-fg = "rgba(80,73,69,1)" ;

        inputbar-bg = "rgba(29,32,33,1)" ;
        inputbar-fg = "rgba(235,219,178,1)"  ;

        statusbar-bg = "rgba(80,73,69,1)" ;
        statusbar-fg = "rgba(235,219,178,1)"  ;

        highlight-color = "rgba(250,189,47,0.5)" ;
        highlight-active-color  = "rgba(254,128,25,0.5)" ;

        default-bg = "rgba(29,32,33,1)" ;
        default-fg = "rgba(235,219,178,1)"  ;
        render-loading = true;
        render-loading-bg = "rgba(29,32,33,1)" ;
        render-loading-fg = "rgba(235,219,178,1)"  ;

        recolor-lightcolor = "rgba(29,32,33,1)" ;
        recolor-darkcolor = "rgba(235,219,178,1)"  ;
        recolor = true;
        recolor-keephue = true ;
      };
    };

    # Enable imv for image viewing
    imv = {
      enable = true;
      package = pkgs.imv;
      settings = {
        options = {
          background = "#${themix.base00}";
          overlay_text_color = "#${themix.base07}";
          overlay_background_color = "#${themix.base02}";
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
        color_theme = "gruvbox_dark_v2";
        theme_background = false;
      };
    };

    # Cava audio bars
    cava = {
      enable = true;
      package = pkgs.cava;
      settings = {
        general = {
          framerate = 60;
        };
        input = {
          method = "pipewire";
          source = "auto";
        };
        color = {
          background = "'#${themix.base00}'";
          gradient = 1;
          gradient_color_1 = "'#${themix.base0B}'";
          gradient_color_2 = "'#${themix.base0C}'";
          gradient_color_3 = "'#${themix.base0D}'";
          gradient_color_4 = "'#${themix.base0E}'";
          gradient_color_5 = "'#${themix.base07}'";
          gradient_color_6 = "'#${themix.base0A}'";
          gradient_color_7 = "'#${themix.base09}'";
          gradient_color_8 = "'#${themix.base08}'";
        };
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
      tree # you know if you know
    ];
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
