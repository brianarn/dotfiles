# macOS-only configuration
# Sourced by .zshrc and .bashrc only on macOS

# Only run on macOS
if [ "$(uname)" != "Darwin" ]; then
    return 0
fi

# Homebrew configuration
if [ -d "/opt/homebrew" ]; then
    # Apple Silicon Macs
    export HOMEBREW_PREFIX="/opt/homebrew"
elif [ -d "/usr/local/Homebrew" ]; then
    # Intel Macs
    export HOMEBREW_PREFIX="/usr/local"
fi

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
alias ls='ls -G'
alias ll='ls -lh'
alias l='ls -lh'
alias la='ls -lah'

# Open files with default application
alias open='open'

# Get macOS version
alias osver='sw_vers'

# Show/hide hidden files in Finder
alias show-hidden='defaults write com.apple.finder AppleShowAllFiles YES && killall Finder'
alias hide-hidden='defaults write com.apple.finder AppleShowAllFiles NO && killall Finder'

# Copy to clipboard
alias pbcopy='pbcopy'
alias pbpaste='pbpaste'

# Macports (if installed)
if [ -d "/opt/local" ]; then
    PATH="/opt/local/bin:/opt/local/sbin:$PATH"
    export PATH
fi

# Ruby, OpenSSL, coreutils on macOS (brew-installed)
# Avoid calling brew --prefix (slow at startup), use direct paths if HOMEBREW_PREFIX is set
if [ -n "${HOMEBREW_PREFIX:-}" ]; then
    # Ruby
    [ -d "$HOMEBREW_PREFIX/opt/ruby/bin" ] && PATH="$HOMEBREW_PREFIX/opt/ruby/bin:$PATH"
    
    # OpenSSL (if it exists, set compiler flags)
    if [ -d "$HOMEBREW_PREFIX/opt/openssl/include" ] && [ -d "$HOMEBREW_PREFIX/opt/openssl/lib" ]; then
        export LDFLAGS="-L$HOMEBREW_PREFIX/opt/openssl/lib"
        export CPPFLAGS="-I$HOMEBREW_PREFIX/opt/openssl/include"
        PATH="$HOMEBREW_PREFIX/opt/openssl/bin:$PATH"
    fi
fi

# Function: Show battery percentage and status
battery() {
    pmset -g batt | grep -E "(\d+%)" | awk '{print $3}' | tr -d ';'
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
    /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | awk -F' SSID: ' '{ print $2 }'
}

# Function: Flush DNS cache
flush-dns() {
    sudo dscacheutil -flushcache
    sudo killall -HUP mDNSResponder
    echo "DNS cache flushed"
}
