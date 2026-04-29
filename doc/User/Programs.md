[Back to Contents](../index.html)

------------------------------------------------------------------------

# [Programs]{#PAGE_HEADER}

Summary:

- [Runtime Configuration](#RUNTIMECONFIG)
- [Executing Genero BDL Programs](#START_FGLRUN)
- [The MAIN block](#MAIN_BLOCK)
- [Signal Handling](#SIGNAL_HANDLING) (`DEFER`)
- [The STATUS variable](#PV_STATUS)
- [The INT_FLAG variable](#PV_INT_FLAG)
- [The QUIT_FLAG variable](#PV_QUIT_FLAG)
- [Importing modules](#IMPORT) (`IMPORT`)
  - [Importing BDL modules](#import_fgl)
  - [Importing Java classes](#import_java)
  - [Imporint C Extensions](#import_cext)
- [Program Options](#PROGRAM_OPTIONS) (`OPTIONS`)
  - [OPTIONS form-element LINE](#options-lines)
  - [OPTIONS DISPLAY ATTRIBUTES](#options-attributes)
  - [OPTIONS INPUT ATTRIBUTES](#options-attributes)
  - [OPTIONS INPUT WRAP](#options-input-wrap)
  - [OPTIONS ON TERMINATE](#options-on-terminate)
  - [OPTIONS ON CLOSE APPLICATION](#options-on-close-application)
  - [OPTIONS HELP FILE](#options-help-file)
  - [OPTIONS FIELD ORDER](#options-field-order)
  - [OPTIONS control keys](#options-keys)
  - [OPTIONS RUN IN](#options-run)
- [Running Sub-programs](#RUN) (`RUN`)
- [Stop Program Execution](#EXIT_PROGRAM) (`EXIT PROGRAM`)
- [Database Schema Specification](#DB_SCHEMA) (`SCHEMA`)
- [The NULL Constant](#PC_NULL)
- [The TRUE Constant](#PC_TRUE)
- [The FALSE Constant](#PC_FALSE)
- [The NOTFOUND Constant](#PC_NOTFOUND)
- [The BREAKPOINT instruction](#BREAKPOINT)
- [Responding to CTRL_LOGOFF_EVENT](#CTRL_LOGOFF_EVENT)

*See also*: [Compiling Programs](CompilingPrograms.html),
[Preprocessor](Preprocessor.html), [Database Schema
Files](DatabaseSchema.html), [Flow Control](FlowControl.html), [The
Application class](ClassApplication.html), [Localized
Strings](LocalizedStrings.html).

------------------------------------------------------------------------

### [Runtime Configuration]{#RUNTIMECONFIG}

You can control the behavior of the runtime system with some
[FGLPROFILE](FglProfile.html) configuration parameters.

#### [Intermediate field trigger execution]{#Dialog_fieldOrder}

`Dialog.fieldOrder = `[`{`]{.underline}`true`[`|`]{.underline}`false`[`}`]{.underline}

When this parameter is set to **true**, intermediate triggers are
executed. As the user moves to a new field with a mouse click, the
runtime system executes the `BEFORE FIELD` / `AFTER FIELD` triggers of
the input fields between the source field and the destination field.
When the parameter is set to **false**, intermediate triggers are not
executed.

**Warning: The `Dialog.fieldOrder` configuration parameter is ignored by
the [DIALOG](MultipleDialogs.html) multiple-dialog instruction or when
using the [FIELD ORDER FORM](RecordInput.html#FIELD_ORDER) option in
singular dialogs (like [INPUT](RecordInput.html)).**

For new applications, it is recommended that you set the parameter to
**false**. GUI applications allow users to jump from one field to any
other field of the form by using the mouse. Therefore, it makes no sense
to execute the `BEFORE FIELD` / `AFTER FIELD` triggers of intermediate
fields.

**Important note:** The default setting for the runtime system is
**false**; while the default setting in FGLPROFILE for
`Dialog.fieldOrder` is **true**. As a result, the overall setting after
installation is **true**. To modify the behavior of intermediate field
trigger execution, change the setting of `Dialog.fieldOrder` in
FGLPROFILE to **false**.

#### [Make current row visible after sort in tables]{#Dialog_currentRowVisibleAfterSort}

`Dialog.currentRowVisibleAfterSort = `[`{`]{.underline}`true`[`|`]{.underline}`false`[`}`]{.underline}

When this parameter is set to **true**, the offset of table page is
automatically adapted to show the current row after a sort. By default,
the offset is not changed and current row may not be visible after
sorting rows of a table. Changing this parameter has no impact on
existing code, it is just an indicator to force the dialog to shift to
the page of rows having the current row, as if the end-user had
scrollbar. You can use this parameter to get the same behavior as well
known e-mail readers. 

------------------------------------------------------------------------

### [Executing Genero BDL Programs]{#START_FGLRUN}

After programs and forms [have been compiled](CompilingPrograms.html),
you can start the execution with the [fglrun](Tools.html#TL_FGLRUN)
tool. Make sure that all required environment variables are properly
defined, like [FGLPROFILE](EnvironmentVariables.html#EV_FGLPROFILE),
[FGLGUI](EnvironmentVariables.html#EV_FGLGUI),
[FGLSERVER](EnvironmentVariables.html#EV_FGLSERVER),
[FGLLDPATH](EnvironmentVariables.html#EV_FGLLDPATH) and
[LANG/LC_ALL](Localization.html).

The GUI client must run on the workstation defined by
[FGLSERVER](EnvironmentVariables.html#EV_FGLSERVER), and all network
security components (i.e. firewalls) must allow TCP connections on the
port defined by this environment variable.

Verify the database client environment settings, and check that the
database server is running and can be accessed, for example by using a
DB vendor specific tool to execute SQL commands.

On the application server host, enter the following command in the
shell:

`fglrun `*`program-name`*`.42r`

Note that it\'s not needed to build a **.42r** program, you can also
start a **.42m** module if the [MAIN block](#MAIN_BLOCK) is defined in
that module.

It is also possible to start programs on the application server [from
the workstation where the GUI client resides]{.underline}, by using for
example rlogin or ssh network protocols. This is actually the typical
way to start applications in a production environment. For more details,
see front-end manuals.

------------------------------------------------------------------------

### [The MAIN block]{#MAIN_BLOCK}

#### Purpose:

The `MAIN` block is the starting point of the application. When the
runtime system executes a program, after some initialization, it gives
control to this program block.

#### Syntax:

`MAIN`\
`  `[`[`]{.underline}` `*`define-statement`*` `[`|`]{.underline}` `*`constant-statement`*` `[`]`]{.underline}\
`  `[`{`]{.underline}` `[`[`]{.underline}*`defer-statement`*[`]`]{.underline}` `[`|`]{.underline}` `*`fgl-statement `*[`|`]{.underline}` `*`sql-statement`*` `[`}`]{.underline}\
`  `[`[...]`]{.underline}\
`END MAIN`

#### Notes:

1.  *define-statement* defines function arguments and local
    [variables](Variables.html).
2.  *constant-statement* can be used to declare local
    [constants](Constants.html).
3.  *defer-statement* defines how to [handle signals](#SIGNAL_HANDLING)
    in the program.
4.  *fgl-statement* is any instruction supported by the language.
5.  *sql-statement* is any static SQL instruction supported by the
    language.

------------------------------------------------------------------------

### [Signal Handling]{#SIGNAL_HANDLING}

#### Purpose:

The `DEFER` instruction allows you to control the behavior of the
program when an *interruption* or *quit* signal has been received.

#### Syntax:

`DEFER `[`{`]{.underline}` INTERRUPT `[`|`]{.underline}` QUIT `[`}`]{.underline}

#### Usage:

`DEFER INTERRUPT` and `DEFER QUIT` instructions can only appear in the
MAIN block.

`DEFER INTERRUPT` indicates that the program must continue when it
receives an *interrupt* signal. By default, the program stops when it
receives an *interrupt* signal.

**Warning: Once deferred, you cannot reset to the default behavior.**

When an *interrupt* signal is caught by the runtime system and
`DEFER INTERRUPT` is used, the [`INT_FLAG`](#PV_INT_FLAG) global
variable is set to [TRUE](#PC_TRUE) by the runtime system.

Interrupt signals are raised on terminal consoles when the user presses
a key like CTRL-C, depending on the stty configuration. When a BDL
program is displayed through a front end, no terminal console is used;
therefore, users cannot send interrupt signals with the CTRL-C key. To
send an interruption request from the front end, you must define an
\'interrupt\' action view. For more details, refer to [Interruption
Handling in the Dynamic User
Interface](InteractionModel.html#INTERRUPTION).

`DEFER QUIT` indicates that the program must continue when it receives a
*quit* signal. By default, the program stops when it receives a *quit*
signal.

When a *quit* signal is caught by the runtime system and `DEFER QUIT` is
used, the [QUIT_FLAG](#PV_QUIT_FLAG) global variable is set to
[TRUE](#PC_TRUE) by the runtime system.

------------------------------------------------------------------------

### [STATUS]{#PV_STATUS}

#### Purpose:

`STATUS` is a predefined variable that contains the execution status of
the last instruction.

#### Syntax:

`STATUS`

#### Definition:


    DEFINE STATUS INTEGER

#### Usage:

The data type of `STATUS` is [INTEGER](DataTypes.html#DT_INTEGER).

`STATUS` is typically used with
[`WHENEVER ERROR CONTINUE`](Exceptions.html) (or
[`CALL`](Exceptions.html)).

`STATUS` is set by expression evaluation errors only when
`WHENEVER ANY ERROR` is used.

After an SQL statement execution, `STATUS` contains the value of
[SQLCA](Connections.html#SQLCA_RECORD).SQLCODE. Use `SQLCA.SQLCODE` for
SQL error management, and `STATUS` for 4gl errors.

`STATUS` is updated after any instruction execution. A typical mistake
is to test `STATUS` after a `DISPLAY STATUS` instruction, written after
an SQL statement.

**Warning: While `STATUS` can be modified by hand, it is not
recommended, as `STATUS` may become read-only in a later release.**

#### Example:


    01 MAIN
    02   DEFINE n INTEGER
    03   WHENEVER ANY ERROR CONTINUE
    04   LET n = 10/0
    05   DISPLAY STATUS
    06 END MAIN

------------------------------------------------------------------------

### [INT_FLAG]{#PV_INT_FLAG}

#### Purpose:

`INT_FLAG` is a predefined variable that is automatically set to
[TRUE](#PC_TRUE) when the user presses the interruption key.

#### Syntax:

`INT_FLAG`

#### Definition:


    DEFINE INT_FLAG INTEGER

#### Usage:

`INT_FLAG` is typically used with [DEFER INTERRUPT](#SIGNAL_HANDLING).
`INT_FLAG` is set to [TRUE](#PC_NULL) when an interruption event is
detected by the runtime system. The interruption event is raised when
the user presses the interruption key.

If `DEFER INTERRUPT` is enabled and the interruption event arrives
during a procedural instruction (`FOR` loop), the runtime system sets
`INT_FLAG` to `TRUE`; it is up to the programmer to manage the
interruption event (stop or continue with the procedure).

If `DEFER INTERRUPT` is enabled and the interruption event arrives
during an interactive instruction (`INPUT`, `CONSTRUCT`), the runtime
system sets `INT_FLAG` to `TRUE` and exits from the instruction. It is
recommended that you test `INT_FLAG` after an interactive instruction to
check whether the input has been cancelled.

**Warning: Once `INT_FLAG` is set to `TRUE`, it must be reset to `FALSE`
to detect a new interruption event. It is the programmer\'s
responsibility to reset the `INT_FLAG` to `FALSE`.**

#### Example:


    01 MAIN
    02   DEFINE n INTEGER
    03   DEFER INTERRUPT
    04   LET INT_FLAG = FALSE
    05   FOR n = 1 TO 1000
    06      IF INT_FLAG THEN EXIT FOR END IF
    07      ...
    08   END FOR
    09 END MAIN

------------------------------------------------------------------------

### [QUIT_FLAG]{#PV_QUIT_FLAG}

#### Purpose:

`QUIT_FLAG` is a predefined variable that is automatically set to
[TRUE](#PC_TRUE) when a \'quit event\' arrives.

#### Syntax:

`QUIT_FLAG`

#### Definition:


    DEFINE QUIT_FLAG INTEGER

#### Usage:

`QUIT_FLAG` is typically used with [DEFER QUIT](#SIGNAL_HANDLING).
`QUIT_FLAG` is set to [TRUE](#PC_NULL) when a quit event is detected by
the runtime system. The quit event is raised when the user presses the
QUIT signal key (Control+Backslash).

If `DEFER QUIT` is enabled and the quit event arrives during a
procedural instruction (`FOR` loop), the runtime system sets `QUIT_FLAG`
to `TRUE`. It is the programmer\'s responsibility to manage the quit
event (whether to stop or continue with the procedure).

If `DEFER QUIT` is enabled and the quit event arrives during an
interactive instruction (`INPUT`, `CONSTRUCT`), the runtime system sets
`QUIT_FLAG` to `TRUE` and exits from the instruction. It is recommended
that you test `QUIT_FLAG` after an interactive instruction to check
whether the input has been cancelled.

**Warning: Once `QUIT_FLAG` is set to `TRUE`, it must be reset to
`FALSE` to detect a new quit event. It is the programmer\'s
responsibility to reset the `QUIT_FLAG` to `FALSE`.**

#### Example:


    01 MAIN
    02   DEFER QUIT
    03   LET QUIT_FLAG = FALSE
    04   INPUT BY NAME ...
    05   IF QUIT_FLAG THEN
    06      ...
    07   END IF
    08 END MAIN

------------------------------------------------------------------------

### [Importing modules]{#IMPORT}

#### Purpose:

The `IMPORT` instruction imports module elements to be used by the
current module.

#### Syntax:

`IMPORT [`*`language`*`] `*`filename`*` `

#### Notes:

1.  *language* defines the programming language of the module; by
    default it is a C extension, but it can also be ` FGL` or `JAVA`.
2.  *filename* is the identifier (without the file extension) of the
    module, Java class or C Extension to be imported.

#### Usage:

The `IMPORT` instruction is used to define a dependency with an external
module. All (public) symbols of the external module can be shared and
used the current module. The ` IMPORT` instruction can import a 4gl
module, a Java class or a C Extension library.

The `IMPORT` instruction must be the first instruction in the current
module. If you specify this instruction after `DEFINE`, `CONSTANT` or
`GLOBALS`, you will get a syntax error.

The module specified with the `IMPORT` instruction can be:

- Using `IMPORT FGL `*`modulename`*: A Genero BDL module (.4gl)
  implementing Genero BDL functions, reports, types and variables.
- Using `IMPORT JAVA `*`classname`*: A Java class or class element.
- Using `IMPORT `*`libname`* (without language specification): A C
  extension implementing Genero BDL functions and variables.

The name specified after `IMPORT [FGL|JAVA]` is case-sensitive: BDL
module or Java class must exactly match the file name. However, for
backward compatibility, C Extension library names are converted to
lowercase by the compiler (therefore, we recommend you to use lowercase
file names for C Extensions). Note that a character case mismatch will
be detected on UNIX platforms, but not on Windows where the file system
is not case-sensitive. Regarding the usage of imported elements in the
rest of the code (i.e. not the `IMPORT` instruction): C Extensions and
BDL elements are case-insensitive, while Java elements are
case-sensitive.

**[Importing Genero BDL modules:]{#import_fgl}**

With `IMPORT FGL `*`modulename`*, you declare that elements of the named
.42m module can be used in the current module, without needing to link
the imported module with [fgllink](Tools.html#TL_FGLLINK) as in previous
versions of Genero BDL.

The imported module elements that can be referenced are:

- Public [functions](Functions.html)
- Public [constants](Constants.html)
- Public [user types](UserTypes.html)
- Public [module variables](Variables.html)

Note that imported modules must be compiled before compiling the
importing module: The [fglcomp](Tools.html#TL_FGLCOMP) compiler does not
do do recursive compilation.

The [FGLLDPATH](EnvironmentVariables.html#EV_FGLLDPATH) environment
variable specifies the directories to search for the 42m compiled Genero
BDL modules used by `IMPORT FGL`.

No circular references are allowed. For example when module A imports
module B, which in turn imports module A, you cannot compile one of the
modules because the 42m file of the imported module is needed. Thus
fglcomp will give error [-8403](FglErrors.html#-8403), indicating that
the imported module cannot be found:

``` linenumber
01 IMPORT FGL module_b
02 FUNCTION func_a()
03   CALL func_b()
04 END FUNCTION
```

``` linenumber
01 IMPORT FGL module_a
02 FUNCTION func_b()
03   CALL func_a()
04 END FUNCTION
```

Traditional linking is still supported for backward compatibility. To
ease migration from traditional linking to imported modules, you can mix
`IMPORT FGL` usage with [fgllink](Tools.html#TL_FGLLINK). To support
traditional linking when `IMPORT FGL` is used,
[fglcomp](Tools.html#TL_FGLCOMP) does not raise an error if a referenced
function is not found in the imported modules. This is mandatory to
compile the 42m file to be linked later with the module defining the
missing function. With the *-Wimplicit* option, you can force fglcomp to
be more strict and to detect undefined functions when compiling a
module. When this option is used, fglcomp will print warning
[-8406](FglErrors.html#-8406) if a referenced function is not defined.

The module specified in the `IMPORT FGL` instruction cannot be a 42x
library.

It is allowed to write several `IMPORT FGL` instruction with the same
module; Compilation will succeed to mimic the Java import rules.
However, you should avoid this.

``` linenumber
01 IMPORT FGL orders
02 IMPORT FGL orders
```

If a symbol is defined twice with the same name in two different
modules, the symbol must be qualified by the name of the module. This
feature overcomes the traditional 4gl limitation requiring unique
function names within a program. In the next example, both imported
modules define the same \"init()\" function, but this can be resolved by
adding the module name followed by a dot before the function names: 

``` linenumber
01 IMPORT FGL orders
02 IMPORT FGL customers
03 MAIN
04   CALL orders.init()
05   CALL customers.init()
06   ...
07 END MAIN
```

If a symbol is defined twice with the same name in the current and the
imported module, an unqualified symbol will reference the current module
symbol. The next example calls the \"init()\" function with and without
a module qualifier, the second call will reference the local function:

``` linenumber
01 IMPORT FGL orders
02 MAIN
03   CALL orders.init()  -- orders module function
04   CALL init()  -- local function
05   ...
06 END MAIN
07 FUNCTION init()
08   ...
09 END FUNCTION
```

**[Importing Java classes:]{#import_java}**

Using `IMPORT JAVA `*`classname`*, you can import and use a Java class.
The CLASSPATH environment variable defines the directories for Java
packages. See the Java documentation for more details.

Actually *classname* must be a path with package names separated by a
dot, so the actual syntax for `IMPORT JAVA` is:

`IMPORT JAVA `[`[`]{.underline}` `*`packagename .`*` `[`[...]`]{.underline}` `[`]`]{.underline}` `*`filename`*

For more details, see [Java Interface](JavaBridge.html).

It is allowed to write several `IMPORT JAVA` instruction with the same
class; Compilation will succeed to mimic the Java import rules. However,
you should avoid this:

``` linenumber
01 IMPORT JAVA java.util.regex.Matcher
02 IMPORT JAVA java.util.regex.Matcher
```

##### [Importing C Extensions:]{#import_cext}

Using `IMPORT `*`libname`* instructs the compiler and runtime system to
use the *libname* C Extension for the current module. This C Extension
must exist as a shared library (.DLL or .so) and be loadable
(environment variables must be set properly). C Extension modules used
with the `IMPORT` instruction do not have to be linked to fglrun as with
previous versions of Genero: The runtime system loads dependent C
extension modules dynamically.

The name of the module specified after the `IMPORT` keyword is converted
to lowercase by the compiler. Therefore it is recommended to use
lowercase file names only.

The [FGLLDPATH](EnvironmentVariables.html#EV_FGLLDPATH) environment
variable specifies the directories to search for the C extension
modules. Note that you may also have to setup the system environment
properly (i.e. PATH on Windows and LD_LIBRARY_PATH on UNIX) if the C
Extension library depends from other libraries.

By default, the runtime system tries to load a C extension module with
the name **userextension,** if it exists. This simplifies the migration
of existing C extensions; you just need to create a shared library named
userextension.so (or userextension.dll on Windows), and copy the file to
one of the directories defined in
[FGLLDPATH](EnvironmentVariables.html#EV_FGLLDPATH).

For more details, see [C Extensions](CExtensions.html). 

#### Example:

\-- File: account.4gl

``` linenumber
01 PRIVATE DEFINE current_account VARCHAR(20)
02 
03 PUBLIC FUNCTION set_account(id)
04   DEFINE id VARCHAR(20)
05   LET current_account = id
06 END FUNCTION
07 ...  -- File: myutils.4gl
01 PRIVATE DEFINE initialized BOOLEAN
02 
03 PUBLIC TYPE t_prog_info RECORD
04        name STRING,
05        version STRING,
06        author STRING
07      END RECORD
08 
09 PUBLIC FUNCTION init()
10   LET initialized = TRUE
11   ...
12 END FUNCTION
13 
14 PUBLIC FUNCTION fini()
15   LET initialized = FALSE
16   ...
17 END FUNCTION
```

\-- File: program.4gl

``` linenumber
01 IMPORT FGL myutils
02 IMPORT FGL account
03 DEFINE filename STRING
04 DEFINE proginfo t_prog_info  -- defined in myutils
05 MAIN
06   LET proginfo.name = "program"
07   LET proginfo.version = "0.99"
08   LET proginfo.author = "scott"
09   CALL myutils.init()  -- with module prefix
10   CALL set_account("CFX4559")  -- without module prefix
11 END MAIN
```

*See also*: [Compiling Programs](CompilingPrograms.html), [C
Extensions](CExtensions.html), [Java Interface](JavaBridge.html),
[Functions](Functions.html), [Reports](Reports.html), [User
Types](UserTypes.html), [Variables](Variables.html).

------------------------------------------------------------------------

### [Program Options]{#PROGRAM_OPTIONS}

#### Purpose:

The `OPTIONS` instruction allows you to change default program options.

#### Syntax:

`OPTIONS`\
[`{`]{.underline}` INPUT `[`[`]{.underline}`NO`[`]`]{.underline}` WRAP`\
[`|`]{.underline}` HELP FILE `*`help-filename`*\
[`|`]{.underline}` INPUT ATTRIBUTE ( `[`{`]{.underline}`FORM`[`|`]{.underline}`WINDOW`[`|`]{.underline}*`input-attributes`*[`}`]{.underline}` )`\
[`|`]{.underline}` DISPLAY ATTRIBUTE ( `[`{`]{.underline}`FORM`[`|`]{.underline}`WINDOW`[`|`]{.underline}*`display-attributes`*[`}`]{.underline}` `*`)`*\
[`|`]{.underline}` SQL INTERRUPT `[`{`]{.underline}`ON`[`|`]{.underline}`OFF`[`}`]{.underline}\
[`|`]{.underline}` FIELD ORDER `[`{`]{.underline}`CONSTRAINED`[`|`]{.underline}`UNCONSTRAINED|FORM`[`}`]{.underline}\
[`|`]{.underline}` ON TERMINATE SIGNAL CALL `*`user-function`*\
[`|`]{.underline}` ON CLOSE APPLICATION `[`{`]{.underline}`CALL `*`user-function`*`|STOP`[`}`]{.underline}\
[`|`]{.underline}` RUN IN `[`{`]{.underline}`FORM`[`|`]{.underline}`LINE`[`}`]{.underline}` MODE`\
[`|`]{.underline}` MESSAGE LINE `*`line-value`* **TUI Only!**\
[`|`]{.underline}` COMMENT LINE `[`{`]{.underline}`OFF`[`|`]{.underline}*`line-value`*[`}`]{.underline}
**TUI Only!**\
[`|`]{.underline}` PROMPT LINE `*`line-value`* **TUI Only!**\
[`|`]{.underline}` ERROR LINE `*`line-value`* **TUI Only!**\
[`|`]{.underline}` FORM LINE `*`line-value`* **TUI Only!**\
[`|`]{.underline}` INSERT KEY `*`key-name`* **TUI Only!**\
[`|`]{.underline}` DELETE KEY `*`key-name`* **TUI Only!**\
[`|`]{.underline}` NEXT KEY `*`key-name`* **TUI Only!**\
[`|`]{.underline}` PREVIOUS KEY `*`key-name`* **TUI Only!**\
[`|`]{.underline}` ACCEPT KEY `*`key-name`* **TUI Only!**\
[`|`]{.underline}` HELP KEY `*`key-name`* **TUI Only!**\
[`}`]{.underline}` `[`[,...]`]{.underline}

#### Usage:

A program can include several `OPTIONS` statements. If these statements
conflict in their specifications, the ` OPTIONS` statement most recently
encountered at runtime prevails. `OPTIONS` can specify the following
features of other statements (such as [CONSTRUCT](Construct.html),
[DISPLAY](RecordDisplay.html), [DISPLAY ARRAY](DisplayArray.html),
[DISPLAY FORM](WindowsAndForms.html),
[ERROR](MessageDisplay.html#ERROR), [INPUT](RecordInput.html), [INPUT
ARRAY](InputArray.html), [MESSAGE](MessageDisplay.html#MESSAGE), [OPEN
FORM](WindowsAndForms.html), [OPEN WINDOW](WindowsAndForms.html),
[PROMPT](Prompt.html) and [RUN](#RUN) ):

- Positions of the reserved lines
- Input and display attributes
- Logical key assignments
- The name of the Help file
- SQL statement interruption
- Field traversal constraints
- Default screen display mode

#### [Defining the default position of reserved lines]{#options-lines} **TUI Only!**

The following options define the positions of reserved lines in
[TUI](FglTerms.html#TEXT_USER_INTERFACE) mode. Is it not recommended
that you use these options in
[GUI](FglTerms.html#GRAPHICAL_USER_INTERFACE) mode, as most have no
effect on the display.

- `COMMENT LINE` specifies the position of the Comment line. The comment
  line displays messages defined with the `COMMENT` attribute in the
  form specification file. The default is (`LAST-1`) for the SCREEN, and
  `LAST` for all other [windows](WindowsAndForms.html). You can hide the
  comment line with `COMMENT LINE OFF`.
- `ERROR LINE` specifies the position on the screen of the Error line
  that displays the text of the [ERROR](MessageDisplay.html#ERROR)
  statement. The default is the `LAST` line of the SCREEN.
- `FORM LINE` specifies the position of the first line of a form. The
  default is (`FIRST+2`), or line 3 of the [current
  window](WindowsAndForms.html).
- `MENU LINE` specifies the position of the Menu line. This displays the
  menu name and options, as defined by the [MENU](Menus.html) statement.
  The default is the `FIRST` line in the [window](WindowsAndForms.html).
- `MESSAGE LINE` specifies the position of the Message line. This
  reserved line displays the text of the
  [MESSAGE](MessageDisplay.html#MESSAGE) statement. The default is
  (`FIRST+1`), or line 2 of the [current window](WindowsAndForms.html).
- `PROMPT LINE` specifies the position of the Prompt line where the text
  of [PROMPT](Prompt.html) statements is displayed. The default value is
  the `FIRST` line in the [window](WindowsAndForms.html).

You can specify any of the following positions for each reserved line:

::: {align="center"}
  ----------------------- ----------------------------------------------------
  **Expression**          **Description**
  `FIRST`                 The first line of the screen or window.
  `FIRST + `*`integer`*   A relative line position from the first line.
  *`integer`*             An absolute line position in the screen or window.
  `LAST - `*`integer`*    A relative line position from the last line.
  `LAST`                  The last line of the screen or window.
  ----------------------- ----------------------------------------------------
:::

#### [Defining the default display and the input attributes]{#options-attributes}

Any attribute defined by the `OPTIONS` statement remains in effect until
the runtime system encounters a statement that redefines the same
attribute. This can be another OPTIONS statement, or an `ATTRIBUTE`
clause in one of the following statements:

- [CONSTRUCT](Construct.html), [INPUT](RecordInput.html),
  [DISPLAY](RecordDisplay.html), [DIALOG](MultipleDialogs.html), [INPUT
  ARRAY](InputArray.html) or [DISPLAY ARRAY](DisplayArray.html)
- [OPEN WINDOW](WindowsAndForms.html#OPEN_WINDOW)

The `ATTRIBUTE` clause in these statements only redefines the attributes
temporarily. After the window closes (in the case of an [OPEN
WINDOW](WindowsAndForms.html#OPEN_WINDOW) statement) or after the
statement terminates (in the case of a [CONSTRUCT](Construct.html),
[INPUT](RecordInput.html), [DISPLAY](RecordDisplay.html),
[DIALOG](MultipleDialogs.html), [INPUT ARRAY](InputArray.html), or
[DISPLAY ARRAY](DisplayArray.html) statement), the runtime system
restores the attributes from the most recent `OPTIONS` statement.

The `FORM` keyword in `INPUT ATTRIBUTE` or `DISPLAY ATTRIBUTE` clauses
instructs the runtime system to use the input or display attributes of
the [current form](WindowsAndForms.html). Similarly, you can use the
`WINDOW` keyword of the same clauses to instruct the program to use the
input or display attributes of the [current
window](WindowsAndForms.html). You cannot combine the `FORM` or `WINDOW`
attributes with any other attributes.

The following table shows the valid *input-attributes* and
*display-attributes*:

::: {align="center"}
  --------------------------------------------------------- ------------------------------------------------
  **Attribute**                                             **Description**
  `BLACK, BLUE, CYAN, GREEN, MAGENTA, RED, WHITE, YELLOW`   The TTY color of the displayed text.
  `BOLD, DIM, INVISIBLE, NORMAL`                            The TTY font attribute of the displayed text.
  `REVERSE, BLINK, UNDERLINE`                               The TTY video attribute of the displayed text.
  --------------------------------------------------------- ------------------------------------------------
:::

#### [Defining the form input loop]{#options-input-wrap}

The tab order in which the screen cursor visits fields of a form is that
of the *field list* of currently executing [CONSTRUCT](Construct.html),
[INPUT](RecordInput.html), and [INPUT ARRAY](InputArray.html)
statements, unless the tab order has been modified by a `NEXT FIELD`
clause. By default, the interactive statement terminates if the user
presses RETURN in the last field (or if the entered data fills the last
field and that field has the [AUTONEXT](FSFAttributes.html#FA_AUTONEXT)
attribute).

The `INPUT WRAP` keywords change this behavior, causing the cursor to
move from the last field to the first, repeating the sequence of fields
until the user presses the Accept key. The `INPUT NO WRAP` option
restores the default input loop behavior.

#### [Application Termination]{#options-on-terminate}

The `OPTIONS ON TERMINATE SIGNAL CALL `*`function`* defines the function
that must be called when the application receives the SIGTERM signal.
With this option, you can control program termination - for example, by
using [ROLLBACK WORK](Transactions.html#TI_ROLLBACK_WORK) to cancel all
pending SQL operations. If this statement is not called, the program is
stopped with an exit value of SIGTERM (15).

On Microsoft Windows platforms, the function will be called in the
following cases:

- The console window that the program was started from is closed.
- The current user session is terminated (i.e. the user logs off).
- The system is shut down.

#### [Front-End Termination]{#options-on-close-application}

The `OPTIONS ON CLOSE APPLICATION CALL `*`function`* can be used to
execute specific code when the front-end stops. For example, when the
client program is stopped, when the user session is ended, or when the
workstation is shut down.

Before stopping, the front-end sends a internal event that is trapped by
the runtime system. When a callback function is specified with the above
program option command, the application code that was executing is
canceled, and the callback function is executed before the program
stops.

You typically do a [ROLLBACK WORK](Transactions.html#TI_ROLLBACK_WORK),
close all files, and release all resources in that function.

The default is `OPTIONS ON CLOSE APPLICATION STOP`. This instructs the
runtime system to stop without any error message if the front end
program is stopped.

Note that a front-end program crash or network failure is not detected
and cannot be handled by this instruction.

#### [Defining the message file]{#options-help-file}

The `HELP FILE` clause specifies an expression that returns the filename
of a help file. This filename can also include a pathname. Messages in
this file can be referenced by number in form-related statements, and
are displayed at runtime when the user presses the Help key.

By default, message files are searched in the current directory, then
[DBPATH](EnvironmentVariables.html#EV_DBPATH)/[FGLRESOURCEPATH](EnvironmentVariables.html#EV_FGLRESOURCEPATH)
environment variable is scanned to find the file.

See also [Message Files](MessageFiles.html).

#### [Defining field tabbing order]{#options-field-order}

Tabbing order is used in dialogs where individual fields can get the
focus, like in [INPUT](RecordInput.html), [INPUT ARRAY](InputArray.html)
or [CONSTRUCT](Construct.html). The `FIELD ORDER` program option defines
the default behavior when moving from field to field with the TAB key or
UP/DOWN ARROW keys in [TUI mode](FglTerms.html#TEXT_USER_INTERFACE).

By default, the tabbing order is defined by the list of fields used by
the program instruction. This corresponds to `FIELD ORDER CONSTRAINED`
option, which is the default.

When using `FIELD ORDER UNCONSTRAINED` in [TUI
mode](FglTerms.html#TEXT_USER_INTERFACE), the UP ARROW and DOWN ARROW
keys will move the cursor to the field above or below the current field,
respectively. Note that when using the default `FIELD ORDER CONSTRAINED`
option, the UP ARROW and DOWN ARROW keys move the cursor to the previous
or next field, respectively. If `FIELD ORDER UNCONSTRAINED` is used, the
[Dialog.fieldOrder](Programs.html#Dialog_fieldOrder) FGLPROFILE entry is
ignored.

Note that the `UNCONSTRAINED` option can only be supported in [TUI
mode](FglTerms.html#TEXT_USER_INTERFACE), with a simple form layout. It
is not recommended to use this option in [GUI
mode](FglTerms.html#GRAPHICAL_USER_INTERFACE).

When you specify `FIELD ORDER FORM`,  the tabbing order is defined by
the [TABINDEX](FSFAttributes.html#FA_TABINDEX) attributes of the current
form fields. This allows you to define a tabbing order specific to the
layout of the form, independent of the program instruction, and is the
preferred way to define tabbing order in GUI mode. If `FIELD ORDER FORM`
is used, the [Dialog.fieldOrder](Programs.html#Dialog_fieldOrder)
FGLPROFILE entry is ignored.

The next example shows the effect of the `FIELD ORDER` program option,
not that the .per file defines tab indexes:

Form file:


    01 LAYOUT
    02 GRID
    03 {
    04   First name:  [f001            ] Last name:   [f002            ]
    05   Address:     [f003                                            ]
    06 }
    07 END
    08 END
    09 ATTRIBUTES
    10 EDIT f001 = FORMONLY.fname, TABINDEX = 2;
    11 EDIT f002 = FORMONLY.lname, TABINDEX = 1;
    12 EDIT f003 = FORMONLY.address, TABINDEX = 0;
    13 END

Program file:


    01 MAIN
    02   DEFINE fname, lname CHAR(20), address CHAR(50)
    03   OPTIONS INPUT WRAP
    04   OPEN FORM f1 FROM "f1"
    05   DISPLAY FORM f1
    06   OPTIONS FIELD ORDER CONSTRAINED
    07   INPUT BY NAME fname, address, lname
    08   OPTIONS FIELD ORDER UNCONSTRAINED
    09   INPUT BY NAME fname, address, lname
    10   OPTIONS FIELD ORDER FORM
    11   INPUT BY NAME fname, address, lname
    12 END MAIN

#### [Defining control keys]{#options-keys} **TUI Only!**

The `OPTIONS` instruction can specify physical keys to support logical
key functions in the interactive instructions.

The physical key definition options are only provided for backward
compatibility with the character mode. These as not supported in
[GUI](FglTerms.html#GRAPHICAL_USER_INTERFACE) mode. Use the [Action
Defaults](ActionDefaults.html) to define accelerator keys for actions.
In TUI mode, action defaults accelerators are ignored.

Description of the keys:

- The `ACCEPT KEY` specifies the key that validates a
  [CONSTRUCT](Construct.html), [INPUT](RecordInput.html),
  [DIALOG](MultipleDialogs.html), [INPUT ARRAY](InputArray.html), or
  [DISPLAY ARRAY](DisplayArray.html) statement.\
  The default `ACCEPT KEY` is `ESCAPE`.
- The `DELETE KEY` specifies the key in [INPUT ARRAY](InputArray.html)
  statements that deletes a screen record.\
  The default `DELETE KEY` is `F2`.
- The `INSERT KEY` specifies the key that opens a screen record for data
  entry in [INPUT ARRAY](InputArray.html).\
  The default `INSERT KEY` is `F1`.
- The `NEXT KEY` specifies the key that scrolls to the next page of a
  program array of records in an [INPUT ARRAY](InputArray.html) or
  [DISPLAY ARRAY](DisplayArray.html) statement.\
  The default `NEXT KEY` is `F3`.
- The `PREVIOUS KEY` specifies the key that scrolls to the previous page
  of program records in an [INPUT ARRAY](InputArray.html) or [DISPLAY
  ARRAY](DisplayArray.html) statement.\
  The default `PREVIOUS KEY` is `F4`.
- The `HELP KEY` specifies the key to display help messages.\
  The default `HELP KEY` is `CONTROL-W`.

You can specify the following keywords for the physical key names:

::: {align="center"}
  --------------------------- ----------------------------------------------------------------------------------------
  **Key Name**                **Description**
  `ESC` or `ESCAPE`           The ESC key (not recommended, use `ACCEPT` instead).
  `INTERRUPT`                 The interruption key (on UNIX, interruption signal).
  `TAB`                       The TAB key (not recommended).
  `CONTROL-`*`char`*          A control key where *char* can be any character except A, D, H, I, J, K, L, M, R, or X
  `F1` through `F255`         A function key.
  `LEFT`                      The left arrow key.
  `RETURN` or `ENTER`         The return key.
  `RIGHT`                     The right arrow key.
  `DOWN`                      The down arrow key.
  `UP`                        The up arrow key.
  `PREVIOUS` or `PREVPAGE`    The previous page key.
  `NEXT` or `NEXTPAGE`        The next page key.
  --------------------------- ----------------------------------------------------------------------------------------
:::

You might not be able to use other keys that have special meaning to
your version of the operating system. For example, CONTROL-C, CONTROL-Q,
and CONTROL-S specify the Interrupt, XON, and XOFF signals on many UNIX
systems.

#### [Setting default screen modes]{#options-run}

When using character terminals, BDL recognizes two screen display modes:
line mode (`IN LINE MODE`) and formatted mode (`IN FORM MODE`). The
`OPTIONS` and `RUN` statements can explicitly specify a screen mode. The
`OPTIONS` statement can set separate defaults for these statements.

After `IN LINE MODE` is specified, the terminal is in the same state (in
terms of stty options) as when the program began. This usually means
that the terminal input is in cooked mode, with interruption enabled,
and input not available until after a newline character has been typed.

The `IN FORM MODE` keywords specify raw mode, in which each character of
input becomes available to the program as it is typed or read.

By default, a program operates in line mode, but so many statements take
it into formatted mode (including `OPTIONS` statements that set keys,
[DISPLAY](RecordDisplay.html), [OPEN
WINDOW](WindowsAndForms.html#OPEN_WINDOW), [DISPLAY
FORM](WindowsAndForms.html#DISPLAY_FORM), and other screen interaction
statements), that typical programs are actually in formatted mode most
of the time.

When the `OPTIONS` statement specifies `RUN IN FORM MODE`, the program
remains in formatted mode if it currently is in formatted mode, but it
does not enter formatted mode if it is currently in line mode.

When the `OPTIONS` statement specifies `RUN IN LINE MODE`, the program
remains in line mode if it is currently in line mode, and it switches to
line mode if it is currently in formatted mode.

------------------------------------------------------------------------

### [Runing Sub-programs (RUN)]{#RUN}

#### Purpose:

The `RUN` instruction creates a new process and executes the command
passed as an argument.

#### Syntax:

`RUN `*`command`*` `\
`  `[`[`]{.underline}` IN `[`{`]{.underline}`FORM`[`|`]{.underline}`LINE`[`}`]{.underline}` MODE `[`]`]{.underline}\
*` `*` `[`[`]{.underline}` RETURNING `*`variable`*` `[`|`]{.underline}` WITHOUT WAITING `[`]`]{.underline}

#### Notes:

1.  *command* is a [string expression](Expressions.html#EX_STRING)
    containing the command to be executed.
2.  *variable* is an [integer variable](Variables.html) receiving the
    execution status of the command.

#### Usage:

The `RUN` instruction executes an operating system command line;  you
can even run a second application as a secondary process. When the
command terminates, the runtime system resumes execution.

**Warning: The execution status in the `RETURNING` clause is system
dependent. See below for more details.**

[Defining the command execution shell]{.underline}

In order to execute the command line, the `RUN` instruction uses the
OS-specific shell defined in the environment of the current user. On
UNIX, this is defined by the **SHELL** environment variable. On Windows,
this is defined by **COMSPEC**. Note that on Windows, the program
defined by the **COMSPEC** variable must support the **/c** option as
CMD.EXE.

[Waiting for the sub-process]{.underline}

By default, the runtime system waits for the end of the execution of the
command.

Unless you specify `WITHOUT WAITING`, the `RUN` instruction also does
the following:

1.  Causes execution of the current program to pause.
2.  Displays any output from the specified command in a new window.
3.  After that command completes execution, closes the new window and
    restores the previous display in the screen.

If you specify `WITHOUT WAITING`, the specified command line is executed
as a background process, and generally does not affect the visual
display. This clause is useful if you know that the command will take
some time to execute, and your program does not need the result to
continue. It is also used in
[GUI](FglTerms.html#GRAPHICAL_USER_INTERFACE) mode to start another
Genero program. In [TUI](FglTerms.html#TEXT_USER_INTERFACE) mode, you
must not use this clause because two programs cannot run simultaneously
on the same terminal.

[Catching the execution status]{.underline}

The `RETURNING` clause saves the termination status code of the command
that `RUN` executes in a [program variable](Variables.html) of type
[SMALLINT](DataTypes.html#DT_SMALLINT). You can then examine this
variable in your program to determine the next action to take. A status
code of zero usually indicates that the command has terminated normally.
Non-zero exit status codes usually indicate that an error or a signal
caused execution to terminate.

The execution status provided by the `RETURNING` clause [is
platform-dependent]{.underline}. On Unix systems, the value is composed
of two bytes having different meanings. On Windows platforms, the
execution status is usually zero for success, not zero if an error
occurred.

On Unix systems, the lower byte (x mod 256) of the return status defines
the termination status of the RUN command. The higher byte (x / 256) of
the return status defines the execution status of the program. On
Windows systems, the value of the return status defines the execution
status of the program.

[IN LINE MODE and IN FORM MODE]{.underline}

By default, programs operate in *LINE MODE*, but as many statements take
it into *FORM MODE* (including [OPTIONS](#PROGRAM_OPTIONS) statements
that set keys, [DISPLAY](RecordDisplay.html), [OPEN
WINDOW](WindowsAndForms.html#OPEN_WINDOW), [DISPLAY
FORM](WindowsAndForms.html#DISPLAY_FORM), and other screen interaction
statements), typical programs are actually in *FORM MODE* most of the
time.

According to the type of command to be executed, you may need to use the
`IN `[`{`]{.underline}`LINE`[`|`]{.underline}`FORM`[`}`]{.underline}` MODE`
clause with the `RUN` instruction. It defines how the terminal or the
graphical front-end behaves when running the child process.

Besides `RUN`, the [OPTIONS](#PROGRAM_OPTIONS), [START
REPORT](Reports.html), and [REPORT](Reports.html) statements can
explicitly specify a screen mode. If no screen mode is specified in the
`RUN` command, the current value from the [OPTIONS](#PROGRAM_OPTIONS)
statement is used. This is, by default, `IN LINE MODE`. The default
screen mode for `PIPE` specifications in
[REPORT](Reports.html#RPT_DRV_START)  is `IN FORM MODE`.

When the `RUN` statement specifies `IN FORM MODE`, the program remains
in *form mode* if it is currently in *form mode*, but it does not enter
*form mode* if it is currently in *line mode*. When the prevailing `RUN`
option specifies `IN LINE MODE`, the program remains in *line mode* if
it is currently in *line mode*, and it switches to *line mode* if it is
currently in *form mode*. This also applies to the `PIPE` option.

Typically, if you need to run another interactive program, you must use
the `IN LINE MODE` clause:

- In a [TUI](FglTerms.html#TEXT_USER_INTERFACE) mode, the terminal is in
  the same state (in terms if *tty* options) as when the program began.
  Usually the terminal input is in cooked mode, with interrupts enabled
  and input not becoming available until after a new-line character is
  typed.
- In a Graphical UI, if the `WITHOUT WAITING` clause in used, the
  front-end is warned before the child process is started (this causes a
  first network round-trip) After the child is started, the front-end is
  warned that the command was executed (second network round-trip). If
  the `RUN` command must wait for child termination (i.e. no
  `WITHOUT WAITING` clause is used), no particular action is taken.

However, if you want to execute a sub-process running silently (batch
program without output), you must use the `IN FORM MODE` clause:

- In a [TUI](FglTerms.html#TEXT_USER_INTERFACE) mode, the screen stays
  in *form mode* if it was in *form mode*, which saves a clear / redraw
  of the screen. The `FORM` mode specifies the terminal raw mode, in
  which each character of input becomes available to the program as it
  is typed or read.
- In a Graphical UI, no particular action is taken to warn the front-end
  (there is no need to warn the front-end for batch program execution).

To summarize, the FORM MODE must be used to optimize programs, if the
child program does not do any output. If the child program uses
interactive instructions, displays messages to the terminal, or if you
don\'t known what it does, just use the RUN instruction in LINE MODE
(which is the default).

It is recommended that you use functions to encapsulate child program
and system command execution:

``` linenumber
01 MAIN
02   DEFINE result SMALLINT
03   CALL runApplication("app2 -p xxx")
04   CALL runBatch("ls -l", FALSE) RETURNING result
05   CALL runBatch("ls -l > /tmp/files", TRUE) RETURNING result
06 END MAIN
07
08 FUNCTION runApplication(pname)
09    DEFINE pname, cmd STRING
10    LET cmd = "fglrun " || pname
11    IF fgl_getenv("FGLGUI") == 1 THEN
12       RUN cmd WITHOUT WAITING
13    ELSE
14       RUN cmd
15    END IF
16 END FUNCTION
17
18 FUNCTION runBatch(cmd, silent)
19    DEFINE cmd STRING
20    DEFINE silent STRING
21    DEFINE result SMALLINT
22    IF silent THEN
23       RUN cmd IN FORM MODE RETURNING result
24    ELSE
25       RUN cmd IN LINE MODE RETURNING result
26    END IF
27    IF fgl_getenv("OS") MATCHES "Win*" THEN
28       RETURN result
29    ELSE
30       RETURN ( result / 256 )
31    END IF
32 END FUNCTION
```

------------------------------------------------------------------------

### [Stop Program Execution (EXIT PROGRAM)]{#EXIT_PROGRAM}

#### Purpose:

The `EXIT PROGRAM` instruction terminates the execution of the program.

#### Syntax:

`EXIT PROGRAM `[`[`]{.underline}` `*`exit-code`*` `[`]`]{.underline}

#### Notes:

1.  *exit-code* is a valid [integer
    expression](Expressions.html#EX_INTEGER) that can be read by the
    process which invoked the program.

#### Usage:

Use the `EXIT PROGRAM` instruction to stop the execution of the current
program instance.

*exit-code* must be zero by default for normal, errorless termination.

**Warnings: *exit-code* is converted into a positive integer between 0
and 255 (8 bits).**

#### Example:


    01 MAIN
    02   DISPLAY "Emergency exit."
    03   EXIT PROGRAM (-1)
    04   DISPLAY "This will never be displayed !"
    05 END MAIN

------------------------------------------------------------------------

### [Database Schema Specification]{#DB_SCHEMA}

#### Purpose:

**Database Schema Specification** identifies the [database schema
files](DatabaseSchema.html) to be used for compilation.

#### Syntax 1:

`SCHEMA `*`dbname`*

#### Syntax 2:

[`[`]{.underline}`DESCRIBE`[`]`]{.underline}` DATABASE `*`dbname`*

#### Notes:

1.  *dbname* identifies the name of the [database schema
    file](DatabaseSchema.html) to be used.

#### Usage:

The `SCHEMA `*`dbname`* instruction defines the database schema files to
be used for compilation, where *dbname* identifies the name of the
[database schema file](DatabaseSchema.html) to be used.

[`[`]{.underline}`DESCRIBE`[`]`]{.underline}` DATABASE` is supported for
backward compatibility, but it is strongly recommended that you use
`SCHEMA` instead.  The `SCHEMA` instruction defines only the database
schema for compilation, and not the default database to connect to at
runtime, which can have a different name than the development database.

The *dbname* database name must be expressed explicitly and not as a
variable, as it can be in a [regular DATABASE](Connections.html)
instruction inside a program block.

Use this instruction outside any program block, before a
[variable](Variables.html) declaration with `DEFINE LIKE` instructions.
It must precede any program block in each module that includes a
`DEFINE…LIKE` declaration or `INITIALIZE…LIKE` and `VALIDATE…LIKE`
statements. It must precede any `GLOBALS…END GLOBALS` block. It must
also precede any `DEFINE…LIKE` declaration of module variables.

The [`[`]{.underline}`DESCRIBE`[`]`]{.underline}` DATABASE` instruction
defines both the database schema files for compilation and the default
database to connect to at runtime when the `MAIN` block is executed,
while `SCHEMA` defines only the database schema to be used during
compilation.

For backward compatibility reasons, *dbname* can actually be written
with different syntaxes:

*`  database`\
`| database`*` @ `*`server`\
`| "string`*`"   -- where `*`string`*` can be for ex //server/database`

However, such database specification is Informix specific and should be
avoided. Use simple database identifiers only, in lowercase.

When using a simple identifier for the database name, the compiler
converts the name to lowercase before searching the schema file.
However, if a double quoted string is used as database name, the name
will be used as is to find the schema file.

#### Example:


    01 SCHEMA dbdevelopment -- Compilation database schema
    02 DEFINE rec RECORD LIKE customer.*
    03 MAIN
    04    DATABASE dbproduction -- Runtime database specification
    05    SELECT * INTO rec.* FROM customer WHERE custno=1
    06 END MAIN

------------------------------------------------------------------------

### [NULL Constant]{#PC_NULL}

#### Purpose:

The `NULL` constant is provided as \"nil\" value.

#### Syntax:

`NULL`

#### Usage:

When comparing variables to `NULL`, use the [IS
NULL](Operators.html#OP_ISNULL) operator, not the equal operator.

If an element of an expression is [NULL](#PC_NULL), the expression is
evaluated to `NULL`.

Variables are initialized to `NULL` or to zero according to their [data
type](DataTypes.html).

Empty character string literals (`""`) are equivalent to `NULL`.

**Warning: `NULL` cannot be used with the = equal comparison operation,
you must use [IS NULL](Operators.html#OP_ISNULL).**

#### Example:


    01 MAIN
    02   DEFINE s CHAR(5)
    03   LET s = NULL
    04   DISPLAY "s IS NULL evaluates to:"
    05   IF s IS NULL THEN 
    06      DISPLAY "TRUE" 
    07   ELSE 
    08      DISPLAY "FALSE" 
    09   END IF
    10 END MAIN

------------------------------------------------------------------------

### [TRUE Constant]{#PC_TRUE}

#### Purpose:

The `TRUE` constant is a predefined boolean value that evaluates to 1.

#### Syntax:

`TRUE`

#### Example:


    01 MAIN
    02   IF FALSE = TRUE THEN
    03      DISPLAY "Something wrong here"
    04   END IF
    05 END MAIN

------------------------------------------------------------------------

### [FALSE Constant]{#PC_FALSE}

#### Purpose:

The `FALSE` constant is a predefined boolean value that evaluates to 0.

#### Syntax:

`FALSE`

#### Example:


    01 FUNCTION isodd( value )
    02   DEFINE value INTEGER
    03   IF value MOD 2 = 1 THEN
    04      RETURN TRUE
    05   ELSE
    06      RETURN FALSE
    07   END IF
    08 END FUNCTION

------------------------------------------------------------------------

### [NOTFOUND Constant]{#PC_NOTFOUND}

#### Purpose:

The `NOTFOUND` constant is a predefined integer value that evaluates to
100.

#### Syntax:

`NOTFOUND`

#### Usage:

This constant is used to test the execution status of an SQL statement
returning a result set, to check whether rows have been found.

#### Example:


    01 MAIN
    02   DATABASE stores
    03   SELECT tabid FROM systables WHERE tabid = 1
    04   IF SQLCA.SQLCODE = NOTFOUND THEN
    05      DISPLAY "No row was found"
    06   END IF
    07 END MAIN

------------------------------------------------------------------------

### [BREAKPOINT]{#BREAKPOINT}

#### Purpose:

The `BREAKPOINT` instruction sets a program breakpoint when running in
debug mode.

#### Syntax:

`BREAKPOINT`

#### Usage:

Normally, to set a breakpoint when you debug a program, you must use the
[break command](Debugger.html#CMD_BREAK) of the debugger. But in some
situations, you might need to set the breakpoint programmatically.
Therefore, the `BREAKPOINT` instruction has been added to the language.

When you start [fglrun](Tools.html#TL_FGLRUN) in debug mode, if the
program flow encounters a `BREAKPOINT` instruction, the program
execution stops and the debug prompt is displayed, to let you enter a
debugger command.

The `BREAKPOINT` instruction is ignored when not running in debug mode.

#### Example:


    01 MAIN
    02   DEFINE i INTEGER
    03   LET i=123
    04   BREAKPOINT
    05   DISPLAY i
    06 END MAIN

------------------------------------------------------------------------

### [Responding to CTRL_LOGOFF_EVENT]{#CTRL_LOGOFF_EVENT}

#### Purpose:

On Windows platforms, when the user disconnects, the system sends a
CTRL_LOGOFF_EVENT event to all console applications. When the DVM
receives this event, it stops immediately (a simple exit(0) system call
is done).

On a Windows Terminal Server, if an Administrator user closes his
session, a CTRL_LOGOFF_EVENT is sent to all console applications started
by ANY user connected to the machine (even if these applications were
not started by the Administrator).

To prevent the DVM from stopping on a logoff event, you can use the
`fglrun.ignoreLogoffEvent` entry in the [FGLPROFILE](FglProfile.html)
configuration file. If this entry is set to `true`, the
CTRL_LOGOFF_EVENT event is ignored by the DVM.

`fglrun.ignoreLogoffEvent = true`

As a result, when the Administrator user disconnects on a Windows
Terminal Server, programs started by remote users would not stop.
