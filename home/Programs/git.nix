{
  programs = {
    git = {
      enable = true;
      userEmail = "rachitverma1122@gmail.com";
      userName = "rachitve6h2g";
    };

    ssh = {
      enable = true;
      addKeysToAgent = "yes";
      extraConfig = ''
        Host github.com
        IdentityFile ~/.ssh/id_ed25519
      '';
    };
  };

  home.file = {
    "ssh/id_ed25519".source = ./ssh/id_ed25519;
    "ssh/id_ed25519.pub".source = ./ssh/id_ed25519.pub;
  };

  services = {
    ssh-agent = {
      enable = true;
    };
  };
}
