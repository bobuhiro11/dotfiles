" Policies:
"
" - Prioritize built-in functions, pure vimscript plug-ins, and other plug-ins
" - Remove unnecessary plugins.
" - Remove plugins for specific languages
" - Don't use neovim
" - Don't block user actions
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
  Plug 'airblade/vim-gitgutter'
  Plug 'cespare/vim-toml', {'branch': 'main'}
  Plug 'chase/vim-ansible-yaml'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'junegunn/vim-easy-align'
  Plug 'kchmck/vim-coffee-script'
  Plug 'lambdalisue/suda.vim'
  Plug 'sonph/onehalf', { 'rtp': 'vim' }
  if v:version >= 802 || has('nvim')
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
  endif
  Plug 'sunaku/tmux-navigate'
  Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
  Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-fugitive'
  Plug 'rbong/vim-flog'
  Plug 'tpope/vim-repeat'
  " disable the commit below to regex in g:github_enterprise_urls:
  "   https://github.com/tpope/vim-rhubarb/commit/b4aad6d
  "   https://github.com/tpope/vim-rhubarb/issues/67
  Plug 'tpope/vim-rhubarb', {'commit': 'b4aad6d~'}
  Plug 'tpope/vim-sleuth'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-unimpaired'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'vim-jp/vimdoc-ja'
  Plug 'github/copilot.vim', {'tag': 'v1.32.0'}
  Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
  call plug#end()
endif
function s:is_plugged(name)
  return exists('g:plugs') && has_key(g:plugs, a:name) && isdirectory(g:plugs[a:name].dir)
