# Widget function to find and insert npm/pnpm commands
function _npm_runzf() {
    # Use our Rust tool to get the commands
    # Output fields: command, workspace, package manager (tab-separated)
    local selected=$(npm-runzf | fzf \
        --height=40% \
        --reverse \
        --ansi \
        --delimiter='\t' \
        --with-nth=1,2 \
        --preview 'echo "Command: {1}\nWorkspace: {2}"' \
        --preview-window=up:2:wrap \
        --bind 'ctrl-/:toggle-preview')

    if [[ -n "$selected" ]]; then
        local cmd=$(echo "$selected" | cut -f1)
        local ws=$(echo "$selected" | cut -f2)
        local pm=$(echo "$selected" | cut -f3)

        # Clear the current line
        LBUFFER=""
        RBUFFER=""

        if [[ "$pm" == "pnpm" ]]; then
            if [[ -n "$ws" ]]; then
                LBUFFER="pnpm -C $ws run $cmd"
            else
                LBUFFER="pnpm run $cmd"
            fi
        else
            if [[ -n "$ws" ]]; then
                LBUFFER="npm run -w $ws $cmd"
            else
                LBUFFER="npm run $cmd"
            fi
        fi
    fi

    zle reset-prompt
}

# Create the widget
zle -N _npm_runzf

bindkey 'ƒ' _npm_runzf
