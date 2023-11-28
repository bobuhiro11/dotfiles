-- Install lazy.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.opt.termguicolors = true
vim.g.mapleader = ' '

-- Plugins.
require("lazy").setup({
  git = {
    filter = false
  },
  defaults = {
    lazy = true,
  },
  {
    "zbirenbaum/copilot-cmp",
    dependencies = {
      "zbirenbaum/copilot.lua",
      config = function()
        require("copilot").setup()
      end,
    },
    cmd = "Copilot",
    event = "InsertEnter",
    config = function ()
      require("copilot_cmp").setup()
    end
  },
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        inverse = true,
      })
    end
  },
  {
    "folke/neodev.nvim",
    config = function()
      require("neodev").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    event = "InsertEnter",
    dependencies =  {
      {
        "williamboman/mason.nvim",
        config = function()
          require("mason").setup()
        end
      },
    },
    config = function ()
      require("mason-lspconfig").setup({
        ensure_installed = {'gopls', 'pyright'},
        automatic_installation = true,
      })
      require("mason-lspconfig").setup_handlers({
        function(server_name)
          local opts = {}

          require("lspconfig")[server_name].setup(opts)
        end
      })
    end
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
    },
    event = 'InsertEnter',
    config = function ()
      local cmp = require("cmp")
      cmp.setup({
        sources = {
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
          { name = "copilot" },
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
      })
    end
  },
  {
    'j-hui/fidget.nvim',
    tag='legacy',
    event = "LspAttach",
    config = function()
      require('fidget').setup()
    end
  },
  {
    'lewis6991/gitsigns.nvim',
    event = { "FocusLost", "CursorHold" },
    config = function()
      require('gitsigns').setup({
        numhl = true,
      })
    end
  },
  {
    'neovim/nvim-lspconfig',
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "LspInfo", "LspInstall", "LspUninstall" },
  },
  {
    -- Example: #558817
    'norcalli/nvim-colorizer.lua',
    event = "VeryLazy",
    config = function()
      require('colorizer').setup()
    end
  },
  {
    'numToStr/Navigator.nvim',
    config = function ()
      require('Navigator').setup({})
    end,
    keys = {
      {"<C-j>h", "<CMD>lua require('Navigator').left()<CR>"},
      {"<C-j>j", "<CMD>lua require('Navigator').down()<CR>"},
      {"<C-j>k", "<CMD>lua require('Navigator').up()<CR>"},
      {"<C-j>l", "<CMD>lua require('Navigator').right()<CR>"},
    },
  },
  {
    'preservim/nerdtree',
    dependencies = {
      'tiagofumo/vim-nerdtree-syntax-highlight',
      'ryanoasis/vim-devicons',
    },
    cmd = {
      'NERDTreeToggle',
    },
  },
  {
    'tpope/vim-commentary',
    keys = {
      {
        "<leader>c",
        "<Plug>CommentaryLine",
        mode = "n"
      },
      {
        "<leader>c",
        "<Plug>Commentary",
        mode = "x"
      },
    },
  },
  {
    'tpope/vim-fugitive',
    dependencies = {
      {
        'tpope/vim-rhubarb',
        -- disable the commit below to regex in g:github_enterprise_urls:
        --   https://github.com/tpope/vim-rhubarb/commit/b4aad6d
        --   https://github.com/tpope/vim-rhubarb/issues/67
        commit = 'b4aad6d~',
      },
    },
    cmd = { "Git", "GBrowse" },
  },
  {
    'tpope/vim-sleuth',
    event = 'VeryLazy',
  },
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      require('lualine').setup {
        options = {
          theme = 'gruvbox',
        },
        inactive_sections = {
          lualine_c = {
            {
              'filename',
              path = 1,
            },
          },
        },
        sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {
            {
              'filename',
              path = 1
            },
            {
              function()
                local diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line(".") - 1 })
                local max_severity = 4
                local max_severity_idx
                for i, diagnostic in ipairs(diagnostics) do
                  if diagnostic.severity < max_severity then
                    max_severity_idx = i
                  end
                end
                return diagnostics[max_severity_idx].message
              end,
            },
          },
          lualine_x = {'filetype'},
          lualine_y = {},
          lualine_z = {'location'},
        }
      }
    end
  },
  {
    'nvim-telescope/telescope.nvim',
    version = '0.1.4',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = "make" },
      'nvim-telescope/telescope-frecency.nvim',
    },
    keys = {
      {
        "<c-l>",
        function ()
          require('telescope.builtin').oldfiles()
        end,
      },
      {
        "<c-p>",
        function ()
          require('telescope.builtin').find_files()
        end,
      },
      {
        "<c-g>",
        function ()
          vim.cmd("Telescope live_grep default_text=" .. vim.fn.expand("<cword>"))
        end,
      },
    },
    config = function()
      require('telescope').setup {
        defaults = {
          layout_strategy = 'vertical',
          sorting_strategy = "descending",
          layout_config = {
            height = 0.5,
            width = 0.5,
            prompt_position = "bottom",
          },
          mappings = {
            i = {
              ["<C-a>"] = {"<Home>", type="command"},
              ["<C-e>"] = {"<End>", type="command"},
              ["<C-f>"] = {"<Right>", type="command"},
              ["<C-b>"] = {"<Left>", type="command"},
              ["<C-h>"] = {"<BS>", type="command"},
              ["<esc>"] = require('telescope.actions').close,
              ["<C-c>"] = require('telescope.actions').close,
            },
          },
        },
      }
      require("telescope").load_extension("frecency")
      require('telescope').load_extension('fzf')
    end
  },
  {'projekt0n/github-nvim-theme', version = 'v0.0.7'},
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
    config = function()
      vim.g.mkdp_echo_preview_url = 1
    end,
  },
})

