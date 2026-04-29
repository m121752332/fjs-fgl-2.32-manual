[Back to Contents](../index.html)

------------------------------------------------------------------------

# [Expressions]{#PAGE_HEADER}

Summary:

- [Definition](#DEFINITION)
- [Boolean Expressions](#EX_BOOLEAN)
- [Integer Expressions](#EX_INTEGER)
- [Number Expressions](#EX_NUMBER)
- [String Expressions](#EX_STRING)
- [Date Expressions](#EX_DATE)
- [Datetime Expressions](#EX_DATETIME)
- [Interval Expressions](#EX_INTERVAL)

*See also:* [Variables](Variables.html), [Data Types](DataTypes.html),
[Literals](Literals.html), [Constants](Constants.html).

------------------------------------------------------------------------

### [Definition]{#DEFINITION}

#### What is an Expression?

An Expression is a sequence of operands, operators, and parentheses that
the runtime system can evaluate as a single value.

Expressions can include the following components:

- Operators, as described in the [Operators section](Operators.html).
- Parentheses, to overwrite precedence of operators.
- Operands, including the following:
  - [Variables](Variables.html)
  - [Constants](Constants.html)
  - [Functions](Functions.html) (returning a single value)
  - [Literal values](Literals.html)
  - Other expressions

#### Differences Between BDL and SQL Expressions

Expressions in SQL statements are evaluated by the database server, not
by the runtime system. The set of operators that can appear in SQL
expressions resembles the set of BDL operators, but they are not
identical. A program can include SQL operators, but these are restricted
to SQL statements. Similarly, most SQL operands are not valid in BDL
expressions. The SQL identifiers of databases, tables, or columns can
appear in a `LIKE` clause or field name in BDL statements, provided that
these SQL identifiers comply with the naming rules of BDL. Here are some
examples of SQL operands and operators that cannot appear in other BDL
expressions:

- SQL identifiers, such as column names
- The SQL keywords ` USER` and ` ROWID`
- Built-in or aggregate SQL functions that are not part of BDL
- The ` BETWEEN` and ` IN` operators
- The `EXISTS`, `ALL`, `ANY`, or ` SOME` keywords of SQL expressions

Conversely, you *cannot* include BDL specific operators in SQL
expressions, as for example:

- Arithmetic operators for exponentiation (`**`) and modulus (`MOD`)
- String operators `ASCII`, `COLUMN`, `SPACE`, `SPACES`, and ` WORDWRAP`
- Field operators ` FIELD_TOUCHED( )`, ` GET_FLDBUF( )`, and
  `INFIELD( )`
- The report operators ` LINENO` and ` PAGENO`

#### Parentheses in BDL Expressions

You can use parentheses as you would in algebra to override the default
order of precedence of operators. In mathematics, this use of
parentheses represents the \"associative\" operator. It is, however, a
convention in computer languages to regard this use of parentheses as
delimiters rather than as operators. (Do not confuse this use of
parentheses to specify *operator* *precedence* with the use of
parentheses to enclose arguments in function calls or to delimit other
lists.)

In the following example, the variable **y** is assigned the value of 2:

`  LET y = 15 MOD 3 + 2`

In the next example, however, **y** is assigned the value of 0 because
the parentheses change the sequence of operations:

`  LET y = 15 MOD (3 + 2)`

------------------------------------------------------------------------

### [Boolean Expressions]{#EX_BOOLEAN}

A **Boolean expression** is one that evaluates to an
[INTEGER](DataTypes.html#DT_INTEGER) value that can be
[TRUE](Programs.html#PC_TRUE), [FALSE](Programs.html#PC_FALSE) and in
some cases, [NULL](Programs.html#PC_NULL).

#### Usage:

Boolean expressions are a combination of [Logical
Operators](Operators.html#LOGICAL_OPERATORS) and Boolean comparisons
based on [Comparison Operators](Operators.html#COMPARISON_OPERATORS).
The result type of a Boolean expression is
[INTEGER](DataTypes.html#DT_INTEGER). Any integer value different from
zero is defined as true, while zero is defined as false. You can use an
[INTEGER](DataTypes.html#DT_INTEGER) or a
[BOOLEAN](DataTypes.html#DT_BOOLEAN) variable to store the result of a
Boolean expression:

``` linenumber
01 MAIN
02   DEFINE b BOOLEAN
03   LET b = ( TRUE AND FALSE )
04   IF b THEN
05      DISPLAY "TRUE"
06   END IF
07 END MAIN
```

If an expression that returns ` NULL` is the operand of the ` IS NULL`
operator, the value of the Boolean expression is `TRUE`:

``` linenumber
01 MAIN
02   DEFINE r INTEGER
03   LET r = NULL
04   IF r IS NULL THEN
05      DISPLAY "TRUE"
06   END IF
07 END MAIN
```

If you include a Boolean expression in a context where the runtime
system expects a number, the expression is evaluated, and is then
converted to an integer by the rules: ` TRUE = 1` and ` FALSE = 0`:

The Boolean expression evaluates to ` TRUE` if the value is a non-zero
real number *or* any of the following items:

- Character string representing a non-zero number
- Non-zero ` INTERVAL`
- Any ` DATE` or ` DATETIME` value
- A ` TRUE` value returned by a Boolean function like `INFIELD( )`
- The built-in integer constant ` TRUE`

If a Boolean expression includes an operand whose value is not an
integer data type, the runtime system attempts to convert the value to
an integer according to the [data conversion
rules](DataConversions.html).

#### Example:

``` linenumber
01 MAIN
02   DEFINE r, c INTEGER
03   LET c = 4
03   LET r = ( FALSE!=FALSE ) AND ( c=2 OR c=4 )
04   IF ( r AND canReadFile("config.txt") ) THEN
05      DISPLAY "OK"
06   END IF
07 END MAIN
```

#### Warnings:

1.  A Boolean expression evaluates to [NULL](Programs.html#PC_NULL) if
    the value is ` NULL` *and* the expression does not appear in any of
    the following contexts:
    - The ` IS [NOT] NULL` test.
    - Boolean Comparisons.
    - Any conditional statement (`IF`, `CASE`, `WHILE`).
2.  The syntax of Boolean expressions in BDL is not the same as *Boolean
    conditions* in SQL statements.
3.  Boolean expressions in `CASE`, `IF`, or ` WHILE` statements return
    ` FALSE` if any element of the comparison is `NULL`, except for
    operands of the ` IS NULL` and the ` IS NOT NULL` operator. See
    [Boolean Operators](Operators.html) for more information about
    individual Boolean operators and Boolean expressions.

------------------------------------------------------------------------

### [Integer Expressions]{#EX_INTEGER}

An **Integer expression** is one that evaluates to a whole number.

#### Usage:

The data type of the expression result can be
[SMALLINT](DataTypes.html#DT_SMALLINT) or
[INTEGER](DataTypes.html#DT_INTEGER).

The operands must be one of:

- An [integer literal](Literals.html#LT_INTEGER)
- A [variable](Variables.html) or [constant](Constants.html) of type
  [SMALLINT](DataTypes.html#DT_SMALLINT) or
  [INTEGER](DataTypes.html#DT_INTEGER)
- A [function](Functions.html) returning a single integer value
- A [Boolean expression](#EX_BOOLEAN)
- The result of a [DATE](DataTypes.html#DT_DATE) subtraction

If an integer expression includes an operand whose value is not an
integer data type, the runtime system attempts to convert the value to
an integer according to the [data conversion
rules](DataConversions.html).

#### Example:

``` linenumber
01 MAIN
02   DEFINE r, c INTEGER
03   LET c = 4
04   LET r = c * ( 2 + c MOD 4 ) / getRowCount("customers")
05 END MAIN
```

#### Warnings:

1.  If an element of an integer expression is
    [NULL](Programs.html#PC_NULL), the expression is evaluated to NULL.

------------------------------------------------------------------------

### [Number Expressions]{#EX_NUMBER}

A **Number expression** is one that evaluates to a number data type.

#### Usage:

The data type of the expression result can be
[SMALLINT](DataTypes.html#DT_SMALLINT),
[INTEGER](DataTypes.html#DT_INTEGER),
[DECIMAL](DataTypes.html#DT_DECIMAL),
[SMALLFLOAT](DataTypes.html#DT_SMALLFLOAT) or
[FLOAT](DataTypes.html#DT_FLOAT).

The operands must be one of:

- An [integer literal](Literals.html#LT_INTEGER)
- A [decimal literal](Literals.html#LT_DECIMAL)
- A [variable](Variables.html) or [constant](Constants.html) of numeric
  data type
- A [function](Functions.html) returning a single numeric value
- A [Boolean expression](#EX_BOOLEAN)
- The result of a [DATE](DataTypes.html#DT_DATE) subtraction

If a number expression includes an operand whose value is not a numeric
data type, the runtime system attempts to convert the value to a number
according to the [data conversion rules](DataConversions.html).

#### Example:

``` linenumber
01 MAIN
02   DEFINE r, c DECIMAL(10,2)
03   LET c = 456.22
04   LET r = c * 2 + ( c / 4.55 )
05 END MAIN
```

#### Warnings:

1.  If an element of a number expression is
    [NULL](Programs.html#PC_NULL), the expression is evaluated to
    `NULL`.

------------------------------------------------------------------------

### [String Expressions]{#EX_STRING}

A **String expression** is one that includes at least one character
string value and that evaluates to the
[STRING](DataTypes.html#DT_STRING) data type.

#### Usage:

The data type of the expression result is
[STRING](DataTypes.html#DT_STRING).

At least one of the operands must be one of:

- A [string literal](Literals.html#LT_STRING).
- A [variable](Variables.html) or [constant](Constants.html) of type
  [CHAR](DataTypes.html#DT_CHAR), [VARCHAR](DataTypes.html#DT_VARCHAR)
  or [STRING](DataTypes.html#DT_STRING).
- A [function](Functions.html) returning a single character value

Other operands whose values are not character string data types are
converted to strings according to the [data conversion
rules](DataConversions.html).

#### Example:

``` linenumber
01 MAIN
02   DEFINE r, c VARCHAR(100)
03   LET c = "abcdef" 
04   LET r = c[1,3] || ": " || TODAY USING "YYYY-MM-DD" || " " || length(c)
05 END MAIN
```

#### Warnings:

1.  If an element of an integer expression is
    [NULL](Programs.html#PC_NULL), the expression is evaluated to NULL.
2.  An empty string (\"\") is equivalent to
    [NULL](Programs.html#PC_NULL).

------------------------------------------------------------------------

### [Date Expressions]{#EX_DATE}

A **Date expression** is one that evaluates to a
[DATE](DataTypes.html#DT_DATE) data type.

#### Usage:

The data type of the expression result is a
[DATE](DataTypes.html#DT_DATE) value.

The operands must be one of:

- A [string literal](Literals.html#LT_STRING) that can be evaluated to a
  Date according to [DBDATE](EnvironmentVariables.html#EV_DBDATE)
- A [variable](Variables.html) or [constant](Constants.html) of type
  [DATE](DataTypes.html#DT_DATE)
- A [function](Functions.html) returning a single Date value
- A unary `+` or `-` associated to an [Integer expression](#EX_INTEGER)
  representing a number of days
- The ` TODAY` constant
- A ` CURRENT` expression with ` YEAR TO DAY` qualifiers
- An ` EXTEND` expression with ` YEAR TO DAY` qualifiers

If a date expression includes an operand whose value is not a date data
type, the runtime system attempts to convert the value to a date value
according to the [data conversion rules](DataConversions.html).

#### Example:

``` linenumber
01 MAIN
02   DEFINE r, c DATE
03   LET c = TODAY + 4
04   LET r = ( c - 2 )
05 END MAIN
```

#### Warnings:

1.  If an element of an integer expression is
    [NULL](Programs.html#PC_NULL), the expression is evaluated to NULL.

------------------------------------------------------------------------

### [Datetime Expressions]{#EX_DATETIME}

A **Datetime expression** is one that evaluates to a
[DATETIME](DataTypes.html#DT_DATETIME) data type.

#### Usage:

The data type of the expression result is a
[DATETIME](DataTypes.html#DT_DATETIME) value.

The operands must be one of:

- A [datetime literal](Literals.html#LT_DATETIME)
- A [string literal](Literals.html#LT_STRING) representing a Datetime
  with the ISO format `YYYY-MM-DD hh:mm:ss.fffff`
- A [variable](Variables.html) or [constant](Constants.html) of
  [DATETIME](DataTypes.html#DT_DATETIME) type
- A [function](Functions.html) returning a single Datetime value
- A unary `+` or `-` associated to an [Interval
  expression](#EX_INTERVAL)
- A `CURRENT` expression
- An `EXTEND` expression

If a datetime expression includes an operand whose value is not a
datetime data type, the runtime system attempts to convert the value to
a datetime value according to the [data conversion
rules](DataConversions.html).

#### Example:

``` linenumber
01 MAIN
02   DEFINE r, c DATETIME YEAR TO SECOND
03   LET c = CURRENT YEAR TO SECOND
04   LET r = c + INTERVAL( 234-02 ) YEAR TO MONTH
05 END MAIN
```

#### Warnings:

1.  If an element of an integer expression is
    [NULL](Programs.html#PC_NULL), the expression is evaluated to NULL.

------------------------------------------------------------------------

### [Interval Expressions]{#EX_INTERVAL}

An **Interval expression** is one that evaluates to a
[INTERVAL](DataTypes.html#DT_INTERVAL) data type.

#### Usage:

The data type of the expression result is a
[INTERVAL](DataTypes.html#DT_INTERVAL) value.

The operands must be one of:

- An [interval literal](Literals.html#LT_INTERVAL)
- A [string literal](Literals.html#LT_STRING) representing an Interval
  with the ISO format `YYYY-MM-DD hh:mm:ss.fffff`
- An [integer expression](#EX_INTEGER) using [the UNITS
  operator](Operators.html#OP_UNITS)
- A [variable](Variables.html) or [constant](Constants.html) of
  [INTERVAL](DataTypes.html#DT_INTERVAL) type
- A [function](Functions.html) returning a single Interval value
- The result of a [DATETIME](DataTypes.html#DT_DATETIME) subtraction

If an interval expression includes an operand whose value is not an
interval data type, the runtime system attempts to convert the value to
an interval value according to the [data conversion
rules](DataConversions.html).

#### Example:

``` linenumber
01 MAIN
02   DEFINE r, c INTERVAL HOUR TO MINUTE
03   LET c = "12:45"
04   LET r = c + ( DATETIME( 14-02 ) HOUR TO MINUTE - DATETIME( 10-43 ) HOUR TO MINUTE )
05 END MAIN
```

#### Warnings:

1.  If an element of an integer expression is
    [NULL](Programs.html#PC_NULL), the expression is evaluated to NULL.
