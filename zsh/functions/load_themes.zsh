
# Safety first
set -o nounset
set -o errexit

# Import dependency libraries and initialize
autoload -U promptinit && promptinit

# Now we have this command available
prompt -l

# If we have any arguments...
[[ -z "$@" ]] && {

  # If we have a first argument...
  [[ -n "$1" ]] && {

    # Then search for that as name of a prompt
    prompt -l | grep "\<$1\>" && echo $1

  }

}


