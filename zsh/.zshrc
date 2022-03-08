# Prompt
PROMPT='%F{132}%n%f %F{30}at%f %F{53}%m%f %F{30}in%f %F{179}%~%f %# '
export PATH=~/bin:$PATH

source ~/.functions


## Individual autocomplete (files in ~/.zsh/completion)
fpath=(~/.zsh/completion $fpath)

# Advanced autocomplete
autoload -Uz compinit
compinit
setopt autoparamslash

# Trailing slash via <tab> for . and .. directories
zstyle ':completion:*' special-dirs true

# Autocompletion with an arrow-key driven interface
zstyle ':completion:*' menu select

# Case matching
# Small letters match small and capital letters, capital only capital
# zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Case-insensitive match
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Case-insensitive only, if there are no case sensitive matches
# zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'

# For enabling autocompletion of privileged environments in privileged commands
zstyle ':completion::complete:*' gain-privileges 1


# Remembering recent directories
autoload -Uz add-zsh-hook

DIRSTACKFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/dirs"
if [[ -f "$DIRSTACKFILE" ]] && (( ${#dirstack} == 0 )); then
	dirstack=("${(@f)"$(< "$DIRSTACKFILE")"}")
	[[ -d "${dirstack[1]}" ]] && cd -- "${dirstack[1]}"
fi
chpwd_dirstack() {
	print -l -- "$PWD" "${(u)dirstack[@]}" > "$DIRSTACKFILE"
}
add-zsh-hook -Uz chpwd chpwd_dirstack

DIRSTACKSIZE='20'

setopt AUTO_PUSHD PUSHD_SILENT PUSHD_TO_HOME

## Remove duplicate entries
setopt PUSHD_IGNORE_DUPS

## This reverts the +/- operators.
setopt PUSHD_MINUS
