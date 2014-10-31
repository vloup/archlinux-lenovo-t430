#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# aliases
alias intellijidea-ce='/usr/share/intellijidea-ce/bin/idea.sh'
alias rcon='java -jar ~/applications/JaRCON/JaRCON.jar'

# completion
complete -cf sudo

# set PATH for android sdk
PATH="$PATH:/home/vincent/applications/adt-bundle-linux-x86_64-20140702/eclipse/"
PATH="$PATH:/home/vincent/applications/adt-bundle-linux-x86_64-20140702/sdk/platform-tools/"
PATH="$PATH:/home/vincent/applications/adt-bundle-linux-x86_64-20140702/sdk/tools/"

# design
# NOTICE: it is already defined into /etc/bash.bashrc
#PS1='[\u@\h \W]\$ '
