{ ... }:

{
  system.defaults.NSGlobalDomain.ApplePressAndHoldEnabled = false;

  security.pam.services.sudo_local.touchIdAuth = true;

  programs.vim.enableSensible = true;

  environment.variables.SSH_AUTH_SOCK = "/Users/litarvan/.gnupg/S.gpg-agent.ssh";
}
