# -------------------------
# bash prompt configuration
#
# Feature:
#
# 1. clean
# 2. show python venv name if in
# 3. show last command exit status
#
# -------------------------

PROMPT_COMMAND=__prompt_command

_getPythonVenvName(){
    if [ -z "${VIRTUAL_ENV}" ]; then
        echo ""
    else
        local dname=`dirname $VIRTUAL_ENV`
        echo "(`basename $dname`) "
    fi
}

# The entire table of ANSI color codes.
# https://gist.github.com/chrisopedia/8754917
ps1ArrowFgColor="92"
__prompt_command(){
    if [ $? == 0 ];
    then
        ps1ArrowFgColor="92"
    else
        ps1ArrowFgColor="91"
    fi
    venvName=`_getPythonVenvName`
    PS1="${venvName}\[\e[0;94m\]\w\[\e[0m\] \[\e[0;${ps1ArrowFgColor}m\]>\[\e[0m\] "
}

export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
export HISTSIZE=100000                   # big big history
export HISTFILESIZE=100000               # big big history
shopt -s histappend                      # append to history, don't overwrite it

# Save and reload the history after each command finishes
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# -------------------------
# bash completion
# -------------------------
[ -f /usr/local/etc/bash_completion  ] && . /usr/local/etc/bash_completion

# -------------------------
# aliases
# -------------------------
alias ls='ls -G'

source ~/.bashrc

# -------------------------
# autojump
# -------------------------
[ -f /usr/local/etc/profile.d/autojump.sh  ] && . /usr/local/etc/profile.d/autojump.sh
