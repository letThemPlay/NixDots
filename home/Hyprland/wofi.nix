{ pkgs, ... }:

{
  programs.wofi = {
    enable = true;

    package =  pkgs.wofi;

    settings = {
      width=600;
      height = 500;
      location = "center";
      show = "drun";
      prompt = "Apps";
      filter_rate = 100;
      allow_markup = true;
      no_actions = true;
      halign = "fill";
      orientation = "vertical";
      content_halign = "fill";
      insensitive = true;
      allow_images = true;
      image_size = 40;
      gtk_dark = true; 
    };


    style = ''
      @import "mocha.css"
      {
        font-family: "JetBrainsMono Nerd Font";
        color: #d5c4a1;
      }
      
      window {
        border: 3px solid #b8bb26;
        background: #3c3836;
        border-radius: 15px;
      }
      
      #input {
        margin: 1.5em;
        margin-bottom: 0em;
        padding: 1em;
        border: none;
        font-weight: bold;
        border: 1px solid transparent;
        background: #928374;
        color: #fe8019;
        border-radius: 15px;
      }
      
      #input:focus {
        border: 1px solid #83a598;
      }
      
      #inner-box {
        margin: 1.5em;
        margin-top: 0.5em;
      }
      
      #outer-box {
        margin-bottom: 0.5em;
      }
      
      #scroll {
        margin-top: 5px 0;
        display: none;
      }
      
      #text {
        margin-left: 0.5em;
        color: #fbf1c7;
      }
      
      #text:selected {
        color: #16161e;
      }
      
      #entry {
        margin-top: 0.5em;
        border-radius: 15px;
      }
      
      #entry:selected {
        background: linear-gradient(90deg, #fabd2f 0%, #d3869b 80%);
      }
    '';
  };

  home.file.".config/wofi/mocha.css".text = ''
    /*
     *
     * Catppuccin Mocha palette
     * Maintainer: rubyowo
     *
     */
     
     @define-color base   #1e1e2e;
     @define-color mantle #181825;
     @define-color crust  #11111b;
     
     @define-color text     #cdd6f4;
     @define-color subtext0 #a6adc8;
     @define-color subtext1 #bac2de;
     
     @define-color surface0 #313244;
     @define-color surface1 #45475a;
     @define-color surface2 #585b70;
     
     @define-color overlay0 #6c7086;
     @define-color overlay1 #7f849c;
     @define-color overlay2 #9399b2;
     
     @define-color blue      #89b4fa;
     @define-color lavender  #b4befe;
     @define-color sapphire  #74c7ec;
     @define-color sky       #89dceb;
     @define-color teal      #94e2d5;
     @define-color green     #a6e3a1;
     @define-color yellow    #f9e2af;
     @define-color peach     #fab387;
     @define-color maroon    #eba0ac;
     @define-color red       #f38ba8;
     @define-color mauve     #cba6f7;
     @define-color pink      #f5c2e7;
     @define-color flamingo  #f2cdcd;
     @define-color rosewater #f5e0dc;
  '';
}
