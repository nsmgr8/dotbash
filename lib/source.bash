[[ -s $HOME/.pythonrc.py ]] && export PYTHONSTARTUP=$HOME/.pythonrc.py
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
[[ `which virtualenvwrapper.sh` ]] && . virtualenvwrapper.sh
[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && . $HOME/.tmuxinator/scripts/tmuxinator

[[ -f $HOME/.bash_profile.local ]] && source $HOME/.bash_profile.local
