{
  programs.helix = {
    enable = true;
    settings = {
      editor = {
        line-number = "relative";
      };
      editor.cursor-shape = {
        normal = "block";
        insert = "bar";
        select = "underline";
      };
      theme = "base16_terminal";
    };
  };
}
