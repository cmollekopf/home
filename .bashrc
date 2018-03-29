#
# ~/.bashrc
#



# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
#Bash prompt
#default name@host
#PS1='[\u@\h \W]\$ '
#PS1='\[\e[1;32m\][\u@\h \W]\$\[\e[0m\] '
#nur name ohne host in grün, rest plain, für volles verzeichnis \W in \w ändern
PS1='\[\e[0;32m\]\u\[\e[m\] \[\e[1;34m\]\W\[\e[m\] \[\e[1;32m\]\$\[\e[m\]'
# mit weissem text:
# PS1='\[\e[0;32m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;32m\]\$\[\e[m\] \[\e[1;37m\]'

#PS1='\[\033[1;36m\][\[\033[1;34m\]\u\[\033[1;33m\]@\[\033[1;32m\]\h:\[\033[1;35m\]\w\[\033[1;36m\]]\[\033[1;31m\]\\$\[\033[0m\] ' 

export GREP_COLOR="1;33"
alias grep='grep --color=auto'

export LESS="-R"

export VISUAL=kwrite
export EDITOR=vim

function cd() {
  if test -z "$1"; then
    builtin cd         
  elif test -z "$2"; then
    builtin cd "$1"
  else
    builtin cd "$1" "$2"
  fi
  _f=`findup .my-setup`
  if test -n "$_f" -a "$_lastf" != "$_f"; then
    echo "Loading $_f"
    _lastf="$_f"
    source "$_f"
  fi
}

export OPERAPLUGINWRAPPER_PRIORITY=0
export OPERA_KEEP_BLOCKED_PLUGIN=1


#It erases duplicate entries, cranks the size up to 10K entries (you can never have enough bash history, and tells the shell to append to the older history file, not overwrite it on exit.
export HISTCONTROL=erasedups
export HISTSIZE=10000
shopt -s histappend

#colored manpages
man() {
	env \
		LESS_TERMCAP_mb=$(printf "\e[1;37m") \
		LESS_TERMCAP_md=$(printf "\e[1;37m") \
		LESS_TERMCAP_me=$(printf "\e[0m") \
		LESS_TERMCAP_se=$(printf "\e[0m") \
		LESS_TERMCAP_so=$(printf "\e[1;47;30m") \
		LESS_TERMCAP_ue=$(printf "\e[0m") \
		LESS_TERMCAP_us=$(printf "\e[0;36m") \
			man "$@"
}

alias imonline="qdbus org.kde.kded /modules/networkstatus org.kde.Solid.Networking.setNetworkStatus ntrack 4"
alias imoffline="qdbus org.kde.kded /modules/networkstatus org.kde.Solid.Networking.setNetworkStatus ntrack 1"
export INTEL_LICENSE_FILE=/opt/intel/licences/NCOM_L_VT__NHBB-X2FZ6DBD.lic
alias vtune="/opt/intel/vtune_amplifier_xe_2011/bin64/amplxe-gui"
#export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel"
export AWT_TOOLKIT="MToolkit"

export PATH="/usr/lib/ccache/bin/:$PATH"
alias make='nice make -j5'

export KF5=$HOME/kf5

set -o vi
