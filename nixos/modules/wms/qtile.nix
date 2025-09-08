{ qtileDeps, ... }:
{
  services.xserver.windowManager = {
    qtile = {
      enable = true;
      extraPackages = python312Packages: qtileDeps;
    };
  };
}
