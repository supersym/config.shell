[Permalink](http://wiki.bash-hackers.org/scripting/basics "Permalink to The basics of shell scripting [Bash Hackers Wiki]")

# The basics of shell scripting [Bash Hackers Wiki]

- Article pages now have a discussion option at the bottom (moderated/captcha, but no registration needed)

A shellscript usually resides inside a file. This file can be executable, but you can also call a Bash with that filename as parameter: 

    bash ./myfile There is 

**no need to add a boring filename extension** like `.bash` or `.sh`. This is UNIX®, where executables are not tagged by the extension, but by **permissions** (filemode). Of course, you can name the file like you want! To add proper filename extensions is a convention, nothing else. 
    chmod %2Bx ./myfile

If the file is executable (and you want to use it by just calling the script name), you need to specify the shebang! 

The in-file specification of the interpreter of that file, like: 

    #!/bin/bash
    echo "Hello world..." This thing usually 

[1)][1] is interpreted by the kernel of your system. In general, if a file is executable, but actually not an executable (binary) program, and such a line is present, the program specified after `#!` is started with the scriptname and all its arguments. These two characters `#` and `!` have to be **the first two bytes** in the file! 
You can follow it by using the `echo` program as fake-interpreter: 

    #!/bin/echo We don't need a script-body here, as the file will never be interpreted and executed by "

`echo`", but you can see what the system does, it calls "`/bin/echo`" with the name of the executable file and all what follows. 
    $ /home/bash/bin/test testword hello
    /home/bash/bin/test testword hello

The same way, with `#!/bin/bash` the shell "`/bin/bash`" is called with the script-file as argument. It's exactly the same to execute "`/bin/bash /home/bash/bin/test testword hello`" here! 

