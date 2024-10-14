{ 
config, 
inputs, 
pkgs, 
lib, 
... 
}: let
  themix = config.colorScheme.palette;
in { 
  programs = {
    # A better 'cat' clone 
    bat = {
      enable = true;
      themes = {
        gruvbox-material-bat = {
          src = inputs.gruvbox-bat;
          file = "gruvbox-material-dark.tmTheme";
        };
      };
      config = {
        theme = "gruvbox-material-bat";
      };
      extraPackages = lib.mkForce [];
    };
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
        notification-error-bg  =     "#32302f"; # bg0
        notification-error-fg      = "#${themix.base08}"; # red
        notification-warning-bg    = "#32302f"; # bg0
        notification-warning-fg    = "#${themix.base0A}"; # yellow
        notification-bg            = "#32302f"; # bg0
        notification-fg            = "#${themix.base0B}"; # green

        completion-bg              = "#3c3836"; # bg2
        completion-fg              = "#d4be98"; # fg0
        completion-group-bg        = "#3c3836"; # bg1
        completion-group-fg        = "#928374"; # gray
        completion-highlight-bg    = "#${themix.base0D}"; # blue
        completion-highlight-fg    = "#3c3836"; # bg2
        
        # define the color in index mode
        index-bg                   = "#3c3836"; # bg2
        index-fg                   = "#d4be98"; # fg0
        index-active-bg            = "#${themix.base0D}"; # blue
        index-active-fg            = "#3c3836"; # bg2
        
        inputbar-bg                = "#3c3836"; # bg2
        inputbar-fg                = "#d4be98"; # fg0
        
        statusbar-bg               = "#3c3836"; # bg2
        statusbar-fg               = "#d4be98"; # fg0
        
        highlight-color            = "rgba(216, 166, 87, 0.5)"; # yellow
        highlight-active-color     = "rgba(231, 138, 78, 0.69)"; # orange
        highlight-fg = "#${themix.base00}";

        default-bg                 = "#${themix.base03}"; # bg3
        default-fg                 = "#${themix.base05}"; # fg1
        render-loading             = true;
        render-loading-bg          = "#32302f"; # bg0
        render-loading-fg          = "#d4be98"; # fg0

        # recolor book content's co=lor
        recolor-lightcolor         = "#${themix.base00}"; # bg0
        recolor-darkcolor          = "#d4be98"; # fg0
        recolor                    = true;
          recolor-keephue            = true;      # keep original color
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

    # Cava audio bars
    cava = {
      enable = true;
      package = pkgs.cava;
      settings = {
        general = {
          framerate = 60;
        };
        input = {
          method = "pipeire";
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
  xdg.configFile = {
    "xfce4/helpers.rc".source = ./thunarHelpers.rc; # See /etc/nixos/modules/thunar.nix
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
