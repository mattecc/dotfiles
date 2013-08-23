
# Setting PATH for Python 2.7
# The orginal version is saved in .bash_profile.pysave
PATH="/usr/local/bin:${PATH}"
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
PATH="${PATH}:."
export PATH

alias ls='ls -FG'
alias ll='ls -hlFG'
alias la='ls -aFG'
alias lal='ls -ahlFG'
alias vim='/Applications/MacVim.app/Contents/MacOS/Vim'
alias gvim='/Applications/MacVim.app/Contents/MacOS/Vim -g'
alias ea='vim ~/.bash_profile'
alias sa='source ~/.bash_profile'
alias rm='rm -i'
alias tag='ctags --python-kinds=-i -R'

#        .--------------------- Directories (Hunter)
#        | .------------------- Symlinks (Druid)
#        | | .----------------- Sockets (Paladin)
#        | | | .--------------- Pipes (Paladin)
#        | | | | .------------- Executable (Shaman)
#        | | | | | .----------- Block Special (Warlock)
#        | | | | | | .--------- Character Special (Warlock)
#        | | | | | | | .------- Exec w/ SetUID (Shaman)
#        | | | | | | | | .----- Exec w/ SetGID (Shaman)
#        | | | | | | | | | .--- Dir writable to others w/ sticky (Hunter)
#        | | | | | | | | | | .- Dir writable to others w/o sticky (Hunter)
#        | | | | | | | | | | |
LSCOLORS=CxGxBxBxexFxFxexexCxCx
export LSCOLORS

# Other colors
# Source files [*.c, *.cpp, *.h, *.hpp, *.py, *.sh] -- Death Knight
# Dot files [.*] -- Warrior
# Unused Colors -- Monk, Mage, Rogue

PS1="\[\e[0;36m\]\w \$\[\e[m\] "
export PS1
