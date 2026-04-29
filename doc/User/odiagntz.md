[Back to Contents](../index.html)

------------------------------------------------------------------------

# ODI Adaptation Guide For Netezza 6.0.x

Installation

::: {align="center"}
  ---------------------------------------------------------
  [Install Netezza and create a database](#ODINTZ_PREP01)
  [Prepare the runtime environment](#ODINTZ_PREP02)
  ---------------------------------------------------------
:::

Database concepts

::: {align="center"}
  ------------------------------------------------------------
  [Database concepts](#ODINTZ007a)
  [Data consistency and concurrency management](#ODINTZ008a)
  [Transactions handling](#ODINTZ009)
  [Defining database users](#ODINTZ016)
  ------------------------------------------------------------
:::

Data dictionary

::: {align="center"}
  ----------------------------------------------
  [BOOLEAN data type](#ODINTZ041)
  [CHARACTER data types](#ODINTZ011)
  [NUMERIC data types](#ODINTZ021)
  [DATE and DATETIME data types](#ODINTZ001)
  [INTERVAL data type](#ODINTZ036)
  [SERIAL data types](#ODINTZ005)
  [ROWIDs](#ODINTZ004)
  [Indexes](#ODINTZ037)
  [Very large data types](#ODINTZ030)
  [Constraints](#ODINTZ012)
  [Triggers](#ODINTZ013)
  [Stored procedures](#ODINTZ014)
  [Name resolution of SQL objects](#ODINTZ019)
  [Data type conversion table](#ODINTZ100)
  ----------------------------------------------
:::

Data manipulation

::: {align="center"}
  ----------------------------------------------
  [Reserved words](#ODINTZ003)
  [Outer joins](#ODINTZ006)
  [Transactions handling](#ODINTZ009)
  [Temporary tables](#ODINTZ017)
  [Substrings in SQL](#ODINTZ018)
  [The LENGTH( ) function](#ODINTZ011b)
  [Name resolution of SQL objects](#ODINTZ019)
  [String delimiters](#ODINTZ020)
  [MATCHES and LIKE conditions](#ODINTZ024)
  [Querying system catalog tables](#ODINTZ033)
  [Syntax of UPDATE statements](#ODINTZ034)
  [The LENGTH() function](#ODINTZ035)
  ----------------------------------------------
:::

BDL programming

::: {align="center"}
  ---------------------------------------------------------
  [UPDATE limitations](#ODINTZ010)
  [SERIAL data type](#ODINTZ005)
  [INFORMIX specific SQL statements in BDL](#ODINTZ025)
  [INSERT cursors](#ODINTZ028)
  [Cursors WITH HOLD](#ODINTZ031)
  [SELECT FOR UPDATE](#ODINTZ008b)
  [UPDATE/DELETE WHERE CURRENT OF \<cursor\>](#ODINTZ032)
  [The LOAD and UNLOAD instructions](#ODINTZ046)
  [SQL Interruption](#ODINTZ047)
  [Scrollable Cursors](#ODINTZ048)
  ---------------------------------------------------------
:::

------------------------------------------------------------------------

## [Runtime configuration]{#ODINTZ_PREP}

> ### [Install Netezza and create a database]{#ODINTZ_PREP01}
>
> 1.  A Netezza appliance (the server) must be available. For proof of
>     concept, development or testing, you can register at Netezza
>     Development Partner Access to get access to the Netezza hosts
>     provided for education and development. Another option is to get a
>     Netezza emulator to run it in-house in a virtual machine
>     environment.\
>     For more details, check
>     [http://partner.netezza.com](http://www.netezza.com).
>
> 2.  Install the Netezza client software with the Netezza ODBC driver
>     on the application server.
>
> 3.  Create a Netezza database with the **nzsql** utility. You must
>     connect to the **system** database:\
>     \
>        \$ nzsql -h *hostname* system *username password*
>
> 4.  Create the **application tables**. Do not forget to convert
>     INFORMIX data types to Netezza data types. See issue
>     [ODINTZ100](#ODINTZ100) for more details.
>
> 5.  If you plan to use the SERIAL emulation, you must prepare the
>     database. See issue [ODINTZ005](#ODINTZ005) for more details.

> ### [Prepare the runtime environment]{#ODINTZ_PREP02}
>
> 1.  In order to connect to Netezza, you must have a Netezza database
>     driver \"**dbmntz\***\" in FGLDIR/dbdrivers.
>
> 2.  The **Netezza** **client software with ODBC driver** is required
>     to connect to a Netezza appliance. Check if the Netezza ODBC
>     client library (**libnzodbc.\***) is installed on the machine
>     where the 4gl programs run.
>
> 3.  Make sure that the Netezza client environment variables are
>     properly set. Check for example **NZ_DIR** (the path to the
>     installation directory), **NZ_ODBC_INI_PATH** (the path to the
>     ODBC data source file), etc. See Netezza documentation for more
>     details.
>
> 4.  Verify the environment variable defining the search path for
>     database client shared libraries (libnzodbc.so on UNIX, ODBC32.DLL
>     on Windows). On UNIX platforms, the variable is specific to the
>     operating system. For example, on Solaris and Linux systems, it is
>     **LD_LIBRARY_PATH**, on AIX it is **LIBPATH**, or HP/UX it is
>     **SHLIB_PATH**. On Windows, you define the DLL search path in the
>     **PATH** environment variable.
>
>     +-----------------------------------+-----------------------------------+
>     | **Netezza** **version**           | **Shared library environment      |
>     |                                   | setting**                         |
>     +-----------------------------------+-----------------------------------+
>     | **Netezza** **6.0 and higher**    | *UNIX*: Add **\$NZ_DIR/lib** (for |
>     |                                   | 32 bit) or **\$NZ_DIR/lib64**     |
>     |                                   | (for 64 bit) to LD_LIBRARY_PATH   |
>     |                                   | (or its equivalent).\             |
>     |                                   | *Windows*: Add **%NZ_DIR%\\bin**  |
>     |                                   | to PATH.                          |
>     +-----------------------------------+-----------------------------------+
>     |                                   |                                   |
>     +-----------------------------------+-----------------------------------+
>
> 5.  You can test the client environment by trying to connect to the
>     server with the SQL command line tool:\
>     \
>        \$ nzsql -h *hostname* system *username password*
>
> 6.  Set up the **fglprofile** entries for [database
>     connections](Connections.html#DS_ODI_DBVSPEC).\
>     \
>     **Warning:** **Make sure that you are using the ODI driver
>     corresponding to the database client and server version. Because
>     Informix features emulation are dependant from the database server
>     version, it is mandatory to use the same version of the database
>     client and ODI driver as the server version.**

------------------------------------------------------------------------

[ODINTZ001 - DATE and DATETIME data types]{#ODINTZ001}

INFORMIX provides two data types to store dates and time information:

- **DATE** = for year, month and day storage.
- **DATETIME** = for year to fraction(1-5) storage.

Netezza provides the following data type to store date and time
information:

- **DATE** = for year, month, day storage.
- **TIME** = for hour, minute, second, fraction with (6 decimal
  positions).
- **TIME WITH TIME ZONE / TIMETZ** = same as TIME, with time zone
  information.
- **TIMESTAMP** = for year, month, day, hour, minute, second, fraction
  (with 6 decimal positions).

**String representing date time information:**

INFORMIX is able to convert quoted strings to DATE / DATETIME data if
the string contents matches environment parameters (i.e. DBDATE,
GL_DATETIME). As in INFORMIX, Netezza can convert quoted strings to date
time data. Netezza accepts different date formats, including ISO date
time strings, and you can specify the cast operator (::date, ::time,
::timestamp) after the string literal.

**Date arithmetic:**

- INFORMIX supports date arithmetic on DATE and DATETIME values. The
  result of an arithmetic expression involving dates/times is a number
  of days when only DATEs are used and an INTERVAL value if a DATETIME
  is used in the expression.
- In Netezza, the result of an arithmetic expression involving DATE
  values is an INTEGER representing a number of days.
- INFORMIX automatically converts an integer to a date when the integer
  is used to set a value of a date column. Netezza does not support this
  automatic conversion.
- Complex DATETIME expressions ( involving INTERVAL values for example)
  are INFORMIX specific and have no equivalent in Netezza.

**Using DATE/DATETIME variables in SQL statements**

INFORMIX supports implicit DATE/DATETIME conversions, for example you
can use a DATE variable when the target column is a DATETIME. This is
not possible with Netezza: The type of the SQL parameter must match the
type of the column in the database table. 

**[*Solution:*]{.underline}**

Netezza has the same **DATE** data type as INFORMIX ( year, month, day
). So you can use Netezza DATE data type for INFORMIX DATE columns.

Netezza **TIME** data type can be used to store INFORMIX DATETIME HOUR
TO SECOND values. The database interface makes the conversion
automatically.

INFORMIX DATETIME values with any precision from YEAR to FRACTION(5) can
be stored in Netezza **TIMESTAMP** columns. The database interface makes
the conversion automatically. Missing date or time parts default to
1900-01-01 00:00:00.0. For example, when using a DATETIME HOUR TO MINUTE
with the value of \"11:45\", the Netezza TIMESTAMP value will be
\"1900-01-01 11:45:00.0\".

**Warning:** Make sure that you are using the same type for the SQL
parameter and the target column, DATE/DATETIME implicit conversion is
not supported by Netezza.

**Warning:** SQL Statements using expressions with TODAY / CURRENT / 
EXTEND must be reviewed and adapted to the native syntax.

**Warning:** Literal DATETIME and INTERVAL expressions (i.e. DATETIME (
1999-10-12) YEAR TO DAY) are not converted.

------------------------------------------------------------------------

[ODINTZ003 - Reserved words]{#ODINTZ003}

INFORMIX allows to use SQL language keywords for database object names
(tables, columns):

    CREATE TABLE table ( int INT, date DATE )

In Netezza, SQL object names like table and column names cannot be SQL
reserved keywords.

***[Solution:]{.underline}***

Table or column names which are Netezza reserved keywords must be
renamed.

See Netezza SQL Reference guide for a list of reserved keywords.

------------------------------------------------------------------------

[ODINTZ004 - ROWIDs]{#ODINTZ004}

When creating a table, INFORMIX automatically adds a \"ROWID\" integer
column (applies to non-fragmented tables only). The ROWID column is
auto-filled with a unique number and can be used like a primary key to
access a given row.

Netezza implements ROWIDs like Informix, except that in Netetzza, the
rowids are stored in a 64 bit integer.

***[Solution:]{.underline}***

ROWIDs can be used with Netezza like when connected to Informix, as long
as you fetch rowid values into a BIGINT variable. But you should avoid
ROWID-based code and use primary key constraints instead.

**Warning:** The SQLCA.SQLERRD\[6\] register cannot be supported,
because Netezza rowids as 64 bit integers (BIGINT) while
SQLCA.SQLERRD\[6\] is an 32 bit integer (INTEGER). Therefore, all
references to SQLCA.SQLERRD\[6\] must be removed because this variable
will not contain the ROWID of the last INSERTed or UPDATEd row.

------------------------------------------------------------------------

## [ODINTZ005 - SERIAL data types]{#ODINTZ005}

INFORMIX supports the SERIAL, SERIAL8 and BIGSERIAL data types to
produce automatic integer sequences. SERIAL is based on INTEGER (32
bit), while SERIAL8 and BIGSERIAL can store 64 bit integers:

- The table column must be of type SERIAL, SERIAL8 or BIGSERIAL.
- To generate a new serial, no value or a zero value is specified in the
  INSERT statement:\
     INSERT INTO tab1 ( c ) VALUES ( \'aa\' )\
     INSERT INTO tab1 ( k, c ) VALUES ( 0, \'aa\' )
- After INSERT, the new SERIAL value is provided in SQLCA.SQLERRD\[2\],
  while the new SERIAL8 and BIGSERIAL value must be fetched with a
  SELECT dbinfo(\'bigserial\') query.

INFORMIX allows you to insert rows with a value different from zero for
a serial column. Using an explicit value will automatically increment
the internal serial counter, to avoid conflicts with future INSERT
statements that are using a zero value :\
    CREATE TABLE tab ( k SERIAL ); \--\> internal counter = 0\
    INSERT INTO tab VALUES ( 0 );   \--\> internal counter = 1\
    INSERT INTO tab VALUES ( 10 );  \--\> internal counter = 10\
    INSERT INTO tab VALUES ( 0 );   \--\> internal counter = 11\
    DELETE FROM tab;                \--\> internal counter = 11\
    INSERT INTO tab VALUES ( 0 );   \--\> internal counter = 12

**Warning:** Netezza does not have a SERIAL data type. Version 6 of the
database supports SEQUENCEs, but not triggers. The lack if triggers
support makes it impossible to emulate Informix SERIALs.

**[*Solution:*]{.underline}**

If you are using Informix SERIALs or BIGSERIALs, you must review the
application logic and database schema to replace SERIAL/BIGSERIAL
columns by INTEGER/BIGINT columns, and generate the new keys from a
SEQUENCE as described in the [SQL Programming
page](SqlProgramming.html#AUTOINCR_NATIVE).

------------------------------------------------------------------------

[ODINTZ006 - Outer joins]{#ODINTZ006}

In INFORMIX SQL, outer tables can be defined in the FROM clause with the
**OUTER** keyword:

> SELECT ... FROM a, OUTER(b)
>      WHERE a.key = b.akey
>
>     SELECT ... FROM a, OUTER(b,OUTER(c))
>      WHERE a.key = b.akey
>        AND b.key1 = c.bkey1
>        AND b.key2 = c.bkey2 

Netezza supports the ANSI outer join syntax:

> SELECT ... FROM cust LEFT OUTER JOIN order
>                          ON cust.key = order.custno
>
>     SELECT ...
>       FROM cust LEFT OUTER JOIN order
>                      LEFT OUTER JOIN item
>                      ON order.key = item.ordno
>                 ON cust.key = order.custno
>      WHERE order.cdate > current date

See the Netezza reference for a complete description of the syntax.

***[Solution:]{.underline}***

For better SQL portability, you should use the ANSI outer join syntax
instead of the old Informix OUTER syntax.

The Netezza interface can convert most INFORMIX OUTER specifications to
ANSI outer joins.

Prerequisites:

1.  In the FROM clause, the main table must be the first item and the
    outer tables must figure from left to right in the order of outer
    levels.\
       Example which does not work : \"FROM OUTER(tab2), tab1\".
2.  The outer join in the WHERE part must use the table name as prefix.\
       Example : \"WHERE tab1.col1 = tab2.col2\".

Restrictions:

1.  Additional conditions on outer table columns cannot be detected and
    therefore are not supported:\
      Example : \"\... FROM tab1, OUTER(tab2) WHERE tab1.col1 =
    tab2.col2 AND tab2.colx \> 10\".
2.  Statements composed of 2 or more SELECT instructions using OUTERs
    are not supported.\
      Example : \"SELECT \... UNION SELECT\" or \"SELECT \... WHERE col
    IN (SELECT\...)\"

Remarks:

1.  Table aliases are detected in OUTER expressions.\
       OUTER example with table alias : \"OUTER( tab1 alias1)\".
2.  In the outer join, \<outer table\>.\<col\> can be placed on both
    right or left sides of the equal sign.\
       OUTER join example with table on the left : \"WHERE outertab.col1
    = maintab.col2 \".
3.  Table names detection is not case-sensitive.\
       Example : \"SELECT \... FROM tab1, TAB2 WHERE tab1.col1 =
    tab2.col2\".
4.  [Temporary tables](#ODINTZ017) are supported in OUTER
    specifications.

------------------------------------------------------------------------

[ODINTZ007a - Database concepts]{#ODINTZ007a}

Most BDL applications use only one database entity (in the meaning of
INFORMIX). But the same BDL application can connect to different
occurrences of the same database schema, allowing several users to
connect to those different databases.

Like INFORMIX servers, Netezza can handle multiple database entities.
Tables created by a user can be accessed without the owner prefix by
other users as long as they have access privileges to these tables.

**[*Solution:*]{.underline}**

Create a Netezza database for each INFORMIX database.

------------------------------------------------------------------------

[ODINTZ008a - Data consistency and concurrency management]{#ODINTZ008a}

**Data consistency** involves readers which want to access data
currently modified by writers and **concurrency data access** involves
several writers accessing the same data for modification. **Locking
granularity** defines the amount of data concerned when a lock is set
(row, page, table, \...).

**INFORMIX**

INFORMIX uses a locking mechanism to handle data consistency and
concurrency. When a process changes database information with UPDATE,
INSERT or DELETE, an **exclusive lock** is set on the touched rows. The
lock remains active until the end of the transaction. Statements
performed outside a transaction are treated as a transaction containing
a single operation and therefore release the locks immediately after
execution. SELECT statements can set **shared locks** according to the
**isolation level**. In case of locking conflicts (for example, when two
processes want to acquire an exclusive lock on the same row for
modification or when a writer is trying to modify data protected by a
shared lock), the behavior of a process can be changed by setting the
**lock wait mode**.

Control:

- Lock wait mode : SET LOCK MODE TO \...
- Isolation level : SET ISOLATION TO \...
- Locking granularity : CREATE TABLE \... LOCK MODE {PAGE\|ROW}
- Explicit exclusive lock : SELECT \... FOR UPDATE

Defaults:

- The default isolation level is read committed.
- The default lock wait mode is \"not wait\".
- The default locking granularity is per page.

[**Netezza**]{.underline}

Netezza servers are designed for Data Warehouse applications, not for
OLTP applications: Concurrent data access is not the best thing that a
Netezza server can do. There are a bunch of limitations that you must be
aware of. You must not expect to be able to migrate an existing OLTP
application running against Informix or Oracle on a Netezza database
server. The purpose of a Netezza-based application is mostly to do
queries, with few insert or updates. Typically a Netezza database is fed
with data by using tools such as nzload, not by Genero BDL programs.

Some limitations of Netezza:

- An application can only execute one cursor (or statement handle) at a
  time.
- Singular data modification statements (INSERT, UPDATE, DELETE) are
  much slower as with traditional OLTP database servers.\
  Netezza is however very good when it comes to load a huge amount of
  data, with special tools like the nzload utility.
- SELECT \... FOR UPDATE is not supported. Regular SELECTs do never lock
  rows.
- Locks can only be set for a whole table with LOCK TABLE.
- Only up to 31 concurrent INSERTs processes are allowed (Netezza V6),
  and there must be only INSERTs in a transaction block.
- UPDATE/DELETE statements lock the entire table, but don\'t prevent
  SELECTs. Other processes doing UPDATEs/DELETEs will wait until the
  first session has committed.
- Netezza (V6) understands the SET TRANSACTION ISOLATION statement, but
  currently implements only the SERIALIZABLE level.
- There is no way to define the LOCK WAIT mode. With Netezza, processes
  always wait for locks to be released.

**[*Solution:*]{.underline}**

Understand that the main difference with INFORMIX is that Netezza is not
good at concurrent data modification. Note also that readers do not have
to wait for writers in Netezza.

Genero application should mainly do queries against a Netezza server.
You must review your program logic when modifying data, having in mind
that only one process can modify a table at the time. Note however that
if you write short transactions this is not visible to the end users,
except that INSERT / UPDATE / DELETE of a single row takes more time as
with another database server.

**Warning:** The SET ISOLATION TO \... INFORMIX syntax is replaced by
SET TRANSACTION ISOLATION LEVEL \... in Netezza. However, only the
REPEATABLE READ level is supported with Netezza.

The next table shows the isolation level mappings done by the Netezza
database driver:

::: {align="center"}
  ----------------------------------- -----------------------------------
  **SET ISOLATION instruction in      **Native SQL command**
  program**                           

  SET ISOLATION TO DIRTY READ         **Not supported (SQL Error)**

  SET ISOLATION TO COMMITTED READ\    **Not supported (SQL Error)**
    \[READ COMMITTED\] \[RETAIN       
  UPDATE LOCKS\]                      

  SET ISOLATION TO CURSOR STABILITY   **Not supported (SQL Error)**

  SET ISOLATION TO REPEATABLE READ    SET TRANSACTION ISOLATION LEVEL
                                      SERIALIZABLE
  ----------------------------------- -----------------------------------
:::

**Warning:** Since Netezza does not support the lock wait mode, you must
check that your programs do not include a SET LOCK MODE instruction.
This instruction will fail with error [-6370](FglErrors.html#-6370) if
it is executed when connected to Netezza.

See INFORMIX and Netezza documentation for more details about data
consistency, concurrency and locking mechanisms.

------------------------------------------------------------------------

[ODINTZ008b - SELECT FOR UPDATE]{#ODINTZ008b}

A lot of BDL programs use pessimistic locking in order to avoid several
users editing the same rows at the same time.

   DECLARE cc CURSOR FOR\
         SELECT \... FROM tab WHERE \... FOR UPDATE\
   OPEN cc\
   FETCH cc \<\-- lock is acquired\
   \...\
   CLOSE cc \<\-- lock is released

In both INFORMIX and Netezza, locks are released when closing the cursor
or when the transaction ends.

**Warning:** Netezza does not support SELECT FOR UPDATE statements.

**[*Solution:*]{.underline}**

You must review the program logic if you use SELECT FOR UPDATE
statements. Actually Netezza systems are designed for data warehouse
applications, not for OLTP applications. In a DW context, concurrent
data access is not required or a priority.

------------------------------------------------------------------------

[ODINTZ009 - Transactions handling]{#ODINTZ009}

Compared to INFORMIX, Netezza has a couple of limitations regarding
transactions and [concurrent data access](#ODINTZ008a).

INFORMIX native mode (non ANSI):

- Transactions are started with BEGIN WORK.
- Transactions are validated with COMMIT WORK.
- Transactions are canceled with ROLLBACK WORK.
- Savepoints can be set with SAVEPOINT *name* \[UNIQUE\].
- Transactions can be rolled back to a savepoint with ROLLBACK \[WORK\]
  TO SAVEPOINT \[*name*\].
- Savepoints can be released with RELEASE SAVEPOINT *name*.
- Statements executed outside of a transaction are automatically
  committed.
- DDL statements can be executed (and canceled) in transactions.

Netezza:

- Transactions are started with BEGIN WORK.
- Transactions are validated with COMMIT WORK.
- Transactions are canceled with ROLLBACK WORK.
- Statements executed outside of a transaction are automatically
  committed.
- DDL statements can be executed (and canceled) in transactions.
- If an SQL error occurs in a transaction, the whole transaction is
  aborted.
- Transaction must only contain INSERTs if you want concurrent processes
  to insert rows at the same time (UPDATEs/DELETEs lock the whole
  table).
- Only the SERIALIZABLE isolation level is implemented by Netezza.

**Warning:** Netezza cancels the whole transaction if an SQL error
occurs in one of the statements executed inside the transaction. The
following code example illustrates this difference:

   CREATE TABLE tab1 ( k INT PRIMARY KEY, c CHAR(10) )\
   WHENEVER ERROR CONTINUE\
   BEGIN WORK\
   INSERT INTO tab1 ( 1, \'abc\' )\
   DELECT FROM unexisting WHERE key = 123   \-- un-existing table = sql
error\
   COMMIT WORK

With INFORMIX, this code will leave the table with one row inside, since
the first INSERT statement succeeded. With Netezza, the table will
remain empty after executing this piece of code, because the server will
rollback the whole transaction.

**[*Solution:*]{.underline}**

Regarding the transaction control instructions, the BDL applications do
not have to be modified in order to work with Netezza: INFORMIX
transaction handling commands are automatically converted to Netezza
instructions to start, validate or cancel transactions. However, since
Netezza is not designed for OLTP applications, you must review the code
doing complex data modifications. See the [concurrency](#ODINTZ008a)
topic for more details.

**Warning:** You must review the SQL statements inside BEGIN WORK /
COMMIT WORK instruction and check if these can raise and SQL error. To
get the same behavior also when connected to a different database as
Netezza, in case of error, you must issue a ROLLBACK to cancel all the
SQL statements that succeeded in the transaction, for example with a
[TRY/CATCH](Exceptions.html#TRYCATCH) block.

   TRY\
      BEGIN WORK\
      \...\
      COMMIT WORK\
   CATCH\
      ROLLBACK WORK\
   END TRY

------------------------------------------------------------------------

## [ODINTZ010 - UPDATE limitations]{#ODINTZ010}

Netezza has some limitations regarding the UPDATE statement:

- Like DELETE, an UPDATE statement locks the entire table.
- It is not possible to UPDATE *distribution columns*:\
  Netezza database tables get distributed across all of the nodes using
  the distribution column.\
  You can specify the distribution column(s) when you create the table.
  See Netezza documentation for more details.\
  If you try to update a distribution column, you get the error 46
  \"Attempt to UPDATE a distribution column\". 

**[*Solution:*]{.underline}**

Review the program logic if the UPDATE statements in your programs uses
distribution columns, and keep in mind that an UPDATE will lock the
entire table.

------------------------------------------------------------------------

## [ODINTZ041 - BOOLEAN data type]{#ODINTZ041}

INFORMIX supports the BOOLEAN data type, which can store \'t\' or \'f\'
values. Genero BDL implements the BOOLEAN data type in a different way:
As in other programming languages, Genero BOOLEAN stores integer values
1 or 0 (for TRUE or FALSE). The type was designed this way to assign the
result of a Boolean expression to a BOOLEAN variable.

Netezza supports the BOOLEAN data type and stores \'t\' or \'f\' values
for TRUE and FALSE representation. It is not possible to insert the
integer values 1 or 0: Values must be true, false, \'t\', \'f\', \'1\'
or \'0\'.

**[*Solution:*]{.underline}**

The Netezza database interface supports the BOOLEAN data type, and
converts the BDL BOOLEAN integer values to a CHAR(1) of \'1\' or \'0\'.

------------------------------------------------------------------------

## [ODINTZ011 - CHARACTER data types]{#ODINTZ011}

INFORMIX supports following character data types:

- CHAR(N) with N\<= 32767 bytes
- VARCHAR(N\[,M\]) with N\<=255 bytes
- NCHAR(N) with N\<= 32767 bytes
- NVARCHAR(N\[,M\]) with N\<=255 bytes

In INFORMIX, both CHAR/VARCHAR and NCHAR/ NVARCHAR data types can be
used to store single-byte or multi-byte encoded character strings. The
only difference between CHAR/VARCHAR and NCHAR/NVARCHAR is for sorting:
N\[VAR\]CHAR types use the collation order, while \[VAR\]CHAR types use
the byte order. The character set used to store strings in
CHAR/VARCHAR/NCHAR/NVARCHAR columns is defined by the DB_LOCALE
environment variable. The character set used by applications is defined
by the CLIENT_LOCALE environment variable. Note that INFORMIX uses Byte
Length Semantics (the size N that you specify in \[VAR\]CHAR(N) is
expressed in bytes, not characters as in some other databases)

Netezza supports the following character data types:

- CHAR(N) with N \<= 64000 characters
- VARCHAR(N) with N \<= 64000 characters
- NCHAR(N) with N \<= 16000 characters
- NVARCHAR(N) with N \<= 16000 characters

Netezza stores single-byte character data in CHAR/VARCHAR columns, and
stores UNICODE (UTF-8 encoded) character strings in NCHAR/NVARCHAR
columns.

**Warning:** You cannot store UTF-8 strings in CHAR/VARCHAR columns.

NCHAR/NVARCHAR data is always stored in UTF-8. The database character
defines the encoding for CHAR and VARCHAR columns and is defined when
creating the database with the CREATE DATABASE command, default is
latin9. Note that while writing these lines, Netezza V6 does not support
yet a different database character set as latin9.

**Warning:** No automatic character set conversion is done by the
Netezza software, this means that the application/client character set
must match the database character set.

**[*Solution:*]{.underline}**

If your application uses a single-byte character set (i.e. latin9), you
can create tables with the CHAR and VARCHAR types. However, if you want
to store UNICODE (UTF-8) strings, you must use the NCHAR/NVARCHAR types
instead when creating tables. Note that in Genero sources you can use
CHAR/VARCHAR, these types can hold single and multi-byte character sets,
according to the C POSIX locale.

**Warning:** Netezza (V6 while writing these lines) supports only the
latin9 database character set for CHAR / VARCHAR types. Since character
set conversion is not supported, you can only implement either latin9 or
UTF-8 based applications.

See also the section about [Localization](Localization.html).

------------------------------------------------------------------------

[ODINTZ011b - The LENGTH( ) function]{#ODINTZ011b}

In INFORMIX, the LENGTH() function counts the number of bytes of a
string expression, by ignoring the trailing blanks.

Netezza supports a LENGTH() and CHARACTER_LENGTH() functions, but these
count the number of characters (not bytes), and trailing blanks are
significant.

**Warning:** Netezza returns NULL if the LENGTH() parameter is NULL.
INFORMIX returns zero instead.

***[Solution:]{.underline}***

The Netezza database interface cannot simulate the behavior of the
INFORMIX LENGTH() SQL function.

Review the program logic and make sure you do not pass NULL values to
the LENGTH() SQL function.

------------------------------------------------------------------------

## [ODINTZ012 - Constraints]{#ODINTZ012}

**Constraint naming syntax:**

Both INFORMIX and Netezza support primary key, unique, foreign key,
default and check constraints, but the constraint naming syntax is
different. Netezza expects the \"CONSTRAINT\" keyword **before** the
constraint specification and INFORMIX expects it **after**.

**UNIQUE constraint example:**

  ----------------------------------- -----------------------------------
  **INFORMIX**                        **Netezza**

  CREATE TABLE scott.emp (\           CREATE TABLE scott.emp (\
  \...\                               \...\
  empcode CHAR(10) UNIQUE\            empcode CHAR(10)\
     **\[CONSTRAINT pk_emp\]**,\         **\[CONSTRAINT pk_emp\]**
  \...                                UNIQUE,\
                                      \...
  ----------------------------------- -----------------------------------

**Warning:** Netezza allows to create tables with the UNIQUE and PRIMARY
KEY and FOREIGN KEY syntax, but the constraints are not enforced.

**[*Solution:*]{.underline}**

The database interface does not convert constraint naming expressions
when creating tables from BDL programs. Review the database creation
scripts to adapt the constraint naming clauses for Netezza.

**Warning:** Since Netezza does not enforce constraints, you must test
for unique values and foreign key references at the program level.

------------------------------------------------------------------------

## [ODINTZ013 - Triggers]{#ODINTZ013}

INFORMIX supports triggers on database tables.

**Warning:** Netezza does not support triggers.

**[*Solution:*]{.underline}**

INFORMIX triggers must be re-written in 4GL.

------------------------------------------------------------------------

[ODINTZ014 - Stored procedures]{#ODINTZ014}

INFORMIX supports stored procedures with the SPL language, and with the
Java / C as User Defined Routines.

Netezza supports stored procedures with the NZPLSQL language.

In Netezza (V6), a stored procedure must always return a value (see the
RETURNS clause). The value returned from a stored procedure can be
either a simple scalar value, or a result set (REFTABLE). Netezza has a
limited support for stored procedures producing result sets (you must
use dynamic SQL in the stored procedure). See Netezza documentation for
more details.

**Warning:** Netezza does not support OUTPUT parameters for stored
procedures, only one single value or a result set can be returned.

**[*Solution:*]{.underline}**

INFORMIX stored procedures must be re-written in Netezza language, and
the call from programs is slightly different from Informix.

To call a stored procedure returning a simple scalar value, do
following:

    PREPARE s1 FROM \"SELECT myproc(?,?,?)\"\
    EXECUTE s1 USING var1, var2, var3 INTO res

To call a stored procedure returning a result set:

    PREPARE s1 FROM \"SELECT myproc(?,?,?)\"\
    OPEN s1 USING var1, var2, var3\
    FETCH s1 INTO record.\*\
    FETCH s1 INTO record.\*\
    \...

------------------------------------------------------------------------

## [ODINTZ016 - Defining database users]{#ODINTZ016}

INFORMIX users are defined at the operating system level, they must be
members of the \'informix\' group, and the database administrator must
grant CONNECT, RESOURCE or DBA privileges to those users.

Netezza users must be registered in the database with the CREATE USER
command, for example:

   CREATE USER *name* WITH PASSWORD \'*pswd*\' IN GROUP \...

See Netezza documentation for more details about user creation and
database access/security.

**[*Solution:*]{.underline}**

According to the application logic (is it a multi-user application ?),
you have to create one or several Netezza users.

------------------------------------------------------------------------

[ODINTZ017 - Temporary tables]{#ODINTZ017}

INFORMIX temporary tables are created through the **CREATE TEMP TABLE**
DDL instruction or through a **SELECT \... INTO TEMP** statement.
Temporary tables are automatically dropped when the SQL session ends,
but they can be dropped with the DROP TABLE command. There is no name
conflict when several users create temporary tables with the same name.

INFORMIX allows you to create indexes on temporary tables. No name
conflict occurs when several users create an index on a temporary table
by using the same index identifier.

Netezza support temporary tables as INFORMIX does, with a little syntax
difference in the SELECT INTO TEMP instruction.

***[Solution:]{.underline}***

Temporary tables are well supported with native Netezza temp tables.

------------------------------------------------------------------------

[ODINTZ018 - Substrings in SQL]{#ODINTZ018}

INFORMIX SQL statements can use subscripts on columns defined with the
character data type:

    SELECT \... FROM tab1 WHERE **col1\[2,3\]** = \'RO\'\
    SELECT \... FROM tab1 WHERE **col1\[10\]**  = \'R\'   \-- Same as
col1\[10,10\]\
    UPDATE tab1 SET **col1\[2,3\]**= \'RO\' WHERE \...\
    SELECT \... FROM tab1 ORDER BY **col1\[1,3\]**

.. while Netezza provides the SUBSTR( ) function, to extract a substring
from a string expression:

    SELECT \.... FROM tab1 WHERE **SUBSTRING(col1 from 2 for 2)** =
\'RO\'\
    SELECT **SUBSTRING(\'Some text\' from 6 for 3)** \...   \-- Gives
\'tex\'

**[*Solution:*]{.underline}**

You must replace all INFORMIX col\[x,y\] expressions by SUBSTRING( col
from x for (y-x+1) ).

**Warning:** In UPDATE instructions, setting column values through
subscripts will produce an error with Netezza :\
    UPDATE tab1 SET **col1\[2,3\]** = \'RO\' WHERE \...\
converted to:\
    UPDATE tab1 SET **SUBSTRING(col1 from 2 for (3-2+1))** = \'RO\'
WHERE \...

------------------------------------------------------------------------

[ODINTZ019 - Name resolution of SQL objects]{#ODINTZ019}

INFORMIX uses the following form to identify an SQL object :

  \[database\[@dbservername\]:\]\[{owner\|\"owner\"}.\]identifier

With Netezza, an object name takes the following form:

  \[database.\[schema\].\]identifier

**[*Solution:*]{.underline}**

For maximum SQL portability, we strongly recommend you to use only
singular table names in your source code, without double quote
delimiters.

------------------------------------------------------------------------

[ODINTZ020 - String delimiters]{#ODINTZ020}

The ANSI string delimiter character is the single quote ( \'string\').
Double quotes are used to delimit database object names
(\"object-name\").

Example: WHERE \"tabname\".\"colname\" = \'a string value\'

INFORMIX allows double quotes as string delimiters, but Netezza
doesn\'t. This is important since many BDL programs use that character
to delimit the strings in SQL commands.

Note: This problem concerns only double quotes within SQL statements.
Double quotes used in pure BDL string expressions are not subject to SQL
compatibility problems.

***[Solution:]{.underline}***

The Netezza database interface can automatically replace all double
quotes by single quotes.

Escaped string delimiters can be used inside strings like following:

     \'This is a single quote: \'\'\'\
     \'This is a single quote : \\\'\'\
     \"This is a double quote : \"\"\"\
     \"This is a double quote : \\\"\"

**Warning:** Database object names cannot be delimited by double quotes
because the database interface cannot determine the difference between a
database object name and a quoted string!

For example, if the program executes the SQL statement:\
  WHERE \"tabname\".\"colname\" = \"a string value\"\
replacing all double quotes by single quotes would produce:\
 WHERE \'tabname\'.\'colname\' = \'a string value\'\
This would produce an error since \'tabname\'.\'colname\' is not allowed
by Netezza.

Although double quotes are replaced automatically in SQL statements, you
should use only single quotes to enforce portability.

------------------------------------------------------------------------

[ODINTZ021 - NUMERIC data types]{#ODINTZ021}

INFORMIX supports several data types to store numbers:

::: {align="center"}
  ------------------------ ---------------------------------------------------------------------------
  **INFORMIX Data Type**   **Description**
  SMALLINT                 16 bit signed integer
  INT/INTEGER              32 bit signed integer
  BIGINT                   64 bit signed integer
  INT8                     64 bit signed integer (replaced by BIGINT)
  SMALLINT                 16 bit integer  ( -2\^15 to 2\^15 )
  INT/INTEGER              32 bit integer  ( -2\^31 to 2\^31 )
  DEC/DECIMAL(p)           Floating-point exact decimal number, with p significant digits
  DEC/DECIMAL(p,s)         Fixed-point exact decimal number, with p significant digits as s decimals
  MONEY                    Equivalent to DECIMAL(16,2)
  MONEY(p)                 Equivalent to DECIMAL(p,2)
  MONEY(p,s)               Equivalent to DECIMAL(p,s)
  REAL/SMALLFLOAT          approx floating point (C float)
  DOUBLE PREC./FLOAT       approx floating point (C double)
  ------------------------ ---------------------------------------------------------------------------
:::

**[*Solution:*]{.underline}**

Netezza supports the following data types to store numbers:

::: {align="center"}
  ------------------------------ -----------------------------------------------------------------------------
  **Netezza** **data type**      **Description**
  BYTEINT                        8-bit value with the range -128 to 127
  SMALLINT                       16 bit signed integer
  INTEGER                        32 bit signed integer
  BIGINT                         64 bit signed integer
  NUMERIC(p,s) / DECIMAL(p,s)    Exact decimal number with p significant digits and s decimals (1\<=p\<=38) 
  NUMERIC(p) / DECIMAL(p)        Integer with precision p (1\<=p\<=38) 
  NUMERIC / DECIMAL              Integer, same as NUMERIC(18,0)
  FLOAT(p) with 1 \<= p \<= 6    16 bit approx floating point (C float)
  FLOAT(p) with 7 \<= p \<= 15   32 bit approx floating point (C double)
  REAL                           same as FLOAT(6)
  DOUBLE PRECISION               same as FLOAT(15)
  ------------------------------ -----------------------------------------------------------------------------
:::

**Warning: There is no Netezza equivalent for the INFORMIX DECIMAL(p)
floating point decimal (i.e. without a scale). If your application is
using such data types, you must review the database schema in order to
use Netezza compatible types. To workaround the Netezza limitation, the
NTZ database drivers converts DECIMAL(p) types to a DECIMAL( 2\*p, p ),
to store all possible numbers an INFORMIX DECIMAL(p) can store. However,
the original INFORMIX precision cannot exceed 19, since Netezza maximum
DECIMAL precision is 38 (2\*19). If the original precision is bigger as
19, a CREATE TABLE statement executed from a Genero program will fail
with an SQL error.**

------------------------------------------------------------------------

[ODINTZ024 - MATCHES and LIKE in SQL conditions]{#ODINTZ024}

INFORMIX supports MATCHES and LIKE in SQL statements. Netezza supports
the LIKE statement as in INFORMIX, plus the \~ operators that are
similar but different from the INFORMIX MATCHES operator.

MATCHES allows brackets to specify a set of matching characters at a
given position :\
   ( col MATCHES \'\[Pp\]aris\' ).\
   ( col MATCHES \'\[0-9\]\[a-z\]\*\' ).\
In this case, the LIKE statement has not equivalent feature.

The following substitutions must be made to convert a MATCHES condition
to a LIKE condition :

- MATCHES keyword must be replaced by LIKE.
- All \'\*\' characters must be replaced by \'%\'.
- All \'?\' characters must be replaced by \'\_\'.
- Remove all brackets expressions.

Netezza \~ operator expects regular expressions as follows:\
   ( col \~ \'a.\*\' )

***[Solution:]{.underline}***

**Warning:** SQL statements using MATCHES expressions must be reviewed
in order to use LIKE expressions.

See also: [MATCHES operator in SQL
Programming](SqlProgramming.html#PORT_MATCHES).

------------------------------------------------------------------------

[ODINTZ025 - INFORMIX specific SQL statements in BDL]{#ODINTZ025}

The BDL compiler supports several INFORMIX specific SQL statements that
have no meaning when using Netezza.

- CREATE DATABASE
- DROP DATABASE
- START DATABASE (SE only)
- ROLLFORWARD DATABASE
- SET \[BUFFERED\] LOG
- CREATE TABLE with special options (storage, lock mode, etc.)

***[Solution:]{.underline}***

Review your BDL source and review all SQL statements which are INFORMIX
specific.

------------------------------------------------------------------------

[ODINTZ028 - INSERT cursors]{#ODINTZ028}

INFORMIX supports insert cursors. An \"insert cursor\" is a special BDL
cursor declared with an INSERT statement instead of a SELECT statement.
When this kind of cursor is open, you can use the PUT instruction to add
rows and the FLUSH instruction to insert the records into the database.

For INFORMIX database with transactions, OPEN, PUT and FLUSH
instructions must be executed within a transaction.

**Warning:** Netezza does not support insert cursors.

**[*Solution:*]{.underline}**

Insert cursors are emulated by the Netezza database interface.

------------------------------------------------------------------------

[ODINTZ030 - Very large data types]{#ODINTZ030}

INFORMIX provides special data types to store very large texts or
images: TEXT and BYTE.

**Warning:** Netezza (V6) does not support large objects in the
database.

**[*Solution:*]{.underline}**

If your application need to store large objects with TEXT and BYTE data
types, you cannot use a Netezza server. 

------------------------------------------------------------------------

## [ODINTZ031 - Cursors WITH HOLD]{#ODINTZ031}

INFORMIX closes opened cursors automatically when a transaction ends
unless the WITH HOLD option is used in the DECLARE instruction.

**Warning:** With Netezza, cursors can be kept open when a transaction
ends. However, cursors declared with a [SELECT FOR UPDATE](#ODINTZ008b)
are not supported with Netezza.

**[*Solution:*]{.underline}**

Since WITH HOLD cursors are usually declared with SELECT FOR UPDATE and
because Netezza does support SELECT FOR UPDATE, you must review the
program logic if you are using cursors declared WITH HOLD.

------------------------------------------------------------------------

[ODINTZ032 - UPDATE/DELETE WHERE CURRENT OF \<cursor\>]{#ODINTZ032}

INFORMIX allows positioned UPDATEs and DELETEs with the \"WHERE CURRENT
OF \<cursor\>\" clause, if the cursor has been DECLARED with a SELECT
\... FOR UPDATE statement.

**Warning:** Netezza servers do no support [SELECT FOR
UPDATE](#ODINTZ008b), and does not set locks. Thus, positioned
UPDATEs/DELETEs with WHERE CURRENT OF \<cursor\> clause cannot be
supported with Netezza.

**[*Solution:*]{.underline}**

You must review the program logic and rewrite all positioned
UPDATEs/DELETEs with a WHERE condition based on primary keys or rowids.

------------------------------------------------------------------------

[ODINTZ033 - Querying system catalog tables]{#ODINTZ033}

As in INFORMIX, Netezza provides system catalog tables (actually, system
views). But the table names and their structure are quite different.

**[*Solution:*]{.underline}**

**Warning:** No automatic conversion of INFORMIX system tables is
provided by the database interface.

------------------------------------------------------------------------

[ODINTZ034 - Syntax of UPDATE statements]{#ODINTZ034}

INFORMIX allows a specific syntax for UPDATE statements:

    UPDATE table SET ( \<col-list\> ) = ( \<val-list\> )

or

    UPDATE table SET table.\* = myrecord.\*\
    UPDATE table SET \* = myrecord.\*

**[*Solution:*]{.underline}**

Static UPDATE statements using the above syntax are converted **by the
compiler** to the standard form:\
\
    UPDATE table SET column=value \[,\...\]

------------------------------------------------------------------------

[ODINTZ035 - The LENGTH() function]{#ODINTZ035}

INFORMIX provides the LENGTH() function:

    SELECT LENGTH(\"aaa\"), LENGTH(col1) FROM table

Netezza has a equivalent function with the same name, but there is some
difference:

INFORMIX does not count the trailing blanks neither for CHAR not for
VARCHAR expressions, while Netezza counts the trailing blanks.

With the Netezza LENGTH function, when using a CHAR column, values are
always blank padded, so the function returns the size of the CHAR
column. When using a VARCHAR column, trailing blanks are significant,
and the function returns the number of characters, including trailing
blanks.

**[*Solution:*]{.underline}**

You must check if the trailing blanks are significant when using the
LENGTH() function.

If you want to count the number of character by ignoring the trailing
blanks, you must use the RTRIM() function:

------------------------------------------------------------------------

[ODINTZ036 - INTERVAL data type]{#ODINTZ036}

INFORMIX INTERVAL data type stores a value that represents a span of
time. INTERVAL types are divided into two classes : ***year-month
intervals*** and ***day-time intervals***.

Netezza implements the INTERVAL data type in a different way as
INFORMIX.

Netezza allows to specify interval qualifiers (YEAR, MONTH, DAY, \...)
but internally it always uses the same base type, storing values of any
combination of units. Thus, tere is no way do distinguish ***year-month
intervals*** and ***day-time intervals*** with Netezza.

The precision of Netezza intervals includes fraction of seconds with up
to 6 significant digits. However, it is not possible to specify the
scale of a Netezza interval as with the INFORMIX FRACTION(N) qualifier.

With Netezza, interval literals must be include the units, as \"-923
days 11 hours 22 minutes\", while INFORMIX interval literals have the
form INTERVAL(999-99\...) qualifier1 TO qualifier2.

**Warning:** Netezza normalizes all INTERVAL values to units of seconds,
and considers a month to be thirty days for the purpose of interval
comparisons. This approximation can lead to inaccuracies.

**[*Solution:*]{.underline}**

The INFORMIX INTERVAL types of the ***day-time*** class can be mapped to
the native Netezza INTERVAL type, for day to second time interval
storage.

**Warning:** Netezza (V6 while writing these lines) has several bugs
regarding the INTERVAL type, we do not recommend to use this type until
Netezza has fixed these problems.

**Warning:** Since Netezza does not clearly distinguish **year-month**
interval class, such types are converted to CHAR(50) by the Netezza
driver.

------------------------------------------------------------------------

## [ODINTZ037 - Indexes]{#ODINTZ037}

Like most database servers, INFORMIX supports index creation on table
columns. Indexes can be used to make the server find rows rapidely:

CREATE INDEX cust_ix1 ON customer (cust_name)

**Warning:** Netezza does not support index creation on tables. There is
no need for indexes in a Netezza database because performances are
achieved by distributing data rows over several disks. Netezza tracks
min/max values of each column per disk extent to ignore extents which do
not contain the values the query is looking for. See Netezza
documentation for more details.

**[*Solution:*]{.underline}**

Remove all CREATE INDEX instructions from your programs.

------------------------------------------------------------------------

## [ODINTZ046 - The LOAD and UNLOAD instructions]{#ODINTZ046}

INFORMIX provides two SQL instructions to export / import data from /
into a database table: The UNLOAD instruction copies rows from a
database table into a text file and the LOAD instructions insert rows
from a text file into a database table.

Netezza does not provide LOAD and UNLOAD instructions, but provides
external tools like the nzload utility.

**[*Solution:*]{.underline}**

LOAD and UNLOAD instructions are supported.

------------------------------------------------------------------------

[ODINTZ047 - SQL Interruption]{#ODINTZ047}

With INFORMIX, it is possible to interrupt a long running query if the
SQL INTERRUPT ON option is set by the Genero program. The database
server returns SQLCODE -213, which can be trapped to detect a user
interruption.

    MAIN\
      DEFINE n INTEGER\
      DEFER INTERRUPT\
      OPTIONS SQL INTERRUPT ON\
      DATABASE test1\
      WHENEVER ERROR CONTINUE\
      \-- Start long query (self join takes time)\
      \-- From now on, user can hit CTRL-C in TUI mode to stop the
query\
      SELECT COUNT(\*) INTO n FROM customers a, customers b\
           WHERE a.cust_id \<\> b.cust_id\
      IF SQLCA.SQLCODE == -213 THEN\
         DISPLAY \"Statement was interrupted by user\...\"\
         EXIT PROGRAM 1\
      END IF\
      WHENEVER ERROR STOP\
      \...\
    END MAIN

**Warning:** Netezza supports SQL Interruption in a similar way as
INFORMIX. However, when the statement is interrupted, Netezza rolls the
transaction back and returns a \"Transaction rolled back by user\", SQL
error number 46.

[***Solution:***]{.underline}

The Netezza database driver supports SQL interruption and converts the
native SQL error 46 to the INFORMIX error code -213.

------------------------------------------------------------------------

## [ODINTZ048 - Scrollable Cursors]{#ODINTZ048}

The Genero programming language supports scrollable cursors with the
**SCROLL** keyword, as shown in the following code example: 

   DECLARE c1 **SCROLL** CURSOR FOR SELECT \* FROM customers ORDER BY
cust_name\
   \...\
   FETCH FIRST c1 INTO rec_cust.\*\
   \...\
   FETCH NEXT c1 INTO rec_cust.\*\
   \...\
   FETCH LAST c1 INTO rec_cust.\*

**Warning:** Netezza does support native scrollable cursors.

***[Solution:]{.underline}***

The Netezza database driver emulates scrollable cursors by fetching rows
in a temporary file. On UNIX, the temp files are created in the
directory defined by the DBTEMP, TMPDIR, TEMP or TMP environment
variables (the default is /tmp). On Windows, the temp files are created
with the \_tempnam() MSVCRT API call.

**Warning:** Native scrollable cursors are normally handled by the
database server (only pieces of the result-set are sent to the client
application). With emulated scrollable cursors, when scrolling to the
last row, all rows will be fetched into the temporary file. This can
generate a lot of network traffic and can produce a large temporary file
if the result-set contains a lot of rows. Additionally, programs are
dependent on the file system resource allocated to the OS user (ulimit).

**Warning:** In case of a runtime system crash, the temporary files
created for scrollable cursors are not removed automatically. Therefore,
is it possible that you will find some unexpected files in the temp
directory. Before removing such files, you must make sure that these
files are no longer used by running processes. Recent operating systems
take care of that, by removing unused temp files periodically. 

------------------------------------------------------------------------

[ODINTZ100 - Data type conversion table]{#ODINTZ100}

::: {align="center"}
  ------------------------------ ---------------------------------
  **INFORMIX Data Types**        **Netezza** **Data Types**
  CHAR(n)                        CHAR(n) or NCHAR(n) if UTF-8
  VARCHAR(n)                     VARCHAR(n) or NVARCHAR if UTF-8
  INTEGER                        INTEGER
  SMALLINT                       SMALLINT
  FLOAT\[(n)\]                   DOUBLE
  SMALLFLOAT                     REAL
  DECIMAL(p,s)                   DECIMAL(p,s)
  DECIMAL(p)                     DECIMAL(p\*2,p)
  DECIMAL                        DECIMAL(32,16)
  MONEY(p,s)                     DECIMAL(p,s)
  DATE                           DATE
  DATETIME HOUR TO SECOND        TIME
  DATETIME YEAR TO FRACTION(p)   TIMESTAMP
  ------------------------------ ---------------------------------

  ----------------------------------------- ----------
  INTERVAL YEAR\[(p)\] TO MONTH             CHAR(50)
  INTERVAL YEAR\[(p)\] TO YEAR              CHAR(50)
  INTERVAL MONTH\[(p)\] TO MONTH            INTERVAL
  INTERVAL DAY\[(p)\] TO FRACTION(n)        INTERVAL
  INTERVAL DAY\[(p)\] TO SECOND             INTERVAL
  INTERVAL DAY\[(p)\] TO MINUTE             INTERVAL
  INTERVAL DAY\[(p)\] TO HOUR               INTERVAL
  INTERVAL DAY\[(p)\] TO DAY                INTERVAL
  INTERVAL HOUR\[(p)\] TO FRACTION(n)       INTERVAL
  INTERVAL HOUR\[(p)\] TO SECOND            INTERVAL
  INTERVAL HOUR\[(p)\] TO MINUTE            INTERVAL
  INTERVAL HOUR\[(p)\] TO HOUR              INTERVAL
  INTERVAL MINUTE\[(p)\] TO FRACTION(n)     INTERVAL
  INTERVAL MINUTE\[(p)\] TO SECOND          INTERVAL
  INTERVAL MINUTE\[(p)\] TO MINUTE          INTERVAL
  INTERVAL SECOND\[(p)\] TO FRACTION(n)     INTERVAL
  INTERVAL SECOND\[(p)\] TO SECOND          INTERVAL
  INTERVAL FRACTION\[(p)\] TO FRACTION(n)   INTERVAL
  ----------------------------------------- ----------

  ------ -----
  BYTE   N/A
  ------ -----
:::
