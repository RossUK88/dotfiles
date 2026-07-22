# Powerlevel10k disabled in favour of catppuccin theme (see ZSH_THEME below).
# To restore p10k: uncomment this block + the two blocks near the bottom, and set ZSH_THEME="agnoster".
# # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# # Initialization code that may require console input (password prompts, [y/n]
# # confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
ZSH_CUSTOM=$HOME/.dotfiles/misc/oh-my-zsh-custom
ZSH_THEME="catppuccin"
CATPPUCCIN_FLAVOR="latte"
CATPPUCCIN_SHOW_TIME=true
CATPPUCCIN_SHOW_HOSTNAME="ssh"
DEFAULT_USER=`whoami`
export UPDATE_ZSH_DAYS=6

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

plugins=(git)

source $ZSH/oh-my-zsh.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#set numeric keys
# 0 . Enter
bindkey -s "^[Op" "0"
bindkey -s "^[Ol" "."
bindkey -s "^[OM" "^M"
# 1 2 3
bindkey -s "^[Oq" "1"
bindkey -s "^[Or" "2"
bindkey -s "^[Os" "3"
# 4 5 6
bindkey -s "^[Ot" "4"
bindkey -s "^[Ou" "5"
bindkey -s "^[Ov" "6"
# 7 8 9
bindkey -s "^[Ow" "7"
bindkey -s "^[Ox" "8"
bindkey -s "^[Oy" "9"
# + -  * /
bindkey -s "^[Ok" "+"
bindkey -s "^[Om" "-"
bindkey -s "^[Oj" "*"
bindkey -s "^[Oo" "/"

# Load the shell dotfiles, and then some:
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.dotfiles/zsh/.{exports,aliases,functions}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file"
done

unset file

typeset -U path cdpath fpath
path=(
    $HOME/.local/bin
    $HOME/.composer/vendor/bin
    ./vendor/bin
    ./node_modules/.bin
    $path
)

# Setup xdebug
export XDEBUG_CONFIG="idekey=VSCODE"


export PATH="/opt/homebrew/opt/mysql@8.0/bin:$PATH"
export PATH="/opt/homebrew/opt/icu4c@74/bin:$PATH"
export PATH="/opt/homebrew/opt/icu4c@74/sbin:$PATH"
# Powerlevel10k disabled in favour of catppuccin theme.
# source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
#
# # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export ENABLE_EXPERIMENTAL_MCP_CLI=1

# SSH: start an agent if none is running, then load keys from the macOS keychain
if [ -z "$SSH_AUTH_SOCK" ]; then
    eval "$(ssh-agent -s)" > /dev/null
fi
ssh-add --apple-load-keychain 2>/dev/null

# peon-ping quick controls
alias peon="bash ~/.claude/hooks/peon-ping/peon.sh"
[ -f ~/.claude/hooks/peon-ping/completions.bash ] && source ~/.claude/hooks/peon-ping/completions.bash
export CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1
