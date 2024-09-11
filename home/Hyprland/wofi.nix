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
      {
        font-family: "JetBrainsMono Nerd Font";
        color: #d5c4a1;
      }
      
      window {
        border: 3px solid #b8bb26;
        background: #1D2021;
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
}
