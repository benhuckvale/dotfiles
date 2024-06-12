# Merely using $0 for this does not work:
THIS_PATH=${(%):-%N}

DOTFILES_DIR="$(dirname "$(readlink -f "$THIS_PATH")")"

echo "Setting up from $DOTFILES_DIR"
DIR=$DOTFILES_DIR/zsh/interactive
if [ -d "$DIR" ]; then
    source $DIR/colours.zsh
    source $DIR/prompt.zsh
    source $DIR/aliases.zsh
fi
