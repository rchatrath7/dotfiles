# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/rchatrath/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/Users/rchatrath/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/Users/rchatrath/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/Users/rchatrath/.fzf/shell/key-bindings.zsh"
