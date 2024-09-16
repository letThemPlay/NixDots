{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Some Nerd fonts
    (nerdfonts.override { fonts = [ "Iosevka" "FantasqueSansMono" ]; })

    # Normal ones
    noto-fonts-emoji
    noto-fonts-cjk
    noto-fonts
  ]; 
  fonts = {
    fontconfig= {
      enable = true;
      defaultFonts = {
        serif = [ "Noto Serif" ];
        sansSerif = [ "Noto Sans" ];
        monospace = [ "FantasqueSansM" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
