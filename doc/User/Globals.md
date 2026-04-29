[Back to Contents](../index.html)

------------------------------------------------------------------------

# [Globals]{#PAGE_HEADER}

Summary:

- [Definition](#DEFINITION)
- [Examples](#EXAMPLES)

*See also:* [Variables](Variables.html), [Arrays](Arrays.html),
[Records](Records.html), [Constants](Constants.html),
[Programs](Programs.html)

------------------------------------------------------------------------

### [Definition]{#DEFINITION}

#### Purpose:

The [`GLOBALS`]{#GLOBALS} instruction can be used to declare variables,
constants and types for the whole program.

#### Syntax 1: Global block declaration

`GLOBALS`\
`  `*`declaration-statement`\
` `*` `[`[`]{.underline}`,...`[`]`]{.underline}\
`END GLOBALS`

#### Syntax 2: Importing global variables

`GLOBALS `*`"filename"`*

#### Notes:

1.  In **Syntax 1**, *declaration-statement* is a
    [variable](Variables.html#DEFINITION), [constant](Constants.html) or
    [user type](UserTypes.html) declaration.
2.  In **Syntax 2**,  *filename* is the name of a file containing the
    definition of global variables. Use this syntax to include a global
    declarations in the current module.

#### Warnings:

1.  Do not write a *declaration-statement* outside a
    `GLOBALS … END GLOBALS` block in a `GLOBALS` file.
2.  If you modify *filename*, you must recompile all the modules that
    include *filename.*

#### Usage:

In general, a program [variable](Variables.html#DEFINITION),
[constant](Constants.html) or [user type](UserTypes.html) is in scope
only in the same [FUNCTION](Functions.html),
[MAIN](Programs.html#MAIN_BLOCK), or [REPORT](Reports.html) program
block in which it was declared.

To extend the scope of a [variable](Variables.html#DEFINITION),
[constant](Constants.html) or [user type](UserTypes.html) beyond the
source module in which they are declared, you can declare it as global
in a \"globals\" file:

1.  Declare global elements in a `GLOBALS … END GLOBALS` block in
    specific files.
2.  Import the global symbols in other modules with
    `GLOBALS "`*`filename`*`"`` ` statements.

The *filename* must contain the **.4gl** suffix. It can be a a relative
or an absolute path. To specify a path, the slash (/) directory
separator can be used for Unix and Windows platforms.

If a local element has the same name as another variable that you
declare in the ` GLOBALS` statement, only the local variable is visible
within its scope of reference.

You can declare several ` GLOBALS` blocks in the same module.

A `GLOBALS` file must not contain any executable statement.

You do not compile the source file containing the `GLOBALS` block.

You can declare several ` GLOBALS "`*`filename`*`" `in the same module.

Although you can include multiple `GLOBALS … END GLOBALS` statements in
the same application, do not declare the same identifier within more
than one `GLOBALS` declaration. Even if several declarations of a global
elements defined in multiple places are identical, declaring any global
element more than once can result in compilation errors or unpredictable
runtime behavior.

A `GLOBALS` block can hold `GLOBALS "filename"` instructions. In such
case, the specified files will be included recursively.

#### Tips:

1.  Use only a few global variables, too much global variables makes the
    source code difficult to maintain and denies reusability.
2.  There is no need to compile *filename,* but compiling *filename*
    might be useful to detect syntax errors.
3.  To improve the readability of your source code, prefix global
    variables by \"g\_\".

------------------------------------------------------------------------

### [Examples]{#EXAMPLES}

#### Example 1: Multiple GLOBALS file

labels.4gl : This module defines the text that should be displayed on
the screen

``` linenumber
01 GLOBALS
02   CONSTANT g_lbl_val = "Index:"
03   CONSTANT g_lbl_idx = "Value:"
04 END GLOBALS
```

globals.4gl : Declares a global array and a constant containing its size

``` linenumber
01 GLOBALS "labels.4gl" -- this statement could be line 2 of main.4gl                                                                                                                                    
02 GLOBALS
03   DEFINE g_idx ARRAY[100] OF CHAR(10)
04   CONSTANT g_idxsize = 100
05 END GLOBALS
```

database.4gl : This module could be dedicated to database access

``` linenumber
01 GLOBALS "globals.4gl"
02 FUNCTION get_id()
03   DEFINE li INTEGER
04   FOR li = 1 TO g_idxsize -- this could be a FOREACH statement
05       LET g_idx[li] = g_idxsize - li
06   END FOR
07 END FUNCTION
```

main.4gl : Fill in the global array and display the result

``` linenumber
01 GLOBALS "globals.4gl"
02 MAIN
03   DISPLAY "Initializing constant values for this application..."
05   DISPLAY "Filling the data from function get_idx in module database.4gl..."
06   CALL get_id()
07   DISPLAY "Retrieving a few values from g_idx"
08   CALL display_data()
09 END MAIN                                                                                                                                    
10 FUNCTION display_data()
11   DEFINE li INTEGER
12   LET li = 1
13   WHILE li <= 10 AND li <= g_idxsize
14       DISPLAY g_lbl_idx CLIPPED || li || " " || g_lbl_val CLIPPED || g_idx[li]
15       LET li = li + 1
16   END WHILE
17 END FUNCTION
```
