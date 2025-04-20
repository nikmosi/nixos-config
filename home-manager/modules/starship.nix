let
  commonFormat = ''\[[$symbol($version)]($style)\]'';
in
{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
    settings = {
      command_timeout = 1000;

      aws.format = ''\[[$symbol($profile)(\($region\))($duration)]($style)\]'';

      c.format = ''\[[$symbol($version(-$name))]($style)\]'';

      cmd_duration.format = ''\[[ $duration ]($style)\]'';

      conda.format = ''\[[$symbol$environment]($style)\]'';

      docker_context.format = ''\[[$symbol$context]($style)\]'';

      dotnet.format = ''\[[$symbol($version)(🎯 $tfm)]($style)\]'';

      elixir.format = ''\[[$symbol($version (OTP $otp_version))]($style)\]'';

      fossil_branch.format = ''\[[$symbol$branch]($style)\]'';

      gcloud.format = ''\[$symbol$account(@$domain)($region)]($style)'';

      git_status.format = ''([\[$all_status$ahead_behind\]]($style))'';

      guix_shell.format = ''\[[$symbol]($style)\]'';

      hg_branch.format = ''\[[$symbol$branch]($style)\]'';

      kubernetes.format = ''\[[$symbol$context( \($namespace\))]($style)\]'';

      memory_usage.format = ''\[$symbol[$ram( | $swap)]($style)\]'';

      meson.format = ''\[[$symbol$project]($style)\]'';

      ocaml.format = ''\[[$symbol($version)(\($switch_indicator$switch_name\))]($style)\]'';

      openstack.format = ''\[[$symbol$cloud(\($project\))]($style)\]'';

      os.format = ''\[[$symbol]($style)\]'';

      pijul_channel.format = ''\[[$symbol$channel]($style)\]'';

      pulumi.format = ''\[[$symbol$stack]($style)\]'';

      raku.format = ''\[[$symbol($version-$vm_version)]($style)\]'';

      spack.format = ''\[[$symbol$environment]($style)\]'';

      sudo.format = ''\[[as $symbol]($style)\]'';

      terraform.format = ''\[[$symbol$workspace]($style)\]'';

      time.format = ''\[[$time]($style)\]'';

      username.format = ''\[[$user]($style)\]'';

      directory = {
        read_only = '''';
        read_only_style = ''fg:#8ABEB7'';
        format = ''[$path]($style)[$read_only]($read_only_style) '';
      };

      git_branch = {
        symbol = '' '';
        format = ''\[ [$symbol$branch]($style) \]'';
      };

      lua = {
        format = commonFormat;
        detect_folders = [ ];
      };

      nix_shell = {
        impure_msg = ''i'';
        symbol = ''❄️'';
        pure_msg = ''p'';
        unknown_msg = ''u'';
        format = ''\[[$symbol $state \($name\)]($style)\]'';
      };

      package = {
        symbol = ''󰏗 '';
        format = ''\[[$symbol$version]($style)\]'';
      };

      python = {
        symbol = '' '';
        format = ''\[[$symbol$pyenv_prefix($version)( \($virtualenv\))]($style)\]'';
      };

      vagrant.format = commonFormat;
      vlang.format = commonFormat;
      zig.format = commonFormat;
      solidity.format = commonFormat;
      bun.format = commonFormat;
      cmake.format = commonFormat;
      cobol.format = commonFormat;
      crystal.format = commonFormat;
      daml.format = commonFormat;
      dart.format = commonFormat;
      deno.format = commonFormat;
      elm.format = commonFormat;
      erlang.format = commonFormat;
      fennel.format = commonFormat;
      golang.format = commonFormat;
      gradle.format = commonFormat;
      haskell.format = commonFormat;
      haxe.format = commonFormat;
      helm.format = commonFormat;
      java.format = commonFormat;
      julia.format = commonFormat;
      kotlin.format = commonFormat;
      nim.format = commonFormat;
      nodejs.format = commonFormat;
      opa.format = commonFormat;
      perl.format = commonFormat;
      php.format = commonFormat;
      purescript.format = commonFormat;
      red.format = commonFormat;
      ruby.format = commonFormat;
      rust.format = commonFormat;
      scala.format = commonFormat;
      swift.format = commonFormat;
    };
  };
}
