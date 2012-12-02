#!/usr/bin/env bash
CWD=$(pwd)
DOT_BASH=$CWD/$(dirname $0)
cd $DOT_BASH

## Check Bash Version

if [[ x"$BASH_VERSION" = "x" ]]; then
    echo "I work only with Bash"
    exit 1
fi

echo "Linking the template .bash_profile into ~/.bash_profile, edit this file to customize dotbash"
ln -s -f $DOT_BASH/bash_template.bash $HOME/.bash_profile
if [[ $(uname -s) == "Linux" && $(grep '\.bash_profile' $HOME/.bashrc) = '' ]]; then
        cat >> $HOME/.bashrc <<EOF
source \$HOME/.bash_profile
EOF
fi

echo "Setting up application-specific configs"
cd $DOT_BASH/configs
for f in $(ls); do
    ln -s -f "$DOT_BASH/configs/$f" "$HOME/.$f" &>/dev/null
done
cd $DOT_BASH

source $HOME/.bash_profile

cd $CWD
echo "Finished. Open a new shell now!"
