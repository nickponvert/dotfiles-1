export EMACS_PLUGIN_LAUNCHER="/home/nick/.dotfiles/emacs/emacsclient.sh"

# set EDITOR if not already defined.
export EDITOR="${EDITOR:-${EMACS_PLUGIN_LAUNCHER}}"

alias emacs="$EMACS_PLUGIN_LAUNCHER --no-wait"
alias e=emacs

alias emacsclient="/usr/local/bin/emacsclient"

# same as M-x eval but from outside Emacs.
alias eeval="$EMACS_PLUGIN_LAUNCHER --eval"
# create a new X frame
alias eframe='/usr/local/bin/emacsclient --alternate-editor "" --create-frame'
alias ef=eframe

# We need to start emacs initially - bug in spacemacs that may soon be fixed
alias estart='/usr/local/bin/emacs'
alias es=estart

# to code all night long
alias emasc=emacs
alias emcas=emacs

# Write to standard output the path to the file
# opened in the current buffer.
function efile {
    local cmd="(buffer-file-name (window-buffer))"
    "$EMACS_PLUGIN_LAUNCHER" --eval "$cmd" | tr -d \"
}

# Write to standard output the directory of the file
# opened in the the current buffer
function ecd {
    local cmd="(let ((buf-name (buffer-file-name (window-buffer))))
                    (if buf-name (file-name-directory buf-name)))"

    local dir="$($EMACS_PLUGIN_LAUNCHER --eval $cmd | tr -d \")"
    if [ -n "$dir" ] ;then
        echo "$dir"
    else
        echo "can not deduce current buffer filename." >/dev/stderr
        return 1
    fi
}