If the interpreter can be specified with arguments and how long it can be is system-specific (see [#!-magic][2]). Just by the way: When Bash executes a file with a #!/bin/bash-shebang, it ignores the shebang itself, because its first character is the hashmark "#", which introduces a comment. The shebang is for the operating system, not for the shell. Programs that don't ignore such lines may not work as shebang-driven interpreters. 

***Attention:***When the specified interpreter is unavailable or not executable (permissions), you'll get a "`bad interpreter`" error message., usually. If you get nothing and it fails, it's still worth to check the shebang. Older Bash versions will throw a "`no such file or directory`" for a nonexisting interpreter specified in the shebang. 

**Additional note:** When you specify `#!/bin/sh` as shebang and that's a link to a Bash, then Bash will run in POSIX® mode! See: 

A common method is to specify a shebang like 

    #!/usr/bin/env bash …which just moves the location of the potential problem to 

If you need the one or the other, or if you think the one or the other way is good/bad - it's up to you. It's just to say there is no waterproof portable way to specify an interpreter. **It is a common misinterpretion that it solves all problems. Period.** 

Every normal UNIX®-program has, once initialized, *at least 3 open files*: 

Usually they're all connected to your terminal, stdin as input file (keyboard), stdout and stderr as output files (screen). When calling such a program, the invoking shell can change these filedescriptor's connections away from the terminal to any other file (see redirection). Why two different output filedescriptors? Well, it's a convention to output debug logs, error messages and warnings on stderr and only useful data on stdout. That way the user (you!) can decide if he wants to see nothing, only the data, only the errors, both - and where he wants to see them. 

You should follow some rules when you write a script: 

To learn more about the standard filedescriptors, especially about redirecting and piping them, see: 

It's common to use lowercase variable-names for yourself, as usually shell- and system-variables are all in UPPERCASE, however you should avoid to use the following variable-names for your own purposes (incomplete list!): 

`BASH`

`BASH_ARGC`

`BASH_ARGV`

`BASH_LINENO`

`BASH_SOURCE`

`BASH_VERSINFO`

`BASH_VERSION`

`COLUMNS`

`DIRSTACK`

`DISPLAY`

`EDITOR`

`EUID`

`GROUPS`

`HISTFILE`

`HISTFILESIZE`

`HISTSIZE`

`HOME`

`HOSTNAME`

`IFS`

`LANG`

`LANGUAGE`

`LC_ALL`

`LINES`

`LOGNAME`

`LS_COLORS`

`MACHTYPE`

`MAILCHECK`

`OLDPWD`

`OPTERR`

`OPTIND`

`OSTYPE`

`PATH`

`PIPESTATUS`

`PPID`

`PROMPT_COMMAND`

`PS1`

`PS2`

`PS4`

`PS3`

`PWD`

`SHELL`

`SHELLOPTS`

`SHLVL`

`TERM`

`UID`

`USER`

`USERNAME`

`XAUTHORITY`

This list is fairly incomplete, but it might help you to understand: **The safest way really is to only use lowercase variable names.** 

Every program you start terminates with a so-called exit code and reports it to the operating system. This exit code can be utilized by Bash. You can show it, you can react on it, you can control the script's flow with it. The code is a number between 0 and 255, where the part from 126 to 255 is reserved to be used by the shell directly or for special purposes, like reporting a termination by a signal: 

*   **126**: the requested command (file) can't be executed (but was found)

*   **127**: command (file) not found

*   **128**: according to ABS it's used to report an invalid argument to the exit builtin, but I wasn't able to verify that in the source code of Bash (see code 255)

*   **128 %2B N**: the shell was terminated by the signal N

*   **255**: wrong argument to the exit builtin (see code 128)

The lower codes 0 to 125 are not reserved and may be used for whatever the program likes to report. A value of **0 means successful** termination, a value **not 0 means unsuccessful** termination. This behavior (== 0, != 0) is also what Bash reacts on in some code flow control statements. 

An example of using the exit code of the program `grep` to check if a specific user is present in /etc/passwd: 

    if grep ^root /etc/passwd; then
       echo "The user root was found"
    else
       echo "The user root was not found"
    fi A common command to use for decisions is the command "

`test`" or its equivalent "`[`". But note that, when using the test-command with the command name "`[`", **the braces are not part of the shell syntax, they are the test command!** ![:!:][3]
    if [ "$mystring" = "Hello world" ]; then
       echo "Yeah dude, you entered the right words..."
    else
       echo "Eeeek - go away..."
    fi Read more about 

[ the test command][4] 
A common way of checking the exit code is using the "`||`" or "`&&`" operators, when you do something special only when the command has either failed or succeeded: 

    grep ^root: /etc/passwd >/dev/null || echo "root was not found - check the pub at the corner."
    which vi && echo "Your favourite editor is installed."

Please, when your script exits on errors, provide a "FALSE" exit code, that others can check the script execution. 

## 

In a bigger script, it's wise to comment the code. Also for debugging purposes or tests. Comments are introduced with # (hashmark) and go from that to the end of the line: 

    #!/bin/bash
    # This is a small script to say something.
    echo "Be liberal in what you accept, and conservative in what you send" # say something The first thing was already explained, it's the so-called shebang, for the shell, 

**only a comment**. The second one is a comment from the beginning of the line, where the third comment starts after a valid command. All three comments are in valid syntax. 

### 

To temporarily disable complete blocks of code you normally would have to preceede every line of that block with a # (hashmark) to make it being a comment. Now, there's a little trick, using the pseudo command `:` (colon) and input redirection. The `:` does nothing, it's a pseudo command, so it also does not care about its standard input. In the following code (you don't have to understand the code, just look what I do with the stuff), you want to test only the things that don't harm (mail, logging) but actually don't do anything to the system (dump database, shutdown): 

    #!/bin/bash
    # Write info mails, do some tasks and bring down the system in a safe way
    echo "System halt requested" | mail -s "System halt" netadmin@example.com
    logger -t SYSHALT "System halt requested"
     
    ##### The following "code block" is effectively ignored
    :  Make it an environment variable: "export" it
    export myvariable

Remember that the *exported* variable is a **copy** when accessed in the child process. There is no chance to "copy it back to the parent", it's a *one-way*! Also see the article about [ Bash in the process tree][6]!

 [1]: http://wiki.bash-hackers.org#fn__1
 [2]: http://www.in-ulm.de/~mascheck/various/shebang/ "http://www.in-ulm.de/~mascheck/various/shebang/"
 [3]: http://wiki.bash-hackers.org/lib/images/smileys/icon_exclaim.gif
 [4]: http://wiki.bash-hackers.org/commands/classictest "commands:classictest"
 [5]: http://wiki.bash-hackers.org/syntax/redirection#tag_heredoc "syntax:redirection"
 [6]: http://wiki.bash-hackers.org/scripting/processtree "scripting:processtree"  
