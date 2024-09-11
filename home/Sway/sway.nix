{ pkgs, lib, config, ... }:
let
  themix = config.colorScheme.palette;

  screenshot = pkgs.pkgs.writeShellScriptBin "screenshot" ''
    filename="grim-$(date '+%d-%m-%Y-%H-%M-%S')"
    ${pkgs.grim}/bin/grim - | tee /home/chris/Pictures/Screenshots/$(echo $filename).png | wl-copy
    ${pkgs.imagemagick}/bin/magick convert /home/chris/Pictures/Screenshots/$(echo $filename).png -bordercolor '#96cdfb' -border 30 /tmp/screenshot-notification.png
    notify-send -i /tmp/screenshot-notification.png "  grim" "desktop screenshot saved"
    rm -f /tmp/screenshot-notification.png
  '';

  partialScreenshot = pkgs.pkgs.writeShellScriptBin "partialScreenshot" ''
    filename="grim-$(date '+%Y-%m-%d-%H-%M-%S')"
    ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp -d -b "#302d4180" -c "#96cdfb" -s "#57526840" -w 2)" - | tee /home/loki/pictures/screenshots/$(echo $filename).png | wl-copy
    ${pkgs.imagemagick}/bin/magick convert /home/chris/Pictures/Screenshots/$(echo $filename).png -bordercolor '#96cdfb' -border 15 /tmp/notification-screenshot.png
    notify-send -i /tmp/notification-screenshot.png "  grim" "screenshot of selected area saved"
    rm -f /tmp/notification-screenshot.png
  '';
