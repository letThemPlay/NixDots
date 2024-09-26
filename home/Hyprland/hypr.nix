{ inputs,
config,
pkgs, 
... 
}: let 
  themix = config.colorScheme.palette;
in {
  # Programs and packages for Hyprland
  home = {
    packages = with pkgs; [
      grimblast # Screenshot utility for hyprland
      brightnessctl # for brightness control
      libnotify # For notifications
      wl-clipboard # clipboard utility
    ];

    # Enter the session variables here
    sessionVariables = {
      XDG_SCREENSHOTS_DIR = "${config.xdg.userDirs.pictures}/Screenshots";
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;

    # Put source entries at the top
    sourceFirst = true;

    # Declare Hyprland settings here
    settings = {
      # auto start apps here
      exec-once = [
        "swaync"
        "wpaperd -d"
        "wl-copy --watch cliphist store"
        "waybar"
        "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1 &"
        "${inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland}/libexec/xdg-desktop-portal-hyprland"
      ];

      "$mod" = "SUPER";
      "$term" = "kitty";
      "$menu" = "wofi -S drun";
      "$clipboard" = "cliphist list | wofi -S dmenu | cliphist decode | wl-copy";
      "$termBrowser" = "qutebrowser";
      "$browser" = "firefox";
      "$filemanager" = "thunar";
      "$termFilemanager" = "$term -e yazi";

      # Monitor settings
      monitor = [
        ", highres, auto, 1"
      ];

      windowrulev2 = [
        "suppressevent maximize, class:.*"
      ];

      # Keybindings 
      bind =
        [
          # Open browsers and other apps
          "$mod, return, exec, $term" # open terminal
          "$mod, I, exec, $browser" # open the browser
          "$mod SHIFT, I, exec, $termBrowser" # Open terminal browser
          "$mod, C, exec, $clipboard" # Open clipboard
          "$mod, D, exec, $menu" # Open the wofi menu
          "$mod, M, exit," # Exit hyprland
          "$mod, E, exec, $filemanager" # Open filemanager
          "$mod SHIFT, E, exec, $termFilemanager" # Open the terminal browser
          "$mod, space, togglefloating," # Enable floating toggle
          "$mod, W, pseudo, " # Enable pseudotiling 
          "$mod, S, togglesplit," # Toggle split orientation in dwindle layout
          "$mod, F, fullscreen, 0" # Toggle fullscreen without gaps 
          "$mod SHIFT, F, fullscreen, 1" # Toggle fullscreen with gaps and waybar
          "$mod, X, exec, systemctl suspend && hyprlock" # Lock and suspend 
          "$mod SHIFT, X, exec, hyprlock" # Just lock and leave
          # ", XF86PowerOff, exec, systemctl suspend && hyprlock"

          "$mod, Q, killactive," # Kill active windows

          "$mod SHIFT, Print, exec, grimblast --notify save area" # screenshot a given area
          "$mod, Print, exec, grimblast --notify save screen" # screenshot whole screen
          "$mod ALT, Print, exec, grimblast --notify save active" # Save the window

          # Change wallpaper
          "$mod, right, exec, wpaperctl next"
          "$mod, left, exec, wpaperctl previous"

          # Change workspaces from P and O 
          "$mod, P, workspace, e+1"
          "$mod, O, workspace, e-1"

          # Toggle special workspace
          "$mod, minus, togglespecialworkspace, magic"
          "$mod SHIFT, minus, movetoworkspace, special:magic"

          # Change focus from window to window
          "$mod, h, movefocus, l"
          "$mod, l, movefocus, r"
          "$mod, j, movefocus, d"
          "$mod, k, movefocus, u"

          # Use mod and keys to move focus around 
          "$mod SHIFT, h, movewindow, l"
          "$mod SHIFT, l, movewindow, r"
          "$mod SHIFT, j, movewindow, d"
          "$mod SHIFT, k, movewindow, u"

          "$mod SHIFT, N, exec, swaync-client -t -sw" # open swaync

          # To switch between windows in a floating workspace
          "$mod, Tab, cyclenext,"
          "$mod, Tab, bringactivetotop,"
        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
          builtins.concatLists (builtins.genList (i:
            let ws = i + 1;
            in [
              "$mod, code:1${toString i}, workspace, ${toString ws}"
              "$mod SHIFT, code:1${toString i}, movetoworkspacesilent, ${toString ws}"
              "ALT SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            ]
          )
            9)
        );

      # volume and multimedia keys
      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
        ",XF86MonBrightnessDown, exec, brightnessctl s 10%-"
      ];

      # Use player keys
      bindl = [
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"

        # Lid switch configuration
        ", switch:[Lid], exec, hyprlock"
        ", switch:on:[Lid], exec, hyprctl keyword monitor \"eDP-1, disable\""
        ", switch:off:[Lid], exec, hyprctl keyword monitor \"eDP-1, 1920x1080, 0x0, 1\""
      ];

      # Mouse bindings
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod ALT, mouse:272, resizewindow"
      ];

      # touchpad settings
      input = {
        touchpad = {
          natural_scroll = true;
        };
      };

      # Disable some stuff
      misc = {
        force_default_wallpaper = false;
        disable_hyprland_logo = true;
      };

      # Animations 
      animations = {
        enabled = true;

        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      # Layout settings
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        new_status = "master";
      };

      # Now for some decoration
      decoration = {
        rounding = 8;
        active_opacity = 1.0;
        inactive_opacity = 1.0;
        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(${themix.base00}ee)";

        # Blur enabled for a few things
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
      };

      # General appearance
      general = {
        gaps_in = 5;
        gaps_out = 20;
        border_size = 2;
        "col.active_border" = "rgba(${themix.base0D}ee) rgba(${themix.base0E}ee) 45deg";
        "col.inactive_border" = "rgba(${themix.base02}aa)";
        resize_on_border = false; # Resize using clicks on gaps and borders
        allow_tearing = false;
        layout = "dwindle";
      };
    };

    # Enable systemd settings to pull in Variables information
    systemd = {
      enable = true;
      variables = [ "--all" ];
    };
  };

  # programs for Hyprland
  programs = {
    # the wallpaper daemon
    wpaperd = {
      enable = true;
      package = pkgs.wpaperd;

      settings = {
        default = {
          path = "${./../Wallpapers/berries.jpg}";
          apply-shadow = true;
          sorting = "ascending";
        };
      };
    };

    # Enable hyprlock
    hyprlock = {
      enable = true;
      package = pkgs.hyprlock;

      # Put source entries first
      sourceFirst = true;
      settings = {
        general = {
          no_fade_in = true;
          no_fade_out = true;
          hide_cursor = false;
          grace = 0;
          disable_loading_bar = true;
        };

        input-field = [
          {
            monitor = "";
            size = "250, 60";
            outline_thickness = 2;
            dots_size = 0.2;
            dots_spacing = 0.35;
            dots_center = true;
            outer_color = "rgba(189, 174, 147, 0.2)";
            inner_color = "rgba(189, 174, 147, 0.2)";
            font_color = "$foreground";
            fade_on_empty = true;
            rounding = -1;
            check_color = "rgb(204, 136, 34)";
            placeholder_text = "<i><span foreground=\"##cdd6f4\">Input Password...</span></i>";
            hide_input = false;
            position = "0, -200";
            halign = "center";
            valign = "center";
          }
        ];

        label = [
          # Date 
          {
            monitor = "";
            text = "cmd[update:1000] echo \"$(date +\"%A, %B %d\")\"";
            color = "rgba(242, 243, 244, 0.75)";
            font_size = 22;
            font_family = "Iosevka Nerd Font";
            position = "0, 300";
            halign = "center";
            valign = "center";
          }

          # TIME 
          {
            monitor = "";
            text = "cmd[update:1000] echo \"$(date +\"%-I:%M\")\"";
            color = "rgba(242, 243, 244, 0.75)";
            font_size = 95;
            font_family = "Iosevka Nerd Font";
            position = "0, 200";
            halign = "center";
            valign = "center";
          }
        ];

        background = [
          {
            monitor = "" ;
            path = "${../Wallpapers/forest-3.jpg}";
            blur_passes = 2;
            contrast = 1;
            brightness = 0.5;
            vibrancy = 0.2;
            vibrancy_darkness = 0.2;
          }
        ];
      };
    };
  };

  # The Hypridle servivce
  services = {
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
            timeout = 300;
            on-timeout = "loginctl lock-session";
            on-resume = "notify-send \"Welcome Back\"";
          }

          {
            timeout = 330;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
        ];
      };
    };
  };
}