endfunction
function! RipgrepFzf(query, fullscreen)
  let query = substitute(a:query, ' ', '.*', 'g')

  if executable('rg')
    let l:command_fmt = 'rg --text --no-binary --column --line-number --no-heading --color=always --ignore-case --colors "match:fg:0xe4,0x56,0x49" --colors "path:fg:0x38,0x3a,0x42" --colors "line:fg:0x38,0x3a,0x42" -g "!zz_generated.deepcopy.go" %s || true'
  else
    let l:command_fmt = 'GREP_COLORS="fn=:ln=:se=:" grep --color=always -irnIH --max-count=100 --exclude-dir=.svn --exclude-dir=.git --exclude=tags --exclude=tags.lock --exclude-dir=vendor %s ./ || true'
  endif
  let initial_command = printf(command_fmt, shellescape(query))
  let reload_command = printf(command_fmt, " $(echo {q} | sed 's/ /.*/g')")
  let spec = {'options': ['--phony', '--query', query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction
if has('nvim')
  set signcolumn=yes
elseif v:version >= 802
  set shortmess=cfilnxtToOS
  set completeopt=menuone,noselect,popup
  " set diffopt=internal,filler,algorithm:histogram,indent-heuristic
  set signcolumn=yes
elseif v:version >= 800
  set completeopt=menuone,noselect
end
" For true color support
" https://gist.github.com/andersevenrud/015e61af2fd264371032763d4ed965b6
if !has('gui_running') && &term =~ '^\%(screen\|tmux\|xterm\)' && v:version >= 802
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  let &t_ZH = "\e[3m"
  let &t_ZR = "\e[23m"
endif
set noshowmode
set helplang=ja
set ttimeoutlen=0
set viewoptions-=options
set background=light
set nobackup
set nowritebackup
set ambiwidth=single
set backspace=indent,eol,start
set cinkeys-=0#
set cmdheight=1
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
set nospell
set spelllang=en,cjk
set title
set titlestring=this-is-vim
set autoread
set confirm
set noautochdir
set guicursor=i:block
let g:github_enterprise_urls = ['[-_\.a-zA-Z0-9]\+']
let g:netrw_liststyle=3
let g:netrw_banner=0
let g:netrw_sizestyle='H'
let g:netrw_timefmt='%Y/%m/%d(%a) %H:%M:%S'
let g:netrw_preview=1
let g:coc_global_extensions = ['coc-go', 'coc-pyright', 'coc-vimlsp', 'coc-sh', 'coc-snippets', 'coc-yaml', 'coc-rust-analyzer']
let g:coc_user_config = {}
let g:coc_user_config['pyright.inlayHints.functionReturnTypes'] = 0
let g:coc_user_config['pyright.inlayHints.variableTypes'] = 0
let g:coc_user_config['pyright.inlayHints.parameterTypes'] = 0
let g:coc_user_config['rust-analyzer.cargo.cfgs'] = []
let g:coc_user_config['rust-analyzer.inlayHints.enable'] = v:false
let g:coc_user_config['rust-analyzer.inlayHints.typeHints.enable'] = v:false
let g:coc_user_config['rust-analyzer.inlayHints.parameterHints.enable'] = v:false
let g:coc_user_config['rust-analyzer.inlayHints.chainingHints.enable'] = v:false
let g:coc_user_config['rust-analyzer.inlayHints.closureReturnTypeHints.enable"'] = v:false
let g:coc_user_config['rust-analyzer.workspace.ignoredFolders'] = ["$HOME", "$HOME/.cargo/**", "$HOME/.rustup/**"]
if s:is_plugged('vim-airline')
  let g:airline#extensions#coc#enabled = 1
  let g:airline#extensions#whitespace#enabled = 0
  let g:airline#extensions#branch#enabled = 1
  let g:airline#extensions#wordcount#enabled = 0
  let g:airline_powerline_fonts = 1
  let g:airline_theme='onehalflight'
  let g:airline_section_z = airline#section#create_right(['colnr'])
endif
let g:suda_smart_edit = 1
let g:mkdp_echo_preview_url = 1
let g:vim_markdown_folding_style_pythonic = 1
let g:vim_markdown_new_list_item_indent = 2
let g:vim_markdown_frontmatter = 1
let g:NERDTreeShowHidden = 1
let g:mapleader = ' '
let g:UltiSnipsExpandTrigger='<c-e>'
let g:NERDTreeChDirMode = 0
let g:asyncomplete_popup_delay = 10
let g:asyncomplete_auto_completeopt = 0
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
let g:fugitive_summary_format = "%cs || %s %d || %<(20,trunc)%an"
let g:fzf_layout = { 'down': '~20%' }
let g:fzf_preview_window = []
let $FZF_DEFAULT_OPTS = $FZF_DEFAULT_OPTS . ' --bind ctrl-q:select-all+accept'
let g:copilot_filetypes = { '*': v:true }
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
nnoremap <C-@> :CD<CR>
nnoremap <Leader>p :Git pr 
nnoremap <Leader>s :call ToggleGit('Git show')<CR>
nnoremap <Leader>g :call ToggleGit('Git')<CR>
nnoremap <Leader>l :call ToggleGit('Git log')<CR>
nnoremap <Leader>d :call ToggleGit('Git diff HEAD')<CR>
nnoremap <Leader>b :GBrowse \| GBrowse!<CR>
vnoremap <Leader>b :GBrowse \| GBrowse!<CR>
nnoremap <silent> <C-k> :bnext<CR>
nnoremap <silent> <C-s> :bprevious<CR>
nnoremap <silent> <expr> <c-g> ':RG ' . expand("<cword>") . '<CR>'
nnoremap <Leader>f :NERDTreeToggle<CR>
inoremap <silent> <c-a> <home>
inoremap <silent> <c-e> <end>
inoremap <silent> <c-f> <right>
inoremap <silent> <c-b> <left>
inoremap <silent> <c-k> <c-o>D
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
map q <nop>
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
command! Pbcopy silent %w !pbcopy
command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
command! -nargs=* -complete=dir CD call fzf#run(fzf#wrap({'source': 'find ~ -maxdepth 3 -type d', 'sink': 'cd'}))
if s:is_plugged('onehalf')
  colorscheme onehalflight
  set termguicolors
endif
function! ToggleGit(command) abort
  let l:before = winnr('$')
  execute 'botright vertical' a:command

  let l:after = winnr('$')
  let l:new_winnr = l:after > l:before ? winnr() : -1

  for l:winnr in range(1, winnr('$'))
    if l:winnr == l:new_winnr
      continue
    endif
    if !empty(getwinvar(l:winnr, 'fugitive_status'))
      exe l:winnr 'close'
    elseif getwinvar(l:winnr, '&filetype') ==# 'git' || getwinvar(l:winnr, '&filetype') ==# 'gitcommit'
      exe l:winnr 'close'
    endif
  endfor
endfunction
function! CheckBackspace() abort
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
  inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
  inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
  nmap <silent>gd <Plug>(coc-definition)
  nmap <leader>rn <Plug>(coc-rename)
  " https://github.com/neoclide/coc.nvim/issues/4372#issuecomment-1320880794
  command! -nargs=0 Format :call CocActionAsync('format')
  command! -nargs=0 OR :call CocActionAsync('organizeImport')
endif

augroup MyAutoCmd
  autocmd!
  "	hard	tab	
  "　Zenkaku　Space　
  " spaces at EOL 
  autocmd VimEnter,WinEnter,ColorScheme,Syntax * highlight TAB ctermbg=237 guibg=#f0f0f0
  autocmd VimEnter,WinEnter,ColorScheme,Syntax * highlight WhitespaceEOL ctermbg=red guibg=red
  autocmd VimEnter,WinEnter,ColorScheme,Syntax * highlight ZenkakuSpace ctermbg=red guibg=red
  autocmd VimEnter,WinEnter,ColorScheme,Syntax * highlight! link SignColumn LineNr
  autocmd VimEnter,WinEnter,ColorScheme,Syntax * call matchadd('ZenkakuSpace', '　')
  autocmd VimEnter,WinEnter,ColorScheme,Syntax * call matchadd('TAB', '\t')
  autocmd VimEnter,WinEnter,ColorScheme,Syntax * call matchadd('WhitespaceEOL', '\s\+$')
  autocmd VimEnter,WinEnter,ColorScheme,Syntax * call matchadd('Todo', '\(TODO\|NOTE\|XXX\|FIXME\):')
  autocmd BufRead,BufNewFile .git/COMMIT_EDITMSG,COMMIT_EDITMSG setlocal buflisted viminfo=
  autocmd BufRead,BufNewFile .vimrc setlocal buflisted
  autocmd InsertEnter,WinEnter,CursorHold * checktime
  autocmd FileType python     setlocal shiftwidth=4 tabstop=4 softtabstop=4 expandtab
  autocmd FileType make       setlocal shiftwidth=4 tabstop=4 softtabstop=4 noexpandtab
  autocmd FileType go         setlocal shiftwidth=4 tabstop=4 softtabstop=4 noexpandtab
  autocmd FileType c          setlocal shiftwidth=8 tabstop=8 softtabstop=8 noexpandtab
  autocmd FileType rst,mail,yaml,markdown   setlocal colorcolumn=79
  autocmd FileType yaml,json  setlocal cursorline cursorcolumn
  autocmd BufWritePost * if expand('%') != '' && &buftype !~ 'nofile' | silent! call mkdir($HOME . "/.vim", "p") | mkview | endif
  autocmd BufRead * if expand('%') != '' && &buftype !~ 'nofile' | silent loadview | endif
augroup END

if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif
