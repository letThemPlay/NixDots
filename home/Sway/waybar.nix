{config, ... }:
let
  themix = config.colorScheme.palette;
in 
  {
  programs.waybar = {
    enable = true;

		# settings of the main bar
		settings = {
			mainBar = {
				layer = "top";
				position = "bottom";

        modules-left = [ 
          "custom/notifications"
          "clock"
          "idle_inhibitor"
          "keyboard-state"
        ];

        modules-center = [ 
          "tray"
          "sway/workspaces"
          "sway/window"
        ];

        modules-right = [ 
          "group/hardware"
          #"battery" 
          "power-profiles-daemon" 
          "backlight" 
          "network" 
          "wireplumber"
          #"cpu" 
          #"memory" 
          "custom/power"
        ];

        "group/hardware" = {
          orientation = "inherit";
          drawer = {
            transition-duration = 500;
            children-class = "not-battery";
            transition-left-to-right = false;
          };
          modules = [
            "battery"
            "cpu"
            "memory"
          ];
        };

				"sway/workspaces" = {
          window-rewrite = "{}";
					disable-scroll = true;
          format = "{icon}";
          persistent-workspaces = {
            "1" = "[]";
            "2" = "[]";
            "3" = "[]";
            "4" = "[]";
            "5" = "[]";
            # "6" = "[]";
            # "7" = "[]";
            # "8" = "[]";
            # "9" = "[]";
            # "10" = "[]";
          };
          format-icons = {
            default = " ";
            empty = " ";
            focused = " ";
          };
					on-click = "activate";
				};

        "sway/window" = {
          format = "{title}";
          max-length = 1;
          icon = true;
          icon-size = 20;
        };

        "sway/modes" = {
          format = "{}";
        };

        wireplumber = {
          format = "{icon}{volume}%";
          tooltip = false;
          format-icons = { 
            default = [
              "<span foreground='#${themix.base0A}'></span>" 
              "<span foreground='#${themix.base0B}'> </span>" 
              "<span foreground='#${themix.base0E}'> </span>"
            ];
            headphone = " ";
          };
          format-muted = "<span foreground='#${themix.base08}'> </span>";
          on-click = "pwvucontrol";
          on-click-right = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        };

        keyboard-state = {
          format = {
            numlock = "N{icon}";
            capslock = "C{icon}";
          };
          format-icons = {
            locked = "<span foreground='#89dceb'> </span>";
            unlocked = "<span foreground='#${themix.base0E}'> </span>";
          };
          numlock = true;
          capslock = true;
        };

				battery = {
					full-at = 80;
					states = {
						good = 75;
						warning = 30;
						critical = 25;
					};
					format = "{icon}{capacity}%";
					format-charging = " {capacity}%";
					format-plugged = " {capacity}%";
					format-full = "{icon} <span foreground='#${themix.base0F}'> </span>";
					format-alt = "{icon} {time}";
          format-icons = [
            "<span foreground='#${themix.base07}'> </span>" 
            "<span foreground='#${themix.base08}'> </span>" 
            "<span foreground='#${themix.base0A}'> </span>" 
            "<span foreground='#${themix.base0B}'> </span>" 
            "<span foreground='#${themix.base0B}'> </span>" 
          ];
					format-time = "{H}h {M}min";
					tooltip = true;
				};

        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = " ";
            deactivated = " ";
          };
        };

				clock = {
					interval = 60;
					align = 0;
					rotate = 0;
					tooltip-format = "<big>{:%B %Y}</big>\n<tt><small>{calendar}</small></tt>";
					format = "<span foreground='#${themix.base06}'> </span>{:%I:%M%p}";
					format-alt = "<span foreground='#${themix.base06}'> </span>{:%a %b %d, %G}";
				};

        cpu = {
          interval = 1;
          format = " {usage}%{icon}";
          states = {
            good = 20;
            warning = 40;
            critical = 50;
          };
          on-click = "kitty -e btop";
          format-icons = [
            "<span color='#69ff94'>▁</span>" #green
            "<span color='#2aa9ff'>▂</span>" #blue
            "<span color='#f8f8f2'>▃</span>" #white
            "<span color='#f8f8f2'>▄</span>" #white
            "<span color='#ffffa5'>▅</span>" #yellow
            "<span color='#ffffa5'>▆</span>" #yellow
            "<span color='#ff9977'>▇</span>" #orange
            "<span color='#dd532e'>█</span>" #red
          ];
        };
        memory = {
          interval = "10";
          format = "<span foreground='#${themix.base0F}'> </span>{used:0.1f}G";
        };

				tray = {
					icon-size = 16;
					spacing = 10;
				};

        network = {
          interval = 5;
          format-wifi = "<span foreground='#${themix.base0B}'> </span><span foreground='#${themix.base05}'>{essid}</span>({signalStrength}%)";
          tooltip-format-wifi = " {bandwidthUpBits} |  {bandwidthDownBits}";
          tooltip-format-ethernet = "<span foreground='#${themix.base0D}'> </span>{ifname} via {gwaddr}";
          format-ethernet = " {ipaddr}/{cidr}";
          format-linked = " {ifname} (No IP)";
          format-disconnected = "<span foreground='#${themix.base08}'>󰤭 </span>";
          format-disabled = "<span foreground='#${themix.base08}'> </span>";
          on-click = "kitty -e nmtui";
        };

        # power-profiles-daemon was enabled as service in configuration.nix
        power-profiles-daemon = {
          format = "{icon}";
          tooltip-format = "Power profile: {profile}\nDriver: {driver}";
          format-icons = {
            default = " ";
            performance = " ";
            balanced = " ";
            power-saver = " ";
          };
        };

        backlight = {
          tooltip = false;
          format = "{icon}{percent}%";
          format-icons = [
            "<span color='#${themix.base0B}'> </span>" #green
            "<span color='#${themix.base0D}'> </span>" #blue
            "<span color='#${themix.base06}'> </span>" #white
            "<span color='#${themix.base0F}'> </span>" #white
            "<span color='#f4b8e4'> </span>" #yellow
            "<span color='#${themix.base0A}'> </span>" #yellow
            "<span color='#ea999c'> </span>" #orange
            "<span color='#${themix.base08}'> </span>" #red
          ];
        };

        "custom/notifications" = {
          tooltip = false;
          format = "{icon}";
          format-icons = {
            notification= "<span foreground='#${themix.base08}'> <sup></sup></span>";
            none= "<span foreground='#${themix.base0F}'> </span>";
            dnd-notification= " <span foreground='#${themix.base08}'><sup></sup></span>";
            dnd-none= " ";
            inhibited-notification= " <span foreground='#${themix.base08}'><sup></sup></span>";
            inhibited-none= " ";
            dnd-inhibited-notification= " <span foreground='#${themix.base08}'><sup></sup></span>";
            dnd-inhibited-none= " ";
          };
          return-type = "json";
          exec-if = "which swaync-client";
          exec = "swaync-client -swb";
          on-click = "swaync-client -t -sw";
          on-click-right = "swaync-client -d -sw";
          escape = true;
        };

        "custom/power" = {
          format = " ";
          tooltip = false;
          on-click = "wlogout";
        };
      };
    };

    style = /*css*/''
      *{
        font-family: 'Iosevka Nerd Font Propo';
        font-size: 12pt;
        min-height: 0;
        border-radius: 0;
      }
      
      tooltip {
        background: #${themix.base00};
        border-radius: 15px;
        border: 2px solid #${themix.base0C};
      }
      
      #window {
        border-radius: 20px;
        color: #${themix.base05};
        margin-left: 10px;
        margin-right: 10px;
      }
      window#waybar {
        background-color: transparent;
        color: #${themix.base05};
        border-radius: 20px;
      }
      
      /*#workspaces {
        padding: 1px 1px 1px 1px;
        border-radius: 25px;
        margin-right: 10px;
        margin-left: 10px;
        margin-top: 2px;
        margin-bottom: 2px;
      }*/

      
      #workspaces button {
        padding: 1px;
        background:none;
        color: #${themix.base0C};
        border: none;
      }

      #workspaces button.focused {
        color: #${themix.base09};
      }

      #workspaces button.urgent {
        color: #${themix.base08};
      }
      
      #workspaces button:hover{
        border-radius: 50px;
        background: #${themix.base04};
        color: #${themix.base07};
      }
      
      .modules-left {
        background: linear-gradient(45deg, #${themix.base00}, #${themix.base00}) padding-box, linear-gradient(45deg, #${themix.base0E}, #${themix.base0D}) border-box;
        border: 2px solid transparent;
        border-radius: 25px;
        color: #${themix.base05};
        margin: 10px 0 10px 5px;
        padding: 5px;
      }
      
      .modules-center {
        background: linear-gradient(180deg, #${themix.base00}, #${themix.base00}) padding-box, linear-gradient(180deg, #${themix.base0D}, #${themix.base0E}) border-box;
        border: 2px solid transparent;
        border-radius: 25px;
        color: inherit;
        margin: 10px 0 10px 0;
        padding: 5px;
      }
      
      .modules-right {
        background: linear-gradient(135deg, #${themix.base00}, #${themix.base00}) padding-box, linear-gradient(135deg, #${themix.base0D}, #${themix.base0E}) border-box;
        border: 2px solid transparent; 
        border-radius: 25px;
        color: inherit;
        margin: 10px 5px 10px 0;
        padding: 5px;
      }

      #custom-notifications,
      #clock,
      #idle_inhibitor,
      #keyboard-state,
      #battery,
      #power-profiles-daemon,
      #backlight,
      #network,
      #wireplumber,
      #cpu,
      #memory,
      #custom-power {
        margin-right: 10px;
        margin-left: 10px;
      }
      
      #power-profiles-daemon.power-saver {
        color: #${themix.base0B};
      }
      #power-profiles.balanced {
        color: #${themix.base0A};
      }
      #power-profiles-daemon.performance {
        color: #${themix.base08};
      }
      
      #idle_inhibitor.activated {
        color: #${themix.base08};
      }
      #idle_inhibitor.deactivated {
        color: #${themix.base07};
      }

      #custom-notifications {
        font-family: "Iosevka Nerd Font Propo";
      }
      #custom-power {
        color: #${themix.base08};
        border-radius: 25px;
        background: #${themix.base03};
        padding: 1px;
      }
      '';
  };
}
