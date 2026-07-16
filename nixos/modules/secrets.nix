{
  config,
  userSettings,
  ...
}:
let
  passwordKey = "user/${userSettings.username}/password";
in
{
  sops = {
    defaultSopsFile = ../../secrets/personal.yaml;
    age.generateKey = false;
    age.keyFile = "/var/lib/sops-nix/age/keys.txt";

    secrets.${passwordKey} = {
      neededForUsers = true;
    };
  };

  # Temporarily disabled — enable after verifying sops decryption works
  # users.mutableUsers = false;
  users.users.${userSettings.username} = {
    hashedPasswordFile = config.sops.secrets.${passwordKey}.path;
  };
}
