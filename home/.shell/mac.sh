# macOS-only configuration
# Sourced by .zshrc and .bashrc only on macOS

# Only run on macOS
if [ "$(uname)" != "Darwin" ]; then
    return 0
fi

# Homebrew configuration (Apple Silicon)
export HOMEBREW_PREFIX="/opt/homebrew"

# Use GNU tools with their default names (installed via homebrew coreutils)
# This is optional - remove if you prefer BSD tools
if [ -d "$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin" ]; then
    PATH="$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin:$PATH"
fi

# Use GNU sed if available
if [ -d "$HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin" ]; then
    PATH="$HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin:$PATH"
fi

export PATH

# macOS-specific aliases (with color)
alias ls="ls -G"
alias ll="ls -lh"
alias l="ls -lh"
alias la="ls -lah"

# Open files with default application
alias open="open"

# Get macOS version
alias osver="sw_vers"

# Show/hide hidden files in Finder
alias show-hidden="defaults write com.apple.finder AppleShowAllFiles YES && killall Finder"
alias hide-hidden="defaults write com.apple.finder AppleShowAllFiles NO && killall Finder"

# Macports (if installed)
if [ -d "/opt/local" ]; then
    PATH="/opt/local/bin:/opt/local/sbin:$PATH"
    export PATH
fi

# OpenSSL (if it exists, set compiler flags)
if [ -d "$HOMEBREW_PREFIX/opt/openssl/include" ] && [ -d "$HOMEBREW_PREFIX/opt/openssl/lib" ]; then
    export LDFLAGS="-L$HOMEBREW_PREFIX/opt/openssl/lib"
    export CPPFLAGS="-I$HOMEBREW_PREFIX/opt/openssl/include"
    PATH="$HOMEBREW_PREFIX/opt/openssl/bin:$PATH"
fi

# Function: Show battery percentage and status
battery() {
    pmset -g batt | grep -E '([0-9]+%)' | awk '{print $3}' | tr -d ';'
}

# Function: Lock screen
lock() {
    /System/Library/CoreServices/Menu\ Extras/User.menu/Contents/MacOS/User\ Accounts
}

# Function: Empty trash
empty-trash() {
    rm -rfv ~/.Trash/*
    echo "Trash emptied"
}

# Function: Get current WiFi network
wifi-name() {
    /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | awk -F' SSID: ' '{print $2}'
}

# Function: Flush DNS cache
flush-dns() {
    sudo dscacheutil -flushcache
    sudo killall -HUP mDNSResponder
    echo "DNS cache flushed"
}
