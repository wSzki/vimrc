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
#
#zmodload zsh/zprof # Startuptime measurments - uncomment zprof at EOF

[ -f ~/.instant-zsh.zsh ]         && source ~/.instant-zsh.zsh && instant-zsh-pre "%5Fλ %8F~ %f"
[ -f ~/.zplug/repos/rupa/z/z.sh ] && . ~/.zplug/repos/rupa/z/z.sh
[ -f ~/.fzf.zsh ]                 && ~/.fzf.zsh

export DOTFILES=$HOME/.dot
export BOX=$DOTFILES/box

 # ---------------------------------------------------------
 # -------------------- TMUX AUTOSTART ---------------------
 # ---------------------------------------------------------
 # If not running interactively, do not do anything # Otherwise start tmux
 #[[ $- != *i* ]] && return ; [[ -z "$TMUX" ]] && exec tmux

# ----------------------------------------------------------
# ------------------------ PLUGINS -------------------------
# ----------------------------------------------------------

if [ -d ~/.zplug ]; then

	source ~/.zplug/init.zsh

	zplug "rupa/z"
	zplug "aloxaf/fzf-tab"
	zplug "supercrabtree/k", defer:2
	zplug 'zplug/zplug', hook-build:'zplug --self-manage'
	zplug "zsh-users/zsh-syntax-highlighting", defer:2
	zplug "zsh-users/zsh-autosuggestions"
	#zplug "marlonrichert/zsh-autocomplete"
	zplug "subnixr/minimal"
	zplug "chisui/zsh-nix-shell"
	zplug "spwhitt/nix-zsh-completions"
	zplug "amaya382/zsh-fzf-widgets"
	#zplug "laggardkernel/zsh-thefuck", defer:2
	if ! zplug check; then	zplug install && exec zsh; fi

	zplug load #--verbose

# ----------------------------------------------------------
# ------------------ SYNTAX HIGHLIGHTING -------------------
# ----------------------------------------------------------

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

# ----------------------------------------------------------
# ----------------- SUBNIXR THEME SETTINGS -----------------
# ----------------------------------------------------------
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

# ----------------------------------------------------------
# ------------------------ BINDKEYS ------------------------
# ----------------------------------------------------------

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

# ----------------------------------------------------------
# ---------------- ZSH COMPLETION SUBSTRING ----------------
# ----------------------------------------------------------

zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
zstyle ':completion:*' completer _complete
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'
autoload -Uz compinit
compinit

# ----------------------------------------------------------
# ------------------------- SOURCE -------------------------
# ----------------------------------------------------------
# For ctrl+f and **
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

#source /etc/profile.d/autojump.zsh
#source /home/wsz/.config/broot/launcher/bash/br

fi ################################################### END ZPLUG

# ----------------------------------------------------------
# -------------------------- TMUX --------------------------
# ----------------------------------------------------------
#if [ "$TMUX" = "" ]; then tmux; fi
alias tmux="tmux attach-session || tmux"

# ----------------------------------------------------------
# ------------------------ HISTORY -------------------------
# ----------------------------------------------------------
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

# ----------------------------------------------------------
# -------------------------- CORE --------------------------
# ----------------------------------------------------------
#export DOTFILES="$(echo $HOME/dotfiles | tr -d '\r')"
function nix-clean  { nix-store --gc                                  } # Cleans cache
function shell      { nix-shell -p   "$@"                             } # Creates temp shell
function lobster    { nix-env   -iA  nixpkgs.$1                       } # Installs package as regular bin
function clam()     { ARGS=$@; shell $1 --run "$ARGS"                 } # Temp shell and execute
function crab       { ARGS="${@:2}"; shell $1 --run "sh -c \"$ARGS\"" } # Temp shell and exec if bin has different name

