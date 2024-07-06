#/bin/bash

# Install tpm
if [ -d ~/.tmux/plugins/tpm ]; then
    echo "tpm already installed"
else
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# clone nvim submodule
git submodule update --init --recursive
