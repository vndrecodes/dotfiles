#!/bin/bash

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
  echo $msg
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
  if [[ ! -d github || ! -d nextcloud ]]; then; echo "Missing directories (github,nextcloud)"; fi

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
  echo "TODO copy, copy, copy..."
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


link_configs() {
  cd ~
  ln -s github/dotfiles/zsh/.functions .functions
  ln -s github/dotfiles/nano/.nanorc .nanorc
  ln -s github/dotfiles/zsh/.alias .zshenv
  ln -s github/dotfiles/zsh/.zshrc .zshrc
}


add_bash_completions() {
  # ~.zsh/completion
}


config_atom() {
  # using rsync for moving stuff to get a little bit feedback
  cd ~/Downloads
  mkdir atom && cd ~/atom

  curl --location --remote-name https://atom.io/download/mac
  unzip atom-mac.zip
  # mv Atom.app
  rsync -vru --progress ./Atom.app /Applications/.
  open -a Atom
  echo "Open Atom and run: Install Shell Commands"
  confirm "Done? (y for yes, anything else for abort)"
  rsnyc -vru --progress ~/github/dotfiles/atom/config.cson ~/.atom/.
  rsnyc -vru --progress ~/github/dotfiles/atom/keymap.cson ~/.atom/.

  apm install --packages-file ~/github/dotfiles/atom/my-packages.txt
}


upgrade_nano() {
  # TODO syntax files
  cd ~/Downloads
  depends_on "xcode-select"
  curl -O  https://www.nano-editor.org/dist/v6/nano-6.0.tar.gz
  tar xvzf nano-6.0.tar.gz
  cd nano-6.0
  ./configure
  make
  make install

  cd ~
  ALIAS_NANO="alias nano=/usr/local/bin/nano"
  if [ -f ".zshenv" ]; then
    echo $ALIAS_NANO >> .zshenv
  else
    echo ".zshenv not found!"
    echo "Add: $ALIAS_NANO manually."
  fi
}


main() {
  check_essential_dirs
  install_xcode
  copy_ssh_keys
  clone_dotfiles
  # install_node
  # link_configs
  # config_atom
  # upgrade_nano
}

main
