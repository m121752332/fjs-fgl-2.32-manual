[Back to Contents](../index.html)

------------------------------------------------------------------------

# [Basic Syntax Elements]{#PAGE_HEADER}

Summary:

- [Summary](#SUMMARY)
- [List of Basic Syntax Elements](#OPERATOR_LIST)
- [Order of Precedence List](#PRECEDENCE_LIST)
- [General Warnings](#GENERAL_WARNINGS)

*See also:* [Variables](Variables.html), [Data Types](DataTypes.html),
[Expressions](Expressions.html), [Literals](Literals.html).

------------------------------------------------------------------------

## [Summary]{#SUMMARY}

This section describes basic syntax elements that can appear in
[Expressions](Expressions.html). There are different sort of basic
syntax elements such as classic arithmetic, string and comparison
operators, pre-defined variables and registers like `SQLSTATE`, and
predefined functions like `SFMT()` or `TODAY`.

Elements of an expressions are evaluated according to their precedence,
from highest to lowest, as described in the [Order of Precedence
List](#PRECEDENCE_LIST). Use [parentheses](#PARENTHESES) to instruct the
runtime system to evaluate the expression in a different way than the
default order of precedence.

------------------------------------------------------------------------

## [List of Basic Syntax Elements]{#OPERATOR_LIST}

### [Comparison Operators]{#COMPARISON_OPERATORS}

- [Is Null](#OP_ISNULL) (`IS NULL`)
- [Like](#OP_LIKE) (`LIKE`)
- [Matches](#OP_MATCHES) (`MATCHES`)
- [Equal](#OP_EQUAL) (`==`)
- [Different](#OP_DIFFERENT) (`!= or <>`)
- [Lower](#OP_LOWER) (`<`)
- [Lower or Equal](#OP_LOWER_OR_EQUAL) (`<=`)
- [Greater](#OP_GREATER) (`>`)
- [Greater or Equal](#OP_GREATER_OR_EQUAL) (`>=`)

### [Logical Operators]{#LOGICAL_OPERATORS}

- [Not](#OP_NOT) (`NOT`)
- [And](#OP_AND) (`AND`)
- [Or](#OP_OR) (`OR`)

### [Arithmetic Operators]{#ARITHMETIC_OPERATORS}

- [Addition](#OP_ADDITION) (`+`)
- [Subtraction](#OP_SUBTRACTION) (`-`)
- [Multiplication](#OP_MULTIPLICATION) (`*`)
- [Division](#OP_DIVISION) (`/`)
- [Exponentiation](#OP_EXPONENTIATION) (`**`)
- [Modulus](#OP_MODULUS) (`MOD`)

### [Character String Handling]{#STRING_OPERATORS}

- [ASCII Char](#OP_ASCII) (`ASCII`)
- [Blank padding](#OP_COLUMN) (`COLUMN`)
- [Concatenate](#OP_CONCATENATE) (`||`)
- [Append](#OP_APPEND) (`,`)
- [Substring](#OP_SUBSTRING) (`[x,y]`)
- [Formatting](#OP_USING) (`USING`)
- [Clipped](#OP_CLIPPED) (`CLIPPED`)
- [Ordinal](#OP_ORD) (`ORD`)
- [Spaces](#OP_SPACES) (`SPACES`)
- [Localized String](#OP_LSTR) (`LSTR`)
- [Replace](#OP_SFMT) (`SFMT`)

### [Associative Syntax Elements]{#ASSOCIATIVE_OPERATORS}

- [Parentheses](#PARENTHESES) ( `( )` )
- [Membership](#OP_MEMBERSHIP) ( `.` )

### Predefined SQL Registers

- [SQL State Code](#OP_SQLSTATE) (`SQLSTATE`)
- [SQL Error Message](#OP_SQLERRMESSAGE) (`SQLERRMESSAGE`)

### Data Type related

- [Type Casting](#OP_CAST) ( `CAST` )
- [Type Checking](#OP_INSTANCEOF) ( `INSTANCEOF` )

### [Assignment Operators]{#ASSIGNMENT_OPERATORS}

- [Assignment](#OP_ASSIGN) ( `:=` )

### Date and Time Manipulation

- [Current Datetime](#OP_CURRENT) (`CURRENT x TO y`)
- [Datetime Extensions](#OP_EXTEND) (`EXTEND( d, x TO y)`)
- [Date Conversion](#OP_DATE) (`DATE`)
- [Time Conversion](#OP_TIME) (`TIME`)
- [Current Date](#OP_TODAY) (`TODAY`)
- [Year of Date](#OP_YEAR) (`YEAR(d)`)
- [Month of Date](#OP_MONTH) (`MONTH(d)`)
- [Day of Date](#OP_DAY) (`DAY(d)`)
- [Weekday of Date](#OP_WEEKDAY) (`WEEKDAY(d)`)
- [Building a Date](#OP_MDY) (`MDY(m,d,y)`)
- [Interval Unit](#OP_UNITS) (`UNITS`)

### Form Field and Dialog Handling

- [Field Buffer](#OP_GET_FLDBUF) (`GET_FLDBUF`)
- [Current Field](#OP_INFIELD) (`INFIELD`)
- [Field Modification](#OP_FIELD_TOUCHED) (`FIELD_TOUCHED`)

------------------------------------------------------------------------

## [Order of Precedence List]{#PRECEDENCE_LIST}

The following list describes the precedence order of the basic syntax
elements. For example, the `MOD` operator has a higher precedence as the
`*` operator. When computing an expression like `( 33 MOD 2 * 5 )`, the
runtime system first evaluates `(33 MOD 2) = 1` and then evaluates
`(1 * 5) = 5`. You can change this by using parentheses:
`( 33 MOD ( 2 * 5 ) ) = 3`. The **P** column defines the precedence,
from highest(14) to lowest(1). Note that some operators have the same
precedence (i.e. are equivalent in evaluation order). The **A** column
defines the direction of association (L=Left, R=Right, N=None).

::: {align="center"}
  ---- --------------------------- ---- --------------------------- ------------------------------------
   P   Syntax Element               A   Description                 Example 
   14  `CAST(v AS `*`type`*`)`      N   Type casting                `CAST(var AS fgl.FglRecord)`
   14  `INSTANCEOF`                 L   Type checking               `var INSTANCEOF java.lang.Boolean`
   13  `UNITS`                      L   Single-qualifier interval   `(integer) UNITS DAY`
   12  `+`                          R   Unary plus                  `+ number`
   12  `-`                          R   Unary minus                 `- number`
   11  `**`                         L   Exponentiation              `x ** 5`
   11  `MOD`                        L   Modulus                     `x MOD 2`
   10  `*`                          L   Multiplication              `x * y`
   10  `/`                          L   Division                    `x / y`
   9   `+`                          L   Addition                    `x + y`
   9   `-`                          L   Subtraction                 `x - y`
   8   `||`                         L   Concatenation               `"Amount:" || amount`
   7   `LIKE`                       R   String comparison           `mystring LIKE "A%"`
   7   `MATCHES`                    R   String comparison           `mystring MATCHES "A*"`
   6   `<`                          L   Less than                   `var < 100`
   6   `<=`                         L   Less then or equal to       `var <= 100`
   6   `>`                          L   Greater than                `var > 100`
   6   `>=`                         L   Greater than or equal to    `var >= 100`
   6   `==`                         L   Equals                      `var == 100`
   6   `<> or !=`                   L   Not equal to                `var <> 100`
   5   `IS NULL`                    L   Test for NULL               `var IS NULL`
   5   `IS NOT NULL`                L   Test for NOT NULL           `var IS NOT NULL`
   4   `NOT`                        L   Logical inverse             `NOT ( a = b )`
   3   `AND`                        L   Logical intersection        `expr1 AND expr2`
   2   `OR`                         L   Logical union               `expr1 OR expr2`
   1   `ASCII( )`                   R   ASCII Character             `ASCII(32)`
   1   `CLIPPED`                    R   Delete trailing blanks      `DISPLAY string CLIPPED`
   1   `COLUMN (reports)`           R   Begin line mode display     `PRINT COLUMN 32, "a"`
   1   `(integer) SPACES`           R   Insert blank spaces         `DISPLAY "a" (5) SPACES`
   1   `LSTR(string) `              R   Load localized string       `DISPLAY LSTR("str123")`
   1   `SFMT(string [,p[...]]) `    R   Parameter replacement       `DISPLAY SFMT("%1",123)`
   1   `SQLSTATE`                   R   SQL State Code              `IF SQLSTATE="IX000"`
   1   `SQLERRMESSAGE`              R   SQL Error Message           `DISPLAY SQLERRMESSAGE`
   1   `USING`                      R   Format character string     `TODAY USING "yy/mm/dd"`
   1   `:=`                         L   Assignment                  `var := "abc"`
  ---- --------------------------- ---- --------------------------- ------------------------------------
:::

------------------------------------------------------------------------

## [General Warnings]{#GENERAL_WARNINGS}

### Pure SQL Synax Elements

The following are related to SQL syntax and not part of the language:

- `BETWEEN `*`expr`*` AND `*`expr`*
- `IN ( `*`expr`*` [ , ..' ] )`

### Report Routine Syntax Elements

The following are only available in the FORMAT section of report
routines:

- `PAGENO`
- `WORDWRAP`

See [Report Definition](Reports.html) for more details.

------------------------------------------------------------------------

### [PARENTHESES]{#PARENTHESES}

#### Purpose:

Parentheses are typically used to associate a set of values or
expressions to override the default order of precedence.

#### Syntax:

` ( `*`expr`*` `[`[...]`]{.underline}` )`

#### Notes:

1.  *expr* is a [language expression](Expressions.html).
2.  Typically used to change the [precedence of
    operators](#PRECEDENCE_LIST).

#### Example:

``` linenumber
01 MAIN
02   DEFINE n INTEGER
03   LET n = ( ( 3 + 2 ) * 2 )
04   IF n=10 AND ( n<=0 OR n>=20 ) THEN
05     DISPLAY "OK"
06   END IF
07 END MAIN
```

------------------------------------------------------------------------

### [MEMBERSHIP]{#OP_MEMBERSHIP}

#### Purpose:

The **period membership** specifies that its right-hand operand is a
member of the set whose name is its left-hand operand.

#### Syntax:

*`setname`*`.`*`element`*

#### Notes:

1.  Typically used for [record](Records.html) members.

#### Example:

``` linenumber
01 MAIN
02   DEFINE rec RECORD
03      n INTEGER,
04      c CHAR(10)
05   END RECORD
06   LET rec.n = 12345
06   LET rec.c = "abcdef"
07 END MAIN
```

------------------------------------------------------------------------

### [ASSIGNMENT]{#OP_ASSIGN}

#### Purpose:

The `:=` assignment operator sets a value to the left-hand operand,
which must be a variable.

#### Syntax:

*`variable`*` := `*`value`*

#### Notes:

1.  Do not confuse with the [LET](Variables.html#VA_LET) instruction.
2.  The left-hand operand must be a variable.
3.  The assignment operator can be used in expressions.
4.  The assignment operator has the lowest precedence.

#### Example:

``` linenumber
01 MAIN
02   DEFINE var1, var2 INTEGER
03   -- 1. Evaluates 2*5
04   -- 2. Sets var2 to 10
05   -- 3. Then affects var1 with 10
06   LET var1 = var2:=2*5
07 END MAIN
```

------------------------------------------------------------------------

### [CAST]{#OP_CAST}

#### Purpose:

The `CAST` operator converts a value or object to the type or class
specified.

#### Syntax:

`CAST( `*`expr`*` AS `*`type`*` )`

#### Notes:

1.  *expr* can be any [expression](Expressions.html) supported by the
    language.
2.  *type* is a [structured user defined type](UserTypes.html) or a
    [Java class](JavaBridge.html).

#### Usage:

The `CAST()` operator is required when you want to assign a value or
object reference to variable defined with a type or class which requires
narrowing reference conversion. The example below shows code using the
[Java Interface](JavaBridge.html#CAST_OPERATOR) facility of Genero BDL.
When assigning a *java.lang.StringBuffer* reference to a
*java.lang.Object* variable, widening reference conversion occurs and no
`CAST()` operator is needed, but when assigning an *java.lang.Object*
reference to a *java.lang.StringBuffer* variable, you must cast the
object reference to a *java.lang. StringBuffer*.

#### Example:

``` linenumber
01 IMPORNT JAVA java.lang.Object
02 IMPORNT JAVA java.lang.StringBuffer
03 MAIN
04   DEFINE sb1, sb2 java.lang.StringBuffer
05   DEFINE o java.lang.Object
06   LET sb1 = StringBuffer.create()
07   LET o = sb1 -- Widening Reference Conversion does not need CAST()
08   LET sb2 = CAST( o AS java.lang.StringBuffer ) -- Narrowing Reference Conversion needs CAST()
09 END MAIN
```

------------------------------------------------------------------------

### [INSTANCEOF]{#OP_INSTANCEOF}

#### Purpose:

The `INSTANCEOF` operator evaluates to [TRUE](Programs.html#PC_TRUE) if
the object reference is of the type or class specified.

#### Syntax:

` `*`expr`*` INSTANCEOF `*`type`*` `

#### Notes:

1.  *expr* can be any [expression](Expressions.html) supported by the
    language.
2.  *type* is a [structured user defined type](UserTypes.html) or a
    [Java class](JavaBridge.html).

#### Usage:

The `INSTANCEOF` operator is used to check if an expression (usually, an
object reference) is one of the type or class specified by *type*.

#### Example:

``` linenumber
01 IMPORNT JAVA java.lang.Object
02 IMPORNT JAVA java.lang.StringBuffer
03 IMPORNT JAVA java.lang.Number
04 MAIN
05   DEFINE o java.lang.Object
06   DEFINE sb java.lang.StringBuffer
07   LET sb = StringBuffer.create()
08   LET o = sb
09   DISPLAY sb INSTANCEOF java.lang.StringBuffer  -- shows 1
10   DISPLAY o INSTANCEOF java.lang.StringBuffer   -- shows 1
11   DISPLAY o INSTANCEOF java.lang.Number         -- shows 0
12 END MAIN
```

------------------------------------------------------------------------

### [IS NULL]{#OP_ISNULL}

#### Purpose:

The `IS NULL` operator is provided to test whether a value is
[NULL](Programs.html#PC_NULL).

#### Syntax:

*`expr`*` IS NULL`

#### Notes:

1.  *expr* can be any [expression](Expressions.html) supported by the
    language.
2.  Applies to most [Data Types](DataTypes.html), **except** complex
    types like [BYTE](DataTypes.html#DT_BYTE) and
    [TEXT](DataTypes.html#DT_TEXT).

#### Example:

``` linenumber
01 MAIN
02   DEFINE n INTEGER
03   LET n = 257
04   IF n IS NULL THEN
05      DISPLAY "Something is wrong here"
06   END IF
07 END MAIN
```

------------------------------------------------------------------------

### [EQUAL]{#OP_EQUAL}

#### Purpose:

The `==` operator evaluates whether two expressions or two records are
identical.

#### Syntax 1: Expression comparison

` `*`expr`*` == `*`expr`*

#### Syntax 2: Record comparison

*`record1.*`*` == `*`record2.*`*

#### Notes:

1.  Syntax 1 applies to most [Data Types](DataTypes.html), **except**
    complex types like [BYTE](DataTypes.html#DT_BYTE) and
    [TEXT](DataTypes.html#DT_TEXT).
2.  *expr* can be any [expression](Expressions.html) supported by the
    language.
3.  Syntax 2 allows you to compare all members of records having the
    same structure.
4.  *record1* and *record2* are [records](Records.html) with the same
    structure.
5.  A single equal sign (`=`) can be used as an alias for this
    operator. 

#### Usage:

When comparing expressions using the first syntax, the result of the
operator is [FALSE](Programs.html#PC_FALSE) when one of the operands is
[NULL](Programs.html#PC_NULL).

When comparing two records using the second syntax, the runtime system
compares all corresponding members of the records. If a pair of members
are different, the result of the operator is
[FALSE](Programs.html#PC_FALSE). When two corresponding members are
[NULL](Programs.html#PC_NULL), they are considered as equal. 

#### Example:

``` linenumber
01 MAIN
02   IF 256==257 THEN
03      DISPLAY "Something is wrong here"
04   END IF
05 END MAIN
```

------------------------------------------------------------------------

### [DIFFERENT]{#OP_DIFFERENT}

#### Purpose:

The `!=` operator evaluates whether two expressions or two records are
different.

#### Syntax 1: Expression comparison

` `*`expr`*` != `*`expr`*

#### Syntax 2: Record comparison

*`record1.*`*` != `*`record2.*`*

#### Notes:

1.  Syntax 1 applies to most [Data Types](DataTypes.html), **except**
    complex types like [BYTE](DataTypes.html#DT_BYTE) and
    [TEXT](DataTypes.html#DT_TEXT).
2.  *expr* can be any [expression](Expressions.html) supported by the
    language.
3.  Syntax 2 allows you to compare all members of records having the
    same structure.
4.  *record1* and *record2* are [records](Records.html) with the same
    structure.
5.  An alias exists for this operator: `<>`

#### Usage:

When comparing expressions with the first syntax, the result of the
operator is [FALSE](Programs.html#PC_FALSE) when one of the operands is
[NULL](Programs.html#PC_NULL).

When comparing two records with the second syntax, the runtime system
compares all corresponding members of the records. If one pair of
members are different, the result of the operator is
[TRUE](Programs.html#PC_TRUE). When two corresponding members are
[NULL](Programs.html#PC_NULL), they are considered as equal. 

#### Example:

``` linenumber
01 MAIN
02   IF 256 != 257 THEN
03      DISPLAY "This seems to be true"
04   END IF
05 END MAIN
```

------------------------------------------------------------------------

### [LOWER]{#OP_LOWER}

#### Purpose:

The `<` operator is provided to test whether a value or expression is
lower than another.

#### Syntax:

` `*`expr`*` < `*`expr`*

#### Warnings:

1.  Applies to most [Data Types](DataTypes.html), **except** complex
    types like [BYTE](DataTypes.html#DT_BYTE) and
    [TEXT](DataTypes.html#DT_TEXT).

------------------------------------------------------------------------

### [LOWER OR EQUAL]{#OP_LOWER_OR_EQUAL}

#### Purpose:

The `<=` operator is provided to test whether a value or expression is
lower than or equal to another.

#### Syntax:

` `*`expr`*` <= `*`expr`*

#### Warnings:

1.  Applies to most [Data Types](DataTypes.html), **except** complex
    types like [BYTE](DataTypes.html#DT_BYTE) and
    [TEXT](DataTypes.html#DT_TEXT).

------------------------------------------------------------------------

### [GREATER]{#OP_GREATER}

#### Purpose:

The `>` operator is provided to test whether a value or expression is
greater than another.

#### Syntax:

` `*`expr`*` > `*`expr`*

#### Warnings:

1.  Applies to most [Data Types](DataTypes.html), **except** complex
    types like [BYTE](DataTypes.html#DT_BYTE) and
    [TEXT](DataTypes.html#DT_TEXT).

------------------------------------------------------------------------

### [GREATER OR EQUAL]{#OP_GREATER_OR_EQUAL}

#### Purpose:

The `>=` operator is provided to test whether a value or expression is
greater than or equal to another.

#### Syntax:

` `*`expr`*` >= `*`expr`*

#### Warnings:

1.  Applies to most [Data Types](DataTypes.html), **except** complex
    types like [BYTE](DataTypes.html#DT_BYTE) and
    [TEXT](DataTypes.html#DT_TEXT).

------------------------------------------------------------------------

### [NOT]{#OP_NOT}

#### Purpose:

The `NOT` operator is a typical logical NOT used to invert a Boolean
expression.

#### Syntax:

` NOT `*`boolexpr`*

#### Example:

``` linenumber
01 MAIN
02   IF NOT ( 256 != 257 ) THEN
03      DISPLAY "Something is wrong here"
04   END IF
05 END MAIN
```

------------------------------------------------------------------------

### [AND]{#OP_AND}

#### Purpose:

The `AND` operator is the logical intersection operator.

#### Syntax:

` `*`boolexpr`*` AND `*`boolexpr`*

#### Example:

``` linenumber
01 MAIN
02   IF 256!=257 AND 256=257 THEN
03      DISPLAY "Sure?"
04   END IF
05 END MAIN
```

------------------------------------------------------------------------

### [OR]{#OP_OR}

#### Purpose:

The `OR` operator is the logical union operator.

#### Syntax:

` `*`boolexpr`*` OR `*`boolexpr`*

#### Example:

``` linenumber
01 MAIN
02   IF TRUE OR FALSE THEN
03      DISPLAY "Must be true!"
04   END IF
05 END MAIN
```

------------------------------------------------------------------------

### [SQLSTATE]{#OP_SQLSTATE}

#### Purpose:

The `SQLSTATE` predefined variable returns the ANSI/ISO SQLSTATE code
when an SQL error occurred.

#### Syntax:

`SQLSTATE`

#### Warnings:

1.  The SQLSTATE error code is a standard ANSI specification, but not
    all database engines support this feature. Check the database server
    documentation for more details.

#### Example:

``` linenumber
01 MAIN
02   DATABASE stores
03   WHENEVER ERROR CONTINUE
04   SELECT foo FROM bar
05   DISPLAY SQLSTATE
06 END MAIN
```

------------------------------------------------------------------------

### [SQLERRMESSAGE]{#OP_SQLERRMESSAGE}

#### Purpose:

The `SQLERRMESSAGE` predefined variable returns the error message if an
SQL error occurred.

#### Syntax:

`SQLERRMESSAGE`

#### Example:

``` linenumber
01 MAIN
02   DATABASE stores
03   WHENEVER ERROR CONTINUE
04   SELECT foo FROM bar
05   DISPLAY SQLERRMESSAGE
06 END MAIN
```

------------------------------------------------------------------------

## [ASCII]{#OP_ASCII}

#### Purpose:

The `ASCII` predefined function returns the character corresponding to
the ASCII code passed as a parameter.

#### Syntax:

`ASCII `*`intexpr`*

#### Notes:

1.  *intexpr* is an integer expression..
2.  Typically used to generate a non-printable character such as NewLine
    or Escape.
3.  In a default (U.S. English) locale, this is the logical inverse of
    the [ORD](#OP_ORD) operator.

#### Warnings:

1.  This is not a function, but a real operator (it can, for example, be
    used as a function parameter).

#### Tips:

1.  Often used with [parentheses](#PARENTHESES) ( ASCII(n) ), but these
    are not needed.

#### Example:

``` linenumber
01 MAIN
02   DISPLAY ASCII 65, ASCII 66, ASCII 7
03 END MAIN
```

------------------------------------------------------------------------

### [LIKE]{#OP_LIKE}

#### Purpose:

The `LIKE` operator returns [TRUE](Programs.html#PC_TRUE) if a string
matches a given mask.

#### Syntax:

*`expression`*` `[`[`]{.underline}`NOT`[`]`]{.underline}` LIKE `*`mask`*` `[`[`]{.underline}` ESCAPE "`*`char`*`" `[`]`]{.underline}

#### Warnings:

1.  Do not confuse with the LIKE clause of the [DEFINE](Variables.html)
    instruction.
2.  LIKE operators used in SQL statements are evaluated by the database
    server. This may have a different behavior than the LIKE operator of
    the language.

#### Notes:

1.  *expression* is any character string [expression](Expressions.html).
2.  *mask* is a character string expression defining the filter.
3.  *char* is a single char specifying the escape symbol.

#### Usage:

The *mask* can be any combination of characters, including the `%` and
`_` wildcards:

- The `%` percent character matches any string of zero or more
  characters.
- The `_` underscore character matches any single character.

The `ESCAPE` clause can be used to define an escape character different
from the default backslash. It must be enclosed in single or double
quotes.

A backslash (or the escape character specified by the `ESCAPE` clause)
makes the operator treat the next character as a literal character, even
if it is one of the special symbols in the above list. This allows you
to search for `%`, `_` or `\` characters.

**Warning: If you need to escape a wildcard character, keep in mind that
a string constant must also escape the backslash character. As a result,
if you want to pass a backslash to the LIKE operator (by using backslash
as default escape character), you need to write four backslashes in the
original string constant.**

The next table shows some examples of string constants used in the
source code and their equivalent `LIKE` pattern:

+-----------------------+-----------------------+-----------------------+
| **Original\           | **Equivalent\         | **Description**       |
| String Constant**     | MATCHES pattern**     |                       |
+-----------------------+-----------------------+-----------------------+
| `"%"`                 | `%`                   | Matches any character |
|                       |                       | in a non-empty        |
|                       |                       | string.               |
+-----------------------+-----------------------+-----------------------+
| `"_"`                 | `_`                   | Matches a single      |
|                       |                       | character.            |
+-----------------------+-----------------------+-----------------------+
| `"abc%"`              | `abc%`                | Starts with abc.      |
+-----------------------+-----------------------+-----------------------+
| `"*abc"`              | `%abc`                | Ends with abc.        |
+-----------------------+-----------------------+-----------------------+
| `"%abc%"`             | `%abc%`               | Contains abc.         |
+-----------------------+-----------------------+-----------------------+
| `"abc__"`             | `abc__`               | Strings equals abc    |
|                       |                       | followed by two       |
|                       |                       | additional            |
|                       |                       | characters.           |
+-----------------------+-----------------------+-----------------------+
| `"\\%"`               | `\%`                  | Contains a single     |
|                       |                       | star character (the % |
|                       |                       | wildcard is escaped)  |
+-----------------------+-----------------------+-----------------------+
| `"%abc\\\\def%"`      | `%abc\\def%`          | Contains abc followed |
|                       |                       | by a backslash        |
|                       |                       | followed by def (the  |
|                       |                       | backslash is escaped) |
+-----------------------+-----------------------+-----------------------+

#### Example:

``` linenumber
01 MAIN
02   IF "abcdef" LIKE "a%e_" THEN
03      DISPLAY "yes"
04   END IF
05 END MAIN
```

------------------------------------------------------------------------

### [MATCHES]{#OP_MATCHES}

#### Purpose:

The `MATCHES` operator returns [TRUE](Programs.html#PC_TRUE) if a string
matches a given mask.

#### Syntax:

*`expression`*` `[`[`]{.underline}`NOT`[`]`]{.underline}` MATCHES `*`mask`*` `[`[`]{.underline}` ESCAPE "`*`char`*`" `[`]`]{.underline}

#### Notes:

1.  *expression* is any character string [expression](Expressions.html).
2.  *mask* is a character string expression defining the filter.
3.  *char* is a single char specifying the escape symbol.

#### Usage:

The *mask* can be any combination of characters, including the `*`, ` ?`
and ` []` wildcards:

- The ` *` star character matches any string of zero or more characters.
- The ` ?` question mark matches any single character.
- The ` [ ]` brackets match any enclosed character. A hyphen (`-`)
  between characters means a range of characters. An initial caret (`^`)
  matches any character that is not listed.

The `ESCAPE` clause can be used to define an escape character different
from the default backslash. It must be enclosed in single or double
quotes.

A backslash (or the escape character specified by the `ESCAPE` clause)
makes the operator treat the next character as a literal character, even
if it is one of the special symbols in the above list. This allows you
to search for `*`, `?`, `[`, `]` or `\` characters.

**Warning: If you need to escape a wildcard character, keep in mind that
a string constant must also escape the backslash character. As a result,
if you want to pass a backslash to the MATCHES operator (by using
backslash as default escape character), you need to write four
backslashes in the original string constant.**

The next table shows some examples of string constants used in the
source code and their equivalent `MATCHES` pattern:

+-----------------------+-----------------------+-----------------------+
| **Original\           | **Equivalent\         | **Description**       |
| String Constant**     | MATCHES pattern**     |                       |
+-----------------------+-----------------------+-----------------------+
| `"*"`                 | `*`                   | Matches any character |
|                       |                       | in a non-empty        |
|                       |                       | string.               |
+-----------------------+-----------------------+-----------------------+
| `"?"`                 | `?`                   | Matches a single      |
|                       |                       | character.            |
+-----------------------+-----------------------+-----------------------+
| `"abc*"`              | `abc*`                | Starts with abc.      |
+-----------------------+-----------------------+-----------------------+
| `"*abc"`              | `*abc`                | Ends with abc.        |
+-----------------------+-----------------------+-----------------------+
| `"*abc*"`             | `*abc*`               | Contains abc.         |
+-----------------------+-----------------------+-----------------------+
| `"[a-z]*"`            | `[a-z]*`              | Starts with a letter  |
|                       |                       | in the range a to z.  |
+-----------------------+-----------------------+-----------------------+
| `"abc??"`             | `abc??`               | Strings equals abc    |
|                       |                       | followed by two       |
|                       |                       | additional            |
|                       |                       | characters.           |
+-----------------------+-----------------------+-----------------------+
| `"\\*"`               | `\*`                  | Contains a single     |
|                       |                       | star character (the   |
|                       |                       | \* wildcard is        |
|                       |                       | escaped)              |
+-----------------------+-----------------------+-----------------------+
| `"*abc\\\\def*"`      | `*abc\\def*`          | Contains abc followed |
|                       |                       | by a backslash        |
|                       |                       | followed by def (the  |
|                       |                       | backslash is escaped) |
+-----------------------+-----------------------+-----------------------+

#### Example:

``` linenumber
01 MAIN
02   IF "55f-plot" MATCHES "55[a-z]-*" THEN
03      DISPLAY "Item reference format is correct."
04   END IF
05 END MAIN
```

------------------------------------------------------------------------

### [CONCATENATE]{#OP_CONCATENATE}

#### Purpose:

The `||` operator is the concatenation operator that produces a string
expression.

#### Syntax:

` `*`expr`*` || `*`expr`*

#### Notes:

1.  *expr* can be a character, numeric or date time expression.
2.  This operator has a high precedence; it can be used in parameters
    for function calls.
3.  The precedence of this operator is higher than [LIKE](#OP_LIKE) and
    [MATCHES](#OP_MATCHES), but less than arithmetic operators. For
    example, `a || b + c` is equivalent to `(a||(b+c))`.

#### Warnings:

1.  If any of the members of a concatenation expression is
    [NULL](Programs.html#PC_NULL), the result string will be NULL.

#### Example:

``` linenumber
01 MAIN
02   DISPLAY "Length: " || length( "ab" || "cdef" )
03 END MAIN
```

------------------------------------------------------------------------

### [APPEND]{#OP_APPEND}

#### Purpose:

The `,` (comma) language element appends a value to a string and returns
the concatenated result.

#### Syntax:

*`charexpr , expr`*

#### Notes:

1.  Can only be used in [LET](Variables.html#VA_LET) and
    [DISPLAY](RecordDisplay.html#DISPLAY_TO) instructions.
2.  In earlier versions this was the only way to concatenate strings;
    you can also use the [`||`](#OP_CONCATENATE) [concatenation
    operator](#OP_CONCATENATE).

#### Example:

``` linenumber
01 MAIN
02   DISPLAY "Today:", TODAY, " and a number: ", 12345.67
03 END MAIN
```

------------------------------------------------------------------------

### [SUBSTRING]{#OP_SUBSTRING}

#### Purpose:

The `[]` (square braces) notation following a CHAR or VARCHAR variable
extracts a sub-string from the character variable.

#### Syntax:

*`charvar`*` [ `*`start`*` `[`[`]{.underline}`, `*`end`*` `[`]`]{.underline}` ]`

#### Notes:

1.  *start* defines the position of the first character of the
    sub-string to be extracted.
2.  *end* defines the position of the last character of the sub-string
    to be extracted.
3.  If *end* is not specified, only one character is extracted.

#### Warnings:

1.  Sub-strings expressions in SQL statements are evaluated by the
    database server. This may have a different behavior than the
    sub-string operator of the language.

#### Example:

``` linenumber
01 MAIN
02   DEFINE s CHAR(10)
03   LET s = "abcdef"
04   DISPLAY s[3,4]
05 END MAIN
```

------------------------------------------------------------------------

### [USING]{#OP_USING}

#### Purpose:

The `USING` operator converts date, datetime and numeric values into a
string with a formatting mask.

#### Syntax:

` `*`expr`*` USING `*`format`*

#### Notes:

1.  *format* is a string expression that defines the formatting mask to
    be used; see below for more details.

#### Usage:

The `USING` operator applies a formatting string to the left operand.

The format operand can be any valid [string
expression](Expressions.html#EX_STRING) using formatting characters as
described later in this section.

#### Warnings:

1.  The `USING` operator has a low [order of
    precedence](#PRECEDENCE_LIST): if you use operators with a higher
    precedence, the resulting string might not be what you are
    expecting. For example, the [\|\| concatenation
    operator](#OP_CONCATENATE) is evaluated before `USING`. As a
    result:\
    `   LET x = a || b USING "`*`format`*`"`\
    will first concatenate `a` and `b`, then apply the `USING` format.\
    To solve this issue, use braces around the `USING` expression:\
    `   LET x = a || (b USING "`*`format`*`")`

##### [Formatting symbols for numbers:]{#FORMAT_NUMBERS}

For [DECIMAL](DataTypes.html#DT_DECIMAL),
[MONEY](DataTypes.html#DT_MONEY),
[SMALLFLOAT](DataTypes.html#DT_SMALLFLOAT), and
[FLOAT](DataTypes.html#DT_FLOAT) data types, *format-string* consists of
a set of place holders that represent digits, currency symbols,
thousands and decimal separators. For example, `"###.##@"` defines three
places to the left of the decimal point and exactly two to the right,
plus a currency symbol at the end of the string.

When used with numeric values, the *format-string* must use normalized
place holders described in the table below. The place holders will be
replaced by the elements defined in the
[DBMONEY](EnvironmentVariables.html#EV_DBMONEY) or
[DBFORMAT](EnvironmentVariables.html#EV_DBFORMAT) environment variables.

::: {align="left"}
  --------------- --------------------------------------------------------------------------------------------------------------------------------------------------------------
  **Character**   **Description**
  `*`             Fills with asterisks any position that would otherwise be blank.
  `&`             Fills with zeros any position that would otherwise be blank.
  `#`             This does not change any blank positions in the display.
  `<`             Causes left alignment.
  `-`             Displays a minus sign for negative numbers.
  `+`             Displays a plus sign for positive numbers.
  `(`             Displayed as left parentheses for negative numbers (accounting parentheses).
  `)`             Displayed as right parentheses for negative numbers (accounting parentheses).
  `,` (comma)     Placeholder for thousand separator defined in [DBFORMAT](EnvironmentVariables.html#EV_DBFORMAT).
  `.` (period)    Placeholder for decimal separator defined in [DBMONEY](EnvironmentVariables.html#EV_DBMONEY) or [DBFORMAT](EnvironmentVariables.html#EV_DBFORMAT).
  `$`             Placeholder for the *front* currency symbol defined in [DBMONEY](EnvironmentVariables.html#EV_DBMONEY) or [DBFORMAT](EnvironmentVariables.html#EV_DBFORMAT).
  `@`             Placeholder for the *back* currency symbol defined in [DBMONEY](EnvironmentVariables.html#EV_DBMONEY) or [DBFORMAT](EnvironmentVariables.html#EV_DBFORMAT).
  --------------- --------------------------------------------------------------------------------------------------------------------------------------------------------------
:::

##### [Formatting symbols for dates:]{#FORMAT_DATES}

::: {align="left"}
  --------------- -------------------------------------------------------------------------------------------
  **Character**   **Description**
  `dd`            Day of the month as a 2-digit integer.
  `ddd`           Three-letter English-language abbreviation of the day of the week, for example, Mon, Tue.
  `mm`            Month as a 2-digit integer.
  `mmm`           Three-letter English-language abbreviation of the month, for example, Jan, Feb.
  `yy`            Year, as a 2-digits integer representing the 2 trailing digits. 
  `yyy`           Year as a 3-digit number *(Ming Guo format only)*
  `yyyy`          Year as a 4-digit number.
  `c1`            [Ming Guo](Localization.html#MING_GUO) format modifier.
  --------------- -------------------------------------------------------------------------------------------
:::

#### Example:

``` linenumber
01 MAIN
02   DEFINE d DECIMAL(12,2)
03   LET d = -12345678.91
04   DISPLAY d USING "$-##,###,##&.&&"
05   DISPLAY TODAY USING "yyyy-mm-dd"
06 END MAIN
```

------------------------------------------------------------------------

### [CLIPPED]{#OP_CLIPPED}

#### Purpose:

The `CLIPPED` operator removes trailing blanks of a string expression.

#### Syntax:

*`charexpr`*` CLIPPED`

#### Example:

``` linenumber
01 MAIN
02   DISPLAY "Some text   " CLIPPED
03 END MAIN
```

------------------------------------------------------------------------

### [COLUMN]{#OP_COLUMN}

#### Purpose:

The `COLUMN` operator generates blanks.

#### Syntax:

`COLUMN `*`pos`*

#### Notes:

1.  *pos* is the column position (starts at 1).

#### Usage:

The `COLUMN` operator is typically used in [REPORT](Reports.html)
routines to align data in [PRINT](Reports.html#RPT_STMT_PRINT)
statements and move the character position forward within the current
line. This operator makes sense when used in an expression with the
[append operator](#OP_APPEND): Spaces will be generated according to the
number of characters that have been used in the expression, before the
`COLUMN` operator.

The `COLUMN` operator can be used outside report routines, in order to
align data to be displayed with a proportional font, typically in a TUI
context. For example, the next lines will always display the content of
the *lastname* variable starting from column 30 of the terminal, no
matters the number of characters contained in the *firstname* variable
(note that the example defines [VARCHAR](DataTypes.html#DT_VARCHAR)
variables, since [CHAR](DataTypes.html#DT_CHAR) variables are
blank-padded, we would need to use the [CLIPPED](#OP_CLIPPED) operator):

``` linenumber
01  DEFINE firstname, lastname VARCHAR(50)
02  DISPLAY firstname, COLUIMN(30), lasttname
```

The *pos* operand must be a non-negative integer that specifies a
character position offset (from the left margin) no greater than the
line width (that is, no greater than the difference (right margin - left
margin). This designation moves the character position to a left-offset,
where 1 is the first position after the left margin. If current position
is greater than the operand, the `COLUMN` specification is ignored.

#### Example:

``` linenumber
01  PAGE HEADER
02    PRINT "Number", COLUMN 12,"Name", COLUMN 35,"Location"
03  ON EVERY ROW
04    PRINT customer_num, COLUMN 12,fname, COLUMN 35,city
```

------------------------------------------------------------------------

### [ORD]{#OP_ORD}

#### Purpose:

`ORD()` converts a character expression and returns the integer value of
the first byte of that argument.

#### Syntax:

`ORD( `*`source`*` STRING )`

#### Notes:

1.  *source* is a [string expression](Expressions.html#EX_STRING).

#### Usage:

Only the first byte of the argument is evaluated. This operator is
case-sensitive. It returns [NULL](Programs.html#PC_NULL) if the argument
passed is not valid.

For a default (U.S. English) locale, `ORD()` is the logical inverse of
the [ASCII()](Operators.html#OP_ASCII) operator.

*See also:* [FGL_KEYVAL()](BuiltInFunctions.html#BF_FGL_KEYVAL),
[ASCII()](Operators.html#OP_ASCII).

------------------------------------------------------------------------

### [SPACES]{#OP_SPACES}

#### Purpose:

`SPACES` returns a character string with blanks.

#### Syntax:

*`intexpr`*` SPACES`

#### Warnings:

1.  *intexpr* is an integer expression.
2.  \"SPACE\" is an alias for this operator.

#### Example:

``` linenumber
01 MAIN
02   DISPLAY 20 SPACES || "xxx"
03 END MAIN
```

------------------------------------------------------------------------

### [LSTR]{#OP_LSTR}

#### Purpose:

`LSTR()` returns a [Localized String](LocalizedStrings.html)
corresponding to the identifier passed as parameter.

#### Syntax:

`LSTR(`*`strexpr)`*

#### Warnings:

1.  *strexpr* is a [string expression](Expressions.html#EX_STRING).

#### Example:

``` linenumber
01 MAIN
02   DISPLAY LSTR ("str"||123)  -- loads string 'str123'
03 END MAIN
```

------------------------------------------------------------------------

### [SFMT]{#OP_SFMT}

#### Purpose:

`SFMT()` returns a string after replacing the parameters passed.

#### Syntax:

`SFMT( `*`strexpr`*` , `*`param`*` `[`[`]{.underline}` , `*`param`*` `[`[...]`]{.underline}` `[`]`]{.underline}` )`

#### Warnings:

1.  *strexpr* is a [string expression](Expressions.html#EX_STRING).
2.  *param* is any valid [expression](Expressions.html) used to replace
    parameter place holders (%*n*).
3.  At least one parameter is required.

#### Usage:

The `SFMT()` operator can be used with parameters that will be
automatically set in the string at the position defined by parameter
place holders. The parameters used with the `SFMT()` operator can be any
valid expressions. Numeric and date/time expressions are evaluated to
strings according to the current format settings
([DBDATE](EnvironmentVariables.html#EV_DBDATE),
[DBMONEY](EnvironmentVariables.html#EV_DBMONEY)).

A place holder a is special marker in the string, that is defined by the
percent character followed by the parameter number. For example, %4
represents the parameter #4. You are allowed to use the same parameter
place holder several times in the string. If you want to use the percent
sign in the string, you must escape it with %%.

Predefined  placeholders can be used to insert information about last
runtime system error that occurred. Note that these are only available
in the context of a runtime error trapped with a [WHENEVER ERROR GOTO /
CALL](Exceptions.html#DEFINITION) handler:

  -------------------------- --------------------------------------------------------------
  **Predefined parameter**   **Description**
  `%(ERRORFILE)`             Name of the module where last runtime error occurred.
  `%(ERRORLINE)`             Line number in the module where last runtime error occurred.
  `%(ERRNO)`                 Last operating system error number.
  `%(STRERROR)`              Last operating system error text.
  -------------------------- --------------------------------------------------------------

#### Example:

``` linenumber
01 MAIN
02   DEFINE n INTEGER
03   LET n = 234
04   DISPLAY SFMT("Order #%1 has been %2.",n,"deleted")
05 END MAIN
```

------------------------------------------------------------------------

### [ADDITION]{#OP_ADDITION}

#### Purpose:

The `+` operator adds a number to another.

#### Syntax:

` `*`numexpr`*` + `*`numexpr`*

#### Example:

``` linenumber
01 MAIN
02  DISPLAY 100 + 200
03 END MAIN
```

------------------------------------------------------------------------

### [SUBTRACTION]{#OP_SUBTRACTION}

#### Purpose:

The `-` operator subtracts a number from another.

#### Syntax:

` `*`numexpr`*` - `*`numexpr`*

#### Example:

``` linenumber
01 MAIN
02  DISPLAY 100 - 200
03 END MAIN
```

------------------------------------------------------------------------

### [MULTIPLICA]{#OP_MULTIPLICATION}[TION]{#OP_MULTIPLICATION}

#### Purpose:

The `*` operator multiplies a number with another.

#### Syntax:

` `*`numexpr`*` * `*`numexpr`*

#### Example:

``` linenumber
01 MAIN
02  DISPLAY 100 * 200
03 END MAIN
```

------------------------------------------------------------------------

### [DIVISION]{#OP_DIVISION}

#### Purpose:

The `/` operator divides a number by another.

#### Syntax:

` `*`numexpr`*` / `*`numexpr`*

#### Example:

``` linenumber
01 MAIN
02  DISPLAY 100 / 200
03 END MAIN
```

------------------------------------------------------------------------

### [EXPONENTIATION]{#OP_EXPONENTIATION}

#### Purpose:

The `**` operator returns a value calculated by raising the left-hand
operand to a power corresponding to the integer part of the right-hand
operand.

#### Syntax:

*`numexpr`*` ** `*`intexpr`*

#### Example:

``` linenumber
01 MAIN
02  DISPLAY 2 ** 8
03  DISPLAY 10 ** 4
04 END MAIN
```

**Warning: If the right operand is a number with a decimal part, it is
rounded to a whole integer before computing the exponentiation.**

------------------------------------------------------------------------

### [MODULUS]{#OP_MODULUS}

#### Purpose:

The `MOD` operator returns the remainder, as an integer, from the
division of the integer part of two numbers. 

#### Syntax:

*`intexpr`*` MOD `*`intexpr`*

#### Example:

``` linenumber
01 MAIN
02   DISPLAY 256 MOD 16
03   DISPLAY 26 MOD 2
04   DISPLAY 27 MOD 2
05 END MAIN
```

**Warning: If the right operand is a number with a decimal part, it is
rounded to a whole integer before computing the modulus.**

------------------------------------------------------------------------

### [CURRENT]{#OP_CURRENT}

#### Purpose:

`CURRENT` returns the current date and time according to the qualifier.

#### Syntax:

`CURRENT `*`qual1 TO qual2`*[`[`]{.underline}`(`*`scale`*`)`[`]`]{.underline}

#### Notes:

1.  *qual1,* *qual2* and *scale* define the date time qualifier; see the
    [DATETIME](DataTypes.html#DT_DATETIME) data type for more details.

#### Example:

``` linenumber
01 MAIN
02   DISPLAY CURRENT YEAR TO FRACTION(4)
03   DISPLAY CURRENT HOUR TO SECOND
04 END MAIN
```

------------------------------------------------------------------------

### [EXTEND]{#OP_EXTEND}

#### Purpose:

`EXTEND()` adjusts a date time value according to the qualifier.

#### Syntax:

`EXTEND ( `*`dtexpr`*`, `*`qual1 TO qual2`*[`[`]{.underline}`(`*`scale`*`)`[`]`]{.underline}` )`

#### Notes:

1.  This operator is used to convert a date time expression to a
    [DATETIME](DataTypes.html#DT_DATETIME) value with a different
    precision.
2.  *dtexpr* is a [date](Expressions.html#EX_DATETIME) or
    [datetime](Expressions.html#EX_DATETIME) expression. If it is a
    character string, it must consist of valid and unambiguous time-unit
    values and separators, but with these restrictions:
    - It cannot be a character string in date format, such as
      \"12/12/99\".
    - It cannot be an ambiguous numeric datetime value, such as
      \"05:06\" or \"05\".
    - It cannot be a time expression that returns an
      [INTERVAL](DataTypes.html#DT_INTERVAL) value.
3.  *qual1,* *qual2* and *scale* define the date time qualifier, see the
    [DATETIME](DataTypes.html#DT_DATETIME) data type for more details.
4.  The default qualifier is `YEAR TO DAY.`

#### Example:

``` linenumber
01 MAIN
02   DISPLAY EXTEND ( TODAY, YEAR TO FRACTION(4) )
03 END MAIN
```

------------------------------------------------------------------------

### [DATE]{#OP_DATE}

#### Purpose:

`DATE()` converts a character expression, an integer or a datetime to a
date value.

#### Syntax:

`DATE `[`[`]{.underline}`(`*`dtexpr`*`)`[`]`]{.underline}

#### Notes:

1.  *dtexpr* is a character [string](Expressions.html#EX_STRING), an
    [integer](Expressions.html#EX_INTEGER) or a
    [datetime](Expressions.html#EX_DATETIME) expression.
2.  This operator is used to convert a character string, an integer or a
    date time value to a [DATE](DataTypes.html#DT_DATE) value.
3.  When *dtexpr* is a character string expression, it must properly
    formatted according to datetime format settings like
    [DBDATE](EnvironmentVariables.html).
4.  If *dtexpr* is an integer expression, it is used as the number of
    days since December 31, 1899.
5.  If you supply no operand, it returns a character representation of
    the current date in the format \"weekday month day year\".

#### Example:

``` linenumber
01 MAIN
02   DISPLAY DATE ( 34000 )
03   DISPLAY DATE ( "12/04/1978" )
04   DISPLAY DATE ( CURRENT )
05 END MAIN
```

------------------------------------------------------------------------

### [TIME]{#OP_TIME}

#### Purpose:

`TIME()` converts the time-of-day portion of its datetime operand to a
character string.

#### Syntax:

`TIME `[`[`]{.underline}`(`*`dtexpr`*`)`[`]`]{.underline}

#### Notes:

1.  *dtexpr* is a [datetime](Expressions.html#EX_DATETIME) expression.
2.  This operator converts a date time expression to a character string
    representing the time-of-day part of its operand.
3.  The format of the returned string is always \"hh:mm:ss\".
4.  If you supply no operand, it returns a character representation of
    the current time.

#### Example:

``` linenumber
01 MAIN
02   DISPLAY TIME ( CURRENT )
03 END MAIN
```

------------------------------------------------------------------------

### [TODAY]{#OP_TODAY}

#### Purpose:

`TODAY` returns the current calendar date.

#### Syntax:

`TODAY`

#### Notes:

1.  Reads current system clock and returns a
    [DATE](DataTypes.html#DT_DATE) value that represents the current
    calendar date.

#### Tips:

1.  See also the [CURRENT](#OP_CURRENT) operator that returns current
    date and time.

#### Example:

``` linenumber
01 MAIN
02   DISPLAY TODAY
03 END MAIN
```

------------------------------------------------------------------------

### [YEAR]{#OP_YEAR}

#### Purpose:

`YEAR()` extracts the year of a date time expression.

#### Syntax:

`YEAR ( `*`dtexpr`*` )`

#### Notes:

1.  *dtexpr* is a [date](DataTypes.html#DT_DATE) or
    [datetime](DataTypes.html#DT_DATETIME) expression.
2.  Returns an integer corresponding to the year portion of its operand.

#### Example:

``` linenumber
01 MAIN
02   DISPLAY YEAR ( TODAY )
03   DISPLAY YEAR ( CURRENT )
04 END MAIN
```

------------------------------------------------------------------------

### [MONTH]{#OP_MONTH}

#### Purpose:

`MONTH()` extracts the month of a date time expression.

#### Syntax:

`MONTH ( `*`dtexpr`*` )`

#### Notes:

1.  *dtexpr* is a [date](Expressions.html#EX_DATETIME) or
    [datetime](Expressions.html#EX_DATETIME) expression.
2.  Returns a positive whole number between 1 and 12 corresponding to
    the month of its operand.

#### Example:

``` linenumber
01 MAIN
02   DISPLAY MONTH ( TODAY )
03   DISPLAY MONTH ( CURRENT )
04 END MAIN
```

------------------------------------------------------------------------

### [DAY]{#OP_DAY}

#### Purpose:

`DAY()` extracts the day of the month of a date time expression.

#### Syntax:

`DAY ( `*`dtexpr`*` )`

#### Notes:

1.  *dtexpr* is a [date](Expressions.html#EX_DATETIME) or
    [datetime](Expressions.html#EX_DATETIME) expression.
2.  Returns a positive whole number between 1 and 31 corresponding to
    the day of the month of its operand.

#### Example:

``` linenumber
01 MAIN
02   DISPLAY DAY ( TODAY )
03   DISPLAY DAY ( CURRENT )
04 END MAIN
```

------------------------------------------------------------------------

### [WEEKDAY]{#OP_WEEKDAY}

#### Purpose:

`WEEKDAY()` extracts the day of the week of a date time expression.

#### Syntax:

`WEEKDAY ( `*`dtexpr`*` )`

#### Notes:

1.  *dtexpr* is a [date](Expressions.html#EX_DATETIME) or
    [datetime](Expressions.html#EX_DATETIME) expression.
2.  Returns a positive whole number between 0 and 6 corresponding to the
    day of the week implied by its operand.
3.  The integer 0 (Zero) represents Sunday.

#### Example:

``` linenumber
01 MAIN
02   DISPLAY WEEKDAY ( TODAY )
03   DISPLAY WEEKDAY ( CURRENT )
04 END MAIN
```

------------------------------------------------------------------------

### [MDY]{#OP_MDY}

#### Purpose:

`MDY()` builds a date value with 3 integers representing the month, day
and year.

#### Syntax:

`MDY ( `*`intexpr1`*`, `*`intexpr2`*`, `*`intexpr3`*` )`

#### Notes:

1.  *intexpr1* is an integer representing the month (from 1 to 12).
2.  *intexpr2* is an integer representing the day (from 1 to 28, 29, 30
    or 31 depending on the month).
3.  *intexpr3* is an integer representing the year (four digits).
4.  The result is a [DATE](DataTypes.html#DT_DATE) value.
5.  The MDY() function is sensitive to the [C1 modifier of
    DBDATE](Localization.html#MING_GUO).

#### Example:

``` linenumber
01 MAIN
02   DISPLAY MDY ( 12, 3+2, 1998 )
03 END MAIN
```

------------------------------------------------------------------------

### [UNITS]{#OP_UNITS}

#### Purpose:

`UNITS` converts an integer expression to an interval value.

#### Syntax:

` `*`intexpr`*` UNITS `*`qual`*[`[`]{.underline}`(`*`scale`*`)`[`]`]{.underline}

#### Notes:

1.  *intexpr* is an integer expression.
2.  *qual* is one of the unit specifiers of a
    [DATETIME](DataTypes.html#DT_DATETIME) qualifier.
3.  The result is a [INTERVAL](DataTypes.html#DT_INTERVAL) value.

#### Example:

``` linenumber
01 MAIN
02   DEFINE d DATE
03   LET d = TODAY + 200
04   DISPLAY (d - TODAY) UNITS DAY
05 END MAIN
```

------------------------------------------------------------------------

### [GET_FLDBUF]{#OP_GET_FLDBUF}

#### Purpose:

`GET_FLDBUF` returns as character strings the current values of the
specified fields.

#### Syntax:

`GET_FLDBUF ( `[`[`]{.underline}*`group`*`.`[`]`]{.underline}*`field`*` `[`[,...]`]{.underline}` )`

#### Notes:

1.  *group* can be a table name, a screen record, a screen array or
    \'formonly\'.
2.  *field* is the name of the screen field.
3.  Typically used to get the value of a screen field before the input
    buffer is copied into the associated variable.
4.  If multiple fields are specified between parentheses, you must use
    the [RETURNING](Functions.html) clause.
5.  When used in a [INPUT ARRAY](InputArray.html) instruction, the
    runtime system assumes that you are referring to the current row.

#### Warnings:

1.  The values returned by this operator are context dependent; it must
    be used carefully. If possible, use the [variable](Variables.html)
    associated to the input field instead.

#### Example:

``` linenumber
01 ...
02   LET v = GET_FLDBUF( customer.custname )
03   CALL GET_FLDBUF( customer.* ) RETURNING rec_customer.*
04 ...
```

------------------------------------------------------------------------

### [INFIELD]{#OP_INFIELD}

#### Purpose:

`INFIELD` returns [TRUE](Programs.html#PC_TRUE) if its operand is the
identifier of the current screen field.

#### Syntax:

`INFIELD ( `[`[`]{.underline}*`group`*`.`[`]`]{.underline}*`field`*` )`

#### Notes:

1.  *group* can be a table name, a screen record, a screen array or
    \'FORMONLY\'.
2.  *field* is the name of the field in the form.
3.  Typically used to check for the current field in a
    [CONSTRUCT](Construct.html), [INPUT](RecordInput.html) or [INPUT
    ARRAY](InputArray.html) instruction.
4.  When used in an [INPUT ARRAY](InputArray.html) instruction, the
    runtime system assumes that you are referring to the current row.

#### Example:

``` linenumber
01 ...
02 INPUT ...
03   IF INFIELD( customer.custname ) THEN
04      MESSAGE "The current field is customer's name."
05 ...
```

------------------------------------------------------------------------

### [FIELD_TOUCHED]{#OP_FIELD_TOUCHED}

#### Purpose:

`FIELD_TOUCHED` returns [TRUE](Programs.html#PC_TRUE) if the value of a
screen field has changed since the beginning of the interactive
instruction.

#### Syntax:

`FIELD_TOUCHED ( `[`{`]{.underline}` `[`[`]{.underline}*`group`*`.`[`]`]{.underline}*`field | group`*`.* | * `[`}`]{.underline}` `[`[,...]`]{.underline}` )`

#### Notes:

1.  *group* can be a table name, a screen record, a screen array or
    \'FORMONLY\'.
2.  *field* is the name of the field in the form.

#### Warnings:

1.  The `FIELD_TOUCHED` operator can only be used inside an `INPUT`,
    `INPUT ARRAY` and `CONSTRUCT` interaction block.
2.  Do not confuse with
    [FGL_BUFFERTOUCHED](BuiltInFunctions.html#BF_FGL_BUFFERTOUCHED); in
    that function, the flag is reset when entering a new field.

#### Usage:

This operator is typically used to check if the value of a field (or
multiple fields) was modified during the dialog execution.

The operator accept a list of explicit field names, the \[*group*.\]\*
notation in order to check multiple fields in a unique function call.
When passing a simple asterisk (\*) to the operator, the runtime system
will check all fields used by the current dialog.

Note that when used in an [INPUT ARRAY](InputArray.html) instruction,
the runtime system assumes that you are referring to the current row.

For more details about the `FIELD_TOUCHED` operator usage and the
understand the \"touched flag\" concept, see the [Touched Flag
section](MultipleDialogs.html#touched-flag) of the `DIALOG` instruction.

#### Example:

``` linenumber
01 ...
02 AFTER FIELD custname
03   IF FIELD_TOUCHED( customer.custname ) THEN
04      MESSAGE "Customer name was changed."
05   END IF
06 ...
07 AFTER INPUT
08   IF FIELD_TOUCHED( customer.* ) THEN
09      MESSAGE "Customer record was changed."
10 ...
```
