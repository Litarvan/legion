modules:

# It seems that '...' does not catch some of the default arguments, and we have to explicitly require them (such as 'pkgs')
{ config, pkgs, ... } @ args:

{
  imports = map
    (module: {
      home-manager.users.litarvan = module (args // { config = config.home-manager.users.litarvan; });
    })
    modules;
}
