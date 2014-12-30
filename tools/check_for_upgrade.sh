#! /bin/sh

function current_epoch() {
    echo $(($(date +%s) / 60 / 60 / 24))
}

function update_dotphiles_update() {
    echo "LAST_EPOCH=$(current_epoch)" > $HOME/.dotphiles/dotphiles-update
}

function upgrade_dotphiles() {
    /usr/bin/python $HOME/.dotphiles/tools/dotphiles.py update
    # Update the dotphiles file
    update_dotphiles_update
}

epoch_target=$UPDATE_DOTPHILES_DAYS
if [[ -z "$epoch_target" ]]; then
    # Default to 13 days
    epoch_target=13
fi

if [ -f $HOME/.dotphiles/dotphiles-update ]; then
    source $HOME/.dotphiles/dotphiles-update

    if [[ -z "$LAST_EPOCH" ]]; then
        update_dotphiles_update && return 0;
    fi

    epoch_diff=$(($(current_epoch) - $LAST_EPOCH))
    if [ $epoch_diff -gt $epoch_target ]; then
        echo "[Dotphiles] Would you like to check for updates?"
        echo "Type Y to update dotphiles: \c"
        read line
        if [ "$line" = Y ] || [ "$line" = y ]; then
            upgrade_dotphiles
        else
            update_dotphiles_update
        fi
    fi
else
    # Create the dotfiles file
    update_dotphiles_update
fi

unset -f current_epoch
unset -f update_dotphiles_update
unset -f upgrade_dotphiles
unset epoch_target
