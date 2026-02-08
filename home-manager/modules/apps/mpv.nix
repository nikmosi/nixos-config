let
  translate_subs = "translate_subs";
in
{
  programs.mpv = {
    enable = true;
    config = {
      cache = "yes";
      cache-secs = 60;
      cache-pause = "no";
      ytdl-format = "best";
      demuxer-max-bytes = "1000MiB";
      demuxer-max-back-bytes = "500MiB";
    };
  };

  home.file.".config/mpv/input.conf" = {
    text = ''
      q quit_watch_later
      Q quit
    '';
  };

  home.file.".config/mpv/scripts/recent.lua" = {
    source = builtins.fetchurl {
      url = "https://raw.githubusercontent.com/nikmosi/recent/master/recent.lua";
      sha256 = "sha256:1kc998vyq43jijrflsp2fn79b52fp6pblr2hc01gwynd2msdki4v";
    };
  };

  home.file.".config/mpv/scripts/${translate_subs}.lua" = {
    text = ''
      local msg = require 'mp.msg'
      local utils = require 'mp.utils'

      function translate_sub()
          local sub_text = mp.get_property("sub-text")
          if not sub_text or sub_text == "" then
              mp.osd_message("No subtitles available")
              return
          end

          -- External call to your translator script (e.g., using curl and jq)
          local args = {
              "bash", "-c",
              string.format("trans -b -t ru \"%s\"", sub_text)
          }

          local res = utils.subprocess({ args = args, cancellable = false })
          if res.status == 0 then
              mp.osd_message("→ " .. res.stdout, 4)
          else
              mp.osd_message("Translation failed")
          end
      end

      mp.add_key_binding("F9", "translate-sub", translate_sub)
    '';
  };

}
