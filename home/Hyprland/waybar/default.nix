{
	programs.waybar = {
		enable = true;
		
		# settings of the main bar
		settings = {
			mainbar = {
				layer = "top";
				position = "bottom";
				height = 39;
				mode = "dock";
				exclusive = true;
				passthrough = false;
				spacing = 6;
				fixed-center = true;
				ipc = true;

        modules-left = [ 
          "keyboard-state" 
          "custom/notification" 
          "hyprland/submap" 
          "hyprland/window" 
        ];

        moudules-center = [ 
          "idle_inhibitor" 
          "hyprland/workspaces" 
          "clock" 
        ];

        modules-right = [ 
          "battery" 
          "power-profiles-daemon" 
          "backlight" 
          "network" 
          "pulseaudio"
          "cpu" 
          "memory" 
          "tray" 
          "custom/power"
        ];

				"hyprland/workspaces" = {
					disable-scroll = true;
					all-outputs = true;
					format = "{}";
					on-click = "activate";
				};

				battery = {
					full-at = 80;
					states = {
						good = 75;
						warning = 30;
						critical = 25;
					};
					format = "{icon}  {capacity}%";
					format-charging = " {capacity}%";
					format-plugged = " {capacity}%";
					format-full = "{icon}  ";
					format-alt = "{icon}  {time}";
					format-icons = [" " " " " " " " " "];
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
					format = "  {:%I:%M %p}";
					format-alt = " {:%a %b %d, %G}";
				};

				cpu = {
					interval = 5;
					format = "  LOAD: {usage}%";
				};

				memory = {
					interval = "10";
					format = "  USED: {used:0.1f}G";
				};

				tray = {
					icon-size = 16;
					spacing = 10;
				};

				network = {
					interval = 5;
					format-wifi = "   {essid}";
					format-alt = " {bandwidthUpBits} |  {bandwidthDownBits}";
					tooltip-format = " {ifname} via {gwaddr}";
					format-ethernet = " {ipaddr}/{cidr}";
        	format-linked = " {ifname} (No IP)";
        	format-disconnected = "!! !!";
        	format-disabled = " ";
				};

        temperature = {
          critical-threshold = 80;
          format = "{temperatureC}°C {icon}";
          format-icon = [  " " "" ];
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
          format = "{percent}% {icon}";
          format-icons = [
            " "
            " "
            " "
            " "
            " "
            " "
            " " 
            " "
            " "
          ];
        };

        pulseaudio = {
          format = "{volume}% {icon}";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = " {icon} {format_source}";
          format-muted = " {format_source}";
          format-source = "{volume}% ";
          format-source-muted = " ";
          format-icons = {
              headphone = " ";
              hands-free = " ";
              headset = " ";
              phone = " ";
              portable = " ";
              car = " ";
              default = ["" " " " "];
          };
          on-click = "pavucontrol";
        };
        
        "hyprland/submap" = {
          format = "{}";
          tooltip = true;
        };

        "custom/power" = { # See wlogout.nix
          tooltip = false;
          format = " ";
          on-click = "wlogout";
        };

        "custom/notification" = {
          tooltip = false;
          format = "{} {icon}";
          format-icons = {
            notification = " <span foreground='red'><sup></sup></span>";
            none = " ";
            dnd-notification = " <span foreground='red'><sup></sup></span>";
            dnd-none = " ";
            inhibited-notification = " <span foreground='red'><sup></sup></span>";
            inhibited-none = " ";
            dnd-inhibited-notification = " <span foreground='red'><sup></sup></span>";
            dnd-inhibited-none = " ";
          };
          return-type = "json";
          exec-if = "which swaync-client";
          exec = "swaync-client -swb";
          on-click = "swaync-client -t -sw";
          on-click-right = "swaync-client -d -sw";
          escape = true;
        };
      };
    };

    style = ''
      ${builtins.readFile(./style.css)}
		'';
	};
}
