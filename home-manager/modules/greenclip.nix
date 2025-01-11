{
  home.file = {
    ".config/greenclip.toml".text = ''
      [greenclip]
      history_file = "/home/nik/.cache/greenclip.history"
      max_history_length = 1000
      max_selection_size_bytes = 0
      trim_space_from_selection = true
      use_primary_selection_as_input = false
      blacklisted_applications = [ 'fzf-passwordstore' ]
      enable_image_support = true
      image_cache_directory = "/tmp/greenclip"
      static_history = [
       '''¯\_(ツ)_/¯''',
      ]
    '';
  };
}