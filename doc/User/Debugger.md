[Back to Contents](../index.html)

------------------------------------------------------------------------

# [The Debugger]{#PAGE_HEADER}

Summary:

- [Basics](#DEFINITION)
- [Usage](#USAGE)
  - [Starting fglrun in debug mode](#STARTING)
  - [Stack Frames](#STACKFRAME)
  - [Using ddd as graphical interface](#USINGDDD)
  - [Invoking the debugger at runtime](#SIGTRAP)
  - [Setting a breakpoint programmatically](#BREAKPOINT)
- [Commands](#COMMANDS)

*See also:* [Programs](Programs.html), [Tools](Tools.html).

------------------------------------------------------------------------

### [Basics]{#DEFINITION}

The debugger is a tool built in the runtime system that allows you to
stop a program before it terminates, or before it encounters a problem,
so that you can locate logical and runtime errors.

#### Syntax:

`fglrun -d `*`program`*[`[`]{.underline}`.42r`[`]`]{.underline}

#### Notes:

1.  *program* is the name of the BDL program.
2.  The command-line arguments for *program* (if any) have to be passed
    to the \"run\" command later on.

------------------------------------------------------------------------

### [Usage]{#USAGE}

------------------------------------------------------------------------

#### [Starting fglrun in debug mode]{#STARTING}

In order to use the debugger, you must start the virtual machine with
the **-d** option:

`fglrun -d myprog`

The debugger can be used alone in the command line mode or with a
graphical shell compatible with gdb such as **ddd**:

`ddd --debugger "fglrun -d myprog"`

The debugger supports a subset of the standard GNU C/C++ debugger called
**gdb**.

In command line mode, the debugger shows the following prompt

`(fgldb)`

A command is a single line of input. It starts with a command name,
which may be followed by arguments whose meaning depends on the command
name. For example, the command `step` accepts as an argument the number
of times to step:

`(fgldb) step 5`

You can use command abbreviations. For example, the \'step\' command
abbreviation is \'s\':

`(fgldb) s 5`

Possible command abbreviations are shown in the command\'s syntax.

A blank line as input to the debugger (pressing just the RETURN or ENTER
keys) usually causes the previous command to repeat. However, commands
whose unintentional repetition might cause problems will not repeat in
this way.

------------------------------------------------------------------------

#### [[Stack Frames]{.underline}]{#STACKFRAME}

Each time your program performs a function call, information about the
call is saved in a block of data called a *stack frame*. Each frame
contains the data associated with one call to one function.

The stack frames are allocated in a region of memory called the *call
stack*. When your program is started, the stack has only one frame, that
of the function **main**. This is the initial frame, also known as the
*outermost frame*. As the debugger executes your program, a new frame is
made each time a function is called. When the function returns, the
frame for that function call is eliminated.

The debugger assigns numbers to all existing stack frames, starting with
zero for the innermost frame, one for the frame that called it, and so
on upward. These numbers do not really exist in your program; they are
assigned by the debugger to allow you to designate stack frames in
commands.

Each time your program stops, the debugger automatically selects the
currently executing frame and describes it briefly. You can use the
[frame](#CMD_FRAME) command to select a different frame from the current
call stack.

------------------------------------------------------------------------

#### [Using ddd as graphical interface]{#USINGDDD}

To use **ddd** with the debugger:

1.  Create a script \"**fglddd**\" containing the following command;
    make the script executable.

<!-- -->

       exec ddd --debugger "fglrun -d" "$@"

2.  Start **fglddd** as a replacement for **fglrun** when you want to
    debug a BDL program.

------------------------------------------------------------------------

#### [Invoking the debugger in a running instance of fglrun]{#SIGTRAP}

Even if fglrun has not been started with the -d option, it is possible
to switch the running program to debug mode: On Unix platforms, you must
send a **SIGTRAP** signal to the process. On Windows, you must use the
**CTRL-BREAK** key in the console window which has started the program.

Example (Unix):

`shell 1> fglrun func`

From another session, send the SIGTRAP signal to this process.

`shell 2> kill -TRAP pid_of_fglrun`

Then the instance running the program will receive this signal and enter
in debugging mode. The (fgldb) prompt is displayed and waits for
instructions.

`shell 1> fglrun func`\
`func1() at func.4gl:15`\
`15 for g_cpt=1 to 1000000`\
`(fgldb) `

In production sites, you can avoid the runtime system to trap the
debugger signal by setting the following [FGLPROFILE](FglProfile.html)
entry:

`fglrun.ignoreDebuggerEvent = true`

------------------------------------------------------------------------

#### [Setting a breakpoint programmatically]{#BREAKPOINT}

You can set a breakpoint in the program source code with the
[BREAKPOINT](Programs.html#BREAKPOINT) instruction. If the program flow
encounters this instruction, the program stops as if the break point was
set by the [break command](#CMD_BREAK):

``` linenumber
01 MAIN
02   DEFINE i INTEGER
03   LET i=123
04   BREAKPOINT
05   DISPLAY i
06 END MAIN
```

The [BREAKPOINT](Programs.html#BREAKPOINT) instruction is simply ignored
when running in normal mode.

------------------------------------------------------------------------

### [Commands]{#COMMANDS}

Summary of the debugger commands:

  ----------------------------------------------------- -----------------------------------------------------------------------------------------------------------------------------------
  **Command**                                           **Description**
  [backtrace](#CMD_BACKTRACE)/[where](#CMD_BACKTRACE)   Print a summary of how your program reached the current state (back trace of all stack frames).
  [break](#CMD_BREAK)                                   Set a break point at the specified line or function.
  [call](#CMD_CALL)                                     Call a function in the program.
  [clear](#CMD_CLEAR)                                   Clear breakpoint at some specified line or function.
  [continue](#CMD_CONTINUE)                             Continue program being debugged.
  [define](#CMD_DEFINE)                                 Define a new command name.
  [delete](#CMD_DELETE)                                 Delete some breakpoints or auto-display expressions.
  [disable](#CMD_DISABLE)                               Disable some breakpoints.
  [display](#CMD_DISPLAY)                               Print the values of expression *EXP* each time the program stops.
  [down](#CMD_DOWN)                                     Select and print the function called by the current function.
  [echo](#CMD_ECHO)                                     Print the specified text.
  [enable](#CMD_ENABLE)                                 Re-activate breakpoints that have previously been disabled.
  [finish](#CMD_FINISH)                                 Execute until selected stack frame returns.
  [frame](#CMD_FRAME)                                   Select and print a stack frame.
  [help](#CMD_HELP)                                     Print list of debugger commands.
  [ignore](#CMD_IGNORE)                                 Set ignore-count of a breakpoint number N to COUNT.
  [info](#CMD_INFO)                                     Provide information about the status of the program.
  [list](#CMD_LIST)                                     List specified function or line.
  [next](#CMD_NEXT)                                     Step program; continue with the next source code line at the same level.
  [output](#CMD_OUTPUT)                                 Print the current value of the specified expression; do not include value history and do not print new-line.
  [print](#CMD_PRINT)                                   Print the current value of the specified expression.
  [ptype](#CMD_PTYPE)                                   Print the type of a variable
  [quit](#CMD_QUIT)                                     Exit the debugger.
  [run](#CMD_RUN)                                       Start the debugged program.
  [set](#CMD_SET)                                       Evaluate an expression and assign the result to a variable.
  [source](#CMD_SOURCE)                                 Execute a file of debugger commands.
  [signal](#CMD_SIGNAL)                                 Continue program giving it the signal specified by the argument.
  [step](#CMD_STEP)                                     Step program until it reaches a different source line.
  [tbreak](#CMD_TBREAK)                                 Set a temporary breakpoint.
  [tty](#CMD_TTY)                                       Set terminal for future runs of program being debugged.
  [undisplay](#CMD_UNDISPLAY)                           Cancel some expressions to be displayed when the program stops.
  [until](#CMD_UNTIL)                                   Continue running until a specified location is reached.
  [up](#CMD_UP)                                         Select and print the function that called the current function.
  [watch](#CMD_WATCH)                                   Set a watchpoint for an expression. A watchpoint stops the execution of your program whenever the value of an expression changes.
  [whatis](#CMD_WHATIS)                                 Prints the data type of a variable.
  ----------------------------------------------------- -----------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------

### [backtrace / where]{#CMD_BACKTRACE}

This commands prints a summary of how your program reached the current
state.

#### Syntax:

`backtrace`

#### Usage:

The `backtrace` command prints a summary of your program\'s entire
stack, one line per frame. Each line in the output shows the frame
number and function name.

#### Example:

    (fgldb) backtrace
    #1 addcount() at mymodule.4gl:6
    #2 main() at mymodule.4gl:2
    (fgldb)

#### Tips:

- `bt` and `where` are aliases for the `backtrace` command.

------------------------------------------------------------------------

### [break]{#CMD_BREAK}

This command defines a break point to stop the program execution at a
given line or function.

#### Syntax:

`break `[`[`]{.underline}` `[`{`]{.underline}` `[`[`]{.underline}*`module`*`.`[`]`]{.underline}*`function`*` `[`|`]{.underline}` `[`[`]{.underline}*`module`*`:`[`]`]{.underline}*`line`*` `[`}`]{.underline}` `[`]`]{.underline}` `[`[`]{.underline}` if `*`condition`*` `[`]`]{.underline}

#### Notes:

1.  *function* is a function name.
2.  *module* is the name of a specific source file, without extension.
3.  *line* is a source code line.
4.  *condition* is an expression evaluated dynamically.

#### Usage:

The `break `command sets a break point at a given position in the
program.

When the program is running, the debugger stops automatically at
breakpoints defined by this command.

If a *condition* is specified, the program stops at the breakpoint only
if the *condition* evaluates to TRUE.

**Warning: If you do not specify any location (function or line number),
the breakpoint is created for the current line. For example, if you
write \"break if var = 1\", the debugger adds a conditional breakpoint
for the current line, and the program will only stop if the variable is
equal to 1 when reaching the current line again.**

#### Example:

    (fgldb) break mymodule:5
    Breakpoint 2 at 0x00000000: file mymodule.4gl, line 5.

------------------------------------------------------------------------

### [call]{#CMD_CALL}

This command calls a function in the program.

#### Syntax:

`call `*`function-name`*` `[`(`]{.underline}` `*`expression`*` `[`[`]{.underline}` , expression `[`[...]`]{.underline}` `[`]`]{.underline}` `[`)`]{.underline}

#### Notes:

1.  *function-name* is the name of the function to call.
2.  *expression* is as simplified language
    [expression](Expressions.html).
3.  The return values are printed when the function returns.

#### Example:

``` linenumber
01 MAIN
02   DEFINE i INTEGER
03
04   LET i = 1 
05   DISPLAY i
06 
07 END MAIN
08 
09 FUNCTION hello ()
10     RETURN "hello", "world"
11 END FUNCTION
```

    (fgldb) br main
    Breakpoint 1 at 0x00000000: file t.4gl, line 4.
    (fgldb) run
    Breakpoint 1, main() at t.4gl:4
    4         LET i = 1
    (fgldb) call hello()
    $1 =  { "hello" , "world" }
    (fgldb)

------------------------------------------------------------------------

### [clear]{#CMD_CLEAR}

This command clears the breakpoint at a specified line or function.

#### Syntax:

`clear `[`[`]{.underline}` `[`{`]{.underline}` `*`function`*` `[`|`]{.underline}` `[`[`]{.underline}` `*`module`*` : `[`]`]{.underline}` `*`line`*` `[`}`]{.underline}` `[`]`]{.underline}

#### Notes:

1.  *function* is a function name.
2.  *module* is a specific source file.
3.  *line* is a source code line.

#### Usage:

With the `clear` command, you can delete breakpoints according to where
they are in your program.

Use the `clear` command with no arguments to delete any breakpoints at
the next instruction to be executed in the selected stack frame. 

See the [delete](#CMD_DELETE) command to delete individual breakpoints
by specifying their breakpoint numbers.

#### Example:

    (fgldb) clear mymodule:5
    Deleted breakpoint 2
    (fgldb)

------------------------------------------------------------------------

### [continue]{#CMD_CONTINUE}

This command continues the execution of the program after a breakpoint.

#### Syntax:

`continue `[`[`]{.underline}*`ignore-count`*[`]`]{.underline}

#### Notes:

1.  *ignore-count* defines the number of times to ignore a breakpoint at
    this location.

#### Usage:

The `continue` command continues the execution of the program until the
program completes normally, another breakpoint is reached, or a signal
is received.  

#### Example:

    (fgldb) continue
       <..program output..>
    Program exited normally.

#### Tips:

- `c` is an alias for the `continue` command.

------------------------------------------------------------------------

### [define]{#CMD_DEFINE}

This command allows you to specify a user-defined sequence of
commands.  

#### Syntax:

`define `*`command-name`\
`command`\*
` `[`[...]`\]{.underline}
`end`

#### Notes:

1.  *command-name* is the name assigned to the command sequence.
2.  *command* is a valid debugger command.
3.  **end**` `` `indicates the end of the command sequence.

#### Usage:

The `define` command allows you to create a user-defined command by
assigning a command name to a sequence of debugger commands that you
specify. You may then execute the command that you defined by entering
the command name at the debugger prompt.  

User commands may accept up to ten arguments separated by white space.  
 

#### Example:

    (fgldb) define myinfo
    > info breakpoints
    > info program
    > end
    (fgldb)

------------------------------------------------------------------------

### [delete]{#CMD_DELETE}

This command allows you to remove breakpoints that you have specified in
your debugger session.

#### Syntax:

`delete `*`breakpoint`*

#### Notes:

1.  *breakpoint` `* is the number assigned to the breakpoint by the
    debugger.

#### Usage:

The `delete` command allows you to remove breakpoints when they are no
longer needed in your debugger session.

If you prefer you may disable the breakpoint instead, see the `disable`
command.

#### Example:

    (fgldb) delete 1
    (fgldb) run
    Program exited normally.
    (fgldb)

#### Tips:

- `d` is an alias for the `delete` command.

------------------------------------------------------------------------

### [disable]{#CMD_DISABLE}

This command disables the specified breakpoint.

#### Syntax:

`disable `*`breakpoint`*

#### Notes:

1.  *breakpoint* is the number assigned to the breakpoint by the
    debugger.

#### Usage:

The `disable` command instructs the debugger to ignore the specified
breakpoint when running the program. 

Use the `enable` command to re-activate the breakpoint for the current
debugger session.  

#### Example:

    (fgldb) disable 1
    (fgldb) run
    Program exited normally.
    (fgldb)

------------------------------------------------------------------------

### [display]{#CMD_DISPLAY}

This command displays the specified expression\'s value each time your
program stops.

#### Syntax:

`display `*`expression`*

#### Notes:

1.  *expression* is your program\'s expression that you wish to examine.

#### Usage:

The `display` command allows you to add an expression to an automatic
display list.  The values of the expressions in the list are printed
each time your program stops.  Each expression in the list is assigned a
number to identify it.

This command is useful in tracking how the values of expressions change
during the program\'s execution.

#### Example:

    (fgldb) display a
    1: a = 6
    (fgldb) display i
    2: i = 1
    (fgldb) step
    2: i = 1
    1: a = 6
    16       for i = 1 to 10
    (fgldb) step
    2: i = 2
    1: a = 6
    17       let a = a+1
    (fgldb)

------------------------------------------------------------------------

### [down]{#CMD_DOWN}

This command selects and prints the function called by the current
function, or the function specified by the frame number in the call
stack.

#### Syntax:

`down `[`[`]{.underline}*`frames`*[`]`]{.underline}

#### Notes:

1.  *frames* is the number of frames to move down the stack.  The
    default is 1.

#### Usage: 

This command moves down the call stack, to the specified frame, and
prints the function identified with that frame.  To print the function
called by the current function, use the down command without an
argument.  See [Stack Frames](#STACKFRAME) for a brief description of
frames.

    (fgldb) down
    #0 query_cust() at custquery.4gl:22
    22    CALL cleanup()
    (fgldb)

------------------------------------------------------------------------

### [echo]{#CMD_ECHO}

This command prints the specified text as prompt.

#### Syntax:

`echo `*`text`*

#### Notes:

1.  *text* is the specific text to be output.

#### Usage:

The `echo` command allows you to generate exactly the output that you
want. Nonprinting characters can be included in text using C escape
sequences, such as '\\n' to print a new-line. No new-line is printed
unless you specify one. In addition to the standard C escape sequences,
a backslash followed by a space stands for a space. A backslash at the
end of text can be used to continue the command onto subsequent lines. 

#### Example:

    (fgldb) echo hello
    hello (fgldb)

------------------------------------------------------------------------

### [enable]{#CMD_ENABLE}

This command enables breakpoints that have previously been disabled.

#### Syntax:

`enable `*`breakpoint`*

#### Notes:

1.  *breakpoint* is the number assigned to the breakpoint by the
    debugger.

#### Usage:

The `enable` command allows you to re-activate a breakpoint in the
current debugger session.  The breakpoint must have been disabled using
the `disable` command.

#### Example:

    (fgldb) disable 1
    (fgldb) run
    Program exited normally.
    (fgldb) enable 1
    (fgldb) run
    Breakpoint 1, at mymodule.4gl:5

------------------------------------------------------------------------

### [finish]{#CMD_FINISH}

This command continues the execution of a program until the current
function returns normally.

#### Syntax:

`finish`

#### Usage:

The `finish` command instructs the program to continue running until
just after the function in the selected stack frame returns, and then
stop.

The returned value, if any, is printed.

#### Example: 

    (fgldb) finish
    Run till exit myfunc() at module.4gl:10
    Value returned is $1 = 123
    (fgldb)

------------------------------------------------------------------------

### [frame]{#CMD_FRAME}

This command selects and prints a stack frame.

#### Syntax:

`frame `[`[`]{.underline}` `*`address`*` `[`|`]{.underline}` `*`number`*` `[`]`]{.underline}

#### Notes:

1.  *address* is the address of the frame that you wish to select.
2.  *number* is the stack frame number of the frame that you wish to
    select.

#### Usage:

The `frame` command allows you to move from one stack frame to another,
and to print the stack frame that you select. Each stack frame is
associated with one call to one function within the currently executing
program.  Without an argument, the current stack frame is printed. See
[Stack Frames](#STACKFRAME) for a brief discussion of frames.

#### Example:

    (fgldb) frame
    #0 query_cust() at testquery.4gl:42
    (fgldb)

------------------------------------------------------------------------

### [help]{#CMD_HELP}

This command provides information about debugger commands.

#### Syntax:

`help `[`[`]{.underline}*`command`*[`]`]{.underline}

#### Notes:

1.  *command* is the name of the debugger command for which you wish
    information.

#### Usage:

The `help` command displays a short explanation of  a specified
command. 

Enter the `help` command with no arguments to display a list of debugger
commands.

#### Example:

    (fgldb) help delete
    Delete some breakpoints or auto-display expressions

------------------------------------------------------------------------

### [ignore]{#CMD_IGNORE}

Set the ignore-count of a breakpoint number N to COUNT.

#### Syntax:

`ignore `*`breakpoint`*` `*`count`*

#### Notes:

1.  *breakpoint* is the breakpoint number.
2.  *count* is the number of times the breakpoint will be ignored.

#### Usage:

The `ignore` command defines the number of times a breakpoint is ignored
when the program flow reaches that breakpoint.

The next *count* times the breakpoint is reached, the program execution
will continue, and no [breakpoint condition](#CMD_BREAK) is checked.

#### Tips:

1.  You can specify a *count* of zero to make the breakpoint stop the
    next time it is reached.
2.  When using the [continue](#CMD_CONTINUE) command to resume the
    execution of the program from a breakpoint, you can specify a an
    ignore count directly as an argument.

#### Example:

    (fgldb) br main
    Breakpoint 1 at 0x00000000: file t.4gl, line 4.
    (fgldb) ignore 1 2
    Will ignore next 2 crossings of breakpoint 1.
    (fgldb) run
              1
    Program exited normally.
    (fgldb) run
              1
    Program exited normally.
    (fgldb) run
    Breakpoint 1, main() at t.4gl:4
    4         LET i = 1
    (fgldb)

------------------------------------------------------------------------

### [info]{#CMD_INFO}

This command describes the current state of your program.

#### Syntax:

`info `[`{`]{.underline}` breakpoints`\
`     `[`|`]{.underline}` `` sources`\
`     `[`|`]{.underline}` program`\
`     `[`|`]{.underline}` variables`\
`     `[`|`]{.underline}` locals`\
`     `[`|`]{.underline}` files`\
`     `[`|`]{.underline}` line `[`{`]{.underline}` `*`function`*` `[`|`]{.underline}` `*`module:line`*` `[`}`]{.underline}\
`     `[`}`]{.underline}

#### Notes:

1.  *function* is a function name of the program.
2.  *module:line* defines a source code line in a module. 

#### Usage:

The `info` command describes the state of your program.

- `info breakpoints` lists the breakpoints that you have set.
- `info sources` prints the names of all the source files in your
  program**.**
- `info program` displays the status of your program.
- `info variables` displays global variables.
- `info locals` displays the local variables of the current function.
- `info files` lists the files from which symbols were loaded.
- `info line `*`function`* prints the program addresses for the first
  line of the function named *function*.  
- `info line `*`module:line `*prints the starting and ending addresses
  of the compiled code for the source line specified.  See the `list`
  command for all the ways that you can specify the source code line.  

#### Example: 

    (fgldb) info sources
    Source files for which symbols have been read in:

    mymodule.4gl, fglwinexec.4gl, fglutil.4gl, fgldialog.4gl, fgldummy4js.4gl
    (fgldb)

------------------------------------------------------------------------

### [list]{#CMD_LIST}

This command prints source code lines of the program being executed.

#### Syntax:

`list `[`[`]{.underline}` `*`function`*` `[`|`]{.underline}` `[`[`]{.underline}*`module`*`:`[`]`]{.underline}*`line`*` `[`]`]{.underline}

#### Usage:

The `list` command prints source code lines of your program, by default
it begins with the current line.

#### Example:

    (fgldb) run
    Breakpoint 1, at mymodule.4gl:5
    5    call addlist()
    (fgldb) list
    5    call addlist()
    6    call addname()
    .
    14  end function
    (fgldb)

------------------------------------------------------------------------

### [next]{#CMD_NEXT}

This command continues running the program by executing the next source
line in the current stack frame, and then stops.

#### Syntax:

`next`

#### Usage:

The `next` command allows you to execute your program one line of source
code at a time. The `next` command is similar to `step,` but function
calls that appear within the line of code are executed without
stopping.  When the next line of code at the original stack level that
was executing when you gave the `next` command is reached,  execution
stops.

After reaching a breakpoint, the `next` command can be used to examine a
troublesome section of code more closely.

#### Example:

    (fgldb) next
    5 call addlist()
    (fgldb) next
    6 call addname()
    (fgldb)

#### Tips:

- `n` is an alias for the `next` command.

------------------------------------------------------------------------

### [output]{#CMD_OUTPUT}

This command prints only the value of the specified expression,
suppressing any other output.

#### Syntax:

`output `*`expression`*

#### Notes:

1.  *expression* is your program\'s expression that you wish to examine.

#### Usage:

The `output` command prints the current value of the expression and
nothing else, no new-line character, no \"expr=\", etc.

The usual output from the debugger is suppressed, allowing you to print
only the value.

#### Example:

    (fgldb) output b
    123(fgldb)

------------------------------------------------------------------------

### [print]{#CMD_PRINT}

This command displays the current value of the specified expression.

#### Syntax:

`print `*`expression`*

#### Notes:

1.  *expression* is your program\'s expression that you wish to examine.

#### Usage:

The `print` command allows you to examine the data in your program.

It evaluates and prints the value of the specified expression from your
program, in a format appropriate to its data type.

#### Example:

    (fgldb) print b
     $1 = 5
    (fgldb)

#### Tips:

- `p` is an alias for the `print` command.

------------------------------------------------------------------------

### [ptype]{#CMD_PTYPE}

This command prints the data type or structure of a variable.

#### Syntax:

`ptype `*`variable-name`*

#### Notes:

1.  *variable-name* is the name of the variable.

#### Example:

    (fgldb) ptype cust_rec
    type = RECORD
        cust_num INTEGER,
        cust_name VARCHAR(10),
        cust_address VARCHAR(200)
    END RECORD

------------------------------------------------------------------------

### [quit]{#CMD_QUIT}

This command terminates the debugger session.

#### Syntax:

`quit`

#### Usage:

The `quit` command allows you to exit the debugger.

Example:

    (fgldb) quit

#### Tips:

- `q` is an alias for the `quit` command.

------------------------------------------------------------------------

### [run]{#CMD_RUN}

This command starts the program.

#### Syntax:

`run `[`[`]{.underline}*`argument`*` `[`[...]`]{.underline}` `[`]`]{.underline}

#### Notes:

1.  *argument *is an argument to be passed to the program.

#### Usage:

The run command causes your program to execute until a breakpoint is
reached or the program terminates normally.

#### Example:

    (fgldb) run a b c
    Breakpoint 1, at mymodule.4gl:3
    3      call addcount()
    (fgldb)

------------------------------------------------------------------------

### [set]{#CMD_SET}

This command allows you to configure your debugger session and change
program variable values.

#### Syntax:

`set `[`{`]{.underline}` prompt `*`ptext`\
`   `*` `[`|`]{.underline}` annotate `*[`{`]{.underline}*`1`[`|`]{.underline}`0`[*`}`*]{.underline}\
`    `[`|`]{.underline}` verbose `*[`{`]{.underline}*`on`[`|`]{.underline}`off`*[`}`]{.underline}\
`   `*` `[`|`]{.underline}` variable `*`varname`*`=`*`expression`*\
*`   `*` `[`|`]{.underline}` environment `*`envname`*[`[`]{.underline}`=`*`value`*[`]`]{.underline}\
`    `[`}`]{.underline}

#### Notes:

1.  *ptext *is the string to which the prompt should be set.
2.  *varname* is the program variable to be set to *expression*.
3.  *expression* is as simplified language
    [expression](Expressions.html).
4.  *envname* is the environment variable to be set to *value*.

#### Usage:

The `set` command allows to change program variables and/or the
environment.

`set variable` sets an program variable, to be taken into account when
continuing program execution. The right operand can be an expression.

`set prompt` changes the prompt text. The text can be set to any string.
A space is not automatically added after the prompt string, allowing you
to determine whether to add a space at the end of the prompt string.

`set environment` sets an environment variable, where *value* may be any
string.  If the *value* parameter is omitted, the variable is set to a
null value. The variable is set for your program, not for the debugger
itself. 

`set verbose on` forces the debugger to display additional messages
about its operations, allowing you to observe that it is still working
during lengthy internal operations.

`set annotate 1 ` switches the output format of the debugger to be more
machine readable (this command is used by GUI front-ends like *ddd* or
*xxgdb*)

#### Example: {#example-22 align="LEFT"}

    (fgldb) set prompt ($)
    ($)

**Warning: On Unix systems, if your SHELL variable names a shell that
runs an initialization file, any variables you set in that file affect
your program. You may wish to move setting of environment variables to
files that are only run when you sign on, such as .login or .profile.**

------------------------------------------------------------------------

### [source]{#CMD_SOURCE}

This command executes a file of debugger commands.

#### Syntax:

`source `*`commandfile`*

#### Notes:

1.  *commandfile* is the name of the file containing the debugger
    commands.

#### Usage:

The ` source` command allows you to execute a command file of lines that
are debugger commands.  The lines in the file are executed sequentially.
The commands are not printed as they are executed, and any messages are
not displayed.  Commands are executed without asking for confirmation.
An error in any command terminates execution of the command file.

#### Example:

Using the text file **mycommands**, which contains the single line: 
break 10

    (fgldb) source mycommands
    Breakpoint 2 @ 0x00000000: file mymod.4gl, line 10.
    (fgldb)

------------------------------------------------------------------------

### [signal]{#CMD_SIGNAL}

This command sends an INTERRUPT signal to your program.

#### Syntax:

`signal `*`signal`*

#### Usage:

Resume execution where your program stopped, but immediately give it the
signal *signal*. *signal* can be the name or the number of a signal. For
example, on many systems signal 2 and signal SIGINT are both ways of
sending an interrupt signal. The `signal SIGINT` command resumes
execution of your program where it has stopped, but immediately sends an
INTERRUPT signal.  The source line that was current when the signal was
received is displayed.

#### Notes:

1.  The current version only allows then signal `SIGINT`.

#### Example:

    (fgldb) signal SIGINT
    Program exited normally.
    16      for i = 1 to 10
    (fgldb)

------------------------------------------------------------------------

### [step]{#CMD_STEP}

This command continues running the program by executing the next line of
source code, and then stops.   

#### Syntax:

`step `[`[`]{.underline}*`count`*[`]`]{.underline}

#### Notes:

1.  *count* defines the number of lines to execute before stopping.

#### Usage:

The `step` command allows you to \"step\" through your program,
executing one line of source code at a time. When a function call
appears within the line of code, that function is also stepped through.
A common technique is to set a breakpoint prior to the section or
function that is causing problems, run the program till it reaches the
breakpoint, and then step through it line by line.

#### Example:

    (fgldb) step
    4 call addlist(a)
    (fgldb)

#### Tips:

- `s` is an alias for the `step` command.

------------------------------------------------------------------------

### [tbreak]{#CMD_TBREAK}

This command sets a temporary breakpoint.

#### Syntax:

`tbreak `[`[`]{.underline}` `[`{`]{.underline}` `*`function`*` `[`|`]{.underline}` `[`[`]{.underline}` `*`module`*` : `[`]`]{.underline}` `*`line`*` `[`}`]{.underline}` `[`]`]{.underline}` `[`[`]{.underline}` if `*`condition`*` `[`]`]{.underline}

#### Notes:

1.  *function* is a function name.
2.  *module* is a specific source file.
3.  *line* is a source code line.
4.  *condition* is an expression evaluated dynamically.

#### Usage:

The `tbreak` command sets a breakpoint for one stop only. The breakpoint
is set in the same way as with the [break](#CMD_BREAK) command, but the
breakpoint is automatically deleted after the first time your program
stops there.

If a *condition* is specified, the program stops at the breakpoint only
if the *condition* evaluates to TRUE.

**Warning: If you do not specify any location (function or line number),
the breakpoint is created for the current line. For example, if you
write \"tbreak if var = 1\", the debugger adds a conditional breakpoint
for the current line, and the program will only stop if the variable is
equal to 1 when reaching the current line again.**

#### Example:

    (fgldb) tbreak 12
    Breakpoint 2 at 0x00000000: file custmain.4gl, line 12.
    (fgldb)

------------------------------------------------------------------------

### [tty]{#CMD_TTY}

This command resets the default program input and output for future run
commands.\>

#### Syntax:

`tty `*`filename`*

#### Notes:

1.  *filename* is the file which is to be the default for program input
    and output.

#### Usage:

The tty command instructs the debugger to re-direct  program input and
output to the specified file for future run commands.

The re-direction is for your program only;  your terminal is still used
for debugger input and output.

#### Example: {#example-27 align="LEFT"}

    (fgldb) tty /dev/ttyS0
    (fgldb)

------------------------------------------------------------------------

### [undisplay]{#CMD_UNDISPLAY}

This command cancels expressions to be displayed when the program stops.

#### Syntax:

`undisplay `*`itemnum`*` `[`[...]`]{.underline}

#### Notes:

1.  *itemnum* is the number of the expressions for which the display is
    cancelled.

#### Usage: 

When the [display](#CMD_DISPLAY) command is used, each expression
displayed is assigned an item number. The `undisplay` command allows you
to remove expressions from the list to be displayed, using the item
number to specific the expression to be removed.

#### Example:

    (fgldb) step
    2: i = 2
    1: a = 20
    9     FOR  i = 1 TO 10
    (fgldb) undisplay 2
    (fgldb) step
    1: a = 20
    10   Let cont = TRUE
    (fgldb)

------------------------------------------------------------------------

### [until]{#CMD_UNTIL}

This command continues running the program until the specified location
is reached.

#### Syntax:

`until `[`[`]{.underline}` `[`{`]{.underline}` `*`function`*` `[`|`]{.underline}` `[`[`]{.underline}` `*`module`*` : `[`]`]{.underline}` `*`line`*` `[`}`]{.underline}` `[`]`]{.underline}

#### Notes:

1.  *function* is a function name.
2.  *module* is a specific source file.
3.  *line* is a source code line.

#### Usage:

The `until` command continues running your program until either the
specified location is reached, or the current stack frame returns.  This
can be used to avoid stepping through a loop more than once.

#### Example:

    (fgldb) until addcount()

------------------------------------------------------------------------

### [up]{#CMD_UP}

This command selects and prints the function that called this one, or
the function specified by the frame number in the call stack.

#### Syntax:

`up `[`[`]{.underline}*`frames`*[`]`]{.underline}

#### Notes:

1.  *frames* says how many frames up to go in the stack.  The default is
    1.

#### Usage:

The ` up` command moves towards the outermost frame, to frames that have
existed longer. To print the function that called the current function,
use the up command without an argument.  See [Stack Frames](#STACKFRAME)
for a brief description of frames.

#### Example:

    (fgldb) up
    #1 main() at customain.4gl:14
    14    CALL query_cust()
    (fgldb)

------------------------------------------------------------------------

### [watch]{#CMD_WATCH}

This command sets a watchpoint for an expression. A watchpoint stops
execution of your program whenever the value of an expression changes.

#### Syntax:

`watch `*`expression`*` `[`[`]{.underline}`boolean-expression`[`]`]{.underline}

#### Notes:

1.  *expression* is the expression to watch.
2.  *boolean-expression* is an optional boolean expression.

#### Usage:

The watchpoint stops the program execution when the value of the
expression changes.

If *boolean-expression* is provided, the watchpoint stops the execution
of the program if the expression value has changed and the
*boolean-expression* evaluates to TRUE.

**Warning: The watchpoint cannot be set if the program is not in the
context where *expression* can be evaluated. Before using a watchpoint,
you typically set a breakpoint in the function where the *expression*
makes sense, then you run the program, and then you set the watchpoint.
The example below illustrates this procedure.**

#### Example:

``` linenumber
01 MAIN
02   DEFINE i INTEGER
03
04   LET i = 1 
05   DISPLAY i
06   LET i = 2 
07   DISPLAY i
08   LET i = 3 
09   DISPLAY i
10
11 END MAIN
```

    (fgldb) break main
    breakpoint 1 at 0x00000000: file test.4gl, line 4
    (fgldb) run
    Breakpoint 1, main() at test.4gl:4
    4      LET i = 1
    (fgldb) watch i if i >= 3
    Watchpoint 1:  i
    (fgldb) continue
              1
              2
    Watchpoint 1:  i

    Old value = 2
    New value = 3
    main() at t.4gl:9
    9         DISPLAY i
    (fgldb)

------------------------------------------------------------------------

### [whatis]{#CMD_WHATIS}

This command prints the data type of a variable.

#### Syntax:

`whatis `*`variable-name`*

#### Notes:

1.  *variable-name* is the name of the variable.

#### Example:

    (fgldb) run 
    Breakpoint 1, main() at t.4gl:4
    4         LET i = 1
    (fgldb) whatis i
    type = INTEGER
    (fgldb)
