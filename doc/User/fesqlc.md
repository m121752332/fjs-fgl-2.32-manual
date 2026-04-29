[Back to Contents](../index.html)

------------------------------------------------------------------------

# Genero FESQLC

- [Overview](#introduction)
- [Prerequisites](#prerequisites)
- [Embedding SQL Statements](#sqlstatement)
- [Using Host Variables](#hostvar)
  - [Character variables](#chars)
  - [Decimal variables](#decimals)
  - [Interval and datetime variables](#intervals)
- [Using Data structures](#datastructures)
  - [Arrays](#arrays)
  - [Structures (struct)](#struct)
  - [Type definitions (typedef)](#typedef)
  - [Function parameters](#parameters)
  - [Pointers](#pointers)
- [Using Indicator Variables](#indicator)
- [Using Database Cursors](#cursors)
- [Using Dynamic SQL](#dynamicsql)
  - [Preparing and Executing SQL Statements](#prepexec)
  - [Using Input parameters in Dynamic SQL](#inputparams)
  - [Using database cursors with Prepared statements](#cursor)
  - [Freeing Prepared statements](#free)
  - [Optimizing Prepared statements](#optomize)
- [Supported Data Types](#datatypes)
- [Compiling with fesqlc](#compiling)
  - [Creating a C Extension written in ESQL/C](#CEXT)
    - [Example](#CEXT_EXAMPLE)
- [Using Preprocessor Directives](#preprocessor)
  - [Including files](#include) - **include**
  - [Creating FESQLC macros](#define) - **define, undefine**
  - [Compiling conditionally](#conditional) - **ifdef, ifndef, endif,
    else, elif**
- [Handling Exceptions](#exceptions)
  - [Using SQLSTATE](#sqlstate)
  - [Using SQLCODE](#sqlcode)
  - [Using WHENEVER](#whenever)
  - [Using GET DIAGNOSTICS](#diagnostics)
  - [Example program](#Exampleprogram)
- [Migration Notes](#migration)

*See also*: [Implementing C Extensions](CExtensions.html)

------------------------------------------------------------------------

## [Overview]{#introduction}

Genero FESQLC allows you to [embed SQL statements](#sqlstatement) in
your C-language programs in order to communicate with a relational
database. The keywords \"**EXEC SQL**\" (preferred ANSI standard) or the
**\$** symbol precede SQL statements and FESQLC pre-processor
directives.

[Host variables](#hostvar) can substitute for literal values in your
programs. The host variable stores the values retrieved from a database
table or serves as a parameter for SQL statements.

You can create [dynamic SQL](#dynamicsql) statements that are
constructed at runtime, based on some program conditions or the user\'s
interaction.

FESQLC supports the common SQL data types, but some, such as DECIMAL, do
not have corresponding C data types. FESQLC provides additional [data
types](#datatypes) that you can use in your programs.

The **[fesqlc](#compiling)** [tool](#compiling) compiles and links C
programs that contain **FESQLC** source code files, creating an
executable C program.

[Exception handling](#exceptions) in FESQLC allows you to obtain
information about the execution of an SQL statement and to handle
program errors.

The FESQLC [preprocessor directives](#preprocessor) allow you to:

- include additional files in your FESQLC program
- create compile-time definitions
- specify conditional compilation

------------------------------------------------------------------------

## [Prerequisites]{#prerequisites}

Before you begin using Genero FESQLC, make sure the following has been
done:

- FESQLC and a C compiler are installed on your system.
- The database client software is installed.
- The environment variables required by the database client software are
  set.
- The PATH environment variable includes **\$FGLDIR/bin**, the bin
  directory of the software installation directory.

------------------------------------------------------------------------

## [Embedding SQL statements]{#sqlstatement}

SQL statements that communicate with a relational database can be
embedded in your program.

Statements must be preceded with the keywords \"EXEC SQL\" (preferred
ANSI standard) or the \$ symbol:

    EXEC SQL CONNECT TO "testdb";

    EXEC SQL CREATE TABLE t1 (
      k2 integer NOT NULL PRIMARY KEY,
      t1 date DEFAULT TODAY NOT NULL,
      c char(10)
    );

    EXEC SQL DELETE FROM customer WHERE store_num = '101';

### [Case sensitivity]{#case}

The following components of an embedded SQL statement are
case-sensitive:

- **[Names](#naming) of host variables**. The variable **ordernum** is
  not the same as **Ordernum**. FESQLC considers these to be two
  different variables.
- **[Data types](#datatypes)**. If you use the data type **INT** in a
  variable declaration it would not be recognized - **int** is the
  correct name. See Supported data types for the names of the FESQLC
  data types.
- **Cursor names and statement names**

Usually, the values in variables are case-sensitive. All other
components are not case-sensitive. 

### [Escape characters]{#quotes} and quotation marks

Both C and FESQLC use the backslash character \\ as the escape
character, to specify that the following character is to be considered
literal and not interpreted. FESQLC allows you to enclose strings in
either single or double quotes. Special care must be taken when the
WHERE clause of your embedded SQL statement contains a backslash or
quotation mark.

- To search for a backslash character, escape the special significance
  of the backslash with the \\ escape character: For example, to search
  for the company name **The \\\\ Store:**

> EXEC SQL DECLARE c1 CURSOR FOR SELECT * FROM customer WHERE store_name = 'The \\\\ Store';
>
> The first backslash causes the second backslash to be interpreted
> literally, and the third backslash causes the fourth backslash to be
> interpreted literally, resulting in the desired \"The \\\\ Store\".

- ANSI standards do not allow you to use the same quotation character in
  an expression as the string delimiter and as a literal. Therefore, to
  search for a value containing an embedded single quote, enclose the
  value with double quotes, and use the \\ escape character to cause the
  single quote to be interpreted literally.  For example, to search for
  the company name **The \' Store**:

> EXEC SQL DECLARE c1 CURSOR FOR SELECT * FROM customer WHERE store_name = "The \' Store";

### [Comments]{#comments}

You can use the standard C comment indicator in your FESQLC statements:

    EXEC SQL DELETE FROM customer;  /* deletes all rows */

------------------------------------------------------------------------

## Using [Host Variables]{#hostvar}

Host variables are C variables that you can use in SQL statements as if
they were literal values. Host variables can store:

- Parameter values for SQL statements
- Result set values fetched from the database
- Cursor or statement identifiers

### [Variable name]{#naming}

As in C, the host variable name can consist of letters, digits, and
underscores, consistent with the requirements of your C compiler. Begin
the name with a letter rather than an underscore, to avoid potential
conflicts with internal FESQLC names.

> int x;
>     char str1[11];

A variable name is case-sensitive; **firstname** is not the same as
**FirstName**.

### [Variable declaration]{#declaring}

Choose a data type for the host variable compatible with the SQL data
type of the database column, if the variable is used to transfer data
between the program and the database. 

See [Supported Data Types](#datatypes) for a list of the SQL data types
and the compatible FESQLC or C data types.

You can also use [data structures](#datastructures) such as arrays,
struct, and pointers as host variables in your program.

Declare the host variable in your program, using the same syntax that
you use to declare a C variable. Put the statements in an FESQLC declare
section preceded with the keywords EXEC SQL BEGIN DECLARE SECTION, and
terminate it with EXEC SQL END DECLARE SECTION (preferred ANSI
standard):

> EXEC SQL BEGIN DECLARE SECTION;
>         int x;
>         char str1[11];
>         char str4[11];
>     EXEC SQL END DECLARE SECTION;

For backward compatibility with Informix ESQL/C, the FESQLC compiler
also supports host variable declaration with the \$ symbol:

> $int x;
>     $char str1[11];

The variable can be declared only once within a C block.

### [Data conversion]{#conversion}

We recommend that you use the [FESQLC data type](#datatypes) that
corresponds to the SQL data type of the database column being referenced
in your statements.

When necessary, FESQLC will try to convert the data type of a value if a
discrepancy exists in your program.

### [Scope]{#scope}

The *scope* of an FESQLC host variable is the same as that of a C
variable, which is dependent on the placement of the declaration within
the file:

- Host variables declared within a program block or declared by a
  function are **local**, accessible only within that block or
  function. 
- Host variables declared outside a function are **modular**, accessible
  from all program blocks that occur after that point, until the end of
  the file. 
- If a local host variable has the same identifier as an external
  variable, the local variable takes precedence inside the program block
  in which it is declared.

### [Initialization]{#initialization}

FESQLC allows you to use normal C initializer expressions with host
variables:

> EXEC SQL BEGIN DECLARE SECTION;
>       int var1 = 128;
>       string var2[21] = "A test string";
>     EXEC SQL END DECLARE SECTION;

Local datetime or interval variables are automatically initialized to
set the datetime or interval qualifier; local variables of any other
data type have an undefined value and must always be initialized before
use.

> EXEC SQL BEGIN DECLARE SECTION;
>       datetime year to second dt;
>       interval hour to second t1_iv1;
>     EXEC SQL END DECLARE SECTION;

The FESQLC preprocessor does not check the validity of initialization
statements; the C compiler handles this.

### [Host variables in use]{#Using_host_variables}

Precede the variable with an indicator (:) whenever it is used in an
embedded SQL statement:

> EXEC SQL BEGIN DECLARE SECTION;
>        varchar firstname[31];
>        int stateid;
>        varchar statename[51];
>     EXEC SQL END DECLARE SECTION;
>
>     EXEC SQL select fname into :firstname from custtab;
>     EXEC SQL insert into statetab values (:stateid, :statename);

------------------------------------------------------------------------

## [Character variables]{#chars}

Although you can use **char/varchar/string/fixchar** data types for host
variables in your program, we recommend that you match the data type of
the host variable to the data type of the corresponding database column.

[Genero C Extensions](CExtensions.html#CAPI) provide character and
string functions to manipulate character data.

### Declaring Size

The **char/varchar/string** host variables include the string
terminator; you must allow for the terminator when declaring one of
these variables. For example, to correspond to a database CHAR data
type, declare the size of the **char** host variable as (dblength+1).

      EXEC SQL BEGIN DECLARE SECTION;
      char p_state_code[3]  /* length of the column state.state_code is 2 */

Although **char**, **varchar**, and **string** host variables contain
null terminators, FESQLC never inserts these characters into a database
column.

### Using char/varchar Pointers

It is strongly recommended that you use fixed-size **char** and
**varchar** variables instead of pointers. The problem with
**char/varchar** pointers is that the database interface cannot
determine the size of the **char/varchar** input parameter or fetch
buffer, which is required for binding host variables to SQL statements.

Host variables defined as **char** or **varchar** pointers cannot be
used to fetch data. If you must use a **char/varchar** pointer to insert
data, use an sqlda structure and specify the exact size of the
corresponding CHAR/VARCHAR SQL type in `sqlvar->sqllen`.

### Fetching and inserting CHAR data

When a value from a CHAR database column is fetched into a **char** host
variable, FESQLC pads the value with trailing blanks up to the size of
the host variable, leaving one space for the null terminator. If the
column data being fetched does not fit into the character host variable,
FESQLC truncates the data, setting the [SQLSTATE](#sqlstate) variable to
01004, and setting the value of any [indicator variable](#indicator) to
the size of the character data in the column.

When inserting a value into a CHAR database column, FESQLC pads or
truncates the value to the size of that column, if necessary.

### Fetching and inserting VARCHAR data

When a value from a VARCHAR database column is fetched into a **char**
host variable, FESQLC truncates and null terminates the value if the
source is longer, and sets any indicator variable; if the destination is
longer, FESQLC pads the value with trailing spaces and null terminates
it.

When a character value is inserted into a VARCHAR database column, any
trailing spaces are not counted.

### Using the fixchar data type

The **fixchar** data type is a character string data type that does not
have a null terminator. When a value from a CHAR or VARCHAR column is
fetched into a fixchar, FESQLC pads the value with trailing blanks. 

Do not use **fixchar** to insert data into a VARCHAR column. Even if the
length of the data is shorter than the **fixchar**, trailing blanks will
be stored by the database server.

Do not copy a null-terminated C string into a **fixchar** variable. When
the variable value is inserted into the database column, the null
character at the end of the string will also be inserted, complicating
subsequent searches for the data value.

### Using the string data type

The FESQLC **string** data type holds character data terminated by a
null character, and does not have trailing blanks.

When values from a CHAR/VARCHAR column are fetched into a **string**
host variable, the value is usually stripped of trailing blanks and
null-terminated. However, if the value is a string of blanks (\"    
\"), a single blank and the null-terminator are stored in the **string**
host variable, to distinguish an empty string from a null string.

------------------------------------------------------------------------

## [Decimal Variables]{#decimals}

FESQLC supports the **dec_t** and **decimal** data types to handle
DECIMALs. Although you can use the **dec_t** data type to fetch decimal
data, it cannot be used to insert data as there is no precision or
scale; we recommend the use of the FESQLC **decimal** data type, which
supports the DECIMAL and MONEY SQL data types, for inserting and
fetching data.

A **decimal** host variable must be defined with a precision and scale:

> EXEC SQL BEGIN DECLARE SECTION;
>        decimal(6,2) dec4;

[Genero C Extensions](CExtensions.html#CAPI) provide decimal functions
to manipulate decimal values. Use only decimal functions on decimal data
types; otherwise, you may get unpredictable results.

------------------------------------------------------------------------

## [Interval and Datetime Variables]{#intervals}

The **interval** FESQLC [data type](#datatypes) encodes a span of time.
The **datetime** FESQLC data type encodes a specific point in time. The
accuracy of the data types is specified by a qualifier (year to second,
etc.) Declare host variables for INTERVAL or DATETIME database columns
using these FESQLC data types:

> EXEC SQL BEGIN DECLARE SECTION;
>       datetime year to second dtm2;
>       interval hour(5) to second inv2;
>     EXEC SQL END DECLARE SECTION;

A **datetime** or **interval** data type is stored as a decimal number
with a scale of zero and a precision dependent on the qualifier used
when defining the data type.

**Datetime** and **interval** host variables must have the qualifier
initialized. This is done by using datetime or **interval** data types
as shown in the above example.  If you use **dtime_t** or **intrvl_t**
data types, use macros to initialize their qualifiers:

> EXEC SQL BEGIN DECLARE SECTION;
>        dtime _t dtml;
>        intrvl_t inv1;
>     EXEC SQL END DECLARE SECTION;
>
>     dtml.dt_qual = TU_DTENCODE(TU_YEAR, TU_SECOND);
>     invl.in_qual = TU_TENCODE(5, TU_HOUR, TU_SECOND);

Genero C Extensions provide [macros](CExtensions.html#MACROS) for the
qualifiers, and [functions](CExtensions.html#CAPI) to manipulate these
data types. 

------------------------------------------------------------------------

## Using [data structures]{#datastructures}

### [Arrays]{#arrays}

You can declare an *array* of host variables in your program; provide
the number of elements in the array:

> EXEC SQL BEGIN DECLARE SECTION;
>       int ordid[20];
>      EXEC SQL END DECLARE SECTION;

An array can be one-dimensional or two-dimensional.

Your program can reference an element of the array as follows:

    EXEC SQL DELETE FROM ordertab WHERE order_num = :ordid[1];

### [Structures (struct)]{#struct}

You can declare a C language structure *struct* in your program,
specifying the members of the structure:

> EXEC SQL BEGIN DECLARE SECTION;
>       struct {
>         int ordid;
>         date orddate; 
>         char ordname[26];
>       } order_rec;
>     EXEC SQL END DECLARE SECTION;

Here struct **order_rec** defines a host variable with three members:
**ordid**, **orddate**, and **ordname**.

The individual members of the structure are referenced in your program
as *structname.membername*:

> EXEC SQL insert into ordertab (order_num, order_date)
>         values (:order_rec.ordid :order_rec.orddate);

If an SQL statement allows a list of host variables, you can specify the
structure name and FESQLC will expand it:

> EXEC SQL insert into ordertab values (:order_rec);

The values list in this SQL statement will expand to order_rec.ordid,
order_rec.orddate, order_rec.ordname.

### [Type definitions (typedef)]{#typedef}

FESQLC supports C typedef statements and allows the use of typedef names
in the declaration of the types of host variables:

> EXEC SQL BEGIN DECLARE SECTION;
>
>     typedef struct {
>          int key;
>          varchar name[21];
>          datetime year to fraction(5) tstamp;
>     } mytype;
>
>     mytype myrecord;
>
>     EXEC SQL END DECLARE SECTION;

You cannot use a typedef statement that names a multidimensional array,
a union, or a function pointer as the type of a host variable.

### [Function parameters]{#parameters}

You can declare host variables as function parameters; precede the
variable name with the PARAMETER keyword.

> func1(ord_id, ord_date)
>     EXEC SQL BEGIN DECLARE SECTION;
>       PARAMETER int ord_id;
>       PARAMETER date ord_date;
>     EXEC SQL END DECLARE SECTION;
>     {
>       ...
>       EXEC SQL INSERT INTO oldorders VALUES (:ord_id, :ord_date);
>       ...
>     }

#### Notes:

- Parameters declared for host variables must be part of a function
  header only.
- You can have other function parameters that are not used as host
  variables inside the EXEC SQL declare section.

### [Pointers]{#pointers}

Host variables can be declared as pointers to SQL identifiers, prepared
statements for example:

> EXEC SQL BEGIN DECLARE SECTION;
>         char *stmt;
>         int ord_num;
>     EXEC SQL END DECLARE SECTION;
>     ...
>     stmt = "SELECT order_num FROM orders";
>     EXEC SQL PREPARE curs1 FROM :stmt;
>     EXEC SQL OPEN curs1;
>     EXEC SQL FETCH curs1 INTO :ord_num;

Host variables declared as pointers can also be used as input parameters
in SQL insert statements. However, we strongly recommend that you use
fixed-size char and varchar host variables instead of char/varchar
pointers to hold SQL CHAR/VARCHAR data.

    EXEC SQL BEGIN DECLARE SECTION;
      int *v_id;
      char v_name[26];
    EXEC SQL END DECLARE SECTION;
    ...
    INSERT INTO vendors values (:v_id, :v_name);

------------------------------------------------------------------------

## [Using Indicator variables]{#indicator}

You can specify an indicator variable in your SQL statement to obtain
information about a value returned by the statement.

- Declare the indicator variable using the normal FESQLC syntax, and
  specify an appropriate data type; integer data types are used for
  indicators that detect [null values](#nullvars) or [truncated
  values](#truncate).

> EXEC SQL BEGIN DECLARE SECTION;
>        char p_state_code[3];
>        int i_state_code;
>     EXEC SQL END DECLARE SECTION;

- Use the indicator variable in the SELECT statement. Specify the
  indicator variable to be associated with the host variable, preceding
  the indicator variable with the word INDICATOR:

> :p_state_code INDICATOR :i_state_code
>
> Or, separate the variables with a symbol (: or \$). There can be one
> or more whitespaces between the host variable name and the indicator
> name:
>
>     :p_state_code :i_state_code
>     $p_state_code$i_state_code
>     $p_state_code:i_state_code
>
> Example:

> EXEC SQL SELECT state_code INTO :p_state_code INDICATOR :i_state_code
>          FROM state WHERE state_name = 'Illinois'; 

When FESQLC returns the value into the host variable, it will also set
the corresponding indicator variable. Your program can check the values
of any indicator variables before continuing.

### [To detect null values]{#nullvars}

If a database table column permits nulls, you may have a null value
returned to the corresponding host variable specified in your SQL SELECT
statement. If one of the values in a database column referenced for an
aggregate function is null, you may also have a null value returned.
Null (unknown) values can cause problems for your program. Use indicator
variables to determine whether any values returned to the host variables
are null:

- FESQLC will set the value of an indicator variable to **zero** if the
  value returned for the associated host variable is not null.
- If the value returned is null, FESQLC will set the indicator variable
  to **-1**.

Checking whether the variable is null before printing it:

      printf("%s\n", i_state_code == 0 ? p_state_code : "<no code>");
     

**Tip:**  The NULL keyword of an INSERT statement allows you to insert a
null value into a table row. As an alternative, you can use a negative
indicator variable with the host variable. Set the value of the
indicator variable to **-1** when it is declared.

### [To detect truncated values]{#truncate}

If the host variable referenced by an SQL SELECT statement is a
character array, the value returned from the database may be truncated
(the value returned is too large to fit into the array). Use indicator
variables to determine whether any values returned are truncated.

- FESQLC will set the value of an indicator variable to **zero** if the
  value returned for the associated host variable is not truncated.
- If the value returned was truncated, FESQLC will set the value of the
  indicator variable to the original size in bytes of the host variable.

#### Example program using indicator variables:

``` linenumber
01 #include <stdio.h>
02
03 int main()
04 {
05  EXEC SQL BEGIN DECLARE SECTION;
06  char p_state_code[3];
07  int i_state_code;
08  EXEC SQL END DECLARE SECTION;
09
10  EXEC SQL CONNECT TO "custdemo";
11  EXEC SQL SELECT state_code INTO :p_state_code INDICATOR :i_state_code 
12    FROM state 
13    WHERE state_name = 'Illinois'; 
14
15  printf("%-20s\n ",
16         i_state_code == 0 ? p_state_code : "<no name>"
17  );
18  EXEC SQL DISCONNECT ALL;
19 }
```

------------------------------------------------------------------------

## [Using database cursor statements]{#cursors}

You can use sequential, scroll, hold, update, or insert cursors in
FESQLC programs. For example, if a SELECT statement will retrieve more
than one row:

- **Declare** the cursor for the select statement. This allocates
  storage to hold the cursor.
- **Open** the cursor. The active set associated with the cursor is
  identified, and the cursor is positioned before the first row of the
  set.
- **Fetch** the data into the [host variable(s),](#hostvar) until the
  last desired row is fetched.
- **Close** the cursor when the fetch is complete. This releases the
  active result set associated with the cursor.  A closed cursor can be
  re-opened.
- **Free** the cursor when it is no longer needed by the program. A
  freed cursor must be declared again before it can be re-opened and
  used.

The cursor program statements must appear physically within the module
in the order listed.

#### Example program using a database cursor:

``` linenumber
01 #include <stdio.h>
02
03 EXEC SQL define NAME_LEN 20;  /* customer.store_name is a CHAR(20)  */
04 EXEC SQL define ADDR_LEN 20;  /* customer.addr is a CHAR(20)        */
05 EXEC SQL define STATE_LEN 2;  /* customer.state_code is a CHAR(2)   */
06
07 int main()
08 {
09
10  EXEC SQL BEGIN DECLARE SECTION;
11    int p_num;
12    varchar p_name[ NAME_LEN + 1 ];
13    int2 i_name;
14    varchar p_addr[ ADDR_LEN + 1 ];
15    int2 i_addr;
16    varchar p_addr2[ ADDR_LEN + 1 ];
17    int2 i_addr2;
18    char p_state_code[STATE_LEN + 1];
19  EXEC SQL END DECLARE SECTION;
20
21  printf( "Connecting...\n\n");
22  EXEC SQL CONNECT TO 'custdemo';
23
24  EXEC SQL DECLARE c1 CURSOR FOR        /* Declaring the cursor */
25    SELECT store_num, store_name, addr, addr2
26     FROM customer
27     WHERE state = :p_state;
28
29  strcpy(p_state, "IL");
30  EXEC SQL OPEN c1;                  /* Opening the cursor */
31
32  for (;;)                           /* loop to fetch the rows */
33  {
34   EXEC SQL FETCH c1 INTO :p_num,   
35    :p_name INDICATOR :i_name,
36    :p_addr INDICATOR :i_addr,
37    :p_addr2 INDICATOR :i_addr2;
38
39   if (strncmp(SQLSTATE, "02", 2) == 0) {
40     /* No more rows */
41     break;
42   }
43
44   printf("%6d %-20s\n %s %s\n",
45     p_num,
46     i_name == 0 ? p_name : "<no name>",
47     i_addr == 0 ? p_addr : "<no address>",
48     i_addr2 == 0 ? p_addr2 : ""
49   );
50  }
51
52  EXEC SQL CLOSE c1;     /* close the cursor */
53  EXEC SQL FREE c1       /* free the cursor  */
54
55  printf("\nDisconnecting...\n\n");
56  EXEC SQL DISCONNECT CURRENT;
57
58  return 0;
59 }
```

The code in lines 39-41 checks the SQLSTATE global variable to determine
whether there are any more rows to retrieve. See [Handling
Exceptions](#exceptions)

See [Dynamic SQL](#dynamicsql) for additional examples using cursors and
the PREPARE statement.

**Note:** The FETCH \... INTO \... syntax is supported by all databases.
Declaring a cursor for SELECT \... INTO \... is Informix-specific
syntax, and not recommended for portability.

------------------------------------------------------------------------

## [Using Dynamic SQL]{#dynamicsql}

Dynamic SQL statements allow you to construct an SQL statement at
runtime, based on some program conditions or the user\'s interaction.

1.  Your program assembles the SQL statement in a character string, and
    assigns it to a character string host variable. 

> The SQL statement string cannot contain the names of any host
> variables. [Input parameters](#inputparams) (indicated by question
> mark placeholders in the statement string) can be used in the
> statement string, for example in a WHERE clause, to indicate that the
> value needed will be provided at a given position in the SQL
> statement.

2.  Your program uses the [prepare](#prepare) statement to assign a
    statement id and send the SQL statement string contained in the host
    variable to the database server for parsing. You can check the
    global variables [SQLSTATE](#sqlstate) or [SQLCODE](#sqlcode) to
    find out whether errors occurred in the parsing.

<!-- -->

3.  Your program [executes](#execute) the prepared statement one or more
    times.

> - If [input parameters](#inputparams) are used, the USING clause of
>   the EXECUTE or OPEN instruction provides the values.
> - If the SQL statement produces a result set (like SELECT), or inserts
>   multiple rows with an INSERT CURSOR, you must declare a
>   [cursor](#cursor) with the prepared statement handle in order to
>   execute it.

4.  When the prepared statement is no longer needed, your program
    [frees](#free) the statement to release the allocated resources.

You can use Dynamic SQL for any SQL statement except SQL management
instructions (such as PREPARE, DECLARE, OPEN, EXECUTE, FETCH, CLOSE,
FREE), SQL connection instructions (such as CONNECT, DATABASE,
DISCONNECT) and transaction control instructions (BEGIN WORK, COMMIT
WORK, ROLLBACK WORK, SET ISOLATION, SET LOCK MODE).

------------------------------------------------------------------------

## [Preparing and Executing SQL statements]{#prepexec}

### [Preparing]{#prepare} statements

In order to prepare an SQL statement, you must do the following:

1.  Declare a char [host variable](#hostvar) to hold the entire SQL
    string:

> EXEC SQL BEGIN DECLARE SECTION;
>       char sqlstring[128];    /* SQL statement */
>     EXEC SQL END DECLARE SECTION;

2.  Assign the SQL string to the host variable:  

> strcpy(sqlstring, "DELETE FROM orders WHERE store_num IS NULL");

3.  Use the PREPARE statement to create a valid SQL statement from the
    string contained in the host variable:

> EXEC SQL PREPARE stid FROM :sqlstring;

Once an SQL statement is prepared, use EXECUTE to execute the statement;
the statement can be executed often as needed.

### [Executing]{#execute} prepared statements that do not return values (INSERT, UPDATE, DELETE)

Follow the steps described at the beginning of this section to prepare
the statement. Then, use the EXECUTE instruction to perform the
execution of the statement:

> strcpy(sqlstring, "DELETE FROM orders WHERE store_num IS NULL");
>     EXEC SQL PREPARE stid FROM :sqlstring;
>     EXEC SQL EXECUTE stid;

### Executing prepared statement that return values (SELECT)

If the prepared SQL statement returns a [single row]{.underline}, you
can use the INTO clause with EXECUTE to specify the host variables to
receive the database column values:

> sprintf(sqlstring, "SELECT COUNT(*) FROM orders");
>     EXEC SQL PREPARE stid FROM :sqlstring;
>     EXEC SQL EXECUTE stid INTO :p_order_count;

You can use [indicator variables](#indicator) with the EXECUTE
statement, to determine if a value returned from the database is null:

> EXEC SQL EXECUTE stid INTO :p_custname INDICATOR :i_custname;

If the prepared statement returns more than one row, you must declare a
database cursor and use cursor management statements instead of the
EXECUTE statement. See [Using cursors with prepared
statements](#cursor).

### Executing dynamic SQL statements without parameters

If there are no [input parameters](#inputparams), and the statement will
not be executed multiple times, you can reduce the number of statements
to be executed by using the EXECUTE IMMEDIATE statement to prepare and
execute the statement string at once:

> sprintf(sqlstring, "DELETE FROM orders WHERE store_num IS NULL");
>     EXEC SQL EXECUTE IMMEDIATE :sqlstring;

#### Example program using EXECUTE IMMEDIATE and also returning a single row:

``` linenumber
01 #include <stdio.h>
02
03 int main()
04
05 {
06  EXEC SQL BEGIN DECLARE SECTION;
07    char sqlstring[128];   /* string to hold sql statement */ 
08    int p_store_num;       /* values for store_num column */
09    char p_store_name[21]; /* values for store_name, column length 20 */
10    int2 i_store_name;      /* indicator variable for p_store_name */
11  EXEC SQL END DECLARE SECTION;
12
13  char whereinput[64];   /* variable for string containing where clause */
14  strcpy(whereinput, "store_num > 200"); /* setting value of whereinput */
15  
16  EXEC SQL CONNECT TO 'custdemo';
17
18  /* Using EXECUTE IMMEDIATE  */
19  sprintf(sqlstring, "DELETE FROM orders WHERE %s", whereinput);
20  EXEC SQL EXECUTE IMMEDIATE :sqlstring;
21
22  /* Returning a single row - USING PREPARE and EXECUTE */
23  strcpy(whereinput, "store_num = 101");  /* setting value of whereinput */
24  sprintf(sqlstring, "SELECT store_name FROM customer WHERE %s", whereinput);
25  EXEC SQL PREPARE stid FROM :sqlstring;
26  EXEC SQL EXECUTE stid INTO :p_store_name INDICATOR :i_store_name;
27  /* Displaying store name */
28  printf("%-20s\n", i_store_name == 0 ? p_store_name : "<no name>");
29
30  EXEC SQL DISCONNECT CURRENT;
31
32  return 0;
33 }
```

------------------------------------------------------------------------

## [Using Input Parameters in dynamic SQL]{#inputparams}

Input parameters are placeholders in an SQL statement string for host
variables that contain the values for expressions. The actual values are
provided at runtime. Placeholders are used since the database server
cannot parse a dynamic SQL statement that contains host variable names.

Placeholders can be used anywhere within the SQL statement where an
expression is valid. You cannot use an input parameter to represent an
identifier such as a database name, a table name, or a column name.

### Steps to use input parameters

1.  Declare a [host variable](#hostvar) for each input parameter. The
    data type of the host variable must be compatible with the data type
    of the database column referenced in the SQL statement string.
2.  Assemble the SQL statement string using ? as a placeholder for each
    input parameter.
3.  PREPARE the statement string to create a valid SQL statement.
4.  Provide the host variables corresponding to the input parameters
    with the USING clause of the EXECUTE instruction. The order in which
    the variables are listed must match the order in which the variables
    appear in the prepared statement.

Example using input parameters with a prepared DELETE statement:

> EXEC SQL PREPARE stid FROM "DELETE FROM orders WHERE store_num = ? AND order_num < ?";
>     EXEC SQL EXECUTE stid USING :p_store_num, :p_order_num;

Example using input parameters with a prepared SELECT statement that
returns a single row:

> EXEC SQL PREPARE stid FROM "SELECT COUNT(*) FROM orders WHERE order_num < ?";
>     EXEC SQL EXECUTE stid USING :p_order_num INTO :p_count;

If the SELECT statement returns more than one row, a [database
cursor](#cursor) must be used.

#### Example program using input parameters:

``` linenumber
01 #include <stdio.h>
02
03 int main()
04 {
05  EXEC SQL BEGIN DECLARE SECTION;
06    char sqlstring[128]; 
07    char p_state_code[3];       /* column length is 2  */
08    char p_state_name[16];      /* column length is 15 */
09  EXEC SQL END DECLARE SECTION;
10
11  EXEC SQL CONNECT TO 'custdemo';
12
13  /* Using placeholders for values to be inserted  */
14  strcpy(sqlstring, "INSERT INTO state VALUES ( ?, ? )");
15  EXEC SQL PREPARE stid2 FROM :sqlstring;
16  printf(" SQLSTATE = [%s]\n\n", SQLSTATE); /* checking SQL success */
17
18  strcpy(p_state_code, "AZ");
19  strcpy(p_state_name, "Arizona");
20
21  /* Executing the prepared statement */
22  EXEC SQL EXECUTE stid2 USING :p_state_code, :p_state_name;
23  printf(" SQLSTATE = [%s]\n\n", SQLSTATE);
24  
25  EXEC SQL DISCONNECT CURRENT;
26
27  return 0;
28 }
```

------------------------------------------------------------------------

## [Using a Database Cursor with Prepared statements]{#cursor}

If an SQL SELECT statement generates a set of rows, you must handle the
result set with a Database Cursor.

First, the cursor is declared for the prepared statement:

> EXEC SQL PREPARE stid FROM "SELECT order_num FROM orders WHERE store_num = ?";
>     EXEC SQL DECLARE c1 CURSOR FOR stid;

If input parameters are used in the WHERE clause, the USING clause of
the OPEN cursor instruction provides the host variables containing the
values needed:

> EXEC SQL OPEN c1 USING :p_store_num;

The FETCH statement uses the INTO clause to retrieve the database values
into host variables. This statement can be executed multiple times until
there are no more values to be retrieved:

> EXEC SQL FETCH c1 INTO :p_order_num;

The order in which the [host variables](#hostvar) are listed must match
the order of the select list.

CLOSE the cursor when the fetch is complete.  A closed cursor can be
re-opened.

> EXEC SQL CLOSE c1;

When the cursor is no longer needed, it is FREEd, releasing the memory
associated with it. Once freed, a cursor must be re-declared before it
can be used again.

> EXEC SQL FREE c1;

#### Example program using a database cursor and prepared statement:

``` linenumber
01 #include <stdio.h>
02 
03 /* To check for SQL errors */
04 void errlog(void)
05 {
06  fprintf(stderr, "Error occurred:\n");
07  fprintf(stderr, " SQLSTATE = [%s] SQLCODE = %d\n\n",
08                  SQLSTATE, SQLCODE);
09  EXEC SQL DISCONNECT ALL;
10  exit(1);
11 }
12
13 int main()
14 {
15  EXEC SQL BEGIN DECLARE SECTION;
16    int p_store_num;        /* store_num column */
17    int p_order_num;        /* order_num column */
18    int2 i_order_num;       /* indicator for p_order_num */
19  EXEC SQL END DECLARE SECTION;
20 
21  EXEC SQL WHENEVER ERROR CALL errlog; /* Set the error-handling */
22
23  EXEC SQL CONNECT TO 'custdemo';
24 
25  EXEC SQL PREPARE stid FROM "SELECT order_num FROM orders WHERE store_num = ?";
26  EXEC SQL DECLARE c1 cursor for stid;
27  p_store_num = 12;  /* Assign a value to store number */
28  EXEC SQL OPEN c1 USING :p_store_num;
29
30  for (;;)
31  {
32   EXEC SQL FETCH c1 INTO :p_order_num INDICATOR :i_order_num;
33   if (strncmp(SQLSTATE, "02", 2) == 0) break;
34   printf("%6d \n",
35          i_order_num == 0 ? p_order_num : "<no order number>"
36   );
37  }
38
39  EXEC SQL CLOSE c1;
40  EXEC SQL FREE c1;
41
42  EXEC SQL DISCONNECT CURRENT;
43
44  return 0;
45 }
```

### [Inserting multiple rows]{#inscurs}

Use an *insert cursor* to perform buffered row insertion in database
tables. The insert cursor simply inserts rows of data; it cannot be used
to fetch data.

A cursor is declared for the prepared statement, using input parameters
for the values to be inserted:

> EXEC SQL PREPARE s1 FROM "INSERT INTO manufact VALUES (?,?)"
>     EXEC SQL DECLARE c1 CURSOR FOR s1;

The insert cursor is opened:

> EXEC SQL OPEN c1;

The PUT cursor instruction uses the USING clause to insert values from
the [host variables](#hostvar) into the database columns. This statement
is executed multiple times until there are no more values to be
inserted.

> EXEC SQL PUT c1 FROM :faccode, :facname;

Flush data rows, if required:

> EXEC SQL FLUSH c1;

Close the cursor:

> EXEC SQL CLOSE c1;

Free the statement handle and the cursor:

> EXEC SQL FREE s1;
>     EXEC SQL FREE c1;

------------------------------------------------------------------------

## [Freeing Prepared Statements]{#free}

When the prepared statement is no longer needed, your program can free
the statement to release the resources allocated:

> EXEC SQL PREPARE stid FROM "SELECT order_num FROM orders WHERE store_num = ?";
>     ...
>     EXEC SQL FREE stid;

If a database cursor is used for the prepared statement, both the cursor
and the statement can be freed:

> EXEC SQL FREE c1;
>     EXEC SQL FREE stid;

------------------------------------------------------------------------

## [Optimizing Prepared Statements]{#optomize}

If an SQL statement is to be executed multiple times, you can reduce
thetraffic between the client application and the database server if the
statement is not also parsed and optimized each time. Use the PREPARE
statement to parse the statement outside of the program loop, so the
parsing only occurs once:

> EXEC SQL PREPARE stid FROM "DELETE FROM orders WHERE store_num = ?"

Then, use the EXECUTE \... USING statement inside the program loop.

> EXEC SQL EXECUTE stid USING :p_store_num;

------------------------------------------------------------------------

## [Supported Data Types]{#datatypes}

When your program accesses a database column you must [declare a host
variable](#declaring) of the appropriate FESQLC or C data type to hold
the data.

### [Recommended Data Types for Host Variables]{#rectypes}

The table below lists the relationship between supported SQL data types,
and the recommended FESQLC host variable data types that correspond to
the SQL types. Also included are the corresponding data type constants,
required by some FESQLC functions:

+-----------------+------------------------+------------------+-----------------+
| **SQL Data      | **C Data Type**        | **Description**  | **Type          |
| Type**          |                        |                  | Constant**      |
+-----------------+------------------------+------------------+-----------------+
| char(*n*),\     | char(*n+1*)            | character data,  | CCHARTYPE       |
| character(*n*)  |                        | padded with      |                 |
|                 | \                      | blanks;          | \               |
|                 | string(*n+1*)          | null-terminated, | CSTRINGTYPE     |
|                 |                        | specify database |                 |
|                 |                        | column length    |                 |
|                 |                        | plus 1           |                 |
|                 |                        |                  |                 |
|                 |                        | character data,  |                 |
|                 |                        | no trailing      |                 |
|                 |                        | blanks;          |                 |
|                 |                        | null-terminated, |                 |
|                 |                        | specify database |                 |
|                 |                        | column length    |                 |
|                 |                        | plus 1           |                 |
+-----------------+------------------------+------------------+-----------------+
| date            | date                   | 4-byte integer   | CDATETYPE       |
|                 |                        | representing the |                 |
|                 |                        | date             |                 |
+-----------------+------------------------+------------------+-----------------+
| datetime        | datetime               | calendar date    | CDTIMETYPE      |
|                 | (*qualifiers*)         | and time of day; |                 |
|                 |                        | must specify     |                 |
|                 |                        | accuracy as a    |                 |
|                 |                        | qualifier such   |                 |
|                 |                        | as *year to day* |                 |
+-----------------+------------------------+------------------+-----------------+
| decimal, dec,   | decimal(*p,s*)         | fixed point      | CDECIMALTYPE    |
| numeric         |                        | number; *p*      |                 |
|                 |                        | (precision) and  |                 |
|                 |                        | *s* (scale) must |                 |
|                 |                        | be defined       |                 |
+-----------------+------------------------+------------------+-----------------+
| money           | decimal(*p,s*)         | fixed point      | CMONEYTYPE      |
|                 |                        | number; *p*      |                 |
|                 |                        | (precision) and  |                 |
|                 |                        | *s* (scale) must |                 |
|                 |                        | be defined       |                 |
+-----------------+------------------------+------------------+-----------------+
| float, double   | double                 | double-precision | CDOUBLETYPE     |
| precision       |                        | value with up to |                 |
|                 |                        | 17 significant   |                 |
|                 |                        | digits           |                 |
+-----------------+------------------------+------------------+-----------------+
| integer, int    | int, long              | 4-byte integer   | CINTTYPE        |
+-----------------+------------------------+------------------+-----------------+
| interval        | interval(*qualifiers*) | a span of time;  | CINVTYPE        |
|                 |                        | must specify     |                 |
|                 |                        | accuracy as a    |                 |
|                 |                        | qualifier such   |                 |
|                 |                        | as *day to       |                 |
|                 |                        | second*          |                 |
+-----------------+------------------------+------------------+-----------------+
| serial          | int, long              | 4-byte integer   | CINTTYPE        |
+-----------------+------------------------+------------------+-----------------+
| smallfloat,     | float                  | single-precision | CFLOATTYPE      |
| real            |                        | value with up to |                 |
|                 |                        | 9 significant    |                 |
|                 |                        | digits           |                 |
+-----------------+------------------------+------------------+-----------------+
| smallint        | short                  | 2-byte integer   | CSHORTTYPE      |
+-----------------+------------------------+------------------+-----------------+
| varchar(m,x)    | varchar(*m+1*)\        | variable length  | CVARCHARTYPE\   |
|                 |                        | character data;  | \               |
|                 | string(*n+1*)          | null-terminated, | \               |
|                 |                        | specify maximum  | CSTRINGTYPE     |
|                 |                        | length plus 1    |                 |
|                 |                        |                  |                 |
|                 |                        | character data,  |                 |
|                 |                        | no trailing      |                 |
|                 |                        | blanks;          |                 |
|                 |                        | null-terminated, |                 |
|                 |                        | specify database |                 |
|                 |                        | column length    |                 |
|                 |                        | plus 1           |                 |
+-----------------+------------------------+------------------+-----------------+

See [Using Host Variables](#hostvar) for additional information about
the use of these data types.

### [Additional FESQLC data types]{#addnltypes}

These data types are not recommended for use in database operations, but
may be used in FESQLC functions.

  ----------------------- ----------------------- -----------------------
  **FESQLC\               **Description**         **Data Type Constant**
  Data Type**                                     

  fixchar(n)              character data, padded  CFIXCHARTYPE
                          with blanks, no null    
                          terminator              

  dec_t                   decimal value; cannot   CDECIMALTYPE
                          have precision or scale 

  dtime_t                 datetime value; cannot  CDTIMETYPE
                          have qualifiers         

  intrvl_t                interval value; cannot  CINVTYPE
                          have qualifiers         
  ----------------------- ----------------------- -----------------------

### [Specific-Length Data Types]{#machtypes}

The following data types automatically map correctly for 32-bit and
64-bit platforms. Some FESQLC functions use these data types instead of
int, short, and long.

  ----------------------------------- -----------------------------------
  **FESQLC\                           **Description**
  Data Type**                         

  int1                                one-byte integer

  int2                                two-byte integer

  int4                                four-byte integer

  mint                                native integer data type for
                                      machine

  mlong                               native long integer data type for
                                      the machine

  MSHORT                              native short integer data type for
                                      the machine

  MCHAR                               native char data type for the
                                      machine
  ----------------------------------- -----------------------------------

### [SQL Data Types not supported]{#unsupported}

+-----------------------------------+-----------------------------------+
| **SQL\                            | **Description**                   |
| Data Type**                       |                                   |
+-----------------------------------+-----------------------------------+
| blob                              | binary large object; binary data  |
|                                   | in an undifferentiated byte       |
|                                   | stream                            |
+-----------------------------------+-----------------------------------+
| boolean                           | data type with values limited to  |
|                                   | TRUE, FALSE, and NULL             |
+-----------------------------------+-----------------------------------+
| byte                              | binary data in an                 |
|                                   | undifferentiated byte stream      |
+-----------------------------------+-----------------------------------+
| clob                              | character large object; text data |
+-----------------------------------+-----------------------------------+
| int8                              | 8-byte integer                    |
+-----------------------------------+-----------------------------------+
| lvarchar                          | character data of varying length, |
|                                   | no larger than 2 kilobytes        |
+-----------------------------------+-----------------------------------+
| list                              | a collection of elements that can |
|                                   | be duplicate values and have      |
|                                   | ordered positions                 |
+-----------------------------------+-----------------------------------+
| multiset                          | a collection of elements that can |
|                                   | be duplicate values and have no   |
|                                   | ordered positions                 |
+-----------------------------------+-----------------------------------+
| opaque                            | user-defined data type            |
+-----------------------------------+-----------------------------------+
| row                               | complex data type with one or     |
|                                   | more members called fields        |
+-----------------------------------+-----------------------------------+
| serial8                           | 8-byte serial data type           |
+-----------------------------------+-----------------------------------+
| set                               | a collection of elements that are |
|                                   | unique values and have no ordered |
|                                   | positions                         |
+-----------------------------------+-----------------------------------+
| text                              | any kind of text data             |
+-----------------------------------+-----------------------------------+

------------------------------------------------------------------------

## [Compiling with fesqlc]{#compiling}

The **[fesqlc](Tools.html#TL_FESQLC)** [tool](Tools.html#TL_FESQLC)
compiles and links C programs that contain **Genero FESQLC** source code
files, creating an executable C program. An **FESQLC** source file must
be preprocessed before a C compiler can compile it. By default, your
**FESQLC** source files are passed to the **FESQLC**
[preprocessor](#preprocessor), and then to the C compiler. You can
choose to preprocess only.

### Usage:

[Options]{#options} can be used for preprocessing only, or for
preprocessing/compiling/linking. Options are global and affect all
files.

The **-V** (display version information) and **-h** (display help)
options do not require source file names:

> fesqlc -V
>     fesqlc -h

The **-e** option suppresses compiling and linking of the source file.
The file will be preprocessed by FESQLC and output as a C source code
file (*filename*.c).

> fesqlc -e mysource.ec

The **-c** option preprocesses the source file, and then compiles it to
object code (*filename*.o). By default the \'**cc**\'compiler is used on
Unix. You can modify the C compiler by setting the FGLCC environment
variable. On Windows, the default is \'**cl.exe**\'.

> fesqlc -c mysource.ec

Use the **-o** option to specify the output file name for the executable
file that is the result of preprocessing, compiling and linking.

> fesqlc -o myprog file1.ec

Use the option **-ED *name*** to define a global FESQLC macro. This has
the same effect as an FESQLC [define preprocessor directive](#define) at
the top of your program.

> fesqlc -ED CHECKED file2.ec

Use the option **-EU *name*** to un-define an FESQLC macro, removing it
globally from the entire program.

> fesqlc -EU CHECKED file2.ec

Use the **-D** and **-U** options only to define and un-define C macros
for your program.

### Example:

    fesqlc -o prog1 -ED DEBUG -I ./include file1.ec file2.ec file3.ec

In this example the executable output file will be named **prog1**, a
global macro named **DEBUG** is defined, the include path is specified
as **./include**.  Files to be processed include **file1.ec**,
**file2.ec** and **file3.ec**. 

### [Creating a C Extensions written in ESQL/C]{#CEXT}

In Genero V 2, runtime system C extensions must be created as shared
libraries. For more details, see [C Extensions](CExtensions.html).

Steps:

1.  Include the **fglExt.h** file to the **.ec** files implementing C
    functions called from Genero BDL.\
       `#include <f2c/fglExt.h>`
2.  Create the extension interface as described in [C Extensions: C
    interface file](CExtensions.html#CEXTFILE).
3.  Compile the extension interface to object files with you C compiler.
4.  Compile all the **.ec** sources to object files with **fesqlc**, by
    using the **-c** option.
5.  Create the shared library (OS specific command) from all the object
    files.\
    Warning: You must link with the **libfesqlc** and **libfgl**
    libraries provided in FGLDIR/lib.
6.  Declare the extension module in the 4gl source code by using the
    [IMPORT](Programs.html#IMPORT) instruction:\
       `IMPORT `*`extension`*\
       `MAIN`\
       `  ...`

#### [Example:]{#CEXT_EXAMPLE}

This example uses three sources:

- The ESQL/C module doing some SQL.
- The extension interface file defining the list of C extension
  functions.
- The Genero program connecting to the database and calling the C
  Extension function of the ESQL/C module.

<!-- -->

    -- The module.ec source ------------------------------------
    #include <f2c/fglExt.h>
    exec sql include sqlca;

    int insert_row(int c)
    {
       exec sql insert into dbit2 values (1, 'aaaa', 'bbbbb');
       return 0;
    }

    -- The myext.c source --------------------------------------

    #include "f2c/fglExt.h"

    int insert_row(int);

    UsrFunction usrFunctions[]={
      { "insert_row", insert_row, 0, 0 },
      { 0, 0, 0, 0 }
    };

    -- The prog.4gl source -------------------------------------

    IMPORT myext
    MAIN
       DATABASE stores
       CALL insert_row()
    END MAIN

First, we link the extension module. This creates the object file
(**module.o**):

    fesqlc -c module.ec

Then, create the shared library from the compiled object file, by using
the **libfesqlc** library:

Linux example:

    gcc -static-libgcc -Xlinker --no-undefined -shared \
       -o myext.so \
       module.o \
       -L$FGLDIR/lib -lfesqlc -lfgl

MS Visual C 7.1 example (you must create a manifest file starting from
VC 8.0):

    link /DLL /O:myext.dll \
       %FGLDIR%\lib\libfesqlc.lib %FGLDIR%\lib\libfgl.lib

You could also create the shared library directly from **fesqlc**, by
using the **-l** option:

    fesqlc -o myext.so \
       -l "gcc -static-libgcc -Xlinker --no-undefined -shared" \
       source1.ec source2.ec source3.ec source4.ec \
       extinterface.c

------------------------------------------------------------------------

## [Preprocessor Directives]{#preprocessor}

The **fesqlc** compiler supports FESQLC preprocessor directives. This
allows you to *include* other FESQLC files, *define macros* that can be
used later in the code and use *ifdef* conditional directives to compile
only some part of the code, as you can do with the C preprocessor (cpp):

> EXEC SQL include "myheader.h";
>     EXEC SQL define LEN 15;
>     EXEC SQL ifdef DEBUG;
>         ...
>     EXEC SQL endif;

#### Warning: FESQLC macros must end with a semi-colon, like all FESQLC statements.

### Standard C preprocessing

Standard C preprocessing takes effect [after]{.underline} FESQLC
preprocessing, during the C compilation step. In order to include system
header files such as **stdio.h**, you must use the standard C
**#include** directive. If C macros are defined, you must use standard C
**#ifdef** directives. FESQLC will ignore any C macro definitions during
the FESQLC preprocessing step.

### [Including files]{#include} - the include directive

The **include** directive allows you to include other files into your
FESQLC programs. You must use the FESQLC include directive if the file
contains embedded SQL statements or other FESQLC statements.

The file will be read into the program at the location of the include
directive. Use the keywords  **EXEC SQL** (preferred ANSI standard) or
the **\$** symbol to precede the directive. Specify the exact name,
including any extension, of the file:

> EXEC SQL include "def_constants.h";
>     EXEC SQL include "/prog/def_constants.h"; 

If the filename includes the path, you must enclose the filename in
quotationmarks. Otherwise, you may omit the quotation marks, but FESQLC
will convert the filename to lowercase. If you omit the path, FESQLC
will search the preprocessor path for the file.

To avoid the need for recompilation if a file location changes, omit the
path from the filename and use the **-I** [FESQLC compiler
option](#options) to specify the path:

> fesqlc -I ./myincludes prog1.ec

**Note:** Genero FESQLC automatically includes any header files that it
requires in order to preprocess your program. Use the standard C
#include directive to include C header files. The #include of C includes
a file after FESQLC preprocessing.

#### Warning: 

> For migration purposes, **include** statements for Informix ESQL/C
> header files are permitted, although they are not required and the
> FESQLC compiler will ignore them. However, if your program has such
> statements, you must use the EXEC SQL syntax. The following C syntax
> is not supported:
>
> > #include "sqlca.h"
>
> FESQLC will consider this a normal C header file to be included. The
> statement must be replaced by:
>
> > EXEC SQL include sqlca;

### [Creating FESQLC macros]{#define} - the define, undef directives

The FESQLC **define** directive allows you to create simple macros that
are available only to the FESQLC preprocessor. The FESQLC preprocessor,
rather than the C preprocessor, processes this directive.

Use the keywords **EXEC SQL** (preferred ANSI standard) or the **\$**
symbol to precede the directive:

> EXEC SQL define CHECKED;       -- macro without a value 
>     EXEC SQL define LEN 15;        -- macro with an integer value of 15
>     EXEC SQL define NAME "scott";  -- macro with a string value

The scope of the macro is from the location of the **define** directive
until the end of the file, or until the macro is removed. The FESQLC
**undef** directive allows you to remove the macro:

> EXEC SQL undef LEN;

You can use the FESQLC [compiler options](#options) **-ED** and **-EU**
to override these FESQLC macro definitions.

**Note:** C macros are defined and undefined using the #define and
#undef C preprocessor directives in your source code, or the -D and -U
FESQLC preprocessor options.

Macros can be used in conjunction with other **FESQLC** preprocessor
directives to control conditional processing of a file.

### [Compiling conditionally]{#conditional} - the  **ifdef,ifndef, endif, else, elif directives**

FESQLC provides directives to conditionally compile a program. The
directives test whether a macro has been created with an FESQLC [define
directive](#define) or the **-ED** FESQLC [compiler option](#options),
and then process the file accordingly.

- **ifdef** - instructs FESQLC to compile the statements that follow, if
  the specified macro is defined.
- **ifndef** - instructs FESQLC to compile the statements that follow,
  if the specified macro is [not]{.underline} defined.
- **endif** - indicates the close of an **ifdef** or **ifndef**
  condition.
- **else** - provides alternative processing instructions for an
  **ifdef** or **ifndef** condition.
- **elif** - is the same as \"else if define\", used to provide
  alternative processing instructions; instructs FESQLC to compile the
  statements that follow, if the specified macro has been defined.

Use the keywords  **EXEC SQL** (preferred ANSI standard) or the **\$**
symbol to precede the directive:

> EXEC SQL ifdef CHECKED;
>     EXEC SQL DELETE FROM cust_temp;  /* executed when CHECKED is defined */
>     EXEC SQL endif;
>
>     EXEC SQL ifdef CHECKED;
>     EXEC SQL DELETE FROM cust_temp;  
>     EXEC SQL else;  /* if CHECKED is not defined */
>     printf("no delete, CHECKED is not defined");
>     EXEC SQL endif;
>
>     EXEC SQL ifdef CHECKED;
>     EXEC SQL DELETE FROM cust_temp; 
>     EXEC SQL elif PROBLEMS;  /* if CHECKED not defined and PROBLEMS defined */
>     printf("no delete, PROBLEMS is defined");
>     EXEC SQL endif; 

**Note:** There is no equivalent to the \"if\" C directive in FESQLC;
the preprocessor supports only the **ifdef** and **ifndef** statements
that test for the existence of a macro.

#### Example:

If your program uses both FESQLC macros and C macros, you can combine
the -D and -ED preprocessor options in the same command line. The
following lines in the FESQLC program **prog.ec** has two blocks of
preprocessing directives. The first block uses FESQLC syntax and the
second block uses the standard C syntax:

> EXEC SQL ifdef CHECKED;
>     printf("CHECKED is defined");
>     EXEC SQL else; 
>     printf("CHECKED is not defined"); 
>     EXEC SQL endif;
>
>     #ifdef MAXLEN
>     printf("MAXLEN is defined"); 
>     #else
>     printf("MAXLEN is not defined"); 
>     #endif

If you combine FESQLC **-ED** and **-D** command line options like this:

    fesqlc -ED CHECKED -D MAXLEN prog.ec

FESQLC will create the FESQLC macro CHECKED, and will create the C macro
MAXLEN.

When the program is run, the following lines would be executed:

> printf("CHECKED is defined");
>     printf("MAXLEN is defined");

------------------------------------------------------------------------

## [Handling Exceptions]{#exceptions}

Unless you explicitly include exception-handling code in your FESQLC
application, the program continues when an SQL error occurs.
Uncontrolled SQL errors may cause your program to have unexpected
behavior.

Suggested exception-handling strategies are:

- Check after each SQL statement by testing the value of
  [SQLSTATE](#sqlstate) (or [SQLCODE](#sqlcode)).
- Use the [WHENEVER](#whenever) statement to specify the action to be
  taken when an SQL statement is not successful.
- Use [GET DIAGNOSTICS](#diagnostics) to obtain additional information
  about any exceptions.

### [Using SQLSTATE]{#sqlstate}

#### Warning: Using SQLSTATE is the preferred ANSI method of checking for exceptions. However, not all database servers do support SQLSTATE. You must check the database server documentation to verify if SQLSTATE is supported.

This global variable defined by FESQLC returns the status of the SQL
statement most recently executed.  The status can be:

- Success
- Success, but no rows found
- Success, but warnings generated
- Failure, runtime error generated

FESQLC automatically copies the status information from the [diagnostics
area](#diagnostics) into the SQLSTATE global variable; you do not have
to define the variable, and it is accessible anywhere in your program.

SQLSTATE can contain only digits and capital letters. The first two
characters of the five-character SQLSTATE string indicate the class of
the execution code; the remaining characters provide additional
information. Check the first two characters to determine whether the
most recently executed SQL statement was successful:

::: {align="left"}
  --------------------------- -----------------------------------------------------------
  **Class (first 2 chars)**   **Description**
  00                          SQL statement was successful
  01                          SQL statement was successful, with warnings
  02                          SELECT or FETCH statement resulted in NOT FOUND condition
  \>02                        SQL statement resulted in a runtime error
  --------------------------- -----------------------------------------------------------
:::

The following code checks SQLSTATE for the NOT FOUND case:

> if (strncmp(SQLSTATE, "02", 2) == 0) {
>       break;
>     }

If an SQL error occurred, you can get specific information from the
other three characters of SQLSTATE. The characters 0 to 4 and A to H are
used for the SQLSTATE class codes in ANSI and X/OPEN standard
implementations:

  ----------------------- ----------------------- -----------------------
  **First two\            **Remaining\            **   Description**
  characters**            characters**            

  00                      000                     SQL statement was
                                                  successful

  01                      000                     SQL statement was
                                                  successful, with
                                                  warnings:

  01                      002                     Warning: Disconnect
                                                  error, transaction
                                                  rolled back

  01                      003                     Warning: Null value
                                                  eliminated in set
                                                  function

  01                      004                     Warning: String data
                                                  right truncated

  01                      005                     Insufficient item
                                                  descriptor areas

  01                      006                     Privilege not revoked

  02                      000                     SELECT or FETCH
                                                  statement resulted in
                                                  NOT FOUND condition

  \>02                                            SQL statement resulted
                                                  in a runtime error

  0A                      000                     Feature not supported.

  0A                      001                     Multiple database
                                                  server transactions

  21                      000                     Cardinality violation

  22                      000                     Data exception

  22                      001                     String data, right
                                                  truncation

  22                      002                     Null value, no
                                                  indicator parameter

  22                      003                     Numeric value out of
                                                  range

  22                      012                     Division by zero

  22                      024                     Un-terminated string

  23                      000                     Integrity-constraint
                                                  violation

  24                      000                     Invalid cursor state

  2B                      000                     Dependent privilege
                                                  descriptors still exist

  2D                      000                     Invalid transaction
                                                  termination

  2E                      000                     Invalid connection name

  33                      000                     Invalid SQL descriptor
                                                  name

  34                      000                     Invalid cursor name

  3C                      000                     Duplicate cursor name

  40                      000                     Transaction rollback

  40                      003                     Statement completion
                                                  unknown

  42                      000                     Syntax error or access
                                                  violation
  ----------------------- ----------------------- -----------------------

Check your database server documentation for additional server-specific
implementations of SQLSTATE codes.

### [Using SQLCODE]{#sqlcode}

SQLCODE is a global variable defined by FESQLC to determine the success
of the most recently executed SQL statement.

SQLCODE holds the Informix SQL error code. Using [SQLSTATE](#sqlstate)
is the preferred method; SQLCODE is provided for backwards
compatibility.

The database server returns information about the execution of an SQL
statement to the SQL Communications Area (sqlca) C structure. FESQLC
copies the value of the sqlca.sqlcode field to the SQLCODE global
variable. Your program can check the value in the SQLCODE variable for
the following information:

  -------------- -------------------------------------------------------------------------------------------------------
  **   Value**   ** Description**
  0              SQL statement was successful
  100            SELECT or FETCH statement resulted in NOT FOUND condition
  \<0            SQL statement resulted in a runtime error. The number specifies the particular Informix error number.
  -------------- -------------------------------------------------------------------------------------------------------

#### Native SQL error codes

If an SQL error occurs, the database server specific error code is
available in **sqlca.sqlerrd\[1\]**.

#### Warnings

If a warning was generated by the SQL statement, sqlca.sqlwarn.sqlwarn0
is set to \"W\". To test for warnings, check the first warning field. If
this indicates the database server has generated a warning, you can
check the values of the other fields in **sqlca.sqlwarn** to identify
the specific condition.

See your database server documentation for additional information about
specific errors reported in SQLCODE, and the sqlca structure.

### [Using WHENEVER]{#whenever}

Your program can use the WHENEVER statement to trap exceptions that
occur during the execution of SQL statements, and to specify the action
to be taken when a specific class of error occurs:

    WHENEVER <exception class> <exception action>

Exception classes:

- SQLERROR - exception occurs when an SQL statement has failed.
- SQLWARNING -  exception occurs when an SQL statement has generated a
  warning.
- NOT FOUND - exception occurs when the NOTFOUND condition is returned
  by an SQL statement.

Using WHENEVER SQLERROR statements allows your program to react to
errors and warnings, in the same way as checking the SQLSTATE or SQLCODE
variables. 

Actions to be taken:

- CONTINUE - the program ignores the exception and continues with the
  next instruction in the program. **This is the default**.
- STOP - the program stops executing immediately when an exception
  occurs.
- CALL *\<function name\>*- the specified function in the program  is
  called if an exception occurs.
- GOTO *\<label\>* - control is transferred to the program code
  identified by the specified label. The program code specified by GOTO
  *\<label\>* must be included in every program block that contains SQL
  statements, or another WHENEVER statement in that program block must
  re-set the condition.

Examples:

    WHENEVER SQLERROR STOP;
    EXEC SQL CONNECT TO mydb;
    ...

    WHENEVER SQLERROR GOTO error_handling_code;
    EXEC SQL DELETE FROM orderstab WHERE cust_num = "101";
    ...

The default action is CONTINUE if no WHENEVER condition is set. The
actions for the exception classes can be set independently.

### [The GET DIAGNOSTICS statement]{#diagnostics}

The diagnostics area is an internal structure that the database server
updates after the execution of each SQL statement.  The GET DIAGNOSTICS
statement can provide additional information about the most recently
executed SQL statement.

Statement fields return overall information about the most recently
executed SQL statement. For example, you can determine the number of
exceptions generated by an SQL statement, indicating whether you need to
seek additional information.

### Syntax:

> EXEC SQL GET DIAGNOSTICS :host-variable = field-name [,...] ;

The keywords for the statement fields of the diagnostic area, and the
data types of the returned information, are:

::: {align="left"}
  ----------------- ------------------------------------------- ----------------- -----------------
  **Field name**    **Data type**                               **Information\    **  
                                                                 type**           Description**

  NUMBER            [mint]{style="background-color: #FFFFFF"}   Statement         Number of
                                                                                  exceptions
                                                                                  generated.  Even
                                                                                  a successful
                                                                                  execution will
                                                                                  generate one
                                                                                  exception.

  MORE              char\[2\]                                   Statement         Contains Y or N
                                                                                  plus a null
                                                                                  terminator; Y
                                                                                  indicates that
                                                                                  the diagnostics
                                                                                  area contains all
                                                                                  the exceptions
                                                                                  information. N
                                                                                  indicates that
                                                                                  there is more
                                                                                  information than
                                                                                  the database
                                                                                  server can store
                                                                                  in the
                                                                                  diagnostics area.

  ROWCOUNT          mint                                        Statement         Number of rows
                                                                                  that a successful
                                                                                  SELECT, UPDATE,
                                                                                  or DELETE
                                                                                  statement has
                                                                                  affected.
                                                                                  ROWCOUNT for a
                                                                                  SELECT statement
                                                                                  is undefined.
  ----------------- ------------------------------------------- ----------------- -----------------
:::

 

GET DIAGNOSTICS can return multiple exceptions; each exception that is
generated has a number.  Exception number 1 is the exception generated
by the last SQL statement executed in your program. No set order exists
for any additional exceptions that are generated. To get information
about a particular exception, use the following syntax:

> EXEC SQL GET DIAGNOSTICS EXCEPTION exception-number
>                   :host-variable = field-name [,...] ;

Some of the keywords for the exception fields associated with a specific
exception, and the data types of the information, are:

  ------------------- --------------------------------------------------- ----------------- -----------------
  **Field name**      **Data type**                                       **Information\    **Description**
                                                                           type**           

  RETURNED_SQLSTATE   char\[6\]                                           Exception         Status of the
                                                                                            exception. FESQLC
                                                                                            automatically
                                                                                            copies the
                                                                                            information from
                                                                                            this field for
                                                                                            exception 1 to
                                                                                            the SQLSTATE
                                                                                            global variable.

  INFORMIX_SQLCODE    int4                                                Exception         Contents of
                                                                                            sqlca.sqlcode;
                                                                                            FESQLC
                                                                                            automatically
                                                                                            copies the
                                                                                            information from
                                                                                            this field to the
                                                                                            SQLCODE global
                                                                                            variable.

  MESSAGE_TEXT        [char\[8191\]]{style="background-color: #FFFFFF"}   Exception         Variable length
                                                                                            character string
                                                                                            that describes
                                                                                            the exception.

  MESSAGE_LENGTH      mint                                                Exception         Number of
                                                                                            characters that
                                                                                            are in the
                                                                                            message stored in
                                                                                            MESSAGE_TEXT.

  SERVER_NAME         char\[255\]                                         Exception         Variable length
                                                                                            character string
                                                                                            holding the name
                                                                                            of the database
                                                                                            server used in
                                                                                            the most recent
                                                                                            connection
                                                                                            statement; will
                                                                                            be blank if there
                                                                                            is no server
                                                                                            connected.

  CONNECTION_NAME     char\[255\]                                         Exception         Variable length
                                                                                            character string
                                                                                            holding the name
                                                                                            of the connection
                                                                                            associated with
                                                                                            the most recent
                                                                                            connection
                                                                                            statement; will
                                                                                            be blank if there
                                                                                            is no current
                                                                                            connection.
  ------------------- --------------------------------------------------- ----------------- -----------------

See the SQL documentation for your database server for additional
information about exception fields in the diagnostics area.

To return information about your SQL statement and any exceptions to
your program:

First, declare a host variable in your program to contain the name of
the field in the diagnostics area that you want to access:

> EXEC SQL BEGIN DECLARE SECTION;
>       mint numrows;
>       mint numerr;
>       char messagetext[8191];
>       mint messagelength; 
>     EXEC SQL END DECLARE SECTION;

To get statement information after the SQL statement has executed,
specify the diagnostics area field name. For example, to get the number
of rows updated, inserted, or deleted by the SQL statement, and the
number of exceptions generated:

> EXEC SQL DELETE FROM orders WHERE store_num = 111;
>     EXEC SQL GET DIAGNOSTICS :numrows = ROWCOUNT, :numerr = NUMBER;

Use the exception clause to get information about a specific exception
generated by your SQL statement. Exception 1 is the exception associated
with the last SQL statement executed.

> EXEC SQL GET DIAGNOSTICS EXCEPTION 1 :messagetext = MESSAGE_TEXT;

You do not have to use GET DIAGNOSTICS to check the RETURNED_SQLSTATE
and INFORMIX_SQLCODE fields for exception 1, since FESQLC copies the
values from those fields to the [SQLSTATE](#sqlstate) and
[SQLCODE](#sqlcode) global variables.

**Note**: The GET DIAGNOSTICS statement does not change the contents of
the diagnostics area.

------------------------------------------------------------------------

## [Migration Notes]{#migration}

- [Including Informix  ESQL/C header files](#headerfiles)
- [Using C-style macros for ESQL/C host variables](#Cmacros)
- [Using char and varchar pointers](#charpointers)
- [Database and database object names](#dbnames)
- [Decimal host variables](#decimals)
- [Literal constants in USING clause](#literalconstants)
- [Comment indicator](#commentind)
- [Features not supported](#notsuppfeatures)

### [Including Informix ESQL/C header files]{#headerfiles}

For migration purposes, include statements for Informix ESQL/C header
files are permitted, although they are not required and the FESQLC
compiler will ignore them. However, if your program has such statements,
you must use the EXEC SQL syntax. The following C syntax is not
supported:

> #include "sqlca.h"

FESQLC will consider this a normal C header file to be included. The
statement must be replaced by:

> EXEC SQL include sqlca;

### [Using C-style macros for ESQL/C host variables]{#Cmacros}

Old Informix ESQL/C compilers allowed you to use C-style macros in the
declaration of host variables:

> #define MAXLEN 15
>
>     $char myvar[MAXLEN];

This is not standard ESQL/C programming. Recent Informix ESQL/C
compilers raise a warning in such a case:\
\
Warning -33208: Runtime error is possible because size of \'myvar\' is
unknown.

FESQLC does not support the usage of C-style macros in SQL host
variables declarations. You must use ESQL/C macros instead:

> EXEC SQL define MAXLEN 15;
>
>     $char myvar[MAXLEN];

Existing code using C-style macros may use the C macro in normal C
variable declarations. Is such a case you can define the macro twice:
Once for the C variables and once for the ESQL/C host variables:

> #define MAXLEN 15
>     EXEC SQL define MAXLEN 15;
>
>     char myvar1[MAXLEN];
>     $char myvar2[MAXLEN];

This solution is valid ESQL/C programming. It works with both Informix
ESQL/C and Genero FESQLC compilers.

### [Using **char** and **varchar** pointers]{#charpointers}

Normally you use char/varchar arrays to hold SQL CHAR or VARCHAR data:

> $char cn[101];
>     $SELECT cust_name INTO $cn FROM customer ... ;

Informix ESQL/C also supports char/varchar pointers, but the length of
the C variable is unknown.

> $char *cn;
>     $SELECT cust_name INTO $cn FROM customer ... ;

The char/varchar pointers are typically used for function parameters:

> int func(p1, p2)
>     EXEC SQL BEGIN DECLARE SECTION;
>     int p1;
>     char *p2;
>     EXEC SQL BEGIN DECLARE SECTION;
>     {
>     EXEC SQL INSERT INTO tab VALUES ( :p1, :p2 );
>     }

or as constants:

> $const char *blank = " ";
>     $const char *undef = "Undefined value";

Database APIs must know the size of the SQL char/varchar type
corresponding to the host variable, to check for overflow. (For example,
you cannot insert a CHAR(100) value into a CHAR(9) in Oracle).

Char and varchar pointers can be used as input parameters in SQL
statements, but the FESQLC API computes the size with an strlen() of the
current value pointed by sqlvar-\>sqldata.

It is strongly recommended that you use a fixed size of char and
varchars. If you MUST use a char/varchar pointer, use an sqlda structure
and specify the exact size of the corresponding CHAR/VARCHAR SQL type in
sqlvar-\>sqllen.\
\
Host variables defined as char or varchar pointers cannot be used to
fetch data:

> $char *c;
>     $varchar *v;
>     $select c1, c2 into :c, :v from t;

### **[Database and database object names]{#dbnames}**

**EXEC SQL DATABASE** supports only a simple database name; for
portability the Informix database specification ***dbname*@*server*** is
not supported.

The database prefix in a table name specification
(***dbname*:*tabname***) is not supported, for portability.

Using SQL keywords as database object names is not supported.

### [Decimal host variables]{#decimals0}

**Decimal host variables** must be declared with precision and scale if
you want to use a database other than Informix:

> $decimal(6,2) mydec;

In an **sqlda** structure, **sqlvar** elements defining a DECIMAL value
must have the **sqllen** member initialized with the decimal dimension
(i.e., PRECMAKE(precision,scale). This is different from Informix
ESQL/C, where **sqllen** has the size of the **dec_t** structure for
input parameters.

### [Literal constants in USING clause]{#literalconstants}

**Literal constants** are not allowed in a USING clause:

> OPEN cursor USING 123, "abc" 

You must always use host variables.

### [Comment Indicator]{#commentind}

The double hyphen (\--) comment identifier is permitted within an SQL
statement only. 

> $SELECT * -- all columns        compiles successfully
>         FROM tab;
>     $SELECT * FROM tab;
>         -- all columns              will not compile

### [Features Not Supported]{#notsuppfeatures}

- **DESCRIBE INTO sqlda** is not yet supported.
- System descriptors (**ALLOCATE DESCRIPTOR**, etc) are not yet
  supported.
- **INT8** and **SERIAL8** data types are not yet supported.
- **CLOB/BLOB** data types are not yet supported.
- **Multi-byte** character sets are not yet supported.
- **Opaque** and **LVARCHAR** data types will not be supported.
- Server communication functions (**sqlbreak sqlexit)** are not
  supported.
- **GLS** library functions will not be supported.
- **Collections** will not be supported.

------------------------------------------------------------------------

## [Example program]{#Exampleprogram}

``` linenumber
01 #include <stdio.h>
02
03 EXEC SQL define NAME_LEN 20;  /* customer.store_name is a CHAR(20) */
04 EXEC SQL define ADDR_LEN 20;  /* customer.addr is a CHAR(20)       */
05
06 void errlog(void)
07 {
08  fprintf(stderr, "Error occurred:\n");
09  fprintf(stderr, "  SQLSTATE = [%s]  SQLCODE = %d\n\n",
10                  SQLSTATE, SQLCODE);
11  EXEC SQL DISCONNECT ALL;
12  exit(1);
13 }
14
15 int main()
16 {
17  EXEC SQL BEGIN DECLARE SECTION;
18    int  p_num;
19    varchar p_name[ NAME_LEN + 1 ];
20    int2 i_name;
21    varchar p_addr[ ADDR_LEN + 1 ];
22    int2 i_addr;
23    varchar p_addr2[ ADDR_LEN + 1 ];
24    int2 i_addr2;
25    char p_state[3]; 
26  EXEC SQL END DECLARE SECTION;
27
28  EXEC SQL WHENEVER ERROR CALL errlog; /* set error handling */
29
30  printf( "Connecting...\n\n");
31  EXEC SQL CONNECT TO 'custdemo';
32
33  EXEC SQL DECLARE c1 CURSOR FOR
34    SELECT store_num, store_name, addr, addr2
35      FROM customer
36      WHERE state = :p_state;
37
38  strcpy(p_state, "IL");
39  EXEC SQL OPEN c1;
40
41  for (;;)
42  {
43
44   EXEC SQL FETCH c1 INTO :p_num,
45                           :p_name INDICATOR :i_name,
46                           :p_addr INDICATOR :i_addr,
47                           :p_addr2 INDICATOR :i_addr2;
48
49   if (strncmp(SQLSTATE, "02", 2) == 0) {
50        /* No more rows */
51        break;
52   }
53
54   printf("%6d %-20s\n      %s %s\n",
55            p_num,
56            i_name == 0 ? p_name : "<no name>",
57            i_addr == 0 ? p_addr : "<no address>",
58            i_addr2 == 0 ? p_addr2 : ""
59   );
60  }
61
62  EXEC SQL CLOSE c1;
63  EXEC SQL FREE c1;
64
65  printf("\nDisconnecting...\n\n");
66  EXEC SQL DISCONNECT CURRENT;
67
68  return 0;
69 }
```

------------------------------------------------------------------------
