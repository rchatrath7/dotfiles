#!/bin/bash

ln -sfn $HOME/oh-my-zsh/.oh-my-zsh $HOME/.oh-my-zsh
ln -sfn $HOME/tools/fzf/.fzf $HOME/.fzf
ln -sfn $HOME/tools/gitz/.gitz $HOME/.gitz
ln -sfn $HOME/spacevim/.spacevim $HOME/.spacevim
ln -sfn $HOME/spacevim/.space-vim $HOME/.space-vim
ln -sfn $HOME/git/.gitconfig $HOME/.gitconfig

mkdir -p $HOME/.config/nvim

ln -sfn $HOME/nvim/init.vim $HOME/.config/nvim/init.vim
ln -sfn $HOME/dotrc/.zshrc $HOME/.zshrc

source $HOME/.zshrc
