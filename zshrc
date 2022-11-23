#!/bin/sh
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    zshrc                                              :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: wszurkow <wszurkow@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/02/27 16:27:46 by wszurkow          #+#    #+#              #
#    Updated: 2022/02/27 16:29:26 by wszurkow         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# ==============================================================================
# ------------------------------------ CORE ------------------------------------
# ==============================================================================

# Startuptime measurments - uncomment zprof at EOF
#zmodload zsh/zprof

[ -f ~/.instant-zsh.zsh ]         && source ~/.instant-zsh.zsh && instant-zsh-pre "%5Fλ %8F~ %f"
[ -f ~/.zplug/repos/rupa/z/z.sh ] && . ~/.zplug/repos/rupa/z/z.sh
[ -f ~/.fzf.zsh ]                 && ~/.fzf.zsh

# TMUX AUTOSTART
# If not running interactively, do not do anything # Otherwise start tmux
#[[ $- != *i* ]] && return ; [[ -z "$TMUX" ]] && exec tmux

export DOTFILES=$HOME/.dot
export BOX=$DOTFILES/box

########################### PLUGINS ##################################

if [ -d ~/.zplug ]; then

	source ~/.zplug/init.zsh

	zplug "rupa/z"
	zplug "aloxaf/fzf-tab"
	zplug "supercrabtree/k", defer:2
	zplug 'zplug/zplug', hook-build:'zplug --self-manage'
	zplug "zsh-users/zsh-syntax-highlighting", defer:2
	zplug "zsh-users/zsh-autosuggestions"
	zplug "subnixr/minimal"
	zplug "chisui/zsh-nix-shell"
	zplug "spwhitt/nix-zsh-completions"
	zplug "amaya382/zsh-fzf-widgets"
	#zplug "laggardkernel/zsh-thefuck", defer:2
	if ! zplug check; then	zplug install && exec zsh; fi

	zplug load #--verbose



########################## SYNTAX HIGHLIGHTING #######################

ZSH_HIGHLIGHT_STYLES[path]='fg=gray, italic'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=yellow, bold'
ZSH_HIGHLIGHT_STYLES[alias]='fg=yellow, bold'
ZSH_HIGHLIGHT_STYLES[command]='fg=yellow, bold'
ZSH_HIGHLIGHT_STYLES[autodirectory]='fg=yellow, bold'
ZSH_HIGHLIGHT_STYLES[global-alias]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[command-substitution]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=magenta'
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(buffer-empty)

########################## SUBNIXR THEME SETTINGS ######################

function nix_component {
	if [[ $IN_NIX_SHELL ]]; then
		echo ▪️;
	fi
}

MNML_PROMPT=(mnml_status nix_component mnml_cwd)
MNML_MAGICENTER=()
MNML_INFOLN=()
MNML_OK_COLOR=5
MNML_ERR_COLOR=3

########################### BINDKEYS #################################

bindkey    "^[[3~"          delete-char
bindkey    "^[3;5~"         delete-char
bindkey    "^F" 			fzf-file-widget
bindkey    "^A" 			beginning-of-line
bindkey    "^E" 			end-of-line
bindkey    "^g" 			fzf-cd-widget
bindkey    "^k" 			fzf-kill-proc-by-list
#bindkey    "^s" 			fzf-git-status
# Autocompletes even if no whitespace
# BREAKS FZF TAB
#bindkey '^i' expand-or-complete-prefix # https://stackoverflow.com/questions/37772712/zsh-how-to-make-tab-completion-need-no-space-to-next-word-after-cursor

####################### ZSH COMPLETION SUBSTRING #####################

zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
zstyle ':completion:*' completer _complete
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'
autoload -Uz compinit
compinit
########################### SOURCE ###################################

# For ctrl+f and **
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

#source /etc/profile.d/autojump.zsh
#source /home/wsz/.config/broot/launcher/bash/br

fi # END OF PLUGIN SCOPE

######################## TMUX ###################################

#if [ "$TMUX" = "" ]; then tmux; fi
alias tmux="tmux attach-session || tmux"

######################### HISTORY ###################################

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY_TIME
setopt EXTENDED_HISTORY
setopt appendhistory
setopt AUTO_CD
#setopt ALWAYS_TO_END

