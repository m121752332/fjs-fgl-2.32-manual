[Back to Contents](../index.html)

------------------------------------------------------------------------

# [Variables]{#PAGE_HEADER}

Summary:

- [Definition](#DEFINITION)
- [Defining Variables](#VA_DEFINE) (`DEFINE`)
- [Declaration Context](#CONTEXT)
- [Structured Types](#STRUCTURED)
- [Database Types](#DATABASE_TYPES)
- [User Types](#USER_TYPES)
- [Default Values](#DEFAULT_VALUES)
- [Variable Initialization](#VA_INITIALIZE) (`INITIALIZE`)
- [LOB Data Localization](#VA_LOCATE) (`LOCATE`)
- [LOB Data Release](#VA_FREE) (`FREE`)
- [Assigning Values](#VA_LET) (`LET`)
- [Data Validation](#VA_VALIDATE) (`VALIDATE`)
- [Specifying a range of record members](#VA_THRU) (`THRU`)
- [Examples](#EXAMPLES)

*See also:* [Records](Records.html), [Arrays](Arrays.html), [Data
Types](DataTypes.html), [Constants](Constants.html), [User
Types](UserTypes.html).

------------------------------------------------------------------------

### [Definition]{#DEFINITION}

A *variable* is a program element that can hold volatile data. The
following list summarizes variables usage:

- You must [DEFINE](#VA_DEFINE) variables before use.
- After definition, variables have [default values](#DEFAULT_VALUES)
  according to the [data type](DataTypes.html).
- The scope of a variable can be [global](Globals.html), local to a
  module, or local to a [function](Functions.html).
- You can define structured variables with [records](Records.html) and
  [arrays](Arrays.html).
- Variables can be initialized with the [INITIALIZE](#VA_INITIALIZE)
  instruction.
- Variables can be assigned with the [LET](#VA_LET) instruction.
- Variables can be validated with the [VALIDATE](#VA_VALIDATE)
  instruction.
- Variables can be used as parameters or fetch buffers in
  [Static](StaticSql.html) or [Dynamic](DynamicSql.html) SQL statements.
- Variables can be used as input or display buffers in interactive
  instructions such as [INPUT](RecordInput.html), [INPUT
  ARRAY](InputArray.html), [DISPLAY ARRAY](DisplayArray.html),
  [CONSTRUCT](Construct.html).

------------------------------------------------------------------------

### [DEFINE]{#VA_DEFINE}

#### Purpose:

A **variable** contains volatile information of a specific [data
type](DataTypes.html).

#### Syntax:

[`[`]{.underline}`PUBLIC`[`|`]{.underline}`PRIVATE`[`]`]{.underline}` DEFINE `*`variable-definition`*` `[`[,...]`]{.underline}` `

where *variable-definition* is:

` `*`identifier`*` `[`[,...]`]{.underline}` `[`{`]{.underline}` `*`datatype`*` `[`|`]{.underline}` LIKE `[`[`]{.underline}*`dbname`*`:`[`]`]{.underline}*`tabname.colname`*` `[`}`]{.underline}

#### Notes:

1.  *identifier* is the name of the variable to be defined. See
    [Identifiers](LanguageFeatures.html#LF_IDENTS) for naming rules.
2.  *datatype* can be:
    - a primitive [data type](DataTypes.html),
    - a [record definition](Records.html),
    - an [array definition](Arrays.html),
    - a [user defined type](UserTypes.html),
    - a [built-in class](BuiltInClasses.html),
    - or a [Java class](JavaBridge.html).
3.  When using the ` LIKE` clause, the data type is taken from the
    [schema](DatabaseSchema.html) file. Columns defined as ` SERIAL` are
    converted to [INTEGER](DataTypes.html#DT_INTEGER).
4.  *dbname* identifies a specific [database schema
    file](DatabaseSchema.html).
5.  *tabname.colname* can be any column reference defined in the
    [database schema file](DatabaseSchema.html).

#### Usage:

A *variable* is a named location in memory that can store a single
value, or an ordered set of values. Variables can be global to the
[program](Programs.html), module-specific, or local to a
[function](Functions.html).

You cannot reference any program variable before it has been declared by
the `DEFINE` statement.

By default, module-specific variables are private; They cannot be used
by an other module of the program. In order to improve code reusability
by data encapsulation, we recommend you to keep module variables
private, except if you want to share large data (like arrays) between
modules. To make a module variable public, add the `PUBLIC` keyword
before `DEFINE`. When a module variable is declared as public, it can be
referenced by another module by using the [IMPORT](Programs.html#IMPORT)
instruction.

#### Tips:

1.  To write well-structured programs, it is recommended that you not
    use global variables. If you need persistent data storage during a
    program\'s execution, use variables local to the module and give
    access to them with [functions](Functions.html).

**Warning: When defining variables with the [`LIKE`](#DATABASE_TYPES)
[clause](#DATABASE_TYPES), the data types are taken from the
[schema](DatabaseSchema.html) file [during compilation]{.underline}.
Make sure that the schema file of the [development
database](FglTerms.html#DEVELOPMENT_DATABASE) corresponds to the
[production database](FglTerms.html#PRODUCTION_DATABASE); otherwise the
variables defined in the compiled version of your modules will not match
the table structures of the production database.**

------------------------------------------------------------------------

### [Declaration Context]{#CONTEXT}

The `DEFINE` statement declares the identifier of one or more
*variables*. There are two important things to know about these
identifiers:

- Where in the program can they be used? The answer defines the scope of
  reference of the variable. A point in the program where an identifier
  can be used is said to be *in* the scope of the identifier. A point
  where the identifier is not known is *outside* the scope of the
  identifier.
- When is storage for the variable allocated? Storage can be allocated
  either statically, when the program is loaded to run (at load time),
  or dynamically, while the program is executing (at runtime).

The context of its declaration in the source module determines where a
variable can be referenced by other language statements, and when
storage is allocated for the variable in memory. The DEFINE statement
can appear in three contexts:

1.  Within a `FUNCTION`, `MAIN`, or `REPORT` program block, `DEFINE`
    declares *local* variables, and causes memory to be allocated for
    them. These DEFINE declarations of local variables must precede any
    executable statements within the same program block.
    - The scope of reference of a local variable is restricted to the
      same program block. The variable is not visible elsewhere.
    - Storage for local variables is allocated when its `FUNCTION`,
      `REPORT`, or `MAIN` block is entered during execution. Functions
      can be called recursively, and each recursive entry creates its
      own set of local variables. The variable is unique to that
      invocation of its program block. Each time the block is entered, a
      new copy of the variable is created.
    - See [Functions](Functions.html) for a discussion of local
      variables and the [BDL stack](Functions.html#FGL_STACK).
2.  Outside any `FUNCTION`, `REPORT`, or `MAIN` program block, the
    ` DEFINE` statement declares names and data types of *module*
    variables, and causes storage to be allocated for them. These
    declarations must appear before any program blocks.
    - Scope of reference is from the `DEFINE` statement to the end of
      the same module. The variable, however, is not visible within this
      scope in program blocks where a local variable has the same
      identifier.
    - Memory for variables of modules is allocated statically, when the
      program starts.
3.  Inside a `GLOBALS` block, the `DEFINE` statement declares *global*
    variables.
    - Scope of reference is global to the whole program.
    - The memory for global variables is allocated statically, when the
      program starts.
    - Multiple `GLOBALS` blocks can be defined for a given module. Use
      one module to declare all global variables and reference that
      module within other modules by using the
      `GLOBALS "`*`filename`*`.4gl"` statement as the first statement in
      the module, outside any program block. 

A compile-time error occurs if you declare the same name for two
variables that have the same scope. You can, however, declare the same
name for variables that differ in their scope. For example, you can use
the same identifier to reference different local variables in different
program blocks.

You can also declare the same name for two or more variables whose
scopes of reference are different but overlapping. Within their
intersection, the compiler interprets the identifier as referencing the
variable whose scope is smaller, and therefore the variable whose scope
is a superset of the other is not visible.

If a local variable has the same identifier as a global variable, then
the local variable takes precedence inside the program block in which it
is declared. Elsewhere in the program, the identifier references the
global variable.

A module variable can have the same name as a global variable that is
declared in a different module. Within the module where the module
variable is declared, the  module variable takes precedence over the
global variable. Statements in that module cannot reference the global
variable.

A module variable cannot have the same name as a global variable that is
declared in the same module.

If a local variable has the same identifier as a module variable, then
the local identifier takes precedence inside the program block in which
it is declared. Elsewhere in the same source-code module, the name
references the module variable.

------------------------------------------------------------------------

### [Structured Types]{#STRUCTURED}

You can use the `RECORD` or `ARRAY` keywords to declare a structured
variable.

For example:

``` linenumber
01 MAIN
02   DEFINE myarr ARRAY[100] OF RECORD
03      id INTEGER,
04      name VARCHAR(100)
05   END RECORD
06   LET myarr[2].id = 52
07 END MAIN
```

For more detail, refer to [Arrays](Arrays.html) and
[Records](Records.html).

------------------------------------------------------------------------

### [Database Types]{#DATABASE_TYPES}

You can use the `LIKE` keyword to declare a variable that has the same
data type as a specified column in a [database
schema](DatabaseSchema.html).

For example:

``` linenumber
01 SCHEMA stores
02 DEFINE cname LIKE customer.cust_name
03 MAIN
05   DEFINE cr RECORD LIKE customer.*
06 END MAIN
```

The following rules apply when using the `LIKE` keyword:

- A `SCHEMA` statement must define the database name identifying the
  [database schema files](DatabaseSchema.html) to be used.
- The column data types are read from the schema file **during
  compilation**, not at runtime. Make sure that your schema files
  correspond exactly to the production database.
- The [database schema files](DatabaseSchema.html) must exist and must
  be available as specified in the
  [FGLDBPATH](EnvironmentVariables.html#EV_FGLDBPATH) variable.
- The column data type defined by the database schema must be supported
  by the language. For more detail about supported types, refer to [Data
  Types](DataTypes.html).
- When using database views, the column cannot be based on an aggregate
  function like `SUM()`.
- If `LIKE` references a `SERIAL` column, the variable will be defined
  with the [INTEGER](DataTypes.html#DT_INTEGER) data type.
- If `LIKE` references an `INT8` or `SERIAL8` column, the variable will
  be defined with the [BIGINT](DataTypes.html#DT_BIGINT) data type.
- The table qualifier must specify *owner* if *table.column* is not a
  unique column identifier within its database, or if the database is
  ANSI-compliant and any user of your application is not the owner of
  *tabl*e.

To understand how to generate database schema files with the schema
extractor tool, refer to [Database Schema Files](DatabaseSchema.html)

------------------------------------------------------------------------

### [User Types]{#USER_TYPES}

Variables can be defined with a [user type](UserTypes.html):

``` linenumber
01 TYPE custlist DYNAMIC ARRAY OF RECORD LIKE customer.*
02 MAIN
03   DEFINE cl custlist
04 END MAIN
```

The scope of a user type can be global, local to a module or local to a
function. Variables can be defined with a user type defined in the same
scope, or in a higher level of scope.

------------------------------------------------------------------------

### [Default Values]{#DEFAULT_VALUES}

After a variable is [defined](#VA_DEFINE), it is automatically
initialized by the runtime system to a default value based on the [data
type](DataTypes.html). The following table shows all possible default
values that variables can take:

  --------------- ---------------------------------------
  **Data Type**   **Default Value**
  `CHAR`          NULL
  `VARCHAR`       NULL
  `STRING`        NULL
  `INTEGER`       Zero
  `SMALLINT`      Zero
  `FLOAT`         Zero
  `SMALLFLOAT`    Zero
  `DECIMAL`       NULL
  `MONEY`         NULL
  `DATE`          1899-12-31 (= Zero in number of days)
  `DATETIME`      NULL
  `INTERVAL`      NULL
  `TEXT`          NULL, See [LOCATE](#VA_LOCATE)
  `BYTE`          NULL, See [LOCATE](#VA_LOCATE)
  --------------- ---------------------------------------

------------------------------------------------------------------------

### [INITIALIZE]{#VA_INITIALIZE}

#### Purpose:

The `INITIALIZE` instruction assigns [NULL](Programs.html#PC_NULL) or
default values to variables.

#### Syntax:

`INITIALIZE `*`target`*` `[`[,...]`]{.underline}` `[`{`]{.underline}` TO NULL `[`|`]{.underline}` LIKE `[`{`]{.underline}*`table`*`.*`[`|`]{.underline}*`table.column`*[`}`]{.underline}` `[`}`]{.underline}

#### Notes:

1.  *target* is the name of the variable to be initialized.
2.  *target* can be a simple variable, a [record](Records.html), a
    record member, a [range of record members](#VA_THRU), an
    [array](Arrays.html) or an array element.
3.  If *target* is a [record](Records.html), you must use the star
    notation to reference all record members in the initialization.
4.  *table.column* can be any column reference defined in the database
    schema files.

#### Usage:

The `TO NULL` clause initializes the variable to
[NULL](Programs.html#PC_NULL).

When initializing a static array `TO NULL`, all elements will be
initialized to NULL. When initializing a dynamic array `TO NULL`, all
elements will be removed (i.e. the dynamic array is cleared).

The `LIKE` clause initializes the variable to the default value defined
in the [database schema validation file](DatabaseSchema.html#VAL_FILE).
This clause works only by specifying the *table.column* schema entry
corresponding to the variable.

To initialize a complete [record](Records.html), you can use the star to
reference all members:

``` linenumber
01 INITIALIZE record.* LIKE table.*
```

#### Warnings:

1.  You cannot initialize variables defined with a complex data type
    (like [TEXT](DataTypes.html#DT_TEXT) or
    [BYTE](DataTypes.html#DT_BYTE)) to a non-NULL value.

#### Example:

``` linenumber
01 DATABASE stores
02 MAIN
03   DEFINE cr RECORD LIKE customer.*
04   DEFINE a1 ARRAY[100] OF INTEGER
05   INITIALIZE cr.cust_name TO NULL
06   INITIALIZE cr.cust_name THRU cr.cust_address TO NULL
07   INITIALIZE cr.* LIKE customer.*
08   INITIALIZE a1 TO NULL
09   INITIALIZE a1[10] TO NULL
10 END MAIN
```

------------------------------------------------------------------------

### [VALIDATE]{#VA_VALIDATE}

#### Purpose:

The `VALIDATE` statement tests whether the value of a variable is within
the range of values for a corresponding column in [database schema
files](DatabaseSchema.html).

#### Syntax:

`VALIDATE `*`target`*` `[`[,...]`]{.underline}` LIKE `` `[`{`]{.underline}*`table`*`.*`[`|`]{.underline}*`table`*`.`*`column`*[`}`]{.underline}

#### Notes:

1.  *target* is the name of the variable to be validated.
2.  *target* can be a simple variable, a [record](Records.html),, a
    [range of record members](#VA_THRU) or an [array
    element](Arrays.html).
3.  If target is a [record](Records.html), you can use the star to
    reference all record members in the validation.
4.  Values are compared to the value defined in the [database schema
    validation file](DatabaseSchema.html#VAL_FILE).
5.  *table.column* can be any column reference defined in the [database
    schema file](DatabaseSchema.html).

#### Errors:

1.  If the value does not match any value defined in the INCLUDE
    attribute of the corresponding column, the runtime system raises an
    [exception](Exceptions.html) with error code **-1321**.

#### Warnings:

1.  The `LIKE` clause requires the IBM Informix **upscol** utility to
    populate the **syscolval** table. See  the [database schema
    files](DatabaseSchema.html) for more details. **Informix only!**
2.  You cannot initialize variables defined with a complex data type
    (like [TEXT](DataTypes.html#DT_TEXT) or
    [BYTE](DataTypes.html#DT_BYTE)) to a non-NULL value.

#### Example:

``` linenumber
01 DATABASE stores
02 MAIN
03   DEFINE cname LIKE customer.cust_name
04   LET cname = "aaa"
05   VALIDATE cname LIKE customer.cust_name
06 END MAIN
```

------------------------------------------------------------------------

### [THRU]{#VA_THRU}

#### Purpose:

The `THRU` keyword can be used to specify a range of members of a
[record](Records.html).

#### Syntax:

*`record.first-member`*` `[`[`]{.underline}` THRU `[`|`]{.underline}` THROUGH `[`]`]{.underline}` `*`record.last-member`*

#### Notes:

1.  *record* defines the record to be used.
2.  *first-member* defines the member of the record starting the group
    of variables.
3.  *last-member* defines the member of the record ending the group of
    variables.
4.  `THROUGH` is a synonym for `THRU`.

#### Usage:

The `THRU` keyword can be used in several instructions such as
[INITIALIZE](#VA_INITIALIZE), [VALIDATE](#VA_VALIDATE),
[LOCATE](#VA_LOCATE).

#### Example:

``` linenumber
01 DATABASE stores
02 MAIN
03   DEFINE cust LIKE customer.*
04   INITIALIZE cust.cust_name THRU customer.cust_address TO NULL
05 END MAIN
```

------------------------------------------------------------------------

### [LET]{#VA_LET}

#### Purpose:

The `LET` statement assigns a value to a variable, or a set of values to
a [record](Records.html).

#### Syntax:

`LET `*`target`*` = `*`expression`*` `[`[`]{.underline}`,...`[`]`]{.underline}

#### Notes:

1.  *target* is the name of the variable to be assigned.
2.  *target* can be a simple variable, a [record](Records.html), or an
    [array element](Arrays.html).
3.  *expression* is any valid [expression](Expressions.html) supported
    by the language.

#### Usage:

The `LET` statement assigns a value to a variable. Values of
*expression* are formatted for display. For example, numeric data if
right-aligned.

When specifying a comma-separated list of expressions for the right
operand, the `LET` statement concatenates all expressions together.
Unlike the `||` operator, if an expression in the comma-separated list
evaluates to [NULL](Programs.html#PC_NULL), the concatenation result
will not be null, except if all expressions to the right of the equal
sign are null.

The runtime system applies [data type conversion
rules](DataConversions.html) if the data type of *expression* does not
correspond to the data type of *target*.

You can use most of the [built-in functions](BuiltInFunctions.html) and
character [string operators](Operators.html#STRING_OPERATORS) like
`CLIPPED` or `USING` within the `LET` statement.

*target* can be [record](Records.html) followed by dot + star
(`record.*`) to reference all record members of the record. In this
case, the right operand must also be a record using this notation (see
example below).

#### Warnings:

1.  Variables defined with a complex data type (like
    [TEXT](DataTypes.html#DT_TEXT) or [BYTE](DataTypes.html#DT_BYTE))
    can only be assigned to [NULL](Programs.html#PC_NULL).
2.  For more details, refer to the [assignment
    operator](Operators.html#OP_ASSIGN).

#### Example:

``` linenumber
01 DATABASE stores
02 MAIN
03   DEFINE c1, c2 RECORD LIKE customer.*
04   LET c1.* = c2.*
05 END MAIN
```

------------------------------------------------------------------------

### [LOCATE]{#VA_LOCATE}

#### Purpose:

The `LOCATE` statement specifies where to store data of
[TEXT](DataTypes.html#DT_TEXT) and [BYTE](DataTypes.html#DT_BYTE)
variables.

#### Syntax 1: Locate in memory

`LOCATE `*`target`*` `[`[,...]`]{.underline}` IN MEMORY`

#### Syntax 2: Locate in a specific file

`LOCATE `*`target`*` `[`[,...]`]{.underline}` IN FILE `*`filename`*` `

#### Syntax 3: Locate in a temporary file

`LOCATE `*`target`*` `[`[,...]`]{.underline}` IN FILE`

#### Notes:

1.  *target* is the name of a [TEXT](DataTypes.html#DT_TEXT) or
    [BYTE](DataTypes.html#DT_BYTE) variable to be located. It can be a
    simple variable, a [record member](Records.html), a [range of record
    members](#VA_THRU), or an [array element](Arrays.html).
2.  *filename* is a [string expression](Expressions.html#EX_STRING)
    defining the name of a file.

#### Usage:

Defining the location of large object data is mandatory before usage.
After defining the data storage, the variable can be used as input
parameter or as a fetch buffer in SQL statements, as well as in
interaction statements and reports.

**Warning: You cannot use a large object variable if the data storage
location is not defined.**

The first syntax using the `IN MEMORY` clause specifies that the large
object data must be located in memory. The second syntax using the
`IN FILE `*`filename`* clause specifies that the large object data must
be located in a specific file. The third syntax using the `IN FILE`
clause specifies that the large object data must be located in a
temporary file.

When using a temporary file, the location of the temporary file can be
defined with the [DBTEMP](EnvironmentVariables.html#EV_DBTEMP)
environment variable. By default, the runtime system will use /tmp on
UNIX and %TMP% or %TEMP% on Windows. The temporary files are
automatically dropped by the runtime system when the program terminates.

You can free the resources allocated to the large object variable with
the [FREE](#VA_FREE) instruction.

#### Example:

``` linenumber
01 MAIN
02   DEFINE ctext1, ctext2 TEXT
03   DATABASE stock
04   LOCATE ctext1 IN MEMORY
05   LOCATE ctext2 IN FILE "/tmp/data1.txt"
06   CREATE TABLE lobtab ( key INTEGER, col1 TEXT, col2 TEXT )
06   INSERT INTO lobtab VALUES ( 123, ctext1, ctext2 )
07 END MAIN
```

------------------------------------------------------------------------

### [FREE]{#VA_FREE}

#### Purpose:

The `FREE` statement releases resources allocated to store the data of
[TEXT](DataTypes.html#DT_TEXT) and [BYTE](DataTypes.html#DT_BYTE)
variables.

#### Syntax:

`FREE `*`target`*` `

#### Notes:

1.  *target* is the name of a [TEXT](DataTypes.html#DT_TEXT) or
    [BYTE](DataTypes.html#DT_BYTE) variable to be freed.
2.  *target* can be a simple variable, a [record member](Records.html),
    or an [array element](Arrays.html).
3.  If the variable was [located](#VA_LOCATE) in memory, the runtime
    system releases the memory.
4.  If the variable was [located](#VA_LOCATE) in a file, the runtime
    system deletes the named file.
5.  For variables declared in a local scope of reference, the resources
    are automatically freed by the runtime system when returning from
    the [function](Functions.html) or [MAIN](Programs.html) block.

#### Warnings:

1.  After freeing a large object, you must [LOCATE](#VA_LOCATE) the
    variable again before usage.

#### Example:

``` linenumber
01 MAIN
02   DEFINE ctext TEXT
03   DATABASE stock
03   LOCATE ctext IN FILE "/tmp/data1.txt"
04   SELECT col1 INTO ctext FROM lobtab WHERE key=123
05   FREE ctext
06 END MAIN
```

------------------------------------------------------------------------

### [Examples]{#EXAMPLES}

#### Example 1: Function variables

``` linenumber
01 FUNCTION myfunc( )
02   DEFINE i INTEGER
03   FOR i=1 TO 10
04       DISPLAY i
05   END FOR
06 END FUNCTION
```

#### Example 2: Module variables

``` linenumber
01 DEFINE s VARCHAR(100)
02 
03 FUNCTION myfunc( )
04   DEFINE i INTEGER
05   FOR i=1 TO 10
06       LET s = "item #" || i
07   END FOR
08 END FUNCTION
```

#### Example 3: Global variables

File \"myglobs.4gl\":

``` linenumber
01 GLOBALS
02   DEFINE userid CHAR(20)
03   DEFINE extime DATETIME YEAR TO SECOND
04 END GLOBALS
```

File \"mylib.4gl\":

``` linenumber
01 GLOBALS "myglobs.4gl"
02 
03 DEFINE s VARCHAR(100)
04 
05 FUNCTION myfunc( )
06   DEFINE i INTEGER
07   DISPLAY "User Id = " || userid
08   FOR i=1 TO10
09       LET s = "item #" || i
10   END FOR
11 END FUNCTION
```

File \"mymain.4gl\":

``` linenumber
01 GLOBALS "myglobs.4gl"
02 
03 MAIN
04   LET userid = fgl_getenv("LOGNAME")
05   LET extime = CURRENT YEAR TO SECOND
06   CALL myfunc()
07 END MAIN
```
