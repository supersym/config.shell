

# Oh My Z-Shell
#
#   /¯¯¯¯¯\ |¯¯¯|¯¯¯|  |¯¯¯\/¯¯¯| \¯¯¯|¯¯¯/||¯¯¯¯¯¯| /¯¯¯¯¯/ '|¯¯¯|¯¯¯|
#   |  x  |'|       |° |       '|  \     /  /¯¯  __/ \ __¯¯¯\'|       |°
#   \_____/ |___|___|  |__|\/|__|  |____|'  |______| /______/||___|___|
#
#
#


# Variable pointing to modified location
ZSH=$HOME/.config/shell/.oh-my-zsh

# Updated prefered (favorite) prompt themes
ZSH_THEME="afowler"

# Community and personalized plugins
plugins=(archlinux cp taskwarrior sublime python cpanm git git-flow rvm ruby bundler gem node npm coffee orientdb)

# Source default omz config
source $ZSH/oh-my-zsh.sh

# Get rid of the TITLE error when using tmux
DISABLE_AUTO_TITLE=true

# Overrides from default omz settings
unsetopt correct_all


# Environment variables
#    ___         _                            _
#   | __|_ ___ _(_)_ _ ___ _ _  _ __  ___ _ _| |_
#   | _|| ' \ V / | '_/ _ \ ' \| '  \/ -_) ' \  _|
#   |___|_||_\_/|_|_| \___/_||_|_|_|_\___|_||_\__|
#
# Even for GUI based Pinentries; you should always set GPG_TTY.# }
export GPG_TTY=$(tty) # do not use /dev/tty it *must* be real tty

#LC_ALL is not being set! Defined in /etc/locale.conf as well
#export LANG="en_US.UTF-8"

# Disables sending the termcap initialization and deinitialization strings  to
# the terminal. Used to keep 'man' info from clearing after closing.
export LESS="-X"

# Default editor is really user preference
export EDITOR="vim"

# Have termcap like detect terminal to prevent encoding and capabilities issues
#export TERM="rxvt-unicode-256color"



# Executable program files found here
#   ____   __   ____  _   _  ___
#  (  _ \ /__\ (_  _)( )_( )/ __)
#   )___//(__)\  )(   ) _ ( \__ \
#  (__) (__)(__)(__) (_) (_)(___/

# Customize to your needs...
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/usr/bin/vendor_perl:/usr/bin/core_perl:$JAVA_HOME/bin

##-------------------------------------------------------
# Linux
##

# Local user locally compiled/placed executables
export PATH=${HOME}/bin:${PATH}

##-------------------------------------------------------
# Node Package Manager (NPM)
#
# Install system wide packages using -g switch
# Ensure we have chmod g+w on /usr/local/..
##

# Node package itself
export NODE_PATH="/usr/local/lib/node"

# Node modules install paths
# Do not rely on globals, local modules are more trustworthy and faster.
export NODE_DIR="${HOME}/node_modules:/usr/local/lib"



##
# Python
#
#JAVA

# Arch has python 3.3 as latest version by default but we like 2.7 due to node
#
# There is probably good reason to soft-override these on a user level instead
# of globally...seems like 50/50 now 3.3 vs 2.7-ish snakes
#
#[[ -d "/tmp/bin" ]] || mkdir /tmp/bin
#[[ -L "/tmp/bin/python" ]] || ln -s /usr/bin/python2 /tmp/bin/python

# Ensure our python comes first in the path so we overrule the others...
#export PATH=/tmp/bin:$PATH

# Added closurescript
#export CLOJURESCRIPT_HOME=/data/solo/ace/language/functional/clojurescript
#export PATH=$PATH:$CLOJURESCRIPT_HOME/bin


##-------------------------------------------------------
# Ruby Version Manager (RVM)
##

# Grab the functional rvm command
source ~/.rvm/scripts/rvm

# This should come last somewhere
PATH="${PATH}:${HOME}/.rvm/bin"

export PERL_LOCAL_LIB_ROOT="/home/supersym/perl5";
export PERL_MB_OPT="--install_base /home/supersym/perl5";
export PERL_MM_OPT="INSTALL_BASE=/home/supersym/perl5";
export PERL5LIB="/home/supersym/perl5/lib/perl5/x86_64-linux-thread-multi:/home/supersym/perl5/lib/perl5";
export PATH="/home/supersym/perl5/bin:$PATH";
