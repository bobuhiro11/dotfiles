require('packer').startup(function(use)
  use "ellisonleao/gruvbox.nvim"
  use "folke/neodev.nvim"
  use "williamboman/mason-lspconfig.nvim"
  use "williamboman/mason.nvim"
  use 'Xuyuanp/nerdtree-git-plugin'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/nvim-cmp'
  use 'j-hui/fidget.nvim'
  use 'lewis6991/gitsigns.nvim'
  use 'neovim/nvim-lspconfig'
  use 'norcalli/nvim-colorizer.lua'
  use 'numToStr/Navigator.nvim'
  use 'preservim/nerdtree'
  use 'ryanoasis/vim-devicons'
  use 'tiagofumo/vim-nerdtree-syntax-highlight'
  use 'tpope/vim-commentary'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'tpope/vim-sleuth'
  use 'wbthomason/packer.nvim'
  use {"nvim-telescope/telescope-frecency.nvim", requires = {"kkharji/sqlite.lua"}}
  use {'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true}}
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}
  use {'nvim-telescope/telescope.nvim', tag = '0.1.0', requires = { {'nvim-lua/plenary.nvim'}}}
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  use {'projekt0n/github-nvim-theme', tag = 'v0.0.7'}
  use {'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim'}
end)

vim.g.mapleader = ' '
vim.g.NERDTreeShowHidden = 1
vim.g.NERDTreeChDirMode = 0
vim.g.NERDTreeGitStatusUseNerdFonts = 1
vim.g.DiffExpr = 0

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
vim.opt.signcolumn = "yes"
vim.opt.smarttab = true
vim.opt.softtabstop = 4
vim.opt.spell = false
vim.opt.startofline = false
vim.opt.swapfile = false
vim.opt.tabstop = 4
vim.opt.termguicolors = true
vim.opt.updatetime = 300
vim.opt.viewoptions = "folds,cursor,curdir"
vim.opt.wildmenu = true
vim.opt.wildoptions = "tagfile"
vim.opt.winbar = nil
vim.opt.writebackup=false
vim.opt.wrap = true
vim.opt.wrapscan = false
vim.opt.ruler = false
vim.opt.cmdheight = 1
vim.opt.relativenumber = false

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>c", "<Plug>CommentaryLine")
vim.keymap.set("x", "<leader>c", "<Plug>Commentary")
vim.keymap.set('c', '<c-k>', '<c-e><c-u>', opts)
vim.keymap.set('i', '<M-b>', '<C-o>B', opts)
vim.keymap.set('i', '<M-f>', '<C-o>W', opts)
vim.keymap.set('i', '<S-Tab>', '<c-d>', opts)
vim.keymap.set('i', '<c-k>', '<c-o>D', opts)
vim.keymap.set('n', "<C-j>h", "<CMD>lua require('Navigator').left()<CR>", opts)
vim.keymap.set('n', "<C-j>j", "<CMD>lua require('Navigator').down()<CR>", opts)
vim.keymap.set('n', "<C-j>k", "<CMD>lua require('Navigator').up()<CR>", opts)
vim.keymap.set('n', "<C-j>l", "<CMD>lua require('Navigator').right()<CR>", opts)
vim.keymap.set('n', "<c-g>", function() vim.cmd("Telescope live_grep default_text=" .. vim.fn.expand("<cword>")) end)
vim.keymap.set('n', '<S-Tab>', '<<', opts)
vim.keymap.set('n', '<c-l>', require('telescope.builtin').oldfiles)
vim.keymap.set('n', '<c-p>', require('telescope.builtin').find_files)
vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
vim.keymap.set('n', 'N', '?<CR>', opts)
vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
vim.keymap.set('n', 'n', '/<CR>', opts)
vim.keymap.set('n', 'q', '<nop>')
vim.keymap.set({'i', 'c'}, '<c-a>', '<home>', opts)
vim.keymap.set({'i', 'c'}, '<c-b>', '<left>', opts)
vim.keymap.set({'i', 'c'}, '<c-e>', '<end>', opts)
vim.keymap.set({'i', 'c'}, '<c-f>', '<right>', opts)
vim.keymap.set({'n', 'i', 'v', 'c'}, '<c-c>', '<esc>', opts)

vim.api.nvim_create_user_command('Format', function() vim.lsp.buf.formatting() end, {})
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
      " hard    tab
      "　Zenkaku　Space　
      " spaces at EOL
      highlight TAB ctermbg=237 guibg=#343434
      highlight WhitespaceEOL ctermbg=red guibg=red
      highlight ZenkakuSpace ctermbg=red guibg=red
      call matchadd('ZenkakuSpace', '　')
      call matchadd('TAB', '\t')
      call matchadd('WhitespaceEOL', '\s\+$')
      call matchadd('Todo', '\(TODO\|NOTE\|XXX\|FIXME\):')
    ]])
  end
})

require("neodev").setup({}) -- Make sure to setup neodev BEFORE lspconfig
require('colorizer').setup()

require("nvim-treesitter.configs").setup {
  ensure_installed={"c", "lua", "go", "python", "ruby", "rust"},
  sync_install=false,
  auto_install = true,
}
require('gitsigns').setup()
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {'gopls', 'pyright', 'clangd', 'yamlls', 'lua_ls'},
  automatic_installation = true,
})
require("mason-lspconfig").setup_handlers({
  function(server_name)
    local opts = {}

    if server_name == "sumneko_lua" then
      opts.settings = {
        Lua = {
          diagnostics = { globals = { 'vim' } },
        }
      }
    end

    if server_name == "yamlls" then
      opts.settings = {
        yaml = { keyOrdering = false},
      }
    end

    require("lspconfig")[server_name].setup(opts)
  end
})

local cmp = require("cmp")
cmp.setup({
  sources = {
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "path" },
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),

    -- Accept currently selected item. Set `select` to `false` to
    -- only confirm explicitly selected items.
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
})

require('Navigator').setup({})
require('fidget').setup()

local colors = require("gruvbox.palette").colors;
require("gruvbox").setup({
  inverse = true,
  overrides = {
    SignColumn = {bg = colors.dark0},
    DiffDelete = {fg = colors.bright_blue, bg=colors.dark0, bold = false, reverse=true},
    DiffAdd    = {fg = colors.bright_blue, bg=colors.dark0, bold = false, reverse=true},
    DiffChange = {fg = colors.bright_blue, bg=colors.dark0, bold = false, reverse=true},
    DiffText   = {fg = colors.bright_blue, bg=colors.dark0, bold = true,  reverse=true},
  }
})

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
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  }
}

require('telescope').setup {
  defaults = {
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
  extensions = {
    fzf =  {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
    frecency = {},
  }
}

require('telescope').load_extension('fzf')
require("telescope").load_extension("frecency")
require("diffview").setup({
  enhanced_diff_hl = true
})

vim.cmd([[colorscheme gruvbox]])

vim.cmd([[
if &diff
  " syntax off
  set noreadonly
endif
]])
