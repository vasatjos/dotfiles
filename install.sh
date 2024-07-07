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

# install p10k
if [ -d $HOME/.oh-my-zsh/custom/themes/powerlevel10k ]; then
    echo "p10k already installed"
else
    echo "Installing p10k"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
fi
