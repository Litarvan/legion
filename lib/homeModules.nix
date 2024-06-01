modules:

{ config, ... } @ args:

{
  imports = map
    (module: {
      home-manager.users.litarvan = module (args // { config = config.home-manager.users.litarvan; });
    })
    modules;
}
