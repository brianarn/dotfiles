#### Base16 Color setup
# Old config, seems gone?
#BASE16_SHELL="$HOME/.dotfiles/external/base16-shell/base16-monokai.dark.sh"
#[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL
BASE16_SHELL="$HOME/.dotfiles/external/base16-shell/"
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

### From oh-my-zsh:
# Path to your oh-my-zsh configuration.
ZSH=$HOME/.dotfiles/oh-my-zsh

# Set name of the theme to load.
# Look in $ZSH/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="brianarn-oldbash"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Personalizations before oh-my-zsh is loaded:
# Speed up the transition to vi mode
export KEYTIMEOUT=1

# Which plugins would you like to load? (plugins can be found in $ZSH/plugins/*)
# Custom plugins may be added to $ZSH/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(
  asdf
  colored-man-pages
  command-not-found
  cp
  docker
  docker-compose
  git
  gitfast
  node
  npm
  ripgrep
  vi-mode
  z
)
if [[ $(uname -s) == "Darwin" ]]; then
  plugins=(
    $plugins
    brew
    httpie
    osx
  )
fi

### Load any local configuration before OMZ is loaded
if [[ -f ~/.zshrc.local.before ]]; then
  source ~/.zshrc.local.before
fi

### Load up OMZ!
source $ZSH/oh-my-zsh.sh

### Customizations:

# I don't like an rprompt
export RPS1=''

# Aliases
alias git='nocorrect git'
alias gch="sha=\$(git log --oneline -1 | awk {'print \$1'}); echo \$sha | tr -d '\n' | pbcopy; echo SHA \$sha copied to clipboard";
alias dm='docker-machine'

# Keybindings to restore some Emacs-mode stuff while in vi-mode
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search

# Path customizations
#PATH=/usr/local/share/npm/bin:$PATH
PATH=/usr/local/bin:/usr/local/sbin:$PATH
PATH="/usr/local/opt/imagemagick@6/bin:$PATH"
PATH=$HOME/.dotfiles/bin:$PATH
#PATH=$HOME/.nave/installed/0.8.22/bin:$PATH
#PATH=/usr/local/ant/bin:$PATH
#PATH=/usr/local/android-sdk-mac_x86/tools:$PATH
#PATH=/usr/local/phonegap-android/bin:$PATH
#PATH=~/.rbenv/shims:$PATH
export PATH

# Mac-specific content
if [[ $(uname -s) == "Darwin" ]]; then
  # Setting up z
  # Commenting out in favor of using z via OMZ
  #source $(brew --prefix)/etc/profile.d/z.sh

  # Homebrew updates in a way that makes it easy to see what's outdated
  alias bup="brew update; printf '=======\n'; brew outdated"
  alias bupvim="brew upgrade --with-override-system-vim macvim"

  # From https://github.com/Wilto/dotfiles/blob/master/bash/bash_aliases
  alias showdotfiles="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
  alias hidedotfiles="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"
  # Hide/show all desktop icons (useful when presenting)
  alias showdeskicons="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"
  alias hidedeskicons="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
  # Add gaps to the Dock
  alias addgaptodock="defaults write com.apple.dock persistent-apps -array-add '{\"tile-type\"=\"spacer-tile\";}'"
fi

# rbenv
#export RBENV_ROOT=/usr/local/var/rbenv
#if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# trying out asdf instead
# Commenting out in lieu of asdf OMZ plugin
#[ -f /usr/local/opt/asdf/asdf.sh ] && source /usr/local/opt/asdf/asdf.sh
#[ -f /usr/local/opt/asdf/completions/asdf.bash ] && source /usr/local/opt/asdf/completions/asdf.bash

# fzf support (worked better than using OMZ for some reason)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Really should put this elsewhere but this works for now
serve() {
    # Get port (if specified)
    local port="${1:-8000}"

    echo "Starting at http://localhost:${port}"

    # Redefining the default content-type to text/plain instead of the default
    # application/octet-stream allows "unknown" files to be viewable in-browser
    # as text instead of being downloaded.
    #
    # Unfortunately, "python -m SimpleHTTPServer" doesn't allow you to redefine
    # the default content-type, but the SimpleHTTPServer module can be executed
    # manually with just a few lines of code.
    #python -c $'import SimpleHTTPServer;\nSimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map[""] = "text/plain";\nSimpleHTTPServer.test();' "$port"

    # PHP has a service now, which seems to work a little better for my needs
    php -S localhost:$port
}

gifify() {
  if [[ -n "$1" ]]; then
    if [[ $2 == '--good' ]]; then
      ffmpeg -i $1 -r 10 -vcodec png out-static-%05d.png
      time convert -verbose +dither -layers Optimize -resize 600x600\> out-static*.png  GIF:- | gifsicle --colors 128 --delay=5 --loop --optimize=3 --multifile - > $1.gif
      rm out-static*.png
    else
      ffmpeg -i $1 -s 600x400 -pix_fmt rgb24 -r 10 -f gif - | gifsicle --optimize=3 --delay=3 > $1.gif
    fi
  else
    echo "proper usage: gifify <input_movie.mov>. You DO need to include extension."
  fi
}

# Load anything else local (intentionally last)
if [[ -f ~/.zshrc.local ]]; then
  source ~/.zshrc.local
fi
