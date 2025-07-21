{
  programs.ripgrep = {
    enable = true;
    arguments = [
      "--smart-case"
      "--hidden"
      "--glob=!**/.git/*"
      "--color=auto"

      "--colors=path:fg:0xbd,0x93,0xf9"
      "--colors=line:fg:0x50,0xfa,0x7b"
      "--colors=column:fg:0x50,0xfa,0x7b"
      "--colors=match:fg:0xff,0x55,0x55"
    ];
  };
}
