[Back to Contents](../index.html)

------------------------------------------------------------------------

# [Functions]{#PAGE_HEADER}

Summary:

- [Definition](#DEFINITION)
- [Usage](#USAGE)
- [BDL stack](#FGL_STACK)
- [Examples](#EXAMPLES)

*See also:* [Variables](Variables.html), [Data Types](DataTypes.html),
[Flow Control](FlowControl.html)

------------------------------------------------------------------------

### [Definition]{#DEFINITION}

#### Purpose:

The [`FUNCTION`]{#FUNCTION} statement defines a named program block
containing a set of statements to be executed when the function is
invoked.

#### [Syntax:]{#SYNTAX}

`[PUBLIC|PRIVATE] FUNCTION `*`function-name`*` ( `[`[`]{.underline}` `*`argument`*` `[`[`]{.underline}`,`[`...]`]{.underline}` `[`]`]{.underline}` )`\
`  `[`[`]{.underline}` `*`define-statement`*` `[`|`]{.underline}` `*`constant-statement`*` `[`]`]{.underline}\
`  `[`{`]{.underline}` `*`fgl-statement`*` `[`|`]{.underline}` `*`sql-statement`*` `[`|`]{.underline}` `*`return-statement`*` `[`}`]{.underline}` `[`[...]`]{.underline}\
`END FUNCTION`

where *return-statement* is:

`RETURN `*`expression`*` `[`[`]{.underline}`,`[`...]`]{.underline}

#### Notes:

1.  *function-name* is the identifier that you declare for this function
    and must be unique among all the names of functions or reports in
    the same program.
2.  *argument* is the name of a formal argument to this function. Its
    scope of reference is local to the function.
3.  *define-statement* is used to define function arguments and local
    [variables](Variables.html).
4.  *constant-statement* can be used to declare local
    [constants](Constants.html).
5.  *fgl-statement* is any instruction supported by the language.
6.  *sql-statement* is any [static SQL](StaticSql.html) instruction
    supported by the language.
7.  *expression* is any [expression](Expressions.html) supported by the
    language.

------------------------------------------------------------------------

### [Usage]{#USAGE}

The ` FUNCTION` block both declares and defines a function. The function
declaration specifies the identifier of the function and the identifiers
of its formal arguments (if any). A ` FUNCTION` block cannot appear
within the [MAIN](Programs.html#MAIN_BLOCK) block, in a
[REPORT](Reports.html) block, or within another ` FUNCTION` block.

By default, functions are public; They can be called by any other module
of the program. If a function is only used by the current module, you
may want to hide that function to other modules, to make sure that it
will not be called by mistake. To keep a function local to the module,
add the `PRIVATE` keyword before the function header. Private functions
are only hidden to external modules, all function of the current module
can still call local private functions.

The [data type](DataTypes.html) of each formal argument of the function
must be specified by a [DEFINE](Variables.html) statement that
immediately follows the argument list. The actual argument in a call to
the function need not be of the declared [data type](DataTypes.html) of
the formal argument. If [data type conversion](DataConversions.html) is
not possible, a runtime error occurs.

Function arguments are passed by value (i.e. value is copied on the
stack) for basic data types and records, while [dynamic
arrays](Arrays.html) and [objects](BuiltInClasses.html) are passed by
reference (i.e. a handle to the original data is copied on the stack and
thus allows modification of the original data inside the function). See
also [BDL Stack](#FGL_STACK) section.

Local [variables](Variables.html) are not visible in other program
blocks. The identifiers of local [variables](Variables.html) must be
unique among the variables that are declared in the same ` FUNCTION`
definition. Any global or module [variable](Variables.html) that has the
same identifier as a local variable, however, is not visible within the
scope of the local variable.

A function that returns one or more values to the calling routine must
include the *return-statement*. Values specified in `RETURN` must
correspond in number and position, and must be of the same or of
[compatible data types](DataConversions.html), to the variables in the
`RETURNING` clause of the [CALL](FlowControl.html#FC_CALL) statement. If
the function returns a single value, it can be invoked as an operand
within a [expression](Expressions.html). Otherwise, you must invoke it
with the [CALL](FlowControl.html#FC_CALL) statement with a `RETURNING`
clause. An error results if the list of returned values in the `RETURN`
statement conflicts in number or in data type with the `RETURNING`
clause of the [CALL](FlowControl.html#FC_CALL) statement that invokes
the function. See also [BDL Stack](#FGL_STACK) section.

Any [GOTO](FlowControl.html#FC_GOTO) or [WHENEVER ERROR
GOTO](Exceptions.html) statement in a function must reference a
statement label within the same `FUNCTION` block.

A function can invoke itself recursively with a
[CALL](FlowControl.html#FC_CALL) statement.

#### Warnings:

1.  If no argument is specified, an empty argument list must still be
    supplied, enclosed between the parentheses.
2.  If the name is also the name of a built-in function, an error occurs
    at link time, even if the program does not reference the built-in
    function.

------------------------------------------------------------------------

### [BDL Stack]{#FGL_STACK}

When passing arguments to a function or when returning values from a
function, you are using the Genero BDL stack. When you call a function,
parameters are pushed on the stack; before the function code executes,
parameters are popped from the stack in the local variables defined in
the function. When a function returns values, data is pushed on the
stack and popped into variables specified in the `RETURNING` clause of
the caller.

Elements are pushed on the stack in a given order, then popped from the
stack in the reverse order. This is transparent to the BDL programmer.
However, if you want to implement a [C Extension](CExtensions.html), you
must keep this in mind.

According to the data type, parameters are passed [by value]{.underline}
or [by reference]{.underline}.

#### Parameter types passed by value

The following data types are passed [by value]{.underline} to a
function:

- [INT](DataTypes.html#DT_INTEGER),
  [SMALLINT](DataTypes.html#DT_SMALLINT),
  [FLOAT](DataTypes.html#DT_FLOAT),
  [SMALLFLOAT](DataTypes.html#DT_SMALLFLOAT),
  [DECIMAL](DataTypes.html#DT_DECIMAL), [MONEY](DataTypes.html#DT_MONEY)

- [CHAR](DataTypes.html#DT_CHAR), [VARCHAR](DataTypes.html#DT_VARCHAR),
  [STRING](DataTypes.html#DT_STRING)

- [DATE](DataTypes.html#DT_DATE),
  [DATETIME](DataTypes.html#DT_DATETIME),
  [INTERVAL](DataTypes.html#DT_INTERVAL)

- [RECORD](Records.html) (see note below)

- [Static ARRAYs](Arrays.html) (see note below)

When passing by value, the runtime system pushes a copy of the parameter
data on the stack. As a result, inside the function, the local variable
value receiving the parameter value can be changed without affecting the
data used by the caller.

You can pass a [RECORD](Records.html) structure as a function parameter
with the dot star (`.*`) notation. In this case, the record is expanded
and each member of the structure is pushed on the stack. The receiving
local variables in the function can then be defined individually or with
the same record structure as the caller. The next example illustrates
this:

``` linenumber
01 MAIN
02   DEFINE rec RECORD
03      a INT, b VARCHAR(50)
04   END RECORD
05   CALL func_r(rec.*)
06   CALL func_ab(rec.*)
07 END MAIN
08 -- function defining a record like that in the caller
09 FUNCTION func_r(r)
10   DEFINE r RECORD
11      a INT, b VARCHAR(50)
12   END RECORD
13   ...
14 END FUNCTION
15 -- function defining two individual variables
16 FUNCTION func_ab(a, b)
17   DEFINE a INT, b VARCHAR(50)
18   ...
19 END FUNCTION
```

It is possible to pass a complete [static ARRAY](Arrays.html) as a
function parameter, but this is not recommended.  in this case, the
complete array is copied on the stack and every element is passed by
value. The receiving local variables in the function must be defined
with the same static array definition as the caller:

``` linenumber
01 MAIN
02   DEFINE arr ARRAY[5] OF INT
03   CALL func(arr)
04 END MAIN
05 -- function defining same static array as the caller 
06 FUNCTION func(x)
07   DEFINE x ARRAY[5] OF INT
08   ...
09 END FUNCTION
```

Therefore, it is better to use dynamic arrays instead.

#### Parameter types passed by reference

The following data types are passed [by reference]{.underline} to a
function:

- [Dynamic ARRAYs](Arrays.html)
- [Built-in Class Objects](BuiltInClasses.html)
- [Java Class Object](JavaBridge.html)
- [BYTE](DataTypes.html#DT_BYTE) or [TEXT](DataTypes.html#DT_TEXT)

Passing a [dynamic ARRAY](Arrays.html) as a function parameter or as
returning element is legal and efficient. When passed as parameter, the
runtime system pushes [a reference]{.underline} of the dynamic array on
the stack, and the receiving local variables in the function can then
manipulate the original data. You can also return a dynamic array from a
function: The runtime system pushes also a reference of the dynamic
array. The next example illustrates this:

``` linenumber
01 MAIN
02   DEFINE arr DYNAMIC ARRAY OF INT
03   DISPLAY arr.getLength()
04   LET arr = init(10)
03   DISPLAY arr.getLength()
04   CALL modify(arr)
05   DISPLAY arr[50]
06   DISPLAY arr[51]
07   DISPLAY arr.getLength()
08 END MAIN
09 --
10 FUNCTION init(c)
11   DEFINE c INT
12   DEFINE x DYNAMIC ARRAY OF INT
13   FOR i=1 TO c
14      LET x[i] = i
15   END FOR
16   RETURN x
17 END FUNCTION
18 --
19 FUNCTION modify(x)
20   DEFINE x DYNAMIC ARRAY OF INT
21   LET x[50] = 222
22   LET x[51] = 333
23 END FUNCTION
```

Output of the program:

     0\
    10\
  222\
  333\
   51

Like other OOP languages, Genero passes objects of [built-in
classes](BuiltInClasses.html) or [java classes](JavaBridge.html) by
reference. It would not make much sense to pass an object by value,
actually. The runtime pushes the reference of the object on the stack
(i.e. the object handler is passed by value), and the reference is then
popped to the receiving object variable in the function. The function
can then be used to manipulate the original object.

``` linenumber
01 MAIN
02   DEFINE ch base.Channel
03   LET ch= base.Channel.create()
04   CALL open(ch)
05   CALL ch.close()
06 END MAIN
07 -- function using the channel object reference
08 FUNCTION open(x)
09   DEFINE x base.Channel
10   CALL x.openFile("filename","r")
11 END FUNCTION
```

[BYTE](DataTypes.html#DT_BYTE) or [TEXT](DataTypes.html#DT_TEXT) data
types are actually large data object handlers internally implemented as
\"LOB locators\". When you pass a BYTE or TEXT to a function, the LOB
locator is pushed on the stack and popped to the receiving BYTE or TEXT
variable in the function. The actual LOB data is not copied, only the
LOB handler is passed by value. However, the data of the LOB locator is
copied - information like [LOCATE](Variables.html#VA_LOCATE) filename is
copied. If you modify the locator inside the function, the locator in
the caller will become invalid.

**Warning: You should not [re-locate](Variables.html#VA_LOCATE) a BYTE
or TEXT locator in a function. Since the LOB locator information is
copied by value, modifying the LOB handler inside a function makes the
LOB handler of the caller invalid.**

#### Returning values from functions

When you return values from a function with the `RETURN` clause, the
values are pushed on the stack and popped to the variables specified in
the `RETURNING` clause.

Simple data types that are passed by value are returned by value
following the same principle. Complex data types are not returned by
value, only the reference is pushed on the stack. You can, for example,
create an object or a dynamic array in a function and return it to the
caller for usage.

#### Implicit data type conversion on the stack

When a value or a reference is popped from the stack, implicit data
conversion takes place. This means, for example, that you can pass a
string value to a function that defines the receiving variable as a
numeric data type; no compilation error will occur, but you can get a
runtime error if the string cannot be converted to a numeric. The same
principle applies to values returned from functions, since the stack is
also used in this case.

For more details about possible data conversions, see the [Data Type
Conversion Table](DataConversions.html).

------------------------------------------------------------------------

### [Examples]{#EXAMPLES}

#### Example 1: Function fetching customer data from the database.

``` linenumber
01 FUNCTION findCustomerNumber(name)
02   DEFINE name VARCHAR(50)
03   DEFINE num INTEGER
04   CONSTANT sqltxt = "SELECT cust_num FROM customer WHERE cust_name = ?"
05   PREPARE stmt FROM sqltxt
06   EXECUTE stmt INTO num USING name
07   IF SQLCA.SQLCODE = 100 THEN
08      LET num =-1
09   END IF
10   RETURN num
11 END FUNCTION
```

#### Example 2: A private function.

``` linenumber
01 PRIVATE FUNCTION checkIdentifier(name)
02   DEFINE name VARCHAR(50)
03   IF name IS NULL THEN RETURN FALSE END IF
04   IF name MATCHES "[0123456789]*" THEN RETURN FALSE END IF
05   RETURN TRUE
06 END FUNCTION
```
