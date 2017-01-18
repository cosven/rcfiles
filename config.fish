set -x PATH $PATH /Users/ysw/path /Library/Frameworks/Python.framework/Versions/3.5/bin/ /usr/local/bin /usr/bin /bin /usr/sbin /sbin
abbr -a ec emacsclient -t
set -x -g LC_ALL en_US.UTF-8
set -x -g LANG en_US.UTF-8

[ -f /usr/local/share/autojump/autojump.fish ]; and source /usr/local/share/autojump/autojump.fish
