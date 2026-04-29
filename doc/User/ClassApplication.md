[Back to Contents](../index.html)

------------------------------------------------------------------------

# [The Application class]{#PAGE_HEADER}

Summary:

- [Syntax](#SYNTAX)
- [Methods](#METHODS)
- [Usage](#USAGE)
  - [Command line arguments](#cmd-line-args)
  - [Program information](#program-info)
  - [Runtime information](#runtime-info)
  - [FGLPROFILE resource](#fglprofile)
  - [Debugging](#debugging)

See also: [Built-in classes](BuiltInClasses.html)

------------------------------------------------------------------------

### [Syntax]{#SYNTAX}

The **Application** class is a [built-in class](BuiltInClasses.html)
providing an interface to the application internals.

#### Syntax:

`base.Application`

#### Notes:

1.  This class does not have to be instantiated; it provides class
    methods for the current program.

------------------------------------------------------------------------

### [Methods:]{#METHODS}

+-----------------------------------------------------------------------------+------------------------------------------------+
| **Class Methods**                                                                                                            |
+-----------------------------------------------------------------------------+------------------------------------------------+
| **Name**                                                                    | **Description**                                |
+-----------------------------------------------------------------------------+------------------------------------------------+
| ` `[`getArgumentCount`](#cmd-line-args){#getArgumentCount}`()`\             | Returns the number of arguments passed to the  |
| `  ``RETURNING INTEGER`                                                     | program.                                       |
+-----------------------------------------------------------------------------+------------------------------------------------+
| ` `[`getArgument`](#cmd-line-args){#getArgument}`( position ``INTEGER`` )`\ | Returns the argument passed to the program,    |
| `  ``RETURNING STRING`                                                      | according to its position.                     |
+-----------------------------------------------------------------------------+------------------------------------------------+
| ` `[`getProgramName`](#program-info){#getProgramName}`()`\                  | Returns the name of the program.               |
| `  ``RETURNING STRING`                                                      |                                                |
+-----------------------------------------------------------------------------+------------------------------------------------+
| ` `[`getProgramDir`](#program-info){#getProgramDir}`()`\                    | Returns the system-dependent path of the       |
| `  ``RETURNING STRING`                                                      | directory where the program files are located. |
+-----------------------------------------------------------------------------+------------------------------------------------+
| [`getFglDir`](#runtime-info){#getFglDir}`()`\                               | Returns the system-dependent path of the       |
| `  ``RETURNING STRING`                                                      | installation directory of the runtime system   |
|                                                                             | ([FGLDIR](EnvironmentVariables.html#EV_FGLDIR) |
|                                                                             | environment variable).                         |
+-----------------------------------------------------------------------------+------------------------------------------------+
| ` `[`getResourceEntry`](#fglprofile){#getResourceEntry}`( name ``STRING`    | Returns the value of an                        |
| ` )`\                                                                       | [FGLPROFILE](FglProfile.html) entry.           |
| `  ``RETURNING STRING`                                                      |                                                |
+-----------------------------------------------------------------------------+------------------------------------------------+
| ` `[`getStackTrace`](#debugging){#getStackTrace}`()`\                       | Returns the current stack trace of the program |
| `  ``RETURNING STRING`                                                      | flow.                                          |
+-----------------------------------------------------------------------------+------------------------------------------------+

------------------------------------------------------------------------

### [Usage:]{#USAGE}

The Application class groups a set of utility functions related to the
program environment. Command line arguments, execution directory and
[FGLPROFILE](FglProfile.html) resource entries are some of the elements
you can query with this class.

#### [Command line arguments]{#cmd-line-args}

You can query command line arguments with the `getArgumentCount()` and
`getArgument()` methods. The `getArgumentCount()` method returns the
total number of arguments passed to the program, while `getArgument()`
returns the argument value for the given position. First argument starts
at 1 (argument number zero is the program name).

``` linenumber
01 MAIN
02    DEFINE i INTEGER
03    FOR i=1 TO base.Application.getArgumentCount()
04       DISPLAY base.Application.getArgument(i)
05    END FOR
06 END MAIN
```

#### [Program information]{#program-info}

Basic program execution information can be queried with the
`getProgramName()` and `getProgramDir()` methods. The `getProgramName()`
method returns the name of the program. The `getProgramDir()` method
returns the directory path where the **42r** program file is located.
Note that the directory path is system-dependent.

#### [Runtime information]{#runtime-info}

Product information can be queried with the `getFglDir()` method. The
`getFglDir()` method returns the installation directory path defined by
FGLDIR. Note that the directory path is system-dependent.

#### [FGLPROFILE resource]{#fglprofile}

If needed you can query [FGLPROFILE](FglProfile.html) resource entries
with the `getResourceEntry()` method. This method returns the fglprofile
value of the entry passed as parameter.

``` linenumber
01 MAIN
02   DISPLAY base.Application.getResourceEntry("mycompany.params.logmode")
03 END MAIN
```

#### [Debugging]{#debugging}

In some situations - typically, to identify problems on a production
site - you may want to known what functions have been called when a
program raises an error. You can get and print the stack trace in a log
file by using the `getStackTrace()` method. This method returns a string
containing a formatted list of the current function stack.

You typically use this function in a WHENEVER ERROR CALL handler, as in
the following code example:

``` linenumber
01 MAIN
02    WHENEVER ERROR CALL my_handler
03    ...
04 END MAIN
05 ...
06 FUNCTION my_handler()
07    DISPLAY base.Application.getStackTrace()
08 END FUNCTION
```

Example of stack trace output:

    #0 my_handler() at debug.4gl:173
    #1 save_customer_data() at customer.4gl:1534
    #2 edit_customer() at customer.4gl:542
    #3 main at main.4gl:23
