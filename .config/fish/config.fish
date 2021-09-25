# add the go bin path to be able to execute our programs
# set -x PATH $PATH /usr/local/go/bin $GOPATH/bin

#set -g -x PATH /usr/local/bin $PATH

# set the workspace path
# set -gx GOPATH $HOME/go
# set -gx GOROOT /usr/local/opt/go/libexec

# set node
# set -g fish_user_paths "/usr/local/opt/node/bin" $fish_user_paths

# set -x PATH $PATH /usr/local/go/bin $GOPATH/bin

# Set homebrew bin to path
set -gx PATH /opt/homebrew/bin $PATH


# Initialize the starship configuration
starship init fish | source
set -g -x PATH /opt/homebrew/opt/bison/bin $PATH
