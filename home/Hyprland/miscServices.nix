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
        positionX = "right";
        positionY = "top";
        layer = "overlay";
        layer-shell = true;
        cssPriority = "application";
        control-center-margin-top = 10;
        control-center-margin-bottom = 10;
        control-center-margin-right = 10;
        control-center-margin-left = 10;
        notification-icon-size = 64;
        notification-body-image-height = 100;
        notification-body-image-width = 200;
        timeout = 10;
        timeout-low = 5;
        timeout-critical = 0;
        fit-to-screen = true;
        control-center-width = 400;
        control-center-height = 650;
        notification-window-width = 350;
        keyboard-shortcuts = true;
        image-visibility = "when-available";
        transition-time = 200;
        hide-on-clear = false;
        hide-on-action = true;
        script-fail-notify = true;

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
    };
  };
}
