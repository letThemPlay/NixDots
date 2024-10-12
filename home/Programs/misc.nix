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
          width = 35; # Width should be greater than the height
          height = 15; # Height should be 20 less that the width
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
            keyColor = "magenta";
          }
          {
            type = "kernel";
            key = " ";
            keyColor = "blue";
          }
          {
            type = "host";
            key = " ";
            keyColor = "magenta";
          }
          {
            type = "bios";
            key = "BIOS 󰒔 ";
            keyColor = "blue";
          }
          "board"
          "chassis"
          "uptime"
          "processes"
          {
            type = "packages";
            key = " ";
            keyColor = "blue";
          }

          {
            type = "shell";
            key = " ";
            keyColor = "magenta";
          }
          "display"
          {
            type = "wm";
            key = " ";
            keyColor = "blue";
          }
          {
            type = "wmtheme";
            key = "THEME ^|";
            keyColor = "magenta";
          }
            
          {
            type = "theme";
            key = " ";
            keyColor = "blue";
          }
          {
            type = "icons";
            key = " ";
            keyColor = "cyan";
          }
          {
            type = "font";
            key = " ";
            keyColor = "cyan";
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
      package = pkgs.zathura.override {
        useMupdf = true;
      };
      mappings = {
        "[normal] j" = "feedkeys <C-Down>";
        "[normal] k" = "feedkeys <C-Up>";
      };
      options = {
         default-fg               = "rgba(205,214,244,1)";
         default-bg 			        =  "rgba(30,30,46,1)";
         completion-bg		        =  "rgba(49,50,68,1)";
         completion-fg		        =  "rgba(205,214,244,1)";
         completion-highlight-bg	=  "rgba(87,82,104,1)";
         completion-highlight-fg	=  "rgba(205,214,244,1)";
         completion-group-bg		  =  "rgba(49,50,68,1)";
         completion-group-fg		  =  "rgba(137,180,250,1)";
         statusbar-fg		          ="rgba(205,214,244,1)";
         statusbar-bg		          ="rgba(49,50,68,1)";
         notification-bg		      =  "rgba(49,50,68,1)";
         notification-fg		      =  "rgba(205,214,244,1)";
         notification-error-bg	  =  "rgba(49,50,68,1)";
         notification-error-fg	  =  "rgba(243,139,168,1)";
         notification-warning-bg	=  "rgba(49,50,68,1)";
        notification-arning-fg	=  "rgba(250,227,176,1)";
        inputbar-fg			        =  "rgba(205,214,244,1)";
        inputbar-bg 		          = "rgba(49,50,68,1)";
        recolor                  = true;
        recolor-lightcolor		    ="rgba(30,30,46,1)";
        recolor-darkcolor		    =  "rgba(205,214,244,1)";
        index-fg			            ="rgba(205,214,244,1)";
        index-bg			            ="rgba(30,30,46,1)";
        index-active-fg		      =  "rgba(205,214,244,1)";
        index-active-bg		      =  "rgba(49,50,68,1)";
        render-loading-bg		    =  "rgba(30,30,46,1)";
        render-loading-fg		    =  "rgba(205,214,244,1)";
        highlight-color		      =  "rgba(87,82,104,0.5)";
        highlight-fg             = "rgba(245,194,231,0.5)";
        highlight-active-color	  ="rgba(245,194,231,0.5)";
      };
    };

    # Enable imv for image vieing
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
        color_theme = "catppuccin_mocha"; # See below for xdg.configFile
        theme_background = true;
        vim_keys = true;
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

  # Calling btop config file from here
  xdg.configFile."btop/themes" = {
    recursive = true;
    source = ./Themes/Btop;
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

      bluetuith # TUI for bluetooth

      # For Pipewire volume control
      # See services in /etc/nixos/modules
      pwvucontrol

      nix-tree # to identify the paths of unwanted (and wanted) stuff thanks to Whovian9369 on reddit

      gnome-clocks # The clock app
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
