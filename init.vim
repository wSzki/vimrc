" **************************************************************************** "
"                                                                              "
"                                                         :::      ::::::::    "
"    init.vim                                           :+:      :+:    :+:    "
"                                                     +:+ +:+         +:+      "
"    By: wszurkow <wszurkow@student.42.fr>          +#+  +:+       +#+         "
"                                                 +#+#+#+#+#+   +#+            "
"    Created: 2020/09/29 17:22:42 by wszurkow          #+#    #+#              "
"    Updated: 2022/02/26 22:51:05 by wszurkow         ###   ########.fr        "
"                                                                              "
" **************************************************************************** "

set runtimepath^=~/.vim
set runtimepath+=~/.vim/after

let $dir_dotfiles = '~/.config/nvim'

let g:sclang_executable_path = "/usr/bin/sclang"
let g:python_executable_path = "/usr/bin/python3"

" Automatically source vimrc on save.
autocmd! bufwritepost $MYVIMRC source $MYVIMRC
autocmd! BufWritePost $MYVIMRC source $MYVIMRC | echom "Reloaded $NVIMRC"

"nnoremap <Leader>s :source $MYVIMRC<CR>:PlugInstall<CR>
"
source $dir_dotfiles/plug.vim
source $dir_dotfiles/plug_settings.vim
source $dir_dotfiles/plug_settings.lua

source $dir_dotfiles/syntax.vim
source $dir_dotfiles/setters.vim
source $dir_dotfiles/mappings.vim

command!  PYNVIM   :!python3 -m pip install --user --upgrade pynvim

command! COCSETUP  :CocInstall
			\ coc-explorer
			\ coc-diagnostic
			\ coc-explorer
			\ coc-clangd
			\ coc-cmake
			\ coc-fzf-preview
			\ coc-sh
			\ coc-snippets
			\ coc-emmet
			\ coc-css
			\ coc-html
			\ coc-html-css-support
			\ coc-svg
			\ coc-eslint
			\ coc-tsserver
			\ coc-json
			\ coc-docker

" LINK VIMRC to NVIMRC > ~/.config/nvim/init.vim
"set runtimepath^=~/.vim runtimepath+=~/.vim/after
"let &packpath = &runtimepath
"source ~/.vimrc
"
"let g:LanguageClient_serverCommands = {
			"\ 'sh': ['bash-language-server', 'start']
			"\ }

"autocmd BufEnter * ContextEnable
"autocmd BufLeave * ContextDisable


hi CocExplorerNormalFloatBorder guifg=#414347 guibg=#272B34
hi CocExplorerNormalFloat guibg=#272B34
hi CocExplorerSelectUI guibg=#EBCB8B guifg=black
hi Pmenu guibg=#2A2E31

autocmd FileType floaterm nnoremap <buffer> <Esc> :q<CR>


nnoremap <leader>web :terminal<CR> i browsh<CR><C-l>


command! VIMSPECTORINIT
			\ :!echo
			\ '{"configurations":{"Launch":{ "adapter":"vscode-cpptools","configuration":{ "request": "launch" , "program": "./a.out" , "externalConsole":true }}}}'
			\ > ./.vimspector.json



lua require('scnvim').setup()


"source ~/.vim/colors/youpi.vim
