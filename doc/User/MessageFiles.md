[Back to Contents](../index.html)

------------------------------------------------------------------------

# [Message Files]{#PAGE_HEADER}

Summary:

- [Basics](#DEFINITION)
- [Syntax](#SYNTAX)
- [Compiling Message Files](#COMPILING)
- [Using Messages Files](#USING)
- [Example](#EXAMPLES)

See also: [OPTIONS](Programs.html#PROGRAM_OPTIONS),
[SHOWHELP()](BuiltInFunctions.html#BF_SHOWHELP),
[fglmkmsg](Tools.html#TL_FGLMKMSG), [Localized
Strings](LocalizedStrings.html).

------------------------------------------------------------------------

### [Basics]{#DEFINITION}

Message Files define text messages with a unique integer identifier. You
can create as many message files as needed. Message files are typically
used to implement application help system, especially when using the
[Text User Interface](FglTerms.html#TEXT_USER_INTERFACE) mode.

In order to use a message file, you need to do the following: 

1.  Create the source message file with a text editor.
2.  Compiler the source message file to a binary format.
3.  Copy the binary file to a distribution directory.
4.  In programs, specify the message file with [OPTIONS HELP
    FILE](Programs.html#options-help-file).

Message files are supported for backward compatibility. You should also
have a look at the [Localized Strings](LocalizedStrings.html) feature.

------------------------------------------------------------------------

### [Syntax]{#SYNTAX}

*`filename`*`.msg`

#### Notes:

1.  *filename* is the name of the message source file.

#### Syntax of a message file:

[`{`]{.underline}\
`  `*`message-definition`*\
[`|`]{.underline}` `*`include-directive`*\
[`}`]{.underline}*\*
`[...]`

where *message-definition* is:

`.`*`message-number`\
`message-line `[`|`]{.underline}` new-page`\*
`[...]`

where *include-directive* is:

`.include `*`file-name`*` `

and where *new-page* is:

`^L (Control-L, ASCII 12)`

You can split the message into pages by adding the \^L (Control-L /
ASCII 12) in a line.

**Warning: Multi-line messages will include the new-line (ASCII 10)
characters.**

------------------------------------------------------------------------

### [Compiling Message Files]{#COMPILING}

In order to use message files in a program, the message source files
(`.msg`) must be compiled with the [fglmkmsg](Tools.html#TL_FGLMKMSG)
utility to produce compiled message files (`.iem`).

The following command line compiles the message source file mess01.msg:

`fglmkmsg mess01.msg`

This creates the compiled message file mess01.iem.

For backward compatibility, you can specify the output file as second
argument:

`fglmkmsg mess01.msg mess01.iem`

#### Warning: The `.iem` compiled version of the message file must be distributed on the machine where the programs are executed.

------------------------------------------------------------------------

### [Using Message Files]{#USING}

In order to use compiled message files (`.iem`) in programs, you must
first specify the message file with the [OPTIONS HELP
FILE](Programs.html#options-help-file) command:

``` linenumber
01  OPTIONS HELP FILE "mymessages.iem"
```

The message file will first be searched with the string passed to the
`OPTIONS HELP FILE` command (i.e. the current directory if the file is
specified without a path), and if not found, the
[DBPATH](EnvironmentVariables.html#EV_DBPATH)/[FGLRESOURCEPATH](EnvironmentVariables.html#EV_FGLRESOURCEPATH)
environment variable with be used.

After the message file is defined, you can start the help viewer by
calling the [`SHOWHELP()`](BuiltInFunctions.html#BF_SHOWHELP) function:

``` linenumber
01  CALL showhelp(1242)
```

You can also use the `HELP` keyword in a dialog instruction like
[INPUT](RecordInput.html) to define particular message number for that
the dialog:

``` linenumber
01  INPUT BY NAME ... HELP 455
```

The help viewer will automatically display the message text
corresponding to the number when the user pressed the help key. By
default, the help key is CONTROL-W in [TUI
mode](FglTerms.html#TEXT_USER_INTERFACE) and F1 in [GUI
mode](FglTerms.html#GRAPHICAL_USER_INTERFACE).

------------------------------------------------------------------------

### [Example]{#EXAMPLES}

#### Message source file example:

``` linenumber
01 .101
02 This is help about option 1
03 .102
04 This is help about help
05 .103
06 This is help about My Menu
```

#### Application using this help message:

``` linenumber
01 MAIN
02     OPTIONS
03         HELP FILE "help.iem"
04     OPEN WINDOW w1 AT 5,5 WITH FORM "const"
05     MENU "My Menu"
06         COMMAND "Option 1" HELP 101
07           DISPLAY "Option 1 chosen"
08         COMMAND "Help"
09             CALL SHOWHELP(103)
10     END MENU
11     CLOSE WINDOW w1
12 END MAIN
```
