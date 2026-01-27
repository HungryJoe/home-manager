{ config, pkgs, pkgs-python310, pkgs-mysql57, ... }:

with pkgs;

{
home = {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  username = "skagan";
  homeDirectory = "/Users/skagan";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  stateVersion = "25.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  packages = let 
    jdk-low-priority = lib.meta.setPrio 10 jdk;
    pylsp-interpreter = lib.meta.setPrio 10 (
      python314.withPackages (
        ps: [ps.python-lsp-server ps.pylsp-rope ps.pylint ps.python-lsp-ruff]
        ++ ps.python-lsp-server.optional-dependencies.all
      )
    );
    coding-interpreter = pkgs-python310.python310Full.withPackages (ps: [ps.pip]);
    gcc-low-priority = lib.meta.setPrio 10 gcc;  # Allow clang's binaries to take precedence over gcc's where they conflict
    clang-high-priority = lib.meta.setPrio 0 clang;
  in [
    # Daily essentials
    coreutils
    nix
    helix
    nix-direnv
    git
    pre-commit
    direnv
    fish
    zoxide
    eza
    fd
    ripgrep
    atuin
    bat
    delta
    fzf

    # Not essential, but make the Terminal User-Friendlier
    jq
    lazygit
    pv
    tokei
    procs
    wget
    bottom
    sd
    procps
    pay-respects

    # Java
    maven
    jdk8
    jdt-language-server
    jdk-low-priority

    # Python
    poetry
    coding-interpreter
    pylsp-interpreter
    ruff
    ty

    # Angular
    nodejs_22  # Supports Angular v18 (archive) and v20 (WS post-upgrade) (Src: https://angular.dev/reference/versions)
    nodePackages.typescript-language-server
    nodePackages."@angular/cli"
    # Nix doesn't currently have @angular/language-server in its package repo,
    #   and anyways installing specific versions of it is easier through npm.

    # Bash :(
    bash
    bash-completion
    nodePackages.bash-language-server

    # Lua - not needed
    # lua
    # lua-language-server
    # luarocks
    # stylua

    # Misc. languages & their tooling
    dockerfile-language-server
    docker-compose-language-service
    perl
    nil
    go
    gcc-low-priority
    cmakeMinimal
    vscode-langservers-extracted
    marksman
    markdown-oxide
    rustup
    yaml-language-server
    postgres-language-server
    clang-high-priority

    # Databases
    postgresql_17
    sqlite
    db
    liquibase
    sqlitebrowser
    pkgs-mysql57.mysql57
    pkg-config

    # Documents & Diagrams
    ghostscript
    graphviz
    pandoc
    pdftk
    drawio

    # Misc.
    gnupg
    nmap
    getopt
    nginx
    # ollama  # Too slow on work Macbook
    # lsp-ai  # Not worth using atm, completions = bad
    grype
    syft
    trivy
    lazysql
    erdtree
    vivid
    mergiraf
    difftastic
    keepassxc
    yaak
    oh-my-posh
    borgbackup
    ripgrep-all
    tectonic
    gnumake
    diffoscope
    dust
    qmk

    # Fonts
    nerd-fonts.monofur
    nerd-fonts.victor-mono
    nerd-fonts.symbols-only

    # Fun
    ffmpeg-headless
    imagemagick

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/skagan/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  sessionVariables = {
    # EDITOR = "emacs";
  };
};
programs = {

  # Let Home Manager install and manage itself.
  home-manager.enable = true;

  direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  zellij = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      theme = "catppuccin-latte";
      show_startup_tips = false;
    };
  };

  yazi = {
    enable = true;
    enableFishIntegration = true;
  };
};

fonts = {
  fontconfig = {
    enable = true;
  };
};
}
