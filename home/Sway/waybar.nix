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

    style = /*css*/''
      @keyframes blink-warning {
      70% {
        color: @light;
      }

      to {
        color: @light;
        background-color: @warning;
      }
      }

      @keyframes blink-critical {
      70% {
        color: @light;
      }

      to {
        color: @light;
        background-color: @critical;
      }
      }
      * {
        font-family: "JetBrainsMono Nerd Font";
        font-size: 12px;
      }

      /** ********** Waybar Window ********** **/
      window#waybar {
        background-color: transparent;
        border-radius: 10px;
        padding-top: 0px;
        margin-top: 0;
      }

      window#waybar.hidden {
        opacity: 0.5;
      }

      /** ********** Backlight ********** **/
      #backlight {
        color: #b16286;
      }

      /** ********** Battery ********** **/
      #battery {
        color: #fabd2f;
      }

      #battery.charging,#battery.plugged {
        color: #b8bb26; 
      }

      @keyframes blink {
      to {
        color: #000000;
      }
      }

      #battery.critical:not(.charging) {
        color: #cc241d;
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }


      #workspaces button {
        padding: 0 5px;
        background-color: transparent;
        color: #fbf1c7;
      }

      #workspaces button:hover {
        color: #DBBC7F;
      }

      #workspaces button.focused {
        background-color: #fe8019;
        box-shadow: inset 0 -3px #ffffff;
      }

      #workspaces button.urgent {
        background-color: #d65d0e;
      }


      /** ********** Clock ********** **/
      #clock {
        color: #8ec07c;
      }

      /** ********** CPU ********** **/
      #cpu {
        color: #83a598;
      }

      /** ********** Memory ********** **/
      #memory {
        color: #d3869b;
      }

      /** ********** Disk ********** **/
      #disk {
        color: #689d6a;
      }

      /** ********** Tray ********** **/
      #tray {
        color: #458588;
      }
      #tray > .passive {
        -gtk-icon-effect: dim;
      }
      #tray > .needs-attention {
        -gtk-icon-effect: highlight;
      }
      #tray > .active {
      }

      /************** Power-profiles-daemon ******/
      #power-profiles-daemon.performance {
        color: #cc241d;
      }
      #power-profiles-daemon.balanced {
        color: #fabd2f;
      }
      #power-profiles-daemon.power-saver {
        color: #b8bb26;
      }

      /************** Idle_inhibitor ************/
      #idle_inhibitor {
        color: #98971a;
      }

      #idle_inhibitor.activated {
        color: #fb4934;
      }

      /** ********** MPD ********** **/
      #mpd {
        background-color: #94e2d5;
      }

      #mpd.disconnected {
        background-color: #f38ba8;
      }

      #mpd.stopped {
        background-color: #f5c2e7;
      }

      #mpd.playing {
        background-color: #74c7ec;
      }

      #mpd.paused {
      }

      /** ********** Pulseaudio ********** **/
      #pulseaudio {
        color: #458588;
      }

      #pulseaudio.bluetooth {
        background-color: #f5c2e7;
      }
      #pulseaudio.muted {
        background-color: #313244;
        color: #cdd6f4;
      }

      /** ********** Network ********** **/
      #network {
        color: #ebdbb2;
      }

      #network.disconnected,#network.disabled {
        color: #d65d0e;
      }
      #network.linked {
      }
      #network.ethernet {
      }
      #network.wifi {
      }

      /** Common style **/
      #custom-notification,
      #idle_inhibitor,
      #submap,
      #power-profiles-daemon,
      #backlight, 
      #battery,
      #clock,
      #cpu,
      #disk,
      #mode,
      #memory,
      #mpd,
      #tray,
      #pulseaudio,
      #network {
        border-radius: 4px;
        margin: 6px 0px;
        padding: 2px 8px;
      }

      #temperature {
        border-radius: 4px;
        margin: 6px 0px;
        padding: 2px 8px;
        color: #f0932b;
      }

      #temperature.critical {
        color: #eb4d4b;
      }

      #submap {
        color: #A7C080;
      }
      
		'';
	};
}
