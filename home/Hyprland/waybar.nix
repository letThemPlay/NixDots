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
					interval = "6 0";
					align = 0;
					rotate = 0;
					full-at = "1 0 0";
					design-capacity = false;
					states = {
						good = "9 5";
						warning = "3 0";
						critical = "1 5";
					};
					format = "{icon}  {capacity}%";
					format-charging = " {capacity}%";
					format-plugged = " {capacity}%";
					format-full = "{icon} FULL";
					format-alt = "{icon}  {time}";
					format-icons = ["" "" "" "" ""];
					format-time = "{H}h {M}min";
					tooltip = true;
				};

				clock = {
					interval = "6 0";
					align = 0;
					rotate = 0;
					tooltip-format = "<big>{:%B %Y}</big>\n<tt><small>{calendar}</small></tt>";
					format = "  {:%H:%M}";
					format-alt = " {:%a %b %d, %G}";
				};

				cpu = {
					interval = 5;
					format = "  LOAD: {usage}%";
				};

				memory = {
					interval = "1 0";
					format = "  USED: {used:0.1f}G";
				};

				tray = {
					icon-size = "1 6";
					spacing = "1 0";
				};

				network = {
					interval = 5;
					format-wifi = "   {essid}";
					format-alt = " {bandwidthUpBits} |  {bandwidthDownBits}";
					tooltip-format = " {ifname} via {gwaddr}";
					format-ethernet = " {ipaddr}/{cidr}";
        	format-linked = " {ifname} (No IP)";
        	format-disconnected = "睊 Disconnected";
        	format-disabled = "睊 Disabled";
				};

        temperature = {
          critical-threshold = 80;
          format = "{temperatureC}°C {icon}";
          format-icon = [  "" "" ];
        };

        "custom/arrow1" = {
          format = "";
          tooltip = false;
        };

        "custom/arrow2" = {
          format = "";
          tooltip = false;
        };

        "custom/arrow3" = {
          format = "";
          tooltip = false;
        };

        "custom/arrow4" = {
          format = "";
          tooltip = false;
        };

        "custom/arrow5" = {
          format = "";
          tooltip = false;
        };

        "custom/arrow6" = {
          format = "";
          tooltip = false;
        };

        "custom/arrow7" = {
          format = "";
          tooltip = false;
        };

        "custom/arrow8" = {
          format = "";
          tooltip = false;
        };

        "custom/arrow9" = {
          format = "";
          tooltip = false;
        };

        "custom/arrow10" = {
          format = "";
          tooltip = false;
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
			    font-family: "FontAwesome, Roboto, Helvetica, Arial, sans-serif, JetBrainsMono";
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
				background-color: #cba6f7;
			}
			
			/** ********** Battery ********** **/
			#battery {
				background-color: #f9e2af;
			}
			
			#battery.charging {
			}
			
			#battery.plugged {
			}
			
			@keyframes blink {
			    to {
			        color: #000000;
			    }
			}
			
			#battery.critical:not(.charging) {
				background-color: #f38ba8;
			    color: #f38ba8;
			    animation-name: blink;
			    animation-duration: 0.5s;
			    animation-timing-function: linear;
			    animation-iteration-count: infinite;
			    animation-direction: alternate;
			}


      #workspaces button {
        padding: 0 5px;
        background-color: transparent;
        color: #ffffff;
      }
    
      #workspaces button:hover {
        background: rgba(0, 0, 0, 0.2);
      }
    
      #workspaces button.focused {
        background-color: #64727D;
        box-shadow: inset 0 -3px #ffffff;
      }
    
      #workspaces button.urgent {
        background-color: #eb4d4b;
      }
    
			
			/** ********** Clock ********** **/
			#clock {
				background-color: #a6e3a1;
			}
			
			/** ********** CPU ********** **/
			#cpu {
				background-color: #89dceb;
			}
			
			/** ********** Memory ********** **/
			#memory {
				background-color: #eba0ac;
			}
			
			/** ********** Disk ********** **/
			#disk {
				background-color: #b4befe;
			}
			
			/** ********** Tray ********** **/
			#tray {
				background-color: #cdd6f4;
			}
			#tray > .passive {
			    -gtk-icon-effect: dim;
			}
			#tray > .needs-attention {
			    -gtk-icon-effect: highlight;
			}
			#tray > .active {
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
				background-color: #fab387;
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
				background-color: #89b4fa;
			}
			
			#network.disconnected,#network.disabled {
				background-color: #313244;
				color: #cdd6f4;
			}
			#network.linked {
			}
			#network.ethernet {
			}
			#network.wifi {
			}
			
			/** ********** Custom ********** **/
			
			/** Common style **/
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
        background-color: #f0932b;
      }

      #temperature.critical {
        background-color: #eb4d4b;
      }
		'';
	};
}
