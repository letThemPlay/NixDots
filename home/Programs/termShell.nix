{ pkgs, config, ... }:
let
  themix = config.colorScheme.palette;
  myShellAliases = {
    ll = "ls -l";
    ".." = "cd ..";
    svi = "sudo vim";
    syscon = "cd /etc/nixos/";
    update = "sudo nixos-rebuild switch";
    backit = "cp -r /etc/nixos/* /home/chris/.dotfiles/NixDots/";
  };
  extraRc = /*bash*/''
    export WLR_NO_HARDWARE_CURSORS="1";

    function yy() {
    	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    	yazi "$@" --cwd-file="$tmp"
    	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    		builtin cd -- "$cwd"
    	fi
    	rm -f -- "$tmp"
    }
  '';
in
{
  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      autosuggestion = {
        enable = true;
        strategy = [ "completion" ];
      };
      cdpath = [
        "/etc/nixos/"
        "/home/chris"
      ];
      history.size = 100;
      dotDir = ".config/zsh";
      dirHashes = {
        docs = "$HOME/Documents";
        vids = "$HOME/Videos";
        dl = "$HOME/Downloads";
      };

      oh-my-zsh = {
        enable = true;
        theme = "random";
        plugins = [
          "git"
          "emotty"
          "emoji"
          "sudo"
          "colored-man-pages"
          "colorize"
        ];
      };

      shellAliases = myShellAliases;

      initExtra = extraRc;
    };

    bash = {
      enable = true;
      shellAliases = myShellAliases;
      initExtra = extraRc;
    };

    # The lightweight wayland terminal
    # foot = {
    #   enable = true;
    #   package = pkgs.foot;
    #   settings = {
    #     main = {
    #       term = "xterm-256color";
    #       font = "JetBrainsMono Nerd Font:size=9";
    #       dpi-aware = "yes";
    #     };
    #     mouse = {
    #       hide-when-typing = "yes";
    #     };
    #
    #     cursor = {
    #       style = "beam";
    #       blink = "yes";
    #       blink-rate = 500;
    #       beam-thickness = 1.0;
    #     };
    #
    #     colors = {
    #       foreground = "${themix.base05}";
    #       background = "${themix.base00}";
    #       regular0 = "${themix.base03}";
    #       regular1 = "${themix.base08}";
    #       regular2 = "${themix.base0B}";
    #       regular3 = "${themix.base0A}";
    #       regular4 = "${themix.base0D}";
    #       regular5 = "f5c2e7";
    #       regular6 = "${themix.base0C}";
    #       regular7 = "bac2de";
    #       bright0 = "${themix.base04}";
    #       bright1 = "${themix.base08}";
    #       bright2 = "${themix.base0B}";
    #       bright3 = "${themix.base0A}";
    #       bright4 = "${themix.base0D}";
    #       bright5 = "f5c2e7";
    #       bright6 = "${themix.base0C}";
    #       bright7 = "a6adc8";
    #       selection-foreground = "${themix.base05}";
    #       selection-background = "414356";
    #       search-box-no-match = "11111b ${themix.base08}";
    #       search-box-match = "${themix.base05} ${themix.base02}";
    #       jump-labels = "11111b ${themix.base09}";
    #       urls = "${themix.base0D}";
    #     };
    #   };
    # Foot does not support png output (try fastfetch in foot and kitty both)

    kitty = {
      enable = true;
      font = {
        name = "Iosevka Nerd Font";
        size = 14;
      };
      # themeFile = "GruvboxMaterialDarkHard";
      package = pkgs.kitty;
      shellIntegration = {
        enableBashIntegration = true;
        enableZshIntegration = true;
      };
      settings = {
        confirm_os_window_close = 0;
        background_blur = 0;
        background_opacity = "1";

        # Set the theme here by matching any theme file and then using nix-colors to style it up
        background = "#${themix.base00}";
        foreground = "#${themix.base05}";

        selection_background = "#${themix.base05}";
        selection_foreground = "#${themix.base00}";

        cursor = "#${themix.base05}";
        cursor_text_color = "background";

        # black
        color0 = "#${themix.base02}";
        color8 = "#${themix.base03}";

        # Red 
        color1 = "#${themix.base08}";
        color9 = "#${themix.base08}";

        # Green
        color2 = "#${themix.base0B}";
        color10 = "#${themix.base0B}";

        # Yellow
        color3 = "#${themix.base09}";
        color11 = "#${themix.base0A}";

        # Blue
        color4 = "#${themix.base0D}";
        color12 = "#${themix.base0D}";

        # Magenta
        color5 = "#${themix.base0E}";
        color13 = "#${themix.base0E}";

        # Cyan
        color6 = "#${themix.base0C}";
        color14 = "#${themix.base0C}";

        # White
        color7 = "#${themix.base07}";
        color15 = "#${themix.base07}";
      };
    };
  };
}

