# -------------------------
# bash prompt configuration
#
# Feature:
#
# 1. clean
# 2. show python venv name if in
# 3. show last command exit status
#
# Coding style: https://google.github.io/styleguide/shell.xml
# -------------------------

######################
# Ansi Color Variables
######################
# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White

# Underline
UBlack='\033[4;30m'       # Black
URed='\033[4;31m'         # Red
UGreen='\033[4;32m'       # Green
UYellow='\033[4;33m'      # Yellow
UBlue='\033[4;34m'        # Blue
UPurple='\033[4;35m'      # Purple
UCyan='\033[4;36m'        # Cyan
UWhite='\033[4;37m'       # White

# Background
On_Black='\033[40m'       # Black
On_Red='\033[41m'         # Red
On_Green='\033[42m'       # Green
On_Yellow='\033[43m'      # Yellow
On_Blue='\033[44m'        # Blue
On_Purple='\033[45m'      # Purple
On_Cyan='\033[46m'        # Cyan
On_White='\033[47m'       # White

# High Intensity
IBlack='\033[0;90m'       # Black
IRed='\033[0;91m'         # Red
IGreen='\033[0;92m'       # Green
IYellow='\033[0;93m'      # Yellow
IBlue='\033[0;94m'        # Blue
IPurple='\033[0;95m'      # Purple
ICyan='\033[0;96m'        # Cyan
IWhite='\033[0;97m'       # White

# Bold High Intensity
BIBlack='\033[1;90m'      # Black
BIRed='\033[1;91m'        # Red
BIGreen='\033[1;92m'      # Green
BIYellow='\033[1;93m'     # Yellow
BIBlue='\033[1;94m'       # Blue
BIPurple='\033[1;95m'     # Purple
BICyan='\033[1;96m'       # Cyan
BIWhite='\033[1;97m'      # White

# High Intensity backgrounds
On_IBlack='\033[0;100m'   # Black
On_IRed='\033[0;101m'     # Red
On_IGreen='\033[0;102m'   # Green
On_IYellow='\033[0;103m'  # Yellow
On_IBlue='\033[0;104m'    # Blue
On_IPurple='\033[0;105m'  # Purple
On_ICyan='\033[0;106m'    # Cyan
On_IWhite='\033[0;107m'   # White



PROMPT_COMMAND=__prompt_command


########################
# 获取 Python 虚拟环境名称
########################
_getPyVenvName(){
    if [ -z "${VIRTUAL_ENV}" ]; then
        echo ""
    else
        local envname=`basename $VIRTUAL_ENV`
        if [ $envname = ".venv" ]; then
            local projectDir=`dirname $VIRTUAL_ENV`
            envname=`basename $projectDir`
        fi
        echo "$envname"
    fi
}

_getPyVenvPS1(){
    local envname=`_getPyVenvName`
    if [ -z $envname ]; then
        echo ""
    else
        local curDir=`pwd`
        local curDirName=`basename $curDir`
        if [ $envname = $curDirName ]; then
            # 部分 TERM(比如 Emacs)不支持显示 Emoji
            if [ $TERM = "dumb" ]; then
                echo " "
            else
                echo "🐍 "
            fi
        else
            echo "($envname) "
        fi
    fi
}

#########################
# 进入目录时自动激活虚拟环境
#########################
_autoActivatePyVenv() {
    if [ -e ".venv" ]; then
        if [ -z "$VIRTUAL_ENV" ]; then
            source .venv/bin/activate
            local envname=`_getPyVenvName`
            echo -e "Auto-activating venv ${Green}${envname}${Color_Off}, you ${Red}can't${Color_Off} deactivate it in pwd!"
        fi
    fi
}

################
# 获取当前目录缩写
# ~/coding/feeluown/heihei 会缩写成 ~/c/f/heihei
################
_getShortPwd() {
    echo -n `pwd | sed -e "s!$HOME!~!" | gsed -re "s!([^/])[^/]+/!\1/!g"`
}

#################
# 获取 git status
#################
_getGitPS1() {
    git status > /dev/null 2>&1
    if [ $? == 0 ]; then
        local branch=`git branch | grep \* | cut -d ' ' -f2`
        local status='*'
        local changes=`git status --porcelain | wc -l`
        if [ $changes == 0 ]; then
            status=''
        fi
        echo " \[\e[0;33m\]$branch$status\[\e[0m\]"
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
    _autoActivatePyVenv
    local venvName=`_getPyVenvPS1`
    local shortPwd=`_getShortPwd`
    # 切记：PS1 中使用颜色时，需要用 [] 格式化颜色
    # https://superuser.com/a/980982/349935
    PS1="${venvName}\[\e[0;94m\]${shortPwd}\[\e[0m\]$(_getGitPS1) \[\e[0;${ps1ArrowFgColor}m\]>\[\e[0m\] "
}

export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
export HISTSIZE=100000                   # big big history
export HISTFILESIZE=100000               # big big history
shopt -s histappend                      # append to history, don't overwrite it

# Save and reload the history after each command finishes
# export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# -------------------------
# bash completion
# -------------------------
[ -f /usr/local/etc/bash_completion  ] && . /usr/local/etc/bash_completion

# -------------------------
# aliases
# -------------------------
alias ls='ls -G'
alias ll='ls -l'
alias ec='emacsclient -nc'
alias g='git'
alias ..='cd ..'
alias ...='cd ../..'

if [ $OSTYPE == "linux-gnu" ]; then
    alias gsed=sed
fi

source ~/.bashrc

# -------------------------
# autojump
# -------------------------
[ -f /usr/local/etc/profile.d/autojump.sh  ] && . /usr/local/etc/profile.d/autojump.sh
[ -f /usr/share/autojump/autojump.sh ] && . /usr/share/autojump/autojump.sh
