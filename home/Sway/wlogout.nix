{ pkgs, ... }:
{
  programs.wlogout = {
    enable = true;
    package = pkgs.wlogout;

    layout = [
      {
        label = "shutdown";
        action = "systemctl poweroff";
        text = "Shutdown";
        circular = true;
      }

      {
        label = "suspend";
        action = "systemctl suspend";
        text = "Sleep";
      }

      {
        label = "lock";
        action = "swaylock";
        text = "Lock the screen";
      }

      {
        label = "reboot";
        action = "systemctl reboot";
        text = "Reboot";
      }

      {
        label = "logout";
        action = "swaymsg exit";
        text = "Logout";
      }
    ];
  };
}
