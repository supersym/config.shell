


## Environment variables

The environment space is not directly related to the topic about scope, but
it's worth to mention.

Every UNIX® process has a so-called environment. Beside other stuff
(unimportant for us), variables are saved there, so-called environment
variables. Now when a child process is created (in Bash e.g. by simply
executing another program, say ls to list files), the whole environment
including the environment variables is copied to the new process. Reading that
from the other side means: Only variables that are part of the environment are
available in the child process.

A variable can be tagged to be part of the environment using the export
command:

