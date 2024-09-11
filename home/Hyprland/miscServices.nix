{pkgs, ... }:

{
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
    #   font = "JetBrainsMono 10";

    #   # Enable icons
    #   icons = true;

    #   # Timeout settings
    #   defaultTimeout = 2500;

    #   # Udiskie has very low timeout so set this
    #   ignoreTimeout = true;

    #   # Configuring the look
    #   backgroundColor = "#d79921";
    #   textColor = "#1d2021";
    #   borderColor = "#ebdbb2";
    #   progressColor = "over #ebdbb2";
    #   extraConfig = ''
    #     [urgency=high]
    #     border-color=#cc241d
    #   '';
    # };

    # Clipboard service
    cliphist = {
      enable = true;
      allowImages = true;
    };

    # Swayosd for cool popups
    swayosd = {
      enable = true;
      package = pkgs.swayosd;
      display = "eDP-1";
    };

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
      style = ''
        /* Row contains all other notification elements. */
        .notification-row {
          outline: none;
        }
        
        /* Background is the next largest element. Just a box behind the notification itself. */
        .notification-background {
          padding: 10px 6px;
        }
        
        /* An notification is a box that contains actions. */
        .notification {
          border-radius: 12px;
          border: 1px solid rgba(37, 36, 35, 0.9);
          padding: 0;
          background: rgba(50, 48, 47, 0.95);
          box-shadow:
            0 0 0 1px rgba(37, 36, 35, 0.3),
            0 1px 3px 1px rgba(37, 36, 35, 0.7),
            0 2px 6px 2px rgba(37, 36, 35, 0.3);
        }
        
        /* Just a desktop, non panel notification. */
        .floating-notifications {
          background: transparent;
        }
        
        /* Content is for example the text of a telegram message, if the default action exists, the content will turn to it. */
        .notification-content {
          background: transparent;
          border-radius: 12px;
          padding: 4px;
        }
        
        /* An example of a default action - this is the telegram message that will be opened by pressing. */
        .notification-default-action {
          padding: 4px;
          margin: 0;
          background: transparent;
          border: none;
          color: rgb(212, 190, 152);
        }
        
        .notification-default-action:hover {
          -gtk-icon-effect: none;
          background: rgba(60, 56, 54, 0.95);
        }
        
        /* Action like the "Mark as read" */
        .notification-action {
          padding: 4px;
          margin: 0;
          background: transparent;
          color: rgb(212, 190, 152);
          border: none;
          border-top: 1px solid rgb(80, 73, 69);
          border-radius: 0px;
          border-right: 1px solid rgb(80, 73, 69);
        }
        
        .notification-action:hover {
          -gtk-icon-effect: none;
          background: rgba(60, 56, 54, 0.95);
        }
        
        .notification-action:first-child {
          /* add bottom border radius to eliminate clipping */
          border-bottom-left-radius: 12px;
        }
        
        .notification-action:last-child {
          border-bottom-right-radius: 12px;
          border-right: none;
        }
        
        /* Reply to message line */
        .inline-reply {
          margin-top: 4px;
        }
        
        .inline-reply-entry {
          background: rgba(37, 36, 35, 0.95);
          color: rgb(212, 190, 152);
          caret-color: rgb(212, 190, 152);
          border: transparent;
          border-radius: 12px;
        }
        
        .inline-reply-button {
          margin-left: 4px;
          background: transparent;
          border: 1px solid rgba(124, 111, 100, 0.95);
          border-radius: 12px;
          color: rgb(212, 190, 152);
        }
        
        .inline-reply-button:disabled {
          background: transparent;
          color: rgba(124, 111, 100, 1);
          border-color: transparent;
        }
        
        .inline-reply-button:hover {
          background: rgba(80, 73, 69, 0.95);
        }
        
        /* Notification close button*/
        .close-button {
          background: transparent;
          color: rgb(212, 190, 152);
          border-radius: 100%;
          margin-top: 5px;
          margin-right: 5px;
          min-width: 24px;
          min-height: 24px;
        }
        
        .close-button:hover {
          background: rgba(80, 73, 69, 0.95);
        }
        
        /* Few other notification settings */
        .image {
          -gtk-icon-effect: none;
          border-radius: 100px;
          margin: 4px;
        }
        
        .app-icon {
          -gtk-icon-effect: none;
          -gtk-icon-shadow: 0 1px 4px black;
          margin: 6px;
        }
        
        .summary {
          font-size: 16px;
          font-weight: bold;
          background: transparent;
          color: rgb(212, 190, 152);
        }
        
        .time {
          font-size: 16px;
          font-weight: bold;
          background: transparent;
          color: rgb(212, 190, 152);
          /* margin-right: 10px; */
        }
        
        .body {
          font-size: 14px;
          font-weight: normal;
          background: transparent;
          color: rgb(212, 190, 152);
          margin-top: 5px;
        }
        
        .body-image {
          margin-top: 4px;
          background-color: white;
          border-radius: 12px;
          -gtk-icon-effect: none;
        }
        
        /* Control-center panel which contains the old notifications + widgets*/
        .control-center {
          background: rgba(37, 36, 35, 0.85);
          color: rgb(212, 190, 152);
          border-radius: 12px;
        }
        .control-center-list-placeholder {
          opacity: 0.5;
        }
        .control-center-list {
          background: transparent;
        }
        
        .blank-window {
          background: transparent;
        }
        
        /* Notification group in control-center */
        .notification-group-buttons,
        .notification-group-headers {
          margin: 0 16px;
          color: rgb(212, 190, 152);
        }
        
        .notification-group-icon {
          color: rgb(212, 190, 152);
        }
        
        .notification-group-header {
          color: rgb(212, 190, 152);
        }
        
        /*** Widgets ***/
        /* Title widget */
        .widget-title {
          color: rgb(212, 190, 152);
          margin: 8px;
          font-size: 20;
        }
        
        .widget-title > button {
          font-size: 16;
          color: rgb(212, 190, 152);
          text-shadow: none;
          background: rgba(37, 36, 35, 0.9);
          border: 1px solid rgba(124, 111, 100, 0.95);
          border-radius: 12px;
        }
        
        .widget-title > button:hover {
          background: rgba(80, 73, 69, 0.9);
        }
        
        /* DND widget */
        .widget-dnd {
          color: rgb(212, 190, 152);
          margin: 8px;
          font-size: 1.1rem;
        }
        
        .widget-dnd > switch {
          font-size: initial;
          border-radius: 12px;
          background: rgba(37, 36, 35, 0.9);
          border: 1px solid rgba(124, 111, 100, 0.95);
          box-shadow: none;
        }
        
        .widget-dnd > switch:checked {
          background: rgba(231, 138, 78, 0.9);
        }
        
        .widget-dnd > switch slider {
          background: rgba(50, 48, 47, 0.95);
          border-radius: 12px;
        }
        
        /* Volume widget */
        .widget-volume {
          color: rgb(212, 190, 152);
          background-color: rgba(60, 56, 54, 0.95);
          padding: 8px;
          margin: 8px;
          border-radius: 12px;
        }
        
        /* Backlight widget */
        .widget-backlight {
          color: rgb(212, 190, 152);
          background-color: rgba(60, 56, 54, 0.95);
          padding: 8px;
          margin: 8px;
          border-radius: 12px;
        }
      '';  
    };
  };
}
