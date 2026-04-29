[Back to Contents](../index.html)

------------------------------------------------------------------------

# [Utility Functions]{#PAGE_HEADER}

Summary:

- [What is a utility function?](#DEFINITION)
- [List of utility functions](#FUNCLIST)
- [List of de-supported utility functions](#DESUPLIST)

*See also:* [Built-in Functions](BuiltInFunctions.html).

------------------------------------------------------------------------

### [What is a utility function?]{#DEFINITION}

A utility function is a [function](Functions.html) provided in a
separate 4GL library; it is not built in the runtime system. You
[must]{.underline} link with the utility library to use one of the
utility functions.

The library of utility function is named **libfgl4js**. The 42x file, 
42m modules and 42f forms are provided in \$FGLDIR/lib. The sources of
the utility functions and form files are provided in the FGLDIR/src
directory.

------------------------------------------------------------------------

### [List of utility functions]{#FUNCLIST}

+--------------------------------------------------------------+-----------------------------------------------------------------------------------+
| **Function**                                                 | **Description**                                                                   |
+--------------------------------------------------------------+-----------------------------------------------------------------------------------+
| **Common dialog functions**                                                                                                                      |
+--------------------------------------------------------------+-----------------------------------------------------------------------------------+
| [FGL_WINBUTTON()](#UF_FGL_WINBUTTON)                         | In a separate window, displays an interactive message box with multiple choices   |
+--------------------------------------------------------------+-----------------------------------------------------------------------------------+
| [FGL_WINMESSAGE()](#UF_FGL_WINMESSAGE)                       | In a separate window, Displays an interactive message box with some text          |
+--------------------------------------------------------------+-----------------------------------------------------------------------------------+
| [FGL_WINPROMPT()](#UF_FGL_WINPROMPT)                         | Displays a dialog box with a field that accepts a value                           |
+--------------------------------------------------------------+-----------------------------------------------------------------------------------+
| [FGL_WINQUESTION()](#UF_FGL_WINQUESTION)                     | In a separate window, displays an interactive message box with Yes, No, Cancel    |
|                                                              | buttons                                                                           |
+--------------------------------------------------------------+-----------------------------------------------------------------------------------+
| [FGL_WINWAIT()](#UF_FGL_WINWAIT)                             | Displays a dialog box and waits for the user to press a key                       |
+--------------------------------------------------------------+-----------------------------------------------------------------------------------+
| **Database utility functions**                                                                                                                   |
+--------------------------------------------------------------+-----------------------------------------------------------------------------------+
| [DB_GET_DATABASE_TYPE()](#UF_DB_GET_DATABASE_TYPE)           | Returns the type of the current database                                          |
+--------------------------------------------------------------+-----------------------------------------------------------------------------------+
| [DB_GET_SEQUENCE()](#UF_DB_GET_SEQUENCE)                     | Returns a new serial value from a predefined table (SERIALREG)                    |
+--------------------------------------------------------------+-----------------------------------------------------------------------------------+
| [DB_START_TRANSACTION()](#UF_DB_START_TRANSACTION)           | Starts a new transaction if none is started (for nested transaction handling)     |
+--------------------------------------------------------------+-----------------------------------------------------------------------------------+
| [DB_FINISH_TRANSACTION()](#UF_DB_FINISH_TRANSACTION)         | Ends a nested transaction                                                         |
+--------------------------------------------------------------+-----------------------------------------------------------------------------------+
| [DB_IS_TRANSACTION_STARTED()](#UF_DB_IS_TRANSACTION_STARTED) | Returns TRUE if a nested transaction is started                                   |
+--------------------------------------------------------------+-----------------------------------------------------------------------------------+
| **Front End Functions (Use ui.Interface.frontCall() instead)**                                                                                   |
+--------------------------------------------------------------+-----------------------------------------------------------------------------------+
| [WINOPENDIR()](#UF_WINOPENDIR)                               | Shows a dialog window to select a directory in the front end workstation file     |
|                                                              | system;\                                                                          |
|                                                              | use                                                                               |
|                                                              | [ui.Interface.frontCall(\"standard\",\"opendir\",\...)](FrontEndFunctions.html)   |
|                                                              | instead.                                                                          |
+--------------------------------------------------------------+-----------------------------------------------------------------------------------+
| [WINOPENFILE()](#UF_WINOPENFILE)                             | Shows a dialog window to select a file in the front end workstation file system;\ |
|                                                              | use                                                                               |
|                                                              | [ui.Interface.frontCall(\"standard\",\"openfile\",\...)](FrontEndFunctions.html)  |
|                                                              | instead.                                                                          |
+--------------------------------------------------------------+-----------------------------------------------------------------------------------+
| [WINSAVEFILE()](#UF_WINSAVEFILE)                             | Shows a dialog window to save a file in the front end workstation file system;\   |
|                                                              | use                                                                               |
|                                                              | [ui.Interface.frontCall(\"standard\",\"savefile\",\...)](FrontEndFunctions.html)  |
|                                                              | instead.                                                                          |
+--------------------------------------------------------------+-----------------------------------------------------------------------------------+
| **Microsoft Windows Client Specific Functions (Use ui.Interface.frontCall() instead)**                                                           |
+--------------------------------------------------------------+-----------------------------------------------------------------------------------+
| [WINEXEC()](#UF_WINEXEC)                                     | Starts a program on a Microsoft Windows front end without waiting;\               |
|                                                              | use                                                                               |
|                                                              | [ui.Interface.frontCall(\"standard\",\"execute\",\...)](FrontEndFunctions.html)   |
|                                                              | instead.                                                                          |
+--------------------------------------------------------------+-----------------------------------------------------------------------------------+
| [WINEXECWAIT()](#UF_WINEXECWAIT)                             | Starts a program on a Microsoft Windows front end and waits;\                     |
|                                                              | use                                                                               |
|                                                              | [ui.Interface.frontCall(\"standard\",\"execute\",\...)](FrontEndFunctions.html)   |
|                                                              | instead.                                                                          |
+--------------------------------------------------------------+-----------------------------------------------------------------------------------+
| [WINSHELLEXEC()](#UF_WINSHELLEXEC)                           | Opens a document on a Microsoft Windows front end with the corresponding          |
|                                                              | program;\                                                                         |
|                                                              | use                                                                               |
|                                                              | [ui.Interface.frontCall(\"standard\",\"shellexec\",\...)](FrontEndFunctions.html) |
|                                                              | instead.                                                                          |
+--------------------------------------------------------------+-----------------------------------------------------------------------------------+

------------------------------------------------------------------------

### [List of de-supported utility functions:]{#DESUPLIST}

  ------------------------------ ---------------------------------------------------------------------------------------------
  **Function**                   **Description**
  *DATE1()*                      Converts a DATETIME to a DATE.
  *TIME1( )*                     Extracts the time part (hour, minute, second) from DATETIME.
  *FGL_FGLGUI()*                 Returns TRUE if the application runs in [GUI](FglTerms.html#GRAPHICAL_USER_INTERFACE) mode.
  *FGL_GETUITYPE()*              Returns the type of the front end.
  *FGL_MSG_NONL()*               Returns an error message without trailing blanks.
  *FGL_INIT4JS( )*               Initializes the built-in function library.
  *FGL_MSG_NONL( )*              Returns an error message without the CR at the end.
  *FGL_WTKCLIENT( )*             Returns TRUE if the current front end is the WTK.
  *FGL_RESOURCE( )*              Selects a specific FGLPROFILE file.
  *FGL_UIRETRIEVE( )*            Returns the value of a variable from the WTK front end.
  *FGL_UISENDCOMMAND( )*         Sends a TCL command to the WTK front end.
  *FGL_WTKCLIENT( )*             Returns TRUE if the current front end is the WTK.
  *FGL_CHARBOOL_TO_INTBOOL()*    Converts a character representation of a Boolean value to an INTEGER.
  *FGL_INTBOOL_TO_CHARBOOL( )*   Converts an INTEGER to a character representation of the Boolean value.
  ------------------------------ ---------------------------------------------------------------------------------------------

------------------------------------------------------------------------

### [DB_GET_DATABASE_TYPE( )]{#UF_DB_GET_DATABASE_TYPE}

#### Purpose:

This function returns the database type for the current connection.

#### Syntax:

`CALL DB_GET_DATABASE_TYPE()`\
` RETURNING `*`result`*` STRING`

#### Usage:

After connecting to the database, you can get the type of the database
server with this function.

The following table shows the codes returned by this function, for the
supported database types:

  ---------- ----------------------
  **Code**   **Description**
  ADS        ANTs / Genero DB
  ASA        Sybase ASA
  DB2        IBM DB2
  IFX        Informix
  MYS        MySQL
  MSV        Microsoft SQL Server
  ORA        Oracle
  PGS        PostgreSQL
  ---------- ----------------------

------------------------------------------------------------------------

### [DB_GET_SEQUENCE( )]{#UF_DB_GET_SEQUENCE}

#### Purpose:

This function generates a new sequence for a given identifier.

#### Syntax:

`CALL DB_GET_SEQUENCE( `*`id`*` STRING )`\
` RETURNING `*`result`*` INTEGER`

#### Warnings:

1.  This function needs a database table called SERIALREG.
2.  This function must be used **inside** a transaction block.

#### Usage:

This function generates a new sequence from a register table created in
the current database.

The table must be created as follows:

CREATE TABLE SERIALREG\
  ( TABLE_NAME VARCHAR(50) NOT NULL PRIMARY KEY,\
    LAST_SERIAL INTEGER NOT NULL )

Each time you call this function, the sequence is incremented in the
database table and returned by the function.

It is mandatory to use this function inside a transaction block, in
order to generate unique sequences.

#### Example:

``` linenumber
01 MAIN
02   DEFINE ns, s INTEGER
03   DATABASE mydb
04   LET s = DB_START_TRANSACTION()
05   LET ns = DB_GET_SEQUENCE("mytable")
06   INSERT INTO mytable VALUES ( ns, 'a new sequence' )
07   LET s = DB_FINISH_TRANSACTION(TRUE)
08 END MAIN
```

------------------------------------------------------------------------

### [DB_START_TRANSACTION( )]{#UF_DB_START_TRANSACTION}

#### Purpose:

This function encapsulates the [BEGIN
WORK](Transactions.html#TI_BEGIN_WORK) instruction to start a
transaction.

#### Syntax:

`CALL DB_START_TRANSACTION()`\
` RETURNING `*`result`*` INTEGER`

#### Usage:

You can use the transaction management functions to handle nested
transactions.

On most database engines, you can only have a unique transaction, that
you start with [BEGIN WORK](Transactions.html#TI_BEGIN_WORK) and you end
with [COMMIT WORK](Transactions.html#TI_COMMIT_WORK) or [ROLLBACK
WORK](Transactions.html#TI_ROLLBACK_WORK). But in a complex program, you
may have nested function calls doing several SQL transactions.

The transaction management functions execute a real transaction
instruction only if the number of subsequent start/end calls of these
functions matches.

#### Example:

``` linenumber
01 DEFINE s INTEGER
02
03 MAIN
04   DATABASE mydb
05   LET s = DB_START_TRANSACTION() -- real BEGIN WORK
06   CALL do_update()
07   LET s = DB_FINISH_TRANSACTION(TRUE) -- real COMMIT WORK
08 END MAIN
09
10 FUNCTION do_update()
11   LET s = DB_START_TRANSACTION()
12   UPDATE customer SET cust_status = 'X'
13   LET s = DB_FINISH_TRANSACTION(TRUE)
14 END FUNCTION
```

------------------------------------------------------------------------

### [DB_FINISH_TRANSACTION( )]{#UF_DB_FINISH_TRANSACTION}

#### Purpose:

This function encapsulates the [COMMIT
WORK](Transactions.html#TI_COMMIT_WORK) or [ROLLBACK
WORK](Transactions.html#TI_ROLLBACK_WORK) instructions to end a
transaction.

#### Syntax:

`CALL DB_FINISH_TRANSACTION( `*`commit`*` INTEGER )`\
` RETURNING `*`result`*` INTEGER`

#### Notes:

1.  *commit* indicates whether the transaction must be committed.

#### Usage:

When the number of calls to DB_START_TRANSACTION() matches, this
function executes a [COMMIT WORK](Transactions.html#TI_COMMIT_WORK) if
the passed parameter is TRUE; if the passed parameter is not TRUE, it
executes a [ROLLBACK WORK](Transactions.html#TI_ROLLBACK_WORK).

If the number of calls does not match, the function does nothing.

*See also:* [DB_START_TRANSACTION()](#UF_DB_START_TRANSACTION).

------------------------------------------------------------------------

### [DB_IS_TRANSACTION_STARTED( )]{#UF_DB_IS_TRANSACTION_STARTED}

#### Purpose:

This function indicates whether a transaction is started with the
transaction management functions.

#### Syntax:

`CALL DB_IS_TRANSACTION_STARTED()`\
` RETURNING `*`result`*` INTEGER`

#### Usage:

The function returns [TRUE](Programs.html#PC_TRUE) if a transaction was
started with [DB_START_TRANSACTION()](#UF_DB_START_TRANSACTION).

------------------------------------------------------------------------

### [FGL_WINBUTTON( )]{#UF_FGL_WINBUTTON}

#### Purpose:

This function displays an interactive message box containing multiple
choices, in a separate window.

#### Syntax:

`CALL FGL_WINBUTTON(`\
`  `*`title`*` STRING, `*`text`*` STRING, `*`default`*` STRING,`\
`  `*`buttons`*` STRING, `*`icon`*` STRING, `*`danger`*` SMALLINT )`\
` RETURNING `*`result`*` STRING`

#### Notes:

1.  *title* defines the title of the message window.
2.  *text* specifies the string displayed in message window.
3.  Use * * \'\\n\' in *text* to separate lines (this does not work on
    ASCII client).
4.  *default* indicates the default button to be pre-selected.
5.  *buttons* defines a set of button labels separated by \"\|\".
6.  You can define up to 7 buttons that each have 10 characters.
7.  *icon* is the name of the icon to be displayed.
8.  Supported icon names are: \"`information`\", \"`exclamation`\",
    \"`question`\", \"`stop`\".
9.  *danger* (for X11 only), number of the warnings item. Otherwise,
    this parameter is ignored.
10. The function returns the label of the button which has been selected
    by the user.

#### Warnings:

1.  You can also use a [form](FormSpecFiles.html) or a [menu with
    \"popup\" style](Menus.html) instead.
2.  If two buttons start with the same letter, the user will not be able
    to select one of them on the ASCII client.
3.  The \"&\" before a letter for a button is either displayed (ASCII
    client), or it underlines the letter.

#### Example:

``` linenumber
01 MAIN
02   DEFINE answer STRING
03   LET answer = FGL_WINBUTTON( "Media selection", "What is your favorite media?",
04       "Lynx", "Floppy Disk|CD-ROM|DVD-ROM|Other", "question", 0)
05   DISPLAY "Selected media is: " || answer
06 END MAIN
```

------------------------------------------------------------------------

### [FGL_WINMESSAGE( )]{#UF_FGL_WINMESSAGE}

#### Purpose:

This function displays an interactive message box containing text, in a
separate window.

#### Syntax:

`CALL FGL_WINMESSAGE( `*`title`*` STRING, `*`text`*` STRING, `*`icon`*` STRING )`

#### Notes:

1.  *title* defines message box title.
2.  *text* is the text displayed in the message box. Use \'\\n\' to
    separate lines.
3.  *icon* is the name of the icon to be displayed.
4.  Supported icon names are: \"`information`\", \"`exclamation`\",
    \"`question`\", \"`stop`\".

#### Warnings:

1.  You can also use a [form](FormSpecFiles.html) or a [menu with
    \"popup\" style](Menus.html) instead.
2.  *icon* is ignored by the ASCII client.

#### Example:

``` linenumber
01 MAIN
02   CALL FGL_WINMESSAGE( "Title", "This is a critical message.", "stop")
03 END MAIN
```

------------------------------------------------------------------------

### [FGL_WINPROMPT( )]{#UF_FGL_WINPROMPT}

#### Purpose:

This function displays a dialog box containing a field that accepts a
value.

#### Syntax:

`CALL FGL_WINPROMPT (`\
`  `*`x`*` INTEGER, `*`y`*` INTEGER, `*`text`*` STRING,`\
`  `*`default`*` STRING, `*`length`*` INTEGER, `*`type`*` INTEGER )`\
` RETURNING `*`value`*` STRING`

#### Notes:

1.  *x* is the column position in characters.
2.  *y* is the line position in characters.
3.  *text* is the message shown in the box.
4.  *default* is the default value.
5.  *length* is the maximum length of the input value.
6.  *type* is the datatype of the return value : 0=CHAR, 1=SMALLINT, 
    2=INTEGER, 7=DATE, 255=invisible
7.  *value* is the value entered by the user.

#### Warnings:

1.  You can also use your own [form](FormSpecFiles.html) instead.

2.  Avoid passing NULL values.

#### Example:

``` linenumber
01 MAIN
02   DEFINE answer DATE
04   LET answer = FGL_WINPROMPT( 10, 10, "Today", DATE, 10, 7 )
05   DISPLAY "Today is " || answer
06 END MAIN
```

------------------------------------------------------------------------

### [FGL_WINQUESTION( )]{#UF_FGL_WINQUESTION}

#### Purpose:

This function displays an interactive message box containing Yes, No,
and Cancel buttons, in a separate window

#### Syntax:

`CALL FGL_WINQUESTION(`\
`  `*`title`*` STRING, `*`text`*` STRING, `*`default`*` STRING,`\
`  `*`buttons`*` STRING, `*`icon`*` STRING, `*`danger`*` SMALLINT )`\
` RETURNING `*`value`*` STRING`

#### Notes:

1.  *title* is the message box title.
2.  *text* is the message displayed in the message box. Use \'\\n\' to
    separate lines (does not work on ASCII client).
3.  *default* defines the default button that is pre-selected.
4.  *buttons* defines the buttons: Either \"yes\|no\" or
    \"yes\|no\|cancel\", not case-sensitive.
5.  *icon* is the name of the icon to be displayed.
6.  Supported icon names are: \"`information`\", \"`exclamation`\",
    \"`question`\", \"`stop`\".
7.  *danger* is for X11, it defines the code of the warning item.
    Otherwise, this parameter is ignored.
8.  The function returns the label of the button which has been selected
    by the user.

#### Warnings:

1.  You can also use a [form](FormSpecFiles.html) or a [menu with
    \"popup\" style](Menus.html) instead.
2.  Setting *buttons* to another value may result in unpredictable
    behavior at runtime.
3.  Avoid passing NULL values

#### Example:

``` linenumber
01 MAIN
02   DEFINE answer STRING
04   LET answer = "yes"
05   WHILE answer = "yes"
06     LET answer = FGL_WINQUESTION(
07         "Procedure", "Would you like to continue ? ",
08         "cancel", "yes|no|cancel", "question", 0)
09   END WHILE
10   IF answer = "cancel" THEN
11      DISPLAY "Canceled."
12   END IF
13 END MAIN
```

------------------------------------------------------------------------

### [FGL_WINWAIT( )]{#UF_FGL_WINWAIT}

#### Purpose:

This function displays an interactive message box and waits for the user
to press a key

#### Syntax:

`CALL FGL_WINWAIT( `*`text`*` STRING ) `

#### Notes:

1.  *text* is the message displayed in the message box. Use \'\\n\' to
    separate lines (not working on ASCII client).

#### Warnings:

1.  You can also use a [form](FormSpecFiles.html) or a [menu with
    \"popup\" style](Menus.html) instead.

------------------------------------------------------------------------

### [WINEXEC( )]{#UF_WINEXEC} MS Windows FE Only!

#### Purpose:

This function executes a program on the machine where the Windows Front
End runs and returns immediately.

#### Context:

1.  At any place in the program, but only after the first instruction
    has displayed something on the front end.

#### Syntax:

`CALL WINEXEC( `*`command`*` STRING )`\
` RETURNING `*`result`*` INTEGER`

#### Notes:

1.  *command* is the command to be executed on the front end.
2.  The function executes the program without waiting.
3.  The function returns [FALSE](Programs.html#PC_FALSE) if a problem
    has occurred.

*See also:* [WINEXECWAIT()](#UF_WINEXECWAIT), [DDE
Support](WinDDE.html).

------------------------------------------------------------------------

### [WINEXECWAIT( )]{#UF_WINEXECWAIT} MS Windows FE Only!

#### Purpose:

This function executes a program on the machine where the Windows Front
End runs and waits for termination.

#### Context:

1.  At any place in the program, but only after the first instruction
    has displayed something on the front end.

#### Syntax:

`CALL WINEXECWAIT( `*`command`*` STRING )`\
` RETURNING `*`result`*` INTEGER`

#### Notes:

1.  *command* is the command to be executed on the front end.
2.  The function executes the program and waits for its termination.
3.  The function returns [FALSE](Programs.html#PC_FALSE) if a problem
    has occurred.

*See also:* [WINEXEC()](#UF_WINEXEC), [DDE Support](WinDDE.html).

------------------------------------------------------------------------

### [WINSHELLEXEC( )]{#UF_WINSHELLEXEC} MS Windows FE Only!

#### Purpose:

This function opens a document with the corresponding program, based on
the file extension.

#### Context:

1.  At any place in the program, but only after the first instruction
    has displayed something on the front end

#### Syntax:

`CALL WINSHELLEXEC( `*`filename`*` STRING )`\
` RETURNING `*`result`*` INTEGER`

#### Notes:

1.  *filename* is the file to be opened on the front end.
2.  The function executes the program and returns immediately.
3.  The function returns [FALSE](Programs.html#PC_FALSE) if a problem
    has occurred.

*See also:* [WINEXEC()](#UF_WINEXEC), [DDE Support](WinDDE.html).

------------------------------------------------------------------------

### [WINOPENDIR( )]{#UF_WINOPENDIR}

#### Purpose:

This function shows a dialog window to let the user select a directory
path on the front end workstation file system.

#### Context:

1.  At any place in the program, but only after the first instruction
    has displayed something on the front end

#### Syntax:

`CALL WINOPENDIR( `*`dirname`*` STRING, `*`caption`*` STRING )`\
` RETURNING `*`result`*` STRING`

#### Notes:

1.  *dirname* is the default path to be displayed in the dialog window.
2.  *caption* is the label to be displayed.
3.  The function returns the directory path on success.
4.  The function returns [NULL](Programs.html#PC_NULL) if a problem has
    occurred or if the the user canceled the dialog.

------------------------------------------------------------------------

### [WINOPENFILE( )]{#UF_WINOPENFILE}

#### Purpose:

This function shows a dialog window to let the user select a file path
on the front end workstation file system, for displaying.

#### Context:

1.  At any place in the program, but only after the first instruction
    has displayed something on the front end.

#### Syntax:

`CALL WINOPENFILE( `*`dirname`*` STRING, `*`typename`*` STRING,`\
`   `*`extlist`*` STRING, `*`caption`*` STRING )`\
` RETURNING `*`result`*` STRING`

#### Notes:

1.  *dirname* is the default path to be displayed in the dialog window.
2.  *typename* is the name of the file type to be displayed.
3.  *extlist* is a blank-separated list of file extensions defining the
    file type.
4.  *caption* is the label to be displayed.
5.  The function returns the file path on success.
6.  The function returns [NULL](Programs.html#PC_NULL) if a problem has
    occurred or if the the user canceled the dialog.

------------------------------------------------------------------------

### [WINSAVEFILE( )]{#UF_WINSAVEFILE}

#### Purpose:

This function shows a dialog window to let the user select a file path
on the front end workstation file system, for saving.

#### Context:

1.  At any place in the program, but only after the first instruction
    has displayed something on the front end

#### Syntax:

`CALL WINSAVEFILE( `*`dirname`*` STRING, `*`typename`*` STRING,`\
`   `*`extlist`*` STRING, `*`caption`*` STRING )`\
` RETURNING `*`result`*` STRING`

#### Notes:

1.  *dirname* is the default path to be displayed in the dialog window.
2.  *typename* is the name of the file type to be saved.
3.  *extlist* is a blank separated list of file extensions defining the
    file type.
4.  *caption* is the label to be saved.
5.  The function returns the file path on success.
6.  The function returns [NULL](Programs.html#PC_NULL) if a problem has
    occurred or if the the user canceled the dialog.
