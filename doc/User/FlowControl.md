[Back to Contents](../index.html)

------------------------------------------------------------------------

# [Flow Control]{#PAGE_HEADER}

Summary:

- [Invoking a function](#FC_CALL) (`CALL`)
- [Returning from a function](#FC_RETURN) (`RETURN`)
- [Conditional cases](#FC_CASE) (`CASE`)
- [Continuing a block](#FC_CONTINUE) (`CONTINUE `*`instruction`*)
- [Leaving a block](#FC_EXIT) (`EXIT `*`instruction`*)
- [Iterative loop](#FC_FOR) (`FOR`)
- [Labeled transfer](#FC_GOTO) (`GOTO`)
- [Conditional block](#FC_IF) (`IF`)
- [Statement label](#FC_LABEL) (`LABEL`)
- [Suspending execution](#FC_SLEEP) (`SLEEP`)
- [Conditional loop](#FC_WHILE) (`WHILE`)

*See also:* [Exceptions](Exceptions.html), [Programs](Programs.html),
[Functions](Functions.html), [Reports](Reports.html),
[Expressions](Expressions.html)

------------------------------------------------------------------------

### [CALL]{#FC_CALL}

#### Purpose:

The `CALL` instruction invokes a specified [function](Functions.html).

#### Syntax:

`CALL `*`function`*` ( `[`[`]{.underline}` `*`parameter`*` `[`[,...]`]{.underline}` `[`]`]{.underline}` ) `[`[`]{.underline}` RETURNING `*`variable`*` `[`[,...]`]{.underline}` `[`]`]{.underline}

#### Notes:

1.  *function* can be one of:

    - a [function](Functions.html) defined in one of the modules of the
      program. If the [IMPORT](Programs.html#IMPORT) instruction was
      used to import a module, *function* can be prefixed with the name
      of the module followed by a dot (i.e. *module.function)*.

    - a [built-in function](BuiltInFunctions.html) of the language.

    - a [built-in class](BuiltInClasses.html) method of the language.

    - a [Java class](JavaBridge.html) method.

2.  *parameter* can be a [variable](Variables.html), a
    [literal](Literals.html), a [constant](Constants.html) or any valid
    [expression](Expressions.html), including object references of
    built-in or Java classes.

3.  *parameters* are separated by a comma \' , \'.

4.  The `RETURNING` clause assigns values returned by the function to
    variables in the calling routine.

5.  *variable* is a [variable](Variables.html) receiving a value
    returned by the function.

6.  The `RETURNING` clause is only needed when the function returns
    parameters.

7.  A [function](Functions.html) returning a single parameter can be
    used in [expressions](Expressions.html).

#### Tips:

1.  You can use a [double-pipe operator \' \|\|
    \'](Operators.html#OP_CONCATENATE) to pass the concatenation of
    [character expressions](Expressions.html#EX_STRING) as a parameter.

#### Warnings:

1.  The value of a receiving [*variable*](Variables.html) may be
    different from the value returned by the function, following the
    [data conversion rules](DataConversions.html).

#### Example 1: Function returning a single value

``` linenumber
01 MAIN
02   DEFINE var1 CHAR(10)
03   DEFINE var2 CHAR(2)
04   LET var1 = foo()
05   DISPLAY "var1 = " || var1
06   CALL foo() RETURNING var2
07   DISPLAY "var2 = " || var2
08 END MAIN
09 
10 FUNCTION foo() 
11   RETURN "Hello"
12 END FUNCTION
```

#### Example 2: Function returning several values

``` linenumber
01 MAIN
02   DEFINE var1 CHAR(15)
03   DEFINE var2 CHAR(15)
04   CALL foo() RETURNING var1, var2
05   DISPLAY var1, var2
06 END MAIN
07 
08 FUNCTION foo() 
09   DEFINE r1 CHAR(15)
10   DEFINE r2 CHAR(15)
11   LET r1 = "return value 1"
12   LET r2 = "return value 2"
13   RETURN r1, r2
14 END FUNCTION
```

#### Example 3: Function and records

``` linenumber
01 MAIN
02   DEFINE r1 RECORD
03              id1     INTEGER,
04              id2     INTEGER,
05              name    CHAR(30)
06            END RECORD
07   CALL get_name( NULL, NULL, NULL ) RETURNING r1.*
08   CALL get_name( NULL, r1.id2, r1.name ) RETURNING r1.*
09   CALL get_name( r1.* ) RETURNING r1.*
10   DISPLAY r1.name
11   CALL get_name( 1, 2, "John" ) RETURNING r1.id2, r1.id1, r1.name
12   DISPLAY r1.name
13 END MAIN
14
15 FUNCTION get_name( code1, code2, name )
16   DEFINE code1   INTEGER
17   DEFINE code2   INTEGER
18   DEFINE name    CHAR(30)
19   IF code1 IS NULL THEN
20      LET name = "ERROR:code1 is NULL"
21      LET code2 = NULL 
22   ELSE
23      IF code2 IS NULL THEN
24        LET name = "ERROR:code2 is NULL"
25        LET code1 = NULL 
26      ELSE
27         IF name IS NULL THEN
28            LET name = "SMITH"
29         END IF
30      END IF
31   END IF
32   RETURN code1, code2, name
33 END FUNCTION
```

------------------------------------------------------------------------

### [RETURN]{#FC_RETURN}

#### Purpose:

The `RETURN` instruction transfers the control back from a
[function](Functions.html) with optional return values.

#### Syntax:

`RETURN `[`[`]{.underline}` `*`value`*` `[`[,...]`]{.underline}` `[`]`]{.underline}` `

#### Notes:

1.  *value* can be a [variable](Variables.html), a
    [literal](Literals.html), a [constant](Constants.html) or any valid
    [expression](Expressions.html).

2.  [Record](Records.html) members can be returned with the `.*` or
    `THRU` notation. Each member is returned as an independent variable.

3.  A [function](Functions.html) may have several `RETURN` points (not
    recommended in structured programming) but they must all return the
    same number of values.

4.  The number of returned *values* must correspond to the number of
    variables listed in the `RETURNING` clause of the [`CALL`](#FC_CALL)
    statement invoking this function.

#### Warnings:

1.  A function cannot return an [array](Arrays.html).

#### Example:

``` linenumber
01 MAIN
02   DEFINE forname, surname CHAR(10)
03   CALL foo(NULL) RETURNING forname, surname
04   DISPLAY forname CLIPPED, " ", upshift(surname) CLIPPED
05   CALL foo(1) RETURNING forname, surname
06   DISPLAY forname CLIPPED, " ", upshift(surname) CLIPPED
07 END MAIN
08
09 FUNCTION foo(code)
10   DEFINE code   INTEGER
11   DEFINE person RECORD
12                  name1   CHAR(10),
13                  name2   CHAR(20)
14                END RECORD
15  IF code IS NULL THEN
16     RETURN NULL, NULL
17  ELSE
18     LET person.name1 = "John"
19     LET person.name2 = "Smith"
20     RETURN person.*
21  END IF
22 END FUNCTION
```

------------------------------------------------------------------------

### [CASE]{#FC_CASE}

#### Purpose:

The `CASE` instruction specifies statement blocks that must be executed
conditionally.

#### Syntax 1:

`CASE `*`expression-1`*\
`  WHEN `*`expression-2`\
`   `*` `[`{`]{.underline}` `*`statement`*` `[`|`]{.underline}` EXIT CASE `[`}`]{.underline}\
`    `[`[...]`]{.underline}\
`  `[`[`]{.underline}` OTHERWISE `\
*`   `*` `[`{`]{.underline}` `*`statement`*` `[`|`]{.underline}` EXIT CASE `[`}`]{.underline}\
`    `[`[...]`]{.underline}\
`  `[`]`]{.underline}\
`END CASE`

#### Syntax 2:

`CASE`\
`  WHEN `*`boolean-expression`\
`   `*` `[`{`]{.underline}` `*`statement`*` `[`|`]{.underline}` EXIT CASE `[`}`]{.underline}\
`    `[`[...]`]{.underline}\
`  `[`[`]{.underline}` OTHERWISE `\
*`   `*` `[`{`]{.underline}` `*`statement`*` `[`|`]{.underline}` EXIT CASE `[`}`]{.underline}\
`    `[`[...]`]{.underline}\
`  `[`]`]{.underline}\
`END CASE`

#### Notes:

1.  *expression-1* is any [expression](Expressions.html) supported by
    the language.
2.  *expression-2* is an expression that is tested against
    *expression-1. expression-1* and *expression-2* should have the same
    [data type](DataTypes.html).
3.  *boolean-expression* is any [[boolean
    expression]{.underline}](Expressions.html#EX_BOOLEAN) supported by
    the language.
4.  *statement* is any instruction supported by the language.
5.  In a `CASE` flow control block, the first matching `WHEN` block is
    executed. If there is no matching `WHEN` block, then the `OTHERWISE`
    block is executed.
6.  If there is no matching `WHEN` block and no `OTHERWISE` block, then
    the program control jumps to the statement following the `END CASE`
    keyword.
7.  The `EXIT CASE` statement transfers the program control to the
    statement following the `END CASE` keyword.
8.  There is an implicit `EXIT CASE` statement at the end of each
    `WHEN` block and at the end of the `OTHERWISE` block.

#### Warnings:

1.  A `NULL` expression is considered as `FALSE`: When doing a
    `CASE `*`expr ...`*` WHEN [NOT] NULL` using the syntax 1, it always
    evaluates to `FALSE`. Use syntax 2 as
    `CASE ... WHEN `*`expr`*` IS NULL` to test if an
    [expression](Expressions.html) is null.
2.  Make sure that *expression-2* is not a [[boolean
    expression]{.underline}](Expressions.html#EX_BOOLEAN) when using the
    first syntax. The compiler will not raise an error in this case, but
    you might get unexpected results at runtime.
3.  If  there is more than one *expression-2* matching *expression-1*
    (syntax 1), or if two [[boolean
    expressions]{.underline}](Expressions.html#EX_BOOLEAN) (syntax 2)
    are true, only the first matching `WHEN` block will be executed.
4.  The `OTHERWISE` block must be the last block of the ` CASE`
    instruction.

#### Example 1: First syntax

``` linenumber
01 MAIN
02    DEFINE v CHAR(10)
03    LET v = "C1"
04    CASE v
05      WHEN "C1"
06        DISPLAY "Value is C1"
07      WHEN "C2"
08        DISPLAY "Value is C2"
09      WHEN "C3"
10        DISPLAY "Value is C3"
11      OTHERWISE
12        DISPLAY "Unexpected value"
13    END CASE
14 END MAIN
```

#### Example 2: Second syntax

``` linenumber
01 MAIN
02    DEFINE v CHAR(10)
03    LET v = "C1"
04    CASE
05      WHEN ( v="C1" OR v="C2" )
06        DISPLAY "Value is either C1 or C2"
06      WHEN ( v="C3" OR v="C4" )
07        DISPLAY "Value is either C3 or C4"
08      OTHERWISE
09        DISPLAY "Unexpected value"
10    END CASE
11 END MAIN
```

------------------------------------------------------------------------

### [CONTINUE]{#FC_CONTINUE}

#### Purpose:

The `CONTINUE` instruction transfers the program execution from a
statement block to another location in the compound statement that is
currently being executed.

#### Syntax:

`CONTINUE `[`{`]{.underline}` FOR `[`|`]{.underline}` FOREACH `[`|`]{.underline}` MENU `[`|`]{.underline}` CONSTRUCT `[`|`]{.underline}` INPUT `[`|`]{.underline}` WHILE `[`}`]{.underline}

#### Notes:

1.  `CONTINUE `*`instruction`*` `can only be used within the statement
    block specified by *`instruction`*. For example, `CONTINUE FOR `can
    only be used within a `FOR ... END FOR `statement block.

2.  The `CONTINUE FOR`, `CONTINUE FOREACH`, or `CONTINUE WHILE` keywords
    cause the current `FOR`, `FOREACH`, or `WHILE` loop (respectively)
    to begin a new cycle immediately. If conditions do not permit a new
    cycle, however, the looping statement terminates.

3.  The `CONTINUE CONSTRUCT` and `CONTINUE INPUT` statements cause the
    program to skip all subsequent statements in the current control
    block. The screen cursor returns to the most recently occupied field
    in the current form, giving the user another chance to enter data in
    that field.

4.  The `CONTINUE MENU` statement causes the program to ignore the
    remaining statements in the current `MENU` control block and
    redisplay the menu. The user can then choose another menu option.

#### Tips:

1.  `CONTINUE INPUT` is valid in `INPUT` and `INPUT ARRAY` statements.

#### Example:

``` linenumber
01 MAIN
02   DEFINE i INTEGER
03   LET i = 0
04   WHILE i < 5
05     LET i = i + 1
06     DISPLAY "i=" || i
07     CONTINUE WHILE
08     DISPLAY "This will never be displayed !"
09   END WHILE
10 END MAIN
```

------------------------------------------------------------------------

### [FOR]{#FC_FOR}

#### Purpose:

The `FOR` instruction executes a statement block a specified number of
times.

#### Syntax:

`FOR `*`counter`*` = `*`start`*` TO `*`finish`*` `[`[`]{.underline}` STEP `*`value`*` `[`]`\]{.underline}
*`   `[`{`]{.underline}` statement `[`|`]{.underline}*` EXIT FOR `*[`|`]{.underline}*` CONTINUE FOR `[`}`]{.underline}\
`   `[`[...]`]{.underline}\
`END FOR`

#### Notes:

1.  *counter* is a [variable](Variables.html) of type
    [INTEGER](DataTypes.html#DT_INTEGER) or
    [SMALLINT](DataTypes.html#DT_SMALLINT) that serves as an index for
    the `FOR` statement block.

2.  *start* is an [integer expression](Expressions.html#EX_INTEGER) used
    to set an initial counter value.

3.  *finish* is any valid [integer
    expression](Expressions.html#EX_INTEGER) used to specify an upper
    limit for *counter*.

4.  *value* is any valid [integer
    expression](Expressions.html#EX_INTEGER) whose value is added to
    *counter* after each iteration of the statement block.

5.  When the `STEP` keyword is not given, *counter* is incremented by 1.

6.  *statement* is any instruction supported by the language.

7.  If *value* is less than 0, *counter* is decreased. In this case,
    *start* should be higher than *finish*.

#### Usage:

The `FOR` instruction block executes the statements up to the `END FOR`
keyword a specified number of times, or until `EXIT FOR` terminates the
`FOR` statement. You can use the `CONTINUE FOR` instruction to skip the
following statements and continue with the loop.

The runtime system maintains the counter, whose value changes on each
pass through the statement block. On the first iteration through the
loop, this counter is set to the initial expression at the left of the
`TO` keyword. For all further iterations, the value of the increment
expression in the `STEP` clause specification (1 by default) is added to
the counter in each pass through the block of statements. When the sign
of the difference between the values of counter and the finish
expression at the right of the `TO` keyword changes, the runtime system
exits from the `FOR` loop.

The `FOR` loop terminates after the iteration for which the left- and
right-hand expressions are equal. Execution resumes at the statement
following the `END FOR` keywords. If either expression returns `NULL`,
the loop cannot terminate, because the Boolean expression \"left =
right\" cannot become `TRUE`.

#### Tips:

1.  If the `FOR` loop includes one or more [SQL
    statements](StaticSql.html) that modify the database, then it is
    advisable that the entire `FOR` loop be within a transaction. You
    may also [PREPARE](DynamicSql.html) the SQL statements before the
    loop to increase performance.

#### Warnings:

1.  *counter* MUST be of type [INTEGER](DataTypes.html#DT_INTEGER) or
    [SMALLINT](DataTypes.html#DT_SMALLINT).
2.  *value* = 0 causes an unending loop unless there is an adequate
    `EXIT FOR `statement.
3.  `NULL `for *start*, *finish* or *value* is treated as 0. There is no
    way to catch this as an error.
4.  If *statement* modifies the value of *counter*, you might get
    unexpected results at runtime. In this case, it is recommended that
    you use a [`WHILE`](#FC_WHILE) loop instead.
5.  It is highly recommended that you ensure that *statement* does not
    modify the values of *start*, *finish* and/or *value*.\

#### Example:

``` linenumber
01 MAIN
02   DEFINE i, i_min, i_max INTEGER
03   LET i_min = 1
04   LET i_max = 10
05   DISPLAY "Look how well I can count from " || i_min || " to " || i_max
06   DISPLAY "I can count forwards..."
07   FOR i = i_min TO i_max
08       DISPLAY i
09   END FOR
10   DISPLAY "... and backwards!"
11   FOR i = i_max TO i_min STEP -1
12       DISPLAY i
13   END FOR
14 END MAIN
```

------------------------------------------------------------------------

### [GOTO]{#FC_GOTO}

#### Purpose:

The `GOTO` instruction transfers program control to a labeled line
within the same program block.

#### Syntax:

`GOTO `[`[`]{.underline}` : `[`]`]{.underline}` `*`label-id`*

#### Notes:

1.  *label-id* is the name of the [LABEL](#FC_LABEL) statement to jump
    to.
2.  The label can be defined before or after the `GOTO` statement.

#### Tips:

1.  `GOTO` statements can reduce the readability of your program source
    and result in infinite loops. It is recommended that you use
    [FOR](#FC_FOR), [WHILE](#FC_WHILE), [IF](#FC_IF), [CASE](#FC_CASE),
    [CALL](#FC_CALL) statements instead.
2.  The `GOTO `statement can be used in a
    [WHENEVER](Exceptions.html#DEFINITION) statement to handle
    [exceptions](Exceptions.html).

#### Warnings:

1.  The `LABEL` and `GOTO` statements must use the *label-id* within a
    single [MAIN](Programs.html), [FUNCTION](Functions.html), or
    [REPORT](Reports.html) program block.

#### Example:

``` linenumber
01 MAIN
02   DEFINE exit_code INTEGER
03   DEFINE l_status  INTEGER
04   WHENEVER ANY ERROR GOTO _error
05   DISPLAY 1/0
06   GOTO _noerror
07   LABEL _error:
08     LET l_status = STATUS
09     DISPLAY "The error number ", l_status, " has occurred."
10     DISPLAY "Description : ", err_get(l_status)
11     LET exit_code = -1
12   GOTO :_exit
13   LABEL _noerror:
14     LET exit_code = 0
15   GOTO _exit
16   LABEL _exit:
17   EXIT PROGRAM (exit_code)
18 END MAIN
```

------------------------------------------------------------------------

### [EXIT]{#FC_EXIT}

#### Purpose:

The `EXIT` instruction transfers control out of a control structure (a
block, a loop, a `CASE` statement, or an interface instruction).

#### Syntax:

`EXIT `[`{`]{.underline}` CASE `[`|`]{.underline}` FOR `[`|`]{.underline}` MENU `[`|`]{.underline}` CONSTRUCT `[`|`]{.underline}` FOREACH `[`|`]{.underline}` REPORT `[`|`]{.underline}` DISPLAY `[`|`]{.underline}` INPUT `[`|`]{.underline}` WHILE `[`}`]{.underline}

#### Notes:

1.  The `EXIT `*`instruction`* instruction must be used inside the
    control structure specified by *`instruction`*. For example,
    `EXIT FOR ` can only appear inside a `FOR ... END FOR `program
    structure.

2.  `EXIT DISPLAY` exits the `DISPLAY ARRAY` instruction and
    `EXIT INPUT` exits both `INPUT` and `INPUT ARRAY` blocks.

#### Tips:

1.  To exit a function, use the [`RETURN`](#FC_RETURN)` ` instruction.
2.  To exit a program, use the
    [`EXIT PROGRAM`](Programs.html#EXIT_PROGRAM) instruction.

#### Example:

``` linenumber
01 MAIN
02   DEFINE i INTEGER
03   LET i = 0
04   WHILE TRUE
05     DISPLAY "This is an infinite loop. How would you get out of here ?"
06     LET i = i + 1
07     IF i = 100 THEN
08       EXIT WHILE
09     END IF
10   END WHILE
11   DISPLAY "Well done."
12 END MAIN
```

------------------------------------------------------------------------

### [IF]{#FC_IF}

#### Purpose:

The `IF` instruction executes a group of statements conditionally.

#### Syntax:

`IF `*`condition`*` THEN`\
`   `*`statement`\*
`   `[`[...]`]{.underline}\
[`[`]{.underline}` ELSE`\
`   `*`statement`\*
`   `[`[...]`]{.underline}\
[`]`*\*]{.underline}
`END IF`

#### Notes:

1.  *condition* is any [[boolean
    expression]{.underline}](Expressions.html#EX_BOOLEAN) supported by
    the language.

2.  *statement* is any instruction supported by the language.

#### Usage:

If *condition* is `TRUE`, the runtime system executes the block of
statements following the `THEN` keyword, until it reaches either the
`ELSE` keyword or the `END IF` keywords and resumes execution after the
`END IF` keywords.

If *condition* is `FALSE`, the runtime system executes the block of
statements between the `ELSE` keyword and the `END IF` keywords. If
`ELSE` is absent, it resumes execution after the `END IF` keywords.

#### Tips:

1.  To test the equality of [[integer
    expressions]{.underline}](Expressions.html#EX_BOOLEAN), both \" = \"
    and \" == \" operators may be used. `IF 5 = 5 THEN ... `can be
    written `IF 5 == 5 THEN ...`

#### Warnings:

1.  A `NULL` expression is considered as `FALSE`. Use the `IS NULL`
    keyword to test if an [expression](Expressions.html) is null.

#### Example:

``` linenumber
01 MAIN
02   DEFINE name CHAR(20)
03   LET name = "John Smith"
04   IF name MATCHES "John*" THEN 
05      DISPLAY "The first name is too common to be displayed."
06      IF name MATCHES "*Smith" THEN
07         DISPLAY "Even the last name is too common to be displayed."
08      END IF
09   ELSE
10      DISPLAY "The name is " || name || "."
11   END IF
12 END MAIN
```

------------------------------------------------------------------------

### [LABEL]{#FC_LABEL}

#### Purpose:

The `LABEL` instruction declares a statement label, making the next
statement one to which a [GOTO](#FC_GOTO) statement can transfer program
control.

#### Syntax:

`LABEL `*`label-id`*`:`

#### Notes:

1.  *label-id* is a unique identifier in a [MAIN](Programs.html),
    [REPORT](Reports.html), or [FUNCTION](Functions.html) program block.

2.  The *label-id* must be followed by a colon (`:`).

#### Example:

``` linenumber
01 MAIN
02   DISPLAY "Line 2"
03   GOTO line5
04   DISPLAY "Line 4"
05   LABEL line5:
06   DISPLAY "Line 6"
07 END MAIN
```

------------------------------------------------------------------------

### [SLEEP]{#FC_SLEEP}

#### Purpose:

The `SLEEP` instruction causes the program to pause for the specified
number of seconds.

#### Syntax:

`SLEEP `*`seconds`*

#### Notes:

1.  *seconds* is a valid [integer
    expression](Expressions.html#EX_INTEGER).

#### Warnings:

1.  If *seconds* \< 0 or *second* `IS NULL`, the program does not stop.

#### Example:

``` linenumber
01 MAIN
02   DISPLAY "Please wait 5 seconds..."
03   SLEEP 5
04   DISPLAY "Thank you."
05 END MAIN
```

------------------------------------------------------------------------

### [WHILE]{#FC_WHILE}

#### Purpose:

The `WHILE` statement executes a block of statements while a condition
that you specify in a [boolean expression](Expressions.html#EX_BOOLEAN)
is true.

#### Syntax:

`WHILE `*`b-expression`*\
*`   `[`{`]{.underline}` statement `[`|`]{.underline}*` EXIT WHILE `*[`|`]{.underline}*` CONTINUE WHILE `[`}`]{.underline}\
`   `[`[...]`]{.underline}*\*
`END WHILE`

#### Notes:

1.  *b-expression* is any valid [boolean
    expression](Expressions.html#EX_BOOLEAN).

2.  *statement* is any instruction supported by the language.

#### Usage:

If *b-expression* is `TRUE`, the runtime system executes the statements
that follow it, down to the `END WHILE` keyword.  The runtime system
again evaluates the *b-expression*, and if it is still `TRUE`, the
runtime system executes the same statement block. The runtime system
usually stops when *b-expression* becomes `FALSE` or *statement* is
`EXIT WHILE`. You can use the `CONTINUE WHILE` instruction to skip the
following statements and continue with the loop.

If *b-expression* is `FALSE`, the runtime system passes control to the
statement that follows `END WHILE`.

#### Tips:

1.  If *b-expression* is complex, it is much better to define a boolean
    \[ [INTEGER](DataTypes.html#DT_INTEGER) or
    [CHAR(1)](DataTypes.html#DT_CHAR) \] [variable](Variables.html) that
    takes the result of *b-expression* and use this variable for
    *b-expression*.

2.  A `WHILE `loop can replace a  `FOR `loop :
    `FOR i = 1 TO 5 ; ... ; END FOR `is equivalent to
    `LET i = 1 ; WHILE i <= 5 ; ... ; LET i = i + 1 ; END WHILE`

3.  In order to avoid unending loops, make sure that either *statement*
    will cause *b-expression* to be `FALSE`,` `or that the
    `EXIT WHILE `statement will be executed.

#### Example:

``` linenumber
01 MAIN
02   DEFINE lval INTEGER
03   DEFINE lmin INTEGER
04   DEFINE lmax INTEGER
05   DEFINE lnb  INTEGER
06   DEFINE lcnt INTEGER
07   DEFINE lguess INTEGER
08   DISPLAY "NumberGuess program"
09   LET lnb  = 20
10   LET lmin = 0
11   LET lmax = 1000
12   LET lval = 753 --random value between lmin and lmax
13   DISPLAY "Guess a number between " || lmin || " and " || lmax
14   LET lguess = (lmax - lmin) / 2
15   LET lcnt = 1
16   WHILE lguess <> lval AND lcnt < lnb
17     DISPLAY "\n  Attempt number " || lcnt
18     DISPLAY "  Your guess is " || lguess || ", hopefully between " || lmin || " and " || lmax
19     IF lval > lguess THEN
20        DISPLAY "  Try higher."
21        LET lmin = lguess
22     ELSE
23        DISPLAY "  Try lower."
24        LET lmax = lguess
25     END IF
26     LET lguess = lmin + (lmax - lmin) / 2
27     LET lcnt = lcnt + 1
28   END WHILE
29   IF lcnt >= lnb THEN
30      DISPLAY "Sorry, the maximum number of attempts has been reached. The number was " || lval
31   ELSE
32      DISPLAY "Well done. You have found the number " || lval || " in " || lcnt || " attempts."
33   END IF
34 END MAIN
```

------------------------------------------------------------------------
