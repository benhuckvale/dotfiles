################################################################################
# setpath
#
# This function enhances PATH management in zsh by allowing users to add
# directories more conveniently to the PATH environment variable. It provides
# functionality to add directories either temporarily or permanently. If the
# --save flag is used, the change will be written to a ~/.setpath.zsh file,
# ensuring that the PATH adjustments persist across shell sessions by sourcing
# this file from the ~/.zshrc.
#
# USAGE:
#   setpath [--save] [DIRECTORY]
#   setpath --detail
#
# ARGUMENTS:

#   DIRECTORY    Specify the directory to add to the PATH. The function checks
#                if the directory exists and handles it appropriately. The order
#                of DIRECTORY and the --save flag does not matter.
#
#   --save       If provided, the addition of the directory to PATH is made
#                permanent by appending the change to ~/.setpath.zsh and ensuring
#                it is sourced in ~/.zshrc. This flag can precede or follow the
#                directory argument.
#
#   (no arguments)
#                Displays the current PATH environment variable in a formatted
#                and organized manner. Each entry in the PATH is listed on a new
#                line. This mode is useful for quickly understanding and verifying
#                current PATH settings, and it helps identify potential issues with
#                directory accessibility.
#
#   --detail     When used without a DIRECTORY argument, this option expresses
#                a bit more than when (no arguments) are provided.  A detailed
#                and formatted view of the current PATH, listing each directory
#                on a new line and detailing all, or some, of the executable
#                files in each directory.
#
# EXAMPLES:
#   setpath /usr/local/bin          # Adds /usr/local/bin to the PATH, just for
#                                   # this shell session
#   setpath /usr/local/bin --save   # Adds /usr/local/bin to the PATH and saves
#                                   # the change for future sessions.
#   setpath --detail                # Displays detailed current PATH information.
#   setpath                         # Formats PATH with newline separator instead of :
#
################################################################################

setpath() {
  local dir=""
  local save=false

  for arg in "$@"; do
    if [[ "$arg" == "--save" ]]; then
      save=true
    elif [[ -d "$arg" ]]; then
      dir="$arg"
    fi
  done

  if [[ -z "$dir" && "$#" -eq 0 ]]; then
    # If no arguments are provided, print the current PATH beautifully
    echo $PATH | tr ':' '\n' | awk '{print $1}'
    return
  elif [[ -z "$dir" && "$1" == "--detail" ]]; then
    # Provide detailed listing of files in each PATH directory
    local dirs=("${(@s/:/)PATH}") # split PATH using zsh's parameter expansion flags
    for dir in "${dirs[@]}"; do
      # Bold the directory name using ANSI escape codes
      echo $'\e[1m'"$dir:"$'\e[0m'
      if [[ -d "$dir" ]]; then
        local files=$(ls -p "$dir" 2>/dev/null | grep -v / | head -n 50 | tr '\n' ' ')
        echo "    $files"
        [[ $(ls -p "$dir" 2>/dev/null | grep -v / | wc -l) -gt 50 ]] && echo "    ..."
      else
        echo "    Directory does not exist or is not accessible"
      fi
    done
    return
  fi

  if [[ -n "$dir" ]]; then
    # Add or update PATH
    # Remove the directory if it's already in the PATH
    PATH=${PATH//:$dir/}
    PATH=${PATH//$dir:/}
    PATH=${PATH//$dir/}
    # Prepend the directory to the PATH
    export PATH="$dir:$PATH"
  fi

  if $save; then
    # Create .setpath.zsh if it doesn't exist
    if ! [[ -f ~/.setpath.zsh ]]; then
      touch ~/.setpath.zsh
    fi

    # Remove any existing entry that matches what we are adding to avoid duplicates
    sed -i '' "\|setpath $dir|d" ~/.setpath.zsh

    # Add new entry
    echo "setpath $dir" >> ~/.setpath.zsh

    # Ensure .zshrc sources .setpath.zsh
    if ! grep -q '.setpath.zsh' ~/.zshrc; then
      echo "[[ -f ~/.setpath.zsh ]] && source ~/.setpath.zsh" >> ~/.zshrc
    fi
  fi
}
