# macOS-only configuration
# Sourced by .zshrc and .bashrc only on macOS

# macOS-specific aliases
alias ls="ls -G"
alias l="ls -lh"
alias osver="sw_vers"

# Show/hide hidden files in Finder
alias show-hidden="defaults write com.apple.finder AppleShowAllFiles YES && killall Finder"
alias hide-hidden="defaults write com.apple.finder AppleShowAllFiles NO && killall Finder"

# OpenSSL (if it exists, set compiler flags for building native extensions)
if [ -n "$HOMEBREW_PREFIX" ] && \
   [ -d "$HOMEBREW_PREFIX/opt/openssl/include" ] && \
   [ -d "$HOMEBREW_PREFIX/opt/openssl/lib" ]; then
  export LDFLAGS="-L$HOMEBREW_PREFIX/opt/openssl/lib${LDFLAGS:+ $LDFLAGS}"
  export CPPFLAGS="-I$HOMEBREW_PREFIX/opt/openssl/include${CPPFLAGS:+ $CPPFLAGS}"
  PATH="$HOMEBREW_PREFIX/opt/openssl/bin:$PATH"
fi

# Function: Show battery percentage and status
battery() {
  pmset -g batt | grep -E '([0-9]+%)' | awk '{print $3}' | tr -d ';'
}

# Function: Empty trash
empty-trash() {
  rm -rfv ~/.Trash/*
  echo "Trash emptied"
}

# Function: Flush DNS cache
flush-dns() {
  sudo dscacheutil -flushcache
  sudo killall -HUP mDNSResponder
  echo "DNS cache flushed"
}
