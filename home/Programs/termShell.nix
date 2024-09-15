{ config, pkgs, ... }:
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

    # # Start the SSH agent if it's not already running
    # if [ -z "$SSH_AUTH_SOCK" ]; then
    #     eval "$(ssh-agent -s)" > /dev/null
    # fi
    #
    # # Add SSH key only if it's not already added
    # if ! ssh-add -l | grep -q "$(ssh-keygen -lf ~/.ssh/id_ed25519 | awk '{print $2}')"; then
    #     ssh-add ~/.ssh/id_ed25519 > /dev/null
    # fi

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

      oh-my-zsh = {
        enable = true;
        theme = "junkfood";
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

        cursor = {
          style = "beam";
          blink = "yes";
          blink-rate = 500;
          beam-thickness = 1.0;
        };

        colors = {
          foreground = "${themix.base05}";
          background = "${themix.base00}";
          regular0 = "${themix.base03}";
          regular1 = "${themix.base08}";
          regular2 = "${themix.base0B}";
          regular3 = "${themix.base0A}";
          regular4 = "${themix.base0D}";
          regular5 = "f5c2e7";
          regular6 = "${themix.base0C}";
          regular7 = "bac2de";
          bright0 = "${themix.base04}";
          bright1 = "${themix.base08}";
          bright2 = "${themix.base0B}";
          bright3 = "${themix.base0A}";
          bright4 = "${themix.base0D}";
          bright5 = "f5c2e7";
          bright6 = "${themix.base0C}";
          bright7 = "a6adc8";
          selection-foreground = "${themix.base05}";
          selection-background = "414356";
          search-box-no-match = "11111b ${themix.base08}";
          search-box-match = "${themix.base05} ${themix.base02}";
          jump-labels = "11111b ${themix.base09}";
          urls = "${themix.base0D}";
        };
      };
    };
  };
}
