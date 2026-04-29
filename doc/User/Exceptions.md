[Back to Contents](../index.html)

------------------------------------------------------------------------

# [Exceptions]{#PAGE_HEADER}

Summary:

- [Exceptions handling](#DEFINITION)
- [Exception Actions](#EXCEPTION_ACTIONS)
- [Exception Types](#EXCEPTION_TYPES)
- [Exception Classes](#EXCEPTION_CLASSES)
- [Exceptions handler](#WHENEVER) (`WHENEVER`)
- [Exception blocks](#TRYCATCH) (`TRY/CATCH`)
- [Handling SQL Errors](#SQLERRORS)
- [Handling SQL Warnings](#SQLWARNINGS)
- [Tracing exceptions](#TRACE)
- [Configuring exception handling](#CONFIG)
  - [Controlling the default action for
    `WHENEVER ANY ERROR`](#mapAnyErrorToError)
- [Examples](#EXAMPLES)
  - [Example 1](#EXAMPLE_1) - `WHENEVER ERROR CALL`
  - [Example 2](#EXAMPLE_2) - `WHENEVER ERROR CONTINUE / STOP`
  - [Example 3](#EXAMPLE_3) - `TRY / CATCH`
  - [Example 4](#EXAMPLE_4) - `WHENEVER + TRY CATCH`
  - [Example 5](#EXAMPLE_5) - `WHENEVER ERROR RAISE`

*See also:* [Flow Control](FlowControl.html), [Fgl
Errors](FglErrors.html).

------------------------------------------------------------------------

## [Exception handling]{#DEFINITION}

If an instructions executes abnormally, the [runtime
system](FglTerms.html#RUNTIME_SYSTEM) throws exceptions that can be
handled by the program. [Actions](#EXCEPTION_ACTIONS) can be taken based
on the [class of the exception](#EXCEPTION_CLASSES). There is no way to
raise exceptions explicitly; only the runtime system can throw
exceptions. Runtime errors (i.e. exceptions) can be trapped by a
[WHENEVER](#WHENEVER) exception handler or by a [TRY / CATCH](#TRYCATCH)
block.

------------------------------------------------------------------------

## [Exception Actions]{#EXCEPTION_ACTIONS}

There are five actions that can be executed if an exception is raised:

`STOP`
:   The program is immediately terminated. A message is displayed to the
    standard error with the location of the related statement, the error
    number, and the details of the exception.

`CONTINUE`
:   The program continues normally (the exception is ignored).

`CALL` *name*
:   The [function](Functions.html) *name* is called by the runtime
    system. The function can be defined in any module, and must have
    zero parameters and zero return values. The
    [STATUS](Programs.html#PV_STATUS) variable will be set to the
    corresponding error number.

`GOTO` *name*
:   The program execution continues at the
    [label](FlowControl.html#FC_GOTO) identified by *name*.

`RAISE`
:   This statement instructs the DVM that an exception raised will not
    be handled by the local function, but by the calling function. If an
    exception is raised, the current function will return and the
    exception handling is left to the caller function.\
    **Warning: `WHENEVER [ANY] ERROR RAISE` is not supported in a
    [REPORT routine](Reports.html).**

------------------------------------------------------------------------

## [Exception Types]{#EXCEPTION_TYPES}

There are four types of exceptions, defining the kind of errors that can
occur:

::: {align="left"}
  ----------------- ------------------------------------------------------------------------------ ----------------------------------------
  **Type**          **Reason**                                                                     **Examples**
  `ET_STATEMENT`    Error occurred in a statement.                                                 DISPLAY AT invalid coordinates.
  `ET_EXPRESSION`   Expression evaluation error.                                                   Division by zero.
  `ET_NOTFOUND`     An SQL statement returns status [NOTFOUND](Programs.html#PC_NOTFOUND).         FETCH when cursor is on last row. 
  `ET_WARNING`      An SQL statement sets [sqlca.sqlawarn](Connections.html#SQLCA_RECORD) flags.   Fetched CHAR value has been truncated.
  ----------------- ------------------------------------------------------------------------------ ----------------------------------------
:::

------------------------------------------------------------------------

## [Exception Classes]{#EXCEPTION_CLASSES}

The exception classes indirectly define the [exception
type](#EXCEPTION_TYPES):

::: {align="left"}
  ------------------------------- ------------------------------------------------------- --------------------
  **Class**                       **Related Exception Type (defines the error reason)**   **Default Action**
  `ERROR (or SQLERROR)`           `ET_STATEMENT`                                          STOP
  `ANY ERROR (or ANY SQLERROR)`   `ET_STATEMENT` or `ET_EXPRESSION`                       CONTINUE (1)
  `NOT FOUND`                     `ET_NOTFOUND`                                           CONTINUE
  `WARNING`                       `ET_WARNING`                                            CONTINUE
  ------------------------------- ------------------------------------------------------- --------------------
:::

Notes:

1.  The default action can be changed, see [Configuring exception
    handling](#mapAnyErrorToError).

------------------------------------------------------------------------

## [WHENEVER]{#WHENEVER}

The `WHENEVER` instruction defines exception handling in a program
module, by associating an [exception class](#EXCEPTION_CLASSES) with an
[exception action](#EXCEPTION_ACTIONS).

#### Syntax:

`WHENEVER `*[`exception-class`](#exception-class)` `[`exception-action`](#exception-action)*

[were exception-class is one of:]{#exception-class}

` `[`{`]{.underline}` `[`[`]{.underline}`ANY`[`]`]{.underline}` ERROR`\
[`|`]{.underline}` `[`[`]{.underline}`ANY`[`]`]{.underline}` SQLERROR`\
[`|`]{.underline}` NOT FOUND`\
[`|`]{.underline}` WARNING`\
[`}`]{.underline}

[and exception-action is one of:]{#exception-action}

` `[`{`]{.underline}` CONTINUE`\
[`|`]{.underline}` STOP`\
[`|`]{.underline}` CALL `*`function`\*
` `[`|`]{.underline}` RAISE`\
[`|`]{.underline}` GOTO `*`label`\*
` `[`}`]{.underline}

#### Notes:

1.  *function* can be any [function](Functions.html) name defined in the
    program.
2.  *label* must be a [label](FlowControl.html#FC_GOTO) defined in the
    current program block (main, function or report routine).

#### Usage:

The scope of a ` WHENEVER` instruction is similar to a C pre-processor
macro. It is local to the module and valid until the end of the module,
unless a new ` WHENEVER` instruction is encountered by the compiler.

Next code example shows a typical `WHENEVER` instruction usage:

``` linenumber
01 WHENEVER ERROR CONTINUE
02 DROP TABLE mytable -- SQL error will be ignored
03 CREATE TABLE mytable ( k INT, c VARCHAR(20) )
04 WHENEVER ERROR STOP
05 IF SQLCA.SQLCODE != 0 THEN
06    ERROR "Could not create the table..."
07 END IF
```

Exception classes `ERROR` and `SQLERROR` are synonyms (compatibility
issue). The previous example could have used `WHENEVER SQLERROR` instead
of `WHENEVER ERROR`.

Actions for classes `ERROR`, `WARNING` and `NOT FOUND` can be set
independently:

``` linenumber
01 WHENEVER ERROR STOP
02 WHENEVER WARNING CONTINUE
03 WHENEVER NOT FOUND GOTO not_found_handler
04 ...
```

For SQL instructions that can potentially generate errors, it is
recommended that you define an exception handler locally; errors in the
rest of the program can be handled by the default exception handler. See
[example 2](#EXAMPLE_2) for more details.

The `RAISE` option can be used to propagate the error to the caller,
which typically traps the error in a [TRY/CATCH block](#TRYCATCH).

**Warning: `WHENEVER [ANY] ERROR RAISE` is not supported in a [REPORT
routine](Reports.html).**

------------------------------------------------------------------------

## [TRY - CATCH pseudo statement]{#TRYCATCH}

Any Genero BDL statement in the `TRY` block will be executed until an
exception is thrown. After an exception the program execution continues
in the `CATCH` block. If no `CATCH` block is provided, the execution
continues after `END TRY`.

If no exception is raised by the statements between the `TRY` and
`CATCH` keywords, the instructions in the `CATCH` section are ignored
and the program flow continues after `END TRY`.

The next code example shows a `TRY` block executing an SQL statement:

    01 TRY
    02     SELECT COUNT(*) INTO num_cust FROM customers WHERE ord_date <= max_date
    03 CATCH
    04     ERROR "Error caught during SQL statement execution:", SQLCA.SQLCODE
    05 END TRY

A `TRY` block be compared with `WHENEVER ANY ERROR GOTO`. Here is the
equivalent of the above code example:

    01 WHENEVER ANY ERROR GOTO catch_error
    02     SELECT COUNT(*) INTO num_cust FROM customers WHERE ord_date <= max_date
    03     GOTO no_error
    04 LABEL catch_error:
    05 WHENEVER ERROR STOP
    06     ERROR "Error caught during SQL statement execution:", SQLCA.SQLCODE
    07 LABEL no_error

The `TRY` statement can be nested in other `TRY` statements. In the next
example, the instruction in line #5 will be executed in case of SQL
error:

``` linenumber
01 TRY
02     TRY
03         SELECT COUNT(*) INTO num_cust FROM customers
04     CATCH
05         ERROR "Try block 2: ", SQLCA.SQLCODE
06     END TRY
07 CATCH
08     ERROR "Try block 1: ", SQLCA.SQLCODE
09 END TRY
```

The [WHENEVER ERROR RAISE](#WHENEVER) instruction can be used
module-wide to define the behavior when an exception occurs in a
function that is called from a `TRY` / `CATCH` block. If an exception
occurs in a statement after the `WHENEVER ERROR RAISE` instruction, the
program flow returns from the function and raises the exception as if it
had occurred in the code of the caller. If the exception in thrown in
the `MAIN` block, the program stops because the exception cannot be
processed by a caller. In the following example, the instruction in line
#5 will be executed if an exception occurs in the *cust_report()*
function:

``` linenumber
01 MAIN
02     TRY
03         CALL cust_report()
04     CATCH
05         ERROR "An error occurred during report execution: ", STATUS
06     END TRY
07 END MAIN
08
09 FUNCTION cust_report()
10     WHENEVER ERROR RAISE
11     START REPORT cust_rep ...
12     ...
13 END FUNCTION
```

Note that it is not possible to set a [debugger](Debugger.html) break
point at `TRY`, `CATCH` or `END TRY`: The `TRY` statement is a pseudo
statement, the compiler does not generate p-code for this statement. 

------------------------------------------------------------------------

## [Handing SQL Errors]{#SQLERRORS}

After executing an SQL statement, you can query
[STATUS](Programs.html#PV_STATUS),
[SQLSTATE](Operators.html#OP_SQLSTATE),
[SQLERRMESSAGE](Operators.html#OP_SQLERRMESSAGE) and the
[SQLCA](Connections.html#SQLCA_RECORD) record to get the description of
the error. When the statement has been executed with errors, STATUS and
SQLCA.SQLCODE contain the **SQL Error Code**. If no error occurs, STATUS
and SQLCA.SQLCODE are set to zero.

You control the result of an SQL statement execution by using the
[WHENEVER ERROR](#DEFINITION) exception handler:

``` linenumber
01 MAIN
02
03   DATABASE stores
04
05   WHENEVER ERROR CONTINUE
06   SELECT COUNT(*) FROM customer
07   IF sqlca.sqlcode THEN
08      ERROR "SQL Error occurred:", sqlca.sqlcode
09   END IF
10   WHENEVER ERROR STOP
11
12 END MAIN
```

The **SQL Error Codes** are not standard. For example, ORACLE returns
903 when a table name does not exist.

By convention, the STATUS and SQLCA.SQLCODE variables always use IBM
Informix SQL Error Codes. When using IBM Informix, both  STATUS and
SQLCA.SQLCODE variables contain the native Informix error code. When
using other database servers, the database interface automatically
converts native SQL Error Codes to IBM Informix Error Codes. If no
equivalent Informix Error Code can be found, the interface returns
**-6372** in SQLCA.SQLCODE.

If an SQL error occurs when using IBM Informix, the SQLCA variable is
filled with standard information as described in the Informix
documentation. When using other database servers, the native SQL Error
Code is available in the SQLCA.SQLERRD\[2\] register. SQL Error Codes in
SQLCA.SQLERRD\[2\] are always negative, even if the database server
defines positives SQL Error Codes. Additionally, if the target database
API supports ANSI SQL states, the SQLSTATE code is returned in
SQLCA.SQLERRM.

The [NOTFOUND](Programs.html#PC_NOTFOUND) (100) execution status is
returned after a [FETCH](ResultSets.html#RS_FETCH), when no rows are
found.

*See also:* [Connections](Connections.html).

------------------------------------------------------------------------

## [Handling SQL Warnings]{#SQLWARNINGS}

Some SQL instructions can produce SQL Warnings. Compared to SQL Errors
which do normally stop the program execution, SQL Warnings indicate a
minor issue that can often be ignored. For example, when connecting to
an IBM Informix database, a warning is returned to indicate that a
database was opened, and an other warning might be returned if that
database supports transactions. None of these facts are critical
problems, but knowing that information can help for further program
execution.

If an SQL Warning is raised, SQLCA.SQLCODE / STATUS remain zero, and the
program flow continues. To detect if an SQL Warning occurs, the
[SQLCA.SQLAWARN](Connections.html#SQLCA_RECORD) register must be used.
SQLCA.SQLAWARN is defined as a CHAR(7) variable. If SQLCA.SQLAWARN\[1\]
contains the **W** letter, it means that the last SQL instruction has
returned a warning. The other character positions
(SQLCA.SQLAWARN\[2-8\]) may contain W letters. Each position from 2 to 8
has a special meaning according to the database server type, and the SQL
instructions type.

If SQLCA.SQLAWARN is set, you can also check the SQLSTATE and
SQLCA.SQLERRD\[2\] registers to get more details about the warning. The
SQLERRMESSAGE register might also contain the warning description.

In the next example, the program connects to a database and displays the
content of the SQLCA.SQLAWARN register. When connecting to an IBM
Informix database with transactions, the program will display
`[WW  W   ]`:

``` linenumber
01 MAIN
02   DATABASE stores
03   DISPLAY "[", sqlca.sqlawarn, "]"
04 END MAIN 
```

By default SQL Warnings do not stop the program execution. To trap SQL
Warnings with an exception handle, use the `WHENEVER WARNING`
instruction, as shown in the example below.

``` linenumber
01 MAIN
02   DEFINE cust_name VARCHAR(50)
03   DATABASE stores
04   WHENEVER WARNING STOP
05   SELECT cust_lname, cust_address INTO cust_name
06        FROM customer WHERE cust_id = 101
07   WHENEVER WARNING CONTINUE
08 END MAIN
```

The `SELECT` statement in the above example uses two columns in the
select list, but only one `INTO` variable is provided. This is legal and
does not raise an SQL Error, however, it will set the SQLCA.SQLAWARN
register to indicate that the number of target variables does not match
the select-list items.

See also [WHENEVER WARNING](#DEFINITION) exception.

------------------------------------------------------------------------

## [Tracing exceptions]{#TRACE}

Exceptions will be automatically logged in a file by the [runtime
system](FglTerms.html#RUNTIME_SYSTEM) if all the following conditions
are true:

- The [STARTLOG](BuiltInFunctions.html#BF_STARTLOG) function has been
  previously called to specify the name of the exception logging file.
- The [exception action](#EXCEPTION_ACTIONS) is set to `CALL`, `GOTO` or
  `STOP`. Exceptions are not logged when the action is `CONTINUE`.
- The [exception class](#EXCEPTION_CLASSES) is an `ERROR`, `ANY ERROR`
  or `WARNING`. ` NOT FOUND` exceptions cannot be logged.

Each log entry contains:

- The system-time
- The location of the related Genero BDL statement (source-file, line)
- The error-number
- The text of the error message, giving human-readable details for the
  exception

------------------------------------------------------------------------

## [Configuring exception handling]{#CONFIG}

### [Controlling the default action for WHENEVER ANY ERROR]{#mapAnyErrorToError}

By default, `WHENEVER ANY ERROR` action is to `CONTINUE` the program
flow. You can force the runtime system to execute the action defined
with `WHENEVER ERROR` exception class with the following
[FGLPROFILE](FglProfile.html) entry:

    `fglrun.mapAnyErrorToError = true`

When this entry is set to true, `ET_EXPRESSION` expression errors such
as a division by zero will be trapped and execute the action defined by
the last `WHENEVER ERROR` instruction, the default being `STOP` the
program with error display.

``` linenumber
01 -- FGLPROFILE env var is defined to file with:
02 --  fglrun.mapAnyErrorToError = true
03 MAIN
04   DEFINE x INT
05   WHENEVER ERROR CALL my_error_handler
06   LET x = 1 / 0   -- error handler will be called here
07   DISPLAY "It continues...."
08 END MAIN
09 FUNCTION my_error_handler()
10   DISPLAY "Handler: ", STATUS
11 END FUNCTION
```

------------------------------------------------------------------------

## [Examples]{#EXAMPLES}

### [Example 1]{#EXAMPLE_1}: Defining a error handler function

This first code example defines an error handler function called
my_error_handler. After connecting to the database, a `SELECT`
statements tries to fetch a row from a table that does not exist, and
raises SQL error -217 when connected to Informix:

``` linenumber
01 MAIN
02   WHENEVER ERROR CALL my_error_handler
03   DATABASE stores
04   SELECT dummy FROM systables WHERE tabid=1
05 END MAIN
06
07 FUNCTION my_error_handler()
08   DISPLAY "Error:", STATUS
09   EXIT PROGRAM 1
10 END FUNCTION
```

Program output:

``` linenumber
01 Error:      -217
```

### [Example 2]{#EXAMPLE_2}:

The code example below shows a typical SQL error handling block from
line 9 to 22, it uses `WHENEVER ERROR CONTINUE` before executing SQL
statements, tests the [SQLCA.SQLCODE](Connections.html#SQLCA_RECORD)
register for errors after each SQL instruction, and resets the default
exception handler with `WHENEVER ERROR STOP` after the set of SQL
commands to be controlled:

``` linenumber
01 MAIN
02   DEFINE tabname VARCHAR(50)
03   DEFINE rowcount INTEGER
04
05   # In the DATABASE statement, no error should occur.
06   DATABASE stores
07
08   # But in the next procedure, user may enter a wrong table.
09   WHENEVER ERROR CONTINUE
10   PROMPT "Enter a table name:" FOR tabname
11   LET sqlstmt = "SELECT COUNT(*) FROM " || tabname
12   PREPARE s FROM sqlstmt
13   IF sqlca.sqlcode THEN
14      DISPLAY "SQL Error occurred:", sqlca.sqlcode
15      EXIT PROGRAMY 1
16   END IF
17   EXECUTE s INTO rowcount
18   IF sqlca.sqlcode THEN
19      DISPLAY "SQL Error occurred:", sqlca.sqlcode
20      EXIT PROGRAMY 1
21   END IF
22   WHENEVER ERROR STOP
24    ... (more instructions, stopping the program in case of error)
26 END MAIN
```

Program output in case of invalid table name:

``` linenumber
01 SQL Error occurred:      -217
```

### [Example 3]{#EXAMPLE_3}:

This example uses a `TRY/CATCH` block to trap errors. In this case, we
try to connect to an invalid database, which will raise an SQL error and
make the program flow go to the line after the `CATCH` statement:

``` linenumber
01 MAIN
02     TRY
03         DATABASE invalid_database_name
04         DISPLAY "Will not be displayed"
05     CATCH
06         DISPLAY "Exception caught, SQL error: ", SQLCA.SQLCODE
07     END TRY
08 END MAIN
```

Program output (with Informix):

``` linenumber
01 Exception caught, SQL error:        -329
```

### [Example 4]{#EXAMPLE_4}:

The code below illustrates the fact that a `TRY/CATCH` block can be used
in conjunction with a `WHENEVER` instruction: The program first executes
a `WHENEVER ANY ERROR` to define an error handler named *foo* and later
it uses a `TRY/CATCH` block to trap expression errors. In this example,
we intentionally force a division by zero. After the `TRY/CATCH` block
we force another division by zero error, which will call the *foo* error
handler:

``` linenumber
01 MAIN
02     DEFINE i INTEGER
03     WHENEVER ANY ERROR CALL foo
04     TRY
05         DISPLAY "Next exception should be handled by the catch statement"
06         LET i = i / 0
07     CATCH
08         DISPLAY "Exception caught, status: ", STATUS
09     END TRY
10     -- The previous error handler is restored after the TRY - CATCH block
11     LET status = 0
12     DISPLAY "Next exception should be handled by the foo function"
13     LET i = i / 0
14 END MAIN
15
16 FUNCTION foo()
17     DISPLAY "Function foo called, status: ", STATUS
18 END FUNCTION
```

Program output:

``` linenumber
01 Next exception should be handled by the catch statement
02 Exception caught, status:      -1202
03 Next exception should be handled by the foo function
04 Function foo called, status:      -1202
```

### [Example 5]{#EXAMPLE_5}:

The next example shows the usage of `WHENEVER ... RAISE` to propagate a
potential exception to the caller. First the program defines the *foo*
function as exception handler with `WHENEVER ANY ERROR CALL foo`, then
it calls the *do_exception* function, which instructs the runtime system
to propagate a potential error to the caller. As result, the division by
zero in line #13 will be caught by the error handler defined in the
`MAIN` block and call the *foo* function:

``` linenumber
01 MAIN
02     DEFINE i INTEGER
03     WHENEVER ANY ERROR CALL foo
04     DISPLAY "Next function call will generate an exception"
05     DISPLAY do_exception(100, 0)
06     WHENEVER ANY ERROR STOP -- reset default handler for rest of program
07     ...
08 END MAIN
09
10 FUNCTION do_exception(a, b)
11     DEFINE a, b INTEGER
12     WHENEVER ANY ERROR RAISE
13     RETURN a / b
14 END FUNCTION
15
16 FUNCTION foo()
17     DISPLAY "Exception caught, status: ", STATUS
18 END FUNCTION
```

Program output:

``` linenumber
01 Next function call will generate an exception
02 Exception caught, status:    -1202
```
