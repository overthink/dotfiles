{ config, pkgs, lib, ... }:

{
  home.username = "mark";
  home.homeDirectory = "/home/mark";
  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    age
    coreutils
    curl
    direnv
    docker
    gawk
    gnupg
    gnused
    go
    htop
    jq
    k9s
    kubectl
    openssh
    python3
    ripgrep
    shellcheck
    sops
    tree
    wget
    yq-go
    sqlite
    duckdb
  ];

  home.shellAliases = {
    ls = "ls --color=auto";
    ll = "ls -laF";
  };

  programs.atuin = {
    enable = true;
    enableBashIntegration = true;
    settings = {
      inline_height = 30;
    };
  };

  programs.readline = {
    enable = true;
    extraConfig = ''
      set editing-mode vi
    '';
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    initExtra = ''
      source ~/.nix-profile/share/git/contrib/completion/git-prompt.sh
      export PS1='\w $(__git_ps1 "(%s) ")$ '
    '';
  };

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    defaultCommand = "rg --files --ignore-vcs --hidden";
  };

  programs.git = {
    enable = true;
    userName = "overthink";
    userEmail = "mark.feeney@gmail.com";
    aliases = {
      ci = "commit";
      co = "checkout";
      st = "status";
      ff = "!git merge --ff-only";
    };
    delta = {
      enable = true;
    };
    ignores = [
      ".netrwhist"
      "*.swp"
    ];
    extraConfig = {
      # Sign all commits using ssh key
      commit.gpgsign = true;
      gpg.format = "ssh";
      gpg.ssh.allowedSignersFile = "~/.ssh/allowed_signers";
      user.signingkey = "~/.ssh/id_ed25519.pub";
    };
  };

  programs.tmux = {
    enable = true;
    keyMode = "vi";
    shortcut = "a";
    customPaneNavigationAndResize = true;
    terminal = "screen-256color";
    extraConfig = ''
      # Change status bar
      set -g status-bg colour234
      set -g status-fg white
      # highlight active window
      set-window-option -g window-status-current-style bg=red
      # put stuff on right
      set -g status-right '#[fg=colour11]#(uptime | cut -d "," -f 3- | sed -e "s/  load average: //")'
    '';
  };

  home.activation.createVimTempDirs = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p $HOME/.local/share/vim/{backup,swap,undo}
  '';

  programs.vim = {
    enable = true;
    defaultEditor = true;

    settings = {
      backupdir = [
        "~/.local/share/vim/backup"
      ];
      undodir = [
        "~/.local/share/vim/undo"
      ];
    };

    plugins = with pkgs.vimPlugins; [
      ale
      fzf-vim
      molokai
      typescript-vim
      vim-fugitive
      vim-gitgutter
      vim-gnupg
      vim-go
      vim-javascript
      vim-jsx-pretty
      vim-jsx-typescript
      vim-markdown
      vim-unimpaired
    ];

    extraConfig = builtins.readFile ./modules/vim/.vimrc;
  };

  home.file = {
    ".ssh/allowed_signers".text = ''
      * ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAPRxjeY5t5aG4lzGTmjXbsONZ+pnmzHGUfsaMHDbECO mark.feeney@gmail.com
    '';
  };

  home.sessionVariables = {
    # EDITOR = "vim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
