# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# Set the directory we want to store zinit (plugin manager) and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k
#
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Add in zsh plugins
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit light Aloxaf/fzf-tab
zinit light mdumitru/fancy-ctrl-z

autoload -Uz compinit && compinit -u
zinit cdreplay -q

# Customize syntax highlighting
# Set color for correctly spelled commands to white
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main)
ZSH_HIGHLIGHT_STYLES[arg0]="fg=white"

# Key bindings
bindkey -e
bindkey '^[[3~' delete-char # Fix delete not working
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[[1;5D' backward-word  # Ctrl+Left
bindkey '^[[1;5C' forward-word   # Ctrl+Right
bindkey '^[[3;5~' kill-word # delete word with ctrl del


# History
HISTSIZE=10000
HISTFILE=$HOME/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion configuration
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z} r:|[._-]=* l:|=*'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# Custom aliases
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'
alias l="ls -lah"
alias cp="cp -r"
alias v="nvim"
alias t="tmux"
alias open="xdg-open" # open something with the default application
alias activate="source .*venv*/bin/activate"
alias activate..="cd .. && activate && cd -"
alias activate...="cd ... && activate && cd -"
alias activate....="cd .... && activate && cd -"
alias compile="g++ -Wall -Wextra -pedantic -O2 "
alias ff="cd && \fd --type f --hidden --exclude .git | fzf --preview 'bat --color=always {}' | xargs -r nvim" # Fuzzy find file and open in nvim
alias fd='cd && cd $(\fd --type d --hidden --exclude .git | fzf --preview  "tree -LC 2 {}")' # Fuzzy find directory and cd into it
alias ft='cd && cd $(\fd --type d --hidden --exclude .git | fzf --preview "tree -LC 2 {}") && tmux' # Fuzzy find directory and start tmux session in it
alias c="clear -x" # Since Ctrl + L doesn't work in tmux

# Gnome stuff
if [ "$XDG_CURRENT_DESKTOP" = "GNOME" ]; then
    # Alt tab switches windows on all workspaces
    gsettings set org.gnome.shell.window-switcher current-workspace-only false
fi

#Git configuration
git config --global user.name "Josef Vasata"
git config --global user.email vasatjos@fit.cvut.cz
git config --global core.editor nvim
git config --global alias.st status
git config --global alias.ci commit
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ll 'log --oneline --graph --all --decorate'
git config --global alias.repush "!git commit --amend --no-edit && git push --force"

# nvm configuration
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Set the theme for bat
export BAT_THEME="gruvbox-dark"

# Shell integrations
eval "$(fzf --zsh)" # fzf version 0.48 or newer
eval "$(zoxide init zsh --cmd cd --hook pwd)"

export PAGER='less'
export LESS='-R'

export td() {
    __zoxide_z "$1" || return
    tmux
}
