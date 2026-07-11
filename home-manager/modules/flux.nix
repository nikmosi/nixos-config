{
  config,
  ...
}:
{
  sops = {
    secrets = {
      "age/flux/public" = { };
    };

    templates."sops-flux" = {
      content = ''
        ---
        creation_rules:
          - encrypted_regex: "^(data|stringData)$"
            age: ${config.sops.placeholder."age/flux/public"}
      '';
      path = "/home/nik/git-repos/flux/.sops.yaml";
      mode = "0644";
    };
  };
}
