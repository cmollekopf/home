#!/bin/bash
set -e

sudo dnf install -y neovim git tig tmux fish the_silver_searcher docker python
sudo chsh -s fish $USER
