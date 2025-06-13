_: {
  programs.swaylock = {
    enable = true;
    settings = {
      clock = true;
      datestr = "%Y年%m月%d日 星期%w";
      font-size = 24;
      hide-input = false;
      indicator-idle-visible = false;
      indicator-radius = 100;
      line-color = "ffffff";
      show-failed-attempts = true;
      timestr = "%H:%M:%S";
    };
  };
}
