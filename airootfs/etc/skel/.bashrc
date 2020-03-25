#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ -f ~/.welcome_screen ]] && . ~/.welcome_screen

alias ls='ls --color=auto'
alias ll='ls -lav --ignore=..'   # show long listing of all except ".."
alias l='ls -lav --ignore=.?*'   # show long listing but no hidden dotfiles except "."

PS1='[\u@\h \W]\$ '

## Use up and down arrow keys for finding a command in history
## (after writing some letters first).
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

################################################################################
## Some generally useful functions.
## Consider uncommenting aliases below to start using these functions.


_GeneralCmdCheck() {
    # A helper for function _SystemUpdate.

    echo "$@" >&2
    "$@" || {
        echo "Error: '$*' failed." >&2
        exit 1
    }
}

_SystemUpdate() {
    # Updates all packages in the system.
    # Updates official Arch packages first, then AUR packages.

    local updates="$(checkupdates)"

    if [ -n "$updates" ] ; then
        echo "Updates from upstream:" >&2
        echo "$updates" | sed 's|^|    |' >&2
        _GeneralCmdCheck sudo pacman -Syu
    else
        echo "No upstream updates." >&2
    fi

    if [ -x /usr/bin/yay ] ; then
        updates="$(yay -Qua)"
        if [ -n "$updates" ] ; then
            echo "Updates from AUR:" >&2
            echo "$updates" | sed 's|^|    |' >&2
            _GeneralCmdCheck yay -Syua
        else
            echo "No AUR updates." >&2
        fi
    else
        echo "Warning: /usr/bin/yay does not exist." >&2
    fi
}


_open_files_for_editing() {
    # Open any given document file(s) for editing (or just viewing).
    # Note1: Do not use for executable files!
    # Note2: uses mime bindings, so you may need to use
    #        e.g. a file manager to make some file bindings.

    local progs="xdg-open exo-open"     # One of these programs is used.
    local prog
    for prog in $progs ; do
        if [ -x /usr/bin/$xx ] ; then
            $prog "$@" >& /dev/null &
            return
        fi
    done
    echo "Sorry, none of programs [$progs] is found." >&2
}

#------------------------------------------------------------

## Aliases for the functions above.
## Uncomment an alias if you want to use it.
##

# alias ef='_open_files_for_editing'     # 'ef' opens given file(s) for editing

alias SystemUpdate='_SystemUpdate'             # Updates all Arch and AUR packages in your system.
################################################################################