# ----------------------------------------------------------
# -------------------------- PKGS --------------------------
# ----------------------------------------------------------
#function node       { shell nodejs nodePackages.npm }
function so         { crab so                       "so  -e google $@" }
function lnav       { crab lnav                     "lnav $@"          }
function pip        { crab python310Packages.pip    "pip $@"           }
function howdoi     { crab python310Packages.howdoi "howdoi $@"        }
function npm        { crab nodePackages.npm         "npm $@"           }
function yarn       { crab nodePackages.yarn        "yarn $@"          }
function chromium   { crab ungoogled-chromium       "chromium $@"      }
function wtf        { crab wtf                      "wtfutil $@"       }
function gping      { crab gping                    "gping $@"         }
function hn         { crab haxor-news               "hn $@"            }
function dockerd    { crab docker                   "sudo dockerd $@"  }
function code       { crab vscodium                 "codium $@"        }
function fltrdr     { crab fltrdr "fltrdr --config-base ~/.dot/config/fltrdr $@" }
function mc         { clam matrix-commander --store ~/.config/matrix-commander/store $@ }
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
function browsh     { shell browsh firefox --run browsh  }


# ----------------------------------------------------------
# --------------------- NIX SHELL INIT ---------------------
# ----------------------------------------------------------
function nix-shell-init ()
{
	VAR=$@
	cp ~/.dot/config/nix/envrc ./.envrc
	cp ~/.dot/config/nix/shell.nix ./
	sed -i "s/ooo/${VAR}/g" ./shell.nix
	direnv allow .
}

 # ---------------------------------------------------------
 # ------------------------ DOCKER -------------------------
 # ---------------------------------------------------------
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


#source ~/.config/zsh/zsh-nix-shell/nix-shell.plugin.zsh

fi ################################################################################# END NIX

alias    chloe="mc -u ploupi -m"
function tdvk { tmux kill-session -t tidal }
function tdv  { tmux kill-session -t tidal ; ~/.dot/tidal/tidal ~/.dot/tidal/main.tidal }
function vcv  { export PIPEWIRE_LATENCY="2048/48000"; vcvrack }


FILE="/etc/passwd"

# ==============================================================================
# ---------------------------------- ALIASES -----------------------------------
# ==============================================================================

[ -f /bin/nvim ] && alias vim="nvim"

alias yay="pikaur"    && alias paru="pikaur"
alias del="trash-put" && alias dells="trash-list" && alias restore="trash-restore"
alias sl="ls"         && alias ka="k -Ah"         && alias kk="k -Ah" && alias ls="k -h" && alias l="k -h" && alias lsa="k -hA --sort WORD"

alias j="z"
alias t="$(which tldr)"
alias tldr="~/.tldr"
alias v="xdotool key v i m space Ctrl+f"
alias c="xdotool key c d space asterisk asterisk Tab"

alias copy="xclip -sel clip"
alias icat="kitty +kitten icat"
alias cal="cal -m"

alias tlprc="sudo vim ~/.dot/sys/tlp.conf"
alias vrc="cd ~/.config/nvim  && vim init.vim && cd -"
alias zpf="vim ~/.zprofile"
alias zrc="vim ~/.zshrc"
alias crc="vim ~/.uncrustify.cfg"
alias xrc="vim ~/.xinitrc"
alias trc="vim ~/.tmux.conf"
alias vimc="vim ~/.vim/ftplugin/c_mappings.vim"
alias krc="vim ~/.config/kitty/kitty.conf"
alias irc="vim ~/.config/i3/conf.i3config"
alias ibrc="vim ~/.config/i3/i3blocks.conf"
alias isrc="vim ~/.config/i3/i3status.conf"
alias ib2rc="vim ~/.config/i3/i3blocks2.conf"
alias config="cd ~/.config"

alias csnippets="vim /home/wsz/.config/coc/ultisnips/c.snippets"
alias cppsnippets="vim /home/wsz/.config/coc/ultisnips/cpp.snippets"
alias cppsnippets="vim /home/wsz/.config/coc/ultisnips/cpp.snippets"
alias jssnippets="vim /home/wsz/.config/coc/ultisnips/js.snippets"
alias jsxsnippets="vim /home/wsz/.config/coc/ultisnips/javascriptreact.snippets"

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

