bold=$(tput bold)
normal=$(tput sgr0)

PROMPT_COMMAND=__prompt_command

__prompt_command(){
    if [ $? == 0 ];
    then
        ps1ArrowFgColor="32"
    else
        ps1ArrowFgColor="31"
    fi
    PS1="\w \[\e[${ps1ArrowFgColor};40m\]${bold}>${normal}\[\e[m\] "
}
