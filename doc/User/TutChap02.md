[Back to Summary](TutIndex.html)

------------------------------------------------------------------------

# Tutorial Chapter 2: Using BDL

Summary:

- [A simple BDL program](#simple)
- [Writing BDL programs](#writing)
- [Compiling and Executing the program](#CompilingandExecuting)
- [Debugging BDL programs](#debugging)
- [The \"Connect to database\" program](#connectdb)
  - [Connecting to a database](#Connecting)
  - [Variable Definition](#VariableDefinition)
  - [Variable Scope](#VariableScope)
  - [Passing Variables](#PassingVariables)
  - [Retrieving data from a database table](#Retrievingdata)
  - [Example: connectdb.4gl ](#examp_connectdb)

------------------------------------------------------------------------

## [A simple BDL program]{#simple}

This simple example displays a text message to the screen, illustrating
the structure of a BDL program.

Because Genero BDL is a structured programming language as well as a 4th
generation language, executable statements can appear only within
logical sections of the source code called program blocks. This can be
the [MAIN](Programs.html#MAIN_BLOCK) statement, a
[FUNCTION](Functions.html) statement, or a [REPORT](TutChap09.html)
statement. (Reports are discussed in [Chapter 9](TutChap09.html).)

Execution of any program begins with the special, required program block
[MAIN](Programs.html#MAIN_BLOCK)**,** delimited by the keywords MAIN and
END MAIN. The source module that contains MAIN is called the main
module. 

The [FUNCTION](Functions.html) statement is a unit of executable code,
delimited by FUNCTION and END FUNCTION, that can be called by name. In a
small program, you can write all the functions used in the program in a
single file. As programs grow larger, you will usually want to group
related functions into separate files, or source modules.  Functions are
available on a global basis. In other words, you can reference any
function in any source module of your program. 

 The following example is a small but complete Genero BDL program,
**simple.4gl **

+-----------------------------------------------------------------------+
| **Program simple.4gl**                                                |
+-----------------------------------------------------------------------+
| ``` linenumber                                                        |
| 01 -- simple.4gl                                                      |
| 02                                                                    |
| 03 MAIN                                                               |
| 04     CALL sayIt()                                                   |
| 05 END MAIN                                                           |
| 06                                                                    |
| 07 FUNCTION sayIt()                                                   |
| 08    DISPLAY "Hello, world!"                                         |
| 09 END FUNCTION  -- sayIt                                             |
| ```                                                                   |
+-----------------------------------------------------------------------+

**Notes:**

- Line `01`{.linenumber} simply lists the filename as a
  [comment](LanguageFeatures.html#LF_COMMENTS), which will be ignored by
  BDL.  
- Line `03`{.linenumber} indicates the start of the
  [MAIN](Programs.html#MAIN_BLOCK) program block.
- Line `04`{.linenumber} Within the MAIN program block, the
  [CALL](FlowControl.html#FC_CALL) statement is used to invoke the
  function named sayIt.  Although no arguments are passed to the
  function sayIt, the empty parentheses are required.  Nothing is
  returned by the function.
- Line `05`{.linenumber}  defines the end of the
  [MAIN](Programs.html#MAIN_BLOCK) program block.  When all the
  statements within the program block have been executed the program
  will terminate automatically.
- Line `07`{.linenumber}  indicates the start of the
  [FUNCTION](Functions.html) **sayIt**.
- Line `08`{.linenumber} uses the [DISPLAY](MessageDisplay.html#DISPLAY)
  statement to display a text message, enclosed within double quotes, 
  to the user.  Because the program has not opened a window or form, the
  message is displayed on the command line.
- Line `09`{.linenumber} indicates the end of the
  [FUNCTION](Functions.html).  The comment ( \-- sayIt ) is
  optional.  After the message is displayed, control in the program is
  returned to the [MAIN](Programs.html#MAIN_BLOCK) function, to line
  ` 05`{.linenumber}, the line immediately following the statement
  invoking the function.  As there are no additional statements to be
  executed (END MAIN has been reached), the program terminates.

------------------------------------------------------------------------

## [Writing BDL Programs]{#writing}

- Genero BDL source code is written as text in a source module (a file
  with a filename extension of **.4gl** ).
- BDL statements do not require a statement terminator.
- You can begin a **[comment](LanguageFeatures.html#LF_COMMENTS)** that
  terminates at the end of the current line with a pair of minus signs (
  \-- ) or  #.  Curly braces { } can be used to delimit comments that
  occupy multiple lines.
- All white space in a source code module is treated as a single space,
  so you are free to use indentations and white space for clarity.
- Although the language keywords in this example and throughout the
  tutorial are in all-capitals,  this is just a convention used in these
  documents. You may write keywords in lowercase, or any combination of
  capitals and lowercase you prefer.
- The line numbers shown in all the code examples are not a part of the
  code; they simply link the notes for the programs with the correct
  program lines.
- 

------------------------------------------------------------------------

## [Compiling and Executing the Program]{#compexec}

BDL programs are made up of a single module, or modules, containing the
program functions. 

The following [tools](Tools.html) can be used to compile and execute the
**simple** program from the command line. 

1.  Create the database schema files if they have not already been
    created:

> fgldbsch -db custdemo

2.  Compile the single module program:

> fglcomp simple.4gl

3.  Execute the program:

> fglrun simple.42m

Programs consisting of multiple modules must be compiled and linked;
this can be accomplished in one command using the following
[tool](Tools.html#TL_FGL2P):

> fgl2p -o myprog.42r simple.4gl newmodule.4gl  

The resulting program is executed using the name of the output file that
you specified:

> fglrun myprog.42r

**Tip:**

1.  You can compile and run a program without specifying the file
    extensions:

        fglcomp simple
        fglrun simple

    You can do this in one command line, adding the -M option for
    errors:

        fglcomp -M simple && fglrun simple

------------------------------------------------------------------------

## [Debugging a BDL Program]{#debugging}

You can use the command line debugger to search for programming errors.
The command line debugger is integrated in the runtime system. You
typically start a program in debug mode by passing the **-d** option to
**fglrun**.

The following lines illustrate a debug session with the previous program
sample:

    fglrun -d simple

    (fgldb) break main
    Breakpoint 1 at 0x00000000: file simple.4gl, line 2.
    (fgldb) run
    Breakpoint 1, main() at simple.4gl:2
    2         CALL sayIt()
    (fgldb) step
    sayit() at simple.4gl:6
    6         DISPLAY "Hello, world!"
    (fgldb) next
    Hello, world!
    7     END FUNCTION -- sayIt
    (fgldb) continue
    Program existed normally.
    (fgldb) quit

For more details, see the [Debugger reference](Debugger.html).

------------------------------------------------------------------------

## [The \"Connect to database\" Program]{#connectdb}

This program illustrates connecting to a database and retrieving data,
defining variables, and passing variables between functions. A row from
the **customer** table of the **custdemo** example database is retrieved
by an SQL statement and displayed to the user. 

### [Connecting to the Database]{#Connecting}

A [Database Connection](Connections.html) is a session of work, opened
by the program to communicate with a specific database server, in order
to execute SQL statements as a specific user. To connect to a database
server, most database engines require a name to identify the server, a
name to identify the database entity, a user name and a password.  

Connecting through the Open Database Interface, the database can be
specified directly, and the specification will be used as the data
source.  Or, you can define the database connection parameters
indirectly in the [FGLPROFILE](FglProfile.html) configuration file, and
the database specification will be used as a key to read the connection
information from the file.  This technique is flexible; for example, 
you can develop your application with the database name \"custdemo\" and
connect to the real database \"custdemo1\" in a production environment.

The [CONNECT](Connections.html#DC_CONNECT_TO) instruction opens a
session in multi-session mode, allowing you to open other connections
with subsequent CONNECT instructions (to other databases, for example). 
If you have multiple connections open, you can use the [SET
CONNECTION](Connections.html#DC_SET_CONNECTION) instruction to switch to
a specific session; this suspends other opened connections.  The
[DISCONNECT](Connections.html#DC_DISCONNECT) instruction can be used to
disconnect from specific sessions, or from all sessions. The end of a
program disconnects all sessions automatically.

The *user name* and *password* can be specified in the
[CONNECT](Connections.html#DC_CONNECT_TO) instruction, or defaults can
be defined in [FGLPROFILE](FglProfile.html). Otherwise,  the user name
and password provided to your operating system will generally be used
for authentication.

       CONNECT TO "custdemo"

### [Variable Definition]{#VariableDefinition}

A [Variable](Variables.html) contains volatile information of a specific
BDL [data type](DataTypes.html).** **Variables must be declared before
you use them in your program, using the
[DEFINE](Variables.html#DEFINITION) statement.  After definition,
variables have [default values](Variables.html#DEFAULT_VALUES) based on
the data type. 

          DEFINE cont_ok INTEGER

You can use the [LIKE](Variables.html#DATABASE_TYPES) keyword to declare
a variable that has the same data type as a specified column in a
database schema. The column data type defined by the database schema
must be supported by the language.  A [SCHEMA](Programs.html#DB_SCHEMA)
statement must define the database name, identifying the [database
schema files](IntroBDL.html#SchemaFiles) to be used. The column data
types are read from the schema file during compilation, not at runtime.
Make sure that your schema files correspond exactly to the production
database.

         DEFINE store_name LIKE customer.store_name

Genero BDL allows you to define structured variables as [records or
arrays](Variables.html#STRUCTURED). Examples of this are included in
later chapters.

### [Variable Scope]{#VariableScope}

[Variables](Variables.html) defined in a [FUNCTION](Functions.html),
[REPORT](Reports.html#RPT_DEFINITION) or
[MAIN](Programs.html#MAIN_BLOCK) program block have *local scope* (are
known only within the program block).  The
[DEFINE](Variables.html#DEFINITION) statement declares the variables and
causes memory to be allocated for them. DEFINE must precede any
executable statements within the same program block. A
[variable](Variables.html) with *local* scope can have its value set and
can be used only within the function in which it is defined.  Memory for
the variable is allocated when the function is called by a program, and
is released when the function ends.     

A [Variable](Variables.html) defined with *module scope* can have its
value set and can be used in any function within a single source-code
module.  The [DEFINE](Variables.html#DEFINITION) statement must appear
at the top of the module, before any program blocks. Memory for module
variables is allocated when the program starts, and is released when the
program ends.

A [Variable](Variables.html) defined with *global scope* can have its
value set and can be used in any function within any modules of the same
program. Memory for global variables is allocated when the program
starts, and is released when the program ends. 

For a well-structured program and ease of maintenance, we recommend that
you use module variables instead of global when you need persistent data
storage. You can include get/set functions in the module to make the
value of the variable accessible to functions in other modules.

A compile-time error occurs if you declare the same name for two
variables that have the same scope. You can, however, declare the same
name for variables that differ in their scope.

### [Passing Variables]{#PassingVariables}

Functions can be invoked explicitly using the
[CALL](FlowControl.html#FC_CALL) statement. [Variables](Variables.html)
can be passed as arguments to a function when it is invoked.  The
parameters can be variables, literals, constants, or any valid
expressions. Arguments are separated by a comma.  If the function
returns any values, the RETURNING clause of the
[CALL](FlowControl.html#FC_CALL) statement assigns the returned values
to variables in the calling routine. The number of input and output
parameters is static.

The function that is invoked must have a
[RETURN](FlowControl.html#FC_RETURN) instruction to transfer the control
back to the calling function and pass the return values. The number of
returned values must correspond to the number of variables listed in the
RETURNING clause of the [CALL](FlowControl.html#FC_CALL) statement
invoking this function. If the function returns only one unique value,
it can be used as a scalar function in an expression.

         CALL myfunc()

         CALL newfunc(var1) RETURNING var2, var3

         LET var2 = anotherfunc(var1)

         IF testfunc1(var1) == testfunc2(var1) THEN ...

See the [BDL stack](Functions.html#FGL_STACK) discussion in
[Functions](Functions.html) for additional information about passing and
returning variables.

### [Retrieving data from a database]{#Retrievingdata}

Using [Static SQL](StaticSql.html), an embedded SQL SELECT statement can
be used to retrieve data from a database table into program variables. 
If the SELECT statement returns only one row of data, you can write it
directly as a procedural instruction, using the INTO clause to provide
the list of variables where the column values will be fetched.  If the
SELECT statement returns more than one row of data, you must declare a
database cursor to process the result set.

------------------------------------------------------------------------

### [Example:  connectdb.4gl ]{#examp_connectdb}

**Note:**  The line numbers shown in the examples in this tutorial are
not part of the BDL code; they are used here so specific lines can be
easily referenced. The BDL keywords are shown in uppercase, as a
convention only.  The keywords also appear in green in this
documentation. 

+-----------------------------------------------------------------------+
| **Program connectdb.4gl **                                            |
+-----------------------------------------------------------------------+
| ``` linenumber                                                        |
| 01 -- connectdb.4gl                                                   |
| 02 SCHEMA custdemo                                                    |
| 03                                                                    |
| 04 MAIN                                                               |
| 05   DEFINE                                                           |
| 06    m_store_name LIKE customer.store_name                           |
| 07                                                                    |
| 08   CONNECT TO "custdemo"                                            |
| 09                                                                    |
| 10   CALL select_name(101)                                            |
| 11       RETURNING m_store_name                                       |
| 12   DISPLAY m_store_name                                             |
| 13                                                                    |
| 14   DISCONNECT CURRENT                                               |
| 15                                                                    |
| 16 END MAIN                                                           |
| 17                                                                    |
| 18 FUNCTION select_name(f_store_num)                                  |
| 19   DEFINE                                                           |
| 20    f_store_num  LIKE customer.store_num,                           |
| 21    f_store_name LIKE customer.store_name                           |
| 22                                                                    |
| 23   SELECT store_name INTO f_store_name                              |
| 24      FROM customer                                                 |
| 25     WHERE store_num = f_store_num                                  |
| 26                                                                    |
| 27   RETURN f_store_name                                              |
| 28                                                                    |
| 29 END FUNCTION  -- select_name                                       |
| ```                                                                   |
+-----------------------------------------------------------------------+

**Notes:**

- Line `02`{.linenumber} The [SCHEMA](Programs.html#DB_SCHEMA) statement
  is used to define the database schema files to be used as
  **custdemo.**  The [LIKE](Variables.html#DATABASE_TYPES) syntax has
  been used to define variables in the module. 
- Lines `05`{.linenumber} and `06`{.linenumber} Using
  [DEFINE](Variables.html#DEFINITION) the local variable
  **m_store_name**  is declared as being
  [LIKE](Variables.html#DATABASE_TYPES) the store_name column; that is,
  it has the same data type definition as the column in the **customer**
  table of the [custdemo](../Tutorial/custdemo.sql) database.
- Line `08`{.linenumber} A [connection](Connections.html#DC_CONNECT_TO)
  in multi-session mode is opened to the custdemo database, with
  connection parameters defined in [FGLPROFILE](FglProfile.html). Once
  connected to the database server, a current database session is
  started. Any subsequent SQL statement is executed in the context of
  the current database session.
- Line `10`{.linenumber} The **select_name** function is called, passing
  the literal value **101** as an argument. The function returns a value
  to be stored in the local variable **m_store_name**.
- Line `12`{.linenumber} The value of **m_store_name** is displayed to
  the user on the standard output.
- Line `14`{.linenumber} The
  [DISCONNECT](Connections.html#DC_DISCONNECT) instruction disconnects
  you from the current session.  As there are no additional lines in the
  program block, the program terminates.
- Line ` 18`{.linenumber}  Beginning of the definition of the function
  **select_name**.  The value 101 that is passed to the  function will
  be stored in the local variable **f_store_num**.
- Lines ` 19`{.linenumber}  thru
  `21 `{.linenumber}[Defines](Variables.html#DEFINITION) multiple local
  variables used in the function, separating the variables listed with a
  comma.  Notice that a variable must be declared with the same name and
  data type as the parameter listed within the parenthesis in the
  function statement, to accept the passed value.
- Lines ` 23`{.linenumber} thru `25`{.linenumber} Contains the embedded
  SELECT \... INTO** ** SQL statement to retrieve the store name for
  store #101.  The store name that is retrieved will be stored in the
  **f_store_name** local variable.  Since the store number is unique,
  the WHERE clause ensures that only a single row will be returned.  
- Line ` 27`{.linenumber} The [RETURN](FlowControl.html#FC_RETURN)
  statement causes the function to terminate, returning the value of the
  local variable **f_store_name**. The number of variables returned
  matches the number declared in the RETURNING clause of the
  [CALL](FlowControl.html#FC_CALL) statement invoking the function.
  Execution of the program continues with line ` 12`{.linenumber}.

------------------------------------------------------------------------

## [Compiling and Executing the Program]{#CompilingandExecuting}

1.  Create the database schema files if they have not already been
    created:

> fgldbsch -db custdemo

2.  Compile the single module program:

> fglcomp connectdb.4gl

3.  Execute the program:

> fglrun connectdb.42m
