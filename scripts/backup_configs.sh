#!/bin/bash
set -e

if [ -z "$1" ]; then
    echo "Error: No backup dir path provided."
    echo "Usage: ./dotfiles_backup.sh /path/to/destination"
    exit 1
fi

DEST_PATH="$1"
LOCAL_HOME="/Users/$USER"
DATE=$(date +%Y%m%d)
HOSTNAME=$(hostname -s)
BACKUP_DIR="$DEST_PATH/$HOSTNAME-$DATE"

mkdir -p "$BACKUP_DIR"
mkdir -p "$BACKUP_DIR/.config"
mkdir -p "$BACKUP_DIR/php"
mkdir -p "$BACKUP_DIR/software_lists"
mkdir -p "$BACKUP_DIR/firefox"
mkdir -p "$BACKUP_DIR/.zsh"

# rclone config
rsync -vr "$LOCAL_HOME/.config/rclone" "$BACKUP_DIR/.config"

# git config
rsync -vr "$LOCAL_HOME/.gitconfig" "$BACKUP_DIR"

# ssh keys
rsync -vru "$LOCAL_HOME/.ssh" "$BACKUP_DIR"

# php .ini
php --ini > "$BACKUP_DIR/php/README.md"
rsync -vr "/usr/local/etc/php/8.3/php.ini" "$BACKUP_DIR/php/"
rsync -vr "/usr/local/etc/php/8.3/conf.d/ext-opcache.ini" "$BACKUP_DIR/php/"

# Docker commandline completion
rsync -vr "/Users/andre/.zsh/completion" "$BACKUP_DIR/.zsh/"

# Save lists of currently installed software
ls -1 /Applications > "$BACKUP_DIR/software_lists/applications.list"
echo "" >> "$BACKUP_DIR/software_lists/applications.list"
ls -1 ~/Applications >> "$BACKUP_DIR/software_lists/applications.list"

code --list-extensions > "$BACKUP_DIR/software_lists/vscode.list"

brew leaves > "$BACKUP_DIR/software_lists/brew.list"
echo "" >> "$BACKUP_DIR/software_lists/brew.list"
brew ls --casks >> "$BACKUP_DIR/software_lists/brew.list"

# Sync software lists w. dotfiles repo
rsync -vru "$BACKUP_DIR/software_lists/applications.list" "$HOME/github/dotfiles/software_lists/"
rsync -vru "$BACKUP_DIR/software_lists/vscode.list" "$HOME/github/dotfiles/vscode/extensions.list"
rsync -vru "$BACKUP_DIR/software_lists/brew.list" "$HOME/github/dotfiles/software_lists/"

# Firefox settings
FF_SRC_DIR="/Users/andre/Library/Application Support/Firefox/Profiles"
FF_BACKUP_DIR="$BACKUP_DIR/firefox"

for PROFILE_DIR in "$FF_SRC_DIR"/*/; do
    PROFILE_NAME=$(basename "$PROFILE_DIR")

    DEST_PROFILE_DIR="$FF_BACKUP_DIR/$PROFILE_NAME"
    mkdir -p "$DEST_PROFILE_DIR"

    if [ -f "$PROFILE_DIR/prefs.js" ]; then
        cp "$PROFILE_DIR/prefs.js" "$DEST_PROFILE_DIR"
    fi

    if [ -f "$PROFILE_DIR/user.js" ]; then
        cp "$PROFILE_DIR/user.js" "$DEST_PROFILE_DIR"
    fi
done
