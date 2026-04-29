[Back to Contents](../index.html)

------------------------------------------------------------------------

# [Data Types]{#PAGE_HEADER}

The data types supported by the language:

::: {align="center"}
**Data Type**
:::

**Description**

**String Data Types**

[CHAR](#DT_CHAR)

Fixed size character strings

[VARCHAR](#DT_VARCHAR)

Variable size character strings

[STRING](#DT_STRING)

Dynamic size character strings

**Date and Datetime Data Types**

[DATE](#DT_DATE)

Simple calendar dates

[DATETIME](#DT_DATETIME)

High precision date and hour data

[INTERVAL](#DT_INTERVAL)

High precision time intervals

**Numeric Data Types**

[TINYINT](#DT_TINYINT)

1 byte signed integer

[SMALLINT](#DT_SMALLINT)

2 byte signed integer

[INTEGER](#DT_INTEGER)

4 byte signed integer

[BIGINT](#DT_BIGINT)

8 byte signed integer

[SMALLFLOAT](#DT_SMALLFLOAT)

4 byte floating point decimal

[FLOAT](#DT_FLOAT)

8 byte floating point decimal

[DECIMAL](#DT_DECIMAL)

High precision decimals

[MONEY](#DT_MONEY)

High precision decimals with currency formatting

**Large Data Types**

[BYTE](#DT_BYTE)

Large binary data (images)

[TEXT](#DT_TEXT)

Large text data (plain text)

**BOOLEAN Data Types**

[BOOLEAN](#DT_BOOLEAN)

TRUE/FALSE bool

*See also:* [Data Conversions](DataConversions.html),
[Variables](Variables.html), [Programs](Programs.html).

------------------------------------------------------------------------

### [CHAR data type]{#DT_CHAR}

#### Purpose:

The `CHAR` data type is a fixed-length character string data type.

#### Syntax:

` CH``AR[ACTER] `[`[`]{.underline}` (`*`size`*`) `[`]`]{.underline}

#### Notes:

1.  `CHAR` and `CHARACTER` are synonyms.
2.  *size* defines the length of the variable; the number of bytes
    allocated for the variable. The upper limit is **65534**.
3.  When *size* is not specified, the default length is 1 character.

#### Usage:

`CHAR` variables are initialized to [NULL](Programs.html#PC_NULL) in
functions, modules and globals.

The *size* defines the number of **bytes** the variable can store. It is
important to distinguish [bytes]{.underline} from
[characters]{.underline}, because in a multi-byte character set, one
character may be encoded on several bytes. For example, in the
ISO-8859-1 character set, \"forêt\" uses 5 bytes, while in the UTF-8
multi-byte character set, the same word occupies 6 bytes, because the
\"ê\" letter is coded with two bytes.

`CHAR` variables are always filled with trailing blanks, but the
trailing blanks are not significant in comparisons:

``` linenumber
01 MAIN
02   DEFINE c CHAR(10)
03   LET c = "abcdef"
04   DISPLAY "[", c ,"]"      -- displays [abcdef    ]
05   IF c == "abcdef" THEN    -- this is TRUE
06      DISPLAY "equals"
07   END IF
08 END MAIN
```

------------------------------------------------------------------------

### [VARCHAR data type]{#DT_VARCHAR}

#### Purpose:

The `VARCHAR` data type is a variable-length character string data type,
with a maximum size.

#### Syntax:

` VARC``HAR `[`[`]{.underline}` ( `*`size`*`, `[`[`]{.underline}` `*`reserve`*` `[`]`]{.underline}` ) `[`]`]{.underline}

#### Notes:

1.  The *size* defines the maximum length of the variable; the maximum
    number of bytes the variable can store. The upper limit is
    **65534**.
2.  *reserve* is not used, however its inclusion in the syntax for a
    ` VARCHAR` variable is permitted for compatibility with the SQL data
    type.
3.  When *size* is not specified, the default length is 1 character.

#### Usage:

`VARCHAR` variables are initialized to [NULL](Programs.html#PC_NULL) in
functions, modules and globals.

The *size* defines the maximum number of **bytes** the variable can
store. It is important to distinguish [bytes]{.underline} from
[characters]{.underline}, because in a multi-byte character set, one
character may be encoded on several bytes. For example, in the
ISO-8859-1 character set, \"forêt\" uses 5 bytes, while in the UTF-8
multi-byte character set, the same word occupies 6 bytes, because the
\"ê\" letter is coded with two bytes.

`VARCHAR` variables store trailing blanks (i.e. `"abc "` is different
from `"abc"`). Trailing blanks are displayed or printed in reports, but
they are not significant in comparisons:

``` linenumber
01 MAIN
02   DEFINE vc VARCHAR(10)
03   LET vc = "abc  "         -- two trailing blanks
04   DISPLAY "[", vc ,"]"     -- displays [abc  ]
05   IF vc == "abc" THEN      -- this is TRUE
06      DISPLAY "equals"
07   END IF
08 END MAIN
```

When you insert character data from `VARCHAR` variables into `VARCHAR`
columns in a database table, the trailing blanks are kept. Likewise,
when you fetch `VARCHAR` column values into `VARCHAR` variables,
trailing blanks are kept. 

``` linenumber
01 MAIN
02   DEFINE vc VARCHAR(10)
03   DATABASE test1
04   CREATE TABLE table1 ( k INT, x VARCHAR(10) )
05   LET vc = "abc  "         -- two trailing blanks
06   INSERT INTO table1 VALUES ( 1, vc )
07   SELECT x INTO vc FROM table1 WHERE k = 1
08   DISPLAY "[", vc ,"]"     -- displays [abc  ]
09 END MAIN
```

**Warning: In SQL statements, the behavior of the comparison operators
when using `VARCHAR` values differs from one database to the other. IBM
Informix is ignoring trailing blanks, but most other databases take
trailing blanks of `VARCHAR` values into account. See [SQL
Programming](SqlProgramming.html#PORT_CHARVARCHAR) for more details.**

------------------------------------------------------------------------

### [STRING data type]{#DT_STRING}

#### Purpose:

The `STRING` data type is a variable-length, dynamically allocated
character string data type, without limitation.

#### Syntax:

`STRING`

#### Usage:

The behavior of a `STRING` variable is similar to the
` `[`VARCHAR`](#DT_VARCHAR) data type. For example, as `VARCHAR`
variables, `STRING` variables have significant trailing blanks (i.e.
` "abc   "` is different from ` "abc"`). There is no size limitation, it
depends on available memory.

**Warning: Unlike `VARCHAR`, a `STRING` can hold a value of zero length
without being [NULL](Programs.html#PC_NULL). For example, if you trim a
string variable with the trim() method and if the original value is a
set of blank characters, the result is an empty string. But testing the
variable with the [IS NULL](Operators.html#OP_ISNULL) operator will
evaluate to [FALSE](Programs.html#PC_FALSE). Using a `VARCHAR` with the
[CLIPPED](Operators.html#OP_CLIPPED) operator would give a `NULL` string
in this case. **

`STRING` variables are initialized to [NULL](Programs.html#PC_NULL) in
functions, modules and globals.

The `STRING` data type is typically used to implement utility functions
manipulating character string with unknown size. It cannot be used to
store SQL character string data, because databases have rules that need
a maximum size as for `CHAR` and `VARCHAR` types. 

**Warning: The `STRING` data type cannot be used as SQL parameter of
fetch buffer.**

Variables declared with the `STRING` data type can use built-in class
methods such as `getLength()` or `toUpperCase()`.

#### Methods:

**Warning: The `STRING` methods are all based on byte-length-semantics.
In a multi-byte environment, the getLength() method returns the number
of bytes, which can be different from the number of characters.**

+----------------------------------------------------+---------------------------------------------+
| **Object Methods**                                                                               |
+----------------------------------------------------+---------------------------------------------+
| **Name**                                           | **Description**                             |
+----------------------------------------------------+---------------------------------------------+
| `append( str ``STRING`` )`\                        | Returns a new string made by adding *str*   |
| `  ``RETURNING STRING`                             | to the end of the current string.           |
+----------------------------------------------------+---------------------------------------------+
| `equals( src ``STRING`` )`\                        | Returns [TRUE](Programs.html#PC_TRUE) if    |
| `  ``RETURNING INTEGER`                            | the string passed as parameters matches the |
|                                                    | current string. If one of the strings is    |
|                                                    | [NULL](Programs.html#PC_NULL) the method    |
|                                                    | returns [FALSE](Programs.html#PC_FALSE).    |
+----------------------------------------------------+---------------------------------------------+
| `equalsIgnoreCase( src ``STRING`` )`\              | Returns [TRUE](Programs.html#PC_TRUE) if    |
| `  ``RETURNING INTEGER`                            | the string passed as parameters matches the |
|                                                    | current string, [ignoring character         |
|                                                    | case]{.underline}. If one of the strings is |
|                                                    | [NULL](Programs.html#PC_NULL) the method    |
|                                                    | returns [FALSE](Programs.html#PC_FALSE).    |
+----------------------------------------------------+---------------------------------------------+
| `getCharAt( pos ``INTEGER`` )`\                    | Returns the character at the byte position  |
| `  ``RETURNING STRING`                             | *pos* (starts at 1). Returns                |
|                                                    | [NULL](Programs.html#PC_NULL) if the        |
|                                                    | position does not match a valid             |
|                                                    | character-byte position in the current      |
|                                                    | string or if the current string is null.    |
+----------------------------------------------------+---------------------------------------------+
| `getIndexOf( str ``STRING``, spos ``INTEGER`` )`\  | Returns the position of the sub-string      |
| `  ``RETURNING INTEGER`                            | *str* in the current string, starting from  |
|                                                    | byte position *spos*. Returns zero if the   |
|                                                    | sub-string was not found. Returns -1 if     |
|                                                    | string is [NULL](Programs.html#PC_NULL).    |
+----------------------------------------------------+---------------------------------------------+
| `getLength( )`\                                    | This method counts the number of bytes,     |
| `  ``RETURNING INTEGER`                            | including trailing blanks. The              |
|                                                    | [LENGTH()](BuiltInFunctions.html#BF_LENGTH) |
|                                                    | built-in function ignores trailing blanks.  |
+----------------------------------------------------+---------------------------------------------+
| `subString( spos ``INTEGER``, epos ``INTEGER`` )`\ | Returns the sub-string starting at byte     |
| `  ``RETURNING STRING`                             | position *spos* and ending at *epos*.       |
|                                                    | Returns [NULL](Programs.html#PC_NULL) if    |
|                                                    | the positions do not delimit a valid        |
|                                                    | sub-string in the current string, or if the |
|                                                    | current string is null.                     |
+----------------------------------------------------+---------------------------------------------+
| `toLowerCase( )`\                                  | Converts the current string to lowercase.   |
| `  ``RETURNING STRING`                             | Returns [NULL](Programs.html#PC_NULL) if    |
|                                                    | the string is null.                         |
+----------------------------------------------------+---------------------------------------------+
| `toUpperCase( )`\                                  | Converts the current string to uppercase.   |
| `  ``RETURNING STRING`                             | Returns [NULL](Programs.html#PC_NULL) if    |
|                                                    | the string is null.                         |
+----------------------------------------------------+---------------------------------------------+
| `trim( )`\                                         | Removes white space characters from the     |
| `  ``RETURNING STRING`                             | beginning and end of the current string.    |
|                                                    | Returns [NULL](Programs.html#PC_NULL) if    |
|                                                    | the string is null.                         |
+----------------------------------------------------+---------------------------------------------+
| `trimLeft( )`\                                     | Removes white space characters from the     |
| `  ``RETURNING STRING`                             | beginning of the current string. Returns    |
|                                                    | [NULL](Programs.html#PC_NULL) if the string |
|                                                    | is null.                                    |
+----------------------------------------------------+---------------------------------------------+
| `trimRight( )`\                                    | Removes white space characters from the end |
| `  ``RETURNING STRING`                             | of the current string. Returns              |
|                                                    | [NULL](Programs.html#PC_NULL) if the string |
|                                                    | is null.                                    |
+----------------------------------------------------+---------------------------------------------+

#### Example:

``` linenumber
01 MAIN
02   DEFINE s STRING
03   LET s = "abcdef  "
04   DISPLAY s || ". (" || s.getLength() || ")"
05   IF s.trimRight() = "abcdef" THEN
06     DISPLAY s.toUpperCase()
07   END IF
08 END MAIN
```

------------------------------------------------------------------------

### [INTEGER data  type]{#DT_INTEGER}

#### Purpose:

The `INTEGER` data type is used for storing large whole numbers.

#### Syntax:

` INT`[`[`]{.underline}`EGER`[`]`]{.underline}

#### Notes:

1.  `INT` and `INTEGER` are synonyms.

#### Usage:

The storage of `INTEGER` variables is based on 4 bytes of signed data (
= 32 bits ).

The value range is from -2,147,483,647 to +2,147,483,647.

When assigning a whole number that exceeds the `INTEGER` range, the
overflow error [-1215](FglErrors.html#-1215) will be raised.

`INTEGER` variables are initialized to zero in functions, modules and
globals.

The `INTEGER` type can be used to define variables storing values from
SERIAL columns.

#### Example:

``` linenumber
01 MAIN
02   DEFINE i INTEGER
03   LET i = 1234567
04   DISPLAY i
05 END MAIN
```

------------------------------------------------------------------------

### [SMALLINT data type]{#DT_SMALLINT}

#### Purpose:

The `SMALLINT` data type is used for storing small whole numbers.

#### Syntax:

` SMALLINT`

#### Notes:

1.  Variables are initialized to zero in functions, modules and globals.
2.  `SMALLINT` values can be converted to strings.

#### Usage:

The storage of `SMALLINT` variables is based on 2 bytes of signed data (
= 16 bits ).

The value range is from -32,767 to +32,767.

When assigning a whole number that exceeds the `SMALLINT` range, the
overflow error [-1214](FglErrors.html#-1214) will be raised.

`SMALLINT` variables are initialized to zero in functions, modules and
globals.

#### Example:

``` linenumber
01 MAIN
02   DEFINE i SMALLINT
03   LET i = 1234
04   DISPLAY i
05 END MAIN
```

------------------------------------------------------------------------

### [TINYINT data type]{#DT_TINYINT}

#### Purpose:

The `TINYINT` data type is used for storing very small whole numbers.

#### Syntax:

`TINYINT`

#### Notes:

1.  Variables are initialized to zero in functions, modules and globals.
2.  `TINYINT` values can be converted to strings.

#### Usage:

The storage of `TINYINT` variables is based on 1 byte of signed data (
=  8 bits ).

The value range is from -128 to +127.

When assigning a whole number that exceeds the `TINYINT` range, the
overflow error [-8097](FglErrors.html#-8097) will be raised.

`TINYINT` variables are initialized to zero in functions, modules and
globals.

**Warning: The TINYINT variables cannot be NULL.**

#### Example:

``` linenumber
01 MAIN
02   DEFINE i TINYINT
03   LET i = 101
04   DISPLAY i
05 END MAIN
```

------------------------------------------------------------------------

### [BIGINT data type]{#DT_BIGINT}

#### Purpose:

The `BIGINT` data type is used for storing very large whole numbers.

#### Syntax:

`BIGINT`

#### Notes:

1.  Variables are initialized to zero in functions, modules and globals.
2.  `BIGINT` values can be converted to strings.

#### Usage:

The storage of `BIGINT` variables is based on 8 bytes of signed data (
=  64 bits ).

The value range is from -9223372036854775807 to +9223372036854775807.

When assigning a whole number that exceeds the `BIGINT` range, the
overflow error [-1284](FglErrors.html#-1284) will be raised.

`BIGINT` variables are initialized to zero in functions, modules and
globals.

The `BIGINT` type can be used to define variables used in SQL
statements. It can be used to store data from INT8, SERIAL8, BIGINT and
BIGSERIAL columns. Note that
[SQLCA.SQLERRD\[2\]](Connections.html#SQLCA_RECORD) is an INTEGER, not a
BIGINT: To retrieve the last generated BIGSERIAL or SERIAL8, you must
use the IBM Informix dbinfo() SQL function
(`SELECT dbinfo('bigserial') FROM systables WHERE tabid = 1`).

#### Example:

``` linenumber
01 MAIN
02   DEFINE i BIGINT
03   LET i = 9223372036854775600
04   DISPLAY i
05 END MAIN
```

------------------------------------------------------------------------

### [FLOAT data type]{#DT_FLOAT}

#### Purpose:

The `FLOAT` data type stores values as double-precision floating-point
binary numbers with up to 16 significant digits.

#### Syntax:

[`{`]{.underline}` FLOAT `[`|`]{.underline}` DOUBLE PRECISION `[`}`]{.underline}` `[`[`]{.underline}`(`*`precision`*`)`[`]`]{.underline}

#### Notes:

1.  `FLOAT` and `DOUBLE PRECISION` are synonyms.
2.  The *precision* can be specified but it has no effect in programs.

#### Usage:

The storage of `FLOAT` variables is based on 8 bytes of signed data ( =
64 bits ), this type is equivalent to the **double** data type in C.

`FLOAT` variables are initialized to zero in functions, modules and
globals.

`FLOAT` values can be converted to strings according to the
[DBMONEY](EnvironmentVariables.html#EV_DBMONEY) environment variable
(defines the decimal separator).

Tip: This data type it is not recommended for exact decimal storage; use
the [DECIMAL](#DT_MONEY) data type instead.

------------------------------------------------------------------------

### [SMALLFLOAT data type]{#DT_SMALLFLOAT}

#### Purpose:

The `SMALLFLOAT` data type stores values as single-precision
floating-point binary numbers with up to 8 significant digits.

#### Syntax:

` `[`{`]{.underline}` SMALLFLOAT `[`|`]{.underline}` REAL `[`}`]{.underline}

#### Notes:

1.  `SMALLFLOAT` and `REAL` are synonyms.
2.  `SMALLFLOAT` values can be converted to strings according to the
    `DBMONEY` environment variable (which defines the decimal
    separator).

#### Usage:

The storage of `SMALLFLOAT` variables is based on 4 bytes of signed data
( = 32 bits ), this type is equivalent to the **float** data type in C.

`SMALLFLOAT` variables are initialized to zero in functions, modules and
globals.

`SMALLFLOAT` values can be converted to strings according to the
` `[`DBMONEY`](EnvironmentVariables.html#EV_DBMONEY) environment
variable (defines the decimal separator).

Tip: This data type it is not recommended for exact decimal storage; use
the [`DECIMAL`](#DT_MONEY) data type instead.

------------------------------------------------------------------------

### [DECIMAL data type]{#DT_DECIMAL}

#### Purpose:

The `DECIMAL` data type is provided to handle large numeric values with
exact decimal storage.

#### Syntax:

` `[`{`]{.underline}` DEC`[`[`]{.underline}`IMAL`[`]`]{.underline}` `[`|`]{.underline}` NUMERIC `[`}`]{.underline}` `[`[`]{.underline}` ( `*`precision`*[`[`]{.underline}`,`*`scale`*[`]`]{.underline}` ) `[`]`]{.underline}

#### Notes:

1.  `DEC`, `DECIMAL` and `NUMERIC` are synonyms.
2.  *precision* defines the number of significant digits (limit is 32,
    default is 16).
3.  *scale* defines the number of digits to the right of the decimal
    point.
4.  When no *scale* is specified, the data type defines a floating point
    number.

#### Usage:

The `DECIMAL` data type must be used for storing number with fractional
parts that must be calculated exactly.

`DECIMAL` variables are initialized to [NULL](Programs.html#PC_NULL) in
functions, modules and globals.

The largest absolute value that a `DECIMAL(p,s)` can store without
errors is 10^p-s^ - 10^s^. The stored value can have up to 30
significant decimal digits in its fractional part, or up to 32 digits to
the left of the decimal point.

When you specify both the *precision* and *scale*, you define a decimal
with a fixed point arithmetic. If the data type declaration specifies a
*precision* but no *scale*, it defines a floating-point number with
*precision* significant digits. If the data type declaration specifies
no *precision* and *scale*, the default is `DECIMAL(16)`, a
floating-point number with a precision of 16 digits.

`DECIMAL` values can be converted to strings according to the
` `[`DBMONEY`](EnvironmentVariables.html#EV_DBMONEY) environment
variable (defines the decimal separator).

#### Warnings:

1.  In ANSI-compliant databases, DECIMAL data types do not provide
    floating point numbers. When you define a database column as
    `DECIMAL(16)`, it is equivalent to a `DECIMAL(16,0)` declaration.
    You should always specify the scale to avoid mistakes.
2.  When the default [exception handler](Exceptions.html) is used, if
    you try to assign a value larger than the Decimal definition (for
    example, 12345.45 into DECIMAL(4,2) ), no out of range error occurs,
    and the variable is assigned with [NULL](Programs.html#PC_NULL). If
    [WHENEVER ANY ERROR](Exceptions.html) is used, it raises error
    [-1226](FglErrors.html). If you do not use [WHENEVER ANY
    ERROR](Exceptions.html), the STATUS variable is not set to
    [-1226](FglErrors.html).

##### high-precision math functions

A couple of precision math functions are available, to be used with
DECIMAL values. These functions have a higher precision as the standard
C library functions based on C double data type, which is equivalent to
[FLOAT](#DT_FLOAT):

- [FGL_DECIMAL_TRUNCATE()](BuiltInFunctions.html#BF_FGL_DECIMAL_TRUNCATE)
- [FGL_DECIMAL_SQRT()](BuiltInFunctions.html#BF_FGL_DECIMAL_SQRT)
- [FGL_DECIMAL_EXP()](BuiltInFunctions.html#BF_FGL_DECIMAL_EXP)
- [FGL_DECIMAL_LOGN()](BuiltInFunctions.html#BF_FGL_DECIMAL_LOGN)
- [FGL_DECIMAL_POWER()](BuiltInFunctions.html#BF_FGL_DECIMAL_POWER)

#### Example:

``` linenumber
01 MAIN
02   DEFINE d1 DECIMAL(10,4)
03   DEFINE d2 DECIMAL(10,3)
04   LET d1 = 1234.4567
05   LET d2 = d1 / 3 -- Rounds decimals to 3 digits
06   DISPLAY d1, d2
07 END MAIN
```

------------------------------------------------------------------------

### [MONEY data type]{#DT_MONEY}

#### Purpose:

The `MONEY` data type is provided to store currency amounts with exact
decimal storage.

#### Syntax:

` MONEY `[`[`]{.underline}` (`*`precision`*[`[`]{.underline}`,`*`scale`*[`]`]{.underline}`) `[`]`]{.underline}

#### Notes:

1.  *precision* defines the number of significant digits (limit is 32,
    default is 16).
2.  *scale* defines the number of digits to the right of the decimal
    point.
3.  When no *scale* is specified, it defaults to 2.

#### Usage:

The `MONEY` data type is provided to store currency amounts. Its
behavior is similar to the [DECIMAL](#DT_DECIMAL) data type, with some
important differences:

A `MONEY` variable is displayed with the currency symbol defined in the
[DBMONEY](EnvironmentVariables.html#EV_DBMONEY) environment variable.

You cannot define floating-point numbers with `MONEY`: If you do not
specific the *scale* in the data type declaration, it defaults to 2. If
no *precision* / *scale* parameters are specified, MONEY is interpreted
as a DECIMAL(16,2).

**Warning: See the [DECIMAL](#DT_DECIMAL) data type.**

------------------------------------------------------------------------

### [DATE data type]{#DT_DATE}

#### Purpose:

The `DATE` data type stores calendar dates with a Year/Month/Day
representation.

#### Syntax:

` DATE`

#### Usage:

Storage of `DATE` variables is based on a 4 byte integer representing
the number of days since 1899/12/31.

The value range is from 0001-01-1 (-693594) to 9999-12-31 (2958464) .

Because ` DATE` values are stored as integers, you can use them in
arithmetic [expressions](Expressions.html): the difference of two dates
returns the number of days. This is possible (and portable) with
language arithmetic [operators](Operators.html), but should be avoided
in SQL statements, because not all databases support integer-based date
arithmetic.

Data conversions, input and display of `DATE` values are ruled by
environment settings, such as the
[DBDATE](EnvironmentVariables.html#EV_DBDATE) and
[DBCENTURY](EnvironmentVariables.html#EV_DBCENTURY) environment
variables.

Several built-in functions and constants are available such as
[MDY()](Operators.html#OP_MDY) and [TODAY](Operators.html#OP_TODAY).

`DATE` variables are initialized to **zero (=1899/12/31)** in functions,
modules and globals.

#### Tips:

1.  Integers can represent dates as a number of days starting from
    1899/12/31, and can be assigned to dates. It is not recommended that
    you directly assign integers to dates, however, for source code
    readability.
2.  As Date-to-String conversion is based on an environment setting, it
    is not recommended that you hardcode strings representing Dates.

#### Example:

``` linenumber
01 MAIN
02   DEFINE d DATE
03   LET d = TODAY
04   DISPLAY d, "  ", d+100
05 END MAIN
```

------------------------------------------------------------------------

### [DATETIME data type]{#DT_DATETIME}

#### Purpose:

The `DATETIME` data type stores date and time data with time units from
the year to fractions of a second.

#### Syntax:

` DATETIME `*`qual1`*` TO `*`qual2`*\
\
`where `*`qual1`*` can be one of:`\
\
`  YEAR`\
`  MONTH`\
`  DAY`\
`  HOUR`\
`  MINUTE`\
`  SECOND`\
`  FRACTION`\
\
`and `*`qual2`*` can be one of:`\
\
`  YEAR`\
`  MONTH`\
`  DAY`\
`  HOUR`\
`  MINUTE`\
`  SECOND`\
`  FRACTION`\
`  FRACTION(1)`\
`  FRACTION(2)`\
`  FRACTION(3)`\
`  FRACTION(4)`\
`  FRACTION(5)`

#### Notes:

1.  *scale* defines the number of significant digits of the fractions of
    a second.
2.  *qual1* and *qual2* qualifiers define the precision of the
    `DATETIME` variable.

#### Usage:

The `DATETIME` data type stores an instance in time, expressed as a
calendar date and time-of-day.

The *qual1* and *qual2* qualifiers define the precision of the
`DATETIME` variable. The precision can range from a year through a
fraction of second.

`DATETIME` arithmetic is based on the [INTERVAL](#DT_INTERVAL) data
type, and can be combined with [DATE](#DT_DATE) values:

  ----------------------- -------------- ------------------------ -----------------
  **Left Operand Type**   **Operator**   **Right Operand Type**   **Result Type**
  `DATETIME`              `-`            `DATETIME`               `INTERVAL`
  `DATETIME`              `-`            `DATE`                   `INTERVAL`
  `DATETIME`              `-`            `INTERVAL`               `DATETIME`
  `DATETIME`              `+`            `INTERVAL`               `DATETIME`
  ----------------------- -------------- ------------------------ -----------------

The [CURRENT](Operators.html#OP_CURRENT) operator provides current
system date/time.

You can assign `DATETIME` variables with [datetime
literals](Literals.html#LT_DATETIME) with a specific notation.

`DATETIME` variables are initialized to [NULL](Programs.html#PC_NULL) in
functions, modules and globals.

`DATETIME` values can be converted to strings by the ISO format
(YYYY-MM-DD hh:mm:ss.fffff).

#### Example:

``` linenumber
01 MAIN
02   DEFINE d1, d2 DATETIME YEAR TO MINUTE
03   LET d1 = CURRENT YEAR TO MINUTE 
04   LET d2 = "1998-01-23 12:34"
05   DISPLAY d1, d2
06 END MAIN
```

------------------------------------------------------------------------

### [INTERVAL data type]{#DT_INTERVAL}

#### Purpose:

The `INTERVAL` data type stores spans of time as Year/Month or
Day/Hour/Minute/Second/Fraction units.

#### Syntax 1: *year-month* class interval

` INTERVAL YEAR`[`[`]{.underline}`(`*`precision`*`)`[`]`]{.underline}`  TO MONTH`\
`|INTERVAL YEAR`[`[`]{.underline}`(`*`precision`*`)`[`]`]{.underline}`  TO YEAR`\
`|INTERVAL MONTH`[`[`]{.underline}`(`*`precision`*`)`[`]`]{.underline}` TO MONTH`

#### Syntax 2: *day-time* class interval

` INTERVAL DAY`[`[`]{.underline}`(`*`precision`*`)`[`]`]{.underline}`      TO FRACTION`[`[`]{.underline}`(`*`scale`*`)`[`]`]{.underline}\
`|INTERVAL DAY`[`[`]{.underline}`(`*`precision`*`)`[`]`]{.underline}`      TO SECOND`\
`|INTERVAL DAY`[`[`]{.underline}`(`*`precision`*`)`[`]`]{.underline}`      TO MINUTE`\
`|INTERVAL DAY`[`[`]{.underline}`(`*`precision`*`)`[`]`]{.underline}`      TO HOUR`\
`|INTERVAL DAY`[`[`]{.underline}`(`*`precision`*`)`[`]`]{.underline}`      TO DAY`\
\
`|INTERVAL HOUR`[`[`]{.underline}`(`*`precision`*`)`[`]`]{.underline}`     TO FRACTION`[`[`]{.underline}`(`*`scale`*`)`[`]`]{.underline}\
`|INTERVAL HOUR`[`[`]{.underline}`(`*`precision`*`)`[`]`]{.underline}`     TO SECOND`\
`|INTERVAL HOUR`[`[`]{.underline}`(`*`precision`*`)`[`]`]{.underline}`     TO MINUTE`\
`|INTERVAL HOUR`[`[`]{.underline}`(`*`precision`*`)`[`]`]{.underline}`     TO HOUR`\
\
`|INTERVAL MINUTE`[`[`]{.underline}`(`*`precision`*`)`[`]`]{.underline}`   TO FRACTION`[`[`]{.underline}`(`*`scale`*`)`[`]`]{.underline}\
`|INTERVAL MINUTE`[`[`]{.underline}`(`*`precision`*`)`[`]`]{.underline}`   TO SECOND`\
`|INTERVAL MINUTE`[`[`]{.underline}`(`*`precision`*`)`[`]`]{.underline}`   TO MINUTE`\
\
`|INTERVAL SECOND`[`[`]{.underline}`(`*`precision`*`)`[`]`]{.underline}`   TO FRACTION`[`[`]{.underline}`(`*`scale`*`)`[`]`]{.underline}\
`|INTERVAL SECOND`[`[`]{.underline}`(`*`precision`*`)`[`]`]{.underline}`   TO SECOND`\
\
`|INTERVAL FRACTION`[`[`]{.underline}`(`*`precision`*`)`[`]`]{.underline}` TO FRACTION`[`[`]{.underline}`(`*`scale`*`)`[`]`]{.underline}

#### Notes:

1.  *precision* defines the number of significant digits of the first
    qualifier, it must be an integer from 1 to 9.\
    For YEAR, the default is 4. For all other time units, the default is
    2.\
    For example, YEAR(5) indicates that the INTERVAL can store a number
    of years with up to 5 digits.

#### Usage:

The `INTERVAL` data type stores a span of time, the difference between
two points in time. It can also be used to store quantities that are
measured in units of time, such as ages or times required for some
activity.

The `INTERVAL` data type falls in two classes, which are mutually
exclusive:

- *Year-time* intervals store a span of years, months or both.
- *Day-time* intervals store a span of days, hours, minutes, seconds and
  fraction of seconds, or a contiguous subset of those units.

`INTERVAL` values can be negative.

`INTERVAL` arithmetic is possible, and can involve
[`DATETIME`](#DT_DATETIME) as well as [DECIMAL](#DT_DECIMAL) operands:

  ----------------------- -------------- ------------------------ -----------------
  **Left Operand Type**   **Operator**   **Right Operand Type**   **Result Type**
  `INTERVAL`              `*`            `DECIMAL`                `INTERVAL`
  `INTERVAL`              `/`            `DECIMAL`                `INTERVAL`
  `INTERVAL`              `-`            `INTERVAL`               `INTERVAL`
  `INTERVAL`              `+`            `INTERVAL`               `INTERVAL`
  `DATETIME`              `-`            `INTERVAL`               `DATETIME`
  `DATETIME`              `+`            `INTERVAL`               `DATETIME`
  `DATETIME`              `-`            `DATETIME`               `INTERVAL`
  ----------------------- -------------- ------------------------ -----------------

You can assign `INTERVAL` variable with [interval
literals](Literals.html#LT_INTERVAL) with a specific notation.

`INTERVAL` values can be converted to strings by using the ISO format
(YYYY-MM-DD hh:mm:ss.fffff).

#### Example:

``` linenumber
01 MAIN
02   DEFINE i1 INTERVAL YEAR TO MONTH
03   DEFINE i2 INTERVAL DAY(5) TO MINUTE
04   LET i1 = "2342-4"
05   LET i2 = "23423 12:34"
06   DISPLAY i1, i2
07 END MAIN
```

------------------------------------------------------------------------

### [BYTE data type]{#DT_BYTE}

#### Purpose:

The `BYTE` data type stores any type of binary data, such as images or
sounds.

#### Syntax:

` BYTE`

#### Usage:

A `BYTE` variable is actually a \'locator\' for a large object stored in
a file or in memory. The `BYTE` data type is a complex type that cannot
be used like simple types such as `INTEGER` or `CHAR`: It is designed to
handle a large amount of unstructured binary data. This type has a
theoretical limit of 2\^31 bytes, but the practical limit depends from
the resources available to the process. You can use the `BYTE` data type
to store, fetch or update the contents of a BYTE database column when
using IBM Informix, or the content of a BLOB column when using another
type of database.

**Warning: A `BYTE` variable must be initialized with the
[LOCATE](Variables.html#VA_LOCATE) instruction before usage. You might
want to free resources allocated to the `BYTE` variable with the
[FREE](Variables.html#VA_FREE) instruction. Note that a `FREE` will
remove the file if the LOB variable is located in a file.**

The `LOCATE` instruction basically defines where the large data object
has to be stored (in file or memory). This instruction will actually
allow you to fetch a LOB into memory or into a file, or insert a LOB
from memory or from a file into the database.

**Warning: When you assign a `BYTE` variable to another `BYTE` variable,
the LOB data is not duplicated, only the handler is copied.**

Note that if you need to clone the large object, you can use the I/O
built-in methods to read/write data from/to a specific file. The large
object can be located in memory, in a specific file or in a temporary
file (the temp dir can be defined by
[DBTEMP](EnvironmentVariables.html#EV_DBTEMP)).

#### Methods:

+-------------------------------------+------------------------------------+
| **Object Methods**                                                       |
+-------------------------------------+------------------------------------+
| **Name**                            | **Description**                    |
+-------------------------------------+------------------------------------+
| `readFile( fileName ``STRING`` ) `  | Reads data from a file and copies  |
|                                     | into memory or to the file used by |
|                                     | the variables according to the     |
|                                     | [LOCATE](Variables.html#VA_LOCATE) |
|                                     | statement issued on the object.    |
+-------------------------------------+------------------------------------+
| `writeFile( fileName ``STRING`` ) ` | Writes data from the variable      |
|                                     | (memory or source file) to the     |
|                                     | destination file passed as         |
|                                     | parameter. The file is created if  |
|                                     | it does not exist.                 |
+-------------------------------------+------------------------------------+

#### Example:

``` linenumber
01 MAIN
02   DEFINE b BYTE
03   DATABASE stock
04   LOCATE b IN MEMORY
05   SELECT png_image INTO b FROM images WHERE image_id = 123
06   CALL b.writeFile("/tmp/image.png")
07 END MAIN
```

------------------------------------------------------------------------

### [TEXT data type]{#DT_TEXT}

#### Purpose:

The `TEXT` data type stores large text data.

#### Syntax:

` TEXT`

#### Usage:

A `TEXT` variable is actually a \'locator\' for a large object stored in
a file or in memory. The `TEXT` data type is a complex type that cannot
be used like basic character string types such as `VARCHAR` or `CHAR`:
It is designed to handle a large amount of text data. You can use this
data type to store, fetch or update the contents of a TEXT database
column when using IBM Informix, or the content of a CLOB column when
using another type of database.

**Warning: A `TEXT` variable must be initialized with the
[LOCATE](Variables.html#VA_LOCATE) instruction before usage. You might
want to free resources allocated to the `TEXT` variable with the
[FREE](Variables.html#VA_FREE) instruction. Note that a `FREE` will
remove the file if the LOB variable is located in a file.**

The `LOCATE` instruction basically defines where the large data object
has to be stored (in file or memory). This instruction will actually
allow you to fetch a LOB into memory or into a file, or insert a LOB
from memory or from a file into the database.

**Warning: When you assign a `TEXT` variable to another `TEXT` variable,
the LOB data is not duplicated, only the handler is copied.**

You can assign `TEXT` variables to/from `VARCHAR`, `CHAR` and `STRING`
variables.

Note that if you need to clone the large object, you can use the I/O
built-in methods to read/write data from/to a specific file. The large
object can be located in memory or in a file.

#### Methods:

+-------------------------------------+------------------------------------+
| **Object Methods**                                                       |
+-------------------------------------+------------------------------------+
| **Name**                            | **Description**                    |
+-------------------------------------+------------------------------------+
| `getLength()`                       | Returns the size of the text in    |
|                                     | bytes.                             |
+-------------------------------------+------------------------------------+
| `readFile( fileName ``STRING`` ) `  | Reads data from a file and copies  |
|                                     | into memory or to the file used by |
|                                     | the variables according to the     |
|                                     | [LOCATE](Variables.html#VA_LOCATE) |
|                                     | statement issued on the object.    |
+-------------------------------------+------------------------------------+
| `writeFile( fileName ``STRING`` ) ` | Writes data from the variable      |
|                                     | (memory or source file) to the     |
|                                     | destination file passed as         |
|                                     | parameter. The file is created if  |
|                                     | it does not exist.                 |
+-------------------------------------+------------------------------------+

#### Example:

``` linenumber
01 MAIN
02   DEFINE t TEXT
03   DATABASE stock
04   LOCATE t IN FILE "/tmp/mytext.txt" 
05   SELECT doc_text INTO t FROM documents WHERE doc_id = 123
06   CALL t.writeFile("/tmp/document.txt")
07 END MAIN
```

------------------------------------------------------------------------

### [BOOLEAN data type]{#DT_BOOLEAN}

#### Purpose:

The `BOOLEAN` data type stores a logical value, TRUE or FALSE.

#### Syntax:

` BOOLEAN`

#### Usage:

Boolean data types have two possible values: ` TRUE` (1) and ` FALSE`
(0). Variables of this type can be used to store the result of a boolean
[expression](Expressions.html).

The `BOOLEAN` type can be used to define variables used in SQL
statements, and can store values of IBM Informix BOOLEAN columns.

**Warning: While IBM Informix SQL BOOLEAN type accepts the \'t\' and
\'f\' values, the Genero BDL BOOLEAN type expects 0/FALSE and 1/TRUE
integer values only. You can however insert/ fetch a BOOLEAN variable
into/from a BOOLEAN column.**

#### Example:

``` linenumber
01 FUNCTION checkOrderStatus( cid )
02   DEFINE oid INT, b BOOLEAN
03   LET b = ( isValid(oid) AND isStored(oid) )
04   IF NOT b THEN
05     ERROR "The order is not ready."
06   END IF
07 END FUNCTION
```

------------------------------------------------------------------------

 
