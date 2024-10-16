{
  pkgs,
  config,
  ...
}:
let
  themix = config.colorScheme.palette;
in
{
  # The overlay for cliphist
  home = {
    packages = with pkgs; [
      libnotify # for notification sending
      cliphist
    ];
  };
  # Services for wayland compositors in case I decide to move over to swayWM
  services = {
    # setting up the wlsunset service
    wlsunset = {
      enable = true;
      sunrise = "06:00";
      sunset = "18:00";
    };

    # for notification
    # mako = {
    #   enable = true;
    #   layer = "top";
    #   markup = true;
    #   anchor = "top-right";
    #   width = 450;
    #   height = 200;
    #   icons = true;
    #   maxIconSize = 96;
    #   font = "JetBrainsMono 10";
    #   margin = "20,20,0";
    #   padding = "15,15,15";
    #   borderSize = 2;
    #   borderRadius = 15;
    #   defaultTimeout = 10000;
    #   groupBy = "summary";
    #   format = "<span font=\"JetBrainsMono Nerd Font weight=325 Italic\" size=\"12288\">%s</span>\\n<span font=\"JetBrainsMono Nerd Font weight=325\" size=\"12288\">%b</span>";
    #
    #   # Configuring the look
    #   backgroundColor = "#${themix.base00}";
    #   textColor = "#${themix.base05}";
    #   borderColor = "#${themix.base06}";
    #   progressColor = "over #${themix.base02}";
    #   extraConfig = ''
    #     icon-location=right
    #     [urgency=high]
    #     border-color=#${themix.base09}
    #
    #     [grouped]
    #     format=<span font="JetBrainsMono Nerd Font weight=325 Italic" size="12288">%s</span>\n<span font="JetBrainsMono Nerd Font weight=325" size="12288">%b</span>
    #     
    #     [mode=do-not-disturb]
    #     invisible=1
    #   '';
    # };

    # Clipboard service
    # cliphist = {
    #   enable = true;
    #   allowImages = true;
    #   package = pkgs.cliphist-custom;
    # };

    # Swayosd for cool popups
    # swayosd = {
    #   enable = true;
    #   package = pkgs.swayosd;
    #   display = "eDP-1";
    # };

    # Enable the swaynotificationcenter
    swaync = {
      enable = true;

      settings = {
        positionY = "bottom";
        layer = "top";
        notification-2fa-action = false;
        timeout = -1;
        control-center-width = 400;
        notification-window-width = 400;
        transition-time = 500;
        hide-on-clear = true;

        widgets = [
          "inhibitors"
          "title"
          "dnd"
          "notifications"
          "volume"
          "backlight"
        ];

        widget-config = {
          inhibitors = {
            text = "Inhibitors";
            button-text = "Clear All";
            clear-all-button = true;
          };

          title = {
            text = "Notfications";
            clear-all-button = true;
            button-text = "Clear All";
          };

          dnd = {
            text = "Do not disturb";
          };

          volume = {
            label = " ";
          };

          backlight = {
            label = " ";
          };
        };
        buttons-grid = {
          actions = [
            {
              label = "Wifi";
              type = "toggle";
              active = true;
              command = "sh -c '[[ $SWAYNC_TOGGLE_STATE == true ]] && nmcli radio wifi on || nmcli radio wifi off'";
              update-command = "sh -c '[[ $(nmcli radio wifi) == \"enabled\" ]] && echo true | false'";
            }
          ];
        };
      };

      # Set the style over here
      style = # scss
        ''
          * {
            all: unset;
            font-size: 14px;
            font-family: "Ubuntu Nerd Font";
            transition: 200ms;
          }

          trough highlight {
            background: #${themix.base05};
          }

          scale trough {
            margin: 0rem 1rem;
            background-color: #${themix.base02};
            min-height: 8px;
            min-width: 70px;
          }

          slider {
            background-color: #${themix.base0D};
          }

          .floating-notifications.background .notification-row .notification-background {
            box-shadow: 0 0 8px 0 rgba(0, 0, 0, 0.8), inset 0 0 0 1px #${themix.base02};
            border-radius: 12.6px;
            margin: 18px;
            background-color: #${themix.base00};
            color: #${themix.base05};
            padding: 0;
          }

          .floating-notifications.background .notification-row .notification-background .notification {
            padding: 7px;
            border-radius: 12.6px;
          }

          .floating-notifications.background .notification-row .notification-background .notification.critical {
            box-shadow: inset 0 0 7px 0 #${themix.base08};
          }

          .floating-notifications.background .notification-row .notification-background .notification .notification-content {
            margin: 7px;
          }

          .floating-notifications.background .notification-row .notification-background .notification .notification-content .summary {
            color: #${themix.base05};
          }

          .floating-notifications.background .notification-row .notification-background .notification .notification-content .time {
            color: #${themix.base04};
          }

          .floating-notifications.background .notification-row .notification-background .notification .notification-content .body {
            color: #${themix.base05};
          }

          .floating-notifications.background .notification-row .notification-background .notification > *:last-child > * {
            min-height: 3.4em;
          }

          .floating-notifications.background .notification-row .notification-background .notification > *:last-child > * .notification-action {
            border-radius: 7px;
            color: #${themix.base05};
            background-color: #${themix.base02};
            box-shadow: inset 0 0 0 1px #${themix.base03};
            margin: 7px;
          }

          .floating-notifications.background .notification-row .notification-background .notification > *:last-child > * .notification-action:hover {
            box-shadow: inset 0 0 0 1px #${themix.base03};
            background-color: #${themix.base02};
            color: #${themix.base05};
          }

          .floating-notifications.background .notification-row .notification-background .notification > *:last-child > * .notification-action:active {
            box-shadow: inset 0 0 0 1px #${themix.base03};
            background-color: #${themix.base0D};
            color: #${themix.base05};
          }

          .floating-notifications.background .notification-row .notification-background .close-button {
            margin: 7px;
            padding: 2px;
            border-radius: 6.3px;
            color: #${themix.base00};
            background-color: #${themix.base08};
          }

          .floating-notifications.background .notification-row .notification-background .close-button:hover {
            background-color: #${themix.base0F};
            color: #${themix.base00};
          }

          .floating-notifications.background .notification-row .notification-background .close-button:active {
            background-color: #${themix.base08};
            color: #${themix.base00};
          }

          .control-center {
            box-shadow: 0 0 8px 0 rgba(0, 0, 0, 0.8), inset 0 0 0 1px #${themix.base02};
            border-radius: 12.6px;
            margin: 18px;
            background-color: #${themix.base00};
            color: #${themix.base05};
            padding: 14px;
          }

          .control-center .widget-title > label {
            color: #${themix.base05};
            font-size: 1.3em;
          }

          .control-center .widget-title button {
            border-radius: 7px;
            color: #${themix.base05};
            background-color: #${themix.base02};
            box-shadow: inset 0 0 0 1px #${themix.base03};
            padding: 8px;
          }

          .control-center .widget-title button:hover {
            box-shadow: inset 0 0 0 1px #${themix.base03};
            background-color: #${themix.base04};
            color: #${themix.base05};
          }

          .control-center .widget-title button:active {
            box-shadow: inset 0 0 0 1px #${themix.base03};
            background-color: #${themix.base0D};
            color: #${themix.base00};
          }

          .control-center .notification-row .notification-background {
            border-radius: 7px;
            color: #${themix.base05};
            background-color: #${themix.base02};
            box-shadow: inset 0 0 0 1px #${themix.base03};
            margin-top: 14px;
          }

          .control-center .notification-row .notification-background .notification {
            padding: 7px;
            border-radius: 7px;
          }

          .control-center .notification-row .notification-background .notification.critical {
            box-shadow: inset 0 0 7px 0 #${themix.base08};
          }

          .control-center .notification-row .notification-background .notification .notification-content {
            margin: 7px;
          }

          .control-center .notification-row .notification-background .notification .notification-content .summary {
            color: #${themix.base05};
          }

          .control-center .notification-row .notification-background .notification .notification-content .time {
            color: #${themix.base04};
          }

          .control-center .notification-row .notification-background .notification .notification-content .body {
            color: #${themix.base05};
          }

          .control-center .notification-row .notification-background .notification > *:last-child > * {
            min-height: 3.4em;
          }

          .control-center .notification-row .notification-background .notification > *:last-child > * .notification-action {
            border-radius: 7px;
            color: #${themix.base05};
            background-color: #11111b;
            box-shadow: inset 0 0 0 1px #${themix.base03};
            margin: 7px;
          }

          .control-center .notification-row .notification-background .notification > *:last-child > * .notification-action:hover {
            box-shadow: inset 0 0 0 1px #${themix.base03};
            background-color: #${themix.base02};
            color: #${themix.base05};
          }

          .control-center .notification-row .notification-background .notification > *:last-child > * .notification-action:active {
            box-shadow: inset 0 0 0 1px #${themix.base03};
            background-color: #${themix.base0D};
            color: #${themix.base05};
          }

          .control-center .notification-row .notification-background .close-button {
            margin: 7px;
            padding: 2px;
            border-radius: 6.3px;
            color: #${themix.base00};
            background-color: #${themix.base0E};
          }

          .close-button {
            border-radius: 6.3px;
          }

          .control-center .notification-row .notification-background .close-button:hover {
            background-color: #${themix.base08};
            color: #${themix.base00};
          }

          .control-center .notification-row .notification-background .close-button:active {
            background-color: #${themix.base08};
            color: #${themix.base00};
          }

          .control-center .notification-row .notification-background:hover {
            box-shadow: inset 0 0 0 1px #${themix.base03};
            background-color: #${themix.base03};
            color: #${themix.base05};
          }

          .control-center .notification-row .notification-background:active {
            box-shadow: inset 0 0 0 1px #${themix.base03};
            background-color: #${themix.base0D};
            color: #${themix.base05};
          }

          .notification.critical progress {
            background-color: #${themix.base08};
          }

          .notification.low progress,
          .notification.normal progress {
            background-color: #${themix.base0D};
          }

          .control-center-dnd {
            margin-top: 5px;
            border-radius: 8px;
            background: #${themix.base02};
            border: 1px solid #${themix.base03};
            box-shadow: none;
          }

          .control-center-dnd:checked {
            background: #${themix.base02};
          }

          .control-center-dnd slider {
            background: #${themix.base03};
            border-radius: 8px;
          }

          .widget-dnd {
            margin: 0px;
            font-size: 1.1rem;
          }

          .widget-dnd > switch {
            font-size: initial;
            border-radius: 8px;
            background: #${themix.base02};
            border: 1px solid #${themix.base03};
            box-shadow: none;
          }

          .widget-dnd > switch:checked {
            background: #${themix.base02};
          }

          .widget-dnd > switch slider {
            background: #${themix.base03};
            border-radius: 8px;
            border: 1px solid #${themix.base02};
          }

          .widget-mpris .widget-mpris-player {
            background: #${themix.base02};
            padding: 7px;
          }

          .widget-mpris .widget-mpris-title {
            font-size: 1.2rem;
          }

          .widget-mpris .widget-mpris-subtitle {
            font-size: 0.8rem;
          }

          .widget-menubar > box > .menu-button-bar > button > label {
            font-size: 3rem;
            padding: 0.5rem 2rem;
          }

          .widget-menubar > box > .menu-button-bar > :last-child {
            color: #${themix.base08};
          }

          .power-buttons button:hover,
          .powermode-buttons button:hover,
          .screenshot-buttons button:hover {
            background: #${themix.base02};
          }

          .control-center .widget-label > label {
            color: #${themix.base05};
            font-size: 2rem;
          }

          .widget-buttons-grid {
            padding-top: 1rem;
          }

          .widget-buttons-grid > flowbox > flowboxchild > button label {
            font-size: 2.5rem;
          }

          .widget-volume {
            padding-top: 1rem;
          }

          .widget-volume label {
            font-size: 1.5rem;
            color: #${themix.base0D};
          }

          .widget-volume trough highlight {
            background: #${themix.base0D};
          }

          .widget-backlight trough highlight {
            background: #${themix.base0A};
          }

          .widget-backlight label {
            font-size: 1.5rem;
            color: #${themix.base0A};
          }

          .widget-backlight .KB {
            padding-bottom: 1rem;
          }

          .image {
            padding-right: 0.5rem;
          }
        '';
    };
  };
}
