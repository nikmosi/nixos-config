{ config, userSettings, ... }:
let
  passwordKey = "user/${userSettings.username}/password";
in
{
  sops = {
    defaultSopsFile = ../../secrets/personal.yaml;
    age.generateKey = false;
    # age SSH host key used for decryption (default: /etc/ssh/ssh_host_ed25519_key)
    # PGP key is used by home-manager (envs.nix) for user-level secrets

    secrets.${passwordKey} = {
      neededForUsers = true;
    };
  };

  users.mutableUsers = false;
  users.users.${userSettings.username} = {
    hashedPasswordFile = config.sops.secrets.${passwordKey}.path;
  };
}
