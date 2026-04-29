[Back to Contents](../index.html)

------------------------------------------------------------------------

# [Built-in Functions]{#PAGE_HEADER}

Summary:

- [What is a built-in function?](#DEFINITION)
- [List of built-in functions](#FUNCLIST)
- [List of de-supported functions](#DESUPLIST)
- [The key code table](#KEYCODES)

*See also:* [Utility Functions](UtilityFunctions.html),
[Variables](Variables.html), [Functions](Functions.html),
[Operators](Operators.html), [Built-in Classes](BuiltInClasses.html).

------------------------------------------------------------------------

### [What is a built-in function?]{#DEFINITION}

A built-in function is a predefined [function](Functions.html) that is
included in the [runtime system](FglTerms.html#RUNTIME_SYSTEM) or
provided as a library function automatically linked to your programs.
You do not have to link with any additional BDL library to create your
programs. The built-in functions are part of the language.

Built-in functions are not [operators](Operators.html). Some operators
have the same syntax as functions, but these are real language operators
that have a specific order of precedence. Operators can be used in
different contexts according to the BDL grammar. See for example:
[YEAR(date)](Operators.html#OP_YEAR),
[MONTH(date)](Operators.html#OP_MONTH),
[DAY(date)](Operators.html#OP_DAY),[WEEKDAY(date)](Operators.html#OP_WEEKDAY),
[MDY(integer,integer,integer)](Operators.html#OP_MDY)
[GET_FLDBUF(field)](Operators.html#OP_GET_FLDBUF),
[INFIELD(field)](Operators.html#OP_INFIELD),
[FIELD_TOUCHED(field)](Operators.html#OP_FIELD_TOUCHED)

See also [Utility Functions](UtilityFunctions.html).

------------------------------------------------------------------------

### [List of built-in functions]{#FUNCLIST}

  -------------------------------------------------------------------------- -------------------------------------------------------------------------------------------------------------------------------------
  **Function**                                                               **Description**
  [ARG_VAL()](#BF_ARG_VAL)                                                   Returns a command line argument by position.
  [ARR_COUNT()](#BF_ARR_COUNT)                                               Returns the number of records entered in a program array during or after execution of the [INPUT ARRAY](InputArray.html) statement.
  [ARR_CURR()](#BF_ARR_CURR)                                                 Returns the current row in a [DISPLAY ARRAY](DisplayArray.html) or [INPUT ARRAY](InputArray.html).
  [DOWNSHIFT()](#BF_DOWNSHIFT)                                               Returns a string value in which all uppercase characters in its argument are converted to lowercase.
  [ERR_GET()](#BF_ERR_GET)                                                   Returns the text corresponding to an error number.
  [ERR_PRINT()](#BF_ERR_PRINT)                                               Prints in the [error line](MessageDisplay.html#ERROR) the text corresponding to an error number.
  [ERR_QUIT()](#BF_ERR_QUIT)                                                 Prints in the [error line](MessageDisplay.html#ERROR) the text corresponding to an error number and terminates the program.
  [ERRORLOG()](#BF_ERRORLOG)                                                 Copies the string passed as a parameter into the [error log file](#BF_STARTLOG).
  [FGL_BUFFERTOUCHED()](#BF_FGL_BUFFERTOUCHED)                               Returns [TRUE](Programs.html#PC_TRUE) if the current input buffer was modified since the field was selected.
  [FGL_DB_DRIVER_TYPE()](#BF_FGL_DB_DRIVER_TYPE)                             Returns the code of the current database driver (ifx, ora, ads, \...)
  [FGL_DECIMAL_TRUNCATE()](#BF_FGL_DECIMAL_TRUNCATE)                         Truncates a decimal to the precision specified.
  [FGL_DECIMAL_SQRT()](#BF_FGL_DECIMAL_SQRT)                                 Computes the square root of a decimal number.
  [FGL_DECIMAL_EXP()](#BF_FGL_DECIMAL_EXP)                                   Computes the exponent of a decimal number.
  [FGL_DECIMAL_LOGN()](#BF_FGL_DECIMAL_LOGN)                                 Computes the natural logarithm of a decimal number.
  [FGL_DECIMAL_POWER()](#BF_FGL_DECIMAL_POWER)                               Raises a decimal to the power of exponent, using real numbers.
  [FGL_DIALOG_GETBUFFER()](#BF_FGL_DIALOG_GETBUFFER)                         Returns the value of the current field as a string.
  [FGL_DIALOG_GETBUFFERLENGTH()](#BF_FGL_DIALOG_GETBUFFERLENGTH)             When using a paged display array, returns the number of rows to fill the array buffer.
  [FGL_DIALOG_GETBUFFERSTART()](#BF_FGL_DIALOG_GETBUFFERSTART)               When using a paged display array, returns the row offset to fill the array buffer.
  [FGL_DIALOG_GETCURSOR()](#BF_FGL_GETCURSOR)                                Returns the position of the edit cursor in the current field.
  [FGL_DIALOG_GETFIELDNAME()](#BF_FGL_DIALOG_GETFIELDNAME)                   Returns the name of the current input field.
  [FGL_DIALOG_GETKEYLABEL()](#BF_FGL_DIALOG_GETKEYLABEL)                     Returns the text associated to a key in the current interactive instruction.
  [FGL_DIALOG_GETSELECTIONEND()](#BF_FGL_DIALOG_GETSELECTIONEND)             Returns the position of the last selected character in the text of the current field.
  [FGL_DIALOG_INFIELD()](#BF_FGL_DIALOG_INFIELD)                             Returns [TRUE](Programs.html#PC_TRUE) if the field passed as a parameter is the current input field.
  [FGL_DIALOG_SETBUFFER()](#BF_FGL_DIALOG_SETBUFFER)                         Sets the value of the current field as a string.
  [FGL_DIALOG_SETCURRLINE()](#BF_FGL_DIALOG_SETCURRLINE)                     Moves to a specific row in a record list.
  [FGL_DIALOG_SETCURSOR()](#BF_FGL_DIALOG_SETCURSOR)                         Sets the position of the input cursor within the current field.
  [FGL_DIALOG_SETFIELDORDER()](#BF_FGL_DIALOG_SETFIELDORDER)                 Enables or disables field order constraint.
  [FGL_DIALOG_SETKEYLABEL()](#BF_FGL_DIALOG_SETKEYLABEL)                     Sets the text associated to a key for the current interactive instruction.
  [FGL_DIALOG_SETSELECTION()](#BF_FGL_DIALOG_SETSELECTION)                   Selects a part of the text in the current field.
  [FGL_DRAWBOX()](#BF_FGL_DRAWBOX)                                           Draws a rectangle based on character terminal coordinates in the current open window.
  [FGL_DRAWLINE()](#BF_FGL_DRAWLINE)                                         Draws a line based on character terminal coordinates in the current open window.
  [FGL_GETCURSOR()](#BF_FGL_GETCURSOR)                                       Returns the position of the edit cursor in the current field.
  [FGL_GETENV()](#BF_FGL_GETENV)                                             Returns the value of the environment variable having the name you specify as argument.
  [FGL_GETFILE()](#BF_FGL_GETFILE)                                           Transfers a file from the front-end to the application server machine.
  [FGL_GETHELP( )](#BF_FGL_GETHELP)                                          Returns the help message according to a number.
  [FGL_GETKEY()](#BF_FGL_GETKEY)                                             In TUI mode, waits for a keystroke and returns corresponding key number.
  [FGL_GETKEYLABEL()](#BF_FGL_GETKEYLABEL)                                   Returns the default label associated to a key.
  [FGL_GETPID( )](#BF_FGL_GETPID)                                            Returns the system process id.
  [FGL_GETRESOURCE( )](#BF_FGL_GETRESOURCE)                                  Returns the value of an [FGLPROFILE](FglProfile.html) entry.
  [FGL_GETVERSION( )](#BF_FGL_GETVERSION)                                    Returns the build number of the runtime system.
  [FGL_GETWIN_HEIGHT()](#BF_FGL_GETWIN_HEIGHT)                               Returns the number of rows of the [current window](WindowsAndForms.html).
  [FGL_GETWIN_WIDTH()](#BF_FGL_GETWIN_WIDTH)                                 Returns the width of the [current window](WindowsAndForms.html) as a number of columns.
  [FGL_GETWIN_X()](#BF_FGL_GETWIN_X)                                         Returns the horizontal position of the [current window](WindowsAndForms.html).
  [FGL_GETWIN_Y()](#BF_FGL_GETWIN_Y)                                         Returns the vertical position of the [current window](WindowsAndForms.html).
  [FGL_KEYVAL()](#BF_FGL_KEYVAL)                                             Returns the key code of a logical or physical key.
  [FGL_LASTKEY()](#BF_FGL_LASTKEY)                                           Returns the [key code](#KEYCODES) of the last key pressed by the user.
  [FGL_PUTFILE()](#BF_FGL_PUTFILE)                                           Transfers a file from from the application server machine to the front-end.
  [FGL_REPORT_PRINT_BINARY_FILE()](#BF_FGL_REPORT_PRINT_BINARY_FILE)         Prints a file containing binary data during a [report](Reports.html).
  [FGL_REPORT_SET_DOCUMENT_HANDLER()](#BF_FGL_REPORT_SET_DOCUMENT_HANDLER)   Defines the document handler to be used for a [report](Reports.html).
  [FGL_SET_ARR_CURR()](#BF_FGL_SET_ARR_CURR)                                 Sets the current line in a record list.
  [FGL_SETENV()](#BF_FGL_SETENV)                                             Sets an environment variable
  [FGL_SETKEYLABEL()](#BF_FGL_SETKEYLABEL)                                   Sets the default label associated to a key.
  [FGL_SETSIZE()](#BF_FGL_SETSIZE)                                           Sets the size of the main application window.
  [FGL_SETTITLE()](#BF_FGL_SETTITLE)                                         Sets the title of the main application window.
  [FGL_SYSTEM()](#BF_FGL_SYSTEM)                                             Executes a command in the application server.
  [FGL_WIDTH()](#BF_FGL_WIDTH)                                               Returns the number of columns needed to represent the string.
  [FGL_WINDOW_GETOPTION()](#BF_FGL_WINDOW_GETOPTION)                         Returns the attributes of the [current window](WindowsAndForms.html).
  [LENGTH()](#BF_LENGTH)                                                     Returns the number of characters of the string passed as a parameter.
  [NUM_ARGS()](#BF_NUM_ARGS)                                                 Returns the number of program arguments.
  [SCR_LINE()](#BF_SCR_LINE)                                                 Returns the number of the current screen record in its [screen array](FormSpecFiles.html#SECTION_INSTRUCTIONS).
  [SET_COUNT()](#BF_SET_COUNT)                                               Specifies the number of records that contain data in a [static array](Arrays.html).
  [SHOWHELP()](#BF_SHOWHELP)                                                 Displays a runtime help message, corresponding to its specified argument, from the current help file.
  [STARTLOG()](#BF_STARTLOG)                                                 Initializes error logging and opens the error log file passed as a parameter.
  [UPSHIFT()](#BF_UPSHIFT)                                                   Returns a string value in which all lowercase characters in its argument are converted to uppercase.
                                                                             
  -------------------------------------------------------------------------- -------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------

### [List of de-supported built-in functions:]{#DESUPLIST}

  ------------------------------ -------------------------------------------------------------------------
  **Function**                   **Description**
  *FGL_FORMFIELD_GETOPTION()*    Returns attributes of a specified form field.
  *FGL_GETUITYPE()*              Returns the type of the front end.
  *FGL_SCR_SIZE( )*              Returns the number of rows of a screen array of the current form.
  *FGL_WINDOW_OPEN( )*           Opens a new window with coordinates and size.
  *FGL_WINDOW_OPENWITHFORM( )*   Opens a new window with coordinates and form.
  *FGL_WINDOW_CLEAR( )*          Clears the window having the name that is passed as a parameter.
  *FGL_WINDOW_CLOSE( )*          Closes the window having the name that is passed as a parameter.
  *FGL_WINDOW_CURRENT( )*        Makes current the window having the name that is passed as a parameter.
  ------------------------------ -------------------------------------------------------------------------

------------------------------------------------------------------------

### [ARG_VAL( )]{#BF_ARG_VAL}

#### Purpose:

This function returns a command line argument by position.

#### Context:

1.  At any place in the program.

#### Syntax:

`CALL ARG_VAL( `*`position`*` INTEGER ) RETURNING `*`result`*` STRING`

#### Notes:

1.  *position* is the argument position. 0 returns the name of the
    program, 1 returns the first argument.

#### Usage:

This function provides a mechanism for passing values to the program
through the command line that invokes the program. You can design a
program to expect or allow arguments after the name of the program in
the command line.

Like all built-in functions, `ARG_VAL()` can be invoked from any program
block. You can use it to pass values to
[MAIN](Programs.html#MAIN_BLOCK), which cannot have formal arguments,
but you are not restricted to calling `ARG_VAL()` from the MAIN
statement. You can use the `ARG_VAL()` function to retrieve individual
arguments during program execution. You can also use the
[NUM_ARGS()](#BF_NUM_ARGS) function to determine how many arguments
follow the program name on the command line.

If *position* is greater than 0, `ARG_VAL(`*`position`*`)` returns the
command-line argument used at a given position. The value of *position*
must be between 0 and the value returned by [NUM_ARGS()](#BF_NUM_ARGS),
the number of command-line arguments. The expression `ARG_VAL(0)`
returns the name of the application program.

*See also:* [NUM_ARGS()](#BF_NUM_ARGS).

------------------------------------------------------------------------

### [NUM_ARGS( )]{#BF_NUM_ARGS}

#### Purpose:

This function returns the number of program arguments.

#### Context:

1.  At any place in the program.

#### Syntax:

`CALL NUM_ARGS( ) RETURNING `*`result`*` INTEGER`

#### Notes:

1.  returns 0 if no arguments are passed to the program.

*See also:* [ARG_VAL()](#BF_ARG_VAL).

------------------------------------------------------------------------

### [SCR_LINE( )]{#BF_SCR_LINE}

#### Purpose:

This function returns the number of the current screen record in its
[screen array](FormSpecFiles.html#SECTION_INSTRUCTIONS). 

#### Context:

1.  During a [DISPLAY ARRAY](DisplayArray.html) or [INPUT
    ARRAY](InputArray.html) statement.

#### Syntax:

`CALL SCR_LINE( ) RETURNING `*`result`*` INTEGER`

#### Notes:

1.  The current record is the line of a screen array that is highlighted
    at the beginning of a `BEFORE ROW` or `AFTER ROW` clause.

#### Warnings:

1.  When using new graphical objects such as
    [TABLEs](FormSpecFiles.html#FF_CONTAINER_TABLE), this function can
    return an invalid screen array line number, because the current row
    may not be visible if the user scrolls in the list with scrollbars. 

*See also:* [ARR_CURR()](#BF_ARR_CURR).

------------------------------------------------------------------------

### [SET_COUNT( )]{#BF_SET_COUNT}

#### Purpose:

This function specifies the number of rows containing explicit data in a
[static array](Arrays.html) used by the next dialog.

#### Context:

1.  Before a [DISPLAY ARRAY](DisplayArray.html) or [INPUT
    ARRAY](InputArray.html) statement.

#### Syntax:

`CALL SET_COUNT( `*`nbrows`*` INTEGER )`

#### Notes:

1.  *nbrows* defines the number of explicit rows in the [static
    array](Arrays.html).

#### Usage:

When using a [static array](Arrays.html) in an [INPUT
ARRAY](InputArray.html) (with `WITHOUT DEFAULTS` clause) or a [DISPLAY
ARRAY](DisplayArray.html) statement, you must specify the number of rows
in the array which contain explicit data. In typical applications, these
array elements contain the values retrieved from a `SELECT` statement
controlled by a [database cursor](ResultSets.html).

Note that you can specify the number of rows with the `SET_COUNT()`
function or with the `COUNT` attribute of [INPUT ARRAY](InputArray.html)
and [DISPLAY ARRAY](DisplayArray.html) statements.

**Warning: You do not have to specify the number of rows when using a
[dynamic array](Arrays.html). When using a dynamic array, the number of
rows is defined by the getLength() method of the array object.**

*See also:* [ARR_CURR()](#BF_ARR_CURR),
[FGL_SET_ARR_CURR()](#BF_FGL_SET_ARR_CURR). 

------------------------------------------------------------------------

### [ARR_COUNT( )]{#BF_ARR_COUNT}

#### Purpose:

This function returns the number of records entered in a program array
during or after execution of the [INPUT ARRAY](InputArray.html)
statement.

#### Context:

1.  Can be called at any place in the program, but should be limited to
    usage inside or after [INPUT ARRAY](InputArray.html) or [DISPLAY
    ARRAY](DisplayArray.html) blocks.

#### Syntax:

`CALL ARR_COUNT( ) RETURNING `*`result`*` INTEGER`

#### Notes:

1.  Returns the current number of records that exist in the current
    array.
2.  Typically used inside [INPUT ARRAY](InputArray.html) blocks, can
    also be called in [DISPLAY ARRAY](DisplayArray.html).

#### Usage:

You can use `ARR_COUNT()` to determine the number of program records
that are currently stored in a program array. In typical Genero BDL
applications, these records correspond to values from the [result
set](ResultSets.html) of retrieved database rows from the most recent
query. By first calling the [SET_COUNT()](#BF_SET_COUNT) function or by
using the `COUNT` attribute of [INPUT ARRAY](InputArray.html), you can
set an upper limit on the value that `ARR_COUNT()` returns.

`ARR_COUNT()` returns a positive integer, corresponding to the index of
the furthest record within the program array that the user accessed. Not
all the rows *counted* by `ARR_COUNT()` necessarily contain data (for
example, if the user presses the DOWN ARROW key more times than there
are rows of data).

*See also:* [INPUT ARRAY](InputArray.html), [DISPLAY
ARRAY](DisplayArray.html), [ARR_CURR()](#BF_ARR_CURR). 

------------------------------------------------------------------------

### [ARR_CURR( )]{#BF_ARR_CURR}

#### Purpose:

This function returns the current row in a [DISPLAY
ARRAY](DisplayArray.html) or [INPUT ARRAY](InputArray.html).

#### Context:

1.  During a [DISPLAY ARRAY](DisplayArray.html) or [INPUT
    ARRAY](InputArray.html) statement.

#### Syntax:

`CALL ARR_CURR( ) RETURNING `*`result`*` INTEGER`

#### Usage:

The `ARR_CURR()` function returns an integer value that identifies the
current row of a list of rows in a [INPUT ARRAY](InputArray.html) or
[DISPLAY ARRAY](DisplayArray.html) instruction. The first row is
numbered 1.

You can pass `ARR_CURR()` as an argument when you call a function. In
this way the function receives as its argument the current record of
whatever array is referenced in the [INPUT ARRAY](InputArray.html) or
[DISPLAY ARRAY](DisplayArray.html) statement.

The `ARR_CURR()` function can be used to force a
[FOR](FlowControl.html#FC_FOR) loop to begin beyond the first line of an
array by setting a variable to `ARR_CURR()` and using that variable as
the starting value for the [FOR](FlowControl.html#FC_FOR) loop.

The built-in functions `ARR_CURR()` and [SCR_LINE()](#BF_SCR_LINE) can
return different values if the program array is larger than the screen
array.

*See also:* [INPUT ARRAY](InputArray.html), [DISPLAY
ARRAY](DisplayArray.html), [ARR_COUNT()](#BF_ARR_COUNT),
[FGL_SET_ARR_CURR()](#BF_FGL_SET_ARR_CURR), [SCR_LINE()](#BF_SCR_LINE),
[DIALOG.getCurrentRow()](ClassDialog.html#getCurrentRow). 

------------------------------------------------------------------------

### [ERR_GET( )]{#BF_ERR_GET}

#### Purpose:

This function returns the text corresponding to an [error
number](FglErrors.html).

#### Context:

1.  At any place in the program.

#### Syntax:

`CALL ERR_GET( `*`error-number`*` INTEGER ) RETURNING `*`result`*` STRING`

#### Notes:

1.  *error-number* is a [runtime error](FglErrors.html) or an Informix
    SQL error.
2.  For development only.

**Warning: Informix SQL error numbers can only be supported if the
program is connected to an Informix database.**

*See also:* [ERRORLOG()](#BF_ERRORLOG), [STARTLOG()](#BF_STARTLOG),
[ERR_QUIT()](#BF_ERR_QUIT), [ERR_PRINT()](#BF_ERR_PRINT),
[Exceptions](Exceptions.html).

------------------------------------------------------------------------

### [ERR_PRINT( )]{#BF_ERR_PRINT}

#### Purpose:

This function prints in the [error line](MessageDisplay.html#ERROR) the
text corresponding to an [error number](FglErrors.html).

#### Context:

1.  At any place in the program.

#### Syntax:

`CALL ERR_PRINT( `*`error-number`*` INTEGER )`

#### Notes:

1.  *error-number* is a [runtime error](FglErrors.html) or an Informix
    SQL error.
2.  For development only.

**Warning: Informix SQL error numbers can only be supported if the
program is connected to an Informix database.**

*See also:* [ERRORLOG()](#BF_ERRORLOG), [STARTLOG()](#BF_STARTLOG),
[ERR_QUIT()](#BF_ERR_QUIT), [ERR_GET()](#BF_ERR_GET),
[Exceptions](Exceptions.html).

------------------------------------------------------------------------

### [ERR_QUIT( )]{#BF_ERR_QUIT}

#### Purpose:

This function prints in the [error line](MessageDisplay.html#ERROR) the
text corresponding to an [error number](FglErrors.html) and terminates
the program.

#### Context:

1.  At any place in the program.

#### Syntax:

`CALL ERR_QUIT( `*`error-number`*` INTEGER )`

#### Notes:

1.  *error-number* is a [runtime error](FglErrors.html) or an Informix
    SQL error.
2.  For development only.

**Warning: Informix SQL error numbers can only be supported if the
program is connected to an Informix database.**

*See also:* [ERRORLOG()](#BF_ERRORLOG), [STARTLOG()](#BF_STARTLOG),
[ERR_QUIT()](#BF_ERR_QUIT), [ERR_GET()](#BF_ERR_GET),
[Exceptions](Exceptions.html).

------------------------------------------------------------------------

### [ERRORLOG( )]{#BF_ERRORLOG}

#### Purpose:

This function copies the string passed as parameter into the [error log
file](#BF_STARTLOG).

#### Context:

1.  At any place in the program.

#### Syntax:

`CALL ERRORLOG( `*`text`*` STRING )`

#### Notes:

1.  *text* is the character string to be inserted in the error log file.
2.  The error log must be started with [STARTLOG()](#BF_STARTLOG).

*See also:* [STARTLOG()](#BF_STARTLOG), [Exceptions](Exceptions.html).

------------------------------------------------------------------------

### [SHOWHELP( )]{#BF_SHOWHELP}

#### Purpose:

This function function displays a runtime help message, corresponding to
its specified argument, from the current help file.

#### Context:

1.  At any place in the program.

#### Syntax:

`CALL SHOWHELP( `*`help-number`*` INTEGER )`

#### Notes:

1.  *help-number* is the help message number in the current help file.
2.  You set the current help file with the `HELP FILE` clause of the
    [OPTIONS](Programs.html) instruction.

*See also:* [OPTIONS](Programs.html), [Message
Files](MessageFiles.html).

------------------------------------------------------------------------

### [STARTLOG( )]{#BF_STARTLOG}

#### Purpose:

This function initializes error logging and opens the error log file
passed as the parameter.

#### Context:

1.  At the beginning of the program.

#### Syntax:

`CALL STARTLOG( `*`filename`*` STRING )`

#### Notes:

1.  *filename* is the name of the error log file.
2.  Runtime errors are automatically reported.
3.  You can insert error records manually with the
    [ERRORLOG()](#BF_ERRORLOG) function.

#### Usage:

Call `STARTLOG()` in the [MAIN](Programs.html#MAIN_BLOCK) program block
to open or create an error log file. After `STARTLOG()` has been
invoked, a record of every subsequent error that occurs during the
execution of your program is written in the error log file. If you need
to report specific application errors, use the
[ERRORLOG()](#BF_ERRORLOG) function to make an entry in the error log
file.

The default format of an error record consists of the date, time,
source-module name and line number, error number, and error message. If
you invoke the `STARTLOG()` function, the format of the error records
appended to the error log file after each subsequent error are as
follows:

    Date: 03/06/99 Time: 12:20:20
    Program error at "stock_one.4gl", line number 89.
    SQL statement error number -239.
    Could not insert new row - duplicate value in a UNIQUE INDEX column.
    SYSTEM error number -100
    ISAM error: duplicate value for a record with unique key.

The `STARTLOG()` and [ERRORLOG()](#BF_ERRORLOG) functions can be used
for *instrumenting* a program, to track how the program is used. This
use is not only valuable for improving the program but also for
recording work habits and detecting attempts to breach security.

If the argument of `STARTLOG()` is not the name of an existing file,
`STARTLOG()` creates one. If the file already exists, `STARTLOG()` opens
it and positions the file pointer so that subsequent error messages can
be appended to this file. The following program fragment invokes
`STARTLOG()`, specifying the name of the error log file in a quoted
string that includes a pathname and a file extension. The function
definition includes a call to the built-in [ERRORLOG()](#BF_ERRORLOG)
function, which adds a message to the error log file:

``` linenumber
01   CALL STARTLOG("/var/myapp/logs/error-" || fgl_getpid() || ".log")
02   ...
03   CALL ERRORLOG("The current user is not allowed to perform order validation")
```

*See also:* [ERRORLOG()](#BF_ERRORLOG), [Exceptions](Exceptions.html).

------------------------------------------------------------------------

### [FGL_BUFFERTOUCHED( )]{#BF_FGL_BUFFERTOUCHED}

#### Purpose:

This function returns [TRUE](Programs.html#PC_TRUE) if the input buffer
was modified after the current field was selected.

#### Context:

1.  In `AFTER FIELD`, `AFTER INPUT`, `AFTER CONSTRUCT`, `ON KEY`,
    `ON ACTION` blocks.

#### Syntax:

`CALL FGL_BUFFERTOUCHED( ) RETURNING `*`result`*` INTEGER`

#### Notes:

1.  returns [TRUE](Programs.html#PC_TRUE) if the input buffer has been
    touched after the current field was selected.

**Warning: This function [is not]{.underline} equivalent to
[FIELD_TOUCHED()](Operators.html#OP_FIELD_TOUCHED): The flag returned by
`FGL_BUFFERTOUCHED()` is reset when you enter a new field, while
`FIELD_TOUCHED()` returns always [TRUE](Programs.html#PC_TRUE) for a
field that was modified during the interactive instruction.**

*See also:* [FGL_DIALOG_SETBUFFER()](#BF_FGL_DIALOG_SETBUFFER),
[FGL_DIALOG_GETBUFFER()](#BF_FGL_DIALOG_GETBUFFER).

------------------------------------------------------------------------

### [FGL_DB_DRIVER_TYPE( )]{#BF_FGL_DB_DRIVER_TYPE}

#### Purpose:

Returns the 3-letter identifier/code of the current database driver.

#### Syntax:

`CALL FGL_DB_DRIVER_TYPE( ) RETURNING `*`type`*` CHAR(3)`

#### Usage:

This function can be called after connecting to a database server with
the `CONNECT` or `DATABASE` instructions, in order to identify the type
of the target database with the driver type. Returned value is the
3-letter driver code. See
[Connections](Connections.html#DS_ODI_CP_DRIVER) page for more details
about the list of database driver codes.

The function returns [NULL](Programs.html#PC_NULL) if there is no
current database driver (i.e. if database connection is not yet
established).

------------------------------------------------------------------------

### [FGL_DECIMAL_TRUNCATE( )]{#BF_FGL_DECIMAL_TRUNCATE}

#### Purpose:

Returns a decimal truncated to the precision passed as parameter.

#### Syntax:

`CALL FGL_DECIMAL_TRUNCATE( `*`value`*` DECIMAL, `*`decimals`*` INTEGER ) RETURNING `*`result`*` DECIMAL`

#### Notes:

1.  *value* is the decimal to be converted.
2.  *decimals* defines the number of digits after the decimal point.

#### Usage:

This function truncates the decimal to the number of decimal digits
specified. The value is not rounded, it is just truncated. For example,
when truncating 12.345 to 2 decimal digits, the result will be 12.34,
not 12.35.

------------------------------------------------------------------------

### [FGL_DECIMAL_SQRT( )]{#BF_FGL_DECIMAL_SQRT}

#### Purpose:

Computes the square root of the decimal passed as parameter.

#### Syntax:

`CALL FGL_DECIMAL_SQRT( `*`value`*` DECIMAL ) RETURNING `*`result`*` DECIMAL`

#### Notes:

1.  *value* is the decimal to be computed.

------------------------------------------------------------------------

### [FGL_DECIMAL_EXP( )]{#BF_FGL_DECIMAL_EXP}

#### Purpose:

Returns the value of Euler\'s constant (e) raised to the power of the
decimal passed as parameter.

#### Syntax:

`CALL FGL_DECIMAL_EXP( `*`value`*` DECIMAL ) RETURNING `*`result`*` DECIMAL`

#### Notes:

1.  *value* is the decimal to be computed.

------------------------------------------------------------------------

### [FGL_DECIMAL_LOGN( )]{#BF_FGL_DECIMAL_LOGN}

#### Purpose:

Returns the natural logarithm of the decimal passed as parameter.

#### Syntax:

`CALL FGL_DECIMAL_LOGN( `*`value`*` DECIMAL ) RETURNING `*`result`*` DECIMAL`

#### Notes:

1.  *value* is the decimal to be computed.

------------------------------------------------------------------------

### [FGL_DECIMAL_POWER( )]{#BF_FGL_DECIMAL_POWER}

#### Purpose:

Raises decimal to the power of the real exponent.

#### Syntax:

`CALL FGL_DECIMAL_POWER( `*`base`*` DECIMAL, `*`exp`*` DECIMAL ) RETURNING `*`result`*` DECIMAL`

#### Notes:

1.  *base* is the decimal to be raise to the power of *exp*.
2.  *exp* is the exponent.

#### Usage:

Unlike the \*\* operator, the FGL_DECIMAL_POWER() supports real numbers
for the exponent.

------------------------------------------------------------------------

### [FGL_DIALOG_GETBUFFER( )]{#BF_FGL_DIALOG_GETBUFFER}

#### Purpose:

This function returns the value of the current field as a string.

#### Context:

1.  In [INPUT](RecordInput.html) , [INPUT ARRAY](InputArray.html),
    [CONSTRUCT](Construct.html) instructions.

#### Syntax:

`CALL FGL_DIALOG_GETBUFFER( ) RETURNING `*`result`*` STRING`

#### Notes:

1.  Returns the content of the input buffer of the current field.
2.  Only useful in a [CONSTRUCT](Construct.html) instruction, because
    there is no variable associated to fields in this case.

*See also:* [FGL_DIALOG_SETBUFFER()](#BF_FGL_DIALOG_SETBUFFER),
[FGL_BUFFERTOUCHED()](#BF_FGL_BUFFERTOUCHED),
[GET_FLDBUF()](Operators.html#OP_GET_FLDBUF).

------------------------------------------------------------------------

### [FGL_DIALOG_SETBUFFER( )]{#BF_FGL_DIALOG_SETBUFFER}

#### Purpose:

This function sets the input buffer of the current field, and assigns
corresponding program variable when using `UNBUFFERED` mode.

#### Context:

1.  In [INPUT](RecordInput.html) , [INPUT ARRAY](InputArray.html),
    [CONSTRUCT](Construct.html) instructions.

#### Syntax:

`CALL FGL_DIALOG_SETBUFFER( `*`value`*` STRING )`

#### Notes:

1.  *value* is the text to set in the current input buffer.
2.  Only useful in a [CONSTRUCT](Construct.html) instruction, because
    there is no variable associated to fields in this case.

#### Usage:

With the default *buffered* input mode, this function modifies the input
buffer of the current field; the [corresponding input
variable](RecordInput.html) is not assigned. It makes no sense to call
this function in `BEFORE FIELD` blocks of `INPUT` and `INPUT ARRAY`.
However, if the statement is using the `UNBUFFERED` mode, the function
will set both the field buffer and the program variable. If the string
set by the function does not represent a valid value that can be stored
by the program variable, the buffer and the variable will be set to
[NULL](Programs.html#PC_NULL).

**Warning: This function sets the \'touched\' flag of the current form
field, and the \'touched\' flag of the dialog. Therefore, both
[FIELD_TOUCHED()](Operators.html#OP_FIELD_TOUCHED) and
[FGL_BUFFERTOUCHED()](#BF_FGL_BUFFERTOUCHED) would return
[TRUE](Programs.html#PC_TRUE) if you call this function.**

*See also:* [FGL_DIALOG_GETBUFFER()](#BF_FGL_DIALOG_GETBUFFER),
[FGL_BUFFERTOUCHED()](#BF_FGL_BUFFERTOUCHED),
[GET_FLDBUF()](Operators.html#OP_GET_FLDBUF).

------------------------------------------------------------------------

### [FGL_DIALOG_GETFIELDNAME( )]{#BF_FGL_DIALOG_GETFIELDNAME}

#### Purpose:

This function returns the name of the current input field.

#### Context:

1.  In [INPUT](RecordInput.html) , [INPUT ARRAY](InputArray.html) or
    [CONSTRUCT](Construct.html) instructions.

#### Syntax:

`CALL FGL_DIALOG_GETFIELDNAME( ) RETURNING `*`result`*` STRING`

#### Notes:

1.  Returns the name of the current input field.

**Warning: Only the column part of the field name is returned.**

*See also:* [FGL_DIALOG_INFIELD()](#BF_FGL_DIALOG_INFIELD).

------------------------------------------------------------------------

### [FGL_DIALOG_INFIELD( )]{#BF_FGL_DIALOG_INFIELD}

#### Purpose:

This function returns [TRUE](Programs.html#PC_TRUE) if the field passed
as the parameter is the current input field.

#### Context:

1.  In [INPUT](RecordInput.html) , [INPUT ARRAY](InputArray.html) or
    [CONSTRUCT](Construct.html) instructions.

#### Syntax:

`CALL FGL_DIALOG_INFIELD( `*`field-name`*` STRING ) RETURNING `*`result`*` INTEGER`

#### Notes:

1.  *field-name* is the name if the [form field](FormSpecFiles.html).

**Warning: Only the column part of the field name is returned.**

*See also:* [INFIELD()](Operators.html#OP_INFIELD). 

------------------------------------------------------------------------

### [FGL_DIALOG_SETCURSOR( )]{#BF_FGL_DIALOG_SETCURSOR}

#### Purpose:

This function sets the position of the input cursor in the current
field.

#### Context:

1.  In interactive instructions control blocks, when staying in the
    current field.

#### Syntax:

`CALL FGL_DIALOG_SETCURSOR( `*`index`*` INTEGER )`

#### Notes:

1.  *index* is the character position in the text.

#### Usage:

This function has only an effect when staying in the current field, it
should not be called in an `AFTER FIELD` or `AFTER ROW` for example.
Note that you can also use
[FGL_DIALOG_SETSELECTION()](#BF_FGL_DIALOG_SETSELECTION) to select a
piece of text in a field.

*See also:* [FGL_GETCURSOR()](#BF_FGL_GETCURSOR),
[FGL_DIALOG_SETSELECTION()](#BF_FGL_DIALOG_SETSELECTION).

------------------------------------------------------------------------

### [FGL_DIALOG_SETFIELDORDER( )]{#BF_FGL_DIALOG_SETFIELDORDER}

#### Purpose:

This function enables or disables field order constraint.

#### Context:

1.  At the beginning of the program or around [INPUT](RecordInput.html)
    instructions.

#### Syntax:

`CALL FGL_DIALOG_SETFIELDORDER( `*`active`*` INTEGER )`

#### Notes:

1.  When *active* is [TRUE](Programs.html#PC_TRUE), the field order is
    constrained.
2.  When *active* is [FALSE](Programs.html#PC_FALSE), the field order is
    not constrained.

#### Usage:

Typical BDL applications control user input with `BEFORE FIELD` and
`AFTER FIELD` blocks. In many cases the field order and  the sequential
execution of `AFTER FIELD` blocks is important in order to validate the
data entered by the user. But with graphical front ends you can use the
mouse to move to a field. By default the runtime system executes all
`BEFORE FIELD` and `AFTER FIELD` blocks of the fields used by the
interactive instruction, from the origin field to the target field
selected by mouse click. If needed, you can force the runtime system to
ignore all intermediate field triggers, by calling this function with a
[FALSE](Programs.html#PC_FALSE) attribute.

------------------------------------------------------------------------

### [FGL_DIALOG_SETCURRLINE( )]{#BF_FGL_DIALOG_SETCURRLINE}

#### Purpose:

This function moves to a specific row in a record list.

#### Context:

1.  During a [DISPLAY ARRAY](DisplayArray.html) or [INPUT
    ARRAY](InputArray.html) instruction, inside `BEFORE DISPLAY` /
    `BEFORE INPUT` or `ON ACTION` / `ON KEY` blocks only.

#### Syntax:

`CALL FGL_DIALOG_SETCURRLINE( `*`line`*` INTEGER, `*`row`*` INTEGER )`

#### Notes:

1.  *line* is the line number in the [screen array](FormSpecFiles.html).
2.  *row* is the row number is the [array variable](Arrays.html).

#### Usage:

Moves to the row / screen line specified. See
[FGL_SET_ARR_CURR()](#BF_FGL_SET_ARR_CURR) for more details.

**Warning: The *line* parameter is ignored in
[GUI](FglTerms.html#GRAPHICAL_USER_INTERFACE) mode.**

------------------------------------------------------------------------

### [FGL_SET_ARR_CURR( )]{#BF_FGL_SET_ARR_CURR}

#### Purpose:

This function moves to a specific row in a record list.

#### Context:

1.  During a [DISPLAY ARRAY](DisplayArray.html) or [INPUT
    ARRAY](InputArray.html) instruction, inside `BEFORE DISPLAY` /
    `BEFORE INPUT` or `ON ACTION` / `ON KEY` blocks only.

#### Syntax:

`CALL FGL_SET_ARR_CURR( `*`row`*` INTEGER )`

#### Notes:

1.  *row* is the row number is the [array variable](Arrays.html).

#### Usage:

This function is typically used to control navigation in a
`DISPLAY ARRAY` or `INPUT ARRAY`, within an `ON ACTION` or `ON KEY`
block. The function can also be used inside `BEFORE DISPLAY` or
`BEFORE INPUT` blocks, to jump to a specific row when the dialog starts.
You should not use this function in an other context.

**Warning: Control blocks like `BEFORE ROW` and field/row validation in
`INPUT ARRAY` are performed, as if the user moved to another row, except
when the function is called in `BEFORE DISPLAY` or `BEFORE INPUT`.**

When a new row is reached by using with this function, the first
editable field gets the focus.

------------------------------------------------------------------------

### [FGL_SETENV( )]{#BF_FGL_SETENV}

#### Purpose:

This function sets the value of an environment variable.

#### Context:

1.  At any place in the program.

#### Syntax:

`CALL FGL_SETENV( `*`variable`*` STRING, `*`value`*` STRING )`

#### Notes:

1.  *variable* is the name of the environment variable.
2.  *value* is the value to be set.

**Warning: Use this function at your own risk: You may experience
unexpected results if you change environment variables that are already
used by the current program - for example, when you are connected to
INFORMIX and you change the INFORMIXDIR environment variable.**

There is a little difference between Windows and UNIX platforms when
passing a [NULL](Programs.html#PC_NULL) as the *value* parameter: On
Windows, the environment variable is removed, while on UNIX, the
environment variable gets an empty value (i.e. it is not removed from
the environment).

*See also:* [FGL_GETENV()](#BF_FGL_GETENV)

------------------------------------------------------------------------

### [FGL_DRAWBOX( )]{#BF_FGL_DRAWBOX}

#### Purpose:

This function draws a rectangle based on the character terminal
coordinates in the current open window.

#### Context:

1.  At any place in the program.

#### Syntax:

`CALL FGL_DRAWBOX( `*`height`*`, `*`width`*`, `*`line`*`, `*`column`*`, `*`color`*` INTEGER )`

**Warning: This function is provided for backward compatibility.**

*See also:* [FGL_DRAWLINE()](#BF_FGL_DRAWLINE). 

------------------------------------------------------------------------

### [FGL_DRAWLINE( )]{#BF_FGL_DRAWLINE}

#### Purpose:

This function draws a line based on the character terminal coordinates
in the current open window.

#### Context:

1.  At any place in the program.

#### Syntax:

`CALL FGL_DRAWLINE( `*`posX, posY`*`, `*`width`*`, `*`color`*` INTEGER )`

**Warning: This function is provided for backward compatibility.**

*See also:* [FGL_DRAWBOX()](#BF_FGL_DRAWBOX). 

------------------------------------------------------------------------

### [FGL_LASTKEY( )]{#BF_FGL_LASTKEY}

#### Purpose:

This function returns the [key code](#KEYCODES) corresponding to the
logical key that the user most recently typed in the form.

#### Context:

1.  Any interactive instruction.

#### Syntax:

`CALL FGL_LASTKEY( ) RETURNING `*`result`*` INTEGER`

#### Notes:

1.  The function returns NULL if no key has been pressed.

#### Usage:

The `FGL_LASTKEY()` function returns a numeric code corresponding to the
user\'s last keystroke before the function was called. For example, if
the last key that the user pressed was a lowercase *s*, the function
returns the code 115 (i.e. the ASCII character set code).

Note that the value of `FGL_LASTKEY()` is undefined in a
[MENU](Menus.html) statement.

It is not required to know the specific key codes returned by
`FGL_LASTKEY()`: The [FGL_KEYVAL()](#BF_FGL_KEYVAL) function can be used
to compare the key code of the last key pressed. The FGL_KEYVAL()
function lets you compare the last key pressed with a logical of
physical key. For example, you do not need to know the physical key
defined to validate a dialog, you can use the logical name \"accept\"
instead. For a complete list of key codes and logical key names, see the
[Key code table](#KEYCODES).

**Warning: This function is provided for backward compatibility. The
Genero BDL Abstract User Interface protocol is based on logical events,
not only key events. For example, in GUI mode, when selecting a new row
with the mouse in a table, there is no key press as when moving in a
static screen array in TUI mode. However, Genero BDL tries to emulate as
much as possible keystrokes from non-keystroke events. **

*See also:* [FGL_KEYVAL()](#BF_FGL_KEYVAL), [key code](#KEYCODES).

------------------------------------------------------------------------

### [FGL_KEYVAL( )]{#BF_FGL_KEYVAL}

#### Purpose:

This function returns the [key code](#KEYCODES) of a logical or physical
key.

#### Context:

1.  At any place in the program.

#### Syntax:

`CALL FGL_KEYVAL( `*`string`*` STRING ) RETURNING `*`result`*` INTEGER`

#### Notes:

1.  *string* can be a single character, a digit, a printable symbol like
    @, #, \$ or a special keyword such as ACCEPT.

#### Usage:

`FGL_KEYVAL()` can be used in form-related statements to examine a value
returned by the [FGL_LASTKEY()](#BF_FGL_LASTKEY) and
[FGL_GETKEY()](#BF_FGL_GETKEY) functions.

Key names recognized by `FGL_KEYVAL()` are: `ACCEPT`, `HELP`, `NEXT`,
`RETURN`, `DELETE`, `INSERT`, `NEXTPAGE`, `RIGHT`, `DOWN`, `INTERRUPT`,
`PREVIOUS`, `TAB`, `ESC`, `ESCAPE`, `LEFT`, `PREVPAGE`, `UP`, `F1`
through `F64`, `CONTROL-`*`character`* (where *character* can be any
letter except A, D, H, I, J, L, M, R, or X )

The function returns NULL if the parameter does not correspond to a
valid key.

If you specify a single character, `FGL_KEYVAL()` considers the case. In
all other instances, the function ignores the case of its argument,
which can be uppercase or lowercase letters.

To determine whether the user has performed an action, such as inserting
a row, specify the logical name of the action (such as INSERT) rather
than the name of the physical key (such as F1). For example, the logical
name of the Accept action is ACCEPT, while the default physical key is
ESCAPE. To test if the key most recently pressed by the user corresponds
to the Accept action, specify `FGL_KEYVAL("ACCEPT")` rather than
`FGL_KEYVAL("ESCAPE")` or `FGL_KEYVAL("ESC")`. Otherwise, if a key other
than ESCAPE is set as the Accept key and the user presses that key,
`FGL_LASTKEY()` does not return a code equal to `FGL_KEYVAL("ESCAPE")`.

Note that the value returned by `FGL_LASTKEY()` is undefined in a MENU
statement.

**Warning: This function is provided for backward compatibility
especially for [TUI mode](FglTerms.html#TEXT_USER_INTERFACE)
applications. `FGL_KEYVAL()` is well supported in text mode, but this
function can only be emulated in GUI mode, because the front-ends
communicate with the runtime system with other events as keystrokes.**

*See also:* [FGL_LASTKEY()](#BF_FGL_LASTKEY),
[FGL_GETKEY()](#BF_FGL_GETKEY).

------------------------------------------------------------------------

### [FGL_REPORT_PRINT_BINARY_FILE( )]{#BF_FGL_REPORT_PRINT_BINARY_FILE}

#### Purpose:

This function prints a file containing binary data during a
[report](Reports.html).

#### Context:

1.  In a [REPORT](Reports.html) routine.

#### Syntax:

`CALL FGL_REPORT_PRINT_BINARY_FILE( `*`filename`*` STRING )`

#### Notes:

1.  *filename* is the name of the binary file.

**Warning: This function is provided for backward compatibility.**

------------------------------------------------------------------------

### [FGL_REPORT_SET_DOCUMENT_HANDLER( )]{#BF_FGL_REPORT_SET_DOCUMENT_HANDLER}

#### Purpose:

This function redirects the next [report](Reports.html) to an XML
document handler.

#### Context:

1.  Before / After the execution of a [REPORT](Reports.html).

#### Syntax:

`CALL FGL_REPORT_SET_DOCUMENT_HANDLER( `*`handler`*` om.SaxDocumentHandler )`

#### Notes:

1.  *handler* is the [document handler](ClassSaxDocumentHandler.html)
    variable.

**Warning: You should use the `TO XML HANDLER` of
` `[`START REPORT`](Reports.html#RPT_XML).**

------------------------------------------------------------------------

### [FGL_DIALOG_GETCURSOR( )]{#BF_FGL_GETCURSOR} / FGL_GETCURSOR()

#### Purpose:

This function returns the position of the edit cursor in the current
field.

#### Context:

1.  In interactive instructions.

#### Syntax:

`CALL FGL_DIALOG_GETCURSOR( ) RETURNING `*`index`*` INTEGER`

#### Notes:

1.  *index* is the character position in the text.

#### Usage:

The FGL_DIALOG_GETCURSOR() function can be used in conjunction with
[FGL_DIALOG_GETSELECTIONEND()](#BF_FGL_DIALOG_GETSELECTIONEND) to get
the position of the edit cursor and the piece of text that is selected
in the current field.

*See also:*
[FGL_DIALOG_GETSELECTIONEND()](#BF_FGL_DIALOG_GETSELECTIONEND),
[FGL_DIALOG_SETCURSOR()](#BF_FGL_DIALOG_SETCURSOR),
[FGL_DIALOG_SETSELECTION()](#BF_FGL_DIALOG_SETSELECTION)

------------------------------------------------------------------------

### [FGL_GETWIN_HEIGHT( )]{#BF_FGL_GETWIN_HEIGHT}

#### Purpose:

This function returns the number of rows of the [current
window](WindowsAndForms.html).

#### Context:

1.  At any place in the program.

#### Syntax:

`CALL FGL_GETWIN_HEIGHT( ) RETURNING `*`result`*` INTEGER`

**Warning: This function is provided for backward compatibility.**

*See also:* [FGL_GETWIN_WIDTH()](#BF_FGL_GETWIN_WIDTH).

------------------------------------------------------------------------

### [FGL_GETWIN_WIDTH( )]{#BF_FGL_GETWIN_WIDTH}

#### Purpose:

This function returns the width of the [current
window](WindowsAndForms.html) as a number of columns.

#### Context:

1.  At any place in the program.

#### Syntax:

`CALL FGL_GETWIN_WIDTH( ) RETURNING `*`result`*` INTEGER`

**Warning: This function is provided for backward compatibility.**

*See also:* [FGL_GETWIN_WIDTH()](#BF_FGL_GETWIN_WIDTH).

------------------------------------------------------------------------

### [FGL_GETWIN_X( )]{#BF_FGL_GETWIN_X}

#### Purpose:

This function returns the horizontal position of the [current
window](WindowsAndForms.html).

#### Context:

1.  At any place in the program.

#### Syntax:

`CALL FGL_GETWIN_X( ) RETURNING `*`result`*` INTEGER`

**Warning: This function is provided for backward compatibility.**

*See also:* [FGL_GETWIN_Y()](#BF_FGL_GETWIN_Y).

------------------------------------------------------------------------

### [FGL_GETWIN_Y( )]{#BF_FGL_GETWIN_Y}

#### Purpose:

This function returns the vertical position of the [current
window](WindowsAndForms.html).

#### Context:

1.  At any place in the program.

#### Syntax:

`CALL FGL_GETWIN_X( ) RETURNING `*`result`*` INTEGER`

**Warning: This function is provided for backward compatibility.**

*See also:* [FGL_GETWIN_X()](#BF_FGL_GETWIN_X).

------------------------------------------------------------------------

### [LENGTH( )]{#BF_LENGTH}

#### Purpose:

This function returns the number of bytes of the expression passed as
parameter.

#### Context:

1.  At any place in the program.

#### Syntax:

`CALL LENGTH( `*`expression`*` ) RETURNING `*`result`*` INTEGER`

#### Notes:

1.  *expression* is any valid [expression](Expressions.html).

#### Usage:

The LENGTH() function counts the number of bytes of a string.

**Warning: The function counts bytes, not characters. This is important
in a multi-byte environment.**

Note that most database servers support an equivalent scalar function in
the SQL language, but the result may be different from the Genero BDL
built-in function. For example, Oracle\'s LENGTH() function returns NULL
when the string is empty. 

Trailing blanks are not counted in the length of the string.

If the parameter is [NULL](Programs.html#PC_NULL), the function returns
zero.

*See also:* [FGL_WIDTH()](#BF_FGL_WIDTH).

------------------------------------------------------------------------

### [FGL_GETVERSION( )]{#BF_FGL_GETVERSION}

#### Purpose:

This function returns the build number of the runtime system.

#### Context:

1.  At any place in the program.

#### Syntax:

`CALL FGL_GETVERSION( ) RETURNING `*`result`*` STRING`

**Warning: The is provided for debugging info only; please do not write
business code dependent on the build number. The format of the build
number returned by this function is subject of change in future
versions.**

------------------------------------------------------------------------

### [FGL_GETHELP( )]{#BF_FGL_GETHELP}

#### Purpose:

Returns the help text according to its identifier by reading the current
help file.

#### Context:

1.  At any place in the program, after the definition of the current
    help file (OPTIONS HELP FILE).

#### Syntax:

`CALL FGL_GETHELP( `*`id`*` INTEGER ) RETURNING `*`result`*` STRING`

#### Notes:

1.  *id* is the help text identifier.

*See also:* The [OPTIONS](Programs.html#PROGRAM_OPTIONS) instruction.

------------------------------------------------------------------------

### [FGL_GETPID( )]{#BF_FGL_GETPID}

#### Purpose:

This function returns the system process identifier.

#### Context:

1.  At any place in the program.

#### Syntax:

`CALL FGL_GETPID() RETURNING `*`result`*` INTEGER`

#### Notes:

1.  The process identifier is provided by the operating system; it is
    normally unique.

*See also:* [FGL_SYSTEM()](#BF_FGL_SYSTEM).

------------------------------------------------------------------------

### [FGL_DIALOG_GETBUFFERSTART( )]{#BF_FGL_DIALOG_GETBUFFERSTART}

#### Purpose:

This function returns the row offset of the page to feed a paged display
array.

#### Syntax:

`CALL FGL_DIALOG_GETBUFFERSTART( ) RETURNING `*`result`*` INTEGER`

#### Usage:

See [DISPLAY ARRAY](DisplayArray.html).

**Warning: This function must be called in the context of the ON FILL
BUFFER trigger. The returned value is undefined if the function is used
outside this trigger.**

------------------------------------------------------------------------

### [FGL_DIALOG_GETBUFFERLENGTH( )]{#BF_FGL_DIALOG_GETBUFFERLENGTH}

#### Purpose:

This function returns the number of rows of the page to feed a paged
display array.

#### Syntax:

`CALL FGL_DIALOG_GETBUFFERLENGTH( ) RETURNING `*`result`*` INTEGER`

#### Usage:

See [DISPLAY ARRAY](DisplayArray.html).

**Warning: This function must be called in the context of the ON FILL
BUFFER trigger. The returned value is undefined if the function is used
outside this trigger.**

------------------------------------------------------------------------

### [FGL_PUTFILE]{#BF_FGL_PUTFILE}

#### Purpose:

Transfers a file from the application server machine to the front end
workstation.

#### Syntax:

`CALL fgl_putfile(`*`src`*` STRING, `*`dst`*` STRING)`

#### Notes:

1.  *src* contains the name of the source file to send.
2.  *dst* contains the name of the file to write on the front end.

**Warning: Using this function can result in a security hole if you
allow the end user to specify the file paths without control. There is
not limitation on the file content or file paths: If the user executing
the application on the server side is allowed to read critical server
files, the program could transfer these files on the client workstation.
On the other hand, critical files can be written on the client
workstation. It is in the hands of the programmer to implement file path
and/or file content restrictions in the programs using FGL_PUTFILE().**

See also: [FGL_GETFILE()](#BF_FGL_GETFILE).

------------------------------------------------------------------------

### [FGL_GETFILE]{#BF_FGL_GETFILE}

#### Purpose:

Transfers a file from the front end workstation to the application
server machine.

#### Syntax:

`CALL fgl_getfile(`*`src`*` STRING, `*`dst`*` STRING)`

#### Notes:

1.  *src* contains the name of the source file to retrieve from the
    front end workstation.
2.  *dst* contains the name of the file to write on the server side.

**Warning: Using this function can result in a security hole if you
allow the end user to specify the file paths without control. There is
not limitation on the file content or file paths: If the user executing
the application on the server side is allowed to write critical server
files, the program could transfer files from the client workstation and
overwrite critical server files. On the other hand, critical files can
be read from the client workstation and copied on the application
server. It is in the hands of the programmer to implement file path
and/or file content restrictions in the programs using FGL_GETFILE().**

See also: [FGL_PUTFILE()](#BF_FGL_PUTFILE).

------------------------------------------------------------------------

### [FGL_GETENV( )]{#BF_FGL_GETENV}

#### Purpose:

This function returns the value of the environment variable having the
name you specify as the argument.

#### Syntax:

`CALL FGL_GETENV( `*`variable`*` STRING ) RETURNING `*`result`*` STRING`

#### Notes:

1.  *variable* is the name of the environment variable.
2.  If the specified environment variable is not defined, the function
    returns a [NULL](Programs.html#PC_NULL) value.
3.  If the environment variable is defined but does not have a value
    assigned to it, the function returns blank spaces.

#### Usage:

The argument of `FGL_GETENV()` must be the name of an environment
variable. If the requested value exists in the current user environment,
the function returns it as a character string and then returns control
of execution to the calling context. 

**Warning: If the returned value can be a long character string, be sure
to declare the receiving [variable](Variables.html) with sufficient size
to store the character value returned by the function. Otherwise, the
value will be truncated.**

*See also:* [FGL_SETENV()](#BF_FGL_SETENV)

------------------------------------------------------------------------

### [FGL_GETKEY( )]{#BF_FGL_GETKEY}

#### Purpose:

Waits for a keystroke and returns the [key code](#KEYCODES)
corresponding to the pressed physical key.

#### Syntax:

`CALL FGL_GETKEY() RETURNING `*`keynum`*` INTEGER`

#### Notes:

1.  *keynum* is the integer key code of the pressed key, equivalent of
    [FGL_KEYVAL()](#BF_FGL_KEYVAL).

#### Usage:

Unlike [FGL_LASTKEY()](#BF_FGL_LASTKEY), which can return a value
indicating the logical effect of whatever key the user pressed,
`FGL_GETKEY()` returns an integer representing the [key code](#KEYCODES)
of the physical key that the user pressed. The `FGL_GETKEY()` function
recognizes the same codes for keys that the
[FGL_KEYVAL()](#BF_FGL_KEYVAL) function returns. Unlike `FGL_KEYVAL()` ,
which can only return keystrokes that are entered during dialogs,
`FGL_GETKEY()` can be called outside a dialog context.

**Warning: This function is provided for backward compatibility and
works only in [TUI mode](FglTerms.html#TEXT_USER_INTERFACE).**

*See also:* [FGL_KEYVAL()](#BF_FGL_KEYVAL).

------------------------------------------------------------------------

### [FGL_GETKEYLABEL( )]{#BF_FGL_GETKEYLABEL}

#### Purpose:

This function returns the default label associated to a key.

#### Syntax:

`CALL FGL_GETKEYLABEL( `*`keyname`*` STRING ) RETURNING `*`result`*` STRING`

#### Notes:

1.  *keyname* is the logical name of a key such as `F11` or `DELETE`,
    `INSERT`, `CANCEL`.

**Warning: This function is provided for backward compatibility.**

*See also:* [FGL_SETKEYLABEL()](#BF_FGL_SETKEYLABEL),
[FGL_DIALOG_GETKEYLABEL()](#BF_FGL_DIALOG_GETKEYLABEL).

------------------------------------------------------------------------

### [FGL_SETKEYLABEL( )]{#BF_FGL_SETKEYLABEL}

#### Purpose:

This function sets the default label associated to a key.

#### Syntax:

`CALL FGL_SETKEYLABEL( `*`keyname`*` STRING, `*`label`*` STRING )`

#### Notes:

1.  *keyname* is the logical name of a key such as `F11` or `DELETE`,
    `INSERT`, `CANCEL`.
2.  *label* is the text associated to the key.

**Warning: This function is provided for backward compatibility.**

*See also:* [FGL_SETKEYLABEL()](#BF_FGL_SETKEYLABEL),
[FGL_DIALOG_SETKEYLABEL()](#BF_FGL_DIALOG_SETKEYLABEL).

------------------------------------------------------------------------

### [FGL_DIALOG_GETKEYLABEL( )]{#BF_FGL_DIALOG_GETKEYLABEL}

#### Purpose:

This function returns the label associated to a key for the current
interactive instruction.

#### Syntax:

`CALL FGL_DIALOG_GETKEYLABEL( `*`keyname`*` STRING ) RETURNING `*`result`*` STRING`

#### Notes:

1.  *keyname* is the logical name of a key such as `F11` or `DELETE`,
    `INSERT`, `CANCEL`.

**Warning: This function is provided for backward compatibility.**

*See also:* [FGL_SETKEYLABEL()](#BF_FGL_SETKEYLABEL),
[FGL_DIALOG_SETKEYLABEL()](#BF_FGL_DIALOG_SETKEYLABEL).

------------------------------------------------------------------------

### [FGL_DIALOG_GETSELECTIONEND( )]{#BF_FGL_DIALOG_GETSELECTIONEND}

#### Purpose:

This function returns position of the last selected character in the
current field text.

#### Syntax:

`CALL FGL_DIALOG_GETSELECTIONEND( ) RETURNING `*`position`*` INTEGER`

#### Notes:

1.  *position* is the position of the last selected character in the
    current field text.
2.  *position* is zero if the complete text is selected.

**Warning: The edit cursor position returned by
[FGL_DIALOG_GETCURSOR()](#BF_FGL_GETCURSOR) will be lower as the
position returned by `FGL_DIALOG_GETSELECTIONEND()` if the text has been
selected backwards.**

*See also:* [FGL_DIALOG_GETCURSOR()](#BF_FGL_GETCURSOR),
[FGL_DIALOG_SETSELECTION()](#BF_FGL_DIALOG_SETSELECTION).

------------------------------------------------------------------------

### [FGL_DIALOG_SETKEYLABEL( )]{#BF_FGL_DIALOG_SETKEYLABEL}

#### Purpose:

This function sets the label associated to a key for the current
interactive instruction.

#### Syntax:

`CALL FGL_DIALOG_SETKEYLABEL( `*`keyname`*` STRING, `*`label`*` STRING )`

#### Notes:

1.  *keyname* is the logical name of a key such as `F11` or `DELETE`,
    `INSERT`, `CANCEL`.
2.  *label* is the text associated to the key.

**Warning: This function is provided for backward compatibility, you
should use [Action Defaults](ActionDefaults.html) instead.**

*See also:* [FGL_SETKEYLABEL()](#BF_FGL_SETKEYLABEL),
[FGL_DIALOG_GETKEYLABEL()](#BF_FGL_DIALOG_GETKEYLABEL).

------------------------------------------------------------------------

### [FGL_DIALOG_SETSELECTION( )]{#BF_FGL_DIALOG_SETSELECTION}

#### Purpose:

This function selects the text in the current field.

#### Context:

1.  In interactive instructions control blocks, when staying in the
    current field.

#### Syntax:

`CALL FGL_DIALOG_SETSELECTION( `*`cursor`*` INTEGER, `*`end`*` INTEGER )`

#### Notes:

1.  *cursor* defines the edit cursor position. 
2.  *end* defines the selection end position.

#### Usage:

Here *cursor* defines the character position of the edit cursor
(equivalent to [FGL_DIALOG_GETCURSOR()](#BF_FGL_GETCURSOR) position),
while *end* defines the character position of the end of the text
selection (equivalent to
[FGL_DIALOG_GETSELECTIONEND()](#BF_FGL_DIALOG_GETSELECTIONEND)
position).

Note that *cursor* can be lower, greater or equal to *end*.

This function has only an effect when staying in the current field, it
should not be called in an `AFTER FIELD` or `AFTER ROW` for example.

*See also:* [FGL_DIALOG_SETCURSOR()](#BF_FGL_DIALOG_SETCURSOR),
[FGL_DIALOG_GETCURSOR()](#BF_FGL_GETCURSOR),
[FGL_DIALOG_GETSELECTIONEND()](#BF_FGL_DIALOG_GETSELECTIONEND).

------------------------------------------------------------------------

### [FGL_SETSIZE( )]{#BF_FGL_SETSIZE}

#### Purpose:

This function sets the size of the main application window.

#### Syntax:

`CALL FGL_SETSIZE( `*`height`*` INTEGER, `*`width`*` INTEGER )`

#### Notes:

1.  *height* is the number of lines of the window.
2.  *width* is the number of columns of the window.

#### Usage:

This function defines the size of the main window when using the
[traditional GUI mode](DynamicUI.html#TRADITIONAL_MODE).

*See also:* [FGL_SETTITLE()](#BF_FGL_SETTITLE),
[ui.Interface.setSize()](ClassInterface.html#setSize).

------------------------------------------------------------------------

### [FGL_SETTITLE( )]{#BF_FGL_SETTITLE}

#### Purpose:

This function sets the title of the main application window.

#### Syntax:

`CALL FGL_SETTITLE( `*`label`*` STRING )`

#### Notes:

1.  *label* is the text of the title. 

**Warning:** **This function is provided for backward compatibility.**

*See also:* [FGL_SETSIZE()](#BF_FGL_SETSIZE).

------------------------------------------------------------------------

### [FGL_SYSTEM( )]{#BF_FGL_SYSTEM}

#### Purpose:

This function runs a command in background on the application server.

#### Syntax:

`CALL FGL_SYSTEM( `*`command`*` STRING )`

#### Notes:

1.  *command* is the command line to be executed on the server. 

**Warning: This function is provided for backward compatibility. In
older versions, the function could raise a terminal emulator on the
front-end to show the command output on the workstation. This feature is
no longer supported by Genero BDL.**

------------------------------------------------------------------------

### [FGL_WIDTH()]{#BF_FGL_WIDTH}

#### Purpose:

This function returns the number of columns needed to represent the
printed version of the expression.

#### Context:

1.  At any place in the program.

#### Syntax:

`CALL FGL_WIDTH( `*`expression`*` ) RETURNING `*`result`*` INTEGER`

#### Notes:

1.  *expression* is any valid [expression](Expressions.html).
2.  Trailing blanks are counted in the length of the string.
3.  If the parameter is [NULL](Programs.html#PC_NULL), the function
    returns zero.

#### Usage:

This function returns the number of columns that will be used if you
display *expression* on a text terminal. The number of columns used by a
character depends on the glyph (i.e. the graphical symbol used to draw
the character on the screen). For example, an ASCII character like A
uses one column, while one Chinese character uses 2 columns (i.e. on a
text terminal, the size of one Chinese character takes the same size as
AB).

*See also:* [LENGTH()](#BF_LENGTH).

------------------------------------------------------------------------

### [FGL_WINDOW_GETOPTION( )]{#BF_FGL_WINDOW_GETOPTION}

#### Purpose:

This function returns attributes of the [current
window](WindowsAndForms.html).

#### Syntax:

`CALL FGL_WINDOW_GETOPTION( `*`attribute`*` STRING ) RETURNING `*`result`*` STRING`

#### Notes:

1.  *attribute* is the name of a window attribute. This can be one of
    `name`, `x`, `y`, `width`, `height`, `formline`, `messageline`.

**Warning: This function is provided for backward compatibility.**

------------------------------------------------------------------------

### [FGL_GETRESOURCE( )]{#BF_FGL_GETRESOURCE}

#### Purpose:

This function returns the value of an [FGLPROFILE](FglProfile.html)
entry.

#### Context:

1.  At any place in the program.

#### Syntax:

`CALL FGL_GETRESOURCE( `*`name`*` STRING ) RETURNING `*`result`*` STRING`

#### Notes:

1.  *name* is the FGLPROFILE entry name to be read.
2.  If the entry does not exist in the configuration file, the function
    returns [NULL](Programs.html#PC_NULL).
3.  See also [FGLPROFILE definition](FglProfile.html).

**Warning: FGLPROFILE entry names are [not]{.underline} case
sensitive.**

------------------------------------------------------------------------

### [DOWNSHIFT( )]{#BF_DOWNSHIFT}

#### Purpose:

This function returns returns a string value in which all uppercase
characters in its argument are converted to lowercase.

#### Context:

1.  At any place in the program.

#### Syntax:

`CALL DOWNSHIFT( `*`source`*` STRING ) RETURNING `*`result`*` STRING`

#### Notes:

1.  *source* is the character string to convert to lowercase letters.
2.  Non-alphabetic or lowercase characters are not altered.

**Warning: Conversion depends on [locale settings](Localization.html)
(the LC_CTYPE environment variable).**

*See also:* [UPSHIFT()](#BF_UPSHIFT).

------------------------------------------------------------------------

### [UPSHIFT( )]{#BF_UPSHIFT}

#### Purpose:

This function returns a string value in which all lowercase characters
in its argument are converted to uppercase.

#### Context:

1.  At any place in the program.

#### Syntax:

`CALL UPSHIFT( `*`source`*` STRING ) RETURNING `*`result`*` STRING`

#### Notes:

1.  *source* is the character string to convert to uppercase letters.
2.  Non-alphabetic or uppercase characters are not altered.

**Warning: Conversion depends on [locale settings](Localization.html)
(the LC_CTYPE environment variable).**

*See also:* [DOWNSHIFT()](#BF_DOWNSHIFT).

------------------------------------------------------------------------

### [The key code table]{#KEYCODES}

**Warning: These are internal key codes. Avoid hard-coding these numbers
in your sources; otherwise your 4gl source will not be compatible with
future versions of Genero BDL. Always use the
[FGL_KEYVAL(*keyname*)](#BF_FGL_KEYVAL) function instead.**

::: {align="center"}
  ------------------ ----------------- -------------------------------------------------------------------------------------------------------------------------------------------------------------------
  **Value**          **Key name**      **Description**
  `1 to 26`          `Control-`*`x`*   Control key,  where *x* is the any letter from A to Z. The key code corresponding to Control-A is 1, Control-B is 2, etc.
  *`others < 256`*   `ASCII chars`     Other codes correspond to the ASCII characters set.
  `2000`             `up`              The up-arrow logical key.
  `2001`             `down`            The down-arrow logical key.
  `2002`             `left`            The left-arrow logical key.
  `2003`             `right`           The right-arrow logical key.
  `2005`             `nextpage`        The next-page logical key.
  `2006`             `prevpage`        The previous-page logical key.
  `2008`             `help`            The help logical key.
  `2011`             `interrupt`       The interrupt logical key.
  `2020`             `home`            The home logical key.
  `2021`             `end`             The end logical key.
  `2016`             `accept`          The accept logical key.
  `2017`             `backspace`       The backspace logical key.
  `3000 to 3255`     `F`*`x`*          Function key, where *x* is the number of the function key. The key code corresponding to a function key F*x* is 3000+*x*-1, for example, 3011 corresponds to F12.
  ------------------ ----------------- -------------------------------------------------------------------------------------------------------------------------------------------------------------------
:::
