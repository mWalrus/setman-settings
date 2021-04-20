" START: VIM-Plug plugins
call plug#begin()

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-airline/vim-airline'
Plug 'sainnhe/sonokai'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'preservim/nerdcommenter'
Plug 'b3nj5m1n/kommentary'
Plug 'Yggdroot/indentLine'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-fugitive'
Plug 'psliwka/vim-smoothie'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()
" END: VIM-Plug plugins

" START: Basic vim configuration
" prevent netrw explorer loading on startup
let loaded_netrwPlugin=1
set number
set number relativenumber
syntax on
" set cursor at mouse click location
set mouse=a
" set tab size to 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab
" disable autocomment on newline
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
 "enable autocomplete
set wildmode=longest,list,full
" remove trailing whitespaces on save
autocmd BufWritePre * %s/\s\+$//e
" auto open coc-explorer on startup
" if a file was opened we skip opening explorer
if expand('%:t') == ""
  autocmd VimEnter * CocCommand explorer
endif
" improve ux
set updatetime=300

" END: Basic vim configuration

" START: Syntax highlighting configuration
au BufNewFile,BufRead *.hbs set filetype=html
" END: Syntax highlighting confuguration

" START: Custom keybinds
let mapleader = " "
" Open the coc-explorer
nnoremap <space>e :CocCommand explorer<CR>
" Resize window splits
nnoremap <silent> <C-A-Up> :resize +5<CR>
nnoremap <silent> <C-A-Down> :resize -5<CR>
nnoremap <silent> <C-A-Left> :vertical resize -5<CR>
nnoremap <silent> <C-A-Right> :vertical resize +5<CR>
"set nerdcommenter toggle to usual keybind
nmap <C-k> <Plug>NERDCommenterToggle
vmap <C-k> <Plug>NERDCommenterToggle<CR>gv
"Move between windows inside vim
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>
"CTRL-S to save files
nmap <c-s> :w<CR>
vmap <c-s> <Esc><c-s>gv
imap <c-s> <Esc><c-s>
" copy selection to clipboard
vnoremap <C-c> "*y
" auto close brackets and parentheses
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O
" close all buffers and exit
nmap <silent> <C-e> :qa<CR>
" navigate with hjkl in insert mode
inoremap <C-k> <Up>
inoremap <C-j> <Down>
inoremap <C-h> <Left>
inoremap <C-l> <Right>
" unbind arrow keys for navigation
"nmap <Up>    <Nop>
"nmap <Down>  <Nop>
"nmap <Left>  <Nop>
"nmap <Right> <Nop>
"imap <Up>    <Nop>
"imap <Down>  <Nop>
"imap <Left>  <Nop>
"imap <Right> <Nop>
" use tab for indent
nmap >> <Nop>
nmap << <Nop>
vmap >> <Nop>
vmap << <Nop>
nnoremap <Tab>   >>
nnoremap <S-Tab> <<
vnoremap <Tab>   >><Esc>gv
vnoremap <S-Tab> <<<Esc>gv
" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" show documentation
nnoremap <silent> K :call <SID>show_documentation()<CR>
" symbol renaming
nmap <F2> <Plug>(coc-rename)
" fuzzy file finder
nmap ff :Files .<CR>
" END: Custom keybinds
"----
" START: Editor colorscheme
if has ('termguicolors')
	set termguicolors
endif

let g:sonokai_style = 'andromeda'
let g:sonokai_enable_italic = 0
let g:sonokai_disable_italic_comment = 1

colorscheme sonokai
" END: Editor colorscheme

" START: treesitter syntaxhighlighting configs
lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    custom_captures = {
      -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
      ["foo.bar"] = "Identifier",
    },
  },
}
EOF

lua <<EOF
require'nvim-treesitter.configs'.setup {
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
}
EOF

lua <<EOF
require'nvim-treesitter.configs'.setup {
  indent = {
    enable = true
  }
}
EOF
" END: treesitter syntaxhighlighting configs
" START: functions
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction
" END: functions
