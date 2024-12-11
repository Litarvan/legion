{
  systemsCommon = import ../systemsCommon.nix;

  core = import ./core.nix;
  graphical = import ./graphical.nix;

  hardware = {
    cpu = {
      amd = import ./hardware/cpu/amd.nix;
      intel = import ./hardware/cpu/intel.nix;
    };

    gpu = {
      amd = import ./hardware/gpu/amd.nix;
      nvidia = import ./hardware/gpu/nvidia.nix;
    };

    bluetooth = import ./hardware/bluetooth.nix;
    hidpi = import ./hardware/hidpi.nix;
    nvme = import ./hardware/nvme.nix;
    touchpad = import ./hardware/touchpad.nix;
  };
}
