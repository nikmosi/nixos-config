{ config, userSettings, ... }:
let
  passwordKey = "user/${userSettings.username}/password";
in
{
  sops = {
    defaultSopsFile = ../../secrets/personal.yaml;
    age.generateKey = false;
    gnupg.sshKeyPaths = [ ];

    secrets.${passwordKey} = {
      neededForUsers = true;
    };
  };

  users.mutableUsers = false;
  users.users.${userSettings.username} = {
    hashedPasswordFile = config.sops.secrets.${passwordKey}.path;
  };
}
