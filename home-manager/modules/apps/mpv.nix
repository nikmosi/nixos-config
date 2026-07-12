{
  pkgs,
  config,
  lib,
  ...
}:
let
  translate_subs = "translate_subs";
  anime4k = pkgs.fetchFromGitHub {
    owner = "bloc97";
    repo = "Anime4k";
    tag = "v4.0.1";
    hash = "sha256-OQWJWcDpwmnJJ/kc4uEReaO74dYFlxNQwf33E5Oagb0=";
  };
  shaderPath = dir: file: "~~/shaders/${dir}/${file}";
  anime4kModeAHq =
    "${shaderPath "Restore" "Anime4K_Clamp_Highlights.glsl"}:"
    + "${shaderPath "Restore" "Anime4K_Restore_CNN_VL.glsl"}:"
    + "${shaderPath "Upscale" "Anime4K_Upscale_CNN_x2_VL.glsl"}:"
    + "${shaderPath "Upscale" "Anime4K_AutoDownscalePre_x2.glsl"}:"
    + "${shaderPath "Upscale" "Anime4K_AutoDownscalePre_x4.glsl"}:"
    + shaderPath "Upscale" "Anime4K_Upscale_CNN_x2_M.glsl";
  anime4kModeBHq =
    "${shaderPath "Restore" "Anime4K_Clamp_Highlights.glsl"}:"
    + "${shaderPath "Restore" "Anime4K_Restore_CNN_Soft_VL.glsl"}:"
    + "${shaderPath "Upscale" "Anime4K_Upscale_CNN_x2_VL.glsl"}:"
    + "${shaderPath "Upscale" "Anime4K_AutoDownscalePre_x2.glsl"}:"
    + "${shaderPath "Upscale" "Anime4K_AutoDownscalePre_x4.glsl"}:"
    + shaderPath "Upscale" "Anime4K_Upscale_CNN_x2_M.glsl";
  anime4kModeCHq =
    "${shaderPath "Restore" "Anime4K_Clamp_Highlights.glsl"}:"
    + "${shaderPath "Upscale+Denoise" "Anime4K_Upscale_Denoise_CNN_x2_VL.glsl"}:"
    + "${shaderPath "Upscale" "Anime4K_AutoDownscalePre_x2.glsl"}:"
    + "${shaderPath "Upscale" "Anime4K_AutoDownscalePre_x4.glsl"}:"
    + shaderPath "Upscale" "Anime4K_Upscale_CNN_x2_M.glsl";
  anime4kModeAAHq =
    "${shaderPath "Restore" "Anime4K_Clamp_Highlights.glsl"}:"
    + "${shaderPath "Restore" "Anime4K_Restore_CNN_VL.glsl"}:"
    + "${shaderPath "Upscale" "Anime4K_Upscale_CNN_x2_VL.glsl"}:"
    + "${shaderPath "Restore" "Anime4K_Restore_CNN_M.glsl"}:"
    + "${shaderPath "Upscale" "Anime4K_AutoDownscalePre_x2.glsl"}:"
    + "${shaderPath "Upscale" "Anime4K_AutoDownscalePre_x4.glsl"}:"
    + shaderPath "Upscale" "Anime4K_Upscale_CNN_x2_M.glsl";
  anime4kModeBBHq =
    "${shaderPath "Restore" "Anime4K_Clamp_Highlights.glsl"}:"
    + "${shaderPath "Restore" "Anime4K_Restore_CNN_Soft_VL.glsl"}:"
    + "${shaderPath "Upscale" "Anime4K_Upscale_CNN_x2_VL.glsl"}:"
    + "${shaderPath "Upscale" "Anime4K_AutoDownscalePre_x2.glsl"}:"
    + "${shaderPath "Upscale" "Anime4K_AutoDownscalePre_x4.glsl"}:"
    + "${shaderPath "Restore" "Anime4K_Restore_CNN_Soft_M.glsl"}:"
    + shaderPath "Upscale" "Anime4K_Upscale_CNN_x2_M.glsl";
  anime4kModeCAHq =
    "${shaderPath "Restore" "Anime4K_Clamp_Highlights.glsl"}:"
    + "${shaderPath "Upscale+Denoise" "Anime4K_Upscale_Denoise_CNN_x2_VL.glsl"}:"
    + "${shaderPath "Upscale" "Anime4K_AutoDownscalePre_x2.glsl"}:"
    + "${shaderPath "Upscale" "Anime4K_AutoDownscalePre_x4.glsl"}:"
    + "${shaderPath "Restore" "Anime4K_Restore_CNN_M.glsl"}:"
    + shaderPath "Upscale" "Anime4K_Upscale_CNN_x2_M.glsl";
in
{
  config = lib.mkIf config.local.apps.mpv.enable {
    programs.mpv = {
      enable = true;
      config = {
        cache = "yes";
        cache-secs = 60;
        cache-pause = "no";
        ytdl-format = "best";
        demuxer-max-bytes = "1000MiB";
        demuxer-max-back-bytes = "500MiB";
        vo = "gpu";
        gpu-api = "opengl";
        gpu-context = "x11egl";
        hwdec = "nvdec-copy";
        glsl-shaders = anime4kModeAHq;
      };
    };

    home.file = {
      ".config/mpv/input.conf" = {
        text = ''
          q quit_watch_later
          Q quit
          CTRL+1 no-osd change-list glsl-shaders set "${anime4kModeAHq}"; show-text "Anime4K: Mode A (HQ)"
          CTRL+2 no-osd change-list glsl-shaders set "${anime4kModeBHq}"; show-text "Anime4K: Mode B (HQ)"
          CTRL+3 no-osd change-list glsl-shaders set "${anime4kModeCHq}"; show-text "Anime4K: Mode C (HQ)"
          CTRL+4 no-osd change-list glsl-shaders set "${anime4kModeAAHq}"; show-text "Anime4K: Mode A+A (HQ)"
          CTRL+5 no-osd change-list glsl-shaders set "${anime4kModeBBHq}"; show-text "Anime4K: Mode B+B (HQ)"
          CTRL+6 no-osd change-list glsl-shaders set "${anime4kModeCAHq}"; show-text "Anime4K: Mode C+A (HQ)"
          CTRL+0 no-osd change-list glsl-shaders clr ""; show-text "GLSL shaders cleared"
        '';
      };

      ".config/mpv/shaders" = {
        source = "${anime4k}/glsl";
        recursive = true;
      };

      ".config/mpv/scripts/recent.lua" = {
        source = builtins.fetchurl {
          url = "https://raw.githubusercontent.com/nikmosi/recent/master/recent.lua";
          sha256 = "sha256:1kc998vyq43jijrflsp2fn79b52fp6pblr2hc01gwynd2msdki4v";
        };
      };

      ".config/mpv/scripts/${translate_subs}.lua" = {
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
    };

  };
}
