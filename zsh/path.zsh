#!/usr/bin/env zsh
# -------------- #
#      PATH      #
# -------------- #

if [[ "$OSTYPE" == "darwin"* ]]; then
    # OSX

    # `brew --prefix coreutils` set staticly for speed
    local brew_prefix_coreutils="/usr/local/opt/coreutils"
    export PATH="$HOME/.dotphiles/bin:$brew_prefix_coreutils/libexec/gnubin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:$PATH"
    export MANPATH=$brew_prefix_coreutils/libexec/gnuman:$MANPATH
else
    # Non-OSX
    export PATH="$HOME/.dotphiles/bin:$PATH"
fi