if [ -f /bin/nvim ];then alias vim="nvim" ; else alias vim="vim -u NONE"; fi


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
alias fxd="/bin/vim -c "FoxDotStart" -u ~/.dot/box/foxdot/foxdot.vimrc ~/.dot/box/foxdot/main.sc"
alias frc="vim ~/.dot/box/foxdot/foxdot.vimrc"
alias surge="gitap && npm run build && cd build && surge ./ amita.surge.sh"
#alias surge="~/.yarn/bin/surge"
alias inc="echo \"export CPATH=$CPATH:$PWD\" >> ~/.zshrc; source ~/.zshrc"
alias heavy="ps -Ao user,uid,comm,pid,pcpu,tty --sort=-pcpu | head -n 6"
alias sudo_lock="sudo passwd -l root"
alias sudo_unlock="sudo passwd -u root"
alias serve="python -m http.server 8000"
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
alias todo="vim ~/.dot/box/todo/todo.md"
alias touchpad_restart="xinput disable 11 && xinput enable 11"
###		AUDIO
#alias glitchout="aplay /bin/*"

# ==============================================================================
# --------------------------------- FUNCTIONS ----------------------------------
# ==============================================================================

# BACKUP ...............................
# ......................................
function back {
	CURRENT_DIR=$PWD
	cd ~/.dot && git add . && git status && git commit -m Backup && git push
	cp -r ~/.dot/config/nvim/* ~/.vimrc.git
	cp ~/.dot/config/tmux/tmux.conf ~/.vimrc.git/
	cp ~/.zshrc ~/.vimrc.git/zshrc
	cd ~/.vimrc.git && git add . && git status && git commit -m Backup && git push
	cd $CURRENT_DIR
}

# GIT ..................................
# ......................................
function gch {
	if [[ $1 == "" ]]; then
		fzf-git-checkout 2> /dev/null
	else
		git checkout $1
	fi
}

# VIMSPECTOR GENERATE FILE .............
# ......................................
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


# YOUTUBE DL ...........................
# ......................................
function dl () {
	if [[ "$1" == "mp3" ]]; then
		yt-dlp -xo '%(title)s.%(ext)s' --embed-thumbnail --audio-format mp3 $2;
		if [[ "$1" == "wav" ]]; then
			yt-dlp -xo '%(title)s.%(ext)s' --embed-thumbnail --audio-format wav $2;
		fi;
	fi;
	}

# COUNTDOWN ............................
# ......................................
alias snippets="cd  ~/.config/coc/ultisnips/ && v"
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

# TIMER ................................
# ......................................
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
# ---------------------------------- CORE END ----------------------------------
# ==============================================================================
# Compilation flags
# export ARCHFLAGS="-arch x86_64"

[ -f "/home/wsz/.ghcup/env" ] && source "/home/wsz/.ghcup/env" # ghcup-env
if type direnv > /dev/null; then eval "$(direnv hook zsh)"; fi

# ----------------------------------------------------------
# ---------------------- AUTOINSTALL -----------------------
# ----------------------------------------------------------

# ASYNC START ..........................
# ......................................
if [ ! -f ~/.instant-zsh.zsh ]; then
	curl -fsSL -o ~/.instant-zsh.zsh https://gist.github.com/romkatv/8b318a610dc302bdbe1487bb1847ad99/raw
	source ~/.instant-zsh.zsh
	instant-zsh-pre "%5Fλ %8F~ %f"
fi

# FZF ..................................
# ......................................
if [ ! -f ~/.fzf.zsh ]; then
	if [ ! -f /usr/bin/fzf ]; then
		git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf/
		~/.fzf/install
	fi
fi

# TLDR .................................
# ......................................
if [ ! -f ~/.tldr ]; then
	which tldr &> /dev/null
	if [[ $? ]]; then
		curl -o ~/.tldr https://raw.githubusercontent.com/raylee/tldr/master/tldr
		chmod +x ~/.tldr
	fi
fi


# ZPLUG ................................
# ......................................
if [ ! -d ~/.zplug ]; then
	curl -sL --proto-redir -all,https \
		https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
			sleep 2
			exec zsh
fi

# ----------------------------------------------------------
# -------------------------- MISC --------------------------
# ----------------------------------------------------------
stty -ixon       # disables ctrl+s
instant-zsh-post # faster zsh startup
#zprof           # Evaluate zsh startup time

# ----------------------------------------------------------
# ------------------------ INCLUDES ------------------------
# ----------------------------------------------------------
export CPATH=$CPATH:/home/wsz/irc/includes/
export CPATH=$CPATH:/home/wsz/irc/includes/numericReplies





