function fish_prompt
    set_color $fish_color_cwd
    echo -n (prompt_pwd)
    set_color normal
    echo -n ' > '
end

export SERVICE_DISCOVERY_URI=consul://discovery.dev.zhihu.com
if test -e /etc/debian_version
    true
    set -x PATH $PATH ~/.local/bin
else
    set -x PATH $PATH ~/path /Library/Frameworks/Python.framework/Versions/3.5/bin/ /usr/local/bin /usr/bin /bin /usr/sbin /sbin
    eval (thefuck --alias | tr '\n' ';')
    abbr -a vim pyvim
end
abbr -a ec emacsclient -t
set -x -g LC_ALL en_US.UTF-8
set -x -g LANG en_US.UTF-8
abbr -a g git
set -x -g EDITOR vim

[ -f /usr/local/share/autojump/autojump.fish ]; and source /usr/local/share/autojump/autojump.fish
[ -d /usr/local/Cellar/python/2.7.13/bin ]; and set -x PATH $PATH /usr/local/Cellar/python/2.7.13/bin
