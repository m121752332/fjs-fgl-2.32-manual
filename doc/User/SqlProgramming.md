[Back to Contents](../index.html)

------------------------------------------------------------------------

# SQL Programming

Summary:

- [1. Programming](#PROG)
  - [1.1 Database utility library](#PROG_DBUTIL)
  - [1.2 Implicit database connection](#PROG_IMPLCONN)
  - [1.3 Managing transaction commands](#PROG_MNGTX)
  - [1.4 Executing stored procedures](#PROG_STOPROC)
    - [Stored procedure call with Informix](#SP_IFX)
    - [Stored procedure call with Genero db](#SP_GDB)
    - [Stored procedure call with Oracle](#SP_ORA)
    - [Stored procedure call with DB2](#SP_DB2)
    - [Stored procedure call with Microsoft SQL Server](#SP_MSV)
    - [Stored procedure call with PostgreSQL](#SP_PGS)
    - [Stored procedure call with MySQL](#SP_MYS)
    - [Stored procedure call with Sybase ASE](#SP_ASE)
  - [1.5 Cursors and Connections](#PROG_ERRIDENT)
  - [1.6 SQL Error identification](#PROG_ERRIDENT)
  - [1.7 Optimizing scrollable cursors](#PROG_SCROLL_CURSORS)
- [2. Performance](#PERF)
  - [2.1 Using dynamic SQL](#PERF_DYNSQL)
  - [2.2 Using transactions](#PERF_USINGTX)
  - [2.3 Avoiding long transactions](#PERF_LONGTRAN)
  - [2.4 Declaring prepared statements](#PERF_DECLPREP)
  - [2.5 Saving SQL resources](#PERF_SAVERES)
- [3. Portability](#PORT)
  - [3.1 Database entities](#PORT_DBENT)
  - [3.2 Database users and security](#PORT_DBUSR)
  - [3.3 Database creation statements](#PORT_DCS)
  - [3.4 Data definition statements](#PORT_DDS)
  - [3.5 Using portable data types](#PORT_DATATYPES)
  - [3.6 Data manipulation statements](#PORT_DML)
  - [3.7 CHAR and VARCHAR types](#PORT_CHARVARCHAR)
  - [3.8 Concurrent data access](#PORT_DATACCESS)
  - [3.9 The SQLCA register](#PORT_SQLCA)
  - [3.10 Optimistic locking](#PORT_OPTLOCK)
  - [3.11 Auto-incremented columns (serials)](#PORT_AUTOINC)
  - [3.12 Informix SQL ANSI mode](#PORT_IFXANSI)
  - [3.13 Positioned Updates/Deletes](#PORT_POSUD)
  - [3.14 WITH HOLD and FOR UPDATE](#PORT_WHFU)
  - [3.15 String literals in SQL statements](#PORT_STRINGLIT)
  - [3.16 Date and time literals in SQL statements](#PORT_DATETIMELIT)
  - [3.17 Naming database objects](#PORT_NAMOBJ)
  - [3.18 Temporary tables](#PORT_TEMPTABS)
  - [3.19 Outer joins](#PORT_OUTERJOINS)
  - [3.20 Sub-string expressions](#PORT_SUBSTR)
  - [3.21 Using ROWIDs](#PORT_ROWIDS)
  - [3.22 MATCHES operator](#PORT_MATCHES)
  - [3.23 GROUP BY clause](#PORT_GROUPBY)
  - [3.24 LENGTH() function](#PORT_LENGTH)
  - [3.25 SQL Interruption](#SQL_INTERRUPTION)

*See also:* [Connections](Connections.html),
[Transactions](Transactions.html), [Static SQL](StaticSql.html),
[Dynamic SQL](DynamicSql.html), [Result Sets](ResultSets.html), [SQL
Errors](Exceptions.html#SQLERRORS), [Programs](Programs.html).

------------------------------------------------------------------------

## 1. [Programming]{#PROG}

------------------------------------------------------------------------

### 1,1 [Database utility library]{#PROG_DBUTIL}

The BDL library \"**fgldbutl.4gl**\" provides several utility functions.
For example, this library implements a function to get the type of the
database engine at runtime. You will find this library in the
**FGLDIR/src** directory. See the source file for more details.

------------------------------------------------------------------------

### 1.2 [Implicit database connection]{#PROG_IMPLCONN}

In BDL, the [DATABASE](Connections.html#DC_DATABASE) statement can be
used in two distinct ways, depending on the context of the statement
within its source module :

- To specify a default database : Typically used in a
  \"[GLOBALS](Globals.html)\" module, to define variables with the
  [LIKE](Variables.html#DEFINITION) clause, but it is also used for the
  [INITIALIZE](Variables.html#VA_INITIALIZE) and
  [VALIDATE](Variables.html#VA_VALIDATE) statements. Using the DATABASE
  statement in this way results in that database being opened
  automatically at run time.
- To specify a current database : In [MAIN](Programs.html#MAIN_BLOCK) or
  in a [FUNCTION](Functions.html#DEFINITION), used to connect to a
  database. A variable can be used in this context ( DATABASE *varname*
  ).

A default database is almost always used, because many BDL applications
contain [DEFINE \... LIKE](Variables.html#DEFINITION) statements. A
problem occurs when the production database name differs from the
development database name, because the default database specification
will result in an automatic connection (just after
[MAIN](Programs.html#MAIN_BLOCK)):

``` linenumber
01 DATABASE stock_dev
02 DEFINE
03    p_cust RECORD LIKE customer.*
04 MAIN
05    DEFINE dbname CHAR(30)
06    LET dbname = "stock1"
07    DATABASE dbname
08 END MAIN
```

In order to avoid the implicit connection, you can use the
[SCHEMA](Programs.html#DB_SCHEMA) instruction instead of
[DATABASE](Connections.html#DC_DATABASE):

``` linenumber
01 SCHEMA stock_dev
02 DEFINE
03    p_cust RECORD LIKE customer.*
04 MAIN
05    DEFINE dbname CHAR(30)
06    LET dbname = "stock1"
07    DATABASE dbname
08 END MAIN
```

This instruction will define the database schema for compilation only,
and will not make an implicit connection at runtime.

------------------------------------------------------------------------

### 1.3 [Managing transaction commands]{#PROG_MNGTX}

A BDL program can become very complex if a lot of nested functions do
SQL processing. When using a database supporting
[transactions](Transactions.html#DBTRANS), you must sometimes execute
all SQL statements in the same transaction block. This can be done
easily by centralizing transaction control commands in wrapper
functions.

The **fgldbutl.4gl** library contains special functions to manage the
beginning and the end of a transaction with an internal counter, in
order to implement nested function calls inside a unique transaction.

Example:

``` linenumber
01 MAIN
02     IF a() <> 0 THEN
03        ERROR "..."
04     END IF
05     IF b() <> 0 THEN
06        ERROR "..."
07     END IF
08 END MAIN
09
10 FUNCTION a()
11   DEFINE s INTEGER
12   LET s = db_start_transaction( )
13   UPDATE ...
14   LET s = SQLCA.SQLCODE
15   IF s = 0 THEN
16      LET s = b( )
17   END IF
18   LET s = db_finish_transaction((s==0))
19   RETURN s
20 END FUNCTION
21
22 FUNCTION b()
23    DEFINE s INTEGER
24    LET s = db_start_transaction( )
25    UPDATE ...
26    LET s = SQLCA.SQLCODE
27    LET s = db_finish_transaction((s==0))
28    RETURN s
29 END FUNCTION
```

In this example, you see in the [MAIN](Programs.html) block that both
functions a() and b() can be called separately. However, the
[transaction](Transactions.html#DBTRANS) SQL commands will be used only
if needed: When function a() is called, it starts the transaction, then
calls b(), which does not start the transaction since it was already
started by a(). When function b() is called directly, it starts the
transaction.

The function `db_finish_transaction()` is called with the expression
`(s==0)`, which is evaluated before the call. This allows you to write
in one line the equivalent of the following `IF` statement:

``` linenumber
01 IF s==0 THEN
02    LET s = db_finish_transaction(1)
03 ELSE
04    LET s = db_finish_transaction(0)
05 END IF
```

------------------------------------------------------------------------

### 1.4 [Executing stored procedures]{#PROG_STOPROC}

#### Specifying output parameters

With Genero BDL you can specify [OUTPUT
parameters](DynamicSql.html#DS_EXECUTE) to get values from stored
procedures. While this new feature is generic, stored procedures
execution needs to be addressed specifically according to the database
type. There are different ways to execute a stored procedure. This
section describes how to execute stored procedures on the supported
database engines.

**Tip:** In order to write reusable code, you should encapsulate each
stored procedure execution in a [program function](Functions.html)
performing database-specific SQL based on a global database type
variable. The program function would just take the input parameters and
return the output parameters of the stored procedure, hiding
database-specific execution steps from the caller.

#### Stored procedures returning a result set

With some database servers it is possible to execute stored procedures
that produce a result set, and fetch the rows as normal `SELECT`
statements, by using `DECLARE`, `OPEN`, `FETCH`. Some databases can
return multiple result sets and cursor handles declared in a stored
procedure as output parameters, but Genero supports only unique and
anonymous result sets. See below for examples.

#### Calling stored procedures with supported databases

- [Stored procedure call with Informix](#SP_IFX)
- [Stored procedure call with Genero db](#SP_GDB)
- [Stored procedure call with Oracle](#SP_ORA)
- [Stored procedure call with DB2 UDB](#SP_DB2)
- [Stored procedure call with SQL Server](#SP_MSV)
- [Stored procedure call with PostgreSQL](#SP_PGS)
- [Stored procedure call with MySQL](#SP_MYS)

------------------------------------------------------------------------

### [Stored procedure call with Informix]{#SP_IFX}

Informix stored procedures are written in the SPL, C or Java programming
languages, also known as User Defined Routines.\
See Informix IDS documentation for more details.

#### Stored functions returning values

The traditional way to return values from an Informix SPL routine is to
fetch the output values, as from a regular SELECT producing a result
set.

You must define a *stored function* with a `RETURNING` clause. Informix
*stored procedures* do not return values.

To execute a stored function with Informix, you must use the
`EXECUTE FUNCTION` SQL instruction:

``` linenumber
14    PREPARE stmt FROM "execute function proc1(?)"
```

In order to retrieve returning values into program variables, you must
use an `INTO` clause in the [EXECUTE](DynamicSql.html#DS_EXECUTE)
instruction.

The following example shows how to call a stored function with Informix:

``` linenumber
01 MAIN
02    DEFINE n INTEGER
03    DEFINE d DECIMAL(6,2)
04    DEFINE c VARCHAR(200)
05    DATABASE test1
06    EXECUTE IMMEDIATE "create function proc1( p1 integer )"
07                 || " returning decimal(6,2), varchar(200);"
08                 || "  define p2 decimal(6,2);"
09                 || "  define p3 varchar(200);"
10                 || "  let p2 = p1 + 0.23;"
11                 || "  let p3 = 'Value = ' || p1;"
12                 || "  return p2, p3;"
13                 || " end function;"
14    PREPARE stmt FROM "execute function proc1(?)"
15    LET n = 111
16    EXECUTE stmt USING n INTO d, c
17    DISPLAY d
18    DISPLAY c
19 END MAIN
```

#### Stored functions defined with output parameters

Starting with IDS 10.00, Informix introduced the concept of output
parameters for stored procedures, like other database vendors.

To retrieve the output parameters, you must execute the routine in a
SELECT statement defining [Statement Locale Variables]{.underline}.
These variables will be listed in the SELECT clause to be fetched as
regular column values.\
See Informix documentation for more details.

In order to retrieve returning values into program variables, you must
use an `INTO` clause in the [EXECUTE](DynamicSql.html#DS_EXECUTE)
instruction.

The next example shows how to call a stored procedure with output
parameters in Informix:

``` linenumber
01 MAIN
02     DEFINE pi, pr INT
03     DATABASE test1
04     EXECUTE IMMEDIATE "create function proc2(i INT, OUT r INT)"
05                     ||" returning int;"
06                     ||" let r=i+10;"
07                     ||" return 1;"
08                     ||" end function"
09     PREPARE s FROM "select r from systables where tabid=1 and proc1(?,r#int)==1"
10     LET pi = 33
11     EXECUTE s USING pi INTO pr
12     DISPLAY "Output value: ", pr
13     EXECUTE IMMEDIATE "drop function proc2"
14 END MAIN
```

------------------------------------------------------------------------

### [Stored procedure call with Genero db]{#SP_GDB}

Genero db implements *stored procedures* as a group of statements that
you can call by name. A subset of RDBMS-specific languages are supported
by Genero db; you can write Genero db stored procedures in Informix SPL,
Oracle PL/SQL or SQL Server Transact-SQL.

#### Stored procedures with output parameters

Genero db *stored procedures* must be called with the input and output
parameters specification in the `USING` clause of the
[EXECUTE](DynamicSql.html#DS_EXECUTE), [OPEN](ResultSets.html#RS_OPEN)
or [FOREACH](ResultSets.html#RS_FOREACH) instruction. As in normal
dynamic SQL, parameters must correspond by position, and the
`IN/OUT/INOUT` options must match the parameter definition of the stored
procedure.

To execute the stored procedure, you must use the `CALL` SQL
instruction:

``` linenumber
11   PREPARE stmt FROM "call proc1(?,?,?)"
```

Here is a complete example creating and calling a stored procedure:

``` linenumber
01 MAIN
02    DEFINE n INTEGER
03    DEFINE d DECIMAL(6,2)
04    DEFINE c VARCHAR(200)
05    DATABASE test1
06    EXECUTE IMMEDIATE "create procedure proc1( p1 in int, p2 out number(6,2), p3 in out varchar2 )"
07                 || " is begin"
08                 || "  p2 := p1 + 0.23;"
09                 || "  p3 := 'Value = ' || p1;"
10                 || "end;"
11    PREPARE stmt FROM "call proc1(?,?,?)"
12    LET n = 111
13    EXECUTE stmt USING n IN, d OUT, c INOUT
14    DISPLAY d
15    DISPLAY c
16 END MAIN
```

#### Stored procedures producing a result set

With Genero db, you can execute stored procedures returning a result
set. To do so, you must declare a cursor and fetch the rows:

``` linenumber
01 MAIN
02    DEFINE i, n INTEGER
03    DEFINE d DECIMAL(6,2)
04    DEFINE c VARCHAR(200)
05    DATABASE test1
06    CREATE TABLE tab1 ( c1 INTEGER, c2 DECIMAL(6,2), c3 VARCHAR(200) )
07    INSERT INTO tab1 VALUES ( 1, 123.45, 'aaaaaa' )
08    INSERT INTO tab1 VALUES ( 2, 123.66, 'bbbbbbbbb' )
09    INSERT INTO tab1 VALUES ( 3, 444.77, 'cccccc' )
10    EXECUTE IMMEDIATE "create procedure proc2 @key integer"
11                 || " as begin"
12                 || "    select * from tab1 where c1 > @key"
13                 || "  end"
14    DECLARE curs CURSOR FROM "call proc2(?)"
15    LET i = 1
16    FOREACH curs USING i INTO n, d, c
17        DISPLAY n, d, c
18    END FOREACH
19 END MAIN
```

#### Stored procedures with output parameters and result set

It is possible to execute Genero db stored procedures with output
parameters and a result set. The output parameter values are available
after the [OPEN](ResultSets.html#RS_OPEN) cursor instruction:

``` linenumber
01    OPEN curs USING n IN, d OUT, c INOUT
02    FETCH curs INTO rec.*
```

------------------------------------------------------------------------

### [Stored procedure call with Oracle]{#SP_ORA}

Oracle supports *stored procedures* and *stored functions* as a group of
PL/SQL statements that you can call by name. Oracle *stored functions*
are very similar to *stored procedures*, except that a function returns
a value to the environment in which it is called. Functions can be used
in SQL expressions.  

#### Stored procedures with output parameters

Oracle *stored procedures* or *stored functions* must be called with the
input and output parameters specification in the `USING` clause of the
[EXECUTE](DynamicSql.html#DS_EXECUTE), [OPEN](ResultSets.html#RS_OPEN)
or [FOREACH](ResultSets.html#RS_FOREACH) instruction. As in normal
dynamic SQL, parameters must correspond by position, and the
`IN/OUT/INOUT` options must match the parameter definition of the stored
procedure.

To execute the *stored procedure*, you must include the procedure in an
anonymous PL/SQL block with `BEGIN` and `END` keywords:

``` linenumber
11   PREPARE stmt FROM "begin proc1(?,?,?); end;"
```

Remark: Oracle stored procedures do not specify the size of number and
character parameters. The size of output values (especially character
strings) are defined by the calling context (i.e. the data type of the
variable used when calling the procedure). When you pass a CHAR(10) to
the procedure, the returning value will be filled with blanks to reach a
size of 10 bytes.

**Warning: For technical reasons, the Oracle driver uses dynamic binding
with OCIBindDynamic(). The Oracle Call Interface does not support stored
procedures parameters with the CHAR data type when using dynamic
binding. You must use VARCHAR2 instead of CHAR to define character
string parameters for stored procedures.**

Here is a complete example creating and calling a stored procedure with
output parameters:

``` linenumber
01 MAIN
02    DEFINE n INTEGER
03    DEFINE d DECIMAL(6,2)
04    DEFINE c VARCHAR(200)
05    DATABASE test1
06    EXECUTE IMMEDIATE "create procedure proc1( p1 in int, p2 in out number, p3 in out varchar2 )"
07                 || " is begin"
08                 || "  p2 := p1 + 0.23;"
09                 || "  p3 := 'Value = ' || to_char(p1);"
10                 || "end;"
11    PREPARE stmt FROM "begin proc1(?,?,?); end;"
12    LET n = 111
13    EXECUTE stmt USING n IN, d INOUT, c INOUT
14    DISPLAY d
15    DISPLAY c
16 END MAIN
```

#### Stored functions with a return value

To execute the *stored function* returning a value, you must include the
function in an anonymous PL/SQL block with `BEGIN` and `END` keywords,
and use an assignment expression to specify the place holder for the
returning value:

``` linenumber
11    PREPARE stmt FROM "begin ? := func1(?,?,?); end;"
```

#### Stored procedures producing a result set

Oracle supports result set generation from stored procedures with the
concept of cursor variables (`REF CURSOR`).

**Warning: Genero does not support cursor references produced by Oracle
stored procedures or functions.**

------------------------------------------------------------------------

### [Stored procedure call with IBM DB2]{#SP_DB2}

IBM DB2 implements *stored procedures* as a saved collection of SQL
statements, which can accept and return user-supplied parameters. IBM
DB2 *stored procedures* can also produce one or more result sets. Beside
*stored procedures*, IBM DB2 supports *user defined functions*,
typically used to define scalar functions returning a simple value which
can be part of SQL expressions.

#### Stored procedures with output parameters

IBM DB2 *stored procedures* must be called with the input and output
parameters specification in the `USING` clause of the
[EXECUTE](DynamicSql.html#DS_EXECUTE), [OPEN](ResultSets.html#RS_OPEN)
or [FOREACH](ResultSets.html#RS_FOREACH) instruction. As in normal
dynamic SQL, parameters must correspond by position and the
`IN/OUT/INOUT` options must match the parameter definition of the stored
procedure.

To execute the stored procedure, you must use the `CALL` SQL
instruction:

``` linenumber
11    PREPARE stmt FROM "call proc1(?,?,?)"
```

Here is a complete example creating and calling a stored procedure with
output parameters:

``` linenumber
01 MAIN
02    DEFINE n INTEGER
03    DEFINE d DECIMAL(6,2)
04    DEFINE c VARCHAR(200)
05    DATABASE test1
06    EXECUTE IMMEDIATE "create procedure proc1( in p1 int, out p2 decimal(6,2), inout p3 varchar(20) )"
07                 || " language sql begin"
08                 || "  set p2 = p1 + 0.23;"
09                 || "  set p3 = 'Value = ' || char(p1);"
10                 || "end"
11    PREPARE stmt FROM "call proc1(?,?,?)"
12    LET n = 111
13    EXECUTE stmt USING n IN, d OUT, c INOUT
14    DISPLAY d
15    DISPLAY c
16 END MAIN
```

#### Stored procedures producing a result set

With DB2 UDB, you can execute stored procedures returning a result set.
To do so, you must declare a cursor and fetch the rows:

``` linenumber
01 MAIN
02    DEFINE i, n INTEGER
03    DEFINE d DECIMAL(6,2)
04    DEFINE c VARCHAR(200)
05    DATABASE test1
06    CREATE TABLE tab1 ( c1 INTEGER, c2 DECIMAL(6,2), c3 VARCHAR(200) )
07    INSERT INTO tab1 VALUES ( 1, 123.45, 'aaaaaa' )
08    INSERT INTO tab1 VALUES ( 2, 123.66, 'bbbbbbbbb' )
09    INSERT INTO tab1 VALUES ( 3, 444.77, 'cccccc' )
10    EXECUTE IMMEDIATE "create procedure proc2( in key integer )"
11                 || " result sets 1"
12                 || " language sql"
13                 || "  begin"
14                 || "  declare c1 cursor with return for"
15                 || "    select * from tab1 where c1 > key;"
16                 || "  open c1;"
17                 || "  end"
18    DECLARE curs CURSOR FROM "call proc2(?)"
19    LET i = 1
20    FOREACH curs USING i INTO n, d, c
21        DISPLAY n, d, c
22    END FOREACH
23 END MAIN
```

#### Stored procedures with output parameters and result set

It is possible to execute DB2 UDB stored procedures with output
parameters and a result set. The output parameter values are available
after the [OPEN](ResultSets.html#RS_OPEN) cursor instruction:

``` linenumber
01    OPEN curs USING n IN, d OUT, c INOUT
02    FETCH curs INTO rec.*
```

------------------------------------------------------------------------

### [Stored procedure call with Microsoft SQL Server]{#SP_MSV}

SQL Server implements *stored procedures*, which are a saved collection
of Transact-SQL statements that can take and return user-supplied
parameters. SQL Server *stored procedures* can also produce one or more
result sets.

#### Stored procedures with output parameters

SQL Server *stored procedures* must be called with the input and output
parameters specification in the `USING` clause of the
[EXECUTE](DynamicSql.html#DS_EXECUTE), [OPEN](ResultSets.html#RS_OPEN)
or [FOREACH](ResultSets.html#RS_FOREACH) instruction. As in normal
dynamic SQL, parameters must correspond by position and the
`IN/OUT/INOUT` options must match the parameter definition of the stored
procedure.

To execute the stored procedure, you must use an ODBC `call` escape
sequence:

        PREPARE stmt FROM "{ call proc1(?,?,?) }"

Here is a complete example creating and calling a stored procedure with
output parameters:

``` linenumber
01 MAIN
02    DEFINE n INTEGER
03    DEFINE d DECIMAL(6,2)
04    DEFINE c VARCHAR(200)
05    DATABASE test1
06    EXECUTE IMMEDIATE "create procedure proc1 @v1 integer, @v2 decimal(6,2) output, @v3 varchar(20) output"
07                 || " as begin"
08                 || "  set @v2 = @v1 + 0.23"
09                 || "  set @v3 = 'Value = ' || cast(@v1 as varchar)"
10                 || "end"
11    PREPARE stmt FROM "{ call proc1(?,?,?) }"
12    LET n = 111
13    EXECUTE stmt USING n IN, d OUT, c OUT
14    DISPLAY d
15    DISPLAY c
16 END MAIN
```

#### Stored procedures producing a result set

With SQL Server, you can execute stored procedures returning a result
set. To do so, you must declare a cursor and fetch the rows.

**Warning: The following example uses a stored procedure with a simple
SELECT statement. If the stored procedure contains additional
Transat-SQL statements such as SET or IF (which is the case in complex
stored procedures), SQL Server generates multiple result sets. By
default the Genero MSV driver uses \"Server Cursors\" to support
multiple active SQL statements. But SQL Server stored procedures
generating multiple result sets cannot be used with Server Cursors: The
Server Cursor is silently converted to a \"Default Result Set\" cursor
by the ODBC driver. Since Default Result Set cursors do not support
multiple active statements, you cannot use another SQL statement while
processing the results of such stored procedure. You must CLOSE the
cursor created for the stored procedure before continuing with other SQL
statements.**

``` linenumber
01 MAIN
02    DEFINE i, n INTEGER
03    DEFINE d DECIMAL(6,2)
04    DEFINE c VARCHAR(200)
05    DATABASE test1
06    CREATE TABLE tab1 ( c1 INTEGER, c2 DECIMAL(6,2), c3 VARCHAR(200) )
07    INSERT INTO tab1 VALUES ( 1, 123.45, 'aaaaaa' )
08    INSERT INTO tab1 VALUES ( 2, 123.66, 'bbbbbbbbb' )
09    INSERT INTO tab1 VALUES ( 3, 444.77, 'cccccc' )
10    EXECUTE IMMEDIATE "create procedure proc2 @key integer"
11                 || "  as select * from tab1 where c1 > @key"
12    DECLARE curs CURSOR FROM "{ call proc2(?) }"
13    LET i = 1
14    FOREACH curs USING i INTO n, d, c
15        DISPLAY n, d, c
16    END FOREACH
17 END MAIN
```

**Warning: It is possible to fetch large objects (text/image) from
stored procedure generating a result set, however, if the stored
procedure executes other statements as the SELECT (like SET/IF
commands), the SQL Server ODBC driver will convert the server cursor to
a regular default result set cursor, requiring the LOB columns to appear
at the end of the SELECT list. Thus, in most cases (stored procedures
typically use SET / IF statements), you will have to move the LOB
columns and the end of the column list.**

#### Stored procedures returning a cursor as output parameter

SQL Server supports \"Cursor Output Parameters\": A stored procedure can
declare/open a cursor and return a reference of the cursor to the
caller.

**Warning: SQL Server stored procedures returning a cursor as output
parameter are not supported. There are two reasons for this: The Genero
language does not have a data type to store a server cursor reference,
and the underlying ODBC driver does not support this anyway.**

#### Stored procedures with return code

SQL Server stored procedures can return integer values. To get the
return value of a stored procedure, you must use an assignment
expression in the ODBC `call` escape sequence: 

``` linenumber
01    PREPARE stmt FROM "{ ? = call proc3(?,?,?) }" 
```

#### Stored procedures with output parameters, return code and result set

With SQL Server you can call stored procedures with a return code,
output parameters and producing a result set.

**Warning: Return codes and output parameters are the last items
returned to the application by SQL Server; they are not returned until
the last row of the result set has been fetched, after the
SQLMoreResults() ODBC function is called. If output parameters are used,
the SQL Server driver executes a SQLMoreResult() call when
[closing]{.underline} the cursor instead of SQLCloseCursor(), to get the
return code and output parameter values from SQL Server.**

``` linenumber
01 MAIN
02    DEFINE r, i, n INTEGER
03    DEFINE d DECIMAL(6,2)
04    DEFINE c VARCHAR(200)
05    DATABASE test1
06    CREATE TABLE tab1 ( c1 INTEGER, c2 DECIMAL(6,2), c3 VARCHAR(200) )
07    INSERT INTO tab1 VALUES ( 1, 123.45, 'aaaaaa' )
08    INSERT INTO tab1 VALUES ( 2, 123.66, 'bbbbbbbbb' )
09    INSERT INTO tab1 VALUES ( 3, 444.77, 'cccccc' )
10    EXECUTE IMMEDIATE "create procedure proc3 @key integer output"
11                 || "  as begin"
12                 || "     set @key = @key - 1"
13                 || "     select * from tab1 where c1 > @key"
14                 || "     return (@key * 3)"
15                 || "  end"
16    DECLARE curs CURSOR FROM "{ ? = call proc3(?) }"
17    LET i = 1
18    OPEN curs USING r INOUT, i INOUT
19    DISPLAY r, i
20    FETCH curs INTO n, d, c
21    FETCH curs INTO n, d, c
22    FETCH curs INTO n, d, c
23    DISPLAY r, i
24    CLOSE curs
25    DISPLAY r, i -- Now the returned values are available
26 END MAIN
```

**Warning: Return code and output parameter variables must be defined as
`INOUT` in the OPEN instruction.**

------------------------------------------------------------------------

### [Stored procedure call with PostgreSQL]{#SP_PGS}

PostgreSQL implements *stored functions* that can return values. If the
function returns more that one value, you must specify the returning
values as function parameters with the `OUT` keyword. If the function
returns a unique value, you can use the `RETURNS` clause.

**Warning: Pay attention to the function signature; PostgreSQL allows
function overloading. For example, func(int) and func(char) are two
different functions. To drop a function, you must specify the parameter
type to identify the function signature properly.**

#### Stored functions with output parameters

To execute a stored function with PostgreSQL, you must use
`SELECT * FROM function`, as shown in the next line:

``` linenumber
14    PREPARE stmt FROM "select * from proc1(?)"
```

In order to retrieve returning values into program variables, you must
use an `INTO` clause in the [EXECUTE](DynamicSql.html#DS_EXECUTE)
instruction.

The following example shows how to call a stored function with
PostgreSQL:

``` linenumber
01 MAIN
02    DEFINE n INTEGER
03    DEFINE d DECIMAL(6,2)
04    DEFINE c VARCHAR(200)
05    DATABASE test1
06    EXECUTE IMMEDIATE "create function proc1(p1 integer, out p2 numeric(6,2), out p3 varchar(200))"
08                 || " as $$"
09                 || "  begin"
10                 || "    p2 := p1 + 0.23;"
11                 || "    p3 := 'Value = ' || cast(p1 as text);"
12                 || "  end;"
13                 || " $$ language plpgsql"
14    PREPARE stmt FROM "select * from proc1(?)"
15    LET n = 111
16    EXECUTE stmt USING n INTO d, c
17    DISPLAY d
18    DISPLAY c
19 END MAIN
```

#### Stored functions producing a result set

With PostgreSQL, you can execute stored procedures returning a result
set. To do so, you must declare a cursor and fetch the rows:

``` linenumber
01 MAIN
02    DEFINE i, n INTEGER
03    DEFINE d DECIMAL(6,2)
04    DEFINE c VARCHAR(200)
05    DATABASE test1
06    CREATE TABLE tab1 ( c1 INTEGER, c2 DECIMAL(6,2), c3 VARCHAR(200) )
07    INSERT INTO tab1 VALUES ( 1, 123.45, 'aaaaaa' )
08    INSERT INTO tab1 VALUES ( 2, 123.66, 'bbbbbbbbb' )
09    INSERT INTO tab1 VALUES ( 3, 444.77, 'cccccc' )
10    EXECUTE IMMEDIATE "create function proc2(integer)"
11                 || " returns setof tab1"
12                 || " as $$"
13                 || "  select * from tab1 where c1 > $1;"
14                 || " $$ language sql"
15    DECLARE curs CURSOR FROM "select * from proc2(?)"
16    LET i = 1
17    FOREACH curs USING i INTO n, d, c
18        DISPLAY n, d, c
19    END FOREACH
20 END MAIN
```

#### Stored functions with output parameters and result set

**Warning: With PostgreSQL you cannot return output parameters and a
result set from the same stored procedure; both use the same technique
to return values to the client, in the context of result columns to be
fetched.**

------------------------------------------------------------------------

### [Stored procedure call with MySQL]{#SP_MYS}

MySQL implements *stored procedures* and *stored functions* as a
collection of SQL statements that can take and return user-supplied
parameters. Functions are very similar to procedures, except that they
return a scalar value and can be used in SQL expressions.

#### Stored procedures with output parameters

**Warning: Since MySQL C API (version 5.0) does not support an output
parameter specification, the IN / OUT / INOUT technique cannot be
used.**

In order to return values from a MySQL *stored procedure* or *stored
function*, you must use SQL variables. There are three steps to execute
the procedure or function:

1.  With the `SET` SQL statement, create and assign an SQL variables for
    each parameter.
2.  `CALL` the stored procedure or stored function with the created SQL
    variables.
3.  Perform a `SELECT` statement to return the SQL variables to the
    application.

In order to retrieve returning values into program variables, you must
use an `INTO` clause in the [EXECUTE](DynamicSql.html#DS_EXECUTE)
instruction.

The following example shows how to call a stored procedure with output
parameters:

**Warning: MySQL version 5.0 does not allow you to prepare the CREATE
PROCEDURE statement; you may need to execute this statement from the
mysql command line tool.**

**Warning: MySQL version 5.0 cannot execute \"SELECT \@variable\" with
server-side cursors. Since the Genero MySQL driver uses server-side
cursors to support multiple active result sets, it is not possible to
execute the SELECT statement to return output parameter values. **

**Warning: MySQL version \>=5.0 evaluates \"@variable\" user variables
assigned with a string as large *text* (CLOB) expressions. That type of
values must normally be fetched into TEXT variable in BDL. To workaround
this behavior, you can use the substring(@var,1,255) function to return
a VARCHAR() expression from MySQL and fetch into a VARCHAR() BDL
variable.**

``` linenumber
01 MAIN
02    DEFINE n INTEGER
03    DEFINE d DECIMAL(6,2)
04    DEFINE c VARCHAR(200)
05    DATABASE test1
06    EXECUTE IMMEDIATE "create procedure proc1(p1 integer, out p2 numeric(6,2), out p3 varchar(200))"
07                 || " no sql begin"
08                 || "    set p2 = p1 + 0.23;"
09                 || "    set p3 = concat( 'Value = ', p1 );"
10                 || "  end;"
11    LET n = 111
12    EXECUTE IMMEDIATE "set @p1 = ", n
13    EXECUTE IMMEDIATE "set @p2 = NULL"
14    EXECUTE IMMEDIATE "set @p3 = NULL"
15    EXECUTE IMMEDIATE "call proc1(@p1, @p2, @p3)"
16    PREPARE stmt FROM "select @p2, substring(@p3,1,200)"
17    EXECUTE stmt INTO d, c
18    DISPLAY d
19    DISPLAY c
20 END MAIN
```

#### Stored functions returning values

The following example shows how to retrieve the return value of a stored
function with MySQL:

**Warning: MySQL version 5.0 does not allow you to prepare the CREATE
FUNCTION statement; you may need to execute this statement from the
mysql command line tool.**

``` linenumber
01 MAIN
02    DEFINE n INTEGER
03    DEFINE c VARCHAR(200)
04    DATABASE test1
05    EXECUTE IMMEDIATE "create function func1(p1 integer)"
06                 || " no sql begin"
07                 || "    return concat( 'Value = ', p1 );"
08                 || "  end;"
09    PREPARE stmt FROM "select func1(?)"
10    LET n = 111
11    EXECUTE stmt USING n INTO c
12    DISPLAY c
13 END MAIN
```

#### Stored procedures producing a result set

**Warning: The MySQL version 5.0 stored procedures and stored functions
cannot return a result set.**

------------------------------------------------------------------------

### [Stored procedure call with Sybase ASE]{#SP_ASE}

Sybase ASE supports *stored procedures*, which can take and return
user-supplied parameters. Sybase ASE *stored procedures* can also
produce one or more result sets.

#### Stored procedures with output parameters

Sybase ASE *stored procedures* must be called with the input and output
parameters specification in the `USING` clause of the
[EXECUTE](DynamicSql.html#DS_EXECUTE), [OPEN](ResultSets.html#RS_OPEN)
or [FOREACH](ResultSets.html#RS_FOREACH) instruction. As in normal
dynamic SQL, parameters must correspond by position and the
`IN/OUT/INOUT` options must match the parameter definition of the stored
procedure.

To execute the stored procedure, you must use a specific syntax to have
the ODI driver identify the statement as an RPC call. The syntax of an
RPC call must be:

    `!rpc procedure-name ( [ @param-name [,...] ] )`

The parameter names must be specified, with the same names as the
arguments of the stored procedure, because the ODI driver must bind
stored procedure parameters by name.

Example:

        PREPARE stmt FROM "!rpc update_account ( @custid, @old, @new )"

Here is a complete example creating and calling a stored procedure with
output parameters:

``` linenumber
01 MAIN
02    DEFINE n INTEGER
03    DEFINE d DECIMAL(6,2)
04    DEFINE c VARCHAR(200)
05    DATABASE test1
06    EXECUTE IMMEDIATE "create procedure proc1 @v1 integer, @v2 decimal(6,2) output, @v3 varchar(20) output"
07                 || " as begin"
08                 || "  set @v2 = @v1 + 0.23"
09                 || "  set @v3 = 'Value = ' || cast(@v1 as varchar)"
10                 || "end"
11    PREPARE stmt FROM "!rpc proc1( @v1, @v2, @v3 ) }"
12    LET n = 111
13    EXECUTE stmt USING n IN, d OUT, c OUT
14    DISPLAY d
15    DISPLAY c
16 END MAIN
```

#### Stored procedures producing a result set

With Sybase, you can execute stored procedures returning a result set.
To do so, you must declare a cursor and fetch the rows.

**Warning: When the stored procedure generates multiple active
statements, you cannot use another SQL statement while processing the
results of such stored procedure. You must CLOSE the cursor created for
the stored procedure before continuing with other SQL statements.**

``` linenumber
01 MAIN
02    DEFINE i, n INTEGER
03    DEFINE d DECIMAL(6,2)
04    DEFINE c VARCHAR(200)
05    DATABASE test1
06    CREATE TABLE tab1 ( c1 INTEGER, c2 DECIMAL(6,2), c3 VARCHAR(200) )
07    INSERT INTO tab1 VALUES ( 1, 123.45, 'aaaaaa' )
08    INSERT INTO tab1 VALUES ( 2, 123.66, 'bbbbbbbbb' )
09    INSERT INTO tab1 VALUES ( 3, 444.77, 'cccccc' )
10    EXECUTE IMMEDIATE "create procedure proc2 @key integer"
11                 || "  as select * from tab1 where c1 > @key"
12    DECLARE curs CURSOR FROM "!rpc proc2( @key ) }"
13    LET i = 1
14    FOREACH curs USING i INTO n, d, c
15        DISPLAY n, d, c
16    END FOREACH
17 END MAIN
```

#### Stored procedures with output parameters, return code and result set

With Sybase ASE stored procedures, you call stored procedures with a
return code, output parameters and producing a result set.

**Warning: Return codes and output parameters are the last items
returned to the application by Sybase; they are not returned until the
last row of the result set has been fetched.**

``` linenumber
01 MAIN
02    DEFINE r, i, n INTEGER
03    DEFINE d DECIMAL(6,2)
04    DEFINE c VARCHAR(200)
05    DATABASE test1
06    CREATE TABLE tab1 ( c1 INTEGER, c2 DECIMAL(6,2), c3 VARCHAR(200) )
07    INSERT INTO tab1 VALUES ( 1, 123.45, 'aaaaaa' )
08    INSERT INTO tab1 VALUES ( 2, 123.66, 'bbbbbbbbb' )
09    INSERT INTO tab1 VALUES ( 3, 444.77, 'cccccc' )
10    EXECUTE IMMEDIATE "create procedure proc3 @key integer output"
11                 || "  as begin"
12                 || "     set @key = @key - 1"
13                 || "     select * from tab1 where c1 > @key"
14                 || "     return (@key * 3)"
15                 || "  end"
16    DECLARE curs CURSOR FROM "!rpc proc3( @key ) }"
17    LET i = 1
18    OPEN curs USING r OUT, i OUT
19    DISPLAY r, i
20    FETCH curs INTO n, d, c
21    FETCH curs INTO n, d, c
22    FETCH curs INTO n, d, c
23    DISPLAY r, i
24    CLOSE curs
25    DISPLAY r, i -- Now the returned values are available
26 END MAIN
```

------------------------------------------------------------------------

### [1.5 Cursors and Connections]{#PROG_CURSCONN}

With Genero you can connect to several database sources from the same
program by using the [CONNECT](Connections.html#DC_CONNECT_TO)
instruction. When connected, you can [DECLARE](ResultSets.html) cursors
or [PREPARE](DynamicSql.html) statements, which can be used in parallel
as long as you follow the rules. This section describes how to use SQL
cursors and SQL statements in a multiple-connection program.

For convenience, the term *Prepared SQL Statement* and *Declared Cursor*
will be grouped as *SQL handle;* from an internal point of view, both
concepts merge into a unique *SQL Handle,* an object provided to
manipulate SQL statements.

When you `DECLARE` a cursor or when you `PREPARE` a statement, you
actually create an *SQL Handle*; the runtime system allocates resources
for that SQL Handle before sending the SQL text to the database server
via the [database driver](Connections.html#DBSPEC).

The SQL Handle is created in the context of the current connection, and
must be used in that context, until it is freed or re-created with
another `DECLARE` or `PREPARE`. If you try to use an SQL Handle in a
different connection context than the one for which it was created, you
will get a runtime error.

To change the current connection context, you must use the [SET
CONNECTION](Connections.html#DC_SET_CONNECTION) instruction. To set a
specific connection, you must identify it by a name. To identify a
connection, you typically use the `AS` clause of the
[CONNECT](Connections.html#DC_CONNECT_TO) instruction. If you don\'t use
the `AS` clause, the connection gets a default name based on the data
source name. Since this might change as the database name changes, it is
best to use an explicit name with the `AS` clause.

This small program example illustrates the use of two cursors with two
different connections:

``` linenumber
01 MAIN
02    CONNECT TO "db1" AS "s1"
03    CONNECT TO "db2" AS "s2"
04    SET CONNECTION "s1"
05    DECLARE c1 CURSOR FOR SELECT tab1.* FROM tab1
06    SET CONNECTION "s2"
07    DECLARE c2 CURSOR FOR SELECT tab1.* FROM tab1
08    SET CONNECTION "s1"
09    OPEN c1
10    SET CONNECTION "s2"
11    OPEN c2
12    ...
13 END MAIN
```

The `DECLARE` and `PREPARE` instructions are a type of creator
instructions; if an SQL Handle is re-created in a connection other than
the original connection for which it was created, old resources are
freed and new resources are allocated in the current connection context.

This allows you to re-execute the same cursor code in different
connection contexts, as in the following example:

``` linenumber
01 MAIN
02    CONNECT TO "db1" AS "s1"
03    CONNECT TO "db2" AS "s2"
04    SET CONNECTION "s1"
05    IF checkForOrders() > 0 ...
06    SET CONNECTION "s2"
05    IF checkForOrders() > 0 ...
08    ...
09 END MAIN
10
11 FUNCTION checkForOrders(d)
12    DEFINE d DATE, i INTEGER
13    DECLARE c1 CURSOR FOR SELECT COUNT(*) FROM orders WHERE ord_date = d
14    OPEN c1
15    FETCH c1 INTO i
16    CLOSE c1
17    FREE c1
18    RETURN i
19 END FUNCTION
```

If the SQL handle was created in a different connection, the resources
used in the old connection context are freed automatically, and new SQL
Handle resources are allocated in the current connection context.

------------------------------------------------------------------------

### [1.6 SQL Error identification]{#PROG_ERRIDENT}

You can centralize SQL error identification in a BDL function:

``` linenumber
01 CONSTANT SQLERR_FATAL = -1 
02 CONSTANT SQLERR_LOCK  = -2 
03 CONSTANT SQLERR_CONN  = -3 
```

(constants must be defined in GLOBALS)

``` linenumber
04 FUNCTION identifySqlError() 
05    CASE 
06      WHEN SQLCA.SQLCODE == -201 OR SQLCA.SQLERRD[2] == ... 
07         RETURN SQLERR_FATAL 
08      WHEN SQLCA.SQLCODE == -263 OR SQLCA.SQLCODE == -244 OR SQLCA.SQLERRD[2] == ... 
09         RETURN SQLERR_LOCK 
10      ... 
11    END CASE 
12 END FUNCTION
```

- The Informix-compatible error code is stored in SQLCA.SQLCODE
  register.
- The native Database Provider error code is stored in
  SQLCA.SQLERRD\[2\] register.

If really needed, this would also allow adding a database specific test.

See also: [SQL error registers](Connections.html#ERRORINFO).

------------------------------------------------------------------------

### [1.7 Optimizing scrollable cursors]{#PROG_SCROLL_CURSORS}

Generally, when using [scrollable cursors](ResultSets.html#RS_DECLARE),
the database server or the database client software (i.e. the
application) will make a static copy of the result set produced by the
`SELECT` statement. For example, when using an Informix database engine,
each scrollable cursor will create a temporary table to hold the result
set. Thus, if the `SELECT` statement returns all columns of the table(s)
in the `FROM` clause, the database software will make a copy of all
these values. This practice has two disadvantages: A lot of resources
are consumed, and the data is static.

A good programming pattern to save resources and always get fresh data
from the database server is to declare two cursors based on the primary
key usage, if the underlying database table has a primary key (or unique
index constraint): The first cursor must be a scrollable cursor that
executes the `SELECT` statement, but returns only the primary keys. The
`SELECT` statement of this first cursor is typically assembled at
runtime with the where-part produced by a [CONSTRUCT](Construct.html)
interactive instruction, to give a sub-set of the rows stored in the
database. The second cursor (actually, a `PREPARE`/`EXECUTE` statement
handle) performs a single-row `SELECT` statement listing all columns to
be fetched for a given record, based on the primary key value of the
current row in the scrollable cursor list. The second statement must use
a ? question mark place holder to execute the single-row `SELECT` with
the current primary key as SQL parameter.

If the primary key `SELECT` statement needs to be ordered, check that
the database engine allows that columns used in the `ORDER BY` clause do
not need to appear in the `SELECT` list. For example, this was the case
with Informix servers prior to version 9.4. If needed, the `SELECT` list
can be completed with the columns used in `ORDER BY`, you can then just
list the variable that holds the primary key in the `INTO` clause of
`FETCH`.

Note also that the primary key result set is [static]{.underline}. That
is, if new rows are inserted in the database or if rows referenced by
the scroll cursor are deleted after the scroll cursor was opened, the
result set will be out-dated. In this case, you can refresh the primary
key result set by re-executing the scroll cursor with `CLOSE`/`OPEN`
commands.

Next code example illustrates this programming pattern:

``` linenumber
01 MAIN
02    DEFINE wp VARCHAR(500)
03    DATABASE test1
04    -- OPEN FORM / DISPLAY FORM with c_id and c_name fields
05    ...
06    -- CONSTRUCT generates wp string...
07    ...
08    LET wp = "c_name LIKE 'J%'"
09    DECLARE clist SCROLL CURSOR FROM "SELECT c_id FROM customer WHERE " || wp
10    PREPARE crec FROM "SELECT * FROM customer WHERE c_id = ?"
11    OPEN clist
12    MENU "Test"
13         COMMAND "First"    CALL disp_cust("F")
14         COMMAND "Next"     CALL disp_cust("N")
15         COMMAND "Previous" CALL disp_cust("P")
16         COMMAND "Last"     CALL disp_cust("L")
17         COMMAND "Refresh"  CLOSE clist OPEN clist
18         COMMAND "Quit" EXIT MENU
19    END MENU
20    FREE crec
21    FREE clist
22 
23 END MAIN
24
25 FUNCTION disp_cust(m)
26    DEFINE m CHAR(1)
27    DEFINE rec RECORD
28           c_id INTEGER,
29           c_name VARCHAR(50)
30       END RECORD
31    CASE m
32        WHEN "F" FETCH FIRST clist INTO rec.c_id
33        WHEN "N" FETCH NEXT clist INTO rec.c_id
34        WHEN "P" FETCH PREVIOUS clist INTO rec.c_id
35        WHEN "L" FETCH LAST clist INTO rec.c_id
36    END CASE
37    INITIALIZE rec.* TO NULL
38    IF SQLCA.SQLCODE == NOTFOUND THEN
39       ERROR "You reached to top or bottom of the result set."
40    ELSE
41       EXECUTE crec USING rec.c_id INTO rec.*
42       IF SQLCA.SQLCODE == NOTFOUND THEN
43          ERROR "Row was not found in the database, refresh the result set."
44       END IF
45    END IF
46    DISPLAY BY NAME rec.*
47 END FUNCTION
```

------------------------------------------------------------------------

## [2. Performance]{#PERF}

------------------------------------------------------------------------

### [2.1 Using Dynamic SQL]{#PERF_DYNSQL}

Although BDL allows you to write SQL statements directly in the program
source as a part of the language ([Static SQL](StaticSql.html)), it is
strongly recommended that you use [Dynamic SQL](DynamicSql.html) instead
when you are executing SQL statements within large program loops. 
Dynamic SQL allows you to [PREPARE](DynamicSql.html#DS_PREPARE) the SQL
statements once and [EXECUTE](DynamicSql.html#DS_EXECUTE) N times,
improving performance.

To perform Static SQL statement execution, the database interface must
use the basic API functions provided by the database vendor. These are
usually equivalent to the ` PREPARE` and ` EXECUTE` instructions. So
when you write a Static SQL statement in your BDL program, it is
actually converted to a ` PREPARE` + `EXECUTE`.

For example, the following BDL code:

``` linenumber
01 FOR n=1 TO 100
02    INSERT INTO tab VALUES ( n, c )
03 END FOR
```

is actually equivalent to:

``` linenumber
01 FOR n=1 TO 100
02    PREPARE s FROM "INSERT INTO tab VALUES ( ?, ? )"
03    EXECUTE s USING n, c
04 END FOR
```

To improve the performance of the preceding code,  use a
[PREPARE](DynamicSql.html#DS_PREPARE) instruction before the loop and
put an [EXECUTE](DynamicSql.html#DS_EXECUTE)  instruction inside the
loop:

``` linenumber
01 PREPARE s FROM "INSERT INTO tab VALUES ( ?, ? )"
02 FOR n=1 TO 100
03    EXECUTE s USING n, c
04 END FOR
```

------------------------------------------------------------------------

### [2.2 Using transactions]{#PERF_USINGTX}

When you use an ANSI compliant RDBMS like **Oracle** or **DB2**, the
database interface must perform a COMMIT after each statement execution.
This generates unnecessary database operations and can slow down big
loops. To avoid this implicit COMMIT, you can control the transaction
with [BEGIN WORK](Transactions.html#TI_BEGIN_WORK) / [COMMIT
WORK](Transactions.html#TI_COMMIT_WORK) around the code containing a lot
of SQL statement execution.

For example, the following loop will generate 2000 basic SQL operations
( 1000 INSERTs plus 1000 COMMITs ):

``` linenumber
01 PREPARE s FROM "INSERT INTO tab VALUES ( ?, ? )"
01 FOR n=1 TO 100
03    EXECUTE s USING n, c   -- Generates implicit COMMIT
04 END FOR
```

You can improve performance if you put a transaction block around the
loop:

``` linenumber
01 PREPARE s FROM "INSERT INTO tab VALUES ( ?, ? )"
02 BEGIN WORK
03 FOR n=1 TO 100
04    EXECUTE s USING n, c   -- In transaction -> no implicit COMMIT
05 END FOR
06 COMMIT WORK
```

With this code, only 1001 basic SQL operations will be executed ( 1000
INSERTs plus 1 COMMIT ).

However, you must take care when generating large
[transactions](Transactions.html#DBTRANS) because all modifications are
registered in transaction logs. This can result in a lack of database
server resources (INFORMIX \"transaction too long\" error, for example)
when the number of operations is very big.  If the SQL operation does
not require a unique transaction for database consistency reasons, you
can split the operation into several transactions, as in the following
example:

``` linenumber
01 PREPARE s FROM "INSERT INTO tab VALUES ( ?, ? )"
02 BEGIN WORK
03 FOR n=1 TO 100
04    IF n MOD 10 == 0 THEN
05       COMMIT WORK
06       BEGIN WORK
07    END IF
08    EXECUTE s USING n, c   -- In transaction -> no implicit COMMIT
09 END FOR
10 COMMIT WORK
```

------------------------------------------------------------------------

### 2.3 [Avoiding long transactions]{#PERF_LONGTRAN}

Some BDL applications do not care about long transactions because they
use an Informix database without transaction logging (transactions are
not stored in log files for potential rollbacks). However, if a failure
occurs, no rollback can be made, and only some of  the rows of a query
might be updated. This could result in data inconsistency !

With many providers (Genero db, SQL Server, IBM DB2, Oracle...), using
transactions is mandatory. Every database modification is stored in a
log file.

BDL applications must prevent long transactions when connected to a
database using logging. If a table holds hundreds of thousands of rows,
a \"DELETE FROM table\", for example,  might cause problems. If the
transaction log is full, no other insert, update or delete could be made
on the database. The activity could be stopped until a backup or
truncation of the log !

For example, if a table holds hundreds of thousands of rows, a \"DELETE
FROM table\" might produce a \"snapshot too old\" error in ORACLE if the
rollback segments are too small.

#### Solution :

You must review the program logic in order to avoid long transactions:

- keep transactions as short as possible.
- access the least amount of data possible while in a transaction. If
  possible, avoid using a big SELECT in transaction.
- split a long transaction into many short transactions. Use a loop to
  handle each block (see the last example below : [2.2 Using
  transactions](#PERF_USINGTX)).
- to delete all rows from a table use the \"TRUNCATE TABLE\" instruction
  instead of \"DELETE FROM\" (Not for all vendors)

In the end, increase the size of the transaction log to avoid it filling
up.

------------------------------------------------------------------------

### 2.4 [Declaring prepared statements]{#PERF_DECLPREP}

Line 2 of the following example shows a cursor declared with a prepared
statement: 

``` linenumber
01 PREPARE s FROM "SELECT * FROM table WHERE ", condition
02 DECLARE c CURSOR FOR s
```

While this has no performance impact with Informix database drivers, it
can become a bottleneck when using non-Informix databases:

Statement preparation consumes a lot of  memory and processor resources.
Declaring a cursor with a prepared statement is a native Informix
feature, which does consume only one real statement preparation. But
non-Informix databases do not support this feature. So the statement is
prepared twice (once for the PREPARE, and once for the DECLARE). When
used in a big loop, such code can cause performance problems.

To optimize such code, you can use the FROM clause in the
[DECLARE](ResultSets.html#RS_DECLARE) statement:

``` linenumber
01 DECLARE c CURSOR FROM "SELECT * FROM table WHERE " || condition
```

By using this solution only one statement preparation will be done by
the database server.

Remark: This performance problem does not appear with
[DECLARE](ResultSets.html#RS_DECLARE) statements using static SQL.

------------------------------------------------------------------------

### [ 2.5 Saving SQL resources]{#PERF_SAVERES}

To write efficient SQL in a Genero program, you should use [Dynamic
SQL](DynamicSql.html) as described in [2.1](#PERF_DYNSQL) of this
performance section. However, when using Dynamic SQL, you allocate an
SQL statement handle on the client and server side, consuming resources.
According to the database type, this can be a few bytes or a significant
amount of memory. For example, on a Linux 32b platform, a prepared
statement costs about 5 Kbytes with an Informix CSDK 2.80 client, while
it costs about 20 Kbytes with an Oracle 10g client. That can be a lot of
memory if you have programs declaring a dozen or more cursors,
multiplied by hundreds of user processes. When executing several [Static
SQL](StaticSql.html) statements, the same statement handle is reused and
thus less memory is needed.

Genero allows you to use either Static or Dynamic SQL, so it\'s in your
hands to choose memory or performance. However, in some cases the same
code will be used by different kinds of programs, needing either low
resource usage or good performance. In many OLTP applications you can
actually distinguish two type of programs:

- Programs where memory usage is not a problem but needing good
  performance (typically, batch programs executed as a unique instance
  during the night).
- Programs where performance is less important but where memory usage
  must be limited (typically, interactive programs executed as multiple
  instances for each application user).

To reuse the same code for interactive programs and batch programs, you
can do the following:

1.  Define a local module variable as an indicator for the prepared
    statement.
2.  Write a function returning the type of program (for example,
    \'interactive\' or \'batch\' mode).
3.  Then, in a reusable function using SQL statements, you prepare and
    free the statement according to the indicators, as shown in the next
    example.

``` linenumber
01 DEFINE up_prepared INTEGER
02
03 FUNCTION getUserPermissions( username )
04   DEFINE username VARCHAR(20)
05   DEFINE cre, upd, del CHAR(1)
06
07   IF NOT up_prepared THEN
08      PREPARE up_stmt FROM "SELECT can_create, can_update, cab_delete"
09                        || " FROM user_perms WHERE name = ?"
10      LET up_prepared = TRUE
11   END IF
12
13   EXECUTE up_stmt USING username INTO cre, upd, del
14
15   IF isInteractive() THEN
16      FREE up_stmt
17      LET up_prepared = FALSE
18   END IF
19
20   RETURN cre, upd, del
21
22 END FUNCTION
```

The first time this function is called, the `up_prepared` value will be
[FALSE](Programs.html#PC_FALSE), so the statement will be prepared in
line 08. The next time the function is called, the statement will be
re-prepared only if `up_prepared` is [TRUE](Programs.html#PC_TRUE). The
statement is executed in line 13 and values are fetch into the variables
returned in line 20. If the program is interactive, lines 15 to 18 free
the statement and set the `up_prepared` module variable back to
[FALSE](Programs.html#PC_FALSE), forcing statement preparation in the
next call of this function.

------------------------------------------------------------------------

## 3. [Portability]{#PORT}

Writing portable SQL is mandatory if you want to succeed with different
kind of database servers. This section gives you some hints to solve SQL
incompatibility problems in your programs. Read this section carefully
and review your program source code if needed. You should also read
carefully the ODI Adaptation Guides which contain detailed information
about SQL compatibility issues.

To easily detect SQL statements with specific syntax, you can use the -W
stdsql option of [fglcomp](Tools.html#TL_FGLCOMP):

    $ fglcomp -W stdsql orders.4gl
    module.4gl:15: SQL Statement or language instruction with specific SQL syntax.

Remark: This compiler option can only detect non-portable SQL syntax in
[Static SQL statements](StaticSql.html).

------------------------------------------------------------------------

### [3.1 Database entities]{#PORT_DBENT}

Most database servers can handle multiple database entities (you can
create multiple \'databases\'), but this is not possible with all
engines:

  -------------------------- --------------------------------
  **Database Server Type**   **Multiple Database Entities**
  Genero db                  No
  IBM DB2 UDB (Unix)         Yes
  Informix                   Yes
  Microsoft SQL Server       Yes
  MySQL                      Yes
  Oracle Database Server     No
  PostgreSQL                 Yes
  Sybase ASA                 Yes
  -------------------------- --------------------------------

When using a database server that does not support multiple database
entities, you can emulate different databases with schemas, but this
requires you to check for the database user definition. Each database
user must have privileges to access any schema, and to see any table of
any schema without needing to set a schema prefix before table names in
SQL statements.

You can force the database driver to set a specific schema at connection
with the following [FGLPROFILE](FglProfile.html) entry:

        dbi.database.<dbname>.schema = "<schema-name>"

Some databases like **Genero db** also allow you to define a default
schema for each database user. When the user connects to the database,
the default schema is automatically selected.

------------------------------------------------------------------------

### [3.2 Database users and security]{#PORT_DBUSR}

To get the benefit of the database server security features, you should
identify each physical user as a database user.

According to the type of server, you must do the following steps to
create a database user:

1.  Define the user as an operating system user.
2.  Declare the user in the database server.
3.  Grant database access privileges.

Each database server has its specific users management and data access
privilege mechanisms. Check the vendor documentation for security
features and make sure you can define the users, groups, and privileges
in all database servers you want to use.

------------------------------------------------------------------------

### [3.3 Database creation statements]{#PORT_DCS}

Database creation statements like CREATE DATABASE, CREATE DBSPACE, DROP
DATABASE cannot be executed with **ODI** database drivers. Such
high-level database management statements are Informix-specific and
require a connection to the server with no current database selected,
which is not supported by the ODI architecture and drivers. However, for
compatibility, the standard Informix drivers (with **ix** prefix) allow
the BDL programs to execute such statements.

------------------------------------------------------------------------

### [3.4 Data definition statements]{#PORT_DDS}

When using Data Definition Statements like CREATE TABLE, ALTER TABLE,
DROP TABLE, only a limited SQL syntax works on all database servers.
Most databases support NOT NULL, CHECK, PRIMARY KEY, UNIQUE, FOREIGN KEY
constraints, but the syntax for naming constraints is different.

The following statement works with most database servers and creates a
table with equivalent properties in all cases:

     CREATE TABLE customer
     (
      cust_id INTEGER NOT NULL,
      cust_name CHAR(50) NOT NULL,
      cust_lastorder DATE NOT NULL,
      cust_group INTEGER,
        PRIMARY KEY (cust_id),
        UNIQUE (cust_name),
        FOREIGN KEY (cust_group) REFERENCES group (group_id)
     )   

**Warning: Some engines like SQL Server have a different default
behavior for NULL columns when you create a table. You may need to set
up database properties to make sure that a column allows NULLs if the
NOT NULL constraint is not specified.**

When you want to create tables in programs using non-standard clauses
(for example to define storage options), you must use [Dynamic
SQL](DynamicSql.html) and adapt the statement to the target database
server.

------------------------------------------------------------------------

### [3.5 Using portable data types]{#PORT_DATATYPES}

The ANSI SQL specification defines standard data types, but for
historical reasons most databases vendors have implemented native
(non-standard) data types. You can usually use a synonym for ANSI types,
but the database server always uses the native types behind the scenes.
For example, when you create a table with an
[INTEGER](DataTypes.html#DT_INTEGER) column in **Oracle**, the native
NUMBER data type is used. In your programs, avoid BDL [data
types](DataTypes.html) that do not have a native equivalent in the
target database. This includes simple types like [floating point
numbers](DataTypes.html#DT_FLOAT), as well as complex data types like
[INTERVAL](DataTypes.html#DT_INTERVAL). Numbers may cause rounding or
overflow problems, because the values stored in the database have
different limits. For [DECIMALs](DataTypes.html#DT_DECIMAL), always use
the same precision and scale for the BDL variables and the database
columns.

To write portable applications, we strongly recommend using the
following BDL data types only:

::: {align="left"}
  ------------------------------------------------------------
  **BDL Data Type**
  [CHAR(n)](DataTypes.html#DT_CHAR)
  [VARCHAR(n)](DataTypes.html#DT_VARCHAR)
  [INTEGER](DataTypes.html#DT_INTEGER)
  [SMALLINT](DataTypes.html#DT_SMALLINT)
  [DECIMAL(p,s)](DataTypes.html#DT_DECIMAL)
  [DATE](DataTypes.html#DT_DATE)
  [DATETIME HOUR TO SECOND](DataTypes.html#DT_DATETIME)
  [DATETIME YEAR TO FRACTION(n)](DataTypes.html#DT_DATETIME)
  ------------------------------------------------------------
:::

See the ODI Adaptation Guides for more details about data type
compatibility.

------------------------------------------------------------------------

### [3.6 Data manipulation statements]{#PORT_DML}

Genero BDL supports several SQL syntaxes for the INSERT, UPDATE and
DELETE statements. Some of the syntaxes are Informix specific, but will
be converted to standard SQL by the compiler.

The following statements are standard SQL and work with all database
servers:

      (1) INSERT INTO table (column-list) VALUES (value-list)
      (2) UPDATE table SET column = value, ... [WHERE condition]
      (3) DELETE FROM table [WHERE condition]

The next statements are not standard SQL, but are converted by the
compiler to standard SQL, working with all database servers:

      (4) INSERT INTO table VALUES record.*
          -- where record is defined LIKE a table from db schema
      (5) UPDATE table SET (column-list) = (value-list) [WHERE condition]
      (6) UPDATE table SET {[table.]*|(column-list)} = record.* ... [WHERE condition]
          -- where record is defined LIKE a table from db schema

The next statement is not standard SQL and will not be converted by the
compiler, so it must be reviewed:

      (7) UPDATE table SET [table.]* = (value-list) [WHERE condition]

You can easily search for non-portable SQL statements in your .4gl
sources by compiling with the **-Wstdall** fglcomp option.

For maximum SQL portability, INSERT statements should be reviewed to
avoid the SERIAL column from the value list.

For example, the following statement:

       INSERT INTO tab (col1,col2) VALUES (0, p_value)

should be converted to :

       INSERT INTO tab (col2) VALUES (p_value)

Static SQL INSERT using records defined from the schema file should also
be reviewed:

       DEFINE rec LIKE tab.*
       INSERT INTO tab VALUES ( rec.* )   -- will use the serial column

should be converted to :

       INSERT INTO tab VALUES rec.* -- without braces, serial column is removed

For more details about supported SQL DML statements, see [Static
SQL](StaticSql.html).

------------------------------------------------------------------------

### [3.7 CHAR and VARCHAR types]{#PORT_CHARVARCHAR}

The [CHAR](DataTypes.html#DT_CHAR) and
[VARCHAR](DataTypes.html#DT_VARCHAR) types are designed to store
character strings, but all database servers do not have the same
behavior when comparing two CHAR or VARCHAR values having trailing
spaces.

#### CHAR and VARCHAR columns in databases

With all kinds of databases servers, CHAR columns are always filled with
blanks up to the size of the column, but trailing blanks are not
significant in comparisons:

`CHAR("abc ") = CHAR("abc")`

With all database servers [except Informix]{.underline}, trailing blanks
are significant when comparing VARCHAR values:\
\
`VARCHAR("abc ") <> VARCHAR("abc")`\
\
This is a major issue if you mix CHAR and VARCHAR columns and variables
in your SQL statements, because the result of an SQL query can be
different depending on whether you are using **Informix** or another
database server.

#### CHAR and VARCHAR variables in BDL

In BDL, CHAR variables are filled with blanks, even if the value used
does not contain all spaces.

The following example:

``` linenumber
01 DEFINE c CHAR(5)
02 LET c = "abc"
03 DISPLAY c || "."
```

shows the value `"abc  ."` (5 chars + dot).

In BDL, VARCHAR variables are assigned with the exact value specified,
with significant trailing blanks.

For example, this code:

``` linenumber
01 DEFINE v VARCHAR(5)
02 LET v = "abc "
03 DISPLAY v || "."
```

shows the value `"abc ."` (4 chars + dot).

When comparing CHAR or VARCHAR variables in a BDL expression, the
trailing blanks are [not significant]{.underline}:

``` linenumber
01 DEFINE c CHAR(5)
02 DEFINE v1, v2 VARCHAR(5)
03 LET c = "abc"
04 LET v1 = "abc "
05 LET v2 = "abc  "
06 IF c == v1 THEN DISPLAY "c==v1" 
07 END IF
08 IF c == v2 THEN DISPLAY "c==v2" 
09 END IF
10 IF v1 == v2 THEN DISPLAY "v1==v2" 
11 END IF
```

shows all three messages.

Additionally, when you assign a VARCHAR variable from a CHAR, the target
variable gets the trailing blanks of the CHAR variable:

``` linenumber
01 DEFINE pc CHAR(50)
02 DEFINE pv VARCHAR(50)
03 LET pc = "abc"
04 LET pv = pc
05 DISPLAY pv || "."
```

shows `"abc <47 spaces>. "` ( 50 chars + dot ).

To avoid this, you can use the [CLIPPED](Operators.html#OP_CLIPPED)
operator:

`LET`` pv = pc ``CLIPPED`

#### CHAR and VARCHAR variables and columns

When you insert a row containing a CHAR variable into a CHAR or VARCHAR
column, the database interface removes the trailing blanks to avoid
overflow problems, (insert CHAR(100) into CHAR(20) when value is `"abc"`
must work).

In the following example:

``` linenumber
01 DEFINE c CHAR(5)
02 LET c = "abc"
03 CREATE TABLE t ( v1 CHAR(10), v2 VARCHAR(10) )
04 INSERT INTO tab VALUES ( c, c )
```

The value in column v1 and v2 would be `"abc"` ( 3 chars in both columns
).

When you insert a row containing a VARCHAR variable into a VARCHAR
column, the VARCHAR value in the database gets the trailing blanks as
set in the variable. When the column is a CHAR(N), the database server
fills the value with blanks so that the size of the string is N
characters.

In the following example:

``` linenumber
01 DEFINE vc VARCHAR(5)
02 LET vc = "abc  "  -- note 2 spaces at end of string
03 CREATE TABLE t ( v1 CHAR(10), v2 VARCHAR(10) )
04 INSERT INTO tab VALUES ( vc, vc )
```

The value in column v1 would be `"abc       "` ( 10 chars ) and v2 would
be `"abc  "` ( 5 chars ).

#### What should you do?

Use VARCHAR variables for VARCHAR columns, and CHAR variables for CHAR
columns to achieve portability across all kinds of database servers. 

See also: [LENGTH()](#PORT_LENGTH) function.

------------------------------------------------------------------------

### [3.8 Concurrent data access]{#PORT_DATACCESS}

Data Concurrency is the simultaneous access of the same data by many
users. Data Consistency means that each user sees a consistent view of
the database. Without adequate concurrency and consistency controls,
data could be changed improperly, compromising data integrity. To write
interoperable BDL applications, you must adapt the program logic to the
behavior of the database server regarding concurrency and consistency
management. This issue requires good knowledge of multi-user application
programming, [transactions](Transactions.html), locking mechanisms,
[isolation levels](Transactions.html#TI_SET_ISOLATION) and [wait
mode](Transactions.html#TI_SET_LOCK_MODE). If you are not familiar with
these concepts, carefully read the documentation of each database server
which covers this subject.

Processes accessing the database can change transaction parameters such
as the isolation level. The main problem is to find a configuration
which results in similar behavior on every database engine. Existing BDL
programs must be adapted to work with this new behavior. ALL programs
accessing the same database must be changed. 

The following is the best configuration to get common behavior with all
types of database engines:

- The database must support [transactions](Transactions.html); this is
  usually the case.
- Transactions must be as short as possible (below a second is fine, 3
  or more seconds is a long transaction).
- The [Isolation Level](Transactions.html#TI_SET_ISOLATION) should be
  set to \"COMMITTED READ\" or \"CURSOR STABILITY\".\
  Note that Informix IDS 11 has introduced the \"LAST COMMITTED\" option
  for the COMMITTED READ isolation level, which makes IDS behave like
  other database server using row-versioning, returning the most
  recently committed version of the row, rather than wait for a lock to
  be released. This option can also be turned on implicitly with the
  USELASTCOMMITTED configuration parameter, saving code changes. 
- The [Wait Mode](Transactions.html#TI_SET_LOCK_MODE) for locks must be
  \"WAIT\" or \"WAIT n\" (timeout). Wait mode can be adapted to wait for
  the longest transaction.

Remarks: With this configuration, the locking granularity does not have
to be at the row level. To improve performance with **Informix**
databases, you can use the \"LOCK MODE PAGE\" locking level, which is
the default.

------------------------------------------------------------------------

### [3.9 The SQLCA register]{#PORT_SQLCA}

[SQLCA](Connections.html#SQLCA_RECORD) is the *SQL Communication Area*
variable. SQLCA is a global record predefined by the runtime system,
that can be queried to get SQL status information. After executing an
SQL statement, members of this record contain execution or error data,
but it is specific to Informix databases. For example, after inserting a
row in a table with a SERIAL column, SQLCA.SQLERRD\[2\] contains the new
generated serial number.

SQLCA.SQLCODE will be set to a specific Informix SQL error code, if the
database driver can convert the native SQL error to an Informix SQL
error. Additional members may be set, but that depends on the database
server and database driver.

To identify SQL errors, you can also use
[SQLSTATE](Operators.html#OP_SQLSTATE); this variable holds normalized
ISO SQL error codes. However, even if Genero database drivers are
prepared to support this register, not all RDBMS  support standard
SQLSTATE error codes:

  -------------------------- ------------------------------
  **Database Server Type**   **Supports SQLSTATE errors**
  Genero db                  Not in version 3.61
  IBM DB2 UDB (Unix)         Yes, since version 7.1
  Informix                   Yes, since IDS 10
  Microsoft SQL Server       Yes, since version 8 (2000)
  MySQL                      Yes
  Oracle Database Server     Not in version 10.2
  PostgreSQL                 Yes, since version 7.4
  Sybase ASA                 Not in version 8.x
  -------------------------- ------------------------------

According to the above, SQL error identification requires quite complex
code, which can be RDBMS-specific in some cases. Therefore, it is
strongly recommended that you centralize SQL error identification in a
function. This will allow you to write RDBMS-specific code, when needed,
only once.

------------------------------------------------------------------------

### [3.10 Optimistic Locking]{#PORT_OPTLOCK}

This section describes how to implement *optimistic locking* in BDL
applications. Optimistic locking is a portable solution to control
simultaneous modification of the same record by multiple users.

Traditional Informix-based applications use a SELECT FOR UPDATE to set a
lock on the row to be edited by the user. This is called *pessimistic
locking*. The SELECT FOR UPDATE is executed before the interactive part
of the code, as described in here:

1.  When the end user chooses to modify a record, the program declares
    and opens a cursor with a [SELECT FOR
    UPDATE](PositionedUpdates.html).\
    At this point, an SQL error might be raised if the record is already
    locked by another process.\
    Otherwise, the lock is acquired and user can modify the record.
2.  The user edits the current record in the input form.
3.  The user validates the dialog.
4.  The [UPDATE](StaticSql.html#SS_UPDATE) SQL instruction is executed.
5.  The [transaction](Transactions.html) is committed or the SELECT FOR
    UPDATE cursor is closed.\
    The lock is released.

Note that if the Informix database was created with transaction logging,
you must either start a [transaction](Transactions.html) or define the
SELECT FOR UPDATE cursor WITH HOLD option.

Unfortunately, this is not a portable solution. The [lock wait
mode](Transactions.html#TI_SET_LOCK_MODE) should preferably be \"WAIT\"
for portability reasons. Pessimistic locking is based on a \"NOT WAIT\"
mode to return control to the program if a record is already locked by
another process. Therefore, following the portable concurrency model,
the *pessimistic locking* mechanisms must be replaced by the *optimistic
locking* technique.

Basically, instead of locking the row before the user starts to modify
the record data, the *optimistic locking* technique makes a copy of the
current values(i.e. Before Modification Values), lets the user edit the
record, and when it\'s time to write data into the database, checks if
the BMVs still correspond to the current values in the database:

1.  A [SELECT](StaticSql.html) is executed to fill the record variable
    used by the interactive instruction for modifications.
2.  The record variable is copied into a backup record to keep Before
    Modification Values.
3.  The user enters modifications in the input form; this updates the
    values in the modification record.
4.  The user validates the dialog.
5.  A transaction is started with [BEGIN WORK](Transactions.html).
6.  A SELECT FOR UPDATE is executed to put the current database values
    into a temporary record.
7.  If the SQL status is [NOTFOUND](Programs.html#PC_NOTFOUND), the row
    has been deleted by another process, and the transaction is [rolled
    back](Transactions.html#TI_ROLLBACK_WORK).
8.  Otherwise, the program [compares](Operators.html#OP_EQUAL) the
    temporary record values with the backup record values
    `(rec1.*==rec2.*)`
9.  If these values have changed, the row has been modified by another
    process, and the transaction is [rolled
    back](Transactions.html#TI_ROLLBACK_WORK).
10. Otherwise, the [UPDATE](StaticSql.html#SS_UPDATE) statement is
    executed.
11. The transaction is [committed](Transactions.html#TI_COMMIT_WORK).

To compare 2 records, simply write:

``` linenumber
01 IF new_record.* != bmv_record.* THEN
02    LET values_have_changed = TRUE
03 END IF
```

The optimistic locking technique could be implemented with a unique SQL
instruction: an UPDATE could compare the column values to the BMVs
directly (UPDATE \... WHERE kcol = kvar AND col1 = bmv.var1 AND \...).
But, this is not possible when BMVs can be NULL. The database engine
always evaluates conditional expressions such as \"col=NULL\" to FALSE.
Therefore, you must use \"col IS NULL\" when the BMV is NULL. This means
dynamic SQL statement generation based on the DMV values. Additionally,
to use the same number of SQL parameters (? markers), you would have to
use \"col=?\" when the BMV is not null and \"col IS NULL and ? IS NULL\"
when the BMV is null. Unfortunately, the expression \" ? IS \[NOT\] NULL
\" is not supported by all database servers (DB2 raises error SQL0418N).

If you are designing a new database application from scratch, you can
also use the row versioning method. Each tables of the database must
have a column that identifies the current version of the row. The column
can be a simple INTEGER (to hold a row version number) or it can be a
timestamp (DATETIME YEAR TO FRACTION(5) for example). To guaranty that
the version or timestamp column is updated each time the row is updated,
you should implement a trigger to increment the version or set the
timestamp when an UPDATE statement is issued. If this is in place, you
just need to check that the row version or timestamp has not changed
since the user modifications started, instead of testing all field of
the BMV record. If you are only using one specific database type, you
may check if the server supports a versioning column natively. For
example, Informix IDS 11.50.xC1 introduced the ALTER TABLE \... ADD
VERCOLS option to get a version + checksum column to a table, you can
then query the table with the *ifx_insert_checksum* and
*ifx_row_version* columns.

------------------------------------------------------------------------

### [3.11 Auto-incremented columns (serials)]{#PORT_AUTOINC}

INFORMIX provides the SERIAL, BIGSERIAL or SERIAL8 data types which can
be emulated with ODI drivers for most non-INFORMIX database engines by
using native sequence generators (when \"ifxemul.serial\" is true). But,
this requires additional configuration and maintenance tasks. If you
plan to review the programming pattern of sequences, you should use a
portable implementation instead of the serial emulation provided by the
ODI drivers. This section describes different solutions to implement
**auto-incremented fields**. The preferred implementation is the
solution using SEQUENCES.

#### [Solution 1: Use database specific serial generators.]{#AUTOINCR_DBSPEC}

[Principle:]{.underline}

In accordance with the target database, you must use the appropriate
native serial generation method. Get the database type with the
**db_get_database_type()** function of **fgldbutl.4gl** and use the
appropriate SQL statements to insert rows with serial generation.

**Warning: This solution uses the native auto-increment feature of the
target database and is fast at execution, but is not very convenient as
it requires to write different code for each database type. However, it
is covered here to make you understand that each database vendor has
it\'s own specific solution for auto-incremented columns. It is of
course not realistic to use this solution in a large application with
hundreds of tables.**

[Implementation:]{.underline}

1.  Create the database objects required for serial generation in the
    target database (for example, create tables with SERIAL columns in
    Informix, tables with IDENTITY columns in **SQL Server** and
    SEQUENCE database objects in **Oracle**).
2.  Adapt your BDL programs to use the native sequence generators in
    accordance with the database type.

[BDL example:]{.underline}

``` linenumber
01 DEFINE dbtype CHAR(3)
02 DEFINE t1rec RECORD
03           id    INTEGER,
04           name  CHAR(50),
05           cdate DATE
06     END RECORD
07
08 LET dbtype = db_get_database_type()
09
10 IF dbtype = "IFX" THEN
11    INSERT INTO t1 ( id, name, cdate )
12           VALUES ( 0, t1rec.name, t1rec.cdate )
13    LET t1rec.id = SQLCA.SQLERRD[2]
14 END IF
15 IF dbtype = "ORA" THEN
16    INSERT INTO t1 ( id, name, cdate )
17            VALUES ( t1seq.nextval, t1rec.name, t1rec.cdate )
18    SELECT t1seq.currval INTO t1rec.id FROM dual
19 END IF
20 IF dbtype = "MSV" THEN
21    INSERT INTO t1 ( name, cdate )
22            VALUES ( t1rec.name, t1rec.cdate )
23    PREPARE s FROM "SELECT convert(integer,@@identity)"
24    EXECUTE s INTO t1rec.id
25 END IF
```

#### [Solution 2: Generate serial numbers from your own sequence table.]{#AUTOINCR_SEQREG}

[Purpose:]{.underline}

The goal is to generate unique INTEGER or BIGINT numbers. These numbers
will usually be used for primary keys.

[Prerequisites:]{.underline}

1.  The database must use [transactions](Transactions.html). This is
    usually the case with non-INFORMIX databases, but INFORMIX databases
    default to auto commit mode. Make sure your INFORMIX database allows
    transactions.
2.  The sequence generation must be called inside a transaction ([BEGIN
    WORK](Transactions.html#TI_BEGIN_WORK) / [COMMIT
    WORK](Transactions.html#TI_COMMIT_WORK)).
3.  The transaction isolation level must guarantee that a row UPDATEd in
    a transaction cannot be read or written by other db sessions until
    the transaction has ended (typically, COMMITTED READ is ok, but some
    db servers require a higher isolation level)
4.  The l[ock wait mode](Transactions.html#TI_SET_LOCK_MODE) must be
    WAIT. This is usually the case in non-INFORMIX databases, but
    INFORMIX defaults to NOT WAIT. You must change the lock wait mode
    with \"SET LOCK MODE TO WAIT\" or \"WAIT seconds\" when using
    INFORMIX.
5.  Non-BDL applications or stored procedures must implement the same
    technique when inserting records in the table having
    auto-incremented columns.

[Principle:]{.underline}

A dedicated table named \"**SEQREG**\" is used to register sequence
numbers. The key is the name of the sequence. This name will usually be
the table name the sequence is generated for. In short, this table
contains a primary key that identifies the sequence and a column
containing the last generated number.

The uniqueness is granted by the concurrency management of the database
server. The first executed instruction is an UPDATE that sets an
exclusive lock on the SEQREG record. When two processes try to get a
sequence at the same time, one will wait for the other until its
transaction is finished.

[Implementation:]{.underline}

The \"**fgldbutl.4gl**\" utility library implements a function called
\"**db_get_sequence**\" which generates a new sequence. You must create
the SEQREG table as described in the **fgldbutl.4gl** source and make
sure that every user has the privileges to access and modify this table.

**Warning: In order to guarantee the uniqueness of the generated number,
the call to db_get_sequence() must be done inside a transaction block
that includes the INSERT statement. Concurrent db sessions must wait for
each other in case of conflict and the transaction isolation level must
be high enough to make sure that the row of the sequence table will not
be read or written by other db sessions until the transaction end. Note
for example that with Genero db, you must be in the native SERIALIZABLE
isolation level, which can be set from the BDL program with SET
ISOLATION TO REPEATABLE READ.**

[BDL example:]{.underline}

``` linenumber
01 IMPORT FGL fgldbutl
02 DEFINE rec RECORD
03            id    INTEGER,
04            name  CHAR(100)
05      END RECORD
06 ...
07 BEGIN WORK
08 LET rec.id = db_get_sequence( "CUSTID" )
09 INSERT INTO CUSTOMER ( CUSTID, CUSTNAME ) VALUES ( rec.* )
10 COMMIT WORK
```

#### [Solution 3: Use native SEQUENCE database objects.]{#AUTOINCR_NATIVE}

[Principle:]{.underline}

More an more database engines support SEQUENCE database objects; If all
database server types you want to use do support sequences, you should
use this solution.

Note that while writing these lines, Microsoft SQL Server (2008), MySQL
(6.0) and SQLite (3) do not support SEQUENCE objects. You can however
write stored procedures that emulate sequence generators (For SQL
Server, search the MSDN for Oracle SEQUENCE migration tips).

[Implementation:]{.underline}

1.  Create a SEQUENCE object for each table using previously a SERIAL
    column in the Informix database.
2.  In database creation scripts (CREATE TABLE), replace all SERIAL
    types by INTEGER (or BIGINT if you need large integers).
3.  Adapt your BDL programs to retrieve a new sequence before inserting
    a new row.

[BDL example:]{.underline}

``` linenumber
01 IMPORT FGL fgldbutl
02 DEFINE dbtype CHAR(3)
03 MAIN
04     DEFINE item_rec RECORD
05                item_num BIGINT,
06                item_name VARCHAR(40)
07            END RECORD
08     DEFINE i INT
09     DATABASE test1
10     LET dbtype = db_get_database_type()
11     CREATE TABLE item ( item_num BIGINT NOT NULL PRIMARY KEY, item_name VARCHAR(50) )
12     CREATE SEQUENCE item_seq
13     LET item_rec.item_num = new_seq("item")
14     DISPLAY "New sequence: ", item_rec.item_num
15     LET item_rec.item_name = "Item#"|| item_rec.item_num
16     INSERT INTO item VALUES ( item_rec.* )
17     DROP TABLE item
18     DROP SEQUENCE item_seq
19 END MAIN
20
21 FUNCTION new_seq(tabname)
22     DEFINE tabname STRING
23     DEFINE sql STRING
24     DEFINE newseq BIGINT
25     IF dbtype=="PGS" THEN
26        LET sql = "SELECT nextval('"||tabname||"_seq')"||unique_row_condition()
27     ELSE
28         LET sql = "SELECT "||tabname||"_seq.nextval "||unique_row_condition()
29     END IF
30     PREPARE seq FROM sql
31     IF SQLCA.SQLCODE!=0 THEN RETURN -1 END IF
32     EXECUTE seq INTO newseq
33     IF SQLCA.SQLCODE!=0 THEN RETURN -1 END IF
34     RETURN newseq
35 END FUNCTION
36
37 FUNCTION unique_row_condition()
38     CASE dbtype
39         WHEN "IFX" RETURN " FROM systables WHERE tabid=1"
40         WHEN "DB2" RETURN " FROM sysibm.systables WHERE name='SYSTABLES'"
41         WHEN "PGS" RETURN " FROM pg_class WHERE relname='pg_class'"
42         WHEN "ORA" RETURN " FROM dual"
43         WHEN "ADS" RETURN " FROM dual"
44         OTHERWISE RETURN " "
45     END CASE
46 END FUNCTION
```

------------------------------------------------------------------------

### [3.12 Informix SQL ANSI Mode]{#PORT_IFXANSI}

INFORMIX allows you to create databases in ANSI mode, which is supposed
to be closer to ANSI standard behavior. Other databases like **ORACLE**
and **DB2** are \'ANSI\' by default.

If you are not using the ANSI mode with **Informix**, we suggest you
keep the database as is, because turning an Informix database into ANSI
mode can result in unexpected behavior of the programs.

Here are some ANSI mode issues extracted from the Informix books:

- Some actions, like CREATE INDEX will generate a warning but will not
  be forbidden.
- Buffered logging is not allowed to enforce data recovery. (Buffered
  logging provides better performance)
- The table-naming scheme allows different users to create tables
  without having to worry about name conflicts.
- Owner specification is required in database object names ( SELECT \...
  FROM \"owner\".table ). You must quote the owner name to prevent
  automatic translation of the owner name into uppercase : SELECT ..
  FROM owner.table -\> SELECT .. FROM OWNER.table =\> table not found in
  database!
- Default privileges differ : When creating a table, the server grants
  privileges to the table owner and the DBA only. The same thing happens
  for the \'Execute\' privilege when creating stored procedures.
- Default isolation level is REPEATABLE READ.
- An error is generated if any character field is filled with a value
  that is longer than the field width.
- DECIMAL(p) (floating point decimals) are automatically converted to
  DECIMAL(p,0) (fixed point decimals).
- Closing a closed cursor generates an SQL error.

It will take more time to adapt the programs to the INFORMIX ANSI mode
than using the database interface to simulate the native mode of
INFORMIX.

------------------------------------------------------------------------

### [3.13 WITH HOLD and FOR UPDATE]{#PORT_WHFU}

Informix supports WITH HOLD cursors using the FOR UPDATE clause. Such
cursors can remain open across transactions (when using FOR UPDATE,
locks are released at the end of a transaction, but the WITH HOLD cursor
is not closed). This kind of cursor is Informix-specific and not
portable. The SQL standards recommend closing FOR UPDATE cursors and
release locks at the end of a transaction. Most database servers close
FOR UPDATE cursors when a COMMIT WORK or ROLLBACK WORK is done. All
database servers release locks when a transaction ends.

  -------------------------- --------------------------------------
  **Database Server Type**   **WITH HOLD FOR UPDATE supported?**
  Genero db                  Yes (if primary key or unique index)
  IBM DB2 UDB (Unix)         No
  Informix                   Yes
  Microsoft SQL Server       No
  MySQL                      No
  Oracle Database Server     No
  PostgreSQL                 No
  Sybase ASA                 No
  -------------------------- --------------------------------------

It is mandatory to review code using WITH HOLD cursors with a SELECT
statement having the FOR UPDATE clause.

The standard SQL solution is to declare a simple FOR UPDATE cursor
outside the transaction and open the cursor inside the transaction:

``` linenumber
01 DECLARE c1 CURSOR FOR SELECT ... FOR UPDATE
02 BEGIN WORK
03   OPEN c1
04   FETCH c1 INTO ...
05   UPDATE ...
06 COMMIT WORK
```

If you need to process a complete result set with many rows including
updates of master and detail rows, you can declare a normal cursor and
do a SELECT FOR UPDATE inside each transaction, as in the following
example:

``` linenumber
01 DECLARE c1 CURSOR FOR SELECT key FROM master ...
02 DECLARE c2 CURSOR FOR SELECT * FROM master WHERE key=? FOR UPDATE
03 FOREACH c1 INTO mrec.key
04   BEGIN WORK
05   OPEN c2 INTO mrec.key
06   FETCH c2 INTO rec.*
07   IF STATUS==NOTFOUND THEN
08      ROLLBACK WORK
09      CONTINUE FOREACH
10   END IF
11   UPDATE master SET ... WHERE CURRENT OF c2
12   UPDATE detail SET ... WHERE mkey=mrec.key
13   COMMIT WORK
14 END FOREACH
```

------------------------------------------------------------------------

### [3.14 Positioned Updates/Deletes]{#PORT_POSUD}

The \"WHERE CURRENT OF *cursor-name*\" clause in UPDATE and DELETE
statements is not supported by all database engines.

  -------------------------- ------------------------------------
  **Database Server Type**   **WHERE CURRENT OF supported?**
  Genero db                  Yes
  IBM DB2 UDB (Unix)         Yes
  Informix                   Yes
  Microsoft SQL Server       Yes
  MySQL                      Yes
  Oracle Database Server     No, emulated by driver with ROWIDs
  PostgreSQL                 No, emulated by driver with OIDs
  Sybase ASA                 Yes
  -------------------------- ------------------------------------

Some database drivers can emulate WHERE CURRENT OF mechanisms by using
rowids, but this requires additional processing. You should review the
code to disable this option.

The standard SQL solution is to use primary keys in all tables and write
UPDATE / DELETE statements with a WHERE clause based on the primary key:

``` linenumber
01 DEFINE rec RECORD
02            id    INTEGER,
03            name  CHAR(100)
04      END RECORD
05 BEGIN WORK
06   SELECT CUSTID FROM CUSTOMER
07          WHERE CUSTID=rec.id FOR UPDATE
08   UPDATE CUSTOMER SET CUSTNAME = rec.name
09          WHERE CUSTID = rec.id
10 COMMIT WORK
```

------------------------------------------------------------------------

### [3.15 String literals in SQL statements]{#PORT_STRINGLIT}

Some database servers like INFORMIX allow single and double quoted
string literals in SQL statements, both are equivalent:

`SELECT COUNT(*) FROM table`\
` WHERE col1 = "abc'def""ghi"`\
`   AND col1 = 'abc''def"ghi'`

Most database servers do not support this specific feature:

  -------------------------- -----------------------------------
  **Database Server Type**   **Double quoted string literals**
  Genero db                  No
  IBM DB2 UDB (Unix)         No
  Informix                   Yes
  Microsoft SQL Server       Yes
  MySQL                      No
  Oracle Database Server     No
  PostgreSQL                 No
  Sybase ASA                 No
  -------------------------- -----------------------------------

The ANSI SQL standards define doubles quotes as database object names
delimiters, while single quotes are dedicated to string literals:

`CREATE TABLE "my table" ( "column 1" CHAR(10) )`\
`SELECT COUNT(*) FROM "my table" WHERE "column 1" = 'abc'`

If you want to write a single quote character inside a string literal,
you must write 2 single quotes:

`... WHERE comment = 'John''s house'`

When writing [Static SQL](StaticSql.html) in your programs, the double
quoted string literals as converted to ANSI single quoted string
literals by the [fglcomp](Tools.html#TL_FGLCOMP) compiler. However,
[Dynamic SQL](DynamicSql.html) statements are not parsed by the compiler
and therefore need to use single quoted string literals.

We recommend that you ALWAYS use single quotes for string literals and,
if needed, double quotes for database object names.

------------------------------------------------------------------------

### [3.16 Date and Time literals in SQL statements]{#PORT_DATETIMELIT}

INFORMIX allows you to specify date and time literals as a quoted
character string in a specific format, depending upon DBDATE and GLS
environment variables. For example, if DBDATE=DMY4, the following
statement specifies a valid DATE literal:

    SELECT COUNT(*) FROM table WHERE date_col = '24/12/2005'

Other database servers do support date/time literals as quoted character
strings, but the date/time format specification is quite different. The
parameter to specify the date/time format can be a database parameter,
an environment variable, or a session option\...

In order to write portable SQL, just use SQL parameters instead of
literals:


    01 DEFINE cnt INTEGER
    02 DEFINE adate DATE
    03 LET adate = MDY(12,24,2005)
    04 SELECT COUNT(*) INTO cnt FROM table
    05   WHERE date_col = adate

Or, when using dynamic SQL:


    01 DEFINE cnt INTEGER
    02 DEFINE adate DATE
    03 LET adate = MDY(12,24,2005)
    04 PREPARE s1 FROM "SELECT COUNT(*) FROM table WHERE date_col = ?"
    05 EXECUTE s1 USING adate INTO cnt

------------------------------------------------------------------------

### [3.17 Naming database objects]{#PORT_NAMOBJ}

#### Name syntax

Each type of database server has its own naming conventions for database
objects (i.e. tables and columns):

  -------------------------- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  **Database Server Type**   **Naming Syntax**
  Genero db                  [`[`]{.underline}*`schema`*`.`[`]`]{.underline}*`identifier`*
  IBM DB2 UDB (Unix)         [`[[`]{.underline}*`database`*`.`[`]`]{.underline}*`owner`*`.`[`]`]{.underline}*`identifier`*
  Informix                   [`[`]{.underline}*`database`*[`[`]{.underline}`@`*`dbservername`*[`]`]{.underline}`:`[`][`]{.underline}*`owner`*`.`[`]`]{.underline}*`identifier`*
  Microsoft SQL Server       [`[[[`]{.underline}*`server`***`.`**[`][`]{.underline}*`database`*[`]`]{.underline}**`.`**[`][`]{.underline}*`owner_name`*[`]`]{.underline}**`.`**[`]`]{.underline}*`object_name`*
  MySQL                      [`[`]{.underline}*`database`*`.`[`]`]{.underline}*`identifier`*
  Oracle Database Server     [`[`]{.underline}*`schema`*`.`[`]`]{.underline}*`identifier`*[`[`]{.underline}`@`*`database-link`*[`]`]{.underline}
  PostgreSQL                 [`[`]{.underline}*`owner`*`.`[`]`]{.underline}*`identifier`*
  Sybase ASA                 [`[`]{.underline}*`database`*`.`[`]`]{.underline}*`identifier`*
  -------------------------- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#### Case-sensitivity

Most database engines have case-sensitive object identifiers. In most
cases, when you do not specify identifiers in double quotes, the SQL
parser automatically converts names to uppercase or lowercase, so that
the identifiers match if the objects are also created without double
quoted identifiers.

`CREATE TABLE Customer ( cust_ID INTEGER )`

In **Oracle**, the above statement would create a table named
\"`CUSTOMER`\" with a \"`CUST_ID`\" column.

The following table shows the behavior of each database engine regarding
case sensitivity and double quoted identifiers:

  -------------------------- --------------------------- -----------------------------------
  **Database Server Type**   **Un-quoted names**         **Double-quoted names**
  Genero db                  Converts to uppercase       Case sensitive
  IBM DB2 UDB (Unix)         Converts to uppercase       Case sensitive
  Informix (1)               Converts to lowercase       Syntax disallowed (non-ANSI mode)
  Microsoft SQL Server (2)   Not converted, kept as is   Case sensitive
  MySQL                      Not converted, kept as is   Syntax disallowed
  Oracle Database Server     Converts to uppercase       Uppercase
  PostgreSQL                 Converts to lowercase       Lowercase
  Sybase ASA                 Converts to lowercase       Lowercase
  -------------------------- --------------------------- -----------------------------------

\(1\) If not ANSI database mode.\
(2) When case-sensitive charset/collation used.

#### Warning: You must take care with database servers marked in red, because object identifiers are case sensitive and are not converted to uppercase or lowercase if not delimited by double-quotes. This means that, by error, you can create two tables with a similar name:

    CREATE TABLE customer ( cust_id INTEGER )  -- first table
    CREATE TABLE Customer ( cust_id INTEGER )  -- second table

According to the above facts, it is recommended to design databases with
lowercase table and column names.

#### Size of identifiers

The maximum size of a table or column name depends on the database
server type. Some database engines allow very large names (256c), while
others support only short names (30c max). Therefore, using short names
is required for writing portable SQL. Short names also simplify SQL
programs.

#### How to write SQL with portable object identifiers

We recommend that you use simple and short (\<30c) database object
names, without double quotes and without a schema/owner prefix:

    CREATE TABLE customer ( cust_id INTEGER )
    SELECT customer.cust_id FROM table

You may need to set the database schema after connection, so that the
current database user can see the application tables without specifying
the owner/schema prefix each time.

Tip: Even if all database engines do not required unique column names
for all tables, we recommend that you define column names with a small
table prefix (for example, CUST_ID in CUSTOMER table).

------------------------------------------------------------------------

### [3.18 Temporary tables]{#PORT_TEMPTABS}

Not all database servers support temporary tables. The engines
supporting this feature often provide it with a specific table creation
statement:

  ----------------------- ------------------------------------------------------------------- -----------------------
  **Database Server       **Temp table creation syntax**                                      **Local to SQL
  Type**                                                                                      session?**

  Genero db               `CREATE TEMP TABLE tablename ( `*`column-defs`*` )`\                Yes
                          `SELECT ... INTO TEMP tablename`                                    

  IBM DB2 UDB (Unix)      `DECLARE GLOBAL TEMPORARY TABLE tablename ( `*`column-defs`*` )`\   Yes
                          `DECLARE GLOBAL TEMPORARY TABLE tablename AS ( SELECT ... )`        

  Informix                `CREATE TEMP TABLE tablename ( `*`column-defs`*` )`\                Yes
                          `SELECT ... INTO TEMP tablename`                                    

  Microsoft SQL Server    `CREATE TABLE #tablename ( `*`column-defs`*` )`\                    Yes
                          `SELECT `*`select-list`*` INTO #tablename FROM ...`                 

  MySQL                   `CREATE TEMPORARY TABLE tablename ( `*`column-defs`*` )`\           Yes
                          `CREATE TEMPORARY TABLE tablename LIKE `*`other-table`*             

  Oracle Database Server  `CREATE GLOBAL TEMPORARY TABLE tablename ( `*`column-defs`*` )`\    No: only data is local
                          `CREATE GLOBAL TEMPORARY TABLE tablename AS SELECT ...`             to session

  PostgreSQL              `CREATE TEMP TABLE tablename ( `*`column-defs`*` )`\                Yes
                          `SELECT `*`select-list`*` INTO TEMP tablename FROM ...`             

  Sybase ASA              `CREATE GLOBAL TEMPORARY TABLE tablename ( `*`column-defs`*` )`\    Yes
                          `CREATE TABLE #tablename ( `*`column-defs`*` )`                     
  ----------------------- ------------------------------------------------------------------- -----------------------

Some databases even have a different behavior when using temporary
tables. For example, **Oracle 9i** supports a kind of temporary table,
but it must be created as a permanent table. The table is not specific
to an SQL session: it is shared by all processes - only the data is
local to a database session.

You must review the programs using temporary tables, and adapt the code
to use database-specific temporary tables.

------------------------------------------------------------------------

### [3.19 Outer joins]{#PORT_OUTERJOINS}

Old INFORMIX SQL outer joins specified with the OUTER keyword in the
FROM part are not standard:

`SELECT * FROM master, OUTER ( detail )`\
`  WHERE master.mid = detail.mid`\
`    AND master.cdate IS NOT NULL`

  -------------------------- -----------------------------------------
  **Database Server Type**   **Supports Informix OUTER join syntax**
  Genero db                  Yes
  IBM DB2 UDB (Unix)         No (but translated by driver)
  Informix (1)               Yes
  Microsoft SQL Server (2)   No (but translated by driver)
  MySQL                      No (but translated by driver)
  Oracle Database Server     No (but translated by driver)
  PostgreSQL                 No (but translated by driver)
  Sybase ASA                 No (but translated by driver)
  -------------------------- -----------------------------------------

Most recent database servers now support the standard ANSI outer join
specification:

`SELECT * FROM master LEFT OUTER JOIN detail ON (master.mid = detail.mid)`\
`  WHERE master.cdate IS NOT NULL`

You should use recent database servers and use ANSI outer joins only.

------------------------------------------------------------------------

### [3.20 Sub-string expressions]{#PORT_SUBSTR}

Only INFORMIX supports sub-string specification with square brackets:

`SELECT * FROM item WHERE item_code[1,4] = "XBFG"`

However, most database servers support a function that extracts
sub-strings from a character string:

  -------------------------- -------------------------------------- ------------------------------------------
  **Database Server Type**   **Supports col\[x,y\] sub-strings?**   **Provides sub-string function?**
  Genero db                  Yes                                    `SUBSTR(expr,start,length)`
  IBM DB2 UDB (Unix)         No                                     `SUBSTR(expr,start,length)`
  Informix (1)               Yes                                    `SUBSTR(expr,start,length)`
  Microsoft SQL Server (2)   No                                     `SUBSTRING(expr,start,length)`
  MySQL                      No                                     `SUBSTR(expr,start,length)`
  Oracle Database Server     No                                     `SUBSTRING(expr,start,length)`
  PostgreSQL                 No                                     `SUBSTRING(expr FROM start FOR length )`
  Sybase ASA                 No                                     `SUBSTR(expr,start,length)`
  -------------------------- -------------------------------------- ------------------------------------------

**Warning: INFORMIX allows you to update some parts of a \[VAR\]CHAR
column by using the sub-string specification (
`UPDATE tab SET col[1,2] ='ab'` ). This is not possible with other
databases.**

Review the SQL statements using sub-string expressions and use the
database specific sub-string function.

You could also create your own SUBSTRING() user function in all
databases that do not support this function, to have a common way to
extract sub-strings. In Microsoft **SQL Server**, when you create a user
function, you must specify the owner as prefix when using the function.
Therefore, you should create a SUBSTRING() user function instead of
SUBSTR().

------------------------------------------------------------------------

### [3.21 Using ROWIDs]{#PORT_ROWIDS}

Rowids are implicit primary keys generated by the database engine. Not
all database servers support rowids:

  -------------------------- -------------------- -----------------
  **Database Server Type**   **Rowid keyword?**   **Rowid type?**
  Genero db                  `ROWID`              `INTEGER`
  IBM DB2 UDB (Unix)         `none`               `none`
  Informix (1)               `ROWID`              `INTEGER`
  Microsoft SQL Server (2)   `none`               `none`
  MySQL                      `none`               `none`
  Oracle Database Server     `ROWID`              `CHAR(18)`
  PostgreSQL                 `OID`                `internal type`
  Sybase ASA                 `none`               `none`
  -------------------------- -------------------- -----------------

**Warning: INFORMIX fills the SQLCA.SQLERRD\[3\] register with the ROWID
of the last updated row. This register is an INTEGER and cannot be
filled with rowids having CHAR(\*) type.**

Search for ROWID and SQLCA.SQLERRD\[3\] in your code and review the code
to remove the usage of rowids.

------------------------------------------------------------------------

### [3.22 MATCHES operator]{#PORT_MATCHES}

The MATCHES operator allows you to scan a string expression:

`SELECT * FROM customer WHERE customer_name MATCHES "A*[0-9]"`

Here is a table listing the database servers which support the MATCHES
operator:

  -------------------------- -----------------------------------
  **Database Server Type**   **Support for MATCHES operator?**
  Genero db                  Yes
  IBM DB2 UDB (Unix)         No
  Informix (1)               Yes
  Microsoft SQL Server (2)   No
  MySQL                      No
  Oracle Database Server     No
  PostgreSQL                 No
  Sybase ASA                 No
  -------------------------- -----------------------------------

The MATCHES operator is specific to INFORMIX SQL and Genero db. There is
an equivalent standard operator: LIKE. We recommend to replace MATCHES
expressions in your SQL statements with a standard LIKE expression.
MATCHES uses `*` and `?` as wildcards. The equivalent wildcards in the
LIKE operator are `%` and `_`. Character ranges `[a-z]` are not
supported by the LIKE operator.

Remark: The BDL language provides a MATCHES operator which is part of
the runtime system. Do not confuse this with the SQL MATCHES operator,
used in SQL statements. There is no problem in using the MATCHES
operator of the BDL language.

**Warning: A program variable can be used as parameter for the MATCHES
or LIKE operator, but you must pay attention to blank padding semantics
of the target database. If the program variable is defined as a CHAR(N),
it is filled by the runtime system with trailing blanks, in order to
have a size of N. For example, when a CHAR(10) variable is assigned with
\"ABC%\", it contains actually \"ABC%\<6 blanks\>\". If this variable is
used as LIKE parameter, the database server will search for column
values matching \"ABC\" + some characters + 6 blanks. To avoid automatic
blanks, use a VARCHAR(N) data type instead of CHAR(N).**

------------------------------------------------------------------------

### [3.23 GROUP BY clause]{#PORT_GROUPBY}

Some databases allow you to specify a column index in the GROUP BY
clause:

`SELECT a, b, sum(c) FROM table GROUP BY 1,2`

This is not possible with all database servers:

  -------------------------- -------------------------------
  **Database Server Type**   **GROUP BY colindex, \... ?**
  Genero db                  No
  IBM DB2 UDB (Unix)         No
  Informix (1)               Yes
  Microsoft SQL Server (2)   No
  MySQL                      Yes
  Oracle Database Server     No
  PostgreSQL                 Yes
  Sybase ASA                 No
  -------------------------- -------------------------------

Search for GROUP BY in your SQL statements and use explicit column
names.

------------------------------------------------------------------------

### [3.24 LENGTH() function]{#PORT_LENGTH}

Not all database servers support the LENGTH() function, and some have
specific behavior:

  -------------------------- ---------------------- ------------------------------------------------ ----------------------------
  **Database Server Type**   **Length function?**   **Counts trailing blanks for CHAR() columns?**   **Return value when NULL**
  Genero db                  LENGTH(expr)           No                                               NULL
  IBM DB2 UDB (Unix)         LENGTH(expr)           Yes                                              NULL
  Informix (1)               LENGTH(expr)           No                                               NULL
  Microsoft SQL Server (2)   LEN(expr)              No                                               NULL
  MySQL                      LENGTH(expr)           No                                               NULL
  Oracle Database Server     LENGTH(expr)           Yes                                              NULL
  PostgreSQL                 LENGTH(expr)           Yes                                              NULL
  Sybase ASA                 LENGTH(expr)           No                                               NULL
  -------------------------- ---------------------- ------------------------------------------------ ----------------------------

Search for LENGTH in your SQL statements and review the code of the
database-specific function. You could also define your own LEN() user
function to have a common function in all databases. In Microsoft SQL
Server, when you create a user function, you must specify the owner as
prefix when using the function. Therefore, you should create a LEN()
user function instead of LENGTH().

Remark: The BDL language provides a LENGTH built-in function which is
part of the runtime system. Do not confuse this with the SQL LENGTH()
function, used in SQL statements. There is no problem in using the
LENGTH() function of the BDL language. However, the LENGTH() function of
the language returns zero when the string expression is NULL.

------------------------------------------------------------------------

### [3.25 SQL Interruption]{#SQL_INTERRUPTION}

With Informix, it is possible to interrupt a long-running query if the
[SQL INTERRUPT ON](Programs.html#PROGRAM_OPTIONS)  option is set by the
Genero program. The database server returns SQLCODE -213, which can be
trapped to detect a user interruption.

``` linenumber
01 MAIN
02   DEFINE n INTEGER
03   DEFER INTERRUPT
04   OPTIONS SQL INTERRUPT ON
05   DATABASE test1
06   WHENEVER ERROR CONTINUE
07   -- Start long query (self join takes time)
08   -- From now on, user can hit CTRL-C in TUI mode to stop the query
09   SELECT COUNT(*) INTO n FROM customers a, customers b
10        WHERE a.cust_id <> b.cust_id
11   IF SQLCA.SQLCODE == -213 THEN
12    DISPLAY "Statement was interrupted by user..."
13      EXIT PROGRAM 1
14   END IF
15   WHENEVER ERROR STOP
16   ...
17 END MAIN
```

When SQL Interruption is available for a database server type, Genero
database drivers implement it to behave as in Informix, converting the
native error to the code -213. Not all database servers support SQL
interruption:

  --------------------------------------------- -------------------------- ------------------------------------------
  **Database Server Type**                      **SQL Interruption API**   **SQL error code for interrupted query**
  Genero db 3.80                                SQLCancel()                Native error -30005
  IBM DB2 UDB 9.x                               SQLCancel()                Native error -952
  Informix                                      sqlbreak()                 Native error -213
  Microsoft SQL Server 2005 (SNC driver only)   SQLCancel()                SQLSTATE HY008
  MySQL                                         N/A                        ?
  Oracle Database Server 8.x, 9.x, 10.x         OCIBreak()                 Native error -1013
  PostgreSQL 8.x                                PQCancel()                 SQLSTATE 57014
  Sybase ASA                                    N/A                        ?
  --------------------------------------------- -------------------------- ------------------------------------------
