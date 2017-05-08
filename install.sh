#!/bin/bash
dotfiles="$HOME/.dotfiles"

if [ ! -e $dotfiles/.git ]; then
    echo "not found dotfiles"
    git clone https://github.com/rapwind/dotfiles.git $dotfiles
    git submodule init
else
    echo "dotfiles already exist"
    cd $dotfiles && git pull
fi
git submodule update

# dotfiles
for f in $dotfiles/.??*; do
    [[ "$(basename $f)" == ".git" ]] && continue
    [[ "$(basename $f)" == ".gitmodules" ]] && continue
    [[ "$(basename $f)" == ".DS_Store" ]] && continue

    if [ ! -e $HOME/$f ] ; then
        ln -nsfF $dotfiles/$(basename $f) $HOME/$(basename $f)
    fi
done

# prezto
for rcfile in $dotfiles/.zprezto/runcoms/??*; do
    [[ "$(basename $rcfile)" == "README.md" ]] && continue

    if [ ! -e $HOME/.$rcfile ] ; then
        ln -ns $rcfile $HOME/.$(basename $rcfile)
    fi
done
