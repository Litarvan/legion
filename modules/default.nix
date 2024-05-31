{
  base = {
    core = import ./base/core.nix;
    graphical = import ./base/graphical.nix;
    users = import ./base/users.nix;
  };

  hardware = {
    cpu = {
      amd = import ./hardware/cpu/amd.nix;
      intel = import ./hardware/cpu/intel.nix;
    };

    gpu = {
      amd = import ./hardware/gpu/amd.nix;
    };

    bluetooth = import ./hardware/bluetooth.nix;
    hidpi = import ./hardware/hidpi.nix;
    nvme = import ./hardware/nvme.nix;
    touchpad = import ./hardware/touchpad.nix;
  };
}
