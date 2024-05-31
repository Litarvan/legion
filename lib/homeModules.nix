modules:

{ ... } @ args:

{
  imports = map
    (module: {
      home-manager.users.litarvan = module args;
    })
    modules;
}
