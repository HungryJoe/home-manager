{ config, pkgs, ... }:

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
  stateVersion = "22.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  packages = let 
    jdk-low-priority = lib.meta.setPrio 10 jdk;
    pylsp-interpreter = lib.meta.setPrio 10 (python312.withPackages (ps: [ps.python-lsp-server ps.pylsp-rope ps.pylint ps.python-lsp-ruff] ++ ps.python-lsp-server.optional-dependencies.all));
   in [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello
    nix
    nix-direnv
    gnupg
    imagemagick
    nmap
    getopt
    coreutils
    nginx

    # Daily essentials
    helix
    git
    pre-commit
    direnv
    fish
    zoxide
    eza
    fd
    ripgrep

    # Not essential, but make the Terminal User-Friendlier
    jq
    gitui
    pv
    tokei
    procs
    wget
    bat
    bottom
    du-dust
    delta
    fzf
    sd
    procps

    # Java
    maven
    jdk8
    jdt-language-server
    jdk-low-priority

    # Python
    poetry
    python310Full
    python310Packages.pip
    pylsp-interpreter
    ruff  # Used for pip-installed pylsp

    # Angular
    nodePackages.typescript-language-server
    nodePackages."@angular/cli"
    # Nix doesn't currently have @angular/language-server in its package repo,
    #   and anyways installing specific versions of it is easier through npm, which is now installed through Homebrew.

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
    nodePackages.dockerfile-language-server-nodejs
    perl
    nil
    go
    gcc
    cmakeMinimal

    # Databases
    postgresql_14
    sqlite
    db
    liquibase
    sqlitebrowser

    # Documents & Diagrams
    ghostscript
    graphviz
    pandoc
    pdftk
    drawio

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

  neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    withPython3 = true;
    withNodeJs = true;
    extraPython3Packages = pyPkgs: [pyPkgs.pynvim];
    extraPackages = [
      nodePackages.neovim
      tree-sitter
    ];
  };

  direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
};
}
