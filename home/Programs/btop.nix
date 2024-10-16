{ config, pkgs, ... }:
let
  themix = config.colorScheme.palette;
in
{
  programs.btop = {
    enable = true;
    package = pkgs.btop;

    settings = {
      color_theme = "myTheme"; # See the xdg.configFile below
      theme_background = true;
      vim_keys = true;
    };
  };
  xdg.configFile."btop/themes/myTheme.theme".text = # php
    ''
      # Btop gruvbox material dark (https://github.com/sainnhe/gruvbox-material) theme
      # by Marco Radocchia

      # Colors should be in 6 or 2 character hexadecimal or single spaced rgb decimal: "#RRGGBB", "#BW" or "0-255 0-255 0-255"
      # example for white: "#FFFFFF", "#ff" or "255 255 255".

      # All graphs and meters can be gradients
      # For single color graphs leave "mid" and "end" variable empty.
      # Use "start" and "end" variables for two color gradient
      # Use "start", "mid" and "end" for three color gradient

      # Main background, empty for terminal default, need to be empty if you want transparent background
      theme[main_bg]="#${themix.base00}"

      # Main text color
      theme[main_fg]="#${themix.base05}"

      # Title color for boxes
      theme[title]="#${themix.base05}"

      # Highlight color for keyboard shortcuts
      theme[hi_fg]="#${themix.base08}"

      # Background color of selected items
      theme[selected_bg]="#${themix.base0A}"

      # Foreground color of selected items
      theme[selected_fg]="#${themix.base00}"

      # Color of inactive/disabled text
      theme[inactive_fg]="#${themix.base00}"

      # Color of text appearing on top of graphs, i.e uptime and current network graph scaling
      theme[graph_text]="#${themix.base02}"

      # Misc colors for processes box including mini cpu graphs, details memory graph and details status text
      theme[proc_misc]="#${themix.base0B}"

      # Cpu box outline color
      theme[cpu_box]="#${themix.base03}"

      # Memory/disks box outline color
      theme[mem_box]="#${themix.base03}"

      # Net up/down box outline color
      theme[net_box]="#${themix.base03}"

      # Processes box outline color
      theme[proc_box]="#${themix.base03}"

      # Box divider line and small boxes line color
      theme[div_line]="#${themix.base03}"

      # Temperature graph colors
      theme[temp_start]="#${themix.base0D}"
      theme[temp_mid]="#${themix.base09}"
      theme[temp_end]="#${themix.base08}"

      # CPU graph colors
      theme[cpu_start]="#${themix.base0B}"
      theme[cpu_mid]="#${themix.base0A}"
      theme[cpu_end]="#${themix.base08}"

      # Mem/Disk free meter
      theme[free_start]="#${themix.base0C}"
      theme[free_mid]=""
      theme[free_end]=""

      # Mem/Disk cached meter
      theme[cached_start]="#${themix.base0D}"
      theme[cached_mid]=""
      theme[cached_end]=""

      # Mem/Disk available meter
      theme[available_start]="#${themix.base0A}"
      theme[available_mid]=""
      theme[available_end]=""

      # Mem/Disk used meter
      theme[used_start]="#${themix.base08}"
      theme[used_mid]=""
      theme[used_end]=""

      # Download graph colors
      theme[download_start]="#${themix.base09}"
      theme[download_mid]=""
      theme[download_end]=""

      # Upload graph colors
      theme[upload_start]="#${themix.base0E}"
      theme[upload_mid]=""
      theme[upload_end]=""
    '';
}
