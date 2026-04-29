[Back to Contents](../index.html)

------------------------------------------------------------------------

# ODI Adaptation Guide For Sybase ASE 15.5+

Installation

::: {align="center"}
  --------------------------------------------------------
  [Install Sybase and create a database](#ODIASE_PREP01)
  [Prepare the runtime environment](#ODIASE_PREP02)
  --------------------------------------------------------
:::

Database concepts

::: {align="center"}
  ------------------------------------------------------------
  [Database concepts](#ODIASE007a)
  [Data consistency and concurrency management](#ODIASE008a)
  [Transactions handling](#ODIASE009)
  [Defining database users](#ODIASE016a)
  [Setting privileges](#ODIASE016b)
  ------------------------------------------------------------
:::

Data dictionary

::: {align="center"}
  ----------------------------------------------
  [BOOLEAN data type](#ODIASE010)
  [CHARACTER data types](#ODIASE011)
  [NUMERIC data types](#ODIASE021)
  [DATE and DATETIME data types](#ODIASE001)
  [INTERVAL data type](#ODIASE036)
  [SERIAL data types](#ODIASE005)
  [ROWIDs](#ODIASE004)
  [Case sensitivity](#ODIASE047)
  [Very large data types](#ODIASE030)
  [The ALTER TABLE instruction](#ODIASE053)
  [Constraints](#ODIASE012)
  [Triggers](#ODIASE013)
  [Stored procedures](#ODIASE014)
  [Name resolution of SQL objects](#ODIASE019)
  [Setup database statistics](#ODIASE051)
  [Data type conversion table](#ODIASE100)
  ----------------------------------------------
:::

Data manipulation

::: {align="center"}
  ----------------------------------------------
  [Reserved words](#ODIASE003)
  [Outer joins](#ODIASE006)
  [Transactions handling](#ODIASE009)
  [Temporary tables](#ODIASE017)
  [Substrings in SQL](#ODIASE018)
  [Name resolution of SQL objects](#ODIASE019)
  [String delimiters](#ODIASE020)
  [Getting one row with SELECT](#ODIASE022)
  [MATCHES and LIKE conditions](#ODIASE024)
  [Querying system catalog tables](#ODIASE033)
  [Syntax of UPDATE statements](#ODIASE034)
  ----------------------------------------------
:::

BDL programming

::: {align="center"}
  -------------------------------------------------------
  [SERIAL data type](#ODIASE005)
  [INFORMIX specific SQL statements in BDL](#ODIASE025)
  [INSERT cursors](#ODIASE028)
  [Cursors WITH HOLD](#ODIASE031)
  [SELECT FOR UPDATE](#ODIASE008b)
  [The LOAD and UNLOAD instructions](#ODIASE046)
  [SQL Interruption](#ODIASE054)
  [Scrollable Cursors](#ODIASE055)
  -------------------------------------------------------
:::

------------------------------------------------------------------------

## [Runtime configuration]{#ODIASE_PREP} {#runtime-configuration align="left"}

> ### [Install Sybase ASE and create a database]{#ODIASE_PREP01} {#install-sybase-ase-and-create-a-database align="left"}
>
> 1.  Install Sybase ASE software on your computer, with the Sybase
>     client software.\
>     Make sure that the server is started and environment variables are
>     properly set (On UNIX, you will find SYBASE.\* shell scripts to
>     source in the installation directory).
>
> 2.  Try to connect to the server with the **isql** command line tool.
>     By default, the **sa** user is defined with a blank password.\
>     It is strongly recommended to set the **sa** password after
>     installation:\
>     \
>        \$ isql -S *server_name* -U sa\
>        1\> sp_password null, *new_password\*
>        2\> go\
>        Password correctly set.\
>        (return status = 0)
>
> 3.  Define server\'s **default character set**:\
>     **Warning:** With Sybase ASE, the db character set cannot be
>     specified at the database level, it is defined at the server
>     level.\
>     After starting the server, you must identify what server character
>     set you want to use (for example, utf8) and re-configure the
>     server.\
>     With Sybase ASE 15.5, this must be done with the **charset**
>     command line utility and with the **sp_configure** stored
>     procedure. Note that you have to shutdown the server, start a
>     first time to have the server take the new character set into
>     account and then restart a second time for use. See Sybase
>     Documentation for more details or more recent versions of Sybase
>     ASE.\
>     **Warning:** Make sure that you select a case-sensitive character
>     set / sort order.
>
> 4.  Create a new Sybase **database** entity:\
>     You can use either the **Sybase Central** GUI tool or use **isql**
>     with SQL commands.\
>     You must connect to the server with the **sa** user.\
>     [Commands:]{.underline}\
>        use master\
>        go\
>        create database *dbname* with \... *options* \...\
>        go
>
> 5.  Leave the default transaction mode (*unchained* mode), to force
>     explicit transaction start and end commands.\
>     See the **set chained** command for more details.
>
> 6.  **Warning:** The database allows NULLs by default when creating
>     columns. This is controlled by the \'allow nulls by default\'
>     option. If this option is set to OFF, columns created without NULL
>     or NOT NULL keywords are NOT NULL by default.\
>     [Commands:]{.underline}\
>        master..sp_dboption *dbname* \'allow nulls by default\', true\
>        go
>
> 7.  The database must allow Data Definition Language (DDL) statements
>     in transaction blocks.\
>     To turn this on, use following commands:\
>     \
>        master..sp_dboption *dbname*, \'ddl in tran\', true\
>        go\
>        checkpoint\
>        go
>
> 8.  For development purpose, you may consider to set the next database
>     option to truncate the transaction log when a checkpoint occurs,
>     otherwise you will have to dump the transaction log when it is
>     full:\
>     [Commands:]{.underline}\
>        master..sp_dboption *dbname* \'trunc log on chkpt\', true\
>        go
>
> 9.  Create a new **login** dedicated to your application: the
>     **application administrator**.\
>     **Warning:** Assign the new created database as default database
>     for this user. \
>     [Commands:]{.underline}\
>        use *dbname*\
>        go\
>        sp_addlogin \'*username*\', \'*password*\', *dbname*, \...
>     *options* \...\
>        go
>
> 10. Create a new **database user** linked to the new application
>     administrator login:\
>     In Sybase Central, open to the \"Databases\" node, select
>     \"Users\" and right-click \"New\"\...\
>     [Commands:]{.underline}\
>        use *dbname*\
>        go\
>        sp_adduser \'*username*\', \'*group*\', \... *options* \...\
>        go\
>     \
>     See documentation for more details about database users and
>     privileges. You must create groups to make tables visible to all
>     users.
>
> 11. If you plan to use SERIAL emulation based on triggers using a
>     registration table, create the SERIALREG table. Create the
>     triggers for each table using a SERIAL. See issue
>     [ODIASE005](#ODIASE005) for more details.
>
> 12. Create the **application tables**. Do not forget to convert
>     INFORMIX data types to Sybase ASE data types. See topic
>     [ODIASE100](#ODIASE100) for more details.\
>     **Warning:** In order to make application tables visible to all
>     users, make sure that all users are members of the group of the
>     owner of the application tables. For more details, see ASE
>     documentation (\"Database object names and prefixes\").
>
> ### [Prepare the runtime environment]{#ODIASE_PREP02} {#prepare-the-runtime-environment align="left"}
>
> 1.  In order to connect to Sybase ASE, you must have a Sybase ASE
>     database driver \"**dbmase\***\" in FGLDIR/dbdrivers.
>
> 2.  If you want to connect to a remote database server, you must have
>     the **Sybase ASE Client Software** installed on the computer
>     running 4gl applications. The **Sybase Open Client Library** is
>     required.
>
> 3.  Make sure that the Sybase ASE client environment variables are
>     properly set. Check for example **SYBASE** (the path to the
>     installation directory), **SYBASE_ASE** (the name of the server
>     sub-directory), **SYBASE_OCS** (the name of the client
>     sub-directory), etc. See Sybase ASE documentation for more
>     details.
>
> 4.  Verify the environment variable defining the search path for
>     database client shared libraries (libsybct\[64\].so and
>     libsybcs\[64\].so on UNIX, LIBSYBCT.DLL and LIBSYBCS.DLL on
>     Windows). On UNIX platforms, the variable is specific to the
>     operating system. For example, on Solaris and Linux systems, it is
>     **LD_LIBRARY_PATH**, on AIX it is **LIBPATH**, or HP/UX it is
>     **SHLIB_PATH**. On Windows, you define the DLL search path in the
>     **PATH** environment variable.
>
>     +-----------------------------------+-----------------------------------+
>     | **Sybase ASE version**            | **Shared library environment      |
>     |                                   | setting**                         |
>     +-----------------------------------+-----------------------------------+
>     | **Sybase ASE 15.5 and higher**    | *UNIX*: Add                       |
>     |                                   | **\$SYBASE/*OCSDIR*/lib** to      |
>     |                                   | LD_LIBRARY_PATH (or its           |
>     |                                   | equivalent).\                     |
>     |                                   | *Windows*: Add                    |
>     |                                   | **%SYBASE%\\*OCSDIR*\\dll** to    |
>     |                                   | PATH.\                            |
>     |                                   | Where *OCSDIR* is the directory   |
>     |                                   | of the Sybase Open Client         |
>     |                                   | Software. For example, with       |
>     |                                   | Sybase 15.5, this directory is    |
>     |                                   | named **OCS-15_0**.               |
>     +-----------------------------------+-----------------------------------+
>     |                                   |                                   |
>     +-----------------------------------+-----------------------------------+
>
> 5.  The name of the Sybase server must be registered in a
>     configuration file. On UNIX, the server name must be defined in
>     the **interfaces** file located in \$SYBASE. On Windows, the
>     server name must be defined in the **sql.ini** file located in
>     %SYBASE%\\ini.\
>     You may want to define the **DSQUERY** environment variable to the
>     name of the server.\
>     See Sybase documentation for more details.\
>     Note that when connecting from a Genero program, both database and
>     server names can be specified with:\
>        database@server\
>     For more details see the description for the [connection data
>     source](Connections.html#DS_ODI_CP_SOURCE) parameter in DATABASE
>     and CONNECT instructions.
>
> 6.  Check the database client locale settings:[\]{.underline}
>     The Sybase client locale must match the locale used by the runtime
>     system (**LANG** on UNIX, **ANSI code page** on Windows).\
>     By default, Sybase OCS uses the character set defined by the
>     operating system. On Windows, this is the ANSI code page, on UNIX
>     it is defined by LC_CTYPE, LC_ALL or LANG environment variables.
>     Note that Genero BDL allows to define the LANG environment
>     variable also on Windows.\
>     **Warning:** The value of the LANG environment variable must be
>     listed in the **locales.dat** file under the **\$SYBASE/locales**
>     directory, otherwise you will get an error when connecting to the
>     database. \
>     See also Sybase OCS documentation regarding localization and
>     character set definition.
>
> 7.  Test the Sybase ASE Client Software: Make sure the server is
>     started and try to connect to a database by using the Sybase ASE
>     command interpreter:\
>     \
>          \$ isql -S *server* -U *appadmin* -P *password*
>
> 8.  Set up the **fglprofile** entries for [database
>     connections](Connections.html#DS_ODI_DBVSPEC):
>
>     **Warning:** **Make sure that you are using the ODI driver
>     corresponding to the database client and server version. Because
>     Informix features emulation are dependant from the database server
>     version, it is mandatory to use the same version of the database
>     client and ODI driver as the server version.**\
>
>     - Define the connection timeout with the following fglprofile
>       entry:\
>           dbi.database.*dbname*.ase.logintime = *integer*\
>       This entry defines the number of seconds to wait for a
>       connection.\
>       Default is 5 seconds.
>
>     - Define the number of rows to be pre-fetched for result sets:\
>           dbi.database.*dbname*.ase.prefetch.rows = *integer\*
>       Default is 10 rows.

------------------------------------------------------------------------

[ODIASE001 - DATE and DATETIME data types]{#ODIASE001}

INFORMIX provides two data types to store dates and time information:

- **DATE** = for year, month and day storage.
- **DATETIME** = for year to fraction(1-5) storage.

Sybase ASE provides these data type to store dates :

- **DATE** = for year, month, day storage.
- **TIME** = for hour, minutes, seconds, fraction(3) storage.
- **SMALLDATETIME** = for hour, minutes, seconds, fraction(3) storage.
- **DATETIME** = for hour, minutes, seconds, fraction(3) storage.
- **BIGTIME** = for hour, minutes, seconds, fraction(6) storage.
- **BIGDATETIME** = for year, month, day, hour, minutes, seconds,
  fraction(6) storage.

**String representing date time information :**

INFORMIX is able to convert quoted strings to DATE / DATETIME data if
the string contents matches environment parameters (i.e. DBDATE,
GL_DATETIME). As in INFORMIX, Sybase ASE can convert quoted strings
representing datetime data in the ANSI format. The CONVERT( ) SQL
function allows you to convert strings to dates.

**Date time arithmetic:**

- INFORMIX supports date arithmetic on DATE and DATETIME values. The
  result of an arithmetic expression involving dates/times is a number
  of days when only DATEs are used and an INTERVAL value if a DATETIME
  is used in the expression.
- INFORMIX automatically converts an integer to a date when the integer
  is used to set a value of a date column. Sybase ASE does not support
  this automatic conversion.
- Complex DATETIME expressions ( involving INTERVAL values for example )
  are INFORMIX specific and have no equivalent in Sybase ASE.
- With Sybase ASE you must use built-in functions to do date/time
  computing (for example, see dateadd() function).
- INFORMIX converts automatically an integer to a date when the integer
  is used to set a value of a date column. Sybase ASE does not support
  this automatic conversion.

**[*Solution:*]{.underline}**

Sybase ASE has the same **DATE** data type as INFORMIX ( year, month,
day ). So you can use Sybase ASE DATE data type for INFORMIX DATE
columns.

Sybase ASE **BIGTIME** data type can be used to store INFORMIX DATETIME
HOUR TO SECOND and DATETIME HOUR TO FRACTION(5) values. The database
interface makes the conversion automatically.

INFORMIX DATETIME values with any precision from YEAR to FRACTION(5) can
be stored in Sybase ASE **BIGDATETIME** columns. The database interface
makes the conversion automatically. Missing date or time parts default
to 1900-01-01 00:00:00.0. For example, when using a DATETIME HOUR TO
MINUTE with the value of \"11:45\", the ASE TIMESTAMP value will be
\"1900-01-01 11:45:00.0\".

Literal DATETIME and INTERVAL expressions (i.e. DATETIME ( 1999-10-12 )
YEAR TO DAY) are translated by the driver to convert() expressions.

**Warning:** Using integers as a number of days in an expression with
dates is not supported by Sybase ASE. Check your code to detect where
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

[ODIASE003 - Reserved words]{#ODIASE003}

Even if Sybase ASE allows SQL reserved keywords as SQL object names if
enclosed in square braces ([create table \[table\] ( col1 int
)]{.small}), you should take care of your existing database schema and
check that you do not use Sybase ASE SQL words.

***[Solution:]{.underline}***

Database objects having a name which is a Sybase ASE SQL reserved word
must be renamed.

All BDL application sources must be verified. To check if a given
keyword is used in a source, you can use UNIX \'grep\' or \'awk\' tools.
Most modifications can be automatically done with UNIX tools like
\'sed\' or \'awk\'.

------------------------------------------------------------------------

## [ODIASE004 - ROWIDs]{#ODIASE004}

When creating a table, INFORMIX automatically adds a \"ROWID\" integer
column (applies to non-fragmented tables only). The ROWID column is
auto-filled with a unique number and can be used like a primary key to
access a given row.

Sybase ASE tables have no ROWIDs.

***[Solution:]{.underline}***

If the BDL application uses ROWIDs, the program logic should be reviewed
in order to use the real primary keys (usually, serials which can be
supported).

All references to SQLCA.SQLERRD\[6\] must be removed because this
variable will not hold the ROWID of the last INSERTed or UPDATEd row
when using the Sybase ASE interface.

------------------------------------------------------------------------

[ODIASE005 - SERIAL data type]{#ODIASE005}

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

Sybase ASE **IDENTITY** columns :

- When creating a table, the IDENTITY keyword must be specified after
  the column data type:\
     CREATE TABLE tab1 ( k integer identity, c char(10) )
- You cannot specify a start value
- A new number is automatically created when inserting a new row :\
     INSERT INTO tab1 ( c ) VALUES ( \'aaa\' )
- To get the last generated number, Sybase ASE provides a global
  variable :\
     SELECT **@@IDENTITY**
- When IDENTITY_INSERT is ON, you can set a specific value into a
  IDENTITY column, but zero does not generate a new serial:\
     SET IDENTITY_INSERT tab1 ON\
     INSERT INTO tab1 ( k, c ) VALUES ( 100, \'aaa\' )

INFORMIX SERIALs and MS Sybase ASE IDENTITY columns are quite similar;
the main difference is that MS Sybase ASE does not generate a new serial
when you specify a zero value for the identity column.

**[*Solution*]{.underline} :**

You are free to use **IDENTITY columns** (1) or **insert triggers based
on the SERIALREG** table (2). The first solution is faster, but does not
allow explicit serial value specification in insert statements; the
second solution is slower but allows explicit serial value
specification.  You can initially use the second solution to have
unmodified 4gl programs working on Sybase ASE, but you should update
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
INTEGER IDENTITY(n) in Sybase ASE.

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

2\. Using triggers with the SERIALREG table

First, you must prepare the database and create the SERIALREG table as
follows:\
\
CREATE TABLE serialreg (\
     tablename VARCHAR(50) NOT NULL,\
     lastserial BIGINT NOT NULL,\
     PRIMARY KEY ( tablename )\
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

**Warning** : Sybase ASE does not allow you to create triggers on
temporary tables. Therefore, you cannot create temp tables with a SERIAL
column when using this solution.

**Warning** : SELECT \... INTO TEMP statements using a table created
with a SERIAL column do not automatically create the SERIAL triggers in
the temporary table. The type of the column in the new table is INTEGER.

**Warning** : Sybase ASE triggers are not automatically dropped when the
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

## [ODIASE006 - Outer joins]{#ODIASE006}

The original OUTER join syntax of INFORMIX is different from the Sybase
ASE outer join syntax:

In INFORMIX SQL, outer tables can be defined in the **FROM** clause with
the **OUTER** keyword :

> SELECT ... FROM cust, OUTER(order)
>      WHERE cust.key = order.custno
>
>     SELECT ... FROM cust, OUTER(order,OUTER(item))
>      WHERE cust.key = order.custno
>        AND order.key = item.ordno
>        AND order.accepted = 1

Sybase ASE Version 7 supports the ANSI outer join syntax :

> SELECT ... FROM cust LEFT OUTER JOIN order
>                          ON cust.key = order.custno
>
>     SELECT ...
>       FROM cust LEFT OUTER JOIN order
>                      LEFT OUTER JOIN item
>                      ON order.key = item.ordno
>                 ON cust.key = order.custno
>      WHERE order.accepted = 1

The old way to define outer joins in Sybase ASE looks like the following
:

> SELECT ... FROM a, b WHERE a.key *= b.key

See the Sybase ASE reference manual for a complete description of the
syntax.

***[Solution:]{.underline}***

For better SQL portability, you should use the ANSI outer join syntax
instead of the old Informix OUTER syntax.

The Sybase ASE interface can convert simple INFORMIX OUTER
specifications to Sybase ASE ANSI outer joins.

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
4.  [Temporary tables](#ODIASE017) are supported in OUTER
    specifications.

------------------------------------------------------------------------

[ODIASE007a - Database concepts]{#ODIASE007a}

As in INFORMIX, an Sybase ASE engine can manage multiple database
entities. When creating a database object such as a table, Sybase ASE
allows you to use the same object name in different databases.

------------------------------------------------------------------------

[ODIASE008a - Data consistency and concurrency management]{#ODIASE008a}

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

**Sybase ASE**

As in INFORMIX, Sybase ASE uses locks to manage data consistency and
concurrency. The database manager sets **exclusive locks** on the
modified rows and **shared locks** when data is read, according to the
**isolation level**. The locks are held until the end of the
transaction. When multiple processes want to access the same data, the
latest processes must wait until the first finishes its transaction or
the lock timeout occurred. The **lock granularity** is at the row or
table level. For more details, see Sybase ASE\'s Documentation.

Control :

- The lock wait mode can be controlled with:\
   SET LOCK {WAIT seconds \| NOWAIT}
- Isolation level : Can be set with:\
   SET TRANSACTION ISOLATION LEVEL = {0\|1\|2\|3}
- Locking granularity : Row level.
- Explicit locking : SELECT \... FOR UPDATE

Defaults :

- The default isolation level is Read Committed ( readers cannot see
  uncommitted data; no shared lock is set when reading data ).

**[*Solution:*]{.underline}**

The SET ISOLATION TO \... INFORMIX syntax is replaced by SET TRANSACTION
ISOLATION LEVEL \... in Sybase ASE. The next table shows the isolation
level mappings done by the Sybase ASE database driver:

::: {align="center"}
  ----------------------------------- -----------------------------------
  **SET ISOLATION instruction in      **Native SQL command**
  program**                           

  SET ISOLATION TO DIRTY READ         SET TRANSACTION ISOLATION LEVEL = 0

  SET ISOLATION TO COMMITTED READ\    SET TRANSACTION ISOLATION LEVEL = 1
    \[READ COMMITTED\] \[RETAIN       
  UPDATE LOCKS\]                      

  SET ISOLATION TO CURSOR STABILITY   SET TRANSACTION ISOLATION LEVEL = 2

  SET ISOLATION TO REPEATABLE READ    SET TRANSACTION ISOLATION LEVEL = 3
  ----------------------------------- -----------------------------------
:::

For portability, it is recommended that you work with INFORMIX in the
read committed isolation level, to make processes wait for each other
(lock mode wait) and to create tables with the \"lock mode row\" option.

The SET LOCK MODE TO \... INFORMIX syntax is replaced by SET LOCK \...
in Sybase ASE. If SET LOCK MODE TO WAIT is used in programs (i.e. wait
forever), the driver will simulate this with a SET LOCK WAIT 5000 in
Sybase ASE:

::: {align="center"}
  ------------------------------------------ ------------------------
  **SET LOCK MODE instruction in program**   **Native SQL command**
  SET LOCK MODE TO NOT WAIT                  SET LOCK NOWAIT
  SET LOCK MODE TO WAIT n                    SET LOCK WAIT n
  SET LOCK MODE TO WAIT                      SET LOCK WAIT 5000
  ------------------------------------------ ------------------------
:::

See INFORMIX and Sybase ASE documentation for more details about data
consistency, concurrency and locking mechanisms.

------------------------------------------------------------------------

[ODIASE008b - SELECT FOR UPDATE]{#ODIASE008b}

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

Sybase ASE ignores the FOR UPDATE clause when not used in a native
Sybase SQL DECLARE command. In order to lock rows when doing a SELECT,
with Sybase you must add the **holdlock** hint or the **at isolation
repeatable read** clause. Sybase supports SELECT locking outside
transactions (i.e. WITH HOLD cursors).

- Locks are acquired when opening the cursor.
- When the cursor (WITH HOLD) is opened outside a transaction, locks are
  released when the cursor is closed.
- When the cursor is opened inside a transaction, locks are released
  when the transaction ends.

Sybase ASE\'s locking granularity is at the row level, page level or
table level (the level is automatically selected by the engine for
optimization).

To control the behavior of the program when locking rows, INFORMIX
provides a specific instruction to set the wait mode:

   SET LOCK MODE TO { WAIT \| NOT WAIT \| WAIT *seconds* }

The default mode is WAIT. SET LOCK MODE is as an INFORMIX specific SQL
statement which is translated by the driver.

**[*Solution:*]{.underline}**

SELECT FOR UPDATE statements are supported: The Sybase ASE driver adds
the \"**at isolation repeatable read**\" keywords to the end of any
SELECT FOR UPDATE statement.

**Warning :** Sybase ASE requires a PRIMARY KEY or UNIQUE INDEX on the
table using in the SELECT .. FOR UPDATE statement.

**Warning :** Sybase ASE locks the rows when you open the cursor. You
will have to test SQLCA.SQLCODE after doing an OPEN.

**Warning :** The database interface is based on an emulation of an
INFORMIX engine using transaction logging. Therefore, opening a SELECT
\... FOR UPDATE cursor declared outside a transaction will raise an SQL
error -255 (not in transaction).

**Warning :** The SELECT FOR UPDATE statement cannot contain an ORDER BY
clause if you want to perform positioned updates/deletes with WHERE
CURRENT OF.

------------------------------------------------------------------------

[ODIASE009 - Transactions handling]{#ODIASE009}

INFORMIX and Sybase ASE handle transactions in a similar manner.

INFORMIX native mode (non ANSI) :

- Transactions are started with \"BEGIN WORK\".
- Transactions are validated with \"COMMIT WORK\".
- Transactions are canceled with \"ROLLBACK WORK\".
- Statements executed outside of a transaction are automatically
  committed.
- DDL statements can be executed (and canceled) in transactions.

Sybase ASE :

- Sybases supports two transaction modes:
  1.  The SQL standards-compatible mode, called *chained* mode, to get
      implicit transaction.
  2.  The default mode, called *unchained* mode, where transactions have
      to be started/ended explicitly.
- Transactions are started with \"BEGIN TRANSACTION \[name\]\".
- Transactions are validated with \"COMMIT TRANSACTION \[name\]\".
- Transactions are canceled with \"ROLLBACK TRANSACTION \[name\]\".
- Transactions save points can be placed with \"SAVEPOINT \[name\]\".
- Sybase ASE supports named and nested transactions.
- DDL statements can be executed in transactions blocks when the \'ddl
  in tran\' option is set to true with:\
     master..sp_dboption dbname, \'ddl in tran\', true\
     go\
     checkpoint\
     go 

**[*Solution:*]{.underline}**

INFORMIX transaction handling commands are automatically converted to
Sybase ASE instructions to start, commit or rollback transactions.

Make sure that the database uses the default *unchained* mode (set
chained off) and allows DDLs in transactions (\'ddl in tran\' option is
true).

Regarding the transaction control instructions, the BDL applications do
not have to be modified in order to work with Sybase ASE.

------------------------------------------------------------------------

## [ODIASE010 - BOOLEAN data type]{#ODIASE010}

INFORMIX supports the BOOLEAN data type, which can store \'t\' or \'f\'
values. Genero BDL implements the BOOLEAN data type in a different way:
As in other programming languages, Genero BOOLEAN stores integer values
1 or 0 (for TRUE or FALSE). The type was designed this way to assign the
result of a Boolean expression to a BOOLEAN variable.

Sybase ASE provides the BIT data type to store Boolean values. However,
unlike Informix, BIT columns cannot be NULL and thus you must specify
the NOT NULL constraint when creating the table.

**[*Solution:*]{.underline}**

The Sybase ASE database interface converts BOOLEAN type to BIT columns
and stores 1 or 0 values in the column.

**Warning: You must explicitly specify the NOT NULL constraint in the
CREATE TABLE statement.**

------------------------------------------------------------------------

[ODIASE011 - CHARACTER data types]{#ODIASE011}

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

Sybase ASE implements the following character data types:

- CHAR(N) with N \<= 16384 bytes
- VARCHAR(N) with N \<= 16384 bytes
- NCHAR(N) with N \<= 16384 characters
- NVARCHAR(N) with N \<= 16384 characters
- UNICHAR(N) with N \<= 16384 characters
- UNIVARCHAR(N) with N \<= 16384 characters

Like Informix, Sybase ASE can store multi-byte characters in CHAR /
VARCHAR columns, according to the database character set. For example,
Sybase can store UTF-8 strings in CHAR/VARCHAR columns. For multi-byte
character sets, you could also use the NCHAR / NVARCHAR or UNICHAR /
UNIVARCHAR Sybase ASE types, the only difference with CHAR / VARCHAR is
that the length is specified in characters instead of bytes. Note that
the UNICHAR / UNIVARCHAR store characters in 16bit UCS-2 charset only,
but this is transparent to the database client.

Sybase supports automatic character set conversion between the client
application and the server. By default, the Sybase database client
character set is defined by the **operating system locale** where the
database client runs. On Windows, it is the ANSI code page of the login
session (can be overwritten by setting the LANG environment variable),
on UNIX it is defined by the LC_CTYPE, LC_ALL or LANG environment
variable. Note that you may need to edit the
\$SYBASE/locales/locales.dat file to map the OS locale name to a known
Sybase character set.

**Warning: Unlike most other database engines, Sybase ASE trims trailing
blanks when inserting character strings in a VARCHAR column.**

For example:

   CREATE TABLE t1 ( k INT, vc VARCHAR(5) )\
   INSERT INTO t1 VALUES ( 1, \'abc  \' )\
   SELECT \'\[\'\|\|vc\|\|\'\]\' FROM t1 WHERE k = 1\
  
\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--\
   \[abc\]

With other database servers you would get:

   \[abc  \]

**[*Solution:*]{.underline}**

If your application must support multi-byte character sets like BIG5 or
UTF-8, you should use CHAR / VARCHAR Sybase data types, where the length
is specified in bytes like with Informix.

**Warning** : Check that your database schema does not use CHAR or
VARCHAR types with a length exceeding the Sybase ASE limit.

**Warning** : Since trailing blanks are trimmed for VARCHARs, make sure
that your application does not rely on this non-standard behavior.

See also the section about [Localization](Localization.html).

------------------------------------------------------------------------

[ODIASE012 - Constraints]{#ODIASE012}

**Constraint naming syntax :**

Both INFORMIX and Sybase ASE support primary key, unique, foreign key,
default and check constraints. But Sybase ASE does not support
constraint naming syntax:

UNIQUE constraint example :

::: {align="left"}
  ----------------------------------- -----------------------------------
  **INFORMIX**                        **Sybase ASE**

  CREATE TABLE scott.emp (\           CREATE TABLE scott.emp (\
  \...\                               \...\
  empcode CHAR(10) UNIQUE\            empcode CHAR(10) UNIQUE,\
     **\[CONSTRAINT pk_emp\]**,\      \...
  \...                                
  ----------------------------------- -----------------------------------
:::

**[*Solution:*]{.underline}**

**Constraint naming syntax :**

The database interface does not convert constraint naming expressions
when creating tables from BDL programs. Review the database creation
scripts to adapt the constraint naming clauses for Sybase ASE.

------------------------------------------------------------------------

[ODIASE013 - Triggers]{#ODIASE013}

INFORMIX and Sybase ASE provide triggers with similar features, but the
programming languages are totally different.

**Warning :** Sybase ASE does not support triggers on temporary tables.

**[*Solution:*]{.underline}**

INFORMIX triggers must be converted to Sybase ASE triggers \"by hand\".

------------------------------------------------------------------------

[ODIASE014 - Stored procedures]{#ODIASE014}

Both INFORMIX and Sybase ASE support stored procedures, but the
programming languages are totally different :

- INFORMIX stored procedures must be written in **SPL**.
- Sybase ASE stored procedures must be written in **Sybase ASE SQL**.

**[*Solution:*]{.underline}**

INFORMIX stored procedures must be converted to Sybase ASE \"by hand\".

See [SQL Programming](SqlProgramming.html#SP_ASE) for more details about
executing stored procedures with Sybase ASE.

------------------------------------------------------------------------

[ODIASE016a - Defining database users]{#ODIASE016a}

INFORMIX users are defined at the operating system level, they must be
members of the \'informix\' group, and the database administrator must
grant CONNECT, RESOURCE or DBA privileges to those users.

Before a user can access an Sybase ASE database, the system
administrator (DBA) must declare the application users in the database
with the GRANT statement. You may also need to define groups in order to
make tables visible to other users.

**[*Solution:*]{.underline}**

See Sybase ASE documentation for more details on database logins and
users.

------------------------------------------------------------------------

[ODIASE016b - Setting privileges]{#ODIASE016b}

INFORMIX and Sybase ASE user privileges management are quite similar.

Sybase ASE provides **user groups** to grant or revoke permissions to
more than one user at the same time.

------------------------------------------------------------------------

[ODIASE017 - Temporary tables]{#ODIASE017}

INFORMIX temporary tables are created through the **CREATE TEMP TABLE**
DDL instruction or through a **SELECT \... INTO TEMP** statement.
Temporary tables are automatically dropped when the SQL session ends,
but they can also be dropped with the DROP TABLE command. There is no
name conflict when several users create temporary tables with the same
name.

**Warning** : The CREATE TEMP TABLE and SELECT INTO TEMP statements are
not supported in Sybase ASE.

Sybase ASE supports temporary tables by using the \# pound sign before
the table name:

    CREATE TABLE **#temp1** ( kcol INTEGER, \.... )\
    SELECT \* **INTO #temp2** FROM customers WHERE \...

***[Solution:]{.underline}***

In BDL, INFORMIX temporary tables instructions are converted to generate
native Sybase ASE temporary tables.

**Warning** : SELECT INTO TEMP statements cannot be converted, because
Sybase ASE does not provide a way to create a temporary table from a
result set, such as CREATE TABLE xx AS (SELECT \... ).

------------------------------------------------------------------------

[ODIASE018 - Substrings in SQL]{#ODIASE018}

INFORMIX SQL statements can use subscripts on columns defined with the
character data type :\
    SELECT \... FROM tab1 WHERE **col1\[2,3\]** = \'RO\'\
    SELECT \... FROM tab1 WHERE **col1\[10\]**  = \'R\'   \-- Same as
col1\[10,10\]\
    UPDATE tab1 SET **col1\[2,3\]** = \'RO\' WHERE \...\
    SELECT \... FROM tab1 ORDER BY **col1\[1,3\]**

.. while Sybase ASE provides the SUBSTR( ) function, to extract a
substring from a string expression :\
    SELECT \.... FROM tab1 WHERE **SUBSTRING(col1,2,2)** = \'RO\'\
    SELECT **SUBSTRING(\'Some text\',6,3)** FROM DUAL       \-- Gives
\'tex\'

**[*Solution:*]{.underline}**

You must replace all INFORMIX col\[x,y\] expressions by
SUBSTRING(col,x,y-x+1).

**Warning:** In UPDATE instructions, setting column values through
subscripts will produce an error with Sybase ASE :\
    UPDATE tab1 SET **col1\[2,3\]** = \'RO\' WHERE \...\
is converted to :\
    UPDATE tab1 SET **SUBSTRING(col1,2,3-2+1)** = \'RO\' WHERE \...

**Warning:** Column subscripts in ORDER BY expressions are also
converted and produce an error with Sybase ASE :\
    SELECT \... FROM tab1 ORDER BY **col1\[1,3\]**\
is converted to :\
    SELECT \... FROM tab1 ORDER BY **SUBSTRING(col1,1,3-1+1)**

------------------------------------------------------------------------

[ODIASE019 - Name resolution of SQL objects]{#ODIASE019}

INFORMIX uses the following form to identify an SQL object :\
  \[database\[@dbservername\]:\]\[{owner\|\"owner\"}.\]identifier

With Sybase ASE, an object name takes the following form :\
 
\[{database\|\[database\]}.\[{owner\|\[owner\]}.\]\]{identifier\|\[identifier\]}

INFORMIX database object names are **not** **case sensitive** in
non-ANSI databases. Sybase ASE database objects names are **case
sensitive** by default.

**[*Solution:*]{.underline}**

Always create and use tables and columns names in lower case.

------------------------------------------------------------------------

[ODIASE020 - String delimiters]{#ODIASE020}

The ANSI string delimiter character is the single quote ( \'string\' ).
Double quotes are used to delimit database object names
(\"object-name\").

[Example]{.underline} : WHERE \"tabname\".\"colname\" = \'a string
value\'

As INFORMIX, Sql Server Anywhere allows to use double quotes as string
delimiters, if the QUOTED_IDENTIFIER session option is OFF (the
default):

    SET QUOTED_IDENTIFIER OFF

Remark : This problem concerns only double quotes within SQL statements.
Double quotes used in BDL string expressions are not subject of SQL
compatibility problems.

***[Solution:]{.underline}***

When the **ifxemul.dblquotes** option is set, the Sybase ASE database
interface converts all double quotes to single quotes in SQL statements.
The Sybase ASE database driver [does not]{.underline} set the
QUOTED_IDENTIFIER option implicitly.

------------------------------------------------------------------------

## [ODIASE021 - NUMERIC data types]{#ODIASE021}

Sybase ASE offers numeric data types which are quite similar to INFORMIX
numeric data types. The table below shows general conversion rules for
numeric data types:

::: {align="center"}
  ----------------------------------- -----------------------------------
  **INFORMIX**                        **Sybase ASE**

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
  DECIMAL(p) defines a [floating      The precision **p** can be from 1
  point]{.underline} decimal where    to 38.\
  **p** is the total number of        The default precision is 18 and the
  significant digits.\                default scale is 0:\
  The precision **p** can be from 1   - DECIMAL in Sybase ASE =
  to 32.\                             DECIMAL(18,0) in INFORMIX\
  DECIMAL is treated as DECIMAL(16).  - DECIMAL(p) in Sybase ASE =
                                      DECIMAL(p,0) in INFORMIX

  **MONEY\[(p\[,s\])**\               Sybase ASE provides the MONEY and
  \                                   SMALLMONEY data types, but the
  \                                   currency symbol handling is quite
                                      different. Therefore, INFORMIX
                                      MONEY columns should be implemented
                                      as **DECIMAL** columns in Sybase
                                      ASE.

  **SMALLFLOAT**  (synonyms: REAL)    **REAL**

  **FLOAT\[(n)\]** (synonyms: DOUBLE  **DOUBLE PRECISION**
  PRECISION)\                         
  The precision (n) is ignored.       
  ----------------------------------- -----------------------------------
:::

**Warning: Sybase ASE (15.5) does not support implicit character string
to numeric conversions. For example, if you compare an integer column to
\'123\' in a WHERE clause, Sybase will raise a conversion error. The
problem exists also when using CHAR or VARCHAR SQL parameters.**

***[Solution:]{.underline}***

[In BDL programs:]{.underline}

When creating tables from BDL programs, the database interface
automatically converts INFORMIX data types to corresponding Sybase ASE
data types.

**Warning: There is no Sybase ASE equivalent for the INFORMIX DECIMAL(p)
floating point decimal (i.e. without a scale). If your application is
using such data types, you must review the database schema in order to
use Sybase ASE compatible types. To workaround the Sybase ASE
limitation, the Sybase ASE database drivers convert DECIMAL(p) types to
a DECIMAL( 2\*p, p ), to store all possible numbers an INFORMIX
DECIMAL(p) can store. However, the original INFORMIX precision cannot
exceed 19, since Sybase ASE maximum DECIMAL precision is 38 (2\*19). If
the original precision is bigger as 19, a CREATE TABLE statement
executed from a Genero program will fail with an Sybase ASE error
2756.**

[Database creation scripts:]{.underline}

- SMALLINT and INTEGER columns do not have to use another data type in
  Sybase ASE.
- For DECIMALs, check the precision limit. Always use a precision and a
  scale.
- Convert MONEY columns to DECIMAL(p,s) columns. Always use a precision
  and a scale.
- Convert SMALLFLOAT columns to REAL columns.
- Since FLOAT precision is ignored in INFORMIX, convert this data type
  to FLOAT(15).

Since Sybase ASE does not support implicit character string to numeric
conversions, you must check that your programs do not use string
literals  or CHAR/VARCHAR SQL parameters in integer expressions, as in
the following example:

   DEFINE pv CHAR(1)\
   CREATE TABLE mytable ( v1 INT, v2 INT )\
   LET pv = \'1\'\
   SELECT \* FROM mytable WHERE v1 = \'1\' AND v2 = pv

------------------------------------------------------------------------

[ODIASE022 - Getting one row with SELECT]{#ODIASE022}

With INFORMIX, you must use the system table with a condition on the
table id :

   SELECT user **FROM systables WHERE tabid=1**

With Sybase ASE, you can omit the FROM clause to generate one row only:

   SELECT user

**[*Solution:*]{.underline}**

Check the BDL sources for \"FROM systables WHERE tabid=1\" and use
dynamic SQL to resolve this problem.

------------------------------------------------------------------------

[ODIASE024 - MATCHES and LIKE in SQL conditions]{#ODIASE024}

INFORMIX supports MATCHES and LIKE in SQL statements, while Sybase ASE
supports the LIKE statement only.

The MATCHES operator of INFORMIX uses the star, question mark and square
braces wildcard characters.\
The LIKE operator of Sybase ASE offers the percent, underscore and
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

[ODIASE025 - INFORMIX specific SQL statements in BDL]{#ODIASE025}

The BDL compiler supports several INFORMIX specific SQL statements that
have no meaning when using Sybase ASE.

Examples :

- CREATE DATABASE dbname IN dbspace WITH BUFFERED LOG
- START DATABASE (SE only)
- ROLLFORWARD DATABASE
- CREATE TABLE \... IN dbspace WITH LOCK MODE ROW

***[Solution:]{.underline}***

Review your BDL source and remove all static SQL statements which are
INFORMIX specific.

------------------------------------------------------------------------

[ODIASE028 - INSERT cursors]{#ODIASE028}

INFORMIX supports insert cursors. An \"insert cursor\" is a special BDL
cursor declared with an INSERT statement instead of a SELECT statement.
When this kind of cursor is open, you can use the PUT instruction to add
rows and the FLUSH instruction to insert the records into the database.

For INFORMIX database with transactions, OPEN, PUT and FLUSH
instructions must be executed within a transaction.

Sybase ASE does not support insert cursors.

**[*Solution:*]{.underline}**

Insert cursors are emulated by the Sybase ASE database interface.

------------------------------------------------------------------------

[ODIASE030 - Very large data types]{#ODIASE030}

Both INFORMIX and Sybase ASE provide special data types to store very
large texts or images.

Sybase ASE provides the text and image data types as equivalent of
Informix TEXT and BYTE types.

**Warning: Sybase ASE 15.5 does not support text/image expressions in
WHERE parts.**

**Warning: The ASE driver is implemented with the Sybase Open Client
Library C API. In Sybase version 15.5, this API has a limited support
for LOBs, especially when it comes to update LOB data in the database:
You cannot directly INSERT large LOB data, you must first INSERT nulls
and then UPDATE the row with the real data. Additionally, UPDATE can
only take one LOB parameter at a time. Fetching LOB data is supported,
with the following limitation: LOB columns must appear [at the
end]{.underline} of the SELECT list.** 

**[*Solution:*]{.underline}**

TEXT and BYTE character data types are supported by the Sybase ASE
database interface, with some limitation.

When INSERTing TEXT/BYTE in a table, you must first insert with nulls,
the update the new row, and only with one TEXT/BYTE parameter at a time:

   DEFINE ptext TEXT, pbyte BYTE\
   \...\
   LOCATE ptext IN \...\
   LOCATE pbyte IN \...\
   CREATE TABLE tab (k INT, t TEXT, b BYTE)\
   \-- First INSERT a new row with NULLs\
   INSERT INTO tab VALUES (123, **null**, **null**)\
   \-- Then UPDATE first TEXT column\
   UPDATE tab SET **t = ptext** WHERE k = 123\
   \-- Then UPDATE second BYTE column\
   UPDATE tab SET **b = pbyte** WHERE k = 123

Fetching TEXT and BYTE columns is possible as long as the columns appear
at the end of the SELECT list. For example, if you have a statement such
as (where *pdata* is a TEXT or BYTE column):

   SELECT pid, **pdata**, ptimestamp FROM pic WHERE \...

Put the BYTE column at the end of the SELECT list:

   SELECT pid, ptimestamp, **pdata** FROM pic WHERE \... 

------------------------------------------------------------------------

[ODIASE031 - Cursors WITH HOLD]{#ODIASE031}

INFORMIX automatically closes opened cursors when a transaction ends
unless the WITH HOLD option is used in the DECLARE instruction.

Sybase ASE does not close cursors when a transaction ends, as long as
the global parameter close_on_endtrans is off.

**[*Solution:*]{.underline}**

BDL cursors that are not declared \"WITH HOLD\" are automatically closed
by the database interface when a COMMIT WORK or ROLLBACK WORK is
performed by the BDL program.

------------------------------------------------------------------------

[ODIASE033 - Querying system catalog tables]{#ODIASE033}

As in INFORMIX, Sybase ASE provides system catalog tables
(sysobjects,syscolumns,etc) in each database, but the table names and
their structure are quite different.

**[*Solution:*]{.underline}**

**Warning:** No automatic conversion of INFORMIX system tables is
provided by the database interface.

------------------------------------------------------------------------

[ODIASE034 - Syntax of UPDATE statements]{#ODIASE034}

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

[ODIASE036 - INTERVAL data type]{#ODIASE036}

INFORMIX\'s INTERVAL data type stores a value that represents a span of
time. INTERVAL types are divided into two classes : **year-month
intervals** and **day-time intervals.**

Sybase ASE does not provide a data type corresponding to the INFORMIX
INTERVAL data type.

**[Solution:]{.underline}**

**Warning:** The INTERVAL data type is not well supported because the
database server has no equivalent native data type. However, you can
store into and retrieve from CHAR columns BDL INTERVAL values.

------------------------------------------------------------------------

## [ODIASE046 - The LOAD and UNLOAD instructions]{#ODIASE046}

INFORMIX provides two SQL instructions to export / import data from /
into a database table: The UNLOAD instruction copies rows from a
database table into an text file and the LOAD instruction inserts rows
from an text file into a database table.

**Warning :** Sybase ASE has LOAD and UNLOAD instructions, but those
commands are related to database backup and recovery. Do not confuse
with INFORMIX commands.

**[*Solution:*]{.underline}**

LOAD and UNLOAD instructions are supported.

**Warning :** The LOAD instruction does not work with tables using
emulated SERIAL columns because the generated INSERT statement holds the
\"SERIAL\" column which is actually a IDENTITY column in Sybase ASE. See
the limitations of INSERT statements when using [SERIALs](#ODIASE005).

**Warning :** In Sybase ASE, INFORMIX DATETIME data is stored in
BIGDATETIME columns, but DATETIME columns are similar to INFORMIX
DATETIME YEAR TO FRACTION(5) columns. Therefore, when using LOAD and
UNLOAD, those columns are converted to text data with the format
\"YYYY-MM-DD hh:mm:ss.fffff\".

------------------------------------------------------------------------

## [ODIASE047 - Case sensitivity]{#ODIASE047}

In INFORMIX, database object names like table and column names are not
case sensitive :

> CREATE TABLE Customer ( Custno INTEGER, \... )\
> SELECT CustNo FROM cuSTomer \...

In Sybase ASE, database object names **and character data** are
case-insensitive by default :

> CREATE TABLE Customer ( Custno INTEGER, CustName CHAR(20) )\
> INSERT INTO CUSTOMER VALUES ( 1, \'TECHNOSOFT\' )\
> SELECT CustNo FROM cuSTomer WHERE custname = \'techNOSoft\'

**[*Solution:*]{.underline}**

When you create a Sybase ASE database with **dbinit**, you can use the
-c option to make the database case-sensitive.

------------------------------------------------------------------------

## [ODIASE051 - Setup database statistics]{#ODIASE051}

INFORMIX provides a special instruction to compute database statistics
in order to help the optimizer find the right query execution plan :

> UPDATE STATISTICS \...

Sybase ASE offers a similar instruction, but it uses different clauses :

> UPDATE STATISTICS \...

See Sybase ASE documentation for more details.

[***Solution:***]{.underline}

Centralize the optimization instruction in a function.

------------------------------------------------------------------------

## [ODIASE053 - The ALTER TABLE instruction]{#ODIASE053}

INFORMIX and MS Sybase ASE use different implementations of the ALTER
TABLE instruction. For example, INFORMIX allows you to use multiple ADD
clauses separated by comma. This is not supported by Sybase ASE :

INFORMIX :\
     ALTER TABLE customer **ADD(col1 INTEGER), ADD(col2 CHAR(20))**

Sybase ASE :\
     ALTER TABLE customer **ADD col1 INTEGER, col2 CHAR(20)**

[***Solution:***]{.underline}

**Warning:** No automatic conversion is done by the database interface.
There is even no real standard for this instruction ( that is, no common
syntax for all database servers). Read the SQL documentation and review
the SQL scripts or the BDL programs in order to use the database server
specific syntax for ALTER TABLE.

------------------------------------------------------------------------

## [ODIASE054 - SQL Interruption]{#ODIASE054}

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

The **ASE** database driver supports SQL interruption and raises error
code -213 if the statement is interrupted.

------------------------------------------------------------------------

## [ODIASE055 - Scrollable Cursors]{#ODIASE055}

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

Sybase ASE supports native scrollable cursors.

***[Solution:]{.underline}***

The Sybase ASE database driver uses the native Sybase ASE Open Client
Library scrollable cursors.

------------------------------------------------------------------------

## [ODIASE100 - Data type conversion table]{#ODIASE100}

::: {align="center"}
**INFORMIX Data Types**
:::

**Sybase ASE Data Types**

CHAR(n)

CHAR(n) (limit = page size, ex:16384 bytes)

VARCHAR(n)

VARCHAR(n) (limit = page size, ex:16384 bytes)

NCHAR(n)

CHAR(n) (length in bytes)

NVARCHAR(n)

VARCHAR(n) (length in bytes)

BOOLEAN

BIT (must be NOT NULL!)

SMALLINT

SMALLINT

INTEGER

INTEGER

BIGINT

BIGINT

INT8

BIGINT

FLOAT\[(n)\]

DOUBLE PRECISION

SMALLFLOAT

REAL

DECIMAL(p,s)

DECIMAL(p,s)

DECIMAL(p) with p\<=19

DECIMAL(2\*p,p)

DECIMAL(p) with p\>19

*N/A*

MONEY(p,s)

DECIMAL(p,s)

MONEY(p)

DECIMAL(p,2)

MONEY

DECIMAL(16,2)

DATE

DATE (yyyy-mm-dd)

DATETIME HOUR TO FRACTION

BIGTIME (hh:mm:ss.ffffff)

DATETIME q1 TO q2 (q2\>FRACTION)

BIGDATETIME (yyyy-mm-dd hh:mm:ss.ffffff)

INTERVAL q1 TO q2

CHAR(50)
