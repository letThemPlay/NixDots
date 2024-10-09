# Many programs related to wlr based stuff will be in ../Programs/misc.nix
{ pkgs, lib, config, ... }:
let
  themix = config.colorScheme.palette;

  screenshot = pkgs.pkgs.writeShellScriptBin "screenshot" ''
    filename="grim-$(date '+%d-%m-%Y-%H-%M-%S')"
    ${pkgs.grim}/bin/grim - | tee /home/chris/Pictures/Screenshots/$(echo $filename).png | wl-copy
    ${pkgs.imagemagick}/bin/magick convert /home/chris/Pictures/Screenshots/$(echo $filename).png -bordercolor '#${themix.base06}' -border 30 /tmp/screenshot-notification.png
    notify-send -i /tmp/screenshot-notification.png "  grim" "desktop screenshot saved"
    rm -f /tmp/screenshot-notification.png
  '';

  partialScreenshot = pkgs.pkgs.writeShellScriptBin "partialScreenshot" ''
    filename="grim-$(date '+%Y-%m-%d-%H-%M-%S')"
    ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp -d -b "#${themix.base00}" -c "#${themix.base0C}" -s "#${themix.base03}" -w 2)" - | tee /home/chris/Pictures/Screenshots/$(echo $filename).png | wl-copy
    ${pkgs.imagemagick}/bin/magick convert /home/chris/Pictures/Screenshots/$(echo $filename).png -bordercolor '#${themix.base0C}' -border 15 /tmp/notification-screenshot.png
    notify-send -i /tmp/notification-screenshot.png "  grim" "screenshot of selected area saved"
    rm -f /tmp/notification-screenshot.png
  '';
