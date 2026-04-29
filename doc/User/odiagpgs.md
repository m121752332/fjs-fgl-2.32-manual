[Back to Contents](../index.html)

------------------------------------------------------------------------

# ODI Adaptation Guide For PostgreSQL 8.0.2, 8.1.x, 8.2.x, 8.3.x, 8.4.x, 9.0.x

Installation

::: {align="center"}
  ------------------------------------------------------------
  [Install PostgreSQL and create a database](#ODIPGS_PREP01)
  [Prepare the runtime environment](#ODIPGS_PREP02)
  ------------------------------------------------------------
:::

Database concepts

::: {align="center"}
  ------------------------------------------------------------
  [Database concepts](#ODIPGS007a)
  [Data storage concepts](#ODIPGS039)
  [Data consistency and concurrency management](#ODIPGS008a)
  [Transactions handling](#ODIPGS009)
  [Defining database users](#ODIPGS016a)
  [Setting privileges](#ODIPGS016b)
  ------------------------------------------------------------
:::

Data dictionary

::: {align="center"}
  ----------------------------------------------
  [BOOLEAN data type](#ODIPGS041)
  [CHARACTER data types](#ODIPGS011a)
  [NUMERIC data types](#ODIPGS021)
  [DATE and DATETIME data types](#ODIPGS001)
  [INTERVAL data type](#ODIPGS036)
  [SERIAL data types](#ODIPGS005)
  [ROWIDs](#ODIPGS004)
  [Very large data types](#ODIPGS030)
  [Constraints](#ODIPGS012)
  [Triggers](#ODIPGS013)
  [Stored procedures](#ODIPGS014)
  [Name resolution of SQL objects](#ODIPGS019)
  [Data type conversion table](#ODIPGS100)
  ----------------------------------------------
:::

Data manipulation

::: {align="center"}
  ----------------------------------------------
  [Reserved words](#ODIPGS003)
  [Outer joins](#ODIPGS006)
  [Transactions handling](#ODIPGS009)
  [Temporary tables](#ODIPGS017)
  [Substrings in SQL](#ODIPGS018)
  [The LENGTH( ) function](#ODIPGS011b)
  [Name resolution of SQL objects](#ODIPGS019)
  [String delimiters](#ODIPGS020)
  [Using column aliases in SELECT](#ODIPGS022)
  [MATCHES and LIKE conditions](#ODIPGS024)
  [Querying system catalog tables](#ODIPGS033)
  [Syntax of UPDATE statements](#ODIPGS034)
  [The LENGTH() function](#ODIPGS035)
  ----------------------------------------------
:::

BDL programming

::: {align="center"}
  -------------------------------------------------------------
  [SERIAL data type](#ODIPGS005)
  [Handling SQL errors when preparing statements](#ODIPGS010)
  [INFORMIX specific SQL statements in BDL](#ODIPGS025)
  [INSERT cursors](#ODIPGS028)
  [Cursors WITH HOLD](#ODIPGS031)
  [SELECT FOR UPDATE](#ODIPGS008b)
  [UPDATE/DELETE WHERE CURRENT OF \<cursor\>](#ODIPGS032)
  [The LOAD and UNLOAD instructions](#ODIPGS046)
  [SQL Interruption](#ODIPGS047)
  [Scrollable Cursors](#ODIPGS048)
  -------------------------------------------------------------
:::

------------------------------------------------------------------------

## [Runtime configuration]{#ODIPGS_PREP}

> ### [Install PostgreSQL and create a database]{#ODIPGS_PREP01}
>
> 1.  Compile and install the PostgreSQL Server on your computer.
>     PostgreSQL is a free database, you can download the sources from
>     [www.postgresql.org](http://www.postgresql.org).
>
> 2.  Read PostgreSQL installation notes for details about the **data**
>     directory creation with the **initdb** utility.
>
> 3.  Set configuration parameters in **postgresql.conf**:
>
>     **Warning for PGS 8.1 and 8.2:** UPDATE / DELETE WHERE CURRENT OF
>     needs **oid** column support. Starting with PostgreSQL version
>     8.1, user tables do not get the **oid** column by default. You
>     must set the **default_with_oid** configuration parameter to
>     \"**on**\" in order to get oid columns created. Starting with
>     PostgreSQL 8.3 and the **dbmpgs83x**, WHERE CURRENT OF is
>     supported by the server and the **oid** columns are not used,
>     therefore you do no longer need to set the **default_with_oid**
>     parameter. However, if you plan to use ROWID keywords in SQL,
>     these can be converted to oid keywords, and therefore you need to
>     have oid support by using the **default_with_oid** parameter.
>
> 4.  Start a **postmaster** process to listen to database client
>     connections.\
>     \
>     **Warning:** If you want to connect through TCP (for example from
>     a Windows PostgreSQL client), you must start postmaster with the
>     **-i** option and setup the **pg_hba.conf** file for security
>     (trusted hosts and users).
>
> 5.  Create a PostgreSQL database with the **createdb** utility:\
>     \
>        \$ createdb -h *hostname* *dbname*
>
> 6.  If you plan to use SERIAL emulation, you need the **plpgsql**
>     procedure language, because the database interface uses this
>     language to create serial triggers. Starting with PostgreSQL
>     version **9.0**, the plpgsql language is available by default.
>     Prior to version 9.0, you must create the language in your
>     database with the following command:\
>     \
>        \$ createlang -h *hostname* plpgsql *dbname*
>
> 7.  Connect to the database as the administrator user and create a
>     database user dedicated to your application, the **application
>     administrator**:\
>     \
>        *dbname*=# CREATE USER *appadmin* PASSWORD \'*password*\';\
>        CREATE USER\
>        *dbname*=# GRANT ALL PRIVILEGES ON DATABASE *dbname* TO
>     *appadmin*;\
>        GRANT\
>        *dbname*=# \\q
>
> 8.  Create the **application tables**. Do not forget to convert
>     INFORMIX data types to PostgreSQL data types. See issue
>     [ODIPGS100](#ODIPGS100) for more details.
>
> 9.  If you plan to use the SERIAL emulation, you must prepare the
>     database. See issue [ODIPGS005](#ODIPGS005) for more details.

> ### [Prepare the runtime environment]{#ODIPGS_PREP02}
>
> 1.  In order to connect to PostgreSQL, you must have a PostgreSQL
>     database driver \"**dbmpgs\***\" in FGLDIR/dbdrivers.\
>     \
>     **Warning:** On HP/UX LP64, the PostgreSQL database driver must be
>     linked with the **libxnet** library if you want to use networking.
>
> 2.  The **PostgreSQL client software** is required to connect to a
>     database server. Check if the PostgreSQL client library
>     (**libpq.\***) is installed on the machine where the 4gl programs
>     run.
>
> 3.  Make sure that the PostgreSQL client environment variables are
>     properly set. Check for example **PGDIR** (the path to the
>     installation directory), **PGDATA** (the path to the data files
>     directory), etc. See PostgreSQL documentation for more details.
>
> 4.  Verify the environment variable defining the search path for
>     database client shared libraries (libpq.so on UNIX, LIBPQ.DLL on
>     Windows). On UNIX platforms, the variable is specific to the
>     operating system. For example, on Solaris and Linux systems, it is
>     **LD_LIBRARY_PATH**, on AIX it is **LIBPATH**, or HP/UX it is
>     **SHLIB_PATH**. On Windows, you define the DLL search path in the
>     **PATH** environment variable.
>
>     +-----------------------------------+-----------------------------------+
>     | **PostgreSQL version**            | **Shared library environment      |
>     |                                   | setting**                         |
>     +-----------------------------------+-----------------------------------+
>     | **PostgreSQL 8.0 and higher**     | *UNIX*: Add **\$PGDIR/lib** to    |
>     |                                   | LD_LIBRARY_PATH (or its           |
>     |                                   | equivalent).\                     |
>     |                                   | *Windows*: Add **%PGDIR%\\bin**   |
>     |                                   | to PATH.                          |
>     +-----------------------------------+-----------------------------------+
>     |                                   |                                   |
>     +-----------------------------------+-----------------------------------+
>
> 5.  To verify if the PostgreSQL client environment is correct, you can
>     start the PostgreSQL command interpreter:\
>     \
>          \$ psql *dbname* -U *appadmin* -W
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

[ODIPGS001 - DATE and DATETIME data types]{#ODIPGS001}

INFORMIX provides two data types to store dates and time information:

- **DATE** = for year, month and day storage.
- **DATETIME** = for year to fraction(1-5) storage.

PostgreSQL provides the following data type to store date and time
information:

- **DATE** = for year, month, day storage.
- **TIME \[(p)\] \[{with\|without} time zone\]** = for hour, minute,
  second [and fraction]{.underline} storage.
- **TIMESTAMP \[(p)\] \[{with\|without} time zone\]** = for year, month,
  day, hour, minute, second, fraction storage.

**String representing date time information:**

INFORMIX is able to convert quoted strings to DATE / DATETIME data if
the string contents matches environment parameters (i.e. DBDATE,
GL_DATETIME). As in INFORMIX, PostgreSQL can convert quoted strings to
date time data according to the DateStyle session parameter. PostgreSQL
always accepts ISO date time strings.

**Date arithmetic:**

- INFORMIX supports date arithmetic on DATE and DATETIME values. The
  result of an arithmetic expression involving dates/times is a number
  of days when only DATEs are used and an INTERVAL value if a DATETIME
  is used in the expression.
- In PostgreSQL, the result of an arithmetic expression involving DATE
  values is an INTEGER representing a number of days.
- INFORMIX automatically converts an integer to a date when the integer
  is used to set a value of a date column. PostgreSQL does not support
  this automatic conversion.
- Complex DATETIME expressions ( involving INTERVAL values for example)
  are INFORMIX specific and have no equivalent in PostgreSQL.

**[*Solution:*]{.underline}**

PostgreSQL has the same **DATE** data type as INFORMIX ( year, month,
day ). So you can use PostgreSQL DATE data type for INFORMIX DATE
columns.

PostgreSQL **TIME(0) WITHOUT TIME ZONE** data type can be used to store
INFORMIX DATETIME HOUR TO SECOND values. The database interface makes
the conversion automatically.

INFORMIX DATETIME values with any precision from YEAR to FRACTION(5) can
be stored in PostgreSQL **TIMESTAMP(5) WITHOUT TIME ZONE** columns. The
database interface makes the conversion automatically. Missing date or
time parts default to 1900-01-01 00:00:00.0. For example, when using a
DATETIME HOUR TO MINUTE with the value of \"11:45\", the PostgreSQL
TIMESTAMP value will be \"1900-01-01 11:45:00.0\".

**Warning:** SQL Statements using expressions with TODAY / CURRENT / 
EXTEND must be reviewed and adapted to the native syntax.

**Warning:** Literal DATETIME and INTERVAL expressions (i.e. DATETIME (
1999-10-12) YEAR TO DAY) are not converted.

------------------------------------------------------------------------

[ODIPGS003 - Reserved words]{#ODIPGS003}

SQL object names like table and column names cannot be SQL reserved
words in PostgreSQL.

***[Solution:]{.underline}***

Table or column names which are PostgreSQL reserved words must be
renamed.

------------------------------------------------------------------------

[ODIPGS004 - ROWIDs]{#ODIPGS004}

When creating a table, INFORMIX automatically adds a \"ROWID\" integer
column (applies to non-fragmented tables only). The ROWID column is
auto-filled with a unique number and can be used like a primary key to
access a given row.

When the feature is enabled, PostgreSQL tables are automatically created
with a OID column (Object Identifier) of type INTEGER. The behavior is
equivalent to INFORMIX ROWID columns.

***[Solution:]{.underline}***

The database automatically converts ROWID keywords to OID for
PostgreSQL. So you can execute \"SELECT ROWID FROM\" and \"UPDATE ..
WHERE ROWID = ?\" statements as with INFORMIX.

**Warning:** Starting with PostgreSQL version 8.1, OIDs are no longer
supported by default. You need to define the **default_with_oid**
parameter in postgresql.conf to get OID columns created for tables.

**Warning:** SQLCA.SQLERRD\[6\] is not supported. All references to
SQLCA.SQLERRD\[6\] must be removed because this variable will not hold
the ROWID of the last INSERTed or UPDATEd row when using the PostgreSQL
interface.

------------------------------------------------------------------------

## [ODIPGS005 - SERIAL data types]{#ODIPGS005}

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

PostgreSQL SERIAL data type:

- PostgreSQL\'s SERIAL data type has the same name as in INFORMIX, but
  it behaves differently.
- You cannot define a start value ( SERIAL(100) ).
- You cannot specify zero as serial value to get a new serial, the
  PostgreSQL serial is based on default values, thus you must omit the
  serial column in the INSERT statement.
- When you INSERT a row with a specific value for the serial column, the
  underlying sequence will not be incremented. As result, the next
  INSERT that does not specify the serial column may get a new sequence
  that was already inserted explicitly.
- With some old versions of PostgreSQL, when you drop the table you must
  drop the sequence too.

PostgreSQL sequences:

- Sequences are totally detached from tables.
- The purpose of sequences is to provide unique integer numbers.
- Sequences are identified by a sequence name.
- To create a sequence, you must use the CREATE SEQUENCE statement.\
  Once a sequence is created, it is permanent (like a table).
- To get a new sequence value, you must use the **nextval** function:\
          INSERT INTO tab1 VALUES ( **nextval(\'tab1_seq\')**, \... )
- To get the last generated number, PostgreSQL provides the **currval**
  function :\
          SELECT **currval(\'tab1_seq\')**

**[*Solution:*]{.underline}**

The INFORMIX SERIAL data type can be emulated with three different
methods, according to an FGLPROFILE setting:

dbi.database.\<dbname\>.ifxemul.datatype.serial.emulation

This entry can get the following values: \"native\", \"regtable\" and
\"trigseq\".

[Using the native serial emulation]{.underline}

The \"**native**\" mode is the default serial emulation mode, using the
native PostgreSQL SERIAL data type. In this mode, the original type name
will be left untouched by the SQL Translator and you will get the
behavior of the PostgreSQL SERIAL column type, based on sequences.

**Warning:** INSERT statements cannot use the serial column, even with a
value zero. When using a NULL value, PostgreSQL will report an non-null
constraint error. Thus, the serial column must be omitted from the
INSERT statement.

**Warning:** The **sqlca.sqlerrd\[2\]** register [is not
set]{.underline} after an INSERT when using a PostgreSQL version prior
to **8.3**.

See also PostgreSQL documentation for more details about the native
SERIAL type.

[Using the regtable serial emulation]{.underline}

With the \"**regtable**\" mode, the SERIAL data type is emulated with a
PostgreSQL **INTEGER** data type and **INSERT triggers** using the table
**SERIALREG** which is dedicated to sequence production. After an
insert, **sqlca.sqlerrd\[2\]** register holds the last generated serial
value.

The triggers can be created **manually** during the application database
installation procedure, or **automatically** from a BDL program: When a
BDL program executes a CREATE \[TEMP\] TABLE with a SERIAL column, the
database interface automatically converts the SERIAL data type to
INTEGER and dynamically creates the triggers.

You must create the SERIALREG table as follows:\
\
CREATE TABLE SERIALREG (\
     TABLENAME VARCHAR(50) NOT NULL,\
     LASTSERIAL DECIMAL(20,0) NOT NULL,\
     PRIMARY KEY ( TABLENAME )\
)

**Warning:** The SERIALREG table must be created before the triggers.
The serial production is based on the SERIALREG table which registers
the last generated number for each table. If you delete rows of this
table, sequences will restart at 1 and you will get unexpected data.

In database creation scripts, all SERIAL\[(n)\] data types must be
converted to INTEGER data types and you must create one trigger for each
table. To know how to write those triggers,  you can create a small
Genero program that creates a table with a SERIAL column. Set the
FGLSQLDEBUG environment variable and run the program. The debug output
will show you the native trigger creation command.

**Warning:** With this emulation mode, INSERT statements using NULL for
the SERIAL column will produce a new serial value:\
   INSERT INTO tab (col1,col2) VALUES (NULL,\'data\')\
This behavior is mandatory in order to support INSERT statements which
do not use the serial column:\
   INSERT INTO tab (col2) VALUES (\'data\')\
Check if your application uses tables with a SERIAL column that can
contain a NULL value.\
Consider to remove the serial column from the INSERT statements.

[Using the trigseq serial emulation]{.underline}

With \"**trigseq**\", the SERIAL data type is emulated with a PostgreSQL
**INTEGER** data type and **INSERT triggers** using a sequence
**\<tablename\>\_seq**. After an insert, **sqlca.sqlerrd\[2\]** register
holds the last generated serial value.

The triggers can be created **manually** during the application database
installation procedure, or **automatically** from a BDL program: When a
BDL program executes a CREATE \[TEMP\] TABLE with a SERIAL column, the
database interface automatically converts the SERIAL data type to
INTEGER and dynamically creates the triggers.

In database creation scripts, all SERIAL\[(n)\] data types must be
converted to INTEGER data types and you must create one trigger for each
table. To know how to write those triggers,  you can create a small
Genero program that creates a table with a SERIAL column. Set the
FGLSQLDEBUG environment variable and run the program. The debug output
will show you the native trigger creation command.

**Warning:** With this emulation mode, INSERT statements using NULL for
the SERIAL column will produce a new serial value:\
   INSERT INTO tab (col1,col2) VALUES (NULL,\'data\')\
This behavior is mandatory in order to support INSERT statements which
do not use the serial column:\
   INSERT INTO tab (col2) VALUES (\'data\')\
Check if your application uses tables with a SERIAL column that can
contain a NULL value.\
Consider to remove the serial column from the INSERT statements.

[Issues common to all serial emulation modes]{.underline}

**Warning:** Since **sqlca.sqlerrd\[2\]** is defined as an INTEGER, it
cannot hold values from BIGSERIAL (BIGINT) auto incremented columns. If
you are using BIGSERIAL columns, you must query the sequence
pseudo-column CURRVAL() or fetch the LASTSERIAL column from the
SERIALREG table if used.

For SQL portability, INSERT statements should be reviewed to remove the
SERIAL column from the list.\
For example, the following statement:\
   INSERT INTO tab (col1,col2) VALUES (**0**, p_value)\
can be converted to :\
   INSERT INTO tab (col2) VALUES (p_value)\
Static SQL INSERT using records defined from the schema file must also
be reviewed :\
   DEFINE rec LIKE tab.\*\
   INSERT INTO tab VALUES ( rec.\* )   \-- will use the serial column\
can be converted to :\
   INSERT INTO tab VALUES rec.\* \-- without braces, serial column is
removed

------------------------------------------------------------------------

[ODIPGS006 - Outer joins]{#ODIPGS006}

In INFORMIX SQL, outer tables can be defined in the FROM clause with the
**OUTER** keyword:

> SELECT ... FROM a, OUTER(b)
>      WHERE a.key = b.akey
>
>     SELECT ... FROM a, OUTER(b,OUTER(c))
>      WHERE a.key = b.akey
>        AND b.key1 = c.bkey1
>        AND b.key2 = c.bkey2 

PostgreSQL supports the ANSI outer join syntax:

> SELECT ... FROM cust LEFT OUTER JOIN order
>                          ON cust.key = order.custno
>
>     SELECT ...
>       FROM cust LEFT OUTER JOIN order
>                      LEFT OUTER JOIN item
>                      ON order.key = item.ordno
>                 ON cust.key = order.custno
>      WHERE order.cdate > current date

See the PostgreSQL reference for a complete description of the syntax.

***[Solution:]{.underline}***

For better SQL portability, you should use the ANSI outer join syntax
instead of the old Informix OUTER syntax.

The PostgreSQL interface can convert most INFORMIX OUTER specifications
to ANSI outer joins.

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
4.  [Temporary tables](#ODIPGS017) are supported in OUTER
    specifications.

------------------------------------------------------------------------

[ODIPGS007a - Database concepts]{#ODIPGS007a}

Most BDL applications use only one database entity (in the meaning of
INFORMIX). But the same BDL application can connect to different
occurrences of the same database schema, allowing several users to
connect to those different databases.

Like INFORMIX servers, PostgreSQL can handle multiple database entities.
Tables created by a user can be accessed without the owner prefix by
other users as long as they have access privileges to these tables.

**[*Solution:*]{.underline}**

Create a PostgreSQL database for each INFORMIX database.

------------------------------------------------------------------------

[ODIPGS008a - Data consistency and concurrency management]{#ODIPGS008a}

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

[PostgreSQL]{.underline}

When data is modified, **exclusive locks** are set and held until the
end of the transaction. For data consistency, PostgreSQL uses a
**multi-version consistency model**: A copy of the original row is kept
for readers before performing writer modifications. Readers do not have
to wait for writers as in INFORMIX. The simplest way to think of
PostgreSQL implementation of read consistency is to imagine each user
operating a private copy of the database, hence the multi-version
consistency model. The **lock wait** [mode]{.underline} cannot be
changed as in INFORMIX. Locks are set at the **row level** in PostgreSQL
and this cannot be changed.

Control:

- No lock wait mode control is provided.
- Isolation level : SET TRANSACTION ISOLATION LEVEL \...
- Explicit exclusive lock : SELECT \... FOR UPDATE

Defaults:

- The default isolation level is Read Committed.

The main difference between INFORMIX and PostgreSQL is that readers do
not have to wait for writers in PostgreSQL.

**[*Solution:*]{.underline}**

The SET ISOLATION TO \... INFORMIX syntax is replaced by SET SESSION
CHARACTERISTICS AS TRANSACTION ISOLATION LEVEL \... in PostgreSQL. The
next table shows the isolation level mappings done by the PostgreSQL
database driver:

::: {align="center"}
  ----------------------------------- -----------------------------------
  **SET ISOLATION instruction in      **Native SQL command**
  program**                           

  SET ISOLATION TO DIRTY READ         SET SESSION CHARACTERISTICS AS\
                                       TRANSACTION ISOLATION LEVEL READ
                                      COMMITTED

  SET ISOLATION TO COMMITTED READ\    SET SESSION CHARACTERISTICS AS\
    \[READ COMMITTED\] \[RETAIN        TRANSACTION ISOLATION LEVEL READ
  UPDATE LOCKS\]                      COMMITTED

  SET ISOLATION TO CURSOR STABILITY   SET SESSION CHARACTERISTICS AS\
                                       TRANSACTION ISOLATION LEVEL READ
                                      COMMITTED

  SET ISOLATION TO REPEATABLE READ    SET SESSION CHARACTERISTICS AS\
                                       TRANSACTION ISOLATION LEVEL
                                      SERIALIZABLE
  ----------------------------------- -----------------------------------
:::

For portability, it is recommended that you work with INFORMIX in the
read committed isolation level, make processes wait for each other (lock
mode wait), and create tables with the \"lock mode row\" option.

See INFORMIX and PostgreSQL documentation for more details about data
consistency, concurrency and locking mechanisms.

------------------------------------------------------------------------

[ODIPGS008b - SELECT FOR UPDATE]{#ODIPGS008b}

A lot of BDL programs use pessimistic locking in order to avoid several
users editing the same rows at the same time.

   DECLARE cc CURSOR FOR\
         SELECT \... FROM tab WHERE \... FOR UPDATE\
   OPEN cc\
   FETCH cc \<\-- lock is acquired\
   \...\
   CLOSE cc \<\-- lock is released

In both INFORMIX and PostgreSQL, locks are released when closing the
cursor or when the transaction ends.

PostgreSQL locking granularity is at the row level.

To control the behavior of the program when locking rows, INFORMIX
provides a specific instruction to set the wait mode:

   SET LOCK MODE TO { WAIT \| NOT WAIT \| WAIT *seconds* }

The default mode is NOT WAIT. This as an INFORMIX specific SQL
statement.

**Warning:** PostgreSQL has no equivalent for \"SET LOCK MODE TO NOT
WAIT\".

**[*Solution:*]{.underline}**

**Warning:** The database interface is based on an emulation of an
INFORMIX engine using transaction logging. Therefore, opening a SELECT
\... FOR UPDATE cursor declared outside a transaction will raise an SQL
error -255 (not in transaction).

You must review the program logic if you use pessimistic locking because
it is based on the NOT WAIT mode which is not supported by PostgreSQL.

------------------------------------------------------------------------

[ODIPGS009 - Transactions handling]{#ODIPGS009}

INFORMIX and PostgreSQL handle transactions in a similar manner.

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

PostgreSQL supports transaction with savepoints:

- Transactions are started with BEGIN WORK.
- Transactions are validated with COMMIT WORK.
- Transactions are canceled with ROLLBACK WORK.
- Savepoints can be placed with SAVEPOINT *name*.
- Transactions can be rolled back to a savepoint with ROLLBACK TO
  SAVEPOINT *name*.
- Savepoints can be be released with RELEASE SAVEPOINT *name*.
- Statements executed outside of a transaction are automatically
  committed.
- DDL statements can be executed (and canceled) in transactions.
- If an SQL error occurs in a transaction, the whole transaction is
  aborted.

Transactions in stored procedures: avoid using transactions in stored
procedures to allow the client applications to handle transactions,
according to the transaction model.

**Warning:** The main difference between INFORMIX and PostgreSQL resides
in the fact that PostgreSQL cancels the whole transaction if an SQL
error occurs in one of the statements executed inside the transaction.
The following code example illustrates this difference:

   CREATE TABLE tab1 ( k INT PRIMARY KEY, c CHAR(10) )\
   WHENEVER ERROR CONTINUE\
   BEGIN WORK\
   INSERT INTO tab1 ( 1, \'abc\' )\
   INSERT INTO tab1 ( 1, \'abc\' ) \-- PK constraint violation = SQL
Error, whole TX aborted\
   COMMIT WORK

With INFORMIX, this code will leave the table with one row inside, since
the first INSERT statement succeeded. With PostgreSQL, the table will
remain empty after executing this piece of code, because the server will
rollback the whole transaction. To workaround this problem in PostgreSQL
you can use SAVEPOINT as described below in the *Solution*.

**[*Solution:*]{.underline}**

INFORMIX transaction handling commands are automatically converted to
PostgreSQL instructions to start, validate or cancel transactions.

Regarding the transaction control instructions, the BDL applications do
not have to be modified in order to work with PostgreSQL.

**Warning:** You must review the SQL statements inside BEGIN WORK /
COMMIT WORK instruction and check if these can raise and SQL error. The
SQL statements that can potentially raise an SQL error must be protected
with a SAVEPOINT. If an error occurs, just rollback to the savepoint:

   CREATE TABLE tab1 ( k INT PRIMARY KEY, c CHAR(10) )\
   WHENEVER ERROR CONTINUE\
   BEGIN WORK\
   INSERT INTO tab1 ( 1, \'abc\' )\
**   CALL sql_protect()\**
   INSERT INTO tab1 ( 1, \'abc\' ) \-- PK constraint violation = SQL
Error\
**   CALL sql_unprotect()\**
   COMMIT WORK\
   \...\
\
   FUNCTION sql_protect()\
      IF NOT dbtype == \"PGS\" THEN RETURN END IF\
      EXECUTE IMMEDIATE \"SAVEPOINT \_sql_protect\_\"\
   END FUNCTION\
\
   FUNCTION sql_unprotect()\
      IF NOT dbtype == \"PGS\" THEN RETURN END IF\
      IF SQLCA.SQLCODE \< 0 THEN\
         EXECUTE IMMEDIATE \"ROLLBACK TO SAVEPOINT \_sql_protect\_\"\
      ELSE\
         EXECUTE IMMEDIATE \"RELEASE SAVEPOINT \_sql_protect\_\"\
      END IF\
   END FUNCTION

**Warning:** If you want to use savepoints, do not use the UNIQUE
keyword in the savepoint declaration, always specify the savepoint name
in ROLLBACK TO SAVEPOINT, and do not drop savepoints with RELEASE
SAVEPOINT.

------------------------------------------------------------------------

[ODIPGS010 - Handling SQL errors when preparing statements]{#ODIPGS010}

The PostgreSQL connector is implemented with the PostgreSQL **libpq**
API. This library does not provide a way to send SQL statements to the
database server during the BDL PREPARE instruction, like the INFORMIX
interface. The statement is sent to the server only when opening the
cursors or when executing the statement, because the database driver
needs to provide the data types of the SQL parameters (only known at
OPEN / EXECUTE time).

Therefore, when preparing an SQL statement with the BDL PREPARE
instruction, no SQL errors can be returned if the statement has syntax
errors or if a column or a table name does not exist in the database.

However, an SQL error will occur after the OPEN or EXECUTE instructions.

**[*Solution:*]{.underline}**

Check that your BDL programs do not test STATUS or SQLCA.SQLCODE
variable just after PREPARE instructions.

Change the program logic in order to handle the SQL errors when opening
the cursors (OPEN) or when executing SQL statements (EXECUTE).

------------------------------------------------------------------------

## [ODIPGS041 - BOOLEAN data type]{#ODIPGS041}

INFORMIX supports the BOOLEAN data type, which can store \'t\' or \'f\'
values. Genero BDL implements the BOOLEAN data type in a different way:
As in other programming languages, Genero BOOLEAN stores integer values
1 or 0 (for TRUE or FALSE). The type was designed this way to assign the
result of a Boolean expression to a BOOLEAN variable.

PostgreSQL supports the BOOLEAN data type and stores \'t\' or \'f\'
values for TRUE and FALSE representation. It is not possible to insert
the integer values 1 or 0: Values must be true, false, \'1\' or \'0\'.

**[*Solution:*]{.underline}**

The PostgreSQL database interface supports the BOOLEAN data type, and
converts the BDL BOOLEAN integer values to a CHAR(1) of \'t\' or \'f\'.

------------------------------------------------------------------------

[ODIPGS011a - CHARACTER data types]{#ODIPGS011a}

INFORMIX supports following character data types:

- CHAR(N) with N\<= 32767 bytes
- VARCHAR(N\[,M\]) with N\<=255 bytes
- NCHAR(N) with N\<= 32767 bytes
- NVARCHAR(N\[,M\]) with N\<=255 bytes
- LVARCHAR (not covered in this section)

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

PostgreSQL provides the following character types:

- CHAR(N) with N\<= 10485760 characters
- VARCHAR(N) with N\<= 10485760 characters
- TEXT with a limit of 1GB

In PostgreSQL, CHAR, VARCHAR and TEXT types store data in single byte or
multi-byte character sets. For CHAR and VARCHAR, the size is specified
in a number of characters, not bytes. The character set used to store
data for these types is defined by the database character set, which can
be specified when you create the database with the *createdb* tool or
the CREATE DATABASE SQL command.

Automatic character set conversion between the PostgreSQL client and
server is supported. You must properly specify the client character set
for PostgreSQL, this can be done with different ways, for example with
the SET CLIENT_ENCODING TO SQL command, or with configuration
parameters. See PostgreSQL documentation for more details.

**[*Solution:*]{.underline}**

INFORMIX \[VAR\]CHAR(N) types can be mapped to PostgreSQL \[VAR\]CHAR(N)
types.

Keep in mind that PostgreSQL uses Character Length Semantics regarding
CHAR/VARCHAR sizes: When you define a CHAR(20) and the database
character set is multi-byte, the PostgreSQL column can hold more
bytes/characters as the INFORMIX CHAR(20) type. For example, in UTF-8,
you can store 20 é (e-acute) characters in PGS CHAR(20), but only IFX
CHAR(20) can only store 10 of such characters, because in UTF-8, é is
encoded with 2 bytes. Even if Genero uses Byte Length Semantics when you
define a CHAR/VARCHAR variable, a good practice is to use the same sizes
for PostgreSQL CHAR/VARCHAR columns: You could then store more
characters in the PGS columns as the Genero variable can hold, but this
is not a problem.

You can store single-byte or multi-byte character strings in PostgreSQL
CHAR, VARCHAR and TEXT columns.

Do not forget to properly define the client character set, which must
correspond to the runtime system character set.

See also the section about [Localization](Localization.html).

------------------------------------------------------------------------

[ODIPGS011b - The LENGTH( ) function]{#ODIPGS011b}

**Warning:** PostgreSQL raises an error if the LENGTH() parameter is
NULL. INFORMIX returns zero instead.

***[Solution:]{.underline}***

The PostgreSQL database interface cannot simulate the behavior of the
INFORMIX LENGTH() SQL function.

Review the program logic and make sure you do not pass NULL values to
the LENGTH() SQL function.

------------------------------------------------------------------------

## [ODIPGS012 - Constraints]{#ODIPGS012}

**Constraint naming syntax:**

Both INFORMIX and PostgreSQL support primary key, unique, foreign key,
default and check constraints, but the constraint naming syntax is
different. PostgreSQL expects the \"CONSTRAINT\" keyword **before** the
constraint specification and INFORMIX expects it **after**.

**UNIQUE constraint example:**

  ----------------------------------- -----------------------------------
  **INFORMIX**                        **PostgreSQL**

  CREATE TABLE scott.emp (\           CREATE TABLE scott.emp (\
  \...\                               \...\
  empcode CHAR(10) UNIQUE\            empcode CHAR(10)\
     **\[CONSTRAINT pk_emp\]**,\         **\[CONSTRAINT pk_emp\]**
  \...                                UNIQUE,\
                                      \...
  ----------------------------------- -----------------------------------

**Unique constraints:**

**Warning:** When using a unique constraint, INFORMIX allows only one
row with a NULL value, while PostgreSQL allows several rows with NULL!

**[*Solution:*]{.underline}**

The database interface does not convert constraint naming expressions
when creating tables from BDL programs. Review the database creation
scripts to adapt the constraint naming clauses for PostgreSQL.

------------------------------------------------------------------------

## [ODIPGS013 - Triggers]{#ODIPGS013}

INFORMIX and PostgreSQL provide triggers with similar features, but the
trigger creation syntax and the programming languages are totally
different.

**[*Solution:*]{.underline}**

INFORMIX triggers must be converted to PostgreSQL triggers \"by hand\".

------------------------------------------------------------------------

[ODIPGS014 - Stored procedures]{#ODIPGS014}

Both INFORMIX and PostgreSQL support stored procedures, but the
programming languages are totally different. With PostgreSQL you must
create the stored procedure language before writing triggers or stored
procedures.

**[*Solution:*]{.underline}**

INFORMIX stored procedures must be converted to PostgreSQL manually.

------------------------------------------------------------------------

[ODIPGS016a - Defining database users]{#ODIPGS016a}

INFORMIX users are defined at the operating system level, they must be
members of the \'informix\' group, and the database administrator must
grant CONNECT, RESOURCE or DBA privileges to those users.

PostgreSQL users must be registered in the database. They are created by
the **createuser** utility:

   \$ createuser \--username=\<username\> \--password

**[*Solution:*]{.underline}**

According to the application logic (is it a multi-user application ?),
you have to create one or several PostgreSQL users.

------------------------------------------------------------------------

[ODIPGS016b - Setting privileges]{#ODIPGS016b}

INFORMIX and PostgreSQL user privileges management are quite similar.

PostgreSQL provides **user groups** to grant or revoke permissions to
more than one user at the same time.

------------------------------------------------------------------------

[ODIPGS017 - Temporary tables]{#ODIPGS017}

INFORMIX temporary tables are created through the **CREATE TEMP TABLE**
DDL instruction or through a **SELECT \... INTO TEMP** statement.
Temporary tables are automatically dropped when the SQL session ends,
but they can be dropped with the DROP TABLE command. There is no name
conflict when several users create temporary tables with the same name.

INFORMIX allows you to create indexes on temporary tables. No name
conflict occurs when several users create an index on a temporary table
by using the same index identifier.

PostgreSQL support temporary tables as INFORMIX does, with a little
syntax difference in the SELECT INTO TEMP instruction.

***[Solution:]{.underline}***

Temporary tables are well supported with native PostgreSQL temp tables.

------------------------------------------------------------------------

[ODIPGS018 - Substrings in SQL]{#ODIPGS018}

INFORMIX SQL statements can use subscripts on columns defined with the
character data type:

    SELECT \... FROM tab1 WHERE **col1\[2,3\]** = \'RO\'\
    SELECT \... FROM tab1 WHERE **col1\[10\]**  = \'R\'   \-- Same as
col1\[10,10\]\
    UPDATE tab1 SET **col1\[2,3\]**= \'RO\' WHERE \...\
    SELECT \... FROM tab1 ORDER BY **col1\[1,3\]**

.. while PostgreSQL provides the SUBSTR( ) function, to extract a
substring from a string expression:

    SELECT \.... FROM tab1 WHERE **SUBSTRING(col1 from 2 for 2)** =
\'RO\'\
    SELECT **SUBSTRING(\'Some text\' from 6 for 3)** \...   \-- Gives
\'tex\'

**[*Solution:*]{.underline}**

You must replace all INFORMIX col\[x,y\] expressions by SUBSTRING( col
from x for (y-x+1) ).

**Warning:** In UPDATE instructions, setting column values through
subscripts will produce an error with PostgreSQL :\
    UPDATE tab1 SET **col1\[2,3\]** = \'RO\' WHERE \...\
is converted to:\
    UPDATE tab1 SET **SUBSTRING(col1 from 2 for (3-2+1))** = \'RO\'
WHERE \...

**Warning:** Column subscripts in ORDER BY expressions are also
converted and produce an error with PostgreSQL:\
    SELECT \... FROM tab1 ORDER BY **col1\[1,3\]**\
is converted to:\
    SELECT \... FROM tab1 ORDER BY **SUBSTRING(col1 from 1 for(3-1+1))**

------------------------------------------------------------------------

[ODIPGS019 - Name resolution of SQL objects]{#ODIPGS019}

INFORMIX uses the following form to identify an SQL object :

  \[database\[@dbservername\]:\]\[{owner\|\"owner\"}.\]identifier

With PostgreSQL, an object name takes the following form:\
  \[owner.\]identifier

**[*Solution:*]{.underline}**

Check for single or double quoted table or column names in your source
and remove them.

------------------------------------------------------------------------

[ODIPGS020 - String delimiters]{#ODIPGS020}

The ANSI string delimiter character is the single quote ( \'string\').
Double quotes are used to delimit database object names
(\"object-name\").

Example: WHERE \"tabname\".\"colname\" = \'a string value\'

INFORMIX allows double quotes as string delimiters, but PostgreSQL
doesn\'t. This is important since many BDL programs use that character
to delimit the strings in SQL commands.

Note: This problem concerns only double quotes within SQL statements.
Double quotes used in pure BDL string expressions are not subject to SQL
compatibility problems.

***[Solution:]{.underline}***

The PostgreSQL database interface can automatically replace all double
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
by PostgreSQL.

Although double quotes are replaced automatically in SQL statements, you
should use only single quotes to enforce portability.

------------------------------------------------------------------------

[ODIPGS021 - NUMERIC data types]{#ODIPGS021}

INFORMIX supports several data types to store numbers:

::: {align="center"}
  ------------------------ --------------------------------------------
  **INFORMIX Data Type**   **Description**
  SMALLINT                 16 bit signed integer
  INT/INTEGER              32 bit signed integer
  BIGINT                   64 bit signed integer
  INT8                     64 bit signed integer (replaced by BIGINT)
  SMALLINT                 16 bit integer  ( -2\^15 to 2\^15 )
  INT/INTEGER              32 bit integer  ( -2\^31 to 2\^31 )
  DEC/DECIMAL(p)           Floating-point decimal number
  DEC/DECIMAL(p,s)         Fixed-point decimal number
  MONEY                    Equivalent to DECIMAL(16,2)
  MONEY(p)                 Equivalent to DECIMAL(p,2)
  MONEY(p,s)               Equivalent to DECIMAL(p,s)
  REAL/SMALLFLOAT          approx floating point (C float)
  DOUBLE PREC./FLOAT       approx floating point (C double)
  ------------------------ --------------------------------------------
:::

**[*Solution:*]{.underline}**

PostgreSQL supports the following data types to store numbers:

::: {align="center"}
  ----------------------------- -----------------------------------------------------
  **PostgreSQL data type**      **Description**
  NUMERIC(p,s) / DECIMAL(p,s)   Decimals with precision and scale (fractional part)
  NUMERIC(p) / DECIMAL(p)       Integers with p digits (no fractional part)
  NUMERIC / DECIMAL             Floating point numbers (no limit)
  FLOAT4                        16 bit variable precision
  FLOAT8                        32 bit variable precision
  INT2                          16 bit signed integer
  INT4                          32 bit signed integer
  INT8                          64 bit signed integer
  ----------------------------- -----------------------------------------------------
:::

ANSI types like SMALLINT, INTEGER, FLOAT are supported by PostgreSQL as
aliases to INT2, INT4 and FLOAT8 native types.

INFORMIX DECIMAL(p) floating point types are converted to DECIMAL
without precision/scale, to store any floating point number in
PostgreSQL.

------------------------------------------------------------------------

[ODIPGS022 - Using column aliases in SELECT]{#ODIPGS022}

PostgreSQL expects the ANSI notation for column aliases :

   SELECT col1 **AS col1_alias** FROM \...

INFORMIX supports the ANSI notation.

**[*Solution:*]{.underline}**

**Warning:** The database interface cannot convert INFORMIX alias
specification to the ANSI notation.

Review your programs and replace the INFORMIX notation with the ANSI
form.

------------------------------------------------------------------------

[ODIPGS024 - MATCHES and LIKE in SQL conditions]{#ODIPGS024}

INFORMIX supports MATCHES and LIKE in SQL statements. PostgreSQL
supports the LIKE statement as in INFORMIX, plus the \~ operators that
are similar but different from the INFORMIX MATCHES operator.

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

PostgreSQL \~ operator expects regular expressions as follows:\
   ( col \~ \'a.\*\' )

***[Solution:]{.underline}***

**Warning:** SQL statements using MATCHES expressions must be reviewed
in order to use LIKE expressions.

See also: [MATCHES operator in SQL
Programming](SqlProgramming.html#PORT_MATCHES).

------------------------------------------------------------------------

[ODIPGS025 - INFORMIX specific SQL statements in BDL]{#ODIPGS025}

The BDL compiler supports several INFORMIX specific SQL statements that
have no meaning when using PostgreSQL.

- CREATE DATABASE
- DROP DATABASE
- START DATABASE (SE only)
- ROLLFORWARD DATABASE
- SET \[BUFFERED\] LOG
- CREATE TABLE with special options (storage, lock mode, etc.)

***[Solution:]{.underline}***

Review your BDL source and remove all static SQL statements which are
INFORMIX specific.

------------------------------------------------------------------------

[ODIPGS028 - INSERT cursors]{#ODIPGS028}

INFORMIX supports insert cursors. An \"insert cursor\" is a special BDL
cursor declared with an INSERT statement instead of a SELECT statement.
When this kind of cursor is open, you can use the PUT instruction to add
rows and the FLUSH instruction to insert the records into the database.

For INFORMIX database with transactions, OPEN, PUT and FLUSH
instructions must be executed within a transaction.

PostgreSQL does not support insert cursors.

**[*Solution:*]{.underline}**

Insert cursors are emulated by the PostgreSQL database interface.

------------------------------------------------------------------------

[ODIPGS030 - Very large data types]{#ODIPGS030}

Both INFORMIX and PostgreSQL Server provide special data types to store
very large texts or images:

::: {align="center"}
  ------------------------ ------------------------------
  **INFORMIX Data Type**   **PostgreSQL** **Data Type**
  TEXT                     TEXT
  BYTE                     BYTEA
  ------------------------ ------------------------------
:::

**[*Solution:*]{.underline}**

TEXT and BYTE data can be stored in PostgreSQL TEXT and BYTEA columns.

------------------------------------------------------------------------

[ODIPGS031 - Cursors WITH HOLD]{#ODIPGS031}

INFORMIX closes opened cursors automatically when a transaction ends
unless the WITH HOLD option is used in the DECLARE instruction. In
PostgreSQL, opened cursors using SELECT statements without a FOR UPDATE
clause are not closed when a transaction ends. Actually, all PostgreSQL
cursors are \'WITH HOLD\' cursors unless the FOR UPDATE clause is used
in the SELECT statement.

**Warning:** Cursors declared FOR UPDATE and using the WITH HOLD option
cannot be supported with PostgreSQL because FOR UPDATE cursors are
automatically closed by PostgreSQL when the transaction ends.

**[*Solution:*]{.underline}**

BDL cursors that are not declared \"WITH HOLD\" are automatically closed
by the database interface when a COMMIT WORK or ROLLBACK WORK is
performed.

**Warning:** Since PostgreSQL automatically closes FOR UPDATE cursors
when the transaction ends, opening cursors declared FOR UPDATE and WITH
HOLD option results in an SQL error that does not normally appear with
INFORMIX, in the same conditions. Review the program logic in order to
find another way to set locks.

------------------------------------------------------------------------

[ODIPGS032 - UPDATE/DELETE WHERE CURRENT OF \<cursor\>]{#ODIPGS032}

INFORMIX allows positioned UPDATEs and DELETEs with the \"WHERE CURRENT
OF \<cursor\>\" clause, if the cursor has been DECLARED with a SELECT
\... FOR UPDATE statement.

**PGS 8.1 and 8.2:** UPDATE/DELETE \... WHERE CURRENT OF \<cursor\> is
not supported by PostgreSQL. However, you can use the OID column to do
positioned updates/deletes.

**Since PGS 8.3:** UPDATE/DELETE \... WHERE CURRENT OF \<cursor\> is
supported by PostgreSQL with server-side cursors created with a DECLARE
statement.

**[*Solution:*]{.underline}**

[With PostgreSQL 8.1 (dbmpgs81x) and 8.2 (dbmpgs82x):]{.underline}

UPDATE/DELETE \... WHERE CURRENT OF instructions are managed by the
PostgreSQL database interface. The PostgreSQL database interface
replaces \"WHERE CURRENT OF \<cursor\>\"  by  \"WHERE OID = ?\" and sets
the value of the Object Identifier returned by the last FETCH done with
the given cursor..

**Warning PGS 8.1 and 8.2:** Starting with PostgreSQL version 8.1, user
tables do not get the **oid** column by default. You must set the
**default_with_oid** configuration parameter in the **postgresql.conf**
file.

[With PostgreSQL 8.3 (dbmpgs83x) and higher:]{.underline}

UPDATE/DELETE \... WHERE CURRENT OF instructions are just executed as
is. Since SELECT FOR UPDATE statements are now executed with a server
cursor by using a DECLARE PostgreSQL statement, native positioned
update/delete takes place.

------------------------------------------------------------------------

[ODIPGS033 - Querying system catalog tables]{#ODIPGS033}

As in INFORMIX, PostgreSQL provides system catalog tables (actually,
system views). But the table names and their structure are quite
different.

**[*Solution:*]{.underline}**

**Warning:** No automatic conversion of INFORMIX system tables is
provided by the database interface.

------------------------------------------------------------------------

[ODIPGS034 - Syntax of UPDATE statements]{#ODIPGS034}

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

[ODIPGS035 - The LENGTH() function]{#ODIPGS035}

INFORMIX provides the LENGTH() function:

    SELECT LENGTH(\"aaa\"), LENGTH(col1) FROM table

PostgreSQL has a equivalent function with the same name, but there is
some difference:

INFORMIX does not count the trailing blanks neither for CHAR not for
VARCHAR expressions, while PostgreSQL counts the trailing blanks.

With the PostgreSQL LENGTH function, when using a CHAR column, values
are always blank padded, so the function returns the size of the CHAR
column. When using a VARCHAR column, trailing blanks are significant,
and the function returns the number of characters, including trailing
blanks.

**[*Solution:*]{.underline}**

You must check if the trailing blanks are significant when using the
LENGTH() function.

If you want to count the number of character by ignoring the trailing
blanks, you must use the RTRIM() function:

------------------------------------------------------------------------

[ODIPGS036 - INTERVAL data type]{#ODIPGS036}

INFORMIX INTERVAL data type stores a value that represents a span of
time. INTERVAL types are divided into two classes : ***year-month
intervals*** and ***day-time intervals***.

Starting with version 8.4, PostgreSQL provides an INTERVAL data type
which is equivalent to the Informix INTERVAL type; Here are some
features of the PostgreSQL 8.4 interval type:

- It is possible to specify the interval class / precision with YEAR,
  MONTH, DAY, HOUR, MINUTE and SECOND\[(p)\] fields.
- Fractional part of seconds can be defined with up to 6 digits.
- INTERVALs value range is from -178000000 to +178000000 years.
- Input and ouput format can be controlled with the SET intervalstyle
  command.

**[*Solution:*]{.underline}**

Starting with Genero 2.21, database drivers dbmpgs84x and higher convert
the Informix-style INTERVAL type to the native PostgreSQL INTERVAL type.
See the [data type conversion table](#ODIPGS100) for the exact
conversion rules.

**Warning:** The PostgreSQL database driver forces the **intervalstyle**
session parameter to \'iso_8601\', this is required to insert and fetch
interval database with the libpq C API functions. You must not change
this setting during program execution. 

**Warning:** While PostgreSQL INTERVALs support up to 9 digits for the
higher unit like Informix, YEAR values range from -178000000 to
+178000000 only. This limitation exists in PostgreSQL 8.4 and may be
solved in future versions.

With PostgreSQL and driver versions prior to 8.4, the INTERVAL data type
is converted to CHAR(50).

------------------------------------------------------------------------

[ODIPGS039 - Data storage concepts]{#ODIPGS039}

An attempt should be made to preserve as much of the storage information
as possible when converting from INFORMIX to PostgreSQL. Most important
storage decisions made for INFORMIX database objects (like initial sizes
and physical placement) can be reused for the PostgreSQL database.

Storage concepts are quite similar in INFORMIX and in PostgreSQL, but
the names are different.

------------------------------------------------------------------------

[ODIPGS046 - The LOAD and UNLOAD instructions]{#ODIPGS046}

INFORMIX provides two SQL instructions to export / import data from /
into a database table: The UNLOAD instruction copies rows from a
database table into a text file and the LOAD instructions insert rows
from a text file into a database table.

PostgreSQL does not provide LOAD and UNLOAD instructions.

**[*Solution:*]{.underline}**

LOAD and UNLOAD instructions are supported.

------------------------------------------------------------------------

[ODIPGS047 - SQL Interruption]{#ODIPGS047}

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

PostgreSQL supports SQL Interruption in a similar way as INFORMIX. The
db client must issue an PQcancel() libPQ call to interrupt a query.

[***Solution:***]{.underline}

The PostgreSQL database driver supports SQL interruption and converts
the SQLSTATE code 57014 to the INFORMIX error code -213.

------------------------------------------------------------------------

## [ODIPGS048 - Scrollable Cursors]{#ODIPGS048}

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

PostgreSQL supports native scrollable cursors.

***[Solution:]{.underline}***

The PostgreSQL database driver uses native scrollable cursors by
declaring (DECLARE) server cursors with the SCROLL clause. 

------------------------------------------------------------------------

[ODIPGS100 - Data type conversion table]{#ODIPGS100}

::: {align="center"}
  ----------------------------------------- ----------------------------------------- -----------------------------------------
  **INFORMIX Data Types**                   **PostgreSQL Data Types (before 8.4)**    **PostgreSQL Data Types (since 8.4)**
  CHAR(n)                                   CHAR(n)                                   CHAR(n)
  VARCHAR(n)                                VARCHAR(n)                                VARCHAR(n)
  INTEGER                                   INT4                                      INT4
  SMALLINT                                  INT2                                      INT2
  FLOAT\[(n)\]                              FLOAT4                                    FLOAT4
  SMALLFLOAT                                FLOAT8                                    FLOAT8
  DECIMAL(p,s)                              DECIMAL(p,s)                              DECIMAL(p,s)
  DECIMAL(p)                                DECIMAL (no precision = floating point)   DECIMAL (no precision = floating point)
  DECIMAL                                   DECIMAL                                   DECIMAL
  MONEY(p,s)                                DECIMAL(p,s)                              DECIMAL(p,s)
  DATE                                      DATE                                      DATE
  DATETIME HOUR TO SECOND                   TIME(0) WITHOUT TIME ZONE                 TIME(0) WITHOUT TIME ZONE
  DATETIME YEAR TO FRACTION(p)              TIMESTAMP(p) WITHOUT TIME ZONE            TIMESTAMP(p) WITHOUT TIME ZONE
  INTERVAL YEAR\[(p)\] TO MONTH             CHAR(50)                                  INTERVAL YEAR TO MONTH
  INTERVAL YEAR\[(p)\] TO YEAR              CHAR(50)                                  INTERVAL YEAR
  INTERVAL MONTH\[(p)\] TO MONTH            CHAR(50)                                  INTERVAL MONTH
  INTERVAL DAY\[(p)\] TO FRACTION(n)        CHAR(50)                                  INTERVAL DAY TO SECOND(n)
  INTERVAL DAY\[(p)\] TO SECOND             CHAR(50)                                  INTERVAL DAY TO SECOND(0)
  INTERVAL DAY\[(p)\] TO MINUTE             CHAR(50)                                  INTERVAL DAY TO MINUTE
  INTERVAL DAY\[(p)\] TO HOUR               CHAR(50)                                  INTERVAL DAY TO HOUR
  INTERVAL DAY\[(p)\] TO DAY                CHAR(50)                                  INTERVAL DAY
  INTERVAL HOUR\[(p)\] TO FRACTION(n)       CHAR(50)                                  INTERVAL HOUR TO SECOND(n)
  INTERVAL HOUR\[(p)\] TO SECOND            CHAR(50)                                  INTERVAL HOUR TO SECOND(0)
  INTERVAL HOUR\[(p)\] TO MINUTE            CHAR(50)                                  INTERVAL HOUR TO MINUTE
  INTERVAL HOUR\[(p)\] TO HOUR              CHAR(50)                                  INTERVAL HOUR
  INTERVAL MINUTE\[(p)\] TO FRACTION(n)     CHAR(50)                                  INTERVAL MINUTE TO SECOND(n)
  INTERVAL MINUTE\[(p)\] TO SECOND          CHAR(50)                                  INTERVAL MINUTE TO SECOND(0)
  INTERVAL MINUTE\[(p)\] TO MINUTE          CHAR(50)                                  INTERVAL MINUE
  INTERVAL SECOND\[(p)\] TO FRACTION(n)     CHAR(50)                                  INTERVAL SECOND(n)
  INTERVAL SECOND\[(p)\] TO SECOND          CHAR(50)                                  INTERVAL SECOND(0)
  INTERVAL FRACTION\[(p)\] TO FRACTION(n)   CHAR(50)                                  INTERVAL SECOND(n)
  TEXT                                      TEXT                                      TEXT
  BYTE                                      BYTEA                                     BYTEA
  ----------------------------------------- ----------------------------------------- -----------------------------------------
:::
