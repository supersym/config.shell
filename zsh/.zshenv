

# Global navigation so you can do:
# cp -av /this/directory ..../
alias '..'='cd ..'
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'

# Quickly scaffold out a temporary testing directory for (node) development only fs
alias tt="cd $(mktemp -d)"
alias pp="popd"

alias dpp="cd ~/projects/docpad/plugin"

