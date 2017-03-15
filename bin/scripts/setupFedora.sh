#!/bin/bash
set -e

sudo dnf copr enable dperson/neovim
sudo dnf install -y neovim python3-neovim git tig tmux fish the_silver_searcher docker python
sudo chsh -s fish $USER

#Install fzf
mkdir ~/src
cd ~/src
git clone github:junegunn/fzf
cd fzf
./install --all
cd ~

#Setup omf
curl -L http://get.oh-my.fish | fish

ln -s ~/.vim ~/.config/nvim
ln -s ~/.vim/vimrc ~/.config/nvim/init.vim
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

cd ~/bin
git clone https://github.com/phacility/libphutil.git
git clone https://github.com/phacility/arcanist.git
cd ~
