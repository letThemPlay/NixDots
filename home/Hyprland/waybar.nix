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

				modules-left = [ "hyprland/workspaces" ];
				moudules-center = [ "hyprland/window" "tray" ];
        modules-right = [ 
          "idle_inhibitor" 
          "power-profiles-daemon" 
          "backlight" 
          "keyboard-state" 
          "network" 
          "pulseaudio"
          "temperature" 
          "cpu" 
          "memory" 
          "battery" 
          "clock" 
        ];

				"hyprland/workspaces" = {
					disable-scroll = true;
					all-outputs = true;
					format = "{icon}";
					on-click = "activate";
					format-icons = {
						"1" = "";
						"2" = "";
						"3" = "";
						"4" = "";
						"5" = "ﭮ";
            "6" = "";
            "7" = "";
            "8" = "";
            "9" = "";
            "10" = "﮼";
						focused = "";
						default = "";
					};
				};

				battery = {
					full-at = 80;
					states = {
						good = 95;
						warning = 30;
						critical = 15;
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
            ""
            ""
            ""
            ""
            ""
            ""
            "" 
            ""
            ""
          ];
        };

        pulseaudio = 
        {
          format = "{volume}% {icon}  {format_source}";
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
			};
		};

    style = ''
      /*@keyframes blink-warning {
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
      }*/







			* {
			    font-family: FontAwesome, Roboto, Helvetica, Arial, sans-serif, JetBrainsMono;
			    font-size: 12px;
			}
			
			/** ********** Waybar Window ********** **/
			window#waybar {
			    background-color: transparent;
				  color: #1e1e2e;
			    border-bottom: 2px solid #313244;
			    transition-property: background-color;
			    transition-duration: .5s;
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
        background: rgba(0, 0, 0, 0.2);
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
      #idle_inhibitor,
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
		'';
	};
}