# ==============================================================================
# ------------------------------------ NIX -------------------------------------
# ==============================================================================


which nix &> /dev/null
if [[ $? -eq 0 ]]; then

#export DOTFILES="$(echo $HOME/dotfiles | tr -d '\r')"
function nix-clean { nix-store --gc            }
function shell     { nix-shell -p   "$@"       }
function lobster   { nix-env   -iA  nixpkgs.$1 }

function node     { shell nodejs nodePackages.npm }

function crab       { ARGS="${@:2}"; shell $1 --run "sh -c \"$ARGS\""}
function so       { crab so                       "so  -e google $@" }
function lnav     { crab lnav                     "lnav $@"          }
function pip      { crab python310Packages.pip    "pip $@"           }
function howdoi   { crab python310Packages.howdoi "howdoi $@"        }
function npm      { crab nodePackages.npm         "npm $@"           }
function yarn     { crab nodePackages.yarn        "yarn $@"          }
function chromium { crab ungoogled-chromium       "chromium $@"      }
function wtf      { crab wtf                      "wtfutil $@"       }
function gping    { crab gping                    "gping $@"         }
function hn       { crab haxor-news               "hn $@"            }
function dockerd  { crab docker                   "sudo dockerd $@"  }
function code     { crab vscodium                 "codium $@"        }
function fltrdr   { crab fltrdr "fltrdr --config-base ~/.dot/config/fltrdr $@" }

function docker {
	if [[ "$1" == "reset" ]]; then
		crab docker "echo '# DOCKER FACTORY RESET #'
		docker kill      $(docker ps -q)
		docker container prune       --force
		docker image     prune --all --force
		docker system    prune --all --force --volumes"
	else;
		crab docker "docker $@"
	fi
}

#function docker { ARGS="$@"; shell docker                --run "sh -c \"docker $ARGS\"" }
#function npm    { ARGS="$@"; shell nodePackages.npm      --run "sh -c \"npm $ARGS\""    }
#function pip    { ARGS="$@"; shell python310Packages.pip --run "sh -c \"pip $ARGS\""    }
#function lnav   { ARGS="$@"; shell lnav                  --run "sh -c \"lnav $ARGS\""     } # Stack

function clam()     { ARGS=$@; shell $1 --run "$ARGS" }

function gotop      { clam gotop      $@ }
function htop       { clam htop       $@ }
function sysz       { clam sysz       $@ }
function glances    { clam glances    $@ }
function zenith     { clam zenith     $@ }
function glow       { clam glow       $@ }
function kmon       { clam kmon       $@ }
function cointop    { clam cointop    $@ }
function scrcpy     { clam scrcpy     $@ }
function firefox    { clam firefox    $@ }
function tmpmail    { clam tmpmail    $@ }
function vlc        { clam vlc        $@ }
function bmon       { clam bmon       $@ }
function ctop       { clam ctop       $@ }
function sen        { clam sen        $@ }
function gitui      { clam gitui      $@ }
function lazygit    { clam lazygit    $@ }
function evince     { clam evince     $@ }
function delta      { clam delta      $@ }
function gpg-tui    { clam gpg-tui    $@ }
function wiki       { clam wiki-tui   $@ }
function docui      { clam docui      $@ } # Docker do  not use
function lazydocker { clam lazydocker $@ } # Docker use this
function tut        { clam tut        $@ } # Mastodon
function xplr       { clam xplr       $@ } # File   explorer
function s-tui      { clam s-tui      $@ } # Stress test
function hn         { clam haxor-news $@ }
function uncrustify { clam uncrustify $@ }
function lldb       { clam lldb       $@ }
function gdb        { clam gdb        $@ }
function scrcpy     { clam scrcpy     $@ }

function browsh { shell browsh firefox --run browsh  }


function mc         {  clam matrix-commander --store ~/.config/matrix-commander/store $@ }
alias    chloe="mc -u ploupi -m"
#function tuir       { cap tuir}

