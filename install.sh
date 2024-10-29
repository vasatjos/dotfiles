#/usr/bin/env bash

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

echo
echo "Tooling installed! Assuming the dotfiles directory is in your $HOME directory, run 'stow .' to symlink the dotfiles."
echo
echo "Make sure to also have zsh, zoxide, fzf and fd-find installed from your package manager."
