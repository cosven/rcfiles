PROMPT_COMMAND=__prompt_command

# The entire table of ANSI color codes.
# https://gist.github.com/chrisopedia/8754917
__prompt_command(){
    if [ $? == 0 ];
    then
        ps1ArrowFgColor="92"
    else
        ps1ArrowFgColor="91"
    fi
    PS1="\[\e[0;94m\]\w\[\e[0m\] \[\e[0;${ps1ArrowFgColor}m\]>\[\e[0m\] "
}
source ~/.bashrc
