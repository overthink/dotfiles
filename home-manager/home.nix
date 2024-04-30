{
  config,
  pkgs,
  lib,
  ...
}:

{
  home = {
    username = "mark";
    homeDirectory = "/home/mark";
    stateVersion = "23.11";

    packages = with pkgs; [
      age
      coreutils
      curl
      direnv
      docker
      duckdb
      gawk
      gnupg
      gnused
      go
      htop
      jq
      k9s
      kubectl
      nixfmt-rfc-style
      openssh
      python3
      ripgrep
      shellcheck
      sops
      sqlite
      statix
      tree
      wget
      yq-go
    ];

    shellAliases = {
      ls = "ls --color=auto";
      ll = "ls -laF";
    };

    activation.createVimTempDirs = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      mkdir -p $HOME/.local/share/vim/{backup,swap,undo}
    '';

    file = {
      ".ssh/allowed_signers".text = ''
        * ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAPRxjeY5t5aG4lzGTmjXbsONZ+pnmzHGUfsaMHDbECO mark.feeney@gmail.com
      '';
    };

    sessionVariables = {
      # EDITOR = "vim";
    };
  };

  programs = {

    # Let Home Manager install and manage itself.
    home-manager.enable = true;
    atuin = {
      enable = true;
      enableBashIntegration = true;
      settings = {
        inline_height = 30;
      };
    };

    readline = {
      enable = true;
      extraConfig = ''
        set editing-mode vi
      '';
    };

    bash = {
      enable = true;
      enableCompletion = true;
      initExtra = ''
        source ~/.nix-profile/share/git/contrib/completion/git-prompt.sh
        export PS1='\w $(__git_ps1 "(%s) ")$ '
      '';
    };

    fzf = {
      enable = true;
      enableBashIntegration = true;
      defaultCommand = "rg --files --ignore-vcs --hidden";
    };

    git = {
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

    tmux = {
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

    vim = {
      enable = true;
      defaultEditor = true;

      settings = {
        backupdir = [ "~/.local/share/vim/backup" ];
        undodir = [ "~/.local/share/vim/undo" ];
      };

      plugins = with pkgs.vimPlugins; [
        ale
        fzf-vim
        molokai
        statix
        typescript-vim
        vim-autoformat
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
  };
}
