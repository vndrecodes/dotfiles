#!/bin/bash

set -e

create_dirs_cache() {
  cd ~
  mkdir -p /Users/andre/.cache/zsh/
  touch /Users/andre/.cache/zsh/dirs
}

depends_on() {
  $1 -v > /dev/null
  if [ $? -ne 0 ]; then
    echo "Missing dependency"
    echo "Depends on: $1"
    exit 1
  fi
}

confirm() {
  msg=$1
  echo "$msg"
  read user_in
  if [ "$user_in" != "y" ]; then
    echo "Abort"
    exit 1
  fi
}

check_essential_dirs() {
  cd ~
  if [[ ! -d github || ! -d nextcloud ]]; then
     echo "Missing directories (github,nextcloud)"
     exit 1
  fi
}

create_symlinks() {
  cd ~
  if [[ ! -d github || ! -d nextcloud ]]; then echo "Missing directories (github,nextcloud)"; fi

  ln -s github/dotfiles/zsh/.functions .functions
  ln -s github/dotfiles/nano/.nanorc .nanorc
  ln -s github/dotfiles/zsh/.alias .zshenv
  ln -s github/dotfiles/zsh/.zshrc .zshrc
}

# install c-compiler & git
install_xcode() {
  xcode-select -v > /dev/null 2>&1

  if [ $? -ne 0 ]; then xcode-select --install; fi
}

copy_ssh_keys() {
  if [ ! -d ~/.ssh ]; then
    echo "TODO copy, copy, copy..."
  fi
}

clone_dotfiles() {
  cd ~/github && [ -d ./dotfiles ] || git clone git@github.com:vndrecodes/dotfiles.git
}

# untested, wip!
# TODO cut non lts releases
# TODO pick, download, exec latest lts release
install_node() {
  local releases_url="https://nodejs.org/dist/index.tab"
  local dist_base_url="https://nodejs.org/dist/v16.14.0/node-v16.14.0.pkg"
  local version=""
  local filename="node-$version.pkg"
  local full_file_url="$dist_base_url/$version/$filename"
  node -v > /dev/null 2>&1
  if [ $? -ne 0 ]; then
    echo "Latest node releases:"
    curl --silent $node_releases_url | head -n 30 | awk -F '\t' '{print $1,$2,$3,$10}'
  fi

  # creates /usr/local/bin
}

add_bash_completions() {
  echo "fix .zsh/completion"
  # ~.zsh/completion
}

upgrade_nano() {
# brew install nano
# find nanorc syntax files (eg. /opt/homebrew/Cellar/nano/8.2/share/nano) and update paths in .nanorc
}

install_brew() {
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  brew analytics off
  brew install htop
  brew install baobab
  brew install shellcheck
}

build_locatedb() {
  sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist
}

htop_rc() {
  cd ~/.config/htop || exit
  mv htoprc htoprc.bak
  ln -s ~/github/dotfiles/htop/htoprc htoprc
}

main() {
  # create_dirs_cache
  # check_essential_dirs
  # install_xcode
  # copy_ssh_keys
  # clone_dotfiles
  # install_node
  # upgrade_nano
  # install_brew
  # build_locatedb
  # htop_rc
}

main
