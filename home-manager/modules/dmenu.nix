{ pkgs, lib, ... }:
{
  programs.dmenu = {
    enable = true;
    package = pkgs.dmenu.overrideAttrs (old: {
      patches = (old.patches or [ ]) ++ [
        # Border patch
        (pkgs.fetchpatch {
          sha256 = lib.fakeSha256; # Replace with actual hash
        })
        # Center patch
        (pkgs.fetchpatch {
          url = "https://tools.suckless.org/dmenu/patches/center/dmenu-center-4.9.diff";
          sha256 = lib.fakeSha256; # Replace with actual hash
        })
        # Fuzzy match patch
        (pkgs.fetchpatch {
          url = "https://tools.suckless.org/dmenu/patches/fuzzymatch/dmenu-fuzzymatch-4.9.diff";
          sha256 = lib.fakeSha256; # Replace with actual hash
        })
        # Line height patch
        (pkgs.fetchpatch {
          url = "https://tools.suckless.org/dmenu/patches/line-height/dmenu-lineheight-4.9.diff";
          sha256 = lib.fakeSha256; # Replace with actual hash
        })
      ];
    });
  };
}
