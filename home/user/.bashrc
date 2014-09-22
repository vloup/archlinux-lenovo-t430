#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# aliases
alias intellijidea-ce='/usr/share/intellijidea-ce/bin/idea.sh'
alias rcon='java -jar ~/applications/JaRCON/JaRCON.jar'

# android SDK
alias adt-eclipse='~/applications/adt-bundle-linux-x86_64-20140702/eclipse/eclipse'
alias adt-android='~/applications/adt-bundle-linux-x86_64-20140702/sdk/tools/android'
alias adt-emulator='~/applications/adt-bundle-linux-x86_64-20140702/sdk/tools/emulator'
alias adt-adb='~/applications/adt-bundle-linux-x86_64-20140702/sdk/platform-tools/adb'

# completion
complete -cf sudo

# design
# NOTICE: it is already defined into /etc/bash.bashrc
#PS1='[\u@\h \W]\$ '
