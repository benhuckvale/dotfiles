################################################################################
# conan_version
#
# A Zsh function to switch between Conan versions 1 and 2 on MacOS.
# The function checks the available versions in the Homebrew Cellar and updates
# the symlink for the conan executable accordingly.
#
# SETUP:
#   1. Add this function to your .zshrc file.
#   2. Source your .zshrc file to apply the changes: source ~/.zshrc
#
# USAGE:
#   conan_version [VERSION_NUMBER]
#
# EXAMPLES:
#   $ conan_version
#   Current active Conan version: Conan version 1.64.1
#
#   $ conan_version 1
#   Switched to Conan version 1.64.1
#
#   $ conan_version 2
#   Switched to Conan version 2.4.0
#
################################################################################

function conan_version() {
  local conan1_path=$(ls /opt/homebrew/Cellar/conan@1/)
  local conan2_path=$(ls /opt/homebrew/Cellar/conan/)

  if [[ -z "$1" ]]; then
    local current_version=$(conan --version)
    echo "Current active Conan version: $current_version"
    return 0
  fi

  if [[ "$1" == "1" ]]; then
    pushd /opt/homebrew/bin > /dev/null
    ln -sf "../Cellar/conan@1/$conan1_path/bin/conan"
    echo "Switched to Conan version $conan1_path"
    popd > /dev/null
  elif [[ "$1" == "2" ]]; then
    pushd /opt/homebrew/bin > /dev/null
    ln -sf "../Cellar/conan/$conan2_path/bin/conan"
    echo "Switched to Conan version $conan2_path"
    popd > /dev/null
  else
    echo "Invalid version specified. Please use '1' or '2'."
  fi
}
