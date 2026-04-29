[Back to Contents](../index.html)

------------------------------------------------------------------------

# [Constants]{#PAGE_HEADER}

Summary:

- [Definition](#DEFINITION)
- [Examples](#EXAMPLES)

*See also:* [Variables](Variables.html), [Records](Records.html), [Data
Types](DataTypes.html), [User Types](UserTypes.html).

------------------------------------------------------------------------

### [Definition]{#DEFINITION}

#### Purpose:

A *constant* defines a read-only value identified by a name.

#### Syntax:

[`[`]{.underline}`PRIVATE`[`|`]{.underline}`PUBLIC`[`]`]{.underline}` CONSTANT `*`constant-definition`*` `[`[,...]`]{.underline}

where *constant-definition* is:

` `*`identifier`*` `[`[`]{.underline}` `*`datatype`*` `[`]`]{.underline}` = `*`value`*` `

#### Notes:

1.  *identifier* is the name of the constant to be defined.
2.  *datatype* can be any [data type](DataTypes.html) except complex
    types like [TEXT](DataTypes.html#DT_TEXT) or
    [BYTE](DataTypes.html#DT_BYTE).
3.  *value* can be an [integer literal](Literals.html#LT_INTEGER), a
    [decimal literal](Literals.html#LT_DECIMAL), or a [string
    literal](Literals.html#LT_STRING). *value* cannot be
    [NULL](Programs.html#PC_NULL).

#### Usage:

You can declare a constant to define a static value that can be used in
other instructions. Constants can be [global](Globals.html),
module-specific, or local to a [function](Functions.html).

By default, module-specific constants are private; They cannot be used
by an other module of the program. To make a module constant public, add
the `PUBLIC` keyword before `CONSTANT`. When a module constant is
declared as public, it can be referenced by another module by using the
[IMPORT](Programs.html#IMPORT) instruction.

When declaring a constant, the data type specification can be omitted.
The literal value automatically defines the data type:

``` linenumber
01 CONSTANT c1 = "Drink" -- Declares a STRING constant
02 CONSTANT c2 = 4711    -- Declares an INTEGER constant
```

However, in some cases, you may need to specify the data type:

``` linenumber
01 CONSTANT c1 SMALLINT = 12000 -- Would be an INTEGER by default
```

Constants can be used in variable, records, and array definitions:

``` linenumber
01 CONSTANT n = 10
02 DEFINE a ARRAY[n] OF INTEGER
```

Constants can be used at any place in the language where you normally
use literals:

``` linenumber
01 CONSTANT n = 10
02 FOR i=1 TO n
```

Constants can be passed as function parameters, and returned from
functions.

Defining public constants in a module to be imported by others:

``` linenumber
01 PUBLIC CONSTANT pi = 3.14159265
```

#### Warnings:

1.  A constant cannot be used in the ` ORDER BY` clause of a static
    ` SELECT` statement, because the compiler considers identifiers
    after ` ORDER BY` as part of the SQL statement (i.e. column names),
    not as constants.\
    `  CONSTANT position = 3`\
    `  SELECT * FROM table ORDER BY position`
2.  Automatic [date type conversion](DataConversions.html) can take
    place in some cases:\
    `  CONSTANT c1 CHAR(10) = "123"`\
    `  CONSTANT c2 CHAR(10) = "abc"`\
    `  DEFINE i INTEGER`\
    `  FOR i=1 TO c1 # Constant "123" is be converted to 123`\
    `  FOR i=1 TO c2 # Constant "abc" is converted to zero!`
3.  Character constants defined with a string literal that is longer
    than the length of the datatype are truncated:\
    `  CONSTANT s CHAR(3) = 'abcdef'`\
    `  DISPLAY s # Displays "abc"`
4.  The compiler throws an error when the symbol used as a constant is
    not defined:\
    `  DEFINE s CHAR(c) # Error, c is not defined!`
5.  The compiler throws an error when the symbol used as a constant is a
    variable:\
    `  DEFINE c INTEGER`\
    `  DEFINE s CHAR(c) # Error, c is a variable!`
6.  The compiler throws an error when you try to assign a value to a
    constant:\
    `  CONSTANT c INTEGER = 123`\
    `  LET c = 345 # Error, c is a constant!`
7.  The compiler throws an error when the symbol used is not defined as
    an integer constant:\
    `  CONSTANT c CHAR(10) = "123"`\
    `  DEFINE s CHAR(c) # Error, c is not an integer!`

#### Tips:

1.  Define common special characters with constants:\
    `  CONSTANT C_ESC  = '\x1b'`\
    `  CONSTANT C_TAB  = '\t'`\
    `  CONSTANT C_CR   = '\r'`\
    `  CONSTANT C_LF   = '\n'`\
    `  CONSTANT C_CRLF = '\r\n'`

------------------------------------------------------------------------

### [Examples]{#EXAMPLES}

#### Example 1:

``` linenumber
01 CONSTANT c1 ="Drink",   # Declares a STRING constant
02          c2 = 4711,     # Declares an INTEGER constant
03          n = 10,        # Declares an INTEGER constant
04          x SMALLINT = 1 # Declares a SMALLINT constant
05 DEFINE a ARRAY[n] OF INTEGER
06 MAIN
07   CONSTANT c1 = "Hello"
08   DEFINE i INTEGER
09   FOR i=1 TO n
10       ...
11   END FOR
12   DISPLAY c1 || c2  # Displays "Hello4711"
13 END MAIN
```
