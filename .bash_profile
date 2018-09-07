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

# -------
# aliases
# -------

alias ls='ls -G'

source ~/.bashrc
