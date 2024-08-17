{
  users.extraGroups.vboxusers.members = [ "chris" ];
  virtualisation = {
    virtualbox = {
      host = {
        enable = true;
      };

      guest = {
        enable = true;
        dragAndDrop = true;
      };
    };
  };
}
