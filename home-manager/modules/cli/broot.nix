_: {
  xdg.configFile."broot/conf.hjson" = {
    force = true;
    text = ''
      show_selection_mark: true
      special_paths: {
          "/media" : {
              list: "never"
              sum: "never"
          }
          "~/.config": { "show": "always" }
          "trav": {
              show: always
              list: "always",
              sum: "never"
          }
      }
      content_search_max_file_size: 10MB
      enable_kitty_keyboard: false
      lines_before_match_in_preview: 1
      lines_after_match_in_preview: 1
      preview_transformers: []
      imports: [
          verbs.hjson
          {
              luma: [dark unknown]
              file: skins/dark-blue.hjson
          }
          {
              luma: light
              file: skins/white.hjson
          }
      ]
    '';
  };
}
