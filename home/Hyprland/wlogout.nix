{pkgs, ...}:
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
        keybind = "s";
      }

      {
        label = "suspend";
        action = "systemctl suspend";
        text = "Sleep";
        keybind = "u";
      }

      {
        label = "lock";
        action = "loginctl lock-session";
        text = "Lock the screen";
        keybind = "l";
      }

      {
        label = "reboot";
        action = "systemctl reboot";
        text = "Reboot";
        keybind = "r";
      }

      {
        label = "logout";
        action = "loginctl terminate-user";
        text = "Logout";
        keybind = "e";
      }
    ];
  };
}
