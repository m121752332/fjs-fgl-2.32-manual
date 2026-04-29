[Back to Contents](../index.html)

------------------------------------------------------------------------

# ODI Adaptation Guide For DB2 UDB 8.x, 9x

Installation

::: {align="center"}
  -----------------------------------------------------
  [Install DB2 and create a database](#ODIDB2_PREP01)
  [Prepare the runtime environment](#ODIDB2_PREP02)
  -----------------------------------------------------
:::

Database concepts

::: {align="center"}
  ------------------------------------------------------------
  [Database concepts](#ODIDB2007a)
  [Data storage concepts](#ODIDB2039)
  [Data consistency and concurrency management](#ODIDB2008a)
  [Transactions handling](#ODIDB2009a)
  [Defining database users](#ODIDB2016a)
  [Setting privileges](#ODIDB2016b)
  ------------------------------------------------------------
:::

Data dictionary

::: {align="center"}
  ----------------------------------------------
  [BOOLEAN data type](#ODIDB2010)
  [CHARACTER data types](#ODIDB2011a)
  [NUMERIC data types](#ODIDB2021a)
  [DATE and DATETIME data types](#ODIDB2001)
  [INTERVAL data type](#ODIDB2036)
  [SERIAL data types](#ODIDB2005)
  [ROWIDs](#ODIDB2004)
  [Very large data types](#ODIDB2030)
  [Constraints](#ODIDB2012)
  [Triggers](#ODIDB2013)
  [Stored procedures](#ODIDB2014)
  [Name resolution of SQL objects](#ODIDB2019)
  [Setup database statistics](#ODIDB2051)
  [The ALTER TABLE instruction](#ODIDB2053)
  [Data type conversion table](#ODIDB2100)
  ----------------------------------------------
:::

Data manipulation

::: {align="center"}
  ------------------------------------------------------------
  [Reserved words](#ODIDB2003)
  [Outer joins](#ODIDB2006)
  [Transactions handling](#ODIDB2009a)
  [Temporary tables](#ODIDB2017)
  [Substrings in SQL](#ODIDB2018)
  [Name resolution of SQL objects](#ODIDB2019)
  [String delimiters and object name delimiters](#ODIDB2020)
  [Getting one row with SELECT](#ODIDB2022)
  [MATCHES and LIKE conditions](#ODIDB2024)
  [SQL functions and constants](#ODIDB2029)
  [Querying system catalog tables](#ODIDB2033)
  [The GROUP BY clause](#ODIDB2052)
  [The star in SELECT statements](#ODIDB2054)
  [The LENGTH() function](#ODIDB2055)
  ------------------------------------------------------------
:::

BDL programming

::: {align="center"}
  -------------------------------------------------------
  [SERIAL data type](#ODIDB2005)
  [INFORMIX specific SQL statements in BDL](#ODIDB2025)
  [INSERT cursors](#ODIDB2028)
  [Cursors WITH HOLD](#ODIDB2031)
  [SELECT FOR UPDATE](#ODIDB2008b)
  [SQL parameters limitation](#ODIDB2043)
  [The LOAD and UNLOAD instructions](#ODIDB2046)
  [SQL Interruption](#ODIDB2056)
  [Scrollable Cursors](#ODIDB2057)
  -------------------------------------------------------
:::

Connecting to DB2 OS/400

::: {align="center"}
  ---------------------------------------------------
  [DB2 Architecture on OS/400](#ODIDB2_OS400_ARCHI)
  ---------------------------------------------------
:::

::: {align="center"}
  ----------------------------------------------------
  [Log in to the AS/400 server](#ODIDB2_OS400_LOGIN)
  ----------------------------------------------------
:::

::: {align="center"}
  --------------------------------------------------------------
  [Collection (Schema) Creation](#ODIDB2_OS400_COLL)
  [Source Physical File Creation](#ODIDB2_OS400_PHYS)
  [Trigger Creation](#ODIDB2_OS400_TRIG)
  [Permission Definition](#ODIDB2_OS400_PERM)
  [Relational DB Directory Entry Creation](#ODIDB2_OS400_EDIR)
  [DB2 Client Configuration on Windows](#ODIDB2_OS400_CLNT)
  --------------------------------------------------------------
:::

::: {align="center"}
  -----------------------------------------------------------------
  [Differences Between DB2 UNIX & DB2 OS/400](#ODIDB2_OS400_DIFF)
  [Naming Conventions](#ODIDB2_OS400_NAME)
  -----------------------------------------------------------------
:::

------------------------------------------------------------------------

## [Runtime configuration]{#ODIDB2_PREP}

> ### [[Install DB2 and create a database]{.small}]{#ODIDB2_PREP01}
>
> 1.  Install the IBM DB2 Universal Server on your database server.
>
> 2.  Create a DB2 database entity: *dbname*
>
> 3.  Declare a database user dedicated to your application: the
>     **application administrator**. This user will manage the database
>     schema of the application (all tables will be owned by it).
>
> 4.  Give all requested database administrator privileges to the
>     **application administrator**.
>
> 5.  If you plan to use temporary table emulation, you must setup the
>     database for DB2 global temporary tables (create a user temporary
>     tablespace and grant privileges to all users).\
>     \
>     See issue [ODIDB2017](#ODIDB2017) for more details.
>
> 6.  Connect as the application administrator:\
>     \
>        \$ db2 \"CONNECT TO *dbname* USER *appadmin* USING *password*\"
>
> 7.  Create the **application tables**. Do not forget to convert
>     INFORMIX data types to DB2 data types. See issue
>     [ODIDB2100](#ODIDB2100) for more details.
>
> 8.  If you plan to use SERIAL column emulation, you must prepare the
>     database. See issue [ODIDB2005](#ODIDB2005) for more details.

> ### [Prepare the runtime environment]{#ODIDB2_PREP02}
>
> 1.  In order to connect to IBM DB2, you must have a database driver
>     \"**dbmdb2\***\" in FGLDIR/dbdrivers.
>
> 2.  If you want to connect to a remote DB2 server, the **IBM DB2
>     Client Application Enabler** must be installed and configured on
>     the computer running the BDL applications. You must declare the
>     data source set up as follows:\
>     \
>     1. Login as root.\
>     2. Create a user dedicated to the db2 client instance environment,
>     for example, \"db2cli1\".\
>     3. Create a client instance environment with the **db2icrt** tool
>     as in following example:\
>     [     \# *db2dir*/instance/db2icrt -a server -s client
>     *instance-user*]{.small}\
>     4. Login as the instance user (environment should be set
>     automatically, verify DB2DIR).\
>     5. Catalog the remote server node:\
>     [     \# db2 \"catalog tcpip node *db2node* remote *hostname*
>     server *tcp-service*\"]{.small}\
>     6. Catalog the remote database:\
>     [     \# db2 \"catalog database *datasource* at node *db2node*
>     authentication server\"]{.small}\
>     7. Test the connection to the remote database:\
>     [     \# db2 \"connect to *datasource* user *dbuser* using
>     *password*\"]{.small}\
>     [             ( where *dbuser* is a database user declared on the
>     remote database server ).\
>     ]{.small}\
>     See IBM DB2 documentation for more details.
>
> 3.  **IMPORTANT WARNING**: You may need to set the PATCH2=15
>     configuration parameter in the **DB2CLI.INI** file, if you have a
>     non-English environment; otherwise DECIMAL values will not be
>     properly inserted or fetched:\
>        \[*datasource*\]\
>        PATCH2=15\
>     For more details, see the DB2 README.TXT file in the SQLLIB
>     directory.
>
> 4.  Make sure that the DB2 client environment variables are properly
>     set. Check variables such as **DB2DIR** (the path to the
>     installation directory), **DB2INSTANCE** (the name of the DB2
>     instance), **INSTHOME** (the path to the home directory of the
>     instance owner). On UNIX, you will find environment settings in
>     the file \$INSTHOME/sqllib/db2proffile. See IBM DB2 documentation
>     for more details.
>
> 5.  Verify the environment variable defining the search path for
>     database client shared libraries (libdb2.so on UNIX, DB2CLI.DLL on
>     Windows). On UNIX platforms, the variable is specific to the
>     operating system. For example, on Solaris and Linux systems, it is
>     **LD_LIBRARY_PATH**, on AIX it is **LIBPATH**, or HP/UX it is
>     **SHLIB_PATH**. On Windows, you define the DLL search path in the
>     **PATH** environment variable.
>
>     +-----------------------------------+-----------------------------------+
>     | **DB2 UDB version**               | **Shared library environment      |
>     |                                   | setting**                         |
>     +-----------------------------------+-----------------------------------+
>     | **DB2 UDB 7.x and 8.x**           | *UNIX*: Add **\$DB2DIR/lib** (for |
>     |                                   | 32 bit) or **\$DB2DIR/lib64**     |
>     |                                   | (for 64 bit) to LD_LIBRARY_PATH   |
>     |                                   | (or its equivalent).\             |
>     |                                   | *Windows*: Add **%DB2DIR%\\bin**  |
>     |                                   | to PATH.                          |
>     +-----------------------------------+-----------------------------------+
>     | **DB2 UDB 9.x**                   | *UNIX*: Add **\$DB2DIR/lib32**    |
>     |                                   | (for 32 bit) or                   |
>     |                                   | **\$DB2DIR/lib64** (for 64 bit)   |
>     |                                   | to LD_LIBRARY_PATH (or its        |
>     |                                   | equivalent).\                     |
>     |                                   | *Windows*: Add **%DB2DIR%\\bin**  |
>     |                                   | to PATH.                          |
>     +-----------------------------------+-----------------------------------+
>     |                                   |                                   |
>     +-----------------------------------+-----------------------------------+
>
> 6.  To verify if the DB2 client environment is correct, you can for
>     example start the db2 command interpreter and connect to the
>     server:\
>     \
>          \$ db2\
>          db2 =\> CONNECT TO *dbname* USER *username* USING *password*
>
> 7.  Check the database locale settings (**DB2CODEPAGE**, etc). The DB
>     locale must match the locale used by the runtime system
>     (**LANG**).
>
> 8.  Setup the **fglprofile** entries for [database
>     connections](Connections.html#DS_ODI_DBVSPEC).\
>     \
>     **Warning:** **Make sure that you are using the ODI driver
>     corresponding to the database client and server version. Because
>     Informix features emulation are dependant from the database server
>     version, it is mandatory to use the same version of the database
>     client and ODI driver as the server version.**\
>
> 9.  Define the database schema selection if needed. Use the following
>     entry to define the database schema to be used by the application.
>     The database interface will automatically perform a \"SET SCHEMA
>     \<name\>\" instruction to switch to a specific schema:\
>     \
>        dbi.database.*dbname*.db2.schema = \'*name*\'\
>     \
>     Here *dbname* identifies the database name used in the BDL program
>     ( DATABASE *dbname* ) and *name* is the schema name to be used in
>     the SET SCHEMA instruction. If this entry is not defined, no \"SET
>     SCHEMA\" instruction is executed and the current schema defaults
>     to the user\'s name.

------------------------------------------------------------------------

[ODIDB2001 - DATE and DATETIME data types]{#ODIDB2001}

INFORMIX provides two data types to store date and time information:

- **DATE** = for year, month and day storage.
- **DATETIME** = for year to fraction(1-5) storage.

IBM DB2 provides only one data type to store dates :

- **DATE** = for year, month, day storage.
- **TIME** = for hour, minute, second storage.
- **TIMESTAMP** = for year, month, day, hour, minute, second, fraction
  storage.

**String representing date time information:**

INFORMIX is able to convert quoted strings to DATE / DATETIME data if
the string content matches environment parameters (i.e. DBDATE,
GL_DATETIME). As INFORMIX, IBM DB2 can convert quoted strings to dates,
times or timestamps. Only one format is possible: \'yyyy-mm-dd\' for
dates, \'hh:mm:ss\' for times and \'yyyy-mm-dd hh:mm:ss:f\' for
timestamps.

**Date time arithmetic:**

- INFORMIX supports date arithmetic on DATE and DATETIME values. The
  result of an arithmetic expression involving dates/times is a number
  of days when only DATEs are used and an INTERVAL value if a DATETIME
  is used in the expression.
- In IBM DB2, the result of an arithmetic expression involving DATE
  values is a NUMBER of days, the decimal part is the fraction of the
  day ( 0.5 = 12H00, 2.00694444 = (2 + (10/1440)) = 2 days and 10
  minutes ) ).
- INFORMIX automatically converts an integer to a date when the integer
  is used to set a value of a date column. IBM DB2 does not support this
  automatic conversion.
- Complex DATETIME expressions ( involving INTERVAL values for example)
  are INFORMIX specific and have no equivalent in IBM DB2.

**[*Solution:*]{.underline}**

DB2 has the same **DATE** data type as INFORMIX ( year, month, day ). So
you can use DB2 DATE data type for INFORMIX DATE columns.

DB2 **TIME** data type can be used to store INFORMIX DATETIME HOUR TO
SECOND values. The database interface makes the conversion
automatically.

INFORMIX DATETIME values with any precision from YEAR to FRACTION(5) can
be stored in DB2 **TIMESTAMP** columns. The database interface makes the
conversion automatically. Missing date or time parts default to
1900-01-01 00:00:00.0. For example, when using a DATETIME HOUR TO MINUTE
with the value of \"11:45\", the DB2 TIMESTAMP value will be
\"1900-01-01 11:45:00.0\".

**Warning:** Using integers as a number of days in an expression with
dates is not supported by IBM DB2. Check your code to detect where you
are using integers with DATE columns.

**Warning:** Literal DATETIME and INTERVAL expressions (i.e. DATETIME (
1999-10-12) YEAR TO DAY) are not converted.

**Warning:** It is strongly recommended that you use BDL variables in
dynamic SQL statements instead of quoted strings representing DATEs. For
example :\
   LET stmt = \"SELECT \... FROM customer WHERE creat_date \>\'\",
adate,\"\'\"\
is not portable, use a question mark place holder instead and OPEN the
cursor USING adate:\
   LET stmt = \"SELECT \... FROM customer WHERE creat_date \> ?\"

**Warning:** DATE arithmetic expressions using SQL parameters (USING
variables) are not fully supported. For example: [\"SELECT \... WHERE
datecol \< ? + 1\"]{.small} generate an error at PREPARE time.

**Warning:** SQL Statements using expressions with TODAY / CURRENT / 
EXTEND must be reviewed and adapted to the native syntax.

------------------------------------------------------------------------

[ODIDB2003 - Reserved words]{#ODIDB2003}

Even if IBM DB2 allows SQL reserved keywords as SQL object names (
\"[create table table ( column int )]{.small}\" ), you should take care
in your existing database schema and check that you do not use DB2 SQL
words. An example of a common word which is part of DB2 SQL grammar is
\'**alias**\'.

***[Solution:]{.underline}***

See IBM DB2 documentation for reserved keywords.

------------------------------------------------------------------------

[ODIDB2004 - ROWIDs]{#ODIDB2004}

When creating a table, INFORMIX automatically adds a \"ROWID\" integer
column (applies to non-fragmented tables only). The ROWID column is
auto-filled with a unique number and can be used like a primary key to
access a given row.

IBM DB2 ROWID columns were introduced in version 9.7. Unlike Informix
integer row ids, DB2 row ids are based on VARCHAR(16) FOR BIT DATA (128
bit integer) that are usually represented as a 32 char hexadecimal
representation of the value. The IBM DB2 ROWID is actually an
alternative syntax for RID_BIT(), and a qualified reference to ROWID
like *tablename*.ROWID is equivalent to RID_BIT(*tablename*).

For example : **x\'070000000000000000000065CE770000\'**

In DB2 SQL, to find a row with a rowid, you must specify the rowid value
as an hexadecimal value:

SELECT \* FROM customer WHERE ROWID =
x\'070000000000000000000065CE770000\'

or convert the ROWID to an hexadecimal representation and then you can
compare to a simple string:

SELECT \* FROM customer WHERE HEX(ROWID) =
\'070000000000000000000065CE770000\'

With INFORMIX, SQLCA.SQLERRD\[6\] contains the ROWID of the last
INSERTed or UPDATEd row. This is not supported with ORACLE because
ORACLE ROWID are not INTEGERs.

***[Solution:]{.underline}***

If the BDL application uses ROWIDs, the program logic should be reviewed
in order to use the real primary keys (usually, serials which can be
supported).

The DB2 database driver will convert the ROWID keyword to HEX(ROWID), so
it can be used as a VARCHAR(32) with the hexadecimal representation of
the BIT DATA. You need however to replace all INTEGER variable
definitions by VARCHAR(32) or CHAR(32).

To emulate Informix integer ROWIDs, you can also use the DB2
GENERATE_UNIQUE built-in function, or the IDENTITY attribute of the
INTEGER or BIGINT data types.

All references to SQLCA.SQLERRD\[6\] must be removed because this
variable will not hold the ROWID of the last INSERTed or UPDATEd row
when using the IBM DB2 interface.

------------------------------------------------------------------------

## [ODIDB2005 - SERIAL data types]{#ODIDB2005}

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
are using a zero value:\
    CREATE TABLE tab ( k SERIAL ); \--\> internal counter = 0\
    INSERT INTO tab VALUES ( 0 );  \--\> internal counter = 1\
    INSERT INTO tab VALUES ( 10 ); \--\> internal counter = 10\
    INSERT INTO tab VALUES ( 0 );  \--\> internal counter = 11\
    DELETE FROM tab;               \--\> internal counter = 11\
    INSERT INTO tab VALUES ( 0 );  \--\> internal counter = 12

IBM DB2 has no equivalent for INFORMIX SERIAL columns.

DB2 version 7.1 supports IDENTITY columns:\
    CREATE TABLE tab ( k INTEGER GENERATED ALWAYS AS IDENTITY);\
To get the last generated IDENTITY value after an INSERT, DB2 provides
the following function:\
    IDENTITY_VAL_LOCAL( )

DB2 version 8.1 supports SEQUENCES:\
    CREATE SEQUENCE sq1 START WITH 100;\
To create a new sequence number, you must use the \"NEXTVAL FOR\"
operator:\
    INSERT INTO table VALUES ( NEXTVAL FOR sq1, \... )\
To get the last generated sequence number, you must use the \"PREVVAL
FOR\" operator:\
    SELECT PREVVAL FOR sq1 \...

**[*Solution:*]{.underline}**

You are free to use **IDENTITY columns** (1) or **insert triggers using
SEQUENCES** (2). The first solution is faster, but does not allow
explicit serial value specification in insert statements; the second
solution is slower but allows explicit serial value specification. You
can start to use the second solution to make unmodified 4gl programs
work on DB2, but you should update your code to use native IDENTITY
columns for performance.

**Warning:** The second method (trigseq) works only with DB2 version 8
and higher.

The serial emulation type is defined by the following FGLPROFILE entry:

   dbi.database.\<dbname\>.ifxemul.datatype.serial.emulation =
{\"native\"\|\"trigseq\"}

The \'**native**\' value defines the IDENTITY column technique and the
\'**trigseq**\' defines the trigger technique.

This entry must be used with:

   dbi.database.\<dbname\>.ifxemul.datatype.serial = {true\|false}

If the datatype.serial entry is set to false, the emulation method
specification entry is ignored.

**Warning:** When no entry is specified, the default is SERIAL emulation
enabled with \'**native**\' method (IDENTITY-based).

[1. Using IDENTITY columns]{.underline}

In database creation scripts, all SERIAL\[(n)\] data types must be
converted by hand to INTEGER GENERATED ALWAYS AS IDENTITY\[( START WITH
n, INCREMENT BY 1)\].

Tables created from the BDL programs can use the SERIAL data type : When
a BDL program executes a CREATE \[TEMP\] TABLE with a SERIAL column, the
database interface automatically converts the \"SERIAL\[(n)\]\" data
type to an IDENTITY specification.

In BDL, the new generated SERIAL value is available from the
SQLCA.SQLERRD\[2\] variable. This is supported by the database interface
which performs a call to the IDENTITY_VAL_LOCAL() function. However,
SQLCA.SQLERRD\[2\] is defined as an INTEGER, it cannot hold values from
BIGINT identity columns. If you are using BIGINT IDENTITY columns, you
must use the IDENTITY_VAL_LOCAL() function.

**Warning:** Since IBM DB2 does not allow you to specify the value of
IDENTITY columns, it is mandatory to convert all INSERT statements to
remove the SERIAL column from the list.\
For example, the following statement:\
   INSERT INTO tab (col1,col2) VALUES (**0**, p_value)\
must be converted to :\
   INSERT INTO tab (col2) VALUES (p_value)\
Static SQL INSERT using records defined from the schema file must also
be reviewed :\
   DEFINE rec LIKE tab.\*\
   INSERT INTO tab VALUES ( rec.\* )   \-- will use the serial column\
must be converted to :\
   INSERT INTO tab VALUES rec.\* \-- without braces, serial column is
removed

[2. Using triggers with the SEQUENCE]{.underline}

In database creation scripts, all SERIAL\[(n)\] data types must be
converted to INTEGER data types and you must create a sequence and a
trigger for each table using a SERIAL. To know how to write those
triggers,  you can create a small Genero program that creates a table
with a SERIAL column. Set the FGLSQLDEBUG environment variable and run
the program. The debug output will show you the native SQL commands to
create the sequence and the trigger.

Tables created from the BDL programs can use the SERIAL data type : When
a BDL program executes a CREATE \[TEMP\] TABLE with a SERIAL column, the
database interface automatically converts the \"SERIAL\[(n)\]\" data
type to \"INTEGER\" and creates the sequence and the insert trigger.

**Warning:** IBM DB2 performs NOT NULL data controls before the
execution of triggers. If the serial column must be NOT NULL (for
example, because it is part of the primary key), you cannot specify a
NULL value for that column in INSERT statements.\
For example, the following statement :\
   INSERT INTO tab VALUES (NULL,p_value)\
must be converted to :\
   INSERT INTO tab (col2) VALUES (p_value)

**Warning:** IBM DB2 triggers are not automatically dropped when the
corresponding table is dropped. They become ***inoperative*** instead.
Database administrators must take care of this behavior when managing
schemas.

**Warning:** With IBM DB2, INSERT statements using NULL for the SERIAL
column will produce a new serial value:\
   INSERT INTO tab ( col_serial, col_data ) VALUES ( NULL, \'data\' )\
This behavior is mandatory in order to support INSERT statements which
do not use the serial column :\
   INSERT INTO tab (col_data) VALUES (\'data\')\
Check if your application uses tables with a SERIAL column that can
contain a NULL value.

**Warning:** With DB2, trigger creation is not allowed on temporary
tables. Therefore, the \"**trigseq**\" method cannot work with temporary
tables using serials.

------------------------------------------------------------------------

[ODIDB2006 - Outer joins]{#ODIDB2006}

The original OUTER join syntax of INFORMIX is different from the IBM DB2
outer join syntax:

In INFORMIX SQL, outer tables are defined in the FROM clause with the
**OUTER** keyword:

> SELECT ... FROM cust, OUTER(order)
>      WHERE cust.key = order.custno
>
>     SELECT ... FROM cust, OUTER(order,OUTER(item))
>      WHERE cust.key = order.custno
>        AND order.key = item.ordno
>        AND order.accepted = 1

IBM DB2 supports the ANSI outer join syntax:

> SELECT ... FROM cust LEFT OUTER JOIN order
>                          ON cust.key = order.custno
>
>     SELECT ...
>       FROM cust LEFT OUTER JOIN order
>                      LEFT OUTER JOIN item
>                      ON order.key = item.ordno
>                 ON cust.key = order.custno
>      WHERE order.accepted = 1

See the IBM DB2 SQL reference for a complete description of the syntax.

***[Solution:]{.underline}***

For better SQL portability, you should use the ANSI outer join syntax
instead of the old Informix OUTER syntax.

The IBM DB2 interface can convert most INFORMIX OUTER specifications to
IBM DB2 outer joins.

Prerequisites :

1.  In the FROM clause, the main table must be the first item and the
    outer tables must figure from left to right in the order of outer
    levels.\
       Example which does not work : \"FROM OUTER(tab2), tab1\".
2.  The outer join in the WHERE clause must use the table name as
    prefix.\
       Example : \"WHERE tab1.col1 = tab2.col2\".

Restrictions :

1.  Additional conditions on outer table columns cannot be detected and
    therefore are not supported :\
      Example : \"\... FROM tab1, OUTER(tab2) WHERE tab1.col1 =
    tab2.col2 AND tab2.colx \> 10\".
2.  Statements composed by 2 or more SELECT instructions using OUTERs
    are not supported.\
      Example : \"SELECT \... UNION SELECT\" or \"SELECT \... WHERE col
    IN (SELECT\...)\"

Remarks :

1.  Table aliases are detected in OUTER expressions.\
       OUTER example with table alias : \"OUTER( tab1 alias1)\".
2.  In the outer join, \<outer table\>.\<col\> can be placed on both
    right or left sides of the equal sign.\
       OUTER join example with table on the left : \"WHERE outertab.col1
    = maintab.col2 \".
3.  Table names detection is not case-sensitive.\
       Example : \"SELECT \... FROM tab1, TAB2 WHERE tab1.col1 =
    tab2.col2\".
4.  [Temporary tables](#ODIDB2017) are supported in OUTER
    specifications.

------------------------------------------------------------------------

[ODIDB2007a - Database concepts]{#ODIDB2007a}

As INFORMIX, an IBM DB2 database server can handle more than one
database entity. INFORMIX servers have an ID (INFORMIXSERVER) and
databases are identified by name. IBM DB2 instances are identified by
the DB2INSTANCE environment variable and databases have to be cataloged
as data sources (see IBM DB2 documentation for more details).

------------------------------------------------------------------------

[ODIDB2008a - Data consistency and concurrency management]{#ODIDB2008a}

**Data consistency** involves readers that want to access data currently
modified by writers and **concurrency data access** involves several
writers accessing the same data for modification. **Locking
granularity** defines the amount of data concerned when a lock is set
(row, page, table, \...).

[INFORMIX]{.underline}

INFORMIX uses a locking mechanism to manage data consistency and
concurrency. When a process modifies data with UPDATE, INSERT or DELETE,
an [exclusive lock]{.underline} is set on the affected rows. The lock is
held until the end of the transaction. Statements performed outside a
transaction are treated as a transaction containing a single operation
and therefore release the locks immediately after execution. SELECT
statements can set [shared locks]{.underline} according the [isolation
level]{.underline}. In case of locking conflicts (for example, when two
processes want to acquire an exclusive lock on the same row for
modification or when a writer is trying to modify data protected by a
shared lock), the behavior of a process can be changed by setting the
[lock wait mode]{.underline}.

Control :

- Isolation level : SET ISOLATION TO \...
- Lock wait mode : SET LOCK MODE TO \...
- Locking granularity : CREATE TABLE \... LOCK MODE {PAGE\|ROW}
- Explicit locking : SELECT \... FOR UPDATE

Defaults :

- The default isolation level is **read committed**.
- The default lock wait mode is \"not wait\".
- The default locking granularity is on per page.

[IBM DB2]{.underline}

As in INFORMIX, IBM DB2 uses locks to manage data consistency and
concurrency. The database manager sets [exclusive locks]{.underline} on
the modified rows and [shared locks]{.underline} when data is read,
according to the [isolation level]{.underline}. The locks are held until
the end of the transaction. When multiple processes want to access the
same data, the latest processes must wait until the first finishes its
transaction.  The [lock granularity]{.underline} is at the row or table
level. For more details, see DB2\'s Administration Guide, \"Application
Consideration\".

Control :

- Lock wait mode : Always WAIT. Only the [Lock Timeout]{.underline} can
  be changed, but this is a global database parameter.
- Isolation level : Can be set through an API function call or with a
  database client configuration parameter.
- Locking granularity : Row level or Table level.
- Explicit locking : SELECT \... FOR UPDATE

Defaults :

- The default isolation level is Cursor Stability ( readers cannot see
  uncommitted data, no shared lock is set when reading data ).

**[*Solution:*]{.underline}**

The SET ISOLATION TO \... INFORMIX syntax is replaced by an ODBC API
call setting the SQL_ATTR_TXN_ISOLATION connection attribute. The next
table shows the isolation level mappings done by the database driver:

::: {align="center"}
  ----------------------------------- -----------------------------------
  **SET ISOLATION instruction in      **ODBC SQL_ATTR_TXN_ISOLATION
  program**                           connection attribute**

  SET ISOLATION TO DIRTY READ         SQL_TXN_READ_UNCOMMITTED

  SET ISOLATION TO COMMITTED READ\    SQL_TXN_READ_COMMITTED
    \[READ COMMITTED\] \[RETAIN       
  UPDATE LOCKS\]                      

  SET ISOLATION TO CURSOR STABILITY   SQL_TXN_REPEATABLE_READ

  SET ISOLATION TO REPEATABLE READ    SQL_TXN_SERIALIZABLE
  ----------------------------------- -----------------------------------
:::

For portability, it is recommended that you work with INFORMIX in the
read committed isolation level, to make processes wait for each other
(lock mode wait) and to create tables with the \"lock mode row\" option.

See INFORMIX and IBM DB2 documentation for more details about data
consistency, concurrency and locking mechanisms.

------------------------------------------------------------------------

[ODIDB2008b - SELECT FOR UPDATE]{#ODIDB2008b}

A lot of BDL programs use pessimistic locking in order to prevent
several users editing the same rows at the same time.

   DECLARE cc CURSOR FOR\
         SELECT \... FROM tab WHERE \... FOR UPDATE\
   OPEN cc\
   FETCH cc \<\-- lock is acquired\
   \...\
   CLOSE cc \<\-- lock is released

In both INFORMIX and DB2, locks are released when closing the cursor or
when the transaction ends.

DB2\'s locking granularity is at the row level.

To control the behavior of the program when locking rows, INFORMIX
provides a specific instruction to set the wait mode :

   SET LOCK MODE TO { WAIT \| NOT WAIT \| WAIT *seconds* }

The default mode is NOT WAIT. This as an INFORMIX specific SQL
statement.

**Warning:** DB2 has no equivalent for \"SET LOCK MODE TO NOT WAIT\".
The \"**Lock timeout**\" can be changed but this is a database parameter
( global to all processes )!

**[*Solution:*]{.underline}**

**Warning :** The database interface is based on an emulation of an
INFORMIX engine using transaction logging. Therefore, opening a SELECT
\... FOR UPDATE cursor declared outside a transaction will raise an SQL
error -255 (not in transaction).

You must review the program logic if you use pessimistic locking because
it is based on the NOT WAIT mode which is not supported by IBM DB2.

------------------------------------------------------------------------

[ODIDB2009a - Transactions handling]{#ODIDB2009a}

INFORMIX and IBM DB2 handle transactions differently. The differences in
the transactional models can affect the program logic.

INFORMIX native mode (non ANSI) :

- DDL statements can be executed (and canceled) in transactions.
- Transactions must be started with BEGIN WORK. Statements executed
  outside of a transaction are automatically committed.

IBM DB2 :

- DDL statements can be executed (and canceled) in transactions.
- Beginning of transactions are implicit; two transactions are delimited
  by COMMIT or ROLLBACK.

Transactions in stored procedures: avoid using transactions in stored
procedures to allow the client applications to handle transactions, in
accordance with the transaction model.

INFORMIX version 11.50 introduces savepoints with the following
instructions:

        SAVEPOINT name [UNIQUE]
        ROLLBACK [WORK] TO SAVEPOINT [name] ]
        RELEASE SAVEPOINT name

IBM DB2 supports savepoints too. However, there are differences:

1.  Savepoints must be declared with the ON ROLLBACK RETAIN CURSORS
    clause
2.  Rollback must always specify the savepoint name

**[*Solution:*]{.underline}**

The INFORMIX behavior is simulated with an auto-commit mode in the IBM
DB2 interface. A switch to the explicit commit mode is done when a BEGIN
WORK is performed by the BDL program.

Regarding the transaction control instructions, the BDL applications do
not have to be modified in order to work with IBM DB2.

**Warning:** If you want to use savepoints, always specify the savepoint
name in ROLLBACK TO SAVEPOINT.

See also [ODIDB2008b](#ODIDB2008b)

------------------------------------------------------------------------

## [ODIDB2010 - BOOLEAN data type]{#ODIDB2010}

INFORMIX supports the BOOLEAN data type, which can store \'t\' or \'f\'
values. Genero BDL implements the BOOLEAN data type in a different way:
As in other programming languages, Genero BOOLEAN stores integer values
1 or 0 (for TRUE or FALSE). The type was designed this way to assign the
result of a Boolean expression to a BOOLEAN variable.

IBM DB2 9.x does not implement a BOOLEAN SQL type.

**[*Solution:*]{.underline}**

The DB2 database interface converts BOOLEAN type to CHAR(1) columns and
stores \'1\' or \'0\' values in the column.

------------------------------------------------------------------------

[ODIDB2011a - CHARACTER data types]{#ODIDB2011a}

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

IBM DB2 implements the following character data types:

- CHAR(N) with N\<= 254 bytes
- VARCHAR(N) with N \<= 32672 bytes

Like INFORMIX, IBM DB2 uses Byte Length Semantics to define the length
of CHAR/VARCHAR columns.

The character set used by DB2 to store CHAR and VARCHAR data is defined
in the database locale section when creating a new database with the DB2
Control Center.

DB2 can automatically convert from/to the client and server characters
sets. In the client applications, you define the character set with the
DB2CODEPAGE profile variable.

**[*Solution:*]{.underline}**

INFORMIX \[VAR\]CHAR(N) types can be mapped to DB2 \[VAR\]CHAR(N) types,
as long as the DB2 size limit is not reached.

**Warning:** Check that your database schema does not use CHAR or
VARCHAR types with a length exceeding the DB2 limits. Especially, the
CHAR type has a very long size limit compared to INFORMIX CHAR.

See also the section about [Localization](Localization.html).

------------------------------------------------------------------------

[ODIDB2012 - Constraints]{#ODIDB2012}

[Constraint naming syntax:]{.underline}

Both INFORMIX and BD2 support primary key, unique, foreign key, default
and check constraints. But the constraint naming syntax is different :
DB2 expects the \"CONSTRAINT\" keyword **before** the constraint
specification, and INFORMIX expects it **after**.

UNIQUE constraint example:

::: {}
  ----------------------------------- -----------------------------------
  **INFORMIX**                        **IBM DB2**

  CREATE TABLE scott.emp (\           CREATE TABLE scott.emp (\
  \...\                               \...\
  empcode CHAR(10) UNIQUE\            empcode CHAR(10)\
     **\[CONSTRAINT pk_emp\]**,\         **\[CONSTRAINT pk_emp\]**
  \...                                UNIQUE,\
                                      \...
  ----------------------------------- -----------------------------------
:::

**Primary keys**:

Like INFORMIX, DB2 creates an index to enforce PRIMARY KEY constraints
(some RDBMS do not create indexes for constraints).  Using \"CREATE
UNIQUE INDEX\"  to define unique constraints is obsolete (use primary
keys or a secondary key instead).

**Warning:** DB2 primary key constraints do not allow NULLs; make sure
your tables do not contain NULLs in the primary key columns.

**Unique constraints:**

Like INFORMIX, DB2 creates an index to enforce UNIQUE constraints (some
RDBMS do not create indexes for constraints).

**Warning:** DB2 unique constraints do not allow NULLs; make sure your
tables do not contain NULLs in the unique columns.

**Foreign keys:**

Both INFORMIX and DB2 support the ON DELETE CASCADE option.

**Check constraints:**

**Warning** : The check condition may be any valid expression that can
be evaluated to TRUE or FALSE, including functions and literals. You
must verify that the expression is not INFORMIX specific.

**Null constraints:**

INFORMIX and DB2 support not null constraints, but INFORMIX does not
allow you to give a name to \"NOT NULL\" constraints.

**[*Solution:*]{.underline}**

[Constraint naming syntax:]{.underline}

The database interface does not convert constraint naming expressions
when creating tables from BDL programs. Review the database creation
scripts to adapt the constraint naming clauses for DB2.

------------------------------------------------------------------------

[ODIDB2013 - Triggers]{#ODIDB2013}

INFORMIX and IBM DB2 provide triggers with similar features, but the
trigger creation syntax and the programming languages are totally
different.

INFORMIX triggers define which stored procedures must be called when a
database event occurs (before \| after  insert \| update \| delete
\...), while IBM DB2 triggers can hold a procedural block.

IBM DB2 provides specific syntax to define triggers. See documentation
for more details.

**[*Solution:*]{.underline}**

INFORMIX triggers must be converted to IBM DB2 triggers \"by hand\".

------------------------------------------------------------------------

[ODIDB2014 - Stored procedures]{#ODIDB2014}

Both INFORMIX and IBM DB2 support stored procedures and user functions,
but the programming languages are totally different.

INFORMIX implements the **SPL** language, while DB2 allows you to write
stored procedures or user defined functions in the **DB2 SQL** or with
an external language, such as **JAVA**, **C** or **C++**.

**[*Solution:*]{.underline}**

INFORMIX stored procedures must be converted to IBM DB2 \"by hand\".

------------------------------------------------------------------------

[ODIDB2016a - Defining database users]{#ODIDB2016a}

INFORMIX users are defined at the operating system level, they must be
members of the \'INFORMIX\' group, and the database administrator must
grant CONNECT, RESOURCE or DBA privileges to those users.

IBM DB2 users are operating system users with a specific DB2
environment. The database administrator must grant the CONNECT authority
to these users.

Database *authorities* involve actions on a database as a whole. When a
database is created, some authorities are automatically granted to
anyone who accesses the database. For example, CONNECT, CREATETAB,
BINDADD and IMPLICIT_SCHEMA authorities are granted to all users.
Database *privileges* involve actions on specific objects within the
database. When a database is created, some privileges are automatically
granted to anyone who accesses the database. For example, SELECT
privilege is granted on catalog views and EXECUTE and BIND privilege on
each successfully bound utility is granted to all users.

Together, privileges and authorities act to control access to an
instance and its database objects. Users can access only those objects
for which they have the appropriate authorization, that is, the required
privilege or authority.

**Warning:** As in INFORMIX, DB2 user names that connect to the database
server must be a maximum of **eight** characters long.

**[*Solution:*]{.underline}**

Setup the IBM DB2 environment for each user as described in the
documentation.

------------------------------------------------------------------------

[ODIDB2016b - Setting privileges]{#ODIDB2016b}

INFORMIX and IBM DB2 user privileges management is quite similar.

IBM DB2 provides user groups to define.

INFORMIX users must have at least the CONNECT privilege to access the
database:\
    GRANT **CONNECT** TO (PUBLIC\|user)

IBM DB2 users must have at least the CONNECT authority to access the
database.\
font face=\"Courier New\"\>    GRANT **CONNECT** ON DATABASE TO
(PUBLIC\|user\|group)

***[Solution:]{.underline}***

Make sure DB2 users have the right privileges to access the database.

See also [Temporary Tables](#ODIDB2017)

------------------------------------------------------------------------

[ODIDB2017 - Temporary tables]{#ODIDB2017}

INFORMIX temporary tables are created through the **CREATE TEMP TABLE**
DDL instruction or through a **SELECT \... INTO TEMP** statement.
Temporary tables are automatically dropped when the SQL session ends,
but they can also be dropped with the DROP TABLE command. There is no
name conflict when several users create temporary tables with the same
name.

Remark : BDL reports create a temporary table when the rows are not
sorted externally (by the source SQL statement).

INFORMIX allows you to create indexes on temporary tables. No name
conflict occurs when several users create an index on a temporary table
by using the same index identifier.

IBM DB2 7 supports the DECLARE GLOBAL TEMPORARY TABLE instruction.
Native DB2 temporary tables are quite similar to INFORMIX temporary
tables with some exceptions:

- A \'user temporary table space\' must exist for the database.
- Users must have \'USE\' privilege on a \'user temporary table space\'.
- For usage, the temporary table name must be prefixed by \'SESSION\'.
- No constraints or indexes can be created on temporary tables.

For more details, see the DB2 documentation.

***[Solution:]{.underline}***

In accordance with some prerequisites, temporary tables creation in BDL
programs can be supported by the database interface.

**How does it work ?**

- INFORMIX specific statements involving temporary table creation are
  automatically converted to IBM DB2 \"DECLARE GLOBAL TEMPORARY TABLE\"
  statements.
- Once the temporary table has been created, all other SQL statements
  performed in the current SQL session are parsed to add the SESSION
  prefix to the table name automatically.

**Prerequisites:**

- DB2 prerequisites to create global temporary tables. See DB2
  documentation for more details.

**Limitations:**

- Tokens matching the original table names are converted to unique names
  in all SQL statements. Make sure you are not using a temp table name
  for other database objects, like columns. The following example
  illustrates this limitation :\
    CREATE TEMP TABLE **tmp1** ( col1 INTEGER, col2 CHAR(20) )\
    SELECT **tmp1** FROM table_x WHERE \...

<!-- -->

- **Warning:** Only the \'native\' serial emulation mode is supported
  with temporary tables. See the issue about [SERIALs](#ODIDB2005) for
  more details.

------------------------------------------------------------------------

[ODIDB2018 - Substrings in SQL]{#ODIDB2018}

INFORMIX SQL statements can use subscripts on columns defined with the
character data type:\
    SELECT \... FROM tab1 WHERE **col1\[2,3\]** = \'RO\'\
    SELECT \... FROM tab1 WHERE **col1\[10\]**  = \'R\'   \-- Same as
col1\[10,10\]\
    UPDATE tab1 SET **col1\[2,3\]** = \'RO\' WHERE \...\
    SELECT \... FROM tab1 ORDER BY **col1\[1,3\]**

.. while IBM DB2 provides the SUBSTR( ) function, to extract a substring
from a string expression:\
    SELECT \.... FROM tab1 WHERE **SUBSTR(col1,2,2)** = \'RO\'\
    SELECT **SUBSTR(\'Some text\',6,3)** FROM DUAL       \-- Gives
\'tex\'

**[*Solution:*]{.underline}**

You must replace all INFORMIX col\[x,y\] expressions by
SUBSTR(col,x,y-x+1).

**Warning** : In UPDATE instructions, setting column values through
subscripts will produce an error with IBM DB2:\
    UPDATE tab1 SET **col1\[2,3\]** = \'RO\' WHERE \...\
is converted to :\
    UPDATE tab1 SET **SUBSTR(col1,2,3-2+1)** = \'RO\' WHERE \...

**Warning:** Column subscripts in ORDER BY expressions produce an error
with IBM DB2:\
    SELECT \... FROM tab1 ORDER BY **col1\[1,3\]**\
is converted to :\
    SELECT \... FROM tab1 ORDER BY **SUBSTR(col1,1,3-1+1)**

------------------------------------------------------------------------

[ODIDB2019 - Name resolution of database objects]{#ODIDB2019}

**Case sensitivity in object names:**

INFORMIX database object names are not **case-sensitive** in non-ANSI
databases.

   CREATE TABLE Tab1 ( Key INT, Col1 CHAR(20) )\
   SELECT COL1 FROM TAB1

IBM DB2 database object names are case-sensitive. When a name is used
without double quotes, it is automatically converted to uppercase
letters. When using double quotes, the names are not converted:

   CREATE TABLE tab1 ( Key INT, Col1 CHAR(20) )\
[       =\> Table name is \"TAB1\", column names are \"KEY\" and
\"COL1\"]{.small}\
[\
]{.small}   CREATE TABLE \"Tab1\" ( \"Key\" INT, \"Col1\" CHAR(20) )\
[       =\> Table name is \"Tab1\", column names are \"Key\" and
\"Col1\"]{.small}

**The DB2 schema concept:**

With non-ANSI INFORMIX databases, you do not have to give a schema name
before the tables when executing an SQL statement.

    SELECT \... FROM \<table\> WHERE \...

In an IBM DB2 database, tables always belong to a database **schema**.
When executing a SQL statement, a schema name must be used as the
high-order part of a two-part object name, unless the current schema
corresponds to the table\'s schema.

The default (implicit) schema is the current user\'s name but it can be
changed with the \"**SET SCHEMA**\" instruction.

Example: The table \"TAB1\" belongs to the schema \"SCH1\". User
\"MARK\" (implicit schema is \"MARK\") wants to access \"TAB1\" in a
SELECT statement :

   SELECT \... FROM TAB1 WHERE \...\
[       =\> Error \"MARK\".\"TAB1\" is an undefined name.
SQLSTATE=42704\
]{.small}   SELECT \... FROM SCH1.TAB1 WHERE \...\
[       =\> OK.]{.small}\
   SET SCHEMA SCH1\
[       =\> Changes the current schema to SCH1.]{.small}\
   SELECT \... FROM TAB1 WHERE \...\
[       =\> OK.]{.small}

DB2 provides \"**aliases**\", but they cannot be used to make a database
object name public because aliases belong to schemas also.

***[Solution:]{.underline}***

**Case sensitivity in object names:**

Avoid the usage of double quotes around the database object names. All
names will be converted to uppercase letters.

**The DB2 schema concept:**

After a connection, the database interface can automatically execute a
\"SET SCHEMA \<**name**\>\" instruction if the following FGLPROFILE
entry is defined:

   dbi.database.\<**dbname**\>.db2.schema = \"\<**name**\>\"

Here \<**dbname**\> identifies the database name used in the BDL program
( DATABASE **dbname** ) and \<**name**\> is the schema name to be used
in the SET SCHEMA instruction. If this entry is not defined, no \"SET
SCHEMA\" instruction is executed and the current schema defaults to the
user\'s name.

Examples:\
   dbi.database.**stores**.db2.schema = \"**STORES1**\"\
   dbi.database.**accnts**.db2.schema = \"**ACCSCH**\"

**Warning:** DB2 does not check the schema name when the SET SCHEMA
instruction is executed. Setting a wrong schema name results in
\"undefined name\" errors when performing subsequent SQL instructions
like SELECT, UPDATE, INSERT.

In accordance with this automatic schema selection, you must create a
DB2 schema for your application :

1.  Connect as a user with the DBADM authority.
2.  Create an administrator user dedicated to your application. For
    example, \"STORESADM\". Make sure this user has the IMPLICIT_SCHEMA
    privilege (this is the default in DB2).
3.  Connect as the application administrator \"STORESADM\" to create all
    database objects ( tables, indexes, \...). In our example, a
    \"STORESADM\" schema will be created implicitly and all database
    objects will belong to this schema.

As a second option you can create a specific schema with the following
SQL command :\
  CREATE SCHEMA \"\<**name**\> \" AUTHORIZATION \"\<**appadmin**\> \"\
See IBM DB2 manuals for more details about schemas.

**Warning:** **Case sensitivity:** When executing the \"SET SCHEMA\"
instruction, the database interface does not use double quotes around
the schema name ( = name is converted to uppercase letters). Make sure
that the schema name is created with uppercase letters in the database.

------------------------------------------------------------------------

[ODIDB2020 - String delimiters]{#ODIDB2020}

The ANSI string delimiter character is the single quote ( \'string\').
Double quotes are used to delimit database object names
(\"object-name\").

**Example**: WHERE \"tabname\".\"colname\" = \'a string value\'

INFORMIX allows double quotes as string delimiters, but IBM DB2
doesn\'t. This is important since many BDL programs use that character
to delimit the strings in SQL commands.

Remark : This problem concerns only double quotes within SQL statements.
Double quotes used in pure BDL string expressions are not subject of SQL
compatibility problems.

***[Solution:]{.underline}***

The IBM DB2 database interface can automatically replace all double
quotes by single quotes.

Escaped string delimiters can be used inside strings like the following
:

     \'This is a single quote : \'\'\'\
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
by IBM DB2.

Although double quotes are automatically replaced in SQL statements, you
should use only single quotes to enforce portability.

------------------------------------------------------------------------

[ODIDB2021a - NUMERIC data types]{#ODIDB2021a}

INFORMIX provides several data types to store numbers :

::: {align="center"}
  ---------------------------- --------------------------------------------
  **INFORMIX** **Data Type**   **Description**
  SMALLINT                     16 bit signed integer
  INT/INTEGER                  32 bit signed integer
  BIGINT                       64 bit signed integer
  INT8                         64 bit signed integer (replaced by BIGINT)
  DEC/DECIMAL(p)               Floating-point decimal number
  DEC/DECIMAL(p,s)             Fixed-point decimal number
  MONEY                        Equivalent to DECIMAL(16,2)
  MONEY(p)                     Equivalent to DECIMAL(p,2)
  MONEY(p,s)                   Equivalent to DECIMAL(p,s)
  REAL/SMALLFLOAT              approx floating point (C float)
  DOUBLE PREC./FLOAT           approx floating point (C double)
  ---------------------------- --------------------------------------------
:::

Most data types supported by IBM DB2 UDB are compatible to Informix data
types. DB2 V 9.1 introduces the DECFLOAT(16) and DECFLOAT(34) floating
point decimal types to store large decimals. The next table lists the
Informix types and DB2 equivalents.

::: {align="center"}
  ----------------------------------- -----------------------------------
  **INFORMIX** **Data Type**          **IBM DB2 equivalent**

  INT8                                Use BIGINT instead

  DECIMAL(p)                          With DB2 **V9.1**, DECIMAL(p\<=16)
                                      can be stored in DECFLOAT(16) and
                                      DECIMAL(p\>16) can be stored in
                                      DECFLOAT(34).\
                                      With older versions of DB2, we can
                                      use DECIMAL(p\*2,p), but with a
                                      limitation of 15 for the original
                                      Informix DECIMAL precision.

  DECIMAL(32,s)                       DB2 decimals maximum precision is
                                      31 digits!

  MONEY                               DECIMAL(16,2)

  MONEY(p)                            DECIMAL(p,2)

  MONEY(p,s)                          DECIMAL(p,s)

  SMALLFLOAT                          REAL

  FLOAT\[(n)\]                        FLOAT\[(n)\]  (DOUBLE)
  ----------------------------------- -----------------------------------
:::

**[*Solution:*]{.underline}**

SQL scripts to create databases must be converted manually. Tables
created from BDL programs do not have to be converted; the database
interface detects the MONEY data type and uses the DECIMAL type for DB2.

**Warning:** The maximum precision for DB2 decimals is 31 digits, while
INFORMIX supports 32 digits.

**Warning: When using DB2 V8 and prior: There is no DB2 equivalent for
the INFORMIX DECIMAL(p) floating point decimal (i.e. without a scale).
If your application is using such data types, you must review the
database schema in order to use DB2 compatible types. To workaround the
DB2 limitation, the DB2 database drivers convert DECIMAL(p) types to a
DECIMAL( 2\*p, p ), to store all possible numbers an INFORMIX DECIMAL(p)
can store. However, the original INFORMIX precision cannot exceed 15
((2\*15) = 30), since DB2 maximum DECIMAL precision is 31. If the
original precision is bigger as 15, a CREATE TABLE statement executed
from a Genero program will fail with a DB2 SQLSTATE 42611.**

When using DB2 **V9.1** and higher: The DECIMAL(p) data type is
converted to DECFLOAT(16) (for p\<=16) or DECFLOAT(34) (for p\>16) to
store floating point decimals. Note that if you create tables with
DECFLOAT columns, you will lose the original DECIMAL precision when
extracting the schema with fgldbsch, because IBM DB2 supports only two
precision specifications (16 or 34). Note also the DECFLOAT(34) will be
extracted as DECIMAL(32), since the Genero DECIMAL type has a maximum
precision of 32 digits.

------------------------------------------------------------------------

[ODIDB2022 - Getting one row with SELECT]{#ODIDB2022}

With INFORMIX, you must use the system table with a condition on the
table id :

   SELECT user FROM systables **WHERE tabid=1**

With IBM DB2, you have to do the following :

   SELECT user FROM SYSIBM.SYSTABLES **WHERE NAME=\'SYSTABLE\'**

**[*Solution:*]{.underline}**

Check the BDL sources for \"FROM systables WHERE tabid=1\" and use
dynamic SQL to resolve this problem.

------------------------------------------------------------------------

[ODIDB2024 - MATCHES and LIKE in SQL conditions]{#ODIDB2024}

INFORMIX supports MATCHES and LIKE in SQL statements, while IBM DB2
supports the LIKE statement only.

MATCHES allows you to use brackets to specify a set of matching
characters at a given position :\
   ( col MATCHES \'\[Pp\]aris\' ).\
   ( col MATCHES \'\[0-9\]\[a-z\]\*\' ).\
In this case, the LIKE statement has no equivalent feature.

The following substitutions must be made to convert a MATCHES condition
to a LIKE condition :

- MATCHES keyword must be replaced by LIKE.
- All \'\*\' characters must be replaced by \'%\'.
- All \'?\' characters must be replaced by \'\_\'.
- Remove all brackets expressions.

***[Solution:]{.underline}***

**Warning:** SQL statements using MATCHES expressions must be reviewed
in order to use LIKE expressions.

See also: [MATCHES operator in SQL
Programming](SqlProgramming.html#PORT_MATCHES).

------------------------------------------------------------------------

## [ODIDB2025 - INFORMIX specific SQL statements in BDL]{#ODIDB2025}

The BDL compiler supports several INFORMIX specific SQL statements that
have no meaning when using IBM DB2:  

- CREATE DATABASE
- DROP DATABASE
- START DATABASE (SE only)
- ROLLFORWARD DATABASE
- SET \[BUFFERED\] LOG
- CREATE TABLE with special options (storage, lock mode, etc.)

***[Solution:]{.underline}***

Review your BDL source and remove all static SQL statements that are
INFORMIX specific.

------------------------------------------------------------------------

[ODIDB2028 - INSERT cursors]{#ODIDB2028}

INFORMIX supports insert cursors. An \"insert cursor\" is a special BDL
cursor declared with an INSERT statement instead of a SELECT statement.
When this kind of cursor is open, you can use the PUT instruction to add
rows and the FLUSH instruction to insert the records into the database.

For INFORMIX databases with transactions, OPEN, PUT and FLUSH
instructions must be executed within a transaction.

IBM DB2 does not support insert cursors.

**[*Solution:*]{.underline}**

Insert cursors are emulated by the IBM DB2 database interface.

------------------------------------------------------------------------

[ODIDB2029 - SQL functions and constants]{#ODIDB2029}

Both INFORMIX and DB2 provide numerous built-in SQL functions. Most
INFORMIX SQL functions have the same name and purpose in DB2 ( DAY(),
MONTH(), YEAR(), UPPER(), LOWER(), LENGTH() ).

::: {align="center"}
  ----------------------------------------------------------------- -----------------------
  **INFORMIX**                                                      **IBM DB2**
  today                                                             current date
  current hour to second                                            current time
  current year to fraction(5)                                       current timestamp
  trim( \[leading \| trailing \| both \"char\" FROM\] \"string\")   ltrim( ) and rtrim( )
  pow(x,y)                                                          power(x,y)
  ----------------------------------------------------------------- -----------------------
:::

**[*Solution:*]{.underline}**

**Warning:** You must review the SQL statements using TODAY / CURRENT /
EXTEND expressions.

You can create user defined functions ( UFs ) in the DB2 database.

------------------------------------------------------------------------

[ODIDB2030 - Very large data types]{#ODIDB2030}

Both INFORMIX and IBM DB2 provide special data types to store very large
texts or images.

IBM DB2 recommends the following conversion rules :

::: {align="center"}
  ---------------------------- ----------------------------
  **INFORMIX** **Data Type**   **IBM DB2 Data Type**
  TEXT                         LONG VARCHAR or CLOB
  BYTE                         BLOB, VARGRAPHIC or DBCLOB
  ---------------------------- ----------------------------
:::

**[*Solution:*]{.underline}**

The DB2 database interface can convert BDL TEXT data to CLOB and BYTE
data to BLOB.

**Warning:** DB2 CLOB and BLOB columns are created with a size of 500K.

**Warning:** Genero TEXT/BYTE program variables have a limit of 2
gigabytes, make sure that the large object data does not exceed this
limit.

------------------------------------------------------------------------

[ODIDB2031 - Cursors WITH HOLD]{#ODIDB2031}

INFORMIX provides the WITH HOLD option to prevent cursors being closed
when a transaction ends.

**Warning:** This feature is well supported when using the DB2
interface, except when a transaction is canceled with a ROLLBACK,
because DB2 automatically closes all cursors when you rollback a
transaction.

**[*Solution:*]{.underline}**

Check that your source code does not use  WITH HOLD cursors after
transactions canceled with ROLLBACK.

------------------------------------------------------------------------

[ODIDB2033 - Querying system catalog tables]{#ODIDB2033}

As in INFORMIX, IBM DB2 provides system catalog tables
(systables,syscolumns,etc.) in each database, but the table names and
their structures are quite different.

**[*Solution:*]{.underline}**

**Warning:** No automatic conversion of INFORMIX system tables is
provided by the database interface.

------------------------------------------------------------------------

[ODIDB2036 - INTERVAL data type]{#ODIDB2036}

INFORMIX INTERVAL data type stores a value that represents a span of
time. INTERVAL types are divided into two classes : *year-month
intervals* and *day-time intervals*.

DB2 does not provide a data type corresponding the INFORMIX INTERVAL
data type.

**[*Solution:*]{.underline}**

**Warning:** The INTERVAL data type is not well supported because the
database server has no equivalent native data type. However, BDL
INTERVAL values can be stored into and retrieved from CHAR columns.

------------------------------------------------------------------------

[ODIDB2039 - Data storage concepts]{#ODIDB2039}

An attempt should be made to preserve as much of the storage information
as possible when converting from INFORMIX to IBM DB2. Most important
storage decisions made for INFORMIX database objects (like initial sizes
and physical placement) can be reused for the IBM DB2 database.

Storage concepts are quite similar in INFORMIX and in IBM DB2, but the
names are different.

The following table compares INFORMIX storage concepts to IBM DB2
storage concepts :

::: {align="center"}
+-------------------------------------+-------------------------------------+
| **INFORMIX**                        | **IBM DB2**                         |
+-------------------------------------+-------------------------------------+
| Physical units of storage                                                 |
+-------------------------------------+-------------------------------------+
| The largest unit of physical disk   | One or more \"**containers**\" are  |
| space is a \"**chunk**\", which can | created for each \"tablespace\" to  |
| be allocated either as a cooked     | physically store the data of all    |
| file ( I/O is controlled by the OS) | logical structures. Like INFORMIX   |
| or as raw device (=UNIX partition,  | \"chunks\", \"containers\" can be   |
| I/O is controlled by the database   | an OS file or a raw device.\        |
| engine). A \"dbspace\" uses at      | You can add \"containers\" to a     |
| least one \"chunk\" for storage.\   | \"tablespace\" in order to increase |
| You must add \"chunks\" to          | the size of the logical unit of     |
| \"dbspaces\" in order to increase   | storage or you can define EXTEND    |
| the size of the logical unit of     | options.                            |
| storage.                            |                                     |
+-------------------------------------+-------------------------------------+
| A \"**page**\" is the smallest      | At the finest level of granularity, |
| physical unit of disk storage that  | IBM DB2 stores data in \"**data     |
| the engine uses to read from and    | blocks**\" with size corresponding  |
| write to databases.\                | to a multiple of the operating      |
| A \"chunk\" contains a certain      | system\'s block size.\              |
| number of \"pages\".\               | You set the \"data block\" size     |
| The size of a \"page\" must be      | when creating the database.         |
| equal to the operating system\'s    |                                     |
| block size.                         |                                     |
+-------------------------------------+-------------------------------------+
| An \"**extent**\" consists of a     | An \"**extent**\" is a specific     |
| collection of contiguous \"pages\"  | number of contiguous \"data         |
| that the engine uses to allocate    | blocks\", obtained in a single      |
| both initial and subsequent storage | allocation.\                        |
| space for database tables.\         | When creating a table, you can      |
| When creating a table, you can      | specify the first extent size and   |
| specify the first extent size and   | the size of future extents with the |
| the size of future extents with the | STORAGE() option.\                  |
| EXTENT SIZE and NEXT EXTENT         | For a single table, \"extents\" can |
| options.\                           | be located in different \"data      |
| For a single table, \"extents\" can | files\" of the same \"tablespace\". |
| be located in different \"chunks\"  |                                     |
| of the same \"dbspace\".            |                                     |
+-------------------------------------+-------------------------------------+
| Logical units of storage                                                  |
+-------------------------------------+-------------------------------------+
| A \"**table**\" is a logical unit   | Same concept as INFORMIX.           |
| of storage that contains rows of    |                                     |
| data values.                        |                                     |
+-------------------------------------+-------------------------------------+
| A \"**database**\" is a logical     | Same concept as INFORMIX.\          |
| unit of storage that contains table | \                                   |
| and index data. Each database also  | An IBM DB2 instance can manage      |
| contains a system catalog that      | several databases.                  |
| tracks information about database   |                                     |
| elements like tables, indexes,      |                                     |
| stored procedures, integrity        |                                     |
| constraints and user privileges.    |                                     |
+-------------------------------------+-------------------------------------+
| Database tables are created in a    | Database tables are created in a    |
| specific \"**dbspace**\", which     | specific \"**tablespace**\", which  |
| defines a logical place to store    | defines a logical place to store    |
| data.\                              | data. The main difference with      |
| If no dbspace is given when         | INFORMIX \"dbspaces\", is that IBM  |
| creating the table, INFORMIX        | DB2 tablespaces belong to a         |
| defaults to the current database    | \"database\", while INFORMIX        |
| dbspace.                            | \"dbspaces\" are external to a      |
|                                     | database.                           |
+-------------------------------------+-------------------------------------+
| Other concepts                                                            |
+-------------------------------------+-------------------------------------+
| When initializing an INFORMIX       | Each IBM DB2 database uses a set of |
| engine, a \"**root dbspace**\" is   | \"**control files**\" to store      |
| created to store information about  | internal information. These files   |
| all databases, including storage    | are located in a dedicated          |
| information (chunks used, other     | directory :                         |
| dbspaces, etc.).                    | \"\.../\$DB2INSTANCE/NODEnnnn\"     |
+-------------------------------------+-------------------------------------+
| The \"**physical log**\" is a set   | DB2 uses \"**database log files**\" |
| of continuous disk pages where the  | to record SQL transactions.\        |
| engine stores \"before-images\" of  |                                     |
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

[ODIDB2043 - SQL parameters limitation]{#ODIDB2043}

The IBM DB2 SQL parser does not allow some uses of the \'?\' SQL
parameter marker.

The following SQL expressions are not supported :

     ? IS \[NOT\] NULL\
     ? \<operator\> ?\
     \<function\>( ? )

SQL instructions containing these expressions raise an error during the
statement preparation.

**[*Solution:*]{.underline}**

Check that your BDL programs do not use these kinds of conditional
expressions.

If you really need to test a BDL variable during the execution of a SQL
statement, you must use the CAST() function for DB2 only :\
    WHERE CAST( ? AS INTEGER ) IS NULL\
See the DB2 documentation for more details.

------------------------------------------------------------------------

## [ODIDB2046 - The LOAD and UNLOAD instructions]{#ODIDB2046}

INFORMIX provides two SQL instructions to export / import data from /
into a database table: The UNLOAD instruction copies rows from a
database table into an text file, and the LOAD instruction inserts rows
from an text file into a database table.

IBM DB2 does not provide LOAD and UNLOAD instructions.

**[*Solution:*]{.underline}**

LOAD and UNLOAD instructions are supported.

**Warning:** There is a difference when using DB2 TIME and TIMESTAMP
columns: TIME columns created in the IBM DB2 database are similar to
INFORMIX DATETIME HOUR TO SECOND columns. In LOAD and UNLOAD, all DB2
TIME columns are treated as INFORMIX DATETIME HOUR TO SECOND columns and
thus will be unloaded with the \"hh:mm:ss\"  format.

------------------------------------------------------------------------

## [ODIDB2051 - Setup database statistics]{#ODIDB2051}

INFORMIX provides a special instruction to compute database statistics
in order to improve query optimization plans :

     UPDATE STATISTICS \[options\]

IBM DB2 provides the following equivalent:

     RUNSTATS ON TABLE [full-qualified-table-name]{.small} \[options\]

**Warning:** RUNSTATS is not a SQL instruction, it is a DB2 command and
therefore cannot be executed from a BDL program.

[***Solution:***]{.underline}

You must execute the RUNSTATS command manually from a DB2 Command
Center.

------------------------------------------------------------------------

## [ODIDB2052 - The GROUP BY clause]{#ODIDB2052}

INFORMIX allows you to use column numbers in the GROUP BY clause

     SELECT ord_date, sum(ord_amount) FROM order **GROUP BY 1**

IBM DB2 does not support column numbers in the GROUP BY clause.

[***Solution:***]{.underline}

Use column names instead:

     SELECT ord_date, sum(ord_amount) FROM order **GROUP BY**
**ord_date**

------------------------------------------------------------------------

[ODIDB2053 - The ALTER TABLE instruction]{#ODIDB2053}

INFORMIX and IBM DB2 use different implementations of the ALTER TABLE
instruction.

For example:

INFORMIX allows you to use multiple ADD clauses separated by commas. DB2
does not expect braces and the comma separator :

INFORMIX:\
     ALTER TABLE customer **ADD(col1 INTEGER), ADD(col2 CHAR(20))**\
IBM DB2:\
     ALTER TABLE customer **ADD col1 INTEGER  ADD col2 CHAR(20)**

Depending on the values currently stored, INFORMIX can change the data
type of a column, while DB2 only supports changing the size of CHAR and
VARCHAR columns :

INFORMIX:\
     ALTER TABLE customer **MODIFY ( col1 INTEGER )**\
IBM DB2:\
     ALTER TABLE customer **ALTER COLUMN col1 SET DATA TYPE
VARCHAR(200)**

[***Solution:***]{.underline}

**Warning:** No automatic conversion is done by the database interface.
Read the SQL documentation and review the SQL scripts or the BDL
programs in order to use the database server specific syntax for ALTER
TABLE.

------------------------------------------------------------------------

[ODIDB2054 - The star (asterisk) in SELECT statements]{#ODIDB2054}

INFORMIX allows you to use the star character in the select list along
with other expressions :

   SELECT col1, **\*** FROM tab1 \...

IBM DB2 does not support this. You must use the table name as a prefix
to the star :

   SELECT col1, **tab1.\*** FROM tab1 \...

**[*Solution:*]{.underline}**

Always use the table name with stars.

------------------------------------------------------------------------

[ODIDB2055 - The LENGTH() function]{#ODIDB2055}

INFORMIX provides the LENGTH() function:

    SELECT LENGTH(\"aaa\"), LENGTH(col1) FROM table

IBM DB2 has a equivalent function with the same name, but there is some
difference:

INFORMIX does not count the trailing blanks neither for CHAR not for
VARCHAR expressions, while IBM DB2 counts the trailing blanks.

With the IBM DB2 LENGTH function, when using a CHAR column, values are
always blank padded, so the function returns the size of the CHAR
column. When using a VARCHAR column, trailing blanks are significant,
and the function returns the number of characters, including trailing
blanks.

**[*Solution:*]{.underline}**

You must check if the trailing blanks are significant when using the
LENGTH() function.

If you want to count the number of character by ignoring the trailing
blanks, you must use the RTRIM() function:

    SELECT LENGTH(RTRIM(col1)) FROM table

------------------------------------------------------------------------

## [ODIDB2056 - SQL Interruption]{#ODIDB2056}

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

DB2 UDB 9 supports SQL Interruption in a similar way as INFORMIX. The db
client must issue an SQLCancel() ODBC call to interrupt a query.

[*Solution:*]{.underline}

The DB2 database driver supports SQL interruption and converts the
native SQL error code -952 to the INFORMIX error code -213.

------------------------------------------------------------------------

## [ODIDB2057 - Scrollable Cursors]{#ODIDB2057}

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

DB2 UDB supports native scrollable cursors.

***[Solution:]{.underline}***

The DB2 database driver uses the native DB2 scrollable cursors by
setting the CLI statement attribute SQL_ATTR_CURSOR_TYPE to
SQL_CURSOR_STATIC.

------------------------------------------------------------------------

## [ODIDB2100 - Data type conversion table]{#ODIDB2100}

::: {align="center"}
  ----------------------- ----------------------- -----------------------
  **INFORMIX** **Data     **DB2 Data Types        **DB2 Data Types
  Types**                 (V\<9.1)**              (V\>=9.1)**

  CHAR(n)                 CHAR(n) (limit = 254c!) CHAR(n) (limit = 254c!)

  VARCHAR(n)              VARCHAR(n) (limit =     VARCHAR(n) (limit =
                          32672c!)                32672c!)

  BOOLEAN                 CHAR(1)                 CHAR(1)

  SMALLINT                SMALLINT                SMALLINT

  INTEGER                 INTEGER                 INTEGER

  BIGINT                  BIGINT                  BIGINT

  INT8                    BIGINT                  BIGINT

  FLOAT\[(n)\]            FLOAT\[(n)\] / DOUBLE   FLOAT\[(n)\] / DOUBLE

  SMALLFLOAT              REAL                    REAL

  DECIMAL(p) with p\<=15  DECIMAL(2\*p,p)         DECFLOAT(16)

  DECIMAL(p) with p\>15   *N/A*                   DECFLOAT(16) if p=16,\
                                                  DECFLOAT(34) if p\>16

  DECIMAL(p,s)            DECIMAL(p,s) [(limit =  DECIMAL(p,s) [(limit =
                          31 digits)]{.small}     31 digits)]{.small}

  MONEY(p,s)              DECIMAL(p,s) [(limit =  DECIMAL(p,s) [(limit =
                          31 digits)]{.small}     31 digits)]{.small}

  DATE                    DATE                    DATE

  DATETIME HOUR TO SECOND TIME                    TIME

  DATETIME q1 TO q2       TIMESTAMP               TIMESTAMP

  INTERVAL q1 TO q2       CHAR(n)                 CHAR(n)
  ----------------------- ----------------------- -----------------------
:::

------------------------------------------------------------------------

## [Connecting to DB2 OS/400]{#ODIDB2_OS400}

Note : some of the following actions can be taken via the OS/400
Operations Navigator.

### [[DB2 Architecture on OS/400]{.small}]{#ODIDB2_OS400_ARCHI}

On OS/400 machines, the DB2 Universal Database is integrated to the
operating system. Therefore, some concepts change. For example, the
physical organization of the database is quite different from UNIX or
Windows platforms.

**Common terms:**

::: {align="center"}
  ----------------- ------------------------------------------------
  **SQL Terms**     **DB2 OS/400 Terms**
  Table             Physical file
  Row               Record
  Column            Field
  Index             Keyed logical file, access path
  View              Non keyed logical file
  Schema            Library, Collection, Schema (OS/400 V5R1 only)
  Log               Journal
  Isolation Level   Commitment control level
  ----------------- ------------------------------------------------
:::

A Collection is a library containing a Journal, Journal Receivers, Views
on the database catalogues.

### [[Login to the AS/400 server]{.small}]{#ODIDB2_OS400_LOGIN}

First, login to the AS/400 machine with a 5250 display emulation. All
the commands are executed in the 5250 display emulation (or telnet
connection).

### [[Collection (Schema) Creation]{.small}]{#ODIDB2_OS400_COLL}

A collection or library in DB2 for OS/400 is equivalent to a schema in
DB2 for UNIX.

**1. Launch \"Interactive SQL\"**

> STRSQL COMMIT(\*NONE)

**2. Create a Collection**

> CREATE COLLECTION\
> Press F4\
> Enter field values:\
>     LIBRARY : name of the collection (Schema)\
>     ASP : 1\
>     WITH DATA DICTIONARY : Y\
> Press ENTER\
> Press F3 to quit ( choose Option 1 (save and exit) ). 

Note: The name of the Schema should not begin with "Q"; libraries
beginning with "Q" are system libraries.

This procedure creates:

- A library for your new database,
- A catalog with a data dictionary,
- A journal (QSQJRN),
- A journal receiver (QSQJRN0001).

### [[Source Physical File Creation]{.small}]{#ODIDB2_OS400_PHYS}

Each table in the database is stored in a Physical file. They can be
created in the control center with SQL scripts (CREATE TABLE), or with
OS/400 commands.

The table creation script file must be copied in the library in the
form: *library/sourcefile.member*

Creation of a physical file:

> Type:\
>     CRTSRCPF\
> Enter field values:\
>     FILE = name of the table (10 characters max).\
>     LIBRARY = name of the library in which the table is created
> (schema).\
>     RECORD LENGTH = length of the script creation file (in bytes)\
>     MEMBER = \*FILE

Execution of the SQL creation script:

> Type\
>     RUNSQLSTM\
> Press F10 for additional parameters\
> Enter field values:\
>     SOURCE FILE = name of the source file of the script creation file\
>     LIBRARY = name of the library (schema)\
>     SOURCE MEMBER = name of the member of the script creation file\
>     NAMING FIELD = \*SQL (SQL Naming convention library.table)\
>     COMMITMENT CONTROL = \*NONE\
>     IBM SQL FLAGGING FIELD = \*FLAG

If errors occur, you can use WRKSPLF to display error information saved
in the spool file. Use option 5 in the Opt Field on the line of the
script file you tried to execute.

### [[Trigger Creation]{.small}]{#ODIDB2_OS400_TRIG}

With DB2 on OS/400, triggers need to be external programs written in a
high level language such as C, COBOL, RPG, or PL/I.

To create a trigger, use the following steps:

**1. Create an OS/400 Source file for the trigger programs**

Create a source physical file on your AS/400 for the trigger programs.
Each trigger program will be stored in a separate member within this
source file.

Type:\
    CRTSRCPF FILE(*library*/*file*)\
where:\
    - *library* : name of the library you created for your new database\
    - *file* : name you want to call the trigger source physical file

The file name should be ten characters or fewer.

**2. Create a member for each trigger program**

Create a source file member for each trigger program. After the creation
of trigger programs (in the next step), the programs will be forwarded
to these members. 

Type:\
     ADDPFM\
Enter field values:\
    FILE = name of the source file you just created\
    LIBRARY = name of the library you created for your database\
    MEMBER = name you want to give the trigger source member

Repeat this operation for each trigger.

**3. Create trigger programs in an OS/400 supported high level
language**

The OS/400-compatible languages include: ILE C/400, ILE COBOL, ILE RPG,
COBOL, PL/I, and RPG.\
The script creation file of the trigger should be send via FTP into
*library/sourcefile.member,* where *sourcefile* and member are the
values specified in the previous step.

**4. Compile the trigger programs**

Once the trigger programs are in AS/400 members, you can compile them.
Use whichever compiler is appropriate for the language you used to
create the trigger program.

**5. Bind the trigger programs**

After you compile the trigger programs, \"bind\" each compiled program
file. Binding will establish a relationship between the program and any
tables or views the program specifies.

Type:\
    CRTPGM PGM (*library*/*program*) ACTGRP(\*CALLER)\
where:\
    *library* is the name of the library you created for your new
database\
    *program* is the name of the compiled trigger program

Repeat this operation for each trigger.

**6. Add the trigger programs to physical files**

The final step for migrating triggers is to add each program to a
physical file. This will tie the trigger program to the table that calls
it.

Type:\
    ADDPFTRG\
Enter field values:\
    PHYSICAL FILE = name of the table you want to attach the trigger to\
    PHYSICAL FILE LIBRARY = name of the database library\
    TRIGGER TIME = either \*BEFORE or \*AFTER.\
    TRIGGER EVENT = \*INSERT, \*DELETE, or \*UPDATE.\
    PROGRAM = name of the compiled program file\
    PROGRAM LIBRARY = name of the database library.\
    REPLACE TRIGGER = \*YES.\
    ALLOW REPEATED CHANGES = \*YES.

Note:: The trigger program should be in the same library as the
database.

The trigger program is now tied to the table specified in the *Physical
File* field and will be called each time the database action you
specified above occurs. The trigger program may be called from
interactive SQL, another AS/400 program, or an ODBC insert, delete,
update, or procedure call.

### [[Permission Definition]{.small}]{#ODIDB2_OS400_PERM}

On OS/400, database security is managed at the operating system level,
not at the database level. When you set up permissions for the database,
you determine the degree of access (read, add, delete, etc.) individual
users, groups, and authorization lists may have. This operation can
easily be done via Operation Navigator.

The privileges must include the following system authorities:

- \*USE to the Create Physical File (CRTPF) command.

- \*EXECUTE and \*ADD to the library into which the table is created.

- \*OBJOPR and \*OBJMGT to the journal.

- \*CHANGE to the data dictionary if the library into which the table is
  created is an SQL collection with a data dictionary.

To define a foreign key, the privileges must include the following on
the parent table: 

- The REFERENCES privilege or object management authority for the table.

- The REFERENCES privilege on each column of the specified parent key.

- Ownership of the table.

The REFERENCES privilege on a table consists of:

- Being the owner of the table.

- Having the REFERENCES privilege to the table.

- Having the system authorities of either \*OBJREF or \*OBJMGT to the
  table.

The REFERENCES privilege on a column consists of:

- Being the owner of the table.

- Having the REFERENCES privilege to the column.

- Having the system authority of \*OBJREF to the column or the system
  authority of \*OBJMGT to the table.

To EXECUTE a user-defined function, the privilege consists of:

- Being owner of the user-defined function.

- Having EXECUTE privilege to the user-defined function.

- Having the system authorities of \*OBJOPR and \*EXECUTE to the
  user-defined function.

### [[Relational DB Directory Entry Creation]{.small}]{#ODIDB2_OS400_EDIR}

The relational database directory is equivalent to the database
directory of the DB2 client. This is necessary to access the database
with DRDA clients (Distributed Relational Database Architecture) like
DB2 client.

Use the WRKRDBDIRE tool to add the entry in the database directory:

- Type\
  WRKDBDIRE

- Type Option 1 (add)

- Enter field values:\
      ADDRESS = \*LOCAL\
      TYPE = \*IP

Start the DDM server on the OS/400 which listens on the DRDA 446 port:

- Type STRTCPSVR \*DDM

Start the database server:

- Type STRHOSTSVR

- Enter field values:\
      SERVER TYPE = \*DATABASE\
  REQUIRED PROTOCOL : \*ANY

The DDM/DRDA server that listens on TCP/IP port 446 handles requests
from a DRDA client (examples are DB2 Connect or another AS/400).

The database server is not needed for DRDA clients, but it is needed for
Client Access.

If a TCP/IP connection is desired, then your AS/400 server cannot have a
release prior to V4R2 installed.

To manually configure the connection via the DB2 command line, you will
need to enter catalog commands:

\> db2 catalog tcpip node \<node-name\> remote \<as400-adress\> server
446\
\> db2 catalog db \<db-name-alias\> at node \<node-name\> authentication
dcs\
\> db2 catalog dcs db \<db-name-alias\> as \<local-RDB-name-of-AS400\>

If you catalogue the DB2 UDB for iSeries server incorrectly, you may get
an SQL5048N error message. SQL7008N is another common error in that the
DB2 UDB for iSeries tables being accessed on the server are not being
journaled. To correct the SQL7008N error, you need to start journaling
your tables or change the isolation level to No Commit.

The proper CCSID value (normally 37 for US English customers) is needed
for any tables on the iSeries accessed via DB2 Connect. You can view the
CCSID value with the DSPFD CL command or Operations Navigator. CCSID
values can be changed with the ALTER TABLE statement or CHGPF CL
command. Furthermore, to successfully connect, you may need to change
one of the following: the CCSID of the job, the CCSID of the user
profile used, or the system CCSID value (QCCSID) if it\'s the default
65535.

### [[DB2 Client Configuration on Windows]{.small}]{#ODIDB2_OS400_CLNT}

To configure a DB2 client on Windows platforms, use the Client
Configuration Assistant. This tool is available only under Microsoft
Windows. Under Unix, you have to use the command line as described in
the previous chapter.

1\. Source:

> \- Select "Manually configure a connection to a database".

2\. Protocol:

> \- Select "TCP/IP".
>
> \- Check "The database physically resides on a host or AS/400 System".

3\. TCP/IP:

> \- Host Name : AS/400 system name.
>
> \- Port Number : Port where DDM/DRDA server is listening (default :
> 446).

4\. Database:

> \- Database name : name defined in the relational database directory
> entries (with WRKRDBDIRE).

5\. ODBC:

> \- You can register the database as an ODBC data source. Not needed
> for DRDA connection used by ODI.

6\. Node Options:

> \- Optional, but needed to access the database via the control center.
>
> \- System name : AS/400 system name.
>
> \- Instance name : not used for a connection to AS400 (because only
> one instance is running on an AS/400).
>
> \- Operating System : OS/400.

7\. Security Options:

> \- Optional.

8\. Host or AS400 Options:

> \- Optional.

### [[Differences Between DB2 UNIX & DB2 OS/400]{.small}]{#ODIDB2_OS400_DIFF}

Some of the differences between DB2 for Unix/Windows and DB2 for OS/400
are:

- There is only one database on a system; you can not create two
  instances on the same database server. The database is a single
  system-wide database. The database name used for the connect statement
  is the name of the system. Schemas (Collections) can be used to manage
  different logical databases on the same OS/400 machine.

- There is no TABLESPACE concept on DB2 for iSeries. All the storage is
  controlled by the database manager and operating system.

- The identity column is not supported (for serial emulation).

- The SET SCHEMA SQL command is not supported.

- NUMERIC data type is defined as zoned decimal on DB2 for iSeries and
  packed decimal on other platforms.

- The FLOAT data type does not use the same storage. For portability
  across platforms, do not use FLOAT(n).

- Not all features of the CREATE FUNCTION statement are supported on
  each platform (see documentation).

- iSeries prior to V5R1 requires the statement to be processed by a
  special schema processor.   iSeries as of V5R1 would require this only
  if the statement includes other DDL statements.

- OS/400 supports "SET DEFAULT" clause ON DELETE.

- OS/400 supports DROP statement with CASCADE behavior.

- Syntaxes of CREATE, ALTER and RENAME TABLE are different on the two
  systems.

### [[Naming Conventions]{.small}]{#ODIDB2_OS400_NAME}

The naming convention defines how database tables are identified.

DB2 OS/400 can use two kinds of naming conventions:

- The **\*SQL** naming convention.\
  The table has to be qualified with the name of the collection (schema)
  which must be the same name as the user connected to the database. All
  tables have to be in the same database.\

- The **\*SYS** naming convention.\
  If a table is unqualified, it will be searched for in the \*CURLIB
  collection. You can change the library list with the ADDLIBLE command.
  You may create a small CL program attached to the profile that will
  change the library list on sign on. You can also globally change the
  user portion of the library list using the QUSRLIBL system variable,
  but this would affect all users on the system.
