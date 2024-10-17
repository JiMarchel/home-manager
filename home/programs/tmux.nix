{
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    clock24 = true;
    mouse = true;
    prefix = "C-a";
    terminal = "tmux-256color";
    extraConfig = ''
      # Menambahkan konfigurasi vim-tmux-navigator secara manual
      bind -n C-h select-pane -L
      bind -n C-j select-pane -D
      bind -n C-k select-pane -U
      bind -n C-l select-pane -R
      bind -n C-\\ select-pane -l

      # Membuat pane tetap sinkron dengan Vim saat berpindah antar pane tmux
      if-shell '[ -n "$TMUX" ]' 'bind -n C-h select-pane -L; bind -n C-j select-pane -D; bind -n C-k select-pane -U; bind -n C-l select-pane -R; bind -n C-\\ select-pane -l'
    '';
  };
}