in 
  {
  home = {
    packages = with pkgs; [
      wev # wayland event viewer
      brightnessctl
      wl-clipboard
    ];
  };
  wayland.windowManager.sway = {
    enable = true;
    package = pkgs.sway;

    config = {
      output = {
        eDP-1 = {
          bg = "${./../Wallpapers/forrest.png} fill";
        };
      };
      defaultWorkspace = "workspace number 1"; # Define the default workspace as 1
      terminal = "kitty";
      menu = "wofi -S drun";
      modifier = "Mod4";

      # Here are the fonts
      fonts = { 
        names = [ "Iosevka Nerd Font" ];
        size = 11.0;
      };

      up = "k";
      down = "j";
      right = "l";
      left = "h";

      startup = [
        { command = "swaync"; }
        { command = "wl-paste --watch cliphist store"; }
        { command = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1 &"; }    
      ];

      bars = [
        {
          command = "waybar";
          fonts = {
            names = [ "Iosevka Nerd Font" ];
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
        followMouse = "yes";
      };

      # The keybinds. The NixOS manual recommends using lib.mkOptionDefault
      # to avoid starting from scratch and rather use the keybinds here with the default ones
      keybindings = 
        let mod = config.wayland.windowManager.sway.config.modifier;
        in lib.mkOptionDefault {
            "${mod}+i" = "exec firefox";
            "${mod}+Shift+i" = "exec qutebrowser";
            "${mod}+q" = "kill";

            # For changing the workspace left and right
            "${mod}+p" = "workspace next";
            "${mod}+o" = "workspace prev";

            # For opening the clipboard
            "${mod}+c" = "exec cliphist list | wofi -S dmenu | cliphist decode | wl-copy";

            # For opening the swaync panel
            "${mod}+Shift+n" = "exec swaync-client -t -sw";
            # "${mod}+d" = "exec sh -c \"notify-send -i ${./makoIcons/dnd.png} '  Do Not Disturb' 'Turning on Do not Distrub Mode' && sleep 2 && makoctl set-mode do-not-disturb\"";
            # "${mod}+Shift+d" = "exec sh -c \"makoctl set-mode default && notify-send -i ${./makoIcons/dnd.png} '  Do Not Disturb' 'Do Not Disturb Mode disabled'\"";
            "${mod}+x" = "exec sh -c \"systemctl suspend && swaylock\"";

            # Volume control keys
            "--locked XF86AudioRaiseVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ -l 1";
            "--locked XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
            "--locked XF86AudioMute" = "exec wpctl set-mute @DEFAULT_SINK@ toggle";

            # Brightness conntrols
            "--locked XF86MonBrightnessUp" = "exec brightnessctl set 5%+";
            "--locked XF86MonBrightnessDown" = "exec brightnessctl set 5%-"; 

            # Player buttons
            "--locked XF86AudioPlay" = "exec playerctl play-pause";
            "--locked XF86AudioNext" = "exec playerctl next";
            "--locked XF86AudioPrev" = "exec playerctl previous";

            #"Control+space" = "exec makoctl dismiss";

            # For screenshots
            "print" = "exec ${screenshot}/bin/screenshot";
            "Shift+print" = "exec ${partialScreenshot}/bin/partialScreenshot";
        };

      # Decoration stuff goes here:
      gaps = {
        smartBorders = "off";
        smartGaps = false;
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
        border = 3;

        commands = [
          {
            criteria = {
              app_id = "vlc";
            };
            command = "inhibit_idle";
          }
        ];
      };

      # coloring the bars
      colors = {
        background = "#${themix.base00}";
        focused = {
          border = "#${themix.base0E}";
          background = "#${themix.base00}";
          text = "#${themix.base05}";
          indicator = "#${themix.base0D}";
          childBorder = "#${themix.base0E}";
        };
        focusedInactive = {
          border = "#${themix.base02}";
          background = "#${themix.base00}";
          text = "#${themix.base05}";
          indicator = "#${themix.base06}";
          childBorder = "#${themix.base02}";
        };
        unfocused = {
          border = "#${themix.base02}";
          background = "#${themix.base00}";
          text = "#${themix.base05}";
          indicator = "#${themix.base06}";
          childBorder = "#${themix.base02}";
        };
        placeholder = {
          border = "#${themix.base02}";
          background = "#${themix.base00}";
          text = "#${themix.base05}";
          indicator = "#${themix.base02}";
          childBorder = "#${themix.base02}";
        };
        urgent = {
          border = "#${themix.base09}";
          background = "#${themix.base00}";
          text = "#${themix.base09}";
          indicator = "#${themix.base02}";
          childBorder = "#${themix.base09}";
        };
      };
    };

    extraConfig = /*jsonc*/''
      bindswitch lid:off exec swaylock
      bindswitch --locked lid:on exec swaymsg 'output * dpms on'

      bindgesture swipe:right workspace prev
      bindgesture swipe:left workspace next
    '';
    swaynag = {
      enable = true;
    };
    wrapperFeatures.gtk = true;

    # Enable systemd variables for sway 
    systemd = {
      enable = true;
      variables = [ "--all" ];
    };
  };

  programs = {
    swaylock = {
      enable = true;
      package = pkgs.swaylock-effects;
      settings = {
        image = "${./../Wallpapers/mandelbrot_full_blue.png}";
        font = "Iosevka Nerd Font";
        font-size = 30;
        scaling = "fill";
        indicator = true;
        clock = true;
        timestr = "%I:%M %p";
        datestr = "%A, %d %B";
        indicator-radius = 150;
        ignore-empty-password = true;
        daemonize = true;

        bs-hl-color = "${themix.base06}";
        caps-lock-bs-hl-color = "${themix.base06}";
        caps-lock-key-hl-color = "${themix.base0B}";
        inside-color = "00000000";
        inside-clear-color = "00000000";
        inside-caps-lock-color = "00000000";
        inside-ver-color = "00000000";
        inside-wrong-color = "00000000";
        key-hl-color = "${themix.base0B}";
        layout-bg-color = "00000000";
        layout-border-color = "00000000";
        layout-text-color = "${themix.base05}";
        line-color = "00000000";
        line-clear-color = "00000000";
        line-caps-lock-color = "00000000";
        line-ver-color = "00000000";
        line-wrong-color = "00000000";
        ring-color = "${themix.base07}";
        ring-clear-color = "${themix.base06}";
        ring-caps-lock-color = "${themix.base09}";
        ring-ver-color = "${themix.base0D}";
        ring-wrong-color = "eba0ac";
        separator-color = "00000000";
        text-color = "${themix.base05}";
        text-clear-color = "${themix.base06}";
        text-caps-lock-color = "${themix.base09}";
        text-ver-color = "${themix.base0D}";
        text-wrong-color = "eba0ac";
      };
    };
  };

  # services related to sway
  # Note that for the commands, etc, the absolute bin paths are to be provided
  services = {
    swayidle = {
      enable = true;
      package = pkgs.swayidle;
      timeouts = [
        { 
          timeout = 180;
          command = "${pkgs.libnotify}/bin/notify-send 'Locking in 5 seconds' -t 5000";
        }

        {
          timeout = 185;
          command = "${pkgs.swaylock-effects}/bin/swaylock";
        }

        {
          timeout = 190;
          command = "${pkgs.sway}/bin/swaymsg 'output * dpms off'";
          resumeCommand = "${pkgs.sway}/bin/swaymsg 'output * dpms on'";
        }

        {
          timeout = 183;
          command = "${pkgs.brightnessctl}/bin/brightnessctl --save set 10%";
          resumeCommand = "${pkgs.brightnessctl}/bin/brightnessctl --restore";
        }
      ];
      events = [
        {
          event = "before-sleep";
          command = "${pkgs.swaylock-effects}/bin/swaylock";
        }
      ];
      systemdTarget = "sway-session.target";
    };
  };      
}
