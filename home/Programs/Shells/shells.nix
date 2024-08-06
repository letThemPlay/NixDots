{ pkgs, ... }:
let
  myShellAliases = {
    ll = "ls -l";
    ".." = "cd ..";
    "svim" = "sudo vim";
    syscon = "cd /etc/nixos/";
    update = "sudo nixos-rebuild switch";
  };
  extraRc = ''
    export WLR_NO_HARDWARE_CURSORS="1";
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
        "/home/chris/.config/home-manager"
        "/home/chris"
      ];
      history.size = 100;

      oh-my-zsh = {
        enable = true;
        theme = "random";
      };

      shellAliases = myShellAliases;

      initExtra = extraRc;
    };

    bash = {
      enable = true;
      shellAliases = myShellAliases;
      initExtra = extraRc;
    };
  };

  home.packages = with pkgs; [
    # For oh-my-zsh theme 'humza'
    bc
  ];
}