function back {
	cd ~/.dot && git add . && git status && git commit -m Backup && git push && cd -
	cp -r ~/.dot/config/nvim/* ~/.vimrc.git
	cp ~/.dot/config/tmux/tmux.conf ~/.vimrc.git/
	cp ~/.zshrc ~/.vimrc.git/zshrc
	cd ~/.vimrc.git && git add . && git status && git commit -m Backup && git push && cd -
}

function tdvk { tmux kill-session -t tidal }
function tdv  { tmux kill-session -t tidal ; ~/.dot/tidal/tidal ~/.dot/tidal/main.tidal }
function vcv  { export PIPEWIRE_LATENCY="2048/48000"; vcvrack }


function vimspector {
	echo 'DO NOT FORGET TO COMPILE WITH -g'
	echo 'Done.'
	echo '
	{
		"configurations": {
		"Launch": {
		"adapter": "vscode-cpptools",
		"configuration": {
		"request": "launch",
		"program": "./a.out",
		"args": ["", ""],
		"externalConsole": true
	}
}
}
}' > .vimspector.json
}



alias snippets="cd  ~/.config/coc/ultisnips/ && v"


function nix-shell-init () {
	VAR=$@
	cp ~/.dot/config/nix/envrc ./.envrc
	cp ~/.dot/config/nix/shell.nix ./
	sed -i "s/ooo/${VAR}/g" ./shell.nix
	direnv allow .
}
#source ~/.config/zsh/zsh-nix-shell/nix-shell.plugin.zsh

fi # END NIX

countdown() {
	start="$(( $(date +%s) + $1))"
	while [ "$start" -ge $(date +%s) ]; do
		## Is this more than 24h away?
		days="$(($(($(( $start - $(date +%s) )) * 1 )) / 86400))"
		time="$(( $start - `date +%s` ))"
		printf '%s day(s) and %s\r' "$days" "$(date -u -d "@$time" +%H:%M:%S)"
		sleep 0.1
	done
}

stopwatch() {
	start=$(date +%s)
	while true; do
		days="$(($(( $(date +%s) - $start )) / 86400))"
		time="$(( $(date +%s) - $start ))"
		printf '%s day(s) and %s\r' "$days" "$(date -u -d "@$time" +%H:%M:%S)"
		sleep 0.1
	done
}

# ==============================================================================
# ---------------------------------- ALIASES -----------------------------------
# ==============================================================================
alias yay="pikaur"
alias paru="pikaur"
alias tlprc="sudo vim ~/.dot/sys/tlp.conf"
#alias vrc="cd ~/.config/nvim  && vim -c 'CocCommand explorer --toggle' plug.vim && cd -"
alias vrc="cd ~/.config/nvim  && vim init.vim && cd -"
alias zpf="vim ~/.zprofile"
alias zrc="vim ~/.zshrc"
alias crc="vim ~/.uncrustify.cfg"
alias xrc="vim ~/.xinitrc"
alias trc="vim ~/.tmux.conf"
alias vimc="vim ~/.vim/ftplugin/c_mappings.vim"
alias csnippets="vim /home/wsz/.config/coc/ultisnips/c.snippets"
alias cppsnippets="vim /home/wsz/.config/coc/ultisnips/cpp.snippets"
alias cppsnippets="vim /home/wsz/.config/coc/ultisnips/cpp.snippets"
alias jssnippets="vim /home/wsz/.config/coc/ultisnips/js.snippets"
alias jsxsnippets="vim /home/wsz/.config/coc/ultisnips/javascriptreact.snippets"
alias vdir="vim ~/.dot/vim/"
alias krc="vim ~/.config/kitty/kitty.conf"
alias irc="vim ~/.config/i3/conf.i3config"
alias ibrc="vim ~/.config/i3/i3blocks.conf"
alias isrc="vim ~/.config/i3/i3status.conf"
alias ib2rc="vim ~/.config/i3/i3blocks2.conf"
alias config="cd ~/.config"
alias dotfiles="cd $DOTFILES"
alias glog4="git log --graph --pretty=oneline --abbrev-commit"
alias glog1="git log --graph --oneline --decorate"
alias glog2="git log --graph --oneline --decorate --branches --tags"
alias glog3="git log --graph --oneline --decorate --all"
alias glog5="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset)%x09%C(bold green)(%ar)%C(reset) %x09%C(white)%s%C(reset) %C(dim white) - %an%C(reset)%C(auto)%d%C(reset)' --all"
alias glog8="figlet GIT LOG; git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset)%x09%an%C(reset)%x09%C(bold green)(%ar)%C(reset)%x09%C(white)%s%C(reset) %C(dim white)%C(auto)%d%C(reset)' --all"
alias glog7="git log --graph --abbrev-commit --decorate=no --date=format:'%Y-%m-%d %H:%I:%S' --format=format:'%C(03)%>|(26)%h%C(reset)  %C(04)%ad%C(reset)  %C(green)%<(16,trunc)%an%C(reset)  %C(bold 1)%d%C(reset) %C(bold 0)%>|(1)%s%C(reset)' --all"
alias glog="clear; figlet GIT LOG; git log --graph --abbrev-commit --decorate=no --date=format:'%Y-%m-%d %H:%I:%S' --format=format:'%C(03)%>|(20)%h%C(reset) %C(04)%<(14,trunc)%ar%C(reset)  %C(green)%<(10,trunc)%an%C(reset) %C(bold white)%s%C(reset) %C(auto)%d%C(reset)' --all"

########################## TIDAL ######################################
#alias tdv="tdvk ; tidalvim ~/.dot/box/tidal/main.tidal"
alias tidalsnippets="vim /home/wsz/.config/coc/ultisnips/tidal.snippets"
alias tidald="cd ~/.dot/box/tidal/"
alias tidalvim="~/.dot/box/tidal/bin/tidalvim"
alias tidal="~/.dot/box/tidal/bin/tidal"
#alias tdvk="tmux kill-session -t tidal"

########################## VIM ######################################

FILE="/etc/passwd"
if [ -f /bin/nvim ];then alias vim="nvim" ; else alias vim="vim -u NONE"; fi
alias ok="nvim"

########################### FASD ###############################

#eval "$(fasd --init auto)"
#alias j="fasd_cd -d"
alias j="z"
alias t="tldr"
alias v="xdotool key v i m space Ctrl+f"
alias c="xdotool key c d space asterisk asterisk Tab"

########################### TRASH-CLI ###############################

alias del="trash-put"
alias dells="trash-list"
alias restore="trash-restore"
alias delete="mv -t ~/.Trash/"
#set -o noclobber # prevent > override


########################### ALIASES ##################################

### DEFAULTS
alias exvim="nvim -u ~/vimrc"
alias ..="cd .."
alias cddl="cd ~/Downloads"
alias wip="cd ~/42/wip"
#alias back="~/.dot/backup.sh"
alias autopush="git add .; git status; git commit -m "autopush"; git push"
alias n0="vim $BOX/notes.md"
alias n1="vim ~/.dot/box/todo/todo.md"
alias norme="norminette"
#alias valgrind_color="~/.local/bin/colour-valgrind"
#if [ -f ~/.local/bin/colour-valgrind ]; then alias valgrind="valgrind_color --tool=memcheck --leak-check=full --leak-resolution=high --show-reachable=yes" ; fi
alias valgrind="valgrind --tool=memcheck --leak-check=full --leak-resolution=high --show-reachable=yes --show-leak-kinds=all --track-origins=yes --verbose -s "
alias valgrind_no_fork="valgrind --child-silent-after-fork=yes"

MAKEFILE_PATH="~/.dot/bin/scripts/newMakefile"
alias Makefile_create="/bin/cat $MAKEFILE_PATH"
alias Makefile_edit="vim $MAKEFILE_PATH"

### MISC
alias man=men
alias qq="tmux kill-session"
#alias vimspector='{"configurations": {"Launch": {"adapter": "vscode-cpptools","configuration": {"request": "launch","program": "./a.out","externalConsole": true}}}}'
alias fxd="/bin/vim -c "FoxDotStart" -u ~/.dot/box/foxdot/foxdot.vimrc ~/.dot/box/foxdot/main.sc"
alias frc="vim ~/.dot/box/foxdot/foxdot.vimrc"
alias surge="gitap && npm run build && cd build && surge ./ amita.surge.sh"
#alias surge="~/.yarn/bin/surge"
alias top="gtop"
alias icat="kitty +kitten icat"
alias inc="echo \"export CPATH=$CPATH:$PWD\" >> ~/.zshrc; source ~/.zshrc"
alias heavy="ps -Ao user,uid,comm,pid,pcpu,tty --sort=-pcpu | head -n 6"
alias sudo_lock="sudo passwd -l root"
alias sudo_unlock="sudo passwd -u root"
alias cat="bat"
alias ccat="bat --style=plain"
alias serve="python -m http.server 8000"
alias cal="cal -m"
alias vsch="vim ~/.dot/sch.md"
alias 42="cd ~/42"
alias powertop="sudo powertop"
alias autotune="sudo powertop --auto-tune"
alias playlist="vim ~/.config/mpv/playlist"
alias tmp="cd ~/.tmp"
alias dot="cd ~/.dot"
alias ddgr="ddgr --colors 'djcddf'"
alias rain="buku -a"
alias buku="buku --colors 'djedf'"
alias nn="kitty & disown && clear"
alias list_functions="nm -g"
alias echo="echo -e"

### UXN
alias uxnemu="~/.uxn/bin/uxnemu"
alias drum_rack="uxnemu ~/.uxn/bin/drum.rom"
alias piano_rack="uxnemu ~/.uxn/bin/piano.rom"
alias uxn="cd ~/.uxn"

### GIT
alias gcl="git clone"
alias glo="fzf-git-log"
alias gst="fzf-git-status"
function gch {
	if [[ $1 == "" ]]; then
		fzf-git-checkout
	else
		git checkout $1
	fi
}


### SSH
if [ $TERM = "xterm-kitty" ] ; then alias ssh="kitty +kitten ssh" ; fi

### GIT
alias gitls="curl -s \"https://api.github.com/users/wszki/repos?per_page=100\" | grep -o 'git@[^\"]*'"

### IP SCAN
alias nmap_scan="sudo arpi"
alias nmap_scan_0="sudo arpi -net=192.168.0.0/24 && sudo arpi"

########################### AUDIO ##################################

### SUPERCOLLIDER
alias collider="pasuspender -- jackd ; jackd -r -d alsa &> /dev/null & vim -c "SCNvimStart" ~/.dot/supercollider/main.sc && killall jackd"
alias startjack="pasuspender -- jackd ; jackd -r -d alsa &> /dev/null &"
#alias collider="vim  ~/.dot/supercollider/main.sc"

### RENOISE
alias renoise="pasuspender -- jackd ; jackd -r -d alsa &> /dev/null & /usr/local/bin/renoise-3.3.1 && killall jackd"

########################## PACKAGE MANAGER ########################

### PACMAN
alias pac="sudo pacman -S"
alias pacs="pacman -Ss"
alias pacsyu="sudo pacman -Syu"
alias pac-orphans="pacman -Qtd"

### YAY
alias yay-cache-clear="rm ~/.cache/yay/completion.cache"

### MISC
alias mpv360="mpv --ytdl-format=18"
alias mpv720="mpv --ytdl-format=18"
alias ntf="notify.sh"
alias cppwd="pwd | copy"
alias ,,="i3-msg move to scratchpad"
alias info="info -v match-style=black,bgred,bold -v active-link-style=black,bgyellow,bold -v link-style=yellow"
alias copy="xclip -sel clip"
alias ytfzf="ytfzf -t"
alias ack="ack --color-match=yellow --color-lineno=magenta --color-filename=blue"
alias ipinfo="curl ipinfo.io"
alias internet_log="ss -p"
alias session_screen_share="cd ; mkfifo sharescreen; script -f sharescreen"
alias screenshot_terminal="ps aux | convert label:@- process.png"
alias veille="systemctl suspend && slock"
alias services="systemctl --type=service"
alias bday="birthday -f ~/.dot/schedule"
alias schedule="vim ~/.dot/schedule"
###     PERFORMANCE
alias governor-performance="sudo cpupower frequency-set -g performance"
alias governor-powersave="sudo cpupower frequency-set -g powersave"
alias governor-ondemand="sudo cpupower frequency-set -g ondemand"
alias governor-conservative="sudo cpupower frequency-set -g conservative"
alias powertop-report="sudo powertop --html=powerreport.html"
### K IS LS
alias sl="ls"
alias ka="k -Ah"
alias kk="k -Ah"
alias ls="k -h"
alias l="k -h"
alias lsa="k -hA --sort WORD"

########################################################################
############################### TRASH ##################################
########################################################################

## DOCKER
#alias docker_start="sudo systemctl start docker.service"
#alias docker_stop="sudo systemctl stop docker.service"
#alias ,dpc="docker container prune"
#alias ,dlsi="docker images"
#alias ,dlsc="docker container list"
#alias ,drun="docker run -it"
#alias ,dbuild="docker build -t tmp_name ./"
alias todo="vim ~/.dot/box/todo/todo.md"

### C
#alias gcc="clang"
#alias gccc="gcc -Wall -Werror -Wextra"
#alias clangc="gcc -Wall -Werror -Wextra"
#alias gccf="gcc -g -fsanitize=address -Wall -Werror -Wextra"
#alias clangf="gcc -g -fsanitize=address -Wall -Werror -Wextra"
##alias norminette="~/.norminette/norminette.rb"
#alias norme="norminette -R CheckForbiddenSourceHeader"
#alias grademe="~/42/Libftest/grademe.sh -n"
#alias deepthought="vim ~/42/Libftest/deepthought"
#alias gnl="cd ~/42/gnl"
#alias bundle="~/.gem/ruby/2.7.0/bin/bundle"
#alias ftsrv="cd ~/42/ft_server"
#alias ddbuild="docker build -t server . && docker create -it server /bin/bash &&  "
#### TASK
#alias ,t="task"
#alias t="clear & task summary ; task list rc.dateformat=a_d/m_H:N ; task calendar "
#alias ,tdt="task due:tomorrowT12:00"
#alias ,tdl="task delete"
#alias ,tadd="task add"
#alias ddd="cd ~/42/cub3d"

### CUB3D
#alias man_mlx="man /usr/local/man/man3/mlx.1"
#alias man_mlx_loop="man /usr/local/man/man3/mlx_loop.1"
#alias man_mlx_new_image="man /usr/local/man/man3/mlx_new_image.1"
#alias man_mlx_pixel="man /usr/local/man/man3/mlx_pixel_put.1"
#alias man_mlx_window="man /usr/local/man/man3/mlx_new_window.1"
#alias c3d="cd ~/42/cub3d"
#alias gcc_mlx="gcc -I /usr/local/include/  main.c -L /usr/local/lib/ -lXext -lX11 -lmlx"
## task add Pay rent due:28th recur:monthly until:now+1yr


## SERVER
#alias server-start="sudo systemctl start mariadb.service; sudo systemctl start httpd.service"
#alias server-stop="sudo systemctl stop mariadb.service; sudo systemctl stop httpd.service"
#alias server-restart="sudo systemctl restart mariadb.service; sudo systemctl restart httpd.service"


### MPV
#alias mpyt="mpv --playlist=/home/wsz/.playlist --shuffle --no-video"
#alias mpsyt="~/.local/bin/mpsyt"

### YOUTUBLE DL
#
#alias youtube-dl-mp3="youtube-dl --extract-audio --audio-format mp3     "
#alias ytdlm="cdyt; youtube-dl -x --audio-format wav"
#alias dddl="cdyt; youtube-dl -xi --audio-format wav"
alias dddlhere="youtube-dl -xi --audio-format wav"
#alias ddlddl="cdyt; youtube-dl -xi --audio-format wav --no-playlist"
alias youtube-dl-wav="youtube-dl -xo '%(title)s.%(ext)s' --audio-format wav"
#alias youtube-dl-playlist="youtube-dl -a playlist -xo '%(title)s.%(ext)s' --audio-format wav"

function dl () {
	if [[ "$1" == "audio" ]]; then
		yt-dlp -xo '%(title)s.%(ext)s' --embed-thumbnail --audio-format mp3 $2;
	fi;
}

### RM LOCK
#alias rm="rm -i"

## DATABASE
#alias maria="sudo mariadb"
#alias portinfo="sudo nmap -n -PN -sT -sU -p- localhost"

### CCAT
#alias cat="/bin/ccat --color=always"
#alias catc="/bin/ccat --color=always"

### GDB TUI
#alias db="gdb -tui -q"
#alias gdb="gdb -q"



### XCLIP
#alias pbc="xclip -selection clipboard"
#alias pbp="xclip -selection clipboard -o"

#alias f="fzf -e --preview='cat {}'  --preview-window=right:50%:wrap"
#alias a="ack --color-match=yellow --color-lineno=magenta --color-filename=blue"
#
#
#
#
#
#
#
#alias is="vim ~/Tree/Suckless/installScript/installScript.sh"
#alias edp_1="xrandr --output eDP-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DP-1 --off --output HDMI-1 --off --output DP-2 --off --output HDMI-2 --off --output DP-2-1 --off --output DP-2-2 --off --output DP-2-3 --off"
#alias hdmion="xrandr --output HDMI-2 --auto --above eDP-1"
#alias hdmioff="xrandr --output HDMI-2 --off"
#alias docked-1=" xrandr --output eDP-1 --primary --mode 1920x1080 --pos 773x1440 --rotate normal --output DP-1 --off --output HDMI-1 --off --output DP-2 --off --output HDMI-2 --off --output DP-2-1 --mode 2560x1440 --pos 1800x0 --rotate normal --output DP-2-2 --off --output DP-2-3 --mode 1440x900 --pos 0x315 --rotate normal; xrandr --output DP-2-3"
##alias docked-1=" xrandr --output eDP-1 --primary --mode 1920x1080 --pos 773x1440 --rotate normal --output DP-1 --off --output HDMI-1 --off --output DP-2 --off --output HDMI-2 --off --output DP-2-1 --mode 2560x1440 --pos 1800x0 --rotate normal --output DP-2-2 --off --output DP-2-3 --mode 1440x900 --pos 0x315 --rotate normal; xrandr --output DP-2-3 --scale 1.25x1.25 "
##alias docked-1="xrandr --output DP-2-3 --scale 1.25x1.25 ; xrandr --output eDP-1 --primary --mode 1920x1080 --pos 773x1440 --rotate normal --output DP-1 --off --output HDMI-1 --off --output DP-2 --off --output HDMI-2 --off --output DP-2-1 --mode 2560x1440 --pos 1800x0 --rotate normal --output DP-2-2 --off --output DP-2-3 --mode 1440x900 --pos 0x315 --rotate normal; "
##alias docked-1="edp_1 ; xrandr --output eDP-1 --primary --mode 1920x1080 --pos 1253x1440 --rotate normal --output DP-1 --off --output HDMI-1 --off --output DP-2 --off --output HDMI-2 --off --output DP-2-1 --mode 2560x1440 --pos 1920x0 --rotate normal --output DP-2-2 --off --output DP-2-3 --mode 1440x900 --pos 480x540 --rotate normal"
#alias docked-1="edp_1 && xrandr --output eDP-1 --primary --mode 1920x1080 --pos 1280x1440 --rotate normal --output DP-1 --off --output HDMI-1 --off --output DP-2 --off --output HDMI-2 --off --output DP-2-1 --mode 2560x1440 --pos 1280x0 --rotate normal --output DP-2-2 --mode 1280x1024 --pos 0x584 --rotate normal --output DP-2-3 --off"
#alias vga-1h="xrandr --output eDP-1 --primary --mode 1920x1080 --pos 0x1080 --rotate normal --output DP-1 --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-1 --off --output DP-2 --off --output HDMI-2 --off"
#alias vga-1v="xrandr --output eDP-1 --primary --mode 1920x1080 --pos 0x1920 --rotate normal --output DP-1 --mode 1920x1080 --pos 840x0 --rotate left --output HDMI-1 --off --output DP-2 --off --output HDMI-2 --off"
#alias vga-off="xrandr --output DP-1 --off"
#alias dualon="xrandr --output eDP-1 --primary --mode 1920x1080 --pos 2025x1440 --rotate normal --output DP-1 --mode 1920x1080 --pos 1060x360 --rotate normal --output HDMI-1 --off --output DP-2 --off --output HDMI-2 --mode 2560x1440 --pos 2980x0 --rotate normal"
#alias dualon2="xrandr --output eDP-1 --primary --mode 1920x1080 --pos 366x1920 --rotate normal --output DP-1 --mode 1920x1080 --pos 0x0 --rotate left --output HDMI-1 --off --output DP-2 --off --output HDMI-2 --mode 2560x1440 --pos 1080x480 --rotate normal"
#alias toweron1="xrandr --output eDP-1 --primary --mode 1920x1080 --pos 1080x1440 --rotate normal --output DP-1 --mode 1920x1080 --pos 0x0 --rotate left --output HDMI-1 --off --output DP-2 --off --output HDMI-2 --mode 2560x1440 --pos 1080x0 --rotate normal"
#alias towerson="xrandr --output eDP-1 --primary --mode 1920x1080 --pos 1080x2560 --rotate normal --output DP-1 --mode 1920x1080 --pos 0x1254 --rotate left --output HDMI-1 --off --output DP-2 --off --output HDMI-2 --mode 2560x1440 --pos 1080x0 --rotate left"
#alias ethernet="sudo systemctl start dhcpcd@enp0s31f6"
##alias vcv="cd ~/Tree/Rack/ && ./Rack"
#alias persist="nohup"
#alias showssh="cat ~/.ssh/id_rsa.pub"
#alias yank="xclip -sel clip"
## xinput --list | grep TouchPad
## TID=$(xinput list | grep -iPo 'touchpad.*id=\K\d+')
alias touchpad_restart="xinput disable 11 && xinput enable 11"



######  SERVICES
###     WIFI
#alias ip-info="ifconfig | grep \"inet \" | grep -v 127.0.0.1"
#alias wifi-auto-on="sudo systemctl enable netctl-auto@wlan0.service && sudo systemctl start netctl-auto@wlan0.service"
#alias wifi-auto-off="sudo systemctl disable netctl-auto@wlan0.service && sudo systemctl stop netctl-auto@wlan0.service"
#alias wifi="sudo wifi-menu"
#alias nmap-local="sudo nmap -sn 192.168.0.0/24"
#alias wifi-restart="sudo systemctl restart netctl-auto@wlan0.service"
#alias wifi_on="nmcli radio wifi on"
#alias wifi_off="nmcli radio wifi off"

#alias p="ping google.fr"

###     BLUETOOTH
#alias bluestart="sudo systemctl enable bluetooth.service && sudo systemctl start bluetooth.service"
#alias bluestop="sudo systemctl disable bluetooth.service && sudo systemctl stop bluetooth.service"


###     LOGIND.CONF
#alias nosleep="sudo vim /etc/systemd/logind.conf"

###     SLEEP
#alias sleep-off="sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target"
#alias sleep-on="sudo systemctl unmask sleep.target suspend.target hibernate.target hybrid-sleep.target"

###     BATTERY
#alias battery-monitor="udevadm monitor --property"

###		AUDIO
#alias glitchout="aplay /bin/*"



#####################################################################################

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
#DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
#ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi


# Compilation flags
# export ARCHFLAGS="-arch x86_64"

[ -f "/home/wsz/.ghcup/env" ] && source "/home/wsz/.ghcup/env" # ghcup-env


if type direnv > /dev/null; then eval "$(direnv hook zsh)"; fi

# ASYNC START
if [ ! -f ~/.instant-zsh.zsh ]; then
	curl -fsSL -o ~/.instant-zsh.zsh https://gist.github.com/romkatv/8b318a610dc302bdbe1487bb1847ad99/raw
	source ~/.instant-zsh.zsh
	instant-zsh-pre "%5Fλ %8F~ %f"
fi

# FZF
if [ ! -f ~/.fzf.zsh ]; then
	if [ ! -f /usr/bin/fzf ]; then
		git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf/
		~/.fzf/install
	fi
fi

# ZPLUG install
if [ ! -d ~/.zplug ]; then
	curl -sL --proto-redir -all,https \
		https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
			sleep 2
			exec zsh
fi

stty -ixon # disables ctrl+s
instant-zsh-post
#zprof
export CPATH=$CPATH:/home/wsz/irc/includes/
export CPATH=$CPATH:/home/wsz/irc/includes/numericReplies
