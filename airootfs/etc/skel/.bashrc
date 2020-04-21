#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ -f ~/.welcome_screen ]] && . ~/.welcome_screen

_set_my_PS1() {
    local iso_version="$(grep ^VERSION= /etc/os-release | cut -d '=' -f 2)"
    if [ -n "$iso_version" ] ; then
        local prefix="eos-"
        local iso_info="$prefix$iso_version"
        PS1="[\u@$iso_info \W]\$ "
    else
        PS1='[\u@\h \W]\$ '
    fi
}
_set_my_PS1
unset -f _set_my_PS1

alias ls='ls --color=auto'
alias ll='ls -lav --ignore=..'   # show long listing of all except ".."
alias l='ls -lav --ignore=.?*'   # show long listing but no hidden dotfiles except "."

[[ "$(whoami)" = "root" ]] && return

[[ -z "$FUNCNEST" ]] && export FUNCNEST=100          # limits recursive functions, see 'man bash'

## Use the up and down arrow keys for finding a command in history
## (you can write some initial letters of the command first).
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

################################################################################
## Some generally useful functions.
## Consider uncommenting aliases below to start using these functions.


_GeneralCmdCheck() {
    # A helper for functions UpdateArchPackages and UpdateAURPackages.

    echo "$@" >&2
    "$@" || {
        echo "Error: '$*' failed." >&2
        exit 1
    }
}

_CheckInternetConnection() {
    curl --silent --connect-timeout 8 https://8.8.8.8 >/dev/null
    local result=$?
    test $result -eq 0 || echo "No internet connection!" >&2
    return $result
}

UpdateArchPackages() {
    # Updates Arch packages.

    _CheckInternetConnection || return 1

    local updates="$(checkupdates)"
    if [ -n "$updates" ] ; then
        echo "Updates from upstream:" >&2
        echo "$updates" | sed 's|^|    |' >&2
        _GeneralCmdCheck sudo pacman -Syu "$@"
        return 0
    else
        echo "No upstream updates." >&2
        return 1
    fi
}

UpdateAURPackages() {
    # Updates AUR packages.

    _CheckInternetConnection || return 1

    local updates
    if [ -x /usr/bin/yay ] ; then
        updates="$(yay -Qua)"
        if [ -n "$updates" ] ; then
            echo "Updates from AUR:" >&2
            echo "$updates" | sed 's|^|    |' >&2
            _GeneralCmdCheck yay -Syua "$@"
        else
            echo "No AUR updates." >&2
        fi
    else
        echo "Warning: /usr/bin/yay does not exist." >&2
    fi
}

UpdateAllPackages() {
    # Updates all packages in the system.
    # Upstream (i.e. Arch) packages are updated first.
    # If there are Arch updates, you should run
    # this function a second time to update
    # the AUR packages too.

    UpdateArchPackages || UpdateAURPackages
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
    echo "Tip: install one of packages" >&2
    for prog in $progs ; do
        echo "    $(pacman -Qqo "$prog")" >&2
    done
}

#------------------------------------------------------------

## Aliases for the functions above.
## Uncomment an alias if you want to use it.
##

# alias ef='_open_files_for_editing'     # 'ef' opens given file(s) for editing
################################################################################
