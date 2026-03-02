# Shared shell functions
# Sourced by both .zshrc and .bashrc

# Start a local HTTP server
serve() {
    local port="${1:-8000}"
    echo "Starting HTTP server on port $port..."
    
    # Python 3 http.server (preferred)
    if command -v python3 &>/dev/null; then
        python3 -m http.server "$port" --directory .
    # Python 2 SimpleHTTPServer (fallback)
    elif command -v python &>/dev/null; then
        python -m SimpleHTTPServer "$port"
    # Node.js http-server (fallback)
    elif command -v http-server &>/dev/null; then
        http-server -p "$port"
    else
        echo "Error: No HTTP server available (python3, python, or http-server required)"
        return 1
    fi
}

# Convert video to GIF
gifify() {
    if [ -z "$1" ]; then
        echo "Usage: gifify <input-video> [output-gif] [fps]"
        return 1
    fi
    
    local input="$1"
    local output="${2:-output.gif}"
    local fps="${3:-10}"
    
    if ! command -v ffmpeg &>/dev/null; then
        echo "Error: ffmpeg is required. Install it with: brew install ffmpeg"
        return 1
    fi
    
    echo "Converting $input to GIF with $fps fps..."
    ffmpeg -i "$input" -vf "fps=$fps,scale=512:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" -loop 0 "$output"
    echo "GIF saved to $output"
}

# Display PATH variable in readable format
listpath() {
    echo "$PATH" | tr ':' '\n' | nl
}

# Git checkout with fuzzy search
gch() {
    if ! command -v fzf &>/dev/null; then
        echo "Error: fzf is required for gch"
        return 1
    fi
    
    if ! git rev-parse --git-dir >/dev/null 2>&1; then
        echo "Error: not in a git repository"
        return 1
    fi
    
    local branch
    # Use portable [[:space:]] instead of \s for macOS sed compatibility
    branch=$(git branch --list | sed 's/^[[:space:]]*\*[[:space:]]*//g' | fzf --preview 'git log --oneline -5 {}')
    
    if [ -n "$branch" ]; then
        git checkout "$branch"
    fi
}

# Git push with upstream setup
ggpush() {
    local branch
    branch=$(git symbolic-ref --short HEAD 2>/dev/null) || return 1
    
    if [ -z "$branch" ]; then
        echo "Error: not on a branch"
        return 1
    fi
    
    echo "Pushing branch '$branch' to origin and setting upstream..."
    git push --set-upstream origin "$branch"
}
