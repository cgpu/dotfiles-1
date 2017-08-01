# Homebrew path
export PATH="/usr/local/bin:/usr/local/sbin:~/bin:$PATH"

# add python to path
export PATH="$PATH:/Users/$USER/Library/Python/3.6/bin"

# add go to path
export PATH="$PATH:/Users/$USER/go/bin:/usr/local/go/bin"

# add coreutils to path
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

# GOPATH
export GOROOT="/usr/local/go"
export GOPATH="/Users/$USER/go"

# Set default editor
export EDITOR='emacs -nw'
export VISUAL='emacs -nw'

. ~/.bashrc
