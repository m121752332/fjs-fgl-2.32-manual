[Back to Contents](../index.html)

------------------------------------------------------------------------

# The Preprocessor

Summary:

[Basics](#DEFINITION)

[Command line syntax](#CMDLINE)

[File inclusion](#FGLPP_INCLUDE) `&include`

[Simple macro definition](#FGLPP_SIMPLE_MACRO) `&define`

[Function macro definition](#FGLPP_FUNCTION_MACRO)` &define`

[Stringification](#FGLPP_STRINGIFICATION)

[Concatenation](#FGLPP_CONCATENATION)

[Predefined macros](#FGLPP_PREDEFINED)

[Un-define a macro](#FGLPP_UNDEF)` &undef`

[Conditional
compilation](#FGLPP_CONDITION)` &ifdef,&ifndef,&else,&endif`

*See also:* [Programs](Programs.html), [Tools](Tools.html)

------------------------------------------------------------------------

### [Basics]{#DEFINITION}

The preprocessor is used to transform your sources before compilation.
It allows you to include other files and to define macros that will be
expanded when used in the source. It behaves similar to the C
Preprocessor, with some differences.

The preprocessor transforms files as follows:

- The source file is read and split into lines.
- Continued lines are merged into one long line if it is part of a
  preprocessor definition.
- Comments are not removed unless they appear in a macro definition.
- Each line is split into a list of lexical tokens.

The preprocessor implements the following features :

1.  File inclusion
2.  Conditional compilation
3.  Macro definition and expansion

There are two kind of macros:

1.  Simple macros
2.  Function macros

where function macros look like function calls.

If a preprocessing directive is invalid, the compilers will generate a
**.err** file with the preprocessing error included in the source file
at the line position where the problem exists. When using the -M option,
preprocessor errors will be printed to **stderr**, like regular compiler
errors.

------------------------------------------------------------------------

### [Compilers command line options]{#CMDLINE}

Preprocessor options can be used with [fglcomp](Tools.html#TL_FGLCOMP)
and [fglform](Tools.html#TL_FGLFORM) compilers.

#### File inclusion path:

` -I `*`path`*

The **-I** option defines a path used to search files included by the
`&include` directives.

#### Macro definition:

` -D `*`identifier`*

The **-D** option defines a macro with the value 1, so that it can be
used conditional directives like `&ifdef`.

#### Preprocessing only:

` -E`

By using the **-E** option, only the pre-processing phase is done by the
compilers. Result is dumped in standard output.

#### Preprocessing options:

` -p [nopp|noln|fglpp]`

When using option `-p nopp`, it disables the preprocessor phase.

By using option `-p noln` with the **-E** preprocessing-only option, you
can remove line number information and un-necessary empty lines.

By default, the preprocessor expects an ampersand \'**&**\' as
preprocessor symbol for macros. The option `-p fglpp` enables the old
syntax, using the sharp \'**\#**\' as preprocessor symbol. Note that the
sharp \'**\#**\' syntax is not compatible with single-line comments.

#### Examples:

`fglcomp -E -D DEBUG -I /usr/sources/headers program.4gl`

`fglcomp -E -p fglpp -I /usr/sources/headers program.4gl`

`fglcomp -E -p nopp -I /usr/sources/headers program.4gl`

------------------------------------------------------------------------

### [File Inclusion]{#FGLPP_INCLUDE}

#### Purpose:

The `&include` directive instructs the preprocessor to include a file.
The included file will be scanned and processed before continuing with
the rest of the current file.

#### Syntax:

`&include "`*`filename`*`"`

#### Notes:

1.  *filename* is searched first in the directory containing the current
    file, then in the directories listed in the include path. (-I
    option). The file name can be followed by spaces and comments.

#### Example:

::: {align="center"}
+-----------------------------------------------------------------------+
| **Source: File A**                                                    |
+-----------------------------------------------------------------------+
| ``` linenumber                                                        |
| 01 First line                                                         |
| 02 &include "B"                                                       |
| 03 Third line                                                         |
| ```                                                                   |
+-----------------------------------------------------------------------+
| **Source: File B**                                                    |
+-----------------------------------------------------------------------+
| ``` linenumber                                                        |
| 01 Second line                                                        |
| ```                                                                   |
+-----------------------------------------------------------------------+
| **Result**                                                            |
+-----------------------------------------------------------------------+
| ``` linenumber                                                        |
| 01 & 1 "A"                                                            |
| 02 First line                                                         |
| 03 & 1 "B"                                                            |
| 04 Second line                                                        |
| 05 & 3 "A"                                                            |
| 06 Third line                                                         |
| ```                                                                   |
+-----------------------------------------------------------------------+
:::

These preprocessor directives inform the compiler of its current
location with special preprocessor comments, so the compiler can provide
the right error message when a syntax error occurs.

The preprocessor-generated comments use the following format:

`& `*`number`*` "`*`filename`*`"`

where:

- *number* is the current line in the preprocessed file
- *filename* is the current file name

#### Recursive inclusions

Recursive inclusions are not allowed. Doing so will fail and output an
error message.

The following example is incorrect:

::: {align="center"}
+----------------------------------------------------------------------------+
| **Source: File A**                                                         |
+----------------------------------------------------------------------------+
| ``` linenumber                                                             |
| 01 &include "B"                                                            |
| ```                                                                        |
+----------------------------------------------------------------------------+
| **Source: File B**                                                         |
+----------------------------------------------------------------------------+
| ``` linenumber                                                             |
| 01 HELLO                                                                   |
| 02 &include "A"                                                            |
| ```                                                                        |
+----------------------------------------------------------------------------+
| **fglcomp -M A.4gl output**                                                |
+----------------------------------------------------------------------------+
|     B.4gl:2:1:2:1:error:(-8029) Multiple inclusion of the source file 'A'. |
+----------------------------------------------------------------------------+
:::

But including the same file several times is allowed:

::: {align="center"}
+-----------------------------------------------------------------------+
| **Source: File A**                                                    |
+-----------------------------------------------------------------------+
| ``` linenumber                                                        |
| 01 &include "B"                                                       |
| 02 &include "B"  -- correct                                           |
| ```                                                                   |
+-----------------------------------------------------------------------+
| **Source: File B**                                                    |
+-----------------------------------------------------------------------+
| ``` linenumber                                                        |
| 01 HELLO                                                              |
| ```                                                                   |
+-----------------------------------------------------------------------+
| **Result**                                                            |
+-----------------------------------------------------------------------+
| ``` linenumber                                                        |
| 01 & 1 "A"                                                            |
| 02 & 1 "B"                                                            |
| 03 HELLO                                                              |
| 04 & 2 "A"                                                            |
| 05 & 1 "B"                                                            |
| 06 HELLO                                                              |
| ```                                                                   |
+-----------------------------------------------------------------------+
:::

------------------------------------------------------------------------

### [Simple macro definition]{#FGLPP_SIMPLE_MACRO}

A macro is identified by its name and body.  As the preprocessor scans
the text, it substitutes the macro body for the name identifier.

#### Syntax:

`&define `*`identifier`*` `*`body`*

#### Notes:

1.  *identifier* is the name of the macro. Any valid identifier can be
    used.
2.  *body* is any sequence of tokens until the end of the line.

After substitution, the macro definition is replaced with blank lines.

#### Examples:

The following example show macro substitution with 2 simple macros:

::: {align="center"}
+-----------------------------------------------------------------------+
| **Source: File A**                                                    |
+-----------------------------------------------------------------------+
| ``` linenumber                                                        |
| 01 &define MAX_TEST 12                                                |
| 02 &define HW "Hello world"                                           |
| 03                                                                    |
| 04 MAIN                                                               |
| 05   DEFINE i INTEGER                                                 |
| 06   FOR i=1 TO MAX_TEST                                              |
| 07     DISPLAY HW                                                     |
| 08   END FOR                                                          |
| 09 END MAIN                                                           |
| ```                                                                   |
+-----------------------------------------------------------------------+
| **Result**                                                            |
+-----------------------------------------------------------------------+
| ``` linenumber                                                        |
| 01 & 1 "A"                                                            |
| 02                                                                    |
| 03                                                                    |
| 04                                                                    |
| 05 MAIN                                                               |
| 06   DEFINE i INTEGER                                                 |
| 07   FOR i=1 TO 12                                                    |
| 08     DISPLAY "Hello world"                                          |
| 09   END FOR                                                          |
| 10 END MAIN                                                           |
| ```                                                                   |
+-----------------------------------------------------------------------+
:::

The macro definition can be continued on multiple lines, but when the
macro is expanded, it is joined to a single line as follows:

::: {align="center"}
+-----------------------------------------------------------------------+
| **Source: File A**                                                    |
+-----------------------------------------------------------------------+
| ``` linenumber                                                        |
| 01 &define TABLE_VALUES 1, \                                          |
| 02                      2, \                                          |
| 03                      3                                             |
| 04 DISPLAY TABLE_VALUES                                               |
| ```                                                                   |
+-----------------------------------------------------------------------+
| **Result**                                                            |
+-----------------------------------------------------------------------+
| ``` linenumber                                                        |
| 01 & 1 "A"                                                            |
| 02                                                                    |
| 03                                                                    |
| 04                                                                    |
| 05 DISPLAY 1, 2, 3                                                    |
| ```                                                                   |
+-----------------------------------------------------------------------+
:::

The source file is processed sequentially, so a macro takes effect at
the place it has been written:

::: {align="center"}
+-----------------------------------------------------------------------+
| **Source: File A**                                                    |
+-----------------------------------------------------------------------+
| ``` linenumber                                                        |
| 01 DISPLAY X                                                          |
| 02 &define X "Hello"                                                  |
| 03 DISPLAY X                                                          |
| ```                                                                   |
+-----------------------------------------------------------------------+
| **Result**                                                            |
+-----------------------------------------------------------------------+
| ``` linenumber                                                        |
| 01 & 1 "A"                                                            |
| 02 DISPLAY X                                                          |
| 03                                                                    |
| 04 DISPLAY "Hello"                                                    |
| ```                                                                   |
+-----------------------------------------------------------------------+
:::

The macro body is expanded only when the macro is applied :

::: {align="center"}
+-----------------------------------------------------------------------+
| **Source: File A**                                                    |
+-----------------------------------------------------------------------+
| ``` linenumber                                                        |
| 01 &define AA BB                                                      |
| 02 &define BB 12                                                      |
| 03 DISPLAY AA                                                         |
| ```                                                                   |
+-----------------------------------------------------------------------+
| **Result**                                                            |
+-----------------------------------------------------------------------+
| ``` linenumber                                                        |
| 01 & 1 "A"                                                            |
| 02                                                                    |
| 03                                                                    |
| 04 DISPLAY 12                                                         |
| ```                                                                   |
+-----------------------------------------------------------------------+
:::

- AA is first expanded to BB.
- The text is rescanned and BB is expanded to 12.
- When the macro AA is defined, BB is not known yet; but it is known
  when the macro AA is used.

In order to prevent infinite recursion, a macro cannot be expanded
recursively.

::: {align="center"}
+-----------------------------------------------------------------------+
| **Source: File A**                                                    |
+-----------------------------------------------------------------------+
| ``` linenumber                                                        |
| 01 &define A B                                                        |
| 02 &define B A                                                        |
| 03 &define C C                                                        |
| 04 A C                                                                |
| ```                                                                   |
+-----------------------------------------------------------------------+
| **Result**                                                            |
+-----------------------------------------------------------------------+
| ``` linenumber                                                        |
| 01 & 1 "A"                                                            |
| 02                                                                    |
| 03                                                                    |
| 04                                                                    |
| 05 A C                                                                |
| ```                                                                   |
+-----------------------------------------------------------------------+
:::

- A is first expanded to B.
- B is expanded to A.
- A is not expanded again as it appears in its own expansion.
- C expands to C and can not be expanded further.

------------------------------------------------------------------------

### [Function macro definition]{#FGLPP_FUNCTION_MACRO}

Function macros are macros which can take arguments.

#### Syntax:

`&define `*`identifier`*`( `*`arglist`*` ) `*`body`*

#### Notes:

1.  *identifier* is the name of the macro. Any valid identifier can be
    used.
2.  *body* is any sequence of tokens until the end of the line.
3.  *arglist* is a list of identifiers separated with commas and
    optionally whitespace.
4.  There must be NO space or comment between the macro name and the
    opening parenthesis. Otherwise the macro is not a function macro,
    but a simple macro.

#### Example:

::: {align="center"}
+-----------------------------------------------------------------------+
| **Source: File A**                                                    |
+-----------------------------------------------------------------------+
| ``` linenumber                                                        |
| 01 &define function_macro(a,b) a + b                                  |
| 02 &define simple_macro (a,b) a + b                                   |
| 03 function_macro( 4 , 5 )                                            |
| 04 simple_macro (1,2)                                                 |
| ```                                                                   |
+-----------------------------------------------------------------------+
| **Result**                                                            |
+-----------------------------------------------------------------------+
| ``` linenumber                                                        |
| 01 & 1 "A"                                                            |
| 02                                                                    |
| 03                                                                    |
| 04 4 + 5                                                              |
| 05 (a,b) a + b (1,2)                                                  |
| ```                                                                   |
+-----------------------------------------------------------------------+
:::

A function macro can have an empty argument list. In this case,
parenthesis are required for the macro to be expanded. As we can see in
the next example, line 03 is not expanded because it there is no \'()\'
after *foo*. The function macro cannot be applied even if it has no
arguments.

+-----------------------------------------------------------------------+
| **Source: File A**                                                    |
+-----------------------------------------------------------------------+
| ``` linenumber                                                        |
| 01 &define foo() yes                                                  |
| 02 foo()                                                              |
| 03 foo                                                                |
| ```                                                                   |
+-----------------------------------------------------------------------+
| **Result**                                                            |
+-----------------------------------------------------------------------+
| ``` linenumber                                                        |
| 01 & 1 "A"                                                            |
| 02                                                                    |
| 03 yes                                                                |
| 04 foo                                                                |
| ```                                                                   |
+-----------------------------------------------------------------------+

The comma separates arguments. Macro parameters containing a comma can
be used with parenthesis. In the following example Line 02 has been
substituted, but line 03 produced an error, because the number of
parameters is incorrect.

::: {align="center"}
+--------------------------------------------------------------------------------------------+
| **Source: File A**                                                                         |
+--------------------------------------------------------------------------------------------+
| ``` linenumber                                                                             |
| 01 &define one_parameter(a) a                                                              |
| 02 one_parameter((a,b))                                                                    |
| 03 one_parameter(a,b)                                                                      |
| ```                                                                                        |
+--------------------------------------------------------------------------------------------+
| **fglcomp -M output**                                                                      |
+--------------------------------------------------------------------------------------------+
|     source.4gl:3:1:3:1:error:(-8039) Invalid number of parameters for macro one_parameter. |
+--------------------------------------------------------------------------------------------+
:::

Macro arguments are completely expanded and substituted before the
function macro expansion.

A macro argument can be left empty.

::: {align="center"}
+---------------------------------------------------------------------------------------+
| **Source: File A**                                                                    |
+---------------------------------------------------------------------------------------+
| ``` linenumber                                                                        |
| 01 &define two_args(a,b) a b                                                          |
| 02 two_args(,b)                                                                       |
| 03 two_args(,)                                                                        |
| 04 two_args()                                                                         |
| 05 two_args(,,)                                                                       |
| ```                                                                                   |
+---------------------------------------------------------------------------------------+
| **fglcomp -M output**                                                                 |
+---------------------------------------------------------------------------------------+
|     source.4gl:4:1:4:1:error:(-8039) Invalid number of parameters for macro two_args. |
|     source.4gl:5:1:5:1:error:(-8039) Invalid number of parameters for macro two_args. |
+---------------------------------------------------------------------------------------+
:::

Macro arguments appearing inside strings are not expanded.

::: {align="center"}
+-----------------------------------------------------------------------+
| **Source: File A**                                                    |
+-----------------------------------------------------------------------+
| ``` linenumber                                                        |
| 01 &define foo(x) "x"                                                 |
| 02 foo(toto)                                                          |
| ```                                                                   |
+-----------------------------------------------------------------------+
| **Result**                                                            |
+-----------------------------------------------------------------------+
| ``` linenumber                                                        |
| 01 & 1 "A"                                                            |
| 02                                                                    |
| 03 "x"                                                                |
| ```                                                                   |
+-----------------------------------------------------------------------+
:::

------------------------------------------------------------------------

### [Stringification]{#FGLPP_STRINGIFICATION}

The stringification transformation allows you to create a string using a
macro parameter. When a macro parameter is used with a preceding
\'`#`\', it is replaced by a string containing the literal text of the
argument. The argument is not macro expanded before the substitution.

#### Example:

::: {align="center"}
+-----------------------------------------------------------------------------------+
| **Source: File A**                                                                |
+-----------------------------------------------------------------------------------+
| ``` linenumber                                                                    |
| 01 &define test(x) IF x THEN \                                                    |
| 02                 DISPLAY #x||" is true."  \                                     |
| 03               ELSE \                                                           |
| 04                 DISPLAY #x||" is false." \                                     |
| 05               END IF                                                           |
| 06 test(1=2)                                                                      |
| ```                                                                               |
+-----------------------------------------------------------------------------------+
| **Result**                                                                        |
+-----------------------------------------------------------------------------------+
| ``` linenumber                                                                    |
| 01 & 1 "A"                                                                        |
| 02                                                                                |
| 03                                                                                |
| 04                                                                                |
| 05                                                                                |
| 06                                                                                |
| 07 IF 1=2 THEN DISPLAY "1=2"||" is true." ELSE DISPLAY "1=2"||" is false." END IF |
| ```                                                                               |
+-----------------------------------------------------------------------------------+
:::

Line 07 has been split on multiple lines for readability. The
preprocessor output is merged on one line.

------------------------------------------------------------------------

### [Concatenation]{#FGLPP_CONCATENATION}

The operator \'`##`\' can be used to merge two tokens while expanding a
macro. The two tokens on either side of each \'`##`\' are combined to
create a single token.

All tokens can not be merged. Usually these tokens are identifiers, or
numbers. The concatenation result produces an identifier.

#### Example:

::: {align="center"}
+-----------------------------------------------------------------------+
| **Source: File A**                                                    |
+-----------------------------------------------------------------------+
| ``` linenumber                                                        |
| 01 &define COMMAND(NAME) #NAME, NAME ## _command                      |
| 02 COMMAND(quit)                                                      |
| ```                                                                   |
+-----------------------------------------------------------------------+
| **Result**                                                            |
+-----------------------------------------------------------------------+
| ``` linenumber                                                        |
| 01 & 1 "A"                                                            |
| 02                                                                    |
| 03 "quit", quit_command                                               |
| ```                                                                   |
+-----------------------------------------------------------------------+
:::

------------------------------------------------------------------------

### [Predefined macros]{#FGLPP_PREDEFINED}

The preprocessor predefines 2 macros:

1.  `__LINE__` expands to the current line number. Its definition
    changes with each new line of the code.
2.  `__FILE__` expands to the name of the current file as a string
    constant. Ex : \"subdir/file.inc\"

These macros are often used to generate error messages.

An `&include` directive changes the values of `__FILE__` and `__LINE__`
to correspond to the included file.

------------------------------------------------------------------------

### [Un-defining a macro]{#FGLPP_UNDEF}

You are allowed to un-define a macro and then redefine it with a new
body.

#### Syntax:

`&undef `*`identifier`*

#### Usage:

If a macro is redefined without having been undefined previously, the
preprocessor issues a warning and replaces the existing definition with
the new one.

#### Example:

::: {align="center"}
+-----------------------------------------------------------------------+
| **Source: File A**                                                    |
+-----------------------------------------------------------------------+
| ``` linenumber                                                        |
| 01 &define HELLO "hello"                                              |
| 02 DISPLAY HELLO                                                      |
| 03 &undef HELLO                                                       |
| 04 DISPLAY HELLO                                                      |
| ```                                                                   |
+-----------------------------------------------------------------------+
| **Result**                                                            |
+-----------------------------------------------------------------------+
| ``` linenumber                                                        |
| 01 & 1 "A"                                                            |
| 02                                                                    |
| 03 DISPLAY "hello"                                                    |
| 04 DISPLAY HELLO                                                      |
| ```                                                                   |
+-----------------------------------------------------------------------+
:::

------------------------------------------------------------------------

### [Conditional compilation]{#FGLPP_CONDITION}

Conditional processing is supported with the `&ifdef` and `&ifndef`
directives.

#### Syntax 1:

`&ifdef `*`identifier`\*
`...`[\
`[`]{.underline}`&else`\
`...`[`]`\]{.underline}
`&endif`

#### Syntax 2:

`&ifndef `*`identifier`\*
`...`[\
`[`]{.underline}`&else`\
`...`[`]`\]{.underline}
`&endif`

#### Notes:

1.  The comment following `&endif` is not required. However, it can help
    to match the corresponding `&ifdef` or `&ifndef`.
2.  Even if the condition is evaluated to false, the content of the
    `&ifdef` block is still scanned and tokenized. Therefore, it must be
    lexically correct.
3.  Sometimes it is useful to use some code if a macro is not defined.
    You can use `&ifndef`, that evaluates to true if the macro is not
    defined.

#### Example:

::: {align="center"}
+-----------------------------------------------------------------------+
| **Source: File A**                                                    |
+-----------------------------------------------------------------------+
| ``` linenumber                                                        |
| 01 &define IS_DEFINED                                                 |
| 02 &ifdef IS_DEFINED                                                  |
| 03 DISPLAY "The macro is defined"                                     |
| 04 &endif  /* IS_DEFINE */                                            |
| ```                                                                   |
+-----------------------------------------------------------------------+
| **Result**                                                            |
+-----------------------------------------------------------------------+
| ``` linenumber                                                        |
| 01 & 1 "A"                                                            |
| 02                                                                    |
| 03                                                                    |
| 04 DISPLAY "The macro is defined"                                     |
| 05                                                                    |
| ```                                                                   |
+-----------------------------------------------------------------------+
:::
