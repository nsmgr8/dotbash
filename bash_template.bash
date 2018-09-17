export EDITOR="vim"
export PATH="$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH"

export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;33'

export LSCOLORS='Gxfxcxdxdxegedabagacad'

shopt -s histappend
export HISTCONTROL=ignoredups:ignorespace
export HISTSIZE=5000

unset MAILCHECK

if [[ "$TERM" != "dumb" ]]; then # To prevent tput errors when someone scps to this box
    export DOT_BASH=$HOME/code/dotbash

    LIB="${DOT_BASH}/lib/*.bash"
    for config_file in $LIB; do
      source $config_file
    done

    for file_type in "completion" "plugins"; do
      FILES="${DOT_BASH}/${file_type}/*.bash"
      for config_file in $FILES; do
        source $config_file
      done
    done
fi

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# OPAM configuration
. /Users/nasim/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true
export ANDROID_HOME=/usr/local/share/android-sdk
export JAVA_HOME=/Library/Java/Home
export ANDROID_HOME=/usr/local/share/android-sdk
export JAVA_HOME=/Library/Java/Home
export ANDROID_HOME=/usr/local/share/android-sdk
export JAVA_HOME=/Library/Java/Home
