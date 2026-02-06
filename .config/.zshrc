fastfetch
#fastfetch 
#pfetch
# Import pywal colors
[[ -f ~/.cache/wal/colors.sh ]] && source ~/.cache/wal/colors.sh


eval "$(starship init zsh)"
eval "$(fzf --zsh)"

alias ls="lsd -l"
alias ll="lsd -al"
alias vim="sudo nvim"
alias  ..="cd .."
alias Cat="bat"
alias opne="ImageViewer"
alias cd="z"
alias audio="sh ~/.config/hypr/scripts/audio-switch.sh"

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# Enable fzf keybindings and completion
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# History file
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000


bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward
# Save each command immediately
setopt INC_APPEND_HISTORY
setopt NO_CASE_GLOB

# Created by `pipx` on 2026-01-20 14:22:37
export PATH="$PATH:/home/scorpion/.local/bin"


eval "$(zoxide init zsh)"


# opencode
export PATH=/home/scorpion/.opencode/bin:$PATH
