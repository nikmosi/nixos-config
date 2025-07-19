{
  programs.yazi = {
    enable = true;
    initLua = ''
      map("n", "<C-n>", [[
          shell 'ripdrag "$@" -x 2>/dev/null &' --confirm
      ]])
    '';
  };
}
