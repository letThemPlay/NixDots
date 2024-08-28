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
    mako = {
      enable = true;
      font = "JetBrainsMono 10";

      # Enable icons
      icons = true;

      # Timeout settings
      defaultTimeout = 2500;

      # Udiskie has very low timeout so set this
      ignoreTimeout = true;

      # Configuring the look
      backgroundColor = "#d79921";
      textColor = "#1d2021";
      borderColor = "#ebdbb2";
      progressColor = "over #ebdbb2";
      extraConfig = ''
        [urgency=high]
        border-color=#cc241d
      '';
    };

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
    };
  };
}
