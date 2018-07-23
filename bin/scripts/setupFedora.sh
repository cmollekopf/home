#!/bin/bash
set -e

sudo dnf copr enable dperson/neovim
sudo dnf install -y neovim python3-neovim git tig tmux fish the_silver_searcher docker python
sudo chsh -s fish $USER

mkdir ~/src
mkdir ~/bin


#Install fzf
cd ~/bin
git clone github:junegunn/fzf
cd fzf
./install --all
cd ~

ln -s ~/.vim ~/.config/nvim
ln -s ~/.vim/vimrc ~/.config/nvim/init.vim
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

cd ~/bin
git clone https://github.com/phacility/libphutil.git
git clone https://github.com/phacility/arcanist.git
git clone https://github.com/jwilm/alacritty
cd ~
