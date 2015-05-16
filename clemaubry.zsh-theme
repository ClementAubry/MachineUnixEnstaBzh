########################################################################
#################### Yannick LM's Zsh prompt config ####################
################## Modified by clemaubry - Fueb, 2015 ##################
########################################################################
bright="\033[m1;"
    dull="\033[m0;"
    for color in BLACK RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
	#eval PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
	eval PR_$color='%{$fg_no_bold[${(L)color}]%}'
	eval PR_BG_$color='%{$bg[${(L)color}]%}'
       eval PR_LIGHT_$color='%{$fg_bold[${(L)color}]%}'
	(( count = $count + 1 ))
    done
    PR_NO_COLOUR="%{$terminfo[sgr0]%}"

# Finally, the prompt.
PROMPT='$PR_BG_BLACK\
$PR_LIGHT_MAGENTA%(!.%SROOT%s.$PR_LIGHT_WHITE%n$PR_LIGHT_YELLOW)@$PR_LIGHT_GREEN%m$PR_LIGHT_MAGENTA\
 [%(?.$PR_LIGHT_WHITE$?.$PR_LIGHT_RED% err $?)$PR_LIGHT_MAGENTA]\
 [$PR_LIGHT_BLUE%~$(git_prompt_info)$PR_LIGHT_MAGENTA]$PR_NO_COLOUR\

z$PR_LIGHT_GREEN%(!.#.$)\
$PR_NO_COLOUR '

RPROMPT="[$PR_BG_BLACK$PR_LIGHT_CYAN%D $PR_LIGHT_GREEN%T$PR_NO_COLOUR]"


# git theming
ZSH_THEME_GIT_PROMPT_PREFIX="$fg_bold[green]("
ZSH_THEME_GIT_PROMPT_SUFFIX=")"
ZSH_THEME_GIT_PROMPT_CLEAN="✔"
ZSH_THEME_GIT_PROMPT_DIRTY="✗"