in 
  {
  home = {
    packages = with pkgs; [
      wev # wayland event viewer
    ];
  };
  wayland.windowManager.sway = {
    enable = true;
    package = pkgs.sway;

    config = {
      output = {
        eDP-1 = {
          bg = "${./../Wallpapers/dark/nix-black-4k.png} fill";
        };
      };
      defaultWorkspace = "workspace number 1"; # Define the default workspace as 1
      terminal = "kitty";
      menu = "wofi -S drun";
      modifier = "Mod4";

      # Here are the fonts
      fonts = { 
        names = [ "JetBrainsMono Nerd Font" ];
        size = 11.0;
      };

      up = "k";
      down = "j";
      right = "l";
      left = "h";

      startup = [
        {command = "wl-paste --watch cliphist store";}
        {command = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1 &";}    
      ];

      bars = [
        {
          command = "waybar";
          fonts = {
            names = [ "JetBrainsMono Nerd Font" ];
          };
        }
      ];

      input = {
        "*" = {
          xkb_layout = "us";
        };

        "type:touchpad" = {
          dwt = "enabled";
          tap = "enabled";
          natural_scroll = "enabled";
          middle_emulation = "enabled";
        };
      };

      focus = {
        followMouse = "always";
      };

      # The keybinds. The NixOS manual recommends using lib.mkOptionDefault
      # to avoid starting from scratch and rather use the keybinds here with the default ones
      keybindings = 
        let modifier = config.wayland.windowManager.sway.config.modifier;
        in lib.mkOptionDefault {
            "${modifier}+i" = "exec firefox";
            "${modifier}+q" = "kill";

            # For changing the workspace left and right
            "${modifier}+p" = "workspace next";
            "${modifier}+o" = "workspace prev";

            # Volume control keys
            "--locked XF86AudioRaiseVolume" = "exec swayosd-client --output-volume +10 --max-volume 100";
            "--locked XF86AudioLowerVolume" = "exec swayosd-client --output-volume -10 --max-volume 100";
            #"--locked XF86AudioMute" = "exec swayosd-client --ouput-volume mute-toggle";
            "--locked XF86AudioMute" = "exec wpctl set-mute @DEFAULT_SINK@ toggle";

            # Brightness conntrols
            "--locked XF86MonBrightnessUp" = "exec swayosd-client --brightness +5";
            "--locked XF86MonBrightnessDown" = "exec swayosd-client --brightness -5";

            # Player buttons
            "--locked XF86AudioPlay" = "exec playerctl play-pause";
            "--locked XF86AudioNext" = "exec playerctl next";
            "--locked XF86AudioPrev" = "exec playerctl previous";

            # Caps-lock and Num lock swayosd settings
            "--release Caps_Lock" = "exec swayosd-client --caps-lock-led input0::capslock";

            # For opening the clipboard
            "${modifier}+c" = "exec cliphist list | wofi -S dmenu | cliphist decode | wl-copy";

            # For opening the swaync panel
            "${modifier}+Shift+n" = "exec swaync-client -t -sw";

            "Control+space" = "makoctl dismiss";

            # For screenshots
            "print" = "${screenshot}/bin/screenshot";
            "Shift+print" = "${partialScreenshot}/bin/partialScreenshot";
        };

      # Decoration stuff goes here:
      gaps = {
        smartBorders = "off";
        inner = 8;
        outer = 8;
      };

      seat = {
      "*" = {
        hide_cursor = "when-typing enable";
        };
      };

      window = {
        titlebar = false;
        border = 2;

        commands = [
          {
            criteria = {
              app_id = "vlc";
            };
            command = "idle_inhibit";
          }
        ];
      };

      # coloring the bars
      colors = {
        background = "#${themix.base00}";
        focused = {
          border = "#${themix.base07}";
          background = "#${themix.base00}";
          text = "#${themix.base05}";
          indicator = "#${themix.base06}";
          childBorder = "#${themix.base07}";
        };
        focusedInactive = {
          border = "#6c7086";
          background = "#${themix.base00}";
          text = "#${themix.base05}";
          indicator = "#${themix.base06}";
          childBorder = "#6c7086";
        };
        unfocused = {
          border = "#6c7086";
          background = "#${themix.base00}";
          text = "#${themix.base05}";
          indicator = "#${themix.base06}";
          childBorder = "#6c7086";
        };
        placeholder = {
          border = "#6c7086";
          background = "#${themix.base00}";
          text = "#${themix.base05}";
          indicator = "#6c7086";
          childBorder = "#6c7086";
        };
        urgent = {
          border = "#${themix.base09}";
          background = "#${themix.base00}";
          text = "#${themix.base09}";
          indicator = "#6c7086";
          childBorder = "#${themix.base09}";
        };
      };
    };
    swaynag = {
      enable = true;
    };
    wrapperFeatures.gtk = true;
  };

  programs = {
    swaylock = {
      enable = true;
      package = pkgs.swaylock-effects;
      settings = {
        color = "1e1e2e";
        bs-hl-color = "f5e0dc";
        caps-lock-bs-hl-color = "f5e0dc";
        caps-lock-lock-key-hl-color = "a6e3a1";
        inside-color = "00000000";
        inside-clear-color = "00000000";
        inside-caps-lock-color = "00000000";
        inside-ver-color = "00000000";
        inside-wrong-color = "00000000";
        key-hl-colors = "a6e3a1";
        layout-bg-color = "00000000";
        layout-border-color = "00000000";
        layout-text-color = "cdd6f4";
        line-color = "00000000";
        line-clear-color = "00000000";
        line-caps-lock-color="00000000";
        line-ver-color="00000000";
        line-wrong-color="00000000";
        ring-color="b4befe";
        ring-clear-color="f5e0dc";
        ring-caps-lock-color="fab387";
        ring-ver-color="89b4fa";
        ring-wrong-color="eba0ac";
        separator-color="00000000";
        text-color="cdd6f4";
        text-clear-color="f5e0dc";
        text-caps-lock-color="fab387";
        text-ver-color="89b4fa";
        text-wrong-color="eba0ac";

        font-size = 24;
        indicator-idle-visible = false;
        indicator-radius = 100;
        show-failed-attempts = true;
      };
    };
  };

  # services related to sway
  services = {
    swayidle = {
      enable = true;
      package = pkgs.swayidle;
      timeouts = [
        { 
          timeout = 60;
          command = "swaylock";
        }

        {
          timeout = 80;
          command = "swaymsg \"output * power off\"";
          resumeCommand = "swaymsg \"output * power on\"";
        }

        {
          timeout = 90;
          command = "systemctl suspend";
        }
      ];
    };
  };      
}

