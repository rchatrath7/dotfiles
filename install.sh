#!/bin/bash

ln -sfn oh-my-zsh/.oh-my-zsh $HOME/.oh-my-zsh
ln -sfn tools/fzf/.fzf $HOME/.fzf
ln -sfn tools/gitz/.gitz $HOME/.gitz
ln -sfn spacevim/.spacevim $HOME/.spacevim
ln -sfn spacevim/.space-vim $HOME/.space-vim
ln -sfn git/.gitconfig $HOME/.gitconfig

mkdir -p $HOME/.config/nvim

ln -sfn nvim/init.vim $HOME/.config/nvim/init.vim
ln -sfn dotrc/.zshrc $HOME/.zshrc

source $HOME/.zshrc
