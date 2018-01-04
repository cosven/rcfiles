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
    set -x PATH $PATH ~/.local/bin ~/path /usr/local/bin /usr/bin /bin /usr/sbin /sbin

    if test -e  ~/.cargo/bin
        set -x PATH $PATH ~/.cargo/bin
    end
    if test -e ~/.mbin
        set -x PATH $PATH ~/.mbin
    end
    # this will cause emacs(exec-path-from-shell) fail
    # eval (thefuck --alias | tr '\n' ';')
end

abbr -a ec emacsclient -t
set -x -g LC_ALL en_US.UTF-8
set -x -g LANG en_US.UTF-8
abbr -a g git
abbr -a jp 'python -m json.tool | pygmentize -l javascript'
abbr -a edit medit
set -x -g EDITOR 'emacsclient -t'
set -x -g ALTERNATE_EDITOR 'nvim'
set -x -g HOMEBREW_NO_AUTO_UPDATE 1

[ -f /usr/local/share/autojump/autojump.fish ]; and source /usr/local/share/autojump/autojump.fish
[ -d /usr/local/Cellar/python/2.7.13/bin ]; and set -x PATH $PATH /usr/local/Cellar/python/2.7.13/bin
if test -d /Library/Frameworks/Python.framework/Versions/3.6/bin
    set -x PATH /Library/Frameworks/Python.framework/Versions/3.6/bin $PATH
    set -x PATH ~/Library/Python/3.6/bin/ $PATH
else
    set -x PATH /Library/Frameworks/Python.framework/Versions/3.5/bin $PATH
end


[ -f /Users/cosven/zhihu/wen/zae-cli/auto_completion/zae_fish ]; and source /Users/cosven/zhihu/wen/zae-cli/auto_completion/zae_fish
