modules:

{ ... } @ args:

{
  imports = map
    (path: {
      home-manager.users.litarvan = import path args;
    })
    modules;
}
