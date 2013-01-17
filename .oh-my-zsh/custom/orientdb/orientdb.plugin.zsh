
echo "Loaded orientdb plugin"

# OrientDB Node.js package with driver installed in temporary directory
create_node_pkg() {

  # Change into temporary directory
  cd `mktemp -d`

  # Install database driver
  npm i orientdb

  # Setup version management
  (git-flow init) || return 1;

}

# Check if we have orientdb installed on this system
hash orientdb-console 2>/dev/null && {

  # Run command line interface tool to manage orientdb
  alias odbcli="sudo -u orient orientdb-console"

  # Create instance of the OrientDB server on this machine, address and port
  alias odbsrv="sudo -u orient /opt/orientdb/bin/server.sh"

  # Create server and navigate to browser-based interface on designated port
  alias odbgui="odbsrv && xdg-open \"http://localhost:2480/studio/\""

  # Create a new node.js orientdb project
  alias odbnjs="create_node_pkg"

} || { echo >&2 "I require orientdb-console but it's not installed. Aborting.";
  exit 1;
}

