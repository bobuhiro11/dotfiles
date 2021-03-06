" Policies:
"
" - Prioritize built-in functions, pure vimscript plug-ins, and other plug-ins
" - Remove unnecessary plugins.
" - Remove plugins for specific languages
" - Don't use neovim
"
" Vim:
" git clone https://github.com/vim/vim.git && cd vim
" ./configure --enable-luainterp --enable-pythoninterp --enable-python3interp
" make -j4
" sudo make install
"
" Node.js:
" curl -sL install-node.now.sh/lts | sudo bash
"
" vim-plug:
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"
" rust-analyzer:
" git clone https://github.com/rust-analyzer/rust-analyzer.git
" cd rust-analyzer
" change members = ["crates/*"] in Cargo.toml
" cargo build
" sudo cp ./target/release/rust-analyzer /usr/local/bin/
"
" Font:
" brew tap homebrew/cask-fonts
" brew install font-hack-nerd-font --cask
"
" Ripgrep:
" curl -LO https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep-13.0.0-x86_64-unknown-linux-musl.tar.gz
" tar -zxvf ripgrep-13.0.0-x86_64-unknown-linux-musl.tar.gz
" mv ripgrep-13.0.0-x86_64-unknown-linux-musl/rg ~/bin/
"
if ! empty(glob('~/.vim/autoload/plug.vim'))
  call plug#begin()
  Plug 'tpope/vim-rhubarb'
  Plug 'ryanoasis/vim-devicons'
  Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
  Plug 'airblade/vim-gitgutter'
  Plug 'morhetz/gruvbox'
  Plug 'mattn/vim-goimports'
  if v:version >= 802 || has('nvim')
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
  endif
  Plug 'itchyny/lightline.vim'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'junegunn/vim-easy-align'
  Plug 'tyru/caw.vim'
  Plug 'cespare/vim-toml', {'branch': 'main'}
  Plug 'chase/vim-ansible-yaml'
  Plug 'tpope/vim-fugitive'
  Plug 'vim-jp/vimdoc-ja'
  Plug 'kchmck/vim-coffee-script'
  Plug 'tpope/vim-sleuth'
  call plug#end()
endif
function s:is_plugged(name)
  return exists('g:plugs') && has_key(g:plugs, a:name) && isdirectory(g:plugs[a:name].dir)
endfunction
function! RipgrepFzf(query, fullscreen)
  if executable('rg')
    let l:command_fmt = 'rg --text --no-binary --column --line-number --no-heading --color=always --smart-case %s || true'
  else
    let l:command_fmt = 'grep -irnIH --max-count=100 --exclude-dir=.svn --exclude-dir=.git --exclude=tags --exclude=tags.lock --exclude-dir=vendor %s ./ || true'
  endif
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction
if has('nvim')
  set signcolumn=number
elseif v:version >= 802
  set shortmess=cfilnxtToOS
  set completeopt=menuone,noselect,popup
  " set diffopt=internal,filler,algorithm:histogram,indent-heuristic
  set signcolumn=number
elseif v:version >= 800
  set completeopt=menuone,noselect
end
set noshowmode
set helplang=ja
set ttimeoutlen=0
set viewoptions-=options
set background=dark
set nobackup
set nowritebackup
set ambiwidth=single
set backspace=indent,eol,start
set cinkeys-=0#
set cmdheight=2
set updatetime=300
set nolist
set number
set norelativenumber
set wildmenu
set nocursorline
set nocursorcolumn
set encoding=utf-8
set expandtab
set fileencodings=utf8,ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932,utf-8
set foldmethod=marker
set hidden
set hlsearch
set ignorecase
set incsearch
set keywordprg=:help
if has('nvim')
  set laststatus=3
else
  set laststatus=2
end
set nopaste
set shellslash
set shiftwidth=2
set showmatch
set smartindent
set smarttab
set softtabstop=2
set tabstop=2
set whichwrap=b,s,h,l,<,>,[,]
"set grepprg=grep\ -rnIH\ --max-count=100\ --exclude-dir=.svn\ --exclude-dir=.git\ --exclude=tags\ --exclude=tags.lock\ --exclude-dir=vendor\ $*\ ./
set virtualedit=block
set nostartofline
set noswapfile
set spell
set spelllang=en,cjk
set autoread
set confirm
set noautochdir
set guicursor=i:block
let g:netrw_liststyle=3
let g:netrw_banner=0
let g:netrw_sizestyle='H'
let g:netrw_timefmt='%Y/%m/%d(%a) %H:%M:%S'
let g:netrw_preview=1
let g:goimports_show_loclist = 0
let g:coc_global_extensions = ['coc-go', 'coc-pyright', 'coc-vimlsp', 'coc-sh', 'coc-snippets', 'coc-yaml']
let g:coc_user_config = {}
let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
      \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'relativepath', 'modified' ] ]
      \ },
      \ 'inactive': {
      \   'left': [ [ 'relativepath' ] ],
      \ }
      \ }
let g:tmux_navigator_no_mappings = 1
let g:vim_markdown_folding_style_pythonic = 1
let g:vim_markdown_new_list_item_indent = 2
let g:vim_markdown_frontmatter = 1
let g:NERDTreeShowHidden = 1
let g:mapleader = ' '
let g:UltiSnipsExpandTrigger='<c-e>'
let g:NERDTreeChDirMode = 0
let g:NERDTreeGitStatusUseNerdFonts = 1
let g:asyncomplete_popup_delay = 10
let g:asyncomplete_auto_completeopt = 0
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
let g:fzf_layout = { 'down': '~20%' }
let g:tmuxcomplete#asyncomplete_source_options = {
      \ 'name':      'tmuxcomplete',
      \ 'whitelist': ['*'],
      \ 'blacklist': ['text'],
      \ 'config': {
      \     'splitmode':      'words',
      \     'filter_prefix':   1,
      \     'show_incomplete': 1,
      \     'sort_candidates': 0,
      \     'scrollback':      0,
      \     'truncate':        0
      \     }
      \ }
nnoremap <leader>. :source $HOME/.vimrc<CR>
nnoremap <C-p> :Files<CR>
nnoremap <C-l> :History<CR>
nnoremap <silent> <C-k> :bnext<CR>
nnoremap <silent> <C-s> :bprevious<CR>
nnoremap <silent> <expr> <c-g> ':RG ' . expand("<cword>") . '<CR>'
nnoremap <Leader>f :NERDTreeToggle<CR>
nnoremap <silent> <C-j>h :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j>j :TmuxNavigateDown<cr>
nnoremap <silent> <C-j>k :TmuxNavigateUp<cr>
nnoremap <silent> <C-j>l :TmuxNavigateRight<cr>
nnoremap <silent> <C-j>\ :TmuxNavigatePrevious<cr>
inoremap <silent> <c-a> <home>
inoremap <silent> <c-e> <end>
inoremap <silent> <c-f> <right>
inoremap <silent> <c-b> <left>
inoremap <silent> <c-k> <c-o>D
nmap <Leader>c <Plug>(caw:hatpos:toggle)
vmap <Leader>c <Plug>(caw:hatpos:toggle)
noremap  <c-c> <esc>
noremap! <c-c> <esc>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-k> <C-e><C-u>
nnoremap <S-Tab> <<
inoremap <S-Tab> <C-d>
nnoremap n /<CR>
nnoremap N ?<CR>
nmap s <Plug>(easymotion-overwin-f2)
syntax enable
filetype plugin indent on
highlight Directory guifg=#FF0000 ctermfg=lightblue ctermbg=black guibg=black
highlight VertSplit guibg=NONE cterm=NONE
highlight SpecialKey ctermfg=darkgray guifg=darkgray ctermbg=black guibg=black
highlight clear SpellBad
highlight SpellBad cterm=underline
highlight clear SpellCap
highlight SpellCap cterm=underline,bold
scriptencoding utf-8
command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
command! -nargs=* -complete=dir CD call fzf#run(fzf#wrap({'source': 'find ~/ -maxdepth 5 -type d', 'sink': 'cd'}))
if s:is_plugged('gruvbox')
  colorscheme gruvbox
  let $BAT_THEME='gruvbox-dark'
endif
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . ' ' . expand('<cword>')
  endif
endfunction

if s:is_plugged('coc.nvim')
  nnoremap <silent> K :call <SID>show_documentation()<CR>
  inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
  "inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
  inoremap <silent><expr> <S-TAB>
    \ pumvisible() ? "\<C-p>" :
    \ coc#jumpable() ? "\<C-r>=coc#rpc#request('snippetPrev',[])\<CR>" :
    \ "\<C-h>"
  inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
  nmap <silent>gd <Plug>(coc-definition)
  nmap <leader>rn <Plug>(coc-rename)
  command! -nargs=0 Format :call CocAction('format')
  command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')
endif

augroup MyAutoCmd
  autocmd!
  "	hard tab
  "	Zenkaku　Space　
  "	spaces at EOL   
  autocmd VimEnter,WinEnter,ColorScheme * highlight TAB ctermbg=236 guibg=#282828
  autocmd VimEnter,WinEnter,ColorScheme * highlight WhitespaceEOL ctermbg=red guibg=red
  autocmd VimEnter,WinEnter,ColorScheme * highlight ZenkakuSpace ctermbg=red guibg=red
  autocmd VimEnter,WinEnter * match WhitespaceEOL /\s\+$/
  autocmd VimEnter,WinEnter * 2match ZenkakuSpace /　/
  autocmd VimEnter,WinEnter * match TAB /\t/
  autocmd InsertEnter,WinEnter,CursorHold * checktime
  autocmd FileType python     setlocal shiftwidth=4 tabstop=4 softtabstop=4 expandtab
  autocmd FileType make       setlocal shiftwidth=4 tabstop=4 softtabstop=4 noexpandtab
  autocmd FileType go         setlocal shiftwidth=4 tabstop=4 softtabstop=4 noexpandtab
  autocmd FileType c          setlocal shiftwidth=8 tabstop=8 softtabstop=8 noexpandtab
  autocmd FileType yaml,json  setlocal cursorline cursorcolumn
  autocmd BufWritePost * if expand('%') != '' && &buftype !~ 'nofile' | silent! call mkdir($HOME . "/.vim", "p") | mkview | endif
  autocmd BufRead * if expand('%') != '' && &buftype !~ 'nofile' | silent loadview | endif
augroup END

if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif
