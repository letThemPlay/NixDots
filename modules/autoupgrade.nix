{ inputs, ... }:

{
  system.autoUpgrade = {
    enable = true;
    allowReboot = false;
    flake = inputs.self.outPath;
    flags = [
      "--upgrade"
      "--option fallback false"
      "--update-input nixos-hardware --update-input home-manager --update-input nixpkgs"
      "-L"
    ];
    dates = "02:00";
    randomizedDelaySec = "45min";
  };
}
