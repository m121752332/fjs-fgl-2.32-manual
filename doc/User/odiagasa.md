[Back to Contents](../index.html)

------------------------------------------------------------------------

# ODI Adaptation Guide For Sybase ASA 8.x

**Warning: Sybase ASA will be de-supported, see [Sybase ASE Adaptation
Guide](odiagase.html).**

Installation

::: {align="center"}
  --------------------------------------------------------
  [Install Sybase and create a database](#ODIASA_PREP01)
  [Prepare the runtime environment](#ODIASA_PREP02)
  --------------------------------------------------------
:::

Database concepts

::: {align="center"}
  ------------------------------------------------------------
  [Database concepts](#ODIASA007a)
  [Data storage concepts](#ODIASA039)
  [Data consistency and concurrency management](#ODIASA008a)
  [Transactions handling](#ODIASA009)
  [Defining database users](#ODIASA016a)
  [Setting privileges](#ODIASA016b)
  ------------------------------------------------------------
:::

Data dictionary

::: {align="center"}
  ----------------------------------------------
  [BOOLEAN data type](#ODIASA010)
  [CHARACTER data types](#ODIASA011)
  [NUMERIC data types](#ODIASA021)
  [DATE and DATETIME data types](#ODIASA001)
  [INTERVAL data type](#ODIASA036)
  [SERIAL data types](#ODIASA005)
  [ROWIDs](#ODIASA004)
  [Case sensitivity](#ODIASA047)
  [Very large data types](#ODIASA030)
  [The ALTER TABLE instruction](#ODIASA053)
  [Constraints](#ODIASA012)
  [Triggers](#ODIASA013)
  [Stored procedures](#ODIASA014)
  [Name resolution of SQL objects](#ODIASA019)
  [Setup database statistics](#ODIASA051)
  [Data type conversion table](#ODIASA100)
  ----------------------------------------------
:::

Data manipulation

::: {align="center"}
  ----------------------------------------------
  [Reserved words](#ODIASA003)
  [Outer joins](#ODIASA006)
  [Transactions handling](#ODIASA009)
  [Temporary tables](#ODIASA017)
  [Substrings in SQL](#ODIASA018)
  [Name resolution of SQL objects](#ODIASA019)
  [String delimiters](#ODIASA020)
  [Getting one row with SELECT](#ODIASA022)
  [MATCHES and LIKE conditions](#ODIASA024)
  [Querying system catalog tables](#ODIASA033)
  [Syntax of UPDATE statements](#ODIASA034)
  ----------------------------------------------
:::

BDL programming

::: {align="center"}
  -------------------------------------------------------
  [SERIAL data type](#ODIASA005)
  [INFORMIX specific SQL statements in BDL](#ODIASA025)
  [INSERT cursors](#ODIASA028)
  [Cursors WITH HOLD](#ODIASA031)
  [SELECT FOR UPDATE](#ODIASA008b)
  [The LOAD and UNLOAD instructions](#ODIASA046)
  [SQL Interruption](#ODIASA054)
  [Scrollable Cursors](#ODIASA055)
  -------------------------------------------------------
:::

------------------------------------------------------------------------

## [Runtime configuration]{#ODIASA_PREP} {#runtime-configuration align="left"}

> ### [Install Sybase ASA and create a database]{#ODIASA_PREP01} {#install-sybase-asa-and-create-a-database align="left"}
>
> 1.  Install Sybase ASA software on your computer.
>
> 2.  Create a Sybase **database** entity with **dbinit** tool. Go to a
>     directory where the database files must be created and run the
>     dbinit tool.\
>     **Warning:** Create the database with case-sensitivity and blank
>     padding for string comparisons:\
>     \
>        \$ cd *datadirectory*\
>        \$ dbinit -c -b *databasename*
>
> 3.  Make sure that the database option ALLOW_NULLS_BY_DEFAULT option
>     is set to ON.\
>     **Warning:** If this option is set to OFF, columns created without
>     NULL or NOT NULL are NOT NULL by default.     
>
> 4.  Try to connect to the new created database with the **dbisql**
>     tool. The default database user is **DBA/SQL**.\
>     **Warning:** User logins and passwords are case sensitive!
>
> 5.  Declare a database user dedicated to your application: the
>     **application administrator**. \
>     \
>        grant connect to *appadmin* identified by *password*\
>        grant resource to *appadmin*\
>     \
>     See documentation for more details about database users and
>     privileges. You must create groups to make tables visible to all
>     users.
>
> 6.  If you plan to use SERIAL emulation based on triggers using a
>     registration table, create the SERIALREG table. Create the
>     triggers for each table using a SERIAL. See issue
>     [ODIASA005](#ODIASA005) for more details.
>
> 7.  Create the **application tables**. Do not forget to convert
>     INFORMIX data types to Sybase ASA data types. See  issue
>     [ODIASA100](#ODIASA100) for more details.\
>     **Warning:** In order to make application tables visible to all
>     users, make sure that all users are members of the group of the
>     owner of the application tables. For more details, see ASA
>     documentation (\"Database object names and prefixes\").
>
> ### [Prepare the runtime environment]{#ODIASA_PREP02} {#prepare-the-runtime-environment align="left"}
>
> In order to connect to Sybase ASA, you must have a Sybase ASA database
> driver \"**dbmasa\***\" in FGLDIR/dbdrivers.
>
> If you want to connect to a remote database server, you must have the
> **Sybase ASA Client Software** installed on the computer running 4gl
> applications.\
> **Warning:** **No ODBC client environment is required. The Sybase ASA
> database driver is designed to be linked with native Sybase client
> libraries (libdblib8+libdbtools8).**
>
> Make sure the Sybase ASA client environment variables are properly
> set. Check for example **SYBASE** (the path to the installation
> directory). See Sybase ASA documentation for more details.
>
> Verify the environment variable defining the search path for database
> client shared libraries. On UNIX platforms, the variable is specific
> to the operating system. For example, on Solaris and Linux systems, it
> is **LD_LIBRARY_PATH**, on AIX it is **LIBPATH**, or HP/UX it is
> **SHLIB_PATH**. On Windows, you define the DLL search path in the
> **PATH** environment variable.
>
> +-----------------------------------+-----------------------------------+
> | **Sybase ASA version**            | **Shared library environment      |
> |                                   | setting**                         |
> +-----------------------------------+-----------------------------------+
> | **Sybase ASA 8.1 and higher**     | *UNIX*: Add **\$SYBASE/lib** to   |
> |                                   | LD_LIBRARY_PATH (or its           |
> |                                   | equivalent).\                     |
> |                                   | *Windows*: Add **%SYBASE%\\bin**  |
> |                                   | to PATH.                          |
> +-----------------------------------+-----------------------------------+
> |                                   |                                   |
> +-----------------------------------+-----------------------------------+
>
> Test the Sybase ASA Client Software: Make sure Sybase ASA is started
> on the database server and try to connect to a database by using the
> **Interactive SQL** tool.
>
> Set up the **fglprofile** entries for [database
> connections](Connections.html#DS_ODI_DBVSPEC).\
> \
> **Warning:** **Make sure that you are using the ODI driver
> corresponding to the database client and server version. Because
> Informix features emulation are dependant from the database server
> version, it is mandatory to use the same version of the database
> client and ODI driver as the server version.**\
>
> Define the connection timeout with the following fglprofile entry:\
> \
>     dbi.database.*dbname*.asa.logintime = *integer*\
> \
> This entry defines the number of seconds to wait for a connection.\
> Default is 5 seconds.

------------------------------------------------------------------------

[ODIASA001 - DATE and DATETIME data types]{#ODIASA001}

INFORMIX provides two data types to store dates and time information:

- **DATE** = for year, month and day storage.
- **DATETIME** = for year to fraction(1-5) storage.

Sybase ASA provides two data type to store dates :

- **DATE** = for year, month, day storage.
- **TIME** = for hour, minutes, seconds, fraction(3) storage.
- **TIMESTAMP** = for year, month, day, hour, minutes, seconds,
  fraction(3) storage.

**String representing date time information :**

INFORMIX is able to convert quoted strings to DATE / DATETIME data if
the string contents matches environment parameters (i.e. DBDATE,
GL_DATETIME). As in INFORMIX, Sybase ASA can convert quoted strings
representing datetime data in the ANSI format. The CONVERT( ) SQL
function allows you to convert strings to dates.

**Date time arithmetic:**

- INFORMIX supports date arithmetic on DATE and DATETIME values. The
  result of an arithmetic expression involving dates/times is a number
  of days when only DATEs are used and an INTERVAL value if a DATETIME
  is used in the expression.
- INFORMIX automatically converts an integer to a date when the integer
  is used to set a value of a date column. Sybase ASA does not support
  this automatic conversion.
- Complex DATETIME expressions ( involving INTERVAL values for example )
  are INFORMIX specific and have no equivalent in Sybase ASA.
- Sybase ASA allows the following arithmetic on dates:\
    - Date + integer =\> add n days to the date.\
    - Date - integer =\> subtract n days from the date.\
    - Timestamp + integer =\> add n days to the timestamp.\
    - Timestamp - integer =\> subtract n days from the timestamp.\
    - Date - Date =\> compute number of days between 2 dates.\
    - Timestamp - Timestamp =\> compute number of days between 2
  timestamps.\
    - Date + Time =\> Create a Timestamp combining given date & time.
- INFORMIX converts automatically an integer to a date when the integer
  is used to set a value of a date column. Sybase ASA does not support
  this automatic conversion.

**[*Solution:*]{.underline}**

Sybase ASA has the same **DATE** data type as INFORMIX ( year, month,
day ). So you can use Sybase ASA DATE data type for INFORMIX DATE
columns.

Sybase ASA **TIME** data type can be used to store INFORMIX DATETIME
HOUR TO FRAC(3) values. The database interface makes the conversion
automatically.

INFORMIX DATETIME values with any precision from YEAR to FRACTION(5) can
be stored in Sybase ASA **TIMESTAMP** columns. The database interface
makes the conversion automatically. Missing date or time parts default
to 1900-01-01 00:00:00.0. For example, when using a DATETIME HOUR TO
MINUTE with the value of \"11:45\", the ASA TIMESTAMP value will be
\"1900-01-01 11:45:00.0\".

**Warning:** Literal DATETIME and INTERVAL expressions (i.e. DATETIME (
1999-10-12) YEAR TO DAY) are not converted.

**Warning:** Using integers as a number of days in an expression with
dates is not supported by Sybase ASA. Check your code to detect where
you are using integers with DATE columns.

**Warning:** It is strongly recommended to use BDL variables in dynamic
SQL statements instead of quoted strings representing DATEs. For example
:\
   LET stmt = \"SELECT \... FROM customer WHERE creat_date \>\'\",
adate,\"\'\"\
is not portable; use a question mark place holder instead and OPEN the
cursor USING adate :\
   LET stmt = \"SELECT \... FROM customer WHERE creat_date \> ?\"

------------------------------------------------------------------------

[ODIASA003 - Reserved words]{#ODIASA003}

Even if ASA allows SQL reserved keywords as SQL object names if enclosed
in double quotes ( \"[create table \"table\" ( col1 int )]{.small}\" ),
you should take care of your existing database schema and check that you
do not use Sybase ASA SQL words.

***[Solution:]{.underline}***

Database objects having a name which is a Sybase ASA SQL reserved word
must be renamed.

All BDL application sources must be verified. To check if a given
keyword is used in a source, you can use UNIX \'grep\' or \'awk\' tools.
Most modifications can be automatically done with UNIX tools like
\'sed\' or \'awk\'.

------------------------------------------------------------------------

## [ODIASA004 - ROWIDs]{#ODIASA004}

When creating a table, INFORMIX automatically adds a \"ROWID\" integer
column (applies to non-fragmented tables only). The ROWID column is
auto-filled with a unique number and can be used like a primary key to
access a given row.

Sybase ASA tables have no ROWIDs.

***[Solution:]{.underline}***

If the BDL application uses ROWIDs, the program logic should be reviewed
in order to use the real primary keys (usually, serials which can be
supported).

All references to SQLCA.SQLERRD\[6\] must be removed because this
variable will not hold the ROWID of the last INSERTed or UPDATEd row
when using the Sybase ASA interface.

------------------------------------------------------------------------

[ODIASA005 - SERIAL data type]{#ODIASA005}

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
the internal serial counter, to avoid conflicts with future INSERTs that
are using a zero value :\
    CREATE TABLE tab ( k SERIAL );  \--\> internal counter = 0\
    INSERT INTO tab VALUES ( 0 );   \--\> internal counter = 1\
    INSERT INTO tab VALUES ( 10 );  \--\> internal counter = 10\
    INSERT INTO tab VALUES ( 0 );   \--\> internal counter = 11\
    DELETE FROM tab;                \--\> internal counter = 11\
    INSERT INTO tab VALUES ( 0 );   \--\> internal counter = 12

Sybase ASA **IDENTITY** columns :

- When creating a table, the IDENTITY keyword must be specified after
  the column data type:\
     CREATE TABLE tab1 ( k integer identity, c char(10) )
- You cannot specify a start value
- A new number is automatically created when inserting a new row :\
     INSERT INTO tab1 ( c ) VALUES ( \'aaa\' )
- To get the last generated number, Sybase ASA provides a global
  variable :\
     SELECT **@@IDENTITY**
- When IDENTITY_INSERT is ON, you can set a specific value into a
  IDENTITY column, but zero does not generate a new serial:\
     INSERT INTO tab1 ( k, c ) VALUES ( 100, \'aaa\' )

INFORMIX SERIALs and MS Sybase ASA IDENTITY columns are quite similar;
the main difference is that MS Sybase ASA does not generate a new serial
when you specify a zero value for the identity column.

**[*Solution*]{.underline} :**

You are free to use **IDENTITY columns** (1) or **insert triggers based
on the SERIALREG** table (2). The first solution is faster, but does not
allow explicit serial value specification in insert statements; the
second solution is slower but allows explicit serial value
specification.  You can initially use the second solution to have
unmodified 4gl programs working on Sybase ASA, but you should update
your code to use native IDENTITY columns for performance.

With the following fglprofile entry, you define the technique to be used
for SERIAL emulation :

   dbi.database.\<dbname\>.ifxemul.datatype.serial.emulation =
{\"native\"\|\"regtable\"}

The \'**native**\' value defines the IDENTITY column technique and the
\'**regtable**\' defines the trigger technique.

This entry must be used with :

   dbi.database.\<dbname\>.ifxemul.datatype.serial = {true\|false}

If this entry is set to false, the emulation method specification entry
is ignored.

**Warning** : When no entry is specified, the default is SERIAL
emulation enabled with \'native\' method (IDENTITY-based).\
\
1. Using IDENTITY columns

In database creation scripts, all SERIAL data types must be converted by
hand to INTEGER IDENTITY data types.

**Warning** : Start values SERIAL(n) cannot be converted, there is no
INTEGER IDENTITY(n) in Sybase ASA.

Tables created from the BDL programs can use the SERIAL data type : When
a BDL program executes a CREATE \[TEMP\] TABLE with a SERIAL column, the
database interface automatically converts the \"SERIAL\[(n)\]\" data
type to \"INTEGER IDENTITY\[(n,1)\]\".

In BDL, the new generated SERIAL value is available from the
SQLCA.SQLERRD\[2\] variable. This is supported by the database interface
which performs a \"SELECT @@IDENTITY\". However, SQLCA.SQLERRD\[2\] is
defined as an INTEGER, it cannot hold values from BIGINT identity
columns. If you are using BIGINT IDENTITY columns, you must use
@@IDENTITY.

**Warning** : When you insert a row with zero as serial value, the
serial column gets the value zero. You must review all INSERT statements
using zero for the serial column.\
For example, the following statement:\
   INSERT INTO tab (col1,col2) VALUES (**0**, p_value)\
must be converted to :\
   INSERT INTO tab (col2) VALUES (p_value)\
Static SQL INSERT using records defined from the schema file must also
be reviewed:\
   DEFINE rec LIKE tab.\*\
   INSERT INTO tab VALUES ( rec.\* )   \-- will use the serial column\
can be converted to :\
   INSERT INTO tab VALUES rec.\* \-- without braces, serial column is
removed

**Warning** : SELECT \* FROM table INTO TEMP with original table having
an IDENTITY column is not supported: The Sybase ASA database driver must
convert the INFORMIX SELECT INTO TEMP statement into a SELECT INTO
#tab + INSERT (see [temporary tables](#ODIASA017)) because ODBC does not
allow SQL parameters in DDL statements. As MS Sybase ASA does not allow
you to insert a row by giving the identity column, the INSERT statement
fails.

2\. Using triggers with the SERIALREG table

First, you must prepare the database and create the SERIALREG table as
follows:\
\
CREATE TABLE SERIALREG (\
     TABLENAME VARCHAR(50) NOT NULL,\
     LASTSERIAL DECIMAL(20,0) NOT NULL,\
     PRIMARY KEY ( TABLENAME )\
)

In database creation scripts, all SERIAL\[(n)\] data types must be
converted to INTEGER data types and you must create one trigger for each
table. To know how to write those triggers,  you can create a small
Genero program that creates a table with a SERIAL column. Set the
FGLSQLDEBUG environment variable and run the program. The debug output
will show you the native trigger creation command.

Tables created from the BDL programs can use the SERIAL data type.  When
a BDL program executes a CREATE \[TEMP\] TABLE with a SERIAL column, the
database interface automatically converts the \"SERIAL\[(n)\]\" data
type to \"INTEGER\" and creates the insert triggers.

**Warning** : Sybase ASA does not allow you to create triggers on
temporary tables. Therefore, you cannot create temp tables with a SERIAL
column when using this solution.

**Warning** : SELECT \... INTO TEMP statements using a table created
with a SERIAL column do not automatically create the SERIAL triggers in
the temporary table. The type of the column in the new table is INTEGER.

**Warning** : Sybase ASA triggers are not automatically dropped when the
corresponding table is dropped. Database administrators must be aware of
this behavior when managing schemas.

**Warning** : INSERT statements using NULL for the SERIAL column will
produce a new serial value:\
   INSERT INTO tab (col1,col2) VALUES (NULL,\'data\')\
This behavior is mandatory in order to support INSERT statements which
do not use the serial column :\
   INSERT INTO tab (col2) VALUES (\'data\')\
Check if your application uses tables with a SERIAL column that can
contain a NULL value.

**Warning** : The serial production is based on the SERIALREG table
which registers the last generated number for each table. If you delete
rows of this table, sequences will restart at 1 and you will get
unexpected data.

------------------------------------------------------------------------

## [ODIASA006 - Outer joins]{#ODIASA006}

The syntax of OUTER joins is quite different in INFORMIX and Sybase ASA
:

In INFORMIX SQL, outer tables are defined in the FROM clause with the
**OUTER** keyword :

> SELECT ... FROM cust, OUTER(order)
>      WHERE cust.key = order.custno
>
>     SELECT ... FROM cust, OUTER(order,OUTER(item))
>      WHERE cust.key = order.custno
>        AND order.key = item.ordno
>        AND order.accepted = 1

Sybase ASA Version 7 supports the ANSI outer join syntax :

> SELECT ... FROM cust LEFT OUTER JOIN order
>                          ON cust.key = order.custno
>
>     SELECT ...
>       FROM cust LEFT OUTER JOIN order
>                      LEFT OUTER JOIN item
>                      ON order.key = item.ordno
>                 ON cust.key = order.custno
>      WHERE order.accepted = 1

The old way to define outer joins in Sybase ASA looks like the following
:

> SELECT ... FROM a, b WHERE a.key *= b.key

See the Sybase ASA reference manual for a complete description of the
syntax.

***[Solution:]{.underline}***

The Sybase ASA interface can convert simple INFORMIX OUTER
specifications to Sybase ASA ANSI outer joins.

Prerequisites :

1.  The outer join in the WHERE part must use the table name as prefix.\
       Example : \"WHERE tab1.col1 = tab2.col2 \".
2.  Additional conditions on outer table columns cannot be detected and
    therefore are not supported :\
       Example : \"\... FROM tab1, OUTER(tab2) WHERE tab1.col1 =
    tab2.col2 AND tab2.colx \> 10\".
3.  Statements composed of 2 or more SELECT instructions using OUTERs
    are not supported.\
      Example : \"SELECT \... UNION SELECT\" or \"SELECT \... WHERE col
    IN (SELECT\...)\"

Notes :

1.  Table aliases are detected in OUTER expressions.\
       OUTER example with table alias : \"OUTER( tab1 alias1)\".
2.  In the outer join, \<outer table\>.\<col\> can be placed on both
    right or left sides of the equal sign.\
       OUTER join example with table on the left : \"WHERE outertab.col1
    = maintab.col2 \".
3.  Table names detection is not case-sensitive.\
       Example : \"SELECT \... FROM tab1, TAB2 WHERE tab1.col1 =
    tab2.col2\".
4.  [Temporary tables](#ODIASA017) are supported in OUTER
    specifications.

------------------------------------------------------------------------

[ODIASA007a - Database concepts]{#ODIASA007a}

As in INFORMIX, an Sybase ASA engine can manage multiple database
entities. When creating a database object such as a table, Sybase ASA
allows you to use the same object name in different databases.

------------------------------------------------------------------------

[ODIASA008a - Data consistency and concurrency management]{#ODIASA008a}

**Data consistency** involves readers which want to access data
currently modified by writers and **concurrency data access** involves
several writers accessing the same data for modification. **Locking
granularity** defines the amount of data concerned when a lock is set
(row, page, table, \...).

**INFORMIX**

INFORMIX uses a locking mechanism to manage data consistency and
concurrency. When a process modifies data with UPDATE, INSERT or DELETE,
an [exclusive lock]{.underline} is set on the affected rows. The lock is
held until the end of the transaction. Statements performed outside a
transaction are treated as a transaction containing a single operation
and therefore release the locks immediately after execution. SELECT
statements can set **shared locks** according to the **isolation
level**. In case of locking conflicts (for example, when two processes
want to acquire an exclusive lock on the same row for modification or
when a writer is trying to modify data protected by a shared lock), the
behavior of a process can be changed by setting the **lock wait mode**.

Control :

- Isolation level : SET ISOLATION TO \...
- Lock wait mode : SET LOCK MODE TO \...
- Locking granularity : CREATE TABLE \... LOCK MODE {PAGE\|ROW}
- Explicit locking : SELECT \... FOR UPDATE

Defaults :

- The default isolation level is read committed.
- The default lock wait mode is \"not wait\".
- The default locking granularity is per page.

**Sybase ASA**

As in INFORMIX, Sybase ASA uses locks to manage data consistency and
concurrency. The database manager sets **exclusive locks** on the
modified rows and **shared locks** when data is read, according to the
**isolation level**. The locks are held until the end of the
transaction. When multiple processes want to access the same data, the
latest processes must wait until the first finishes its transaction or
the lock timeout occurred. The **lock granularity** is at the row or
table level. For more details, see Sybase ASA\'s Documentation,
\"Accessing and Changing Data\", \"Locking\".

Control :

- Lock wait mode : Can only be set to on or off, and a timeout can be
  specified, with:\
   SET TEMPORARY OPTION BLOCKING = { ON \| OFF }\
   SET TEMPORARY OPTION BLOCKING_TIMEOUT = n
- Isolation level : Can be set with:\
   SET TEMPORARY OPTION ISOLATION LEVEL = {1\|2\|3\|4}
- Locking granularity : Row level.
- Explicit locking : SELECT \... FOR UPDATE

Defaults :

- The default isolation level is Read Committed ( readers cannot see
  uncommitted data; no shared lock is set when reading data ).

**[*Solution:*]{.underline}**

The SET ISOLATION TO \... INFORMIX syntax is replaced by SET TEMPORARY
OPTION ISOLATION_LEVEL \... in Sybase ASA. The next table shows the
isolation level mappings done by the Sybase ASA database driver:

::: {align="center"}
  ----------------------------------- -----------------------------------
  **SET ISOLATION instruction in      **Native SQL command**
  program**                           

  SET ISOLATION TO DIRTY READ         SET TEMPORARY OPTION
                                      ISOLATION_LEVEL = 1

  SET ISOLATION TO COMMITTED READ\    SET TEMPORARY OPTION
    \[READ COMMITTED\] \[RETAIN       ISOLATION_LEVEL = 2
  UPDATE LOCKS\]                      

  SET ISOLATION TO CURSOR STABILITY   SET TEMPORARY OPTION
                                      ISOLATION_LEVEL = 3

  SET ISOLATION TO REPEATABLE READ    SET TEMPORARY OPTION
                                      ISOLATION_LEVEL = 4
  ----------------------------------- -----------------------------------
:::

For portability, it is recommended that you work with INFORMIX in the
read committed isolation level, to make processes wait for each other
(lock mode wait) and to create tables with the \"lock mode row\" option.

See INFORMIX and Sybase ASA documentation for more details about data
consistency, concurrency and locking mechanisms.

------------------------------------------------------------------------

[ODIASA008b - SELECT FOR UPDATE]{#ODIASA008b}

A lot of BDL programs use pessimistic locking in order to avoid several
users editing the same rows at the same time.

  DECLARE cc CURSOR FOR\
        SELECT \... FOR UPDATE\
  OPEN cc\
  FETCH cc \<\-- lock is acquired\
  CLOSE cc \<\-- lock is released

- A transaction must be started before opening cursors declared for
  update.
- The row must be fetched in order to set the lock.
- The lock is released when the transaction ends (if the cursor is not
  declared \"WITH HOLD\") or when the cursor is closed.

Sybase ASA allows individual and exclusive row locking by using the FOR
UPDATE clause, as INFORMIX.

- Individual locks are acquired when fetching the rows.
- When the cursor (WITH HOLD) is opened outside a transaction, locks are
  released when the cursor is closed.
- When the cursor is opened inside a transaction, locks are released
  when the transaction ends.

Sybase ASA\'s locking granularity is at the row level, page level or
table level (the level is automatically selected by the engine for
optimization).

To control the behavior of the program when locking rows, INFORMIX
provides a specific instruction to set the wait mode:

   SET LOCK MODE TO { WAIT \| NOT WAIT \| WAIT *seconds* }

The default mode is WAIT. This as an INFORMIX specific SQL statement.

**[*Solution:*]{.underline}**

SELECT FOR UPDATE statements are well supported.

**Warning :** Sybase ASA locks the rows when you open the cursor. You
will have to test SQLCA.SQLCODE after doing an OPEN.

**Warning :** The database interface is based on an emulation of an
INFORMIX engine using transaction logging. Therefore, opening a SELECT
\... FOR UPDATE cursor declared outside a transaction will raise an SQL
error -255 (not in transaction).

**Warning :** The SELECT FOR UPDATE statement cannot contain an ORDER BY
clause if you want to perform positioned updates/deletes with WHERE
CURRENT OF.

You must review the program logic if you use pessimistic locking; it is
based on the NOT WAIT mode, which is not supported by Sybase ASA.

------------------------------------------------------------------------

[ODIASA009 - Transactions handling]{#ODIASA009}

INFORMIX and Sybase ASA handle transactions in a similar manner.

INFORMIX native mode (non ANSI) :

- Transactions are started with \"BEGIN WORK\".
- Transactions are validated with \"COMMIT WORK\".
- Transactions are canceled with \"ROLLBACK WORK\".
- Statements executed outside of a transaction are automatically
  committed.
- DDL statements can be executed (and canceled) in transactions.

Sybase ASA :

- Transactions are started with \"BEGIN TRANSACTION \[name\]\".
- Transactions are validated with \"COMMIT TRANSACTION \[name\]\".
- Transactions are canceled with \"ROLLBACK TRANSACTION \[name\]\".
- Transactions save points can be placed with \"SAVEPOINT \[name\]\".
- Sybase ASA supports named and nested transactions.
- By default transactions are started implicitly as in the ANSI
  specification.\
  This behavior can be changed with:\
     SET TEMPORARY OPTION CHAINED = OFF 
- DDL statements are not supported in transactions blocks.

Transactions in stored procedures : avoid using transactions in stored
procedures to allow the client applications to handle transactions,
according to the transaction model.

**[*Solution:*]{.underline}**

INFORMIX transaction handling commands are automatically converted to
Sybase ASA instructions to start, validate or cancel transactions.

The Sybase ASA database driver sets the \"CHAINED\" option to OFF when
connecting to the server.

Regarding the transaction control instructions, the BDL applications do
not have to be modified in order to work with Sybase ASA.

------------------------------------------------------------------------

## [ODIASA010 - BOOLEAN data type]{#ODIASA010}

INFORMIX supports the BOOLEAN data type, which can store \'t\' or \'f\'
values. Genero BDL implements the BOOLEAN data type in a different way:
As in other programming languages, Genero BOOLEAN stores integer values
1 or 0 (for TRUE or FALSE). The type was designed this way to assign the
result of a Boolean expression to a BOOLEAN variable.

Sybase ASA provides the BIT data type to store Boolean values.

**[*Solution:*]{.underline}**

The Sybase ASA database interface converts BOOLEAN type to BIT columns
and stores 1 or 0 values in the column.

------------------------------------------------------------------------

[ODIASA011 - CHARACTER data types]{#ODIASA011}

As in INFORMIX, Sybase ASA provides the CHAR and VARCHAR data types to
store character data.

INFORMIX CHAR type can store up to **32767** characters and the VARCHAR
data type is limited to **255** characters.

Sybase ASA CHAR and VARCHAR both have a limit of  **32767** characters.

Sybase ASA provides the LONG VARCHAR data type to store large character
strings. Only the LIKE operator can be used for searches. LONG VARCHAR
columns cannot be used in classic comparison expressions (as col =
\'value\').

**[*Solution:*]{.underline}**

The database interface supports character string variables in SQL
statements for input (BDL USING) and output (BDL INTO) for CHAR and
VARCHAR data types.

**Warning** : Check that your database schema does not use CHAR or
VARCHAR types with a length exceeding the Sybase ASA limit.

**Warning:** TEXT values cannot be used as input or output parameters in
SQL statements and therefore are not supported.

------------------------------------------------------------------------

[ODIASA012 - Constraints]{#ODIASA012}

**Constraint naming syntax :**

Both INFORMIX and Sybase ASA support primary key, unique, foreign key,
default and check constraints. But Sybase ASA does not support
constraint naming syntax:

UNIQUE constraint example :

::: {align="left"}
  ----------------------------------- -----------------------------------
  **INFORMIX**                        **Sybase ASA**

  CREATE TABLE scott.emp (\           CREATE TABLE scott.emp (\
  \...\                               \...\
  empcode CHAR(10) UNIQUE\            empcode CHAR(10)UNIQUE,\
     **\[CONSTRAINT pk_emp\]**,\      \...
  \...                                
  ----------------------------------- -----------------------------------
:::

**[*Solution:*]{.underline}**

**Constraint naming syntax :**

The database interface does not convert constraint naming expressions
when creating tables from BDL programs. Review the database creation
scripts to adapt the constraint naming clauses for Sybase ASA.

------------------------------------------------------------------------

[ODIASA013 - Triggers]{#ODIASA013}

INFORMIX and Sybase ASA provide triggers with similar features, but the
programming languages are totally different.

**Warning :** Sybase ASA does not support triggers on temporary tables.

**[*Solution:*]{.underline}**

INFORMIX triggers must be converted to Sybase ASA triggers \"by hand\".

------------------------------------------------------------------------

[ODIASA014 - Stored procedures]{#ODIASA014}

Both INFORMIX and Sybase ASA support stored procedures, but the
programming languages are totally different :

- INFORMIX stored procedures must be written in **SPL**.
- Sybase ASA stored procedures must be written in **Sybase ASA SQL**.

**[*Solution:*]{.underline}**

INFORMIX stored procedures must be converted to Sybase ASA \"by hand\".

------------------------------------------------------------------------

[ODIASA016a - Defining database users]{#ODIASA016a}

INFORMIX users are defined at the operating system level, they must be
members of the \'informix\' group, and the database administrator must
grant CONNECT, RESOURCE or DBA privileges to those users.

Before a user can access an Sybase ASA database, the system
administrator (DBA) must declare the application users in the database
with the GRANT statement. You may also need to define groups in order to
make tables visible to other users.

**[*Solution:*]{.underline}**

See Sybase ASA documentation for more details on database logins and
users.

------------------------------------------------------------------------

[ODIASA016b - Setting privileges]{#ODIASA016b}

INFORMIX and Sybase ASA user privileges management are quite similar.

Sybase ASA provides **user groups** to grant or revoke permissions to
more than one user at the same time.

------------------------------------------------------------------------

[ODIASA017 - Temporary tables]{#ODIASA017}

INFORMIX temporary tables are created through the **CREATE TEMP TABLE**
DDL instruction or through a **SELECT \... INTO TEMP** statement.
Temporary tables are automatically dropped when the SQL session ends,
but they can also be dropped with the DROP TABLE command. There is no
name conflict when several users create temporary tables with the same
name.

**Warning** : The CREATE TEMP TABLE and SELECT INTO TEMP statements are
not supported in Sybase ASA.

Sybase ASA supports temporary tables by using the DECLARE LOCAL
TEMPORARY TABLE statement. 

***[Solution:]{.underline}***

The CREATE TEMP TABLE statements are converted by the database interface
to DECLARE LOCAL TEMPORARY TABLE statements.

**Warning** : SELECT INTO TEMP statements cannot be converted, because
Sybase ASA does not provide a way to create a temporary table from a
result set, such as CREATE TABLE xx AS (SELECT \... ).

------------------------------------------------------------------------

[ODIASA018 - Substrings in SQL]{#ODIASA018}

INFORMIX SQL statements can use subscripts on columns defined with the
character data type :\
    SELECT \... FROM tab1 WHERE **col1\[2,3\]** = \'RO\'\
    SELECT \... FROM tab1 WHERE **col1\[10\]**  = \'R\'   \-- Same as
col1\[10,10\]\
    UPDATE tab1 SET **col1\[2,3\]** = \'RO\' WHERE \...\
    SELECT \... FROM tab1 ORDER BY **col1\[1,3\]**

.. while Sybase ASA provides the SUBSTR( ) function, to extract a
substring from a string expression :\
    SELECT \.... FROM tab1 WHERE **SUBSTRING(col1,2,2)** = \'RO\'\
    SELECT **SUBSTRING(\'Some text\',6,3)** FROM DUAL       \-- Gives
\'tex\'

**[*Solution:*]{.underline}**

You must replace all INFORMIX col\[x,y\] expressions by
SUBSTRING(col,x,y-x+1).

**Warning:** In UPDATE instructions, setting column values through
subscripts will produce an error with Sybase ASA :\
    UPDATE tab1 SET **col1\[2,3\]** = \'RO\' WHERE \...\
is converted to :\
    UPDATE tab1 SET **SUBSTRING(col1,2,3-2+1)** = \'RO\' WHERE \...

**Warning:** Column subscripts in ORDER BY expressions are also
converted and produce an error with Sybase ASA :\
    SELECT \... FROM tab1 ORDER BY **col1\[1,3\]**\
is converted to :\
    SELECT \... FROM tab1 ORDER BY **SUBSTRING(col1,1,3-1+1)**

------------------------------------------------------------------------

[ODIASA019 - Name resolution of SQL objects]{#ODIASA019}

INFORMIX uses the following form to identify an SQL object :\
  \[database\[@dbservername\]:\]\[{owner\|\"owner\"}.\]identifier

With Sybase ASA, an object name takes the following form :\
  \[{owner\|\"owner\"}.\]{identifier\|\"identifier\"}

Identifiers have a maximum length of 128 bytes and are composed of
alphabetic characters ( \_, @, #, \$ are considered as alphabetic
characters) or digits. The first character must be alphabetic.

INFORMIX database object names are **not** **case sensitive** in
non-ANSI databases. Sybase ASA database objects names are **case
sensitive** by default, but this is related to the -c option of the
**dbinit** command. Databases must be created as case-sensitive,
otherwise a string comparison such as \"abc\"=\"ABC\" would evaluate to
TRUE.

------------------------------------------------------------------------

[ODIASA020 - String delimiters]{#ODIASA020}

The ANSI string delimiter character is the single quote ( \'string\' ).
Double quotes are used to delimit database object names
(\"object-name\").

[Example]{.underline} : WHERE \"tabname\".\"colname\" = \'a string
value\'

As INFORMIX, Sql Server Anywhere allows to use double quotes as string
delimiters, if the QUOTED_IDENTIFIER session option is OFF, the default
is ON:

    SET TEMPORARY OPTION QUOTED_IDENTIFIER = OFF

Remark : This problem concerns only double quotes within SQL statements.
Double quotes used in BDL string expressions are not subject of SQL
compatibility problems.

***[Solution:]{.underline}***

When the **ifxemul.dblquotes** option is set, the Sybase ASA database
interface converts all double quotes to single quotes in SQL statements.
The Sybase ASA database driver [does not]{.underline} set the
QUOTED_IDENTIFIER option implicitly.

------------------------------------------------------------------------

## [ODIASA021 - NUMERIC data types]{#ODIASA021}

Sybase ASA offers numeric data types which are quite similar to INFORMIX
numeric data types. The table below shows general conversion rules for
numeric data types :

::: {align="center"}
  ----------------------------------- -----------------------------------
  **INFORMIX**                        **Sybase ASA**

  **SMALLINT**                        **SMALLINT**

  **INTEGER** (synonym: INT)          **INTEGER** (synonym: INT)

  **BIGINT**                          **BIGINT**

  **INT8**                            **BIGINT**

  **DECIMAL\[(p\[,s)\]** (synonyms:   **DECIMAL\[(p\[,s)\]** (synonyms:
  DEC, NUMERIC)\                      DEC, NUMERIC)\
  DECIMAL(p,s) defines a [fixed       DECIMAL\[(p\[,s\])\] defines a
  point]{.underline} decimal where    [fixed point]{.underline} decimal
  **p** is the total number of        where **p** is the total number of
  significant digits and **s** the    significant digits and **s** the
  number of digits that fall on the   number of digits that fall on the
  right of the decimal point.\        right of the decimal point.\
  DECIMAL(p) defines a [floating      Without any decimal storage
  point]{.underline} decimal where    specification, [the precision
  **p** is the total number of        defaults to 30]{.underline} and
  significant digits.\                [the scale defaults to
  The precision **p** can be from 1   6]{.underline} :\
  to 32.\                             - DECIMAL in Sybase ASA =
  DECIMAL is treated as DECIMAL(16).  DECIMAL(30,0) in INFORMIX\
                                      - DECIMAL(p) in Sybase ASA =
                                      DECIMAL(p,6) in INFORMIX

  **MONEY\[(p\[,s\])**\               Sybase ASA provides the MONEY and
  \                                   SMALLMONEY data types, but the
  \                                   currency symbol handling is quite
                                      different. Therefore, INFORMIX
                                      MONEY columns should be implemented
                                      as **DECIMAL** columns in Sybase
                                      ASA.

  **SMALLFLOAT**  (synonyms: REAL)    **REAL**

  **FLOAT\[(n)\]** (synonyms: DOUBLE  **FLOAT(n)** (synonyms: DOUBLE
  PRECISION)\                         PRECISION)\
  The precision (n) is ignored.       Where n must be from 1 to 15.
  ----------------------------------- -----------------------------------
:::

***[Solution:]{.underline}***

**In BDL programs :**

When creating tables from BDL programs, the database interface
automatically converts INFORMIX data types to corresponding Sybase ASA
data types.

**Database creation scripts :**

- SMALLINT and INTEGER columns do not have to use another data type in
  Sybase ASA.
- For DECIMALs, check the precision limit. Always use a precision and a
  scale.
- Convert MONEY columns to DECIMAL(p,s) columns. Always use a precision
  and a scale.
- Convert SMALLFLOAT columns to REAL columns.
- Since FLOAT precision is ignored in INFORMIX, convert this data type
  to FLOAT(15).

------------------------------------------------------------------------

[ODIASA022 - Getting one row with SELECT]{#ODIASA022}

With INFORMIX, you must use the system table with a condition on the
table id :

   SELECT user **FROM systables WHERE tabid=1**

With Sybase ASA, you can omit the FROM clause to generate one row only:

       SELECT user

**[*Solution:*]{.underline}**

Check the BDL sources for \"FROM systables WHERE tabid=1\" and use
dynamic SQL to resolve this problem.

------------------------------------------------------------------------

[ODIASA024 - MATCHES and LIKE in SQL conditions]{#ODIASA024}

INFORMIX supports MATCHES and LIKE in SQL statements, while Sybase ASA
supports the LIKE statement only.

The MATCHES operator of INFORMIX uses the star, question mark and square
braces wildcard characters.\
The LIKE operator of Sybase ASA offers the percent, underscore and
square braces wildcard characters.

The following substitutions must be made to convert a MATCHES condition
to a LIKE condition :

- MATCHES keyword must be replaced by LIKE.
- All \'\*\' characters must be replaced by \'%\'.
- All \'?\' characters must be replaced by \'\_\'.

***[Solution:]{.underline}***

**Warning:** SQL statements using MATCHES expressions must be reviewed
in order to use LIKE expressions.

See also: [MATCHES operator in SQL
Programming](SqlProgramming.html#PORT_MATCHES).

------------------------------------------------------------------------

[ODIASA025 - INFORMIX specific SQL statements in BDL]{#ODIASA025}

The BDL compiler supports several INFORMIX specific SQL statements that
have no meaning when using Sybase ASA.

Examples :

- CREATE DATABASE dbname IN dbspace WITH BUFFERED LOG
- START DATABASE (SE only)
- ROLLFORWARD DATABASE
- CREATE TABLE \... IN dbspace WITH LOCK MODE ROW

***[Solution:]{.underline}***

Review your BDL source and remove all static SQL statements which are
INFORMIX specific.

------------------------------------------------------------------------

[ODIASA028 - INSERT cursors]{#ODIASA028}

INFORMIX supports insert cursors. An \"insert cursor\" is a special BDL
cursor declared with an INSERT statement instead of a SELECT statement.
When this kind of cursor is open, you can use the PUT instruction to add
rows and the FLUSH instruction to insert the records into the database.

For INFORMIX database with transactions, OPEN, PUT and FLUSH
instructions must be executed within a transaction.

Sybase ASA does not support insert cursors.

**[*Solution:*]{.underline}**

Insert cursors are emulated by the Sybase ASA database interface.

------------------------------------------------------------------------

[ODIASA030 - Very large data types]{#ODIASA030}

Both INFORMIX and Sybase ASA provide special data types to store very
large texts or images.

Sybase ASA recommends the following conversion rules :

::: {align="center"}
  ------------------------ ------------------------------------------
  **INFORMIX Data Type**   **Sybase ASA** **Data Type**
  TEXT                     TEXT / LONG VARCHAR
  BYTE                     BINARY / LONG BINARY / IMAGE / VARBINARY
  ------------------------ ------------------------------------------
:::

**[*Solution:*]{.underline}**

Very large character data types are not supported yet by the Sybase ASA
database interface.

------------------------------------------------------------------------

[ODIASA031 - Cursors WITH HOLD]{#ODIASA031}

INFORMIX automatically closes opened cursors when a transaction ends
unless the WITH HOLD option is used in the DECLARE instruction.

Sybase ASA does not close cursors when a transaction ends, as long as
the global parameter close_on_endtrans is off.

**[*Solution:*]{.underline}**

BDL cursors that are not declared \"WITH HOLD\" are automatically closed
by the database interface when a COMMIT WORK or ROLLBACK WORK is
performed by the BDL program.

------------------------------------------------------------------------

[ODIASA033 - Querying system catalog tables]{#ODIASA033}

As in INFORMIX, Sybase ASA provides system catalog tables
(sysobjects,syscolumns,etc) in each database, but the table names and
their structure are quite different.

**[*Solution:*]{.underline}**

**Warning:** No automatic conversion of INFORMIX system tables is
provided by the database interface.

------------------------------------------------------------------------

[ODIASA034 - Syntax of UPDATE statements]{#ODIASA034}

INFORMIX allows a specific syntax for UPDATE statements :

    UPDATE table SET ( \<col-list\> ) = ( \<val-list\> )

or

    UPDATE table SET table.\* = myrecord.\*\
    UPDATE table SET \* = myrecord.\*

**[*Solution:*]{.underline}**

Static UPDATE statements using the above syntax are converted [by the
compiler]{.underline} to the standard form :\
\
    UPDATE table SET column=value \[,\...\]

------------------------------------------------------------------------

[ODIASA036 - INTERVAL data type]{#ODIASA036}

INFORMIX\'s INTERVAL data type stores a value that represents a span of
time. INTERVAL types are divided into two classes : **year-month
intervals** and **day-time intervals.**

Sybase ASA does not provide a data type corresponding to the INFORMIX
INTERVAL data type.

**[Solution:]{.underline}**

**Warning:** The INTERVAL data type is not well supported because the
database server has no equivalent native data type. However, you can
store into and retrieve from CHAR columns BDL INTERVAL values.

------------------------------------------------------------------------

## [ODIASA039 - Data storage concepts]{#ODIASA039}

An attempt should be made to preserve as much of the storage information
as possible when converting from INFORMIX to Sybase ASA. Most important
storage decisions made for INFORMIX database objects (like initial sizes
and physical placement) can be reused in an Sybase ASA database.

Storage concepts are quite similar in INFORMIX and in Sybase ASA, but
the names are different.

The following table compares INFORMIX storage concepts to Sybase ASA
storage concepts :

::: {align="center"}
+-------------------------------------+-------------------------------------+
| **INFORMIX**                        | **Sybase ASA**                      |
+-------------------------------------+-------------------------------------+
| Physical units of storage                                                 |
+-------------------------------------+-------------------------------------+
| The largest unit of physical disk   | A database is composed of           |
| space is a \"**chunk**\", which can | **tablespace**. Each tablespace is  |
| be allocated either as a cooked     | composed of a \'.db\' file. In a    |
| file ( I/O is controlled by the OS) | database, there is one tablespace   |
| or as raw device (=UNIX partition,  | at the creation, but can hold more  |
| I/O is controlled by the database   | than one tablespace. The size of a  |
| engine). A \"dbspace\" uses at      | tablespace is increased             |
| least one \"chunk\" for storage.\   | automatically.                      |
| You must add \"chunks\" to          |                                     |
| \"dbspaces\" in order to increase   |                                     |
| the size of the logical unit of     |                                     |
| storage.                            |                                     |
+-------------------------------------+-------------------------------------+
| A \"**page**\" is the smallest      | At the finest level of granularity, |
| physical unit of disk storage that  | Sql Server Anywhere stores data in  |
| the engine uses to read from and    | \"**page**\" which size can be      |
| write to databases.\                | defined at the creation time.       |
| A \"chunk\" contains a certain      |                                     |
| number of \"pages\".\               |                                     |
| The size of a \"page\" must be      |                                     |
| equal to the operating system\'s    |                                     |
| block size.                         |                                     |
+-------------------------------------+-------------------------------------+
| An \"**extent**\" consists of a     | Database files are extended by 32   |
| collection of continuous \"pages\"  | pages at a time when the space is   |
| that the engine uses to allocate    | needed.                             |
| both initial and subsequent storage |                                     |
| space for database tables.\         |                                     |
| When creating a table, you can      |                                     |
| specify the first extent size and   |                                     |
| the size of future extents with the |                                     |
| EXTENT SIZE and NEXT EXTENT         |                                     |
| options.\                           |                                     |
| For a single table, \"extents\" can |                                     |
| be located in different \"chunks\"  |                                     |
| of the same \"dbspace\".            |                                     |
+-------------------------------------+-------------------------------------+
| Logical units of storage                                                  |
+-------------------------------------+-------------------------------------+
| A \"**table**\" is a logical unit   | Same concept as INFORMIX.           |
| of storage that contains rows of    |                                     |
| data values.                        |                                     |
+-------------------------------------+-------------------------------------+
| A \"**database**\" is a logical     | Same concept as INFORMIX.           |
| unit of storage that contains table |                                     |
| and index data. Each database also  |                                     |
| contains a system catalog that      |                                     |
| tracks information about database   |                                     |
| elements like tables, indexes,      |                                     |
| stored procedures, integrity        |                                     |
| constraints and user privileges.    |                                     |
+-------------------------------------+-------------------------------------+
| Database tables are created in a    | ?                                   |
| specific \"**dbspace**\", which     |                                     |
| defines a logical place to store    |                                     |
| data.\                              |                                     |
| If no dbspace is given when         |                                     |
| creating the table, INFORMIX        |                                     |
| defaults to the current database    |                                     |
| dbspace.                            |                                     |
+-------------------------------------+-------------------------------------+
| The total disk space allocated for  | ?                                   |
| a table is the \"**tblspace**\",    |                                     |
| which includes \"pages\" allocated  |                                     |
| for data, indexes, blobs, tracking  |                                     |
| page usage within table extents.    |                                     |
+-------------------------------------+-------------------------------------+
| Other concepts                                                            |
+-------------------------------------+-------------------------------------+
| When initializing an INFORMIX       | ?                                   |
| engine, a \"**root dbspace**\" is   |                                     |
| created to store information about  |                                     |
| all databases, including storage    |                                     |
| information (chunks used, other     |                                     |
| dbspaces, etc.).                    |                                     |
+-------------------------------------+-------------------------------------+
| The \"**physical log**\" is a set   | Sybase ASA uses \"**database log    |
| of continuous disk pages where the  | files**\" to record SQL             |
| engine stores \"before-images\" of  | transactions.\                      |
| data that has been modified during  |                                     |
| processing.                         |                                     |
|                                     |                                     |
| The \"**logical log**\" is a set of |                                     |
| \"**logical-log files**\" used to   |                                     |
| record logical operations during    |                                     |
| on-line processing. All transaction |                                     |
| information is stored in the        |                                     |
| logical log files if a database has |                                     |
| been created with transaction log.  |                                     |
|                                     |                                     |
| INFORMIX combines \"physical log\"  |                                     |
| and \"logical log\" information     |                                     |
| when doing fast recovery. Saved     |                                     |
| \"logical logs\" can be used to     |                                     |
| restore a database from tape.       |                                     |
+-------------------------------------+-------------------------------------+
:::

------------------------------------------------------------------------

## [ODIASA046 - The LOAD and UNLOAD instructions]{#ODIASA046}

INFORMIX provides two SQL instructions to export / import data from /
into a database table: The UNLOAD instruction copies rows from a
database table into an text file and the LOAD instruction inserts rows
from an text file into a database table.

**Warning :** Sybase ASA has LOAD and UNLOAD instructions, but those
commands are related to database backup and recovery. Do not confuse
with INFORMIX commands.

**[*Solution:*]{.underline}**

LOAD and UNLOAD instructions are supported.

**Warning :** The LOAD instruction does not work with tables using
emulated SERIAL columns because the generated INSERT statement holds the
\"SERIAL\" column which is actually a IDENTITY column in Sybase ASA. See
the limitations of INSERT statements when using [SERIALs](#ODIASA005).

**Warning :** In Sybase ASA, INFORMIX DATE data is stored in DATETIME
columns, but DATETIME columns are similar to INFORMIX DATETIME YEAR TO
FRACTION(3) columns. Therefore, when using LOAD and UNLOAD, those
columns are converted to text data with the format \"YYYY-MM-DD
hh:mm:ss.fff\".

**Warning :** In Sybase ASA, INFORMIX DATETIME data is stored in
DATETIME columns, but DATETIME columns are similar to INFORMIX DATETIME
YEAR TO FRACTION(3) columns. Therefore, when using LOAD and UNLOAD,
those columns are converted to text data with the format \"YYYY-MM-DD
hh:mm:ss.fff\".

**Warning :** When using an INFORMIX database, simple dates are unloaded
with the DBDATE format (ex: \"23/12/1998\"). Therefore, unloading from
an INFORMIX database for loading into a Sybase ASA database is not
supported.

------------------------------------------------------------------------

## [ODIASA047 - Case sensitivity]{#ODIASA047}

In INFORMIX, database object names like table and column names are not
case sensitive :

> CREATE TABLE Customer ( Custno INTEGER, \... )\
> SELECT CustNo FROM cuSTomer \...

In Sybase ASA, database object names **and character data** are
case-insensitive by default :

> CREATE TABLE Customer ( Custno INTEGER, CustName CHAR(20) )\
> INSERT INTO CUSTOMER VALUES ( 1, \'TECHNOSOFT\' )\
> SELECT CustNo FROM cuSTomer WHERE custname = \'techNOSoft\'

**[*Solution:*]{.underline}**

When you create a Sybase ASA database with **dbinit**, you can use the
-c option to make the database case-sensitive.

------------------------------------------------------------------------

## [ODIASA051 - Setup database statistics]{#ODIASA051}

INFORMIX provides a special instruction to compute database statistics
in order to help the optimizer find the right query execution plan :

> UPDATE STATISTICS \...

Sybase ASA offers a similar instruction, but it uses different clauses :

> UPDATE STATISTICS \...

See Sybase ASA documentation for more details.

[***Solution:***]{.underline}

Centralize the optimization instruction in a function.

------------------------------------------------------------------------

## [ODIASA053 - The ALTER TABLE instruction]{#ODIASA053}

INFORMIX and MS Sybase ASA use different implementations of the ALTER
TABLE instruction. For example, INFORMIX allows you to use multiple ADD
clauses separated by comma. This is not supported by Sybase ASA :

INFORMIX :\
     ALTER TABLE customer **ADD(col1 INTEGER), ADD(col2 CHAR(20))**

Sybase ASA :\
     ALTER TABLE customer **ADD col1 INTEGER, col2 CHAR(20)**

[***Solution:***]{.underline}

**Warning:** No automatic conversion is done by the database interface.
There is even no real standard for this instruction ( that is, no common
syntax for all database servers). Read the SQL documentation and review
the SQL scripts or the BDL programs in order to use the database server
specific syntax for ALTER TABLE.

------------------------------------------------------------------------

## [ODIASA054 - SQL Interruption]{#ODIASA054}

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

[*Solution:*]{.underline}

**Warning:** SQL Interruption is not supported with Sybase ASA.

------------------------------------------------------------------------

## [ODIASA055 - Scrollable Cursors]{#ODIASA055}

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

Sybase ASA supports native scrollable cursors.

***[Solution:]{.underline}***

The Sybase ASA database driver uses the native Sybase ASA scrollable
cursors by setting the 0x0080 flag for options of the dbpp_declare() API
call.

------------------------------------------------------------------------

## [ODIASA100 - Data type conversion table]{#ODIASA100}

::: {align="center"}
**INFORMIX Data Types**
:::

**Sybase ASA Data Types**

CHAR(n)

CHAR(n) (limit = 32767c!)

VARCHAR(n)

VARCHAR(n) (limit = 32767c!)

BOOLEAN

BIT

SMALLINT

SMALLINT

INTEGER

INTEGER

BIGINT

BIGINT

INT8

BIGINT

FLOAT\[(n)\]

FLOAT(n)

SMALLFLOAT

REAL

DECIMAL(p,s)

DECIMAL(p,s)! upper limit = 128 digits

MONEY(p,s)

DECIMAL(p,s)! upper limit = 128 digits

DATE

DATE (yyyy-mm-dd)

DATETIME HOUR TO FRACTION

TIME (hh:mm:ss.fff)

DATETIME q1 TO q2 (q2\>FRACTION)

TIMESTAMP (yyyy-mm-dd hh:mm:ss.fff)

INTERVAL q1 TO q2

CHAR(n)
