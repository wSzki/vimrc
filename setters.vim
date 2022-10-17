" **************************************************************************** "
"                                                                              "
"                                                         :::      ::::::::    "
"    setters.vim                                        :+:      :+:    :+:    "
"                                                     +:+ +:+         +:+      "
"    By: wszurkow <wszurkow@student.42.fr>          +#+  +:+       +#+         "
"                                                 +#+#+#+#+#+   +#+            "
"    Created: 2022/02/27 14:47:15 by wszurkow          #+#    #+#              "
"    Updated: 2022/02/27 14:47:58 by wszurkow         ###   ########.fr        "
"                                                                              "
" **************************************************************************** "

"################################################ "
"### GLOBAL SETTINGS  ### "
"################################################ "


" Settings
"""""""""""
set mouse=a
set splitright
set clipboard^=unnamed,unnamedplus
set nu
"set nocompatible
set scrolloff=5
set relativenumber
set laststatus=2
set background=dark
set history=1000
set noswapfile
set foldmethod=syntax
set foldnestmax=1
set foldlevelstart=20
"set autochdir
syn on
set cmdheight=0 " hide commandline when unused
"set signcolumn=number
"set clipboard=unnamed

"Indentation
"""""""""""""
filetype indent on
filetype plugin on
set autoindent
set cindent
set smartindent

" Lines, rulers, wrapping
""""""""""""""""""""""""""
set linebreak
set ruler
set nowrap
set tabstop=4
set shiftwidth=4
set breakindent
set breakindentopt=shift:2
set showbreak=↳
set cursorcolumn
"set cc=80
set cursorline
"set nocursorline
"set showbreak=\\\\\↳

" Increments
"""""""""""""
"nnoremap = <C-a>
"nnoremap - <C-x>
"nnoremap <C-c> <C-a><Plug>TidalRegionSend
"nnoremap <C-x> <C-x><Plug>TidalRegionSend


" Search
"""""""""
"set incsearch
"set hlsearch
"set infercase
"set smartcase

" Wildmenu
"""""""""""
set wildmode=longest:full,full
set wildmenu
set wildignorecase
"set wildmode=longest,list,full
"set wildmode=list

" Split
""""""""
"Automatically equalize splits when Vim is resized
autocmd VimResized * wincmd =
set splitbelow
set splitright

" WhiteSpaces
""""""""""""""
set list
set listchars=space:.,tab:•-,trail:~,extends:>,precedes:<
"set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<

"################################################ "
"### PERFORMANCE SETTINGS  ### "
"################################################ "

" Improve scroll performance for certain file types:
"""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup syntaxSyncMinLines
	autocmd!
	autocmd Syntax * syntax sync minlines=2000
augroup END

" Performance misc
"""""""""""""""""""
set encoding=utf-8
set complete-=5
set lazyredraw
set re=1
"set redrawtime=100
"set timeoutlen=1000 " slows down whichkey
set synmaxcol=400
syntax sync minlines=256

" True Color settings
""""""""""""""""""""""
if has('termguicolors')
	set termguicolors
endif
"" Correct RGB escape codes for vim inside tmux
"if !has('nvim') && $TERM ==# 'screen-256color'
"	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
"	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
"endif

" No Indent Pasting
""""""""""""""""""""
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
function! XTermPasteBegin()
	set pastetoggle=<Esc>[201~
	set paste
	return ""
endfunction

" Disable clear clipboard onleave
""""""""""""""""""""""""""""""""""
autocmd VimLeave * call system("xclip -o | xclip -selection c")
"if  has('clipboard_data')
"autocmd VimLeave * call system("echo -n $'" . escape(getreg(), "'") . "' | xclip -selection buffer-cut")
"endif
"autocmd VimLeave * call system('echo -n' . shellescape(getreg('+')) .
			"\ ' | xclip -selection clipboard')
"autocmd VimLeave * call system("xsel -ib", getreg('+'))
"autocmd VimLeave * call system("xclip -selection clipboard -i", getreg('+'))
"autocmd VimLeave * call system("xclip -selection clipboard -i", getreg('+'))
