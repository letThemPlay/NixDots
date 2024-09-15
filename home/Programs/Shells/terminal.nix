{ pkgs, ... }:
{
  programs = {
    kitty = {
      enable = true;
      font = {
        name = "JetBrainsMono Nerd Font";
        size = 14;
      };
      shellIntegration = {
        enableBashIntegration = true;
        enableZshIntegration = true;
      };

      # Uncomment background_opacity and background_blur to
      # Enable blur and transparency.
      extraConfig = '' 
      confirm_os_window_close 0
      '';
      theme = "Catppuccin-Mocha";
    };

    # The lightweight wayland terminal
    foot = {
      enable = true;
      package = pkgs.foot;
      settings = {
        main = {
          term = "xterm-256color";
          font = "JetBrainsMono Nerd Font:size=9";
          dpi-aware = "yes";
        };
        mouse = {
          hide-when-typing = "yes";
        };
      };
    };
  };
}