vim.g.NERDTreeShowHidden = 1
vim.g.NERDTreeChDirMode = 0
vim.g.NERDTreeGitStatusUseNerdFonts = 0
vim.g.DiffExpr = 0
vim.g.mkdp_echo_preview_url = 1
vim.g.github_enterprise_urls = { "[-_\\.a-zA-Z0-9]\\+" }

vim.opt.autochdir = false
vim.opt.background = "dark"
vim.opt.backspace="indent,eol,start"
vim.opt.backup=false
vim.opt.cursorcolumn=false
vim.opt.cursorline=false
vim.opt.diffopt = "internal,filler,algorithm:histogram,indent-heuristic,foldcolumn:0,vertical,followwrap"
vim.opt.encoding='utf-8'
vim.opt.foldcolumn="0"
vim.opt.guicursor= "i:block"
vim.opt.hidden = true
vim.opt.hlsearch = true
vim.opt.fillchars = "diff: "
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.list=false
vim.opt.mouse = ""
vim.opt.number = true
vim.opt.shiftwidth = 4
vim.opt.showcmd = false
vim.opt.showmode = false
vim.opt.signcolumn = "no"
vim.opt.smarttab = true
vim.opt.softtabstop = 4
vim.opt.spell = false
vim.opt.startofline = false
vim.opt.swapfile = false
vim.opt.tabstop = 4
vim.opt.updatetime = 300
vim.opt.viewoptions = "folds,cursor,curdir"
vim.opt.wildmenu = true
vim.opt.wildoptions = "tagfile"
vim.opt.winbar = nil
vim.opt.writebackup=false
vim.opt.wrap = true
vim.opt.wrapscan = true
vim.opt.ruler = false
vim.opt.cmdheight = 1
vim.opt.relativenumber = false

local opts = { noremap = true, silent = true }
vim.keymap.set('c', '<c-k>', '<c-e><c-u>', opts)
vim.keymap.set('i', '<M-b>', '<C-o>B', opts)
vim.keymap.set('i', '<M-f>', '<C-o>W', opts)
vim.keymap.set('i', '<S-Tab>', '<c-d>', opts)
vim.keymap.set('i', '<c-k>', '<c-o>D', opts)
vim.keymap.set('n', '<S-Tab>', '<<', opts)
vim.keymap.set('n', 'N', '?<CR>', opts)
vim.keymap.set('n', 'n', '/<CR>', opts)
vim.keymap.set('n', 'q', '<nop>')
vim.keymap.set({'i', 'c'}, '<c-a>', '<home>', opts)
vim.keymap.set({'i', 'c'}, '<c-b>', '<left>', opts)
vim.keymap.set({'i', 'c'}, '<c-e>', '<end>', opts)
vim.keymap.set({'i', 'c'}, '<c-f>', '<right>', opts)
vim.keymap.set({'n', 'i', 'v', 'c'}, '<c-c>', '<esc>', opts)
vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
vim.api.nvim_create_user_command('Format', function() vim.lsp.buf.format() end, {})
vim.api.nvim_create_user_command('Rename', function() vim.lsp.buf.rename() end, {})

vim.cmd([[
nnoremap <Leader>f :silent! NERDTreeToggle<CR>
]])

vim.diagnostic.config({
  virtual_text = false,
})

vim.api.nvim_create_autocmd({"InsertEnter", "WinEnter", "CursorHold"}, {
  command = "checktime"
})

vim.api.nvim_create_autocmd({"VimEnter", "WinEnter", "ColorScheme", "Syntax"}, {
  callback = function()
    vim.cmd([[
      " hard	tab
      "　Zenkaku　Space　
      " spaces at EOL 
      highlight TAB ctermbg=237 guibg=#343434
      highlight WhitespaceEOL ctermbg=red guibg=red
      highlight ZenkakuSpace ctermbg=red guibg=red
      call matchadd('ZenkakuSpace', '　')
      call matchadd('TAB', '\t')
      call matchadd('WhitespaceEOL', '\s\+$')
      " TODO: NOTE: XXX: FIXME:
      call matchadd('Todo', '\(TODO\|NOTE\|XXX\|FIXME\):')
    ]])
  end
})

vim.cmd([[colorscheme gruvbox]])

vim.cmd([[
if &diff
  " syntax off
  set noreadonly
endif
]])
