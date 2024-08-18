{ pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    # Settings 
    settings = {
      monitor = ",highrr, auto, 1";
      "$mod" = "SUPER";
      "$term" = "kitty";
      "$menu" = "wofi --show drun";
      exec-once = [
        "waybar &"

        # Wallpaper daemon executes
        "hyprpaper &"

        # Start clipboard
        "wl-paste --watch cliphist store" # Stores only text data

        # for Gnome Polkit Agent
        "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1 &"

        # For Screen Sharing 
        "${pkgs.xdg-desktop-portal-hyprland}/libexec/xdg-desktop-portal-hyprland &"
      ];

      # Input settings
      input = {
        sensitivity = 0;
        follow_mouse = true;
        touchpad = {
          natural_scroll = true;
        };
      };

      # Decoration time
      general = {
        gaps_in = 5;
        gaps_out = 20;
        border_size = 2;
        no_border_on_floating = true;
        layout = "dwindle";
        "col.active_border" = "rgba(b8bb26ee) rgba(98971aee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        allow_tearing = false;
      };

      misc = {
        vfr = true;
        disable_hyprland_logo = false;
        disable_splash_rendering = false;
        mouse_move_enables_dpms = true;
        enable_swallow = true;
        swallow_regex = "^(kitty)$";
      };

      decoration = {
        # Rounded corners
        rounding = 5;

        # Opacity
        active_opacity = 1.0;
        inactive_opacity = 0.912;

        # Blur effects
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          new_optimizations = true;
          ignore_opacity = true;
          vibrancy = 0.1696;
        };

        drop_shadow = true;
        shadow_ignore_window = true;
        shadow_offset = "2 2";
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "0x66000000";

        blurls = [
          "gtk-layer-shell"
          "waybar"
          "lockscreen"
          "wofi -S drun"
        ];
      };

      # Animations
      animations = {
        enabled = true;
        bezier = [
          "overshot, 0.05, 0.9, 0.1, 1.05"
          "smoothOut, 0.36, 0, 0.66, -0.56"
          "smoothIn, 0.25, 1, 0.5, 1"
        ];

        animation = [
          "windows, 1, 5, overshot, slide"
          "windowsOut, 1, 4, smoothOut, slide"
          "windowsMove, 1, 4, default"
          "border, 1, 10, default"
          "fade, 1, 10, smoothIn"
          "fadeDim, 1, 10, smoothIn"
          "workspaces, 1, 6, default"
        ];
      };

      # layouts
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      # Windowrules
      windowrulev2 = "suppressevent maximize, class:.*";

      # Before configuring this see the switch name using "hyprctl devices"
      # Lid closing and opening 
      bindl = [
        " , switch:[Lid], exec, hyprlock"
        " , switch:on:[Lid], exec, hyprctl keyword monitor"
        " , switch:off:[Lid], exec, hyprctl keyword monitor"
      ];

      # Mouse bindings to move windows around
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      # Keybindings
      bind = [

        # PRESS WHEN DESPERATELY NEEDED
        "$mod, M, exit,"
        #############################
        "$mod, I, exec, firefox"
        "$mod, Return, exec, $term"
        "$mod, D, exec, $menu"

        # Killactive
        "$mod, Q, killactive"

        # Move focus around
        "$mod, H, movefocus, l"
        "$mod, L, movefocus, r"
        "$mod, J, movefocus, d"
        "$mod, K, movefocus, u"

        # Move windows around in a workspace
        "$mod SHIFT, J, movewindow, d"
        "$mod SHIFT, K, movewindow, u"
        "$mod SHIFT, H, movewindow, l"
        "$mod SHIFT, L, movewindow, r"

        # Open a workspace 
        "$mod, 1, workspace, 1"	
        "$mod, 2, workspace, 2"	
        "$mod, 3, workspace, 3"	
        "$mod, 4, workspace, 4"	
        "$mod, 5, workspace, 5"	
        "$mod, 6, workspace, 6"	
        "$mod, 7, workspace, 7"	
        "$mod, 8, workspace, 8"	
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"

        # special workspace
        "$mod, grave, togglespecialworkspace, magic"
        "$mod SHIFT, grave, movetoworkspace, special:magic"

        # To move workspace right and left
        "$mod, P, workspace, e+1"
        "$mod, O, workspace, e-1"

        # Toggle floating
        "$mod, V, togglefloating"
        # Toggle fullscreen
        "$mod, F, fullscreen, 0"

        # Toggle split
        "$mod, S, togglesplit"

        # Tabbed
        "$mod, G, togglegroup"
        "$mod, tab, changegroupactive"

        # Multimedia
        ", XF86AudioRaiseVolume, exec, ~/.config/hypr/scripts/volume --inc" # for raising volume
        ", XF86AudioLowerVolume, exec, ~/.config/hypr/scripts/volume --dec" # for lowering volume
        ", XF86AudioMute, exec, ~/.config/hypr/scripts/volume --toggle" # for muting

        # For brightness level
        ",XF86MonBrightnessDown, exec, ~/.config/hypr/scripts/backlight --dec" # Lower the brightness
        ",XF86MonBrightnessUp, exec, ~/.config/hypr/scripts/backlight --inc" # increase the brightness

        # Media player hot-keys
        ",XF86AudioPlay, exec, playerctl play-pause"
        ",XF86AudioNext, exec, playerctl next"
        ",XF86AudioPrev, exec, playerctl previous"

        # To lock the screen before shutting off the screen
        "$mod, X, exec, bash -c \"systemctl suspend && hyprlock\""

        # For opening the clipboard
        "$mod, C, exec, cliphist list | wofi -S dmenu | cliphist decode | wl-copy"
      ]
      ++ (
          # workspaces
          # binds $mod + [Shift +] {1,2, ... 10} to move to workspace {1 ... 10}
          builtins.concatLists (builtins.genList (
            x: let
              ws = let
                c = (x + 1) / 10;
            in
              builtins.toString (x + 1 - (c * 10));
              in [
                "$mod, $(ws), workspace, ${toString (x + 1)}"
                "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
              ]
            )
        10)
      );

      env = [
        "HYPRCURSOR_THEME,Bibata-Modern-Classic"
        "HYPRCURSOR_SIZE,24"
      ];

      cursor = {
        enable_hyprcursor = true;
      };
    };


    # Submaps need to be written in a specific way, that's why they go to the extraConfig section
    # Before assigning any keybind here, check the above written ones first
    extraConfig = ''
      ${builtins.readFile(./hypr/submaps.conf)}
    '';

    systemd = {
      enable = true;
      variables = ["--all"];
    };
  };

  services = {

    # for wallpaper
    hyprpaper = {
    	enable = true;
    	package = pkgs.hyprpaper;

      importantPrefixes = [
        "$"
      ];

      settings = {
        ipc = "off";
        splash = false;
        splash_offset = 2.0;

        preload = [
          "/home/chris/Pictures/Wallpapers/gruvbox_astro.jpg"
        ];

        wallpaper = [
          "eDP-1, /home/chris/Pictures/Wallpapers/gruvbox_astro.jpg"
        ];
      };
    };

    # Idle daemon
    hypridle = {
      enable = true;
      package = pkgs.hypridle;
      settings = {
        general = {
          lock_cmd = "pidof hyprlock || hyprlock";
          before_sleep_cmd = "loginctl lock-session";
          after_sleep_cmd = "hyprctl dispatch dpms on";
        };

        listener = [
          {
            timeout = 150;
            on-timeout = "brightnessctl -s set 10";
            on-resume = "brightnessctl -r";
          }

          {
            timeout = 150;
            on-timeout = "brightnessctl -sd rgb:kbd_backlight set 0";
            on-resume = "brightnessctl -rd rgb:kbd_backlight";
          }

          {
            timeout = 300;
            on-timeout = "loginctl lock-session";
          }

          {
            timeout = 1800;
            on-timeout = "systemctl suspend";
          }
        ];
      };
    };


    # setting up the wlsunset service
    wlsunset = {
      enable = true;
      sunrise = "06:00";
      sunset = "18:00";
    };

    # for notification
    mako = {
      enable = true;
      font = "JetBrainsMono 10";

      # Enable icons
      icons = true;

      # Timeout settings
      defaultTimeout = 500;

      # Udiskie has very low timeout so set this
      ignoreTimeout = true;

      # Configuring the look
      backgroundColor = "#d79921";
      textColor = "#1d2021";
      borderColor = "#ebdbb2";
      progressColor = "over #ebdbb2";
      extraConfig = ''
        [urgency=high]
        border-color=#cc241d
      '';
    };

    # Clipboard service
    cliphist = {
      enable = true;
      allowImages = true;
    };
  };

  programs = {
    hyprlock = {
      enable = true;

      importantPrefixes = [
        "$"
        "monitor"
        "size"
        "source"
      ];
      settings = {
        general = {
          disable_loading_bar = false;
          hide_cursor = false;
          no_fade_in = false;
          no_fade_out = false;
          ignore_empty_input = true;
        };

        background = [
          {
            path = "screenshot";
            blur_passes = 1;
            blur_size = 3;
            noise = 0.0117;
            contrast = 0.8916;
            brightness = 0.8172;
            vibrancy = 0.1696;
            vibrancy_darkness = 0.0;
          }
        ];

        input-field = [
          {
            size = "200, 50";
            position = "0, -80";
            monitor = "";
            dots_center = true;
            fade_on_empty = false;
            font_color = "rgb( 202, 211, 245)";
            inner_color = "rgb(91, 96, 120)";
            outer_color = "rgb(24, 25, 38)";
            outline_thickness = 5;
            shadow_passes = 2;
          }
        ];
      };
    };
  };


  # Hyprland mouse pointer
  home = {
    # Define packages to install here
    packages = with pkgs; [
      brightnessctl
      libnotify

      # The whole hyprland ecosystem
      polkit_gnome # You know it
      xdg-desktop-portal-hyprland # for screen sharing
      hyprcursor # for amazing mouse cursors
      hyprpicker # for color picking

      # For clipboard management
      wl-clipboard # Clip hist uses this

      # For controlling volume in the scripts
      pamixer
    ];

    # Declare session variables for Hyprland here
    sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1";
      EDITOR = "nvim";
    };

    # sourcce all the files here
    file = {
      "Pictures/Wallpapers" = {
        recursive = true;
        source = ./../Wallpapers;
      };

      # All the scripts in the hypr directory
      ".config/hypr/scripts" = {
        recursive = true;
        source = ./hypr/scripts;
      };

      # Icon directory of mako
      ".config/mako/icons" = {
        recursive = true;
        source = ./mako/icons;
      };
    };

    # cursor settings
    pointerCursor = {
      gtk.enable = true;
      # x11.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 16;
    };
  };

  # GTK theming for apps
  gtk = {
    enable = true;

    theme = {
      package = pkgs.flat-remix-gtk;
      name = "Flat-Remix-GTK-Grey-Darkest";
    };

    iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };

    font = {
      name = "Sans";
      size = 11;
    };
  };
}
