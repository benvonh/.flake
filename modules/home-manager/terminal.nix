{ inputs, outputs, lib, config, pkgs, ... }:
let
  p10k = "${config.home.homeDirectory}/.flake/modules/home-manager/.p10k.zsh";
in
{
  imports = [ inputs.nixvim.homeManagerModules.nixvim ];

  home.packages = with pkgs; [
    fd
    htop
    neofetch
    ranger
    ripgrep
    thefuck
    tldr
    todo
    wl-clipboard
  ];

  programs = {
    eza = {
      git = true;
      icons = true;
      enable = true;
      enableAliases = true;
      extraOptions = [ "--group-directories-first" ];
    };

    bat = {
      enable = true;
      config.theme = "gruvbox-dark";
      extraPackages = with pkgs.bat-extras; [
        batdiff
        batgrep
        batman
        batwatch
      ];
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
      tmux.enableShellIntegration = true;
    };

    git = {
      enable = true;
      userName = "benvonh";
      userEmail = "benjaminvonsnarski@gmail.com";
    };

    gh = {
      enable = true;
    };

    command-not-found.enable = true;

    zsh = {
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = true;
      syntaxHighlighting.enable = true;
      historySubstringSearch.enable = true;
      defaultKeymap = "emacs";
      initExtra = "source ${p10k}";
      initExtraFirst = ''
        if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
          source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
        fi
      '';
      shellAliases = {
        cd = "z";
        ga = "git add";
        gd = "git diff";
        gp = "git push";
        gl = "git pull";
        gc = "git commit";
        gs = "git status";
        fzf = "fzf --prompt ' ' --pointer '' --marker ''";
        hms = "home-manager switch --flake ~/.flake";
        nrs = "sudo nixos-rebuild switch --flake ~/.flake";
        ngc = "nix-collect-garbage -d";
      };
      history = {
        ignoreAllDups = true;
        path = "${config.xdg.dataHome}/zsh/zsh_history";
      };
      oh-my-zsh = {
        enable = true;
        plugins = [
          "bgnotify"
          "command-not-found"
          "copybuffer"
          "copyfile"
          "copypath"
          "dirhistory"
          "fd"
          "gh"
          "ripgrep"
          "thefuck"
        ];
      };
      zplug = {
        enable = true;
        zplugHome = "${config.xdg.dataHome}/zplug";
        plugins = [
          {
            name = "romkatv/powerlevel10k";
            tags = [ "as:theme" "depth:1" ];
          }
        ];
      };
    };

    tmux = {
      enable = true;
      mouse = true;
      clock24 = true;
      baseIndex = 1;
      shortcut = "s";
      shell = "${pkgs.zsh}/bin/zsh";
      terminal = "kitty";
      extraConfig = "set -g status-position top";
      plugins = with pkgs.tmuxPlugins; [
        better-mouse-mode
        continuum
        extrakto
        resurrect
        tmux-fzf
        vim-tmux-navigator
        {
          plugin = power-theme;
          extraConfig = ''
            set -g @tmux_power_theme 'default'

            set -g @tmux_power_left_arrow_icon ' '
            set -g @tmux_power_right_arrow_icon ' '
          '';
        }
      ];
    };

    nixvim = {
      enable = true;
      colorschemes.gruvbox.enable = true;
      clipboard.providers.wl-copy.enable = true;
      options = {
        autoindent = true;
        background = "dark";
        backup = false;
        clipboard = "";
        cmdheight = 1;
        colorcolumn = "120";
        confirm = true;
        cursorline = true;
        expandtab = true;
        guifont = "CaskaydiaCove\ Nerd\ Font:h12";
        hlsearch = false;
        incsearch = true;
        number = true;
        pumheight = 8;
        pumwidth = 24;
        scrolloff = 8;
        shiftround = false;
        shiftwidth = 4;
        showmode = false;
        signcolumn = "yes";
        smartcase = true;
        smartindent = true;
        smarttab = true;
        softtabstop = 4;
        splitbelow = true;
        splitright = true;
        swapfile = false;
        syntax = "yes";
        tabstop = 4;
        termguicolors = true;
        timeout = true;
        timeoutlen = 1000;
        undofile = true;
        undolevels = 1000;
        visualbell = true;
        wrap = false;
      };
      globals.mapleader = " ";
      keymaps = [
        { mode = "i"; key = "<c-c>"; action = "<esc>"; }

        { mode = "v"; key = "<"; action = "<gv"; }
        { mode = "v"; key = ">"; action = ">gv"; }
        { mode = "v"; key = "J"; action = ":m '>+1<cr>gv=gv"; }
        { mode = "v"; key = "K"; action = ":m '<-2<cr>gv=gv"; }
        { mode = "v"; key = "p"; action = "\"_dP"; }

        { mode = "n"; key = "n"; action = "nzz"; }
        { mode = "n"; key = "N"; action = "Nzz"; }
        { mode = "n"; key = "<a-h>"; action = "<c-w>H"; }
        { mode = "n"; key = "<a-j>"; action = "<c-w>J"; }
        { mode = "n"; key = "<a-k>"; action = "<c-w>K"; }
        { mode = "n"; key = "<a-l>"; action = "<c-w>L"; }
        { mode = "n"; key = "<c-u>"; action = "<c-u>zz"; }
        { mode = "n"; key = "<c-d>"; action = "<c-d>zz"; }
        { mode = "n"; key = "H"; action = "<cmd>bprev<cr>"; }
        { mode = "n"; key = "L"; action = "<cmd>bnext<cr>"; }

        { mode = ""; key = "<leader>y"; action = "\"+y"; }
        { mode = ""; key = "<leader>Y"; action = "\"+Y"; }
        { mode = ""; key = "<leader>d"; action = "\"_d"; }
        { mode = ""; key = "<leader>D"; action = "\"_D"; }

        { mode = "n"; key = "<leader>q"; action = "<cmd>q<cr>"; }
        { mode = "n"; key = "<leader>w"; action = "<cmd>w<cr>"; }
        { mode = "n"; key = "<leader>x"; action = "<cmd>x<cr>"; }
        { mode = "n"; key = "<leader>a"; action = "<cmd>qa<cr>"; }
        { mode = "n"; key = "<leader>s"; action = "<cmd>wa<cr>"; }
        { mode = "n"; key = "<leader>z"; action = "<cmd>xa<cr>"; }
        { mode = "n"; key = "<leader>v"; action = "<cmd>vsplit<cr>"; }

        { mode = "n"; key = "<leader>j"; action = "<cmd>ToggleTerm<cr>"; }
        { mode = "n"; key = "<leader>t"; action = "<cmd>TodoTelescope<cr>"; }
        { mode = "n"; key = "<leader>e"; action = "<cmd>NvimTreeToggle<cr>"; }
        { mode = "n"; key = "<leader>l"; action = "<cmd>Telescope live_grep<cr>"; }
        { mode = "n"; key = "<leader>f"; action = "<cmd>Telescope find_files<cr>"; }
        { mode = "n"; key = "<leader>r"; action = "<cmd>TroubleToggle lsp_references<cr>"; }
        { mode = "n"; key = "<leader>dd"; action = "<cmd>TroubleToggle document_diagnostics<cr>"; }
        { mode = "n"; key = "<leader>dw"; action = "<cmd>TroubleToggle workspace_diagnostics<cr>"; }
        { mode = "n"; key = "<leader>df"; action = "<cmd>TroubleToggle quickfix<cr>"; }
      ];
      autoCmd = [
        {
          event = "FileType";
          pattern = [ "c" "cpp" "nix" ];
          command = "setlocal tabstop=2 shiftwidth=2 softtabstop=2";
        }
      ];
      plugins = {
        which-key = {
          enable = true;
          registrations = {
            "<leader>q" = "Quit buffer";
            "<leader>w" = "Write buffer";
            "<leader>x" = "Write & Quit buffer";
            "<leader>a" = "Abandon buffers";
            "<leader>s" = "Save all buffers";
            "<leader>z" = "Save & Exit";
            "<leader>v" = "Split vertical";
            "<leader>j" = "Open terminal";
            "<leader>t" = "Search TODO";
            "<leader>e" = "Toggle file explorer";
            "<leader>l" = "Live grep";
            "<leader>f" = "Find file";
            "<leader>r" = "Show references";
            "<leader>dd" = "Show document diagnostics";
            "<leader>dw" = "Show workspace diagnostics";
            "<leader>df" = "Show quick fixes";
          };
        };

        nix.enable = true;
        nix-develop.enable = true;
        comment-nvim.enable = true;
        todo-comments.enable = true;
        rainbow-delimiters.enable = true;
        persistence.enable = true;
        telescope.enable = true;
        trouble.enable = true;

        treesitter = {
          enable = true;
          indent = true;
        };

        toggleterm = {
          enable = true;
          size = 20;
        };

        nvim-autopairs = {
          enable = true;
          enableAbbr = true;
          checkTs = true;
          mapCW = true;
        };

        indent-blankline = {
          enable = true;
          scope.showEnd = false;
          scope.showStart = false;
          indent.char = "▏";
        };

        lualine = {
          enable = true;
          globalstatus = true;
          sectionSeparators.left = "";
          sectionSeparators.right = "";
          componentSeparators.left = "";
          componentSeparators.right = "";
        };

        nvim-tree = {
          enable = true;
          git.ignore = false;
          hijackCursor = true;
          diagnostics.enable = true;
          diagnostics.showOnDirs = true;
          updateFocusedFile.enable = true;
          renderer.indentMarkers.enable = false;
          renderer.icons.gitPlacement = "after";
        };

        lsp = {
          enable = true;
          servers = {
            bashls.enable = true;
            clangd.enable = true;
            cmake.enable = true;
            cssls.enable = true;
            # FIXME: Not available in 23.11
            # dockerls.enable = true;
            html.enable = true;
            jsonls.enable = true;
            lua-ls.enable = true;
            # FIXME: Not available in 23.11
            # marksman.enable = true;
            nil_ls.enable = true;
            pyright.enable = true;
            rust-analyzer.enable = true;
            rust-analyzer.installCargo = true;
            rust-analyzer.installRustc = true;
            texlab.enable = true;
            yamlls.enable = true;
          };
          keymaps = {
            diagnostic = {
              "<leader>j" = "goto_next";
              "<leader>k" = "goto_prev";
            };
            lspBuf = {
              K = "hover";
              gD = "references";
              gd = "definition";
              gi = "implementation";
              gt = "type_definition";
            };
          };
        };

        lspkind = {
          enable = true;
          cmp.enable = true;
          mode = "text_symbol";
        };

        luasnip.enable = true;
        cmp-rg.enable = true;
        cmp-zsh.enable = true;
        cmp-tmux.enable = true;
        cmp-path.enable = true;
        cmp-buffer.enable = true;
        cmp-cmdline.enable = true;
        cmp-nvim-lsp.enable = true;
        cmp-treesitter.enable = true;
        cmp-latex-symbols.enable = true;
        cmp-nvim-lsp-signature-help.enable = true;
        cmp-nvim-lsp-document-symbol.enable = true;
        cmp_luasnip.enable = true;

        nvim-cmp = {
          enable = true;
          preselect = "Item";
          snippet.expand = "luasnip";
          mappingPresets = [ "insert" "cmdline" ];
          mapping = {
            "<c-e>" = "cmp.mapping.abort()";
            "<c-u>" = "cmp.mapping.scroll_docs(4)";
            "<c-d>" = "cmp.mapping.scroll_docs(-4)";
            "<c-n>" = "cmp.mapping.select_next_item()";
            "<c-p>" = "cmp.mapping.select_prev_item()";
            "<tab>" = "cmp.mapping.confirm({ select = true })";
          };
          sources = [
            { name = "nvim_lsp"; }
            { name = "nvim_lsp_signature_help"; }
            { name = "nvim_lsp_document_symbol"; }
            { name = "luasnip"; }
            { name = "path"; }
            { name = "buffer"; }
            # TODO
            # { name = "latex_symbols"; }
            { name = "treesitter"; }
            { name = "cmdline"; }
            { name = "rg"; }
            # { name = "zsh"; }
            # { name = "tmux"; }
          ];
        };

        markdown-preview = {
          enable = true;
          autoStart = true;
          echoPreviewUrl = true;
          theme = "dark";
        };

        tmux-navigator = {
          enable = true;
          tmuxNavigatorDisableWhenZoomed = 1;
        };
      };
    };
  };
}
