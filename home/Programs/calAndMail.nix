{ pkgs, config, ... }:
let
  myHome = config.home.homeDirectory;
in
{
  programs = {
    neomutt = {
      enable = true;
      editor = "$EDITOR";
      package = pkgs.neomutt;

      sidebar = {
        enable = true;
        format = "%D%?F? [%F]?%* %?N?%N/?%S";
        shortPath = true;
        width = 22;
      };

      settings = {
        my_name = "Rachit Kumar Verma";
      };
    };
  };

  # Set up email and other online accounts here
  accounts = {
    email = {
      maildirBasePath = "${myHome}/Mails";
      accounts = {
        chris = {
          primary = true;
          address = "rachitverma1122@gmail.com";
          imap = {
            host = "imap.exmaple.org";
            tls = { };
          };
          neomutt = {
            enable = true;
            mailboxName = "-> <MyMails> <-";
            mailboxType = "imap";
          };
        };
      };
    };
  };
}
