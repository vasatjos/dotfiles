#/bin/bash

# install tpm
if [ -d $HOME/.tmux/plugins/tpm ]; then
    echo "tpm already installed"
else
    echo "Installing tpm"
    git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
fi

# install tmux plugins
echo "Installing tmux plugins"
tmux start-server
tmux new-session -d
$HOME/.tmux/plugins/tpm/scripts/install_plugins.sh
tmux kill-server

# clone nvim submodule
git submodule update --init --recursive
