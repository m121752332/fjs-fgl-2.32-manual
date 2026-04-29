[Back to Contents](../index.html)

------------------------------------------------------------------------

# ODI Adaptation Guide For Oracle 8.x, 9.x, 10.x, 11.x

Installation

::: {align="center"}
  --------------------------------------------------------
  [Install ORACLE and create a database](#ODIORA_PREP01)
  [Prepare the runtime environment](#ODIORA_PREP02)
  --------------------------------------------------------
:::

Database concepts

::: {align="center"}
  ------------------------------------------------------------
  [Database concepts](#ODIORA007a)
  [Data storage concepts](#ODIORA039)
  [Data consistency and concurrency management](#ODIORA008a)
  [Transactions handling](#ODIORA009a)
  [Defining database users](#ODIORA016a)
  [Setting privileges](#ODIORA016b)
  ------------------------------------------------------------
:::

Data dictionary

::: {align="center"}
  ----------------------------------------------
  [BOOLEAN data type](#ODIORA041)
  [CHARACTER data types](#ODIORA011a)
  [NUMERIC data types](#ODIORA021)
  [DATE and DATETIME data types](#ODIORA001)
  [INTERVAL data type](#ODIORA036)
  [SERIAL data types](#ODIORA005)
  [ROWIDs](#ODIORA004)
  [Very large data types](#ODIORA030)
  [The ALTER TABLE instruction](#ODIORA053)
  [Constraints](#ODIORA012)
  [Triggers](#ODIORA013)
  [Stored procedures](#ODIORA014)
  [Name resolution of SQL objects](#ODIORA019)
  [Setup database statistics](#ODIORA051)
  [NULLs in indexed columns](#ODIORA055)
  [Data type conversion table](#ODIORA100)
  ----------------------------------------------
:::

Data manipulation

::: {align="center"}
  --------------------------------------------------
  [Reserved words](#ODIORA003)
  [Outer joins](#ODIORA006)
  [Transactions handling](#ODIORA009a)
  [Temporary tables](#ODIORA017)
  [Substrings in SQL](#ODIORA018)
  [The LENGTH( ) function](#ODIORA011b)
  [Empty character strings](#ODIORA011c)
  [Name resolution of SQL objects](#ODIORA019)
  [String delimiters and object names](#ODIORA020)
  [Getting one row with SELECT](#ODIORA022)
  [MATCHES and LIKE conditions](#ODIORA024)
  [SQL functions and constants](#ODIORA029)
  [Querying system catalog tables](#ODIORA033)
  [Syntax of UPDATE statements](#ODIORA034)
  [The USER constant](#ODIORA047)
  [The GROUP BY clause](#ODIORA052)
  [The star in SELECT statements](#ODIORA054)
  --------------------------------------------------
:::

BDL programming

::: {align="center"}
  -------------------------------------------------------------
  [SERIAL data type](#ODIORA005)
  [Handling SQL errors when preparing statements](#ODIORA010)
  [INFORMIX specific SQL statements in BDL](#ODIORA025)
  [INSERT cursors](#ODIORA028)
  [Cursors WITH HOLD](#ODIORA031)
  [SELECT FOR UPDATE](#ODIORA008b)
  [UPDATE/DELETE WHERE CURRENT OF \<cursor\>](#ODIORA032)
  [The LOAD and UNLOAD instructions](#ODIORA046)
  [SQL Interruption](#ODIORA056)
  [Scrollable Cursors](#ODIORA057)
  -------------------------------------------------------------
:::

------------------------------------------------------------------------

## [Runtime configuration]{#ODIORA_PREP} {#runtime-configuration align="left"}

> ### [Install Oracle and create a database]{#ODIORA_PREP01} {#install-oracle-and-create-a-database align="left"}
>
> 1.  Install the ORACLE Server on your computer.
>
> 2.  Create and setup the Oracle **instance**.\
>     \
>     Warning: If you plan to create a database a multi-byte character
>     set like UTF-8, make sure to use [byte length
>     semantics](#ODIORA011a).
>
> 3.  Set up and start a **listener** if you plan to use a client /
>     server architecture.
>
> 4.  Create a database user dedicated to your application, the
>     **application administrator** which will manage the database
>     tables of the application:\
>     \
>        \$ sqlplus / AS SYSDBA\
>        \...\
>        sqlplus\> CREATE USER *appadmin* IDENTIFIED BY *password;*\
>     \
>     You must grant privileges to this user:\
>     \
>        sqlplus\> GRANT CONNECT, RESOURCE TO *appadmin;*\
>     \
>
> 5.  If you plan to use the default temporary table emulation, you must
>     create the **TEMPTABS** tablespace. Note that this tablespace must
>     be created as **permanent** tablespace. See issue
>     [ODIORA017](#ODIORA017) for more details:\
>     \
>        sqlplus\> CREATE TABLESPACE **TEMPTABS\
>                ** DATAFILE \'*file*\'\
>                 SIZE 1M AUTOEXTEND ON NEXT 1K;
>
> 6.  Connect as the application administrator:
>
>        sqlplus\> CONNECT *appadmin*/*password*\
>
> 7.  Create the **application tables**. Do not forget to convert
>     INFORMIX data types to Oracle data types. See issue
>     [ODIORA100](#ODIORA100) for more details. Check for reserved words
>     in your table and column names: Oracle 8i provides the
>     V\$RESERVED_WORDS view to track Oracle reserved words.
>
> 8.  If you plan to use SERIAL emulation, you must choose an emulation
>     method. You are free to use a technique based on SEQUENCES or
>     based on the SERIALREG registration table. If you want to use the
>     registration table technique, you must create the **SERIALREG**
>     table and create a INSERT TRIGGER for each table using a SERIAL.
>     See issue [ODIORA005](#ODIORA005) for more details.

> ### [Prepare the runtime environment]{#ODIORA_PREP02} {#prepare-the-runtime-environment align="left"}
>
> 1.  In order to connect to ORACLE, you must have a database driver
>     \"**dbmora\***\" in FGLDIR/dbdrivers.
>
> 2.  If you want to connect to a remote Oracle server from an
>     application server, you must install the **ORACLE Client
>     Software** on your application server and configure this part.
>
> 3.  Make sure that the ORACLE client environment variables are
>     properly set. Check variables such as **ORACLE_HOME** (the path to
>     the installation directory), **ORACLE_SID** (the server identifier
>     when connecting locallly), etc. See Oracle documentation for more
>     details.
>
> 4.  Verify the environment variable defining the search path for
>     database client shared libraries (libclntsh.so on UNIX, OCI.DLL on
>     Windows). On UNIX platforms, the variable is specific to the
>     operating system. For example, on Solaris and Linux systems, it is
>     **LD_LIBRARY_PATH**, on AIX it is **LIBPATH**, or HP/UX it is
>     **SHLIB_PATH**. On Windows, you define the DLL search path in the
>     **PATH** environment variable.
>
>     +-----------------------------------+-----------------------------------+
>     | **ORACLE version**                | **Shared library environment      |
>     |                                   | setting**                         |
>     +-----------------------------------+-----------------------------------+
>     | **Oracle 8.1 and higher**         | *UNIX*: Add **\$ORACLE_HOME/lib** |
>     |                                   | to LD_LIBRARY_PATH (or its        |
>     |                                   | equivalent).\                     |
>     |                                   | *Windows*: Add                    |
>     |                                   | **%ORACLE_HOME%\\bin** to PATH.   |
>     +-----------------------------------+-----------------------------------+
>     |                                   |                                   |
>     +-----------------------------------+-----------------------------------+
>
> 5.  Check the database locale settings (**NLS_LANG**,
>     **NLS_DATE_FORMAT**, etc). The DB locale must match the locale
>     used by the runtime system (**LANG**).
>
> 6.    If you are using the TNS protocol, verify if the **ORACLE
>     listener** is started on the server.
>
> 7.  To test the client environment settings, you can try to connect to
>     the ORACLE server with the SQL\*Plus tool:
>
>          \$ sqlplus *username*/*password*@*service*
>
> 8.  Set up the **fglprofile** entries for [database
>     connections](Connections.html#DS_ODI_DBVSPEC).\
>     \
>     **Warning:** **Make sure that you are using the ODI driver
>     corresponding to the database client and server version. Because
>     Informix features emulation are dependant from the database server
>     version, it is mandatory to use the same version of the database
>     client and ODI driver as the server version.**\
>
> 9.  Set up fglprofile for the SERIAL emulation method. The following
>     entry defines the SERIAL emulation method. You can either use the
>     SEQUENCE based trigger or the SERIALREG based trigger method:\
>        dbi.database.*dbname*.ifxemul.datatype.serial.emulation =
>     \"(native\|regtable)\"\
>     The value \'native\' selects the SEQUENCE based method and the
>     value \'regtable\' selects the SERIALREG based method. This entry
>     has no effect if
>     **dbi.database.\<dbname\>.ifxemul.datatype.serial** is set to
>     \'false\'.\
>     The default is SERIAL emulation enabled with native method
>     (SEQUENCE-based). See issue [ODIORA005](#ODIORA005) for more
>     details.
>
> 10. Define the database schema selection if needed.\
>     Warning : This is only supported in Oracle 8i (8.1.5) and higher.
>     The following entry defines the database schema to be used by the
>     application. The database interface automatically executes an
>     \"ALTER SESSION SET CURRENT_SCHEMA \<owner\>\" instruction to
>     switch to a specific schema:\
>     \
>        dbi.database.*dbname*.ora.schema = \"*name*\"\
>     \
>     Here *dbname* identifies the database name used in the BDL program
>     ( DATABASE *dbname* ) and *name* is the schema name to be used in
>     the ALTER SESSION instruction. If this entry is not defined, no
>     \"ALTER SESSION\" instruction is executed and the current schema
>     defaults to the user\'s name.
>
> 11. Define pre-fetch parameters. Oracle offers high performance by
>     pre-fetching rows in memory. The pre-fetching parameters can be
>     tuned with the following entries:\
>     \
>        dbi.database.*dbname*.ora.prefetch.rows = *integer*\
>        dbi.database.*dbname*.ora.prefetch.memory = *integer* \# in
>     bytes\
>     \
>     Note: These values will be applied to all application cursors.\
>     \
>     The interface pre-fetches rows up to the prefetch.rows limit
>     unless the prefetch.memory limit is reached, in which case the
>     interface returns as many rows as will fit in a buffer of size
>     prefetch.memory. By default, pre-fetching is on and defaults to 10
>     rows, the memory parameter is set to zero, which means that memory
>     size is not included in computing the number of rows to prefetch.
>
> 12. If needed, define a specific command to generate session
>     identifiers with this FGLPROFILE setting:\
>     \
>        dbi.database.*dbname*.ora.sid.command = \"SELECT \...\"\
>     \
>     This unique session identifier will be used to create table names
>     for temporary table emulation.\
>     By default, the database driver will use \"SELECT
>     USERENV(\'SESSIONID\') FROM DUAL\".\
>
> 13. The default temporary table emulation uses regular permanent
>     tables. If this does not fit you needs, you can use GLOBAL
>     TEMPORARY TABLES with this FGLPROFILE setting:\
>     \
>        dbi.database.*dbname*.ifxemul.temptables.emulation =
>     \"global\"\
>
> 14. By default, the Oracle database driver will use native scrollable
>     cursors. You can turn on scrollable cursor emulation with the next
>     FGLPROFILE setting:\
>     \
>        dbi.database.*dbname*.ora.cursor.scroll.emul = true

------------------------------------------------------------------------

[ODIORA001 - DATE and DATETIME data types]{#ODIORA001}

INFORMIX provides two data types to store date and time information:

- **DATE** = for year, month and day storage.
- **DATETIME** = for year to fraction(1-5) storage.

ORACLE provides only the following data types to store date and time
data:

- **DATE** = for year, month, day, hour, min, second storage.
- **TIMESTAMP** (Oracle 9i) = for year, month, day, hour, min, second,
  fraction storage.

**String representing date time information:**

INFORMIX is able to convert quoted strings to DATE / DATETIME data if
the string contains matching environment parameters (i.e. DBDATE,
GL_DATETIME).

As in INFORMIX, ORACLE can convert quoted strings to DATE or TIMESTAMP
data if the contents of the string matches the NLS date format
parameters (NLS_DATE_FORMAT, NLS_TIMESTAMP_FORMAT).  The TO_DATE( ) and
TO_TIMESTAMP() SQL functions convert strings to dates or timestamps,
according to a given format. The TO_CHAR( ) SQL function allows you to
convert dates or timestamps to strings, according to a given format.

**Date arithmetic:**

- INFORMIX supports date arithmetic on DATE and DATETIME values. The
  result of an arithmetic expression involving dates/times is a number
  of days when only DATEs are used, and an INTERVAL value if a DATETIME
  is used in the expression. In ORACLE, the result of an arithmetic
  expression involving DATE values is a NUMBER of days; the decimal part
  is the fraction of the day ( 0.5 = 12H00, 2.00694444 = (2 + (10/1440))
  = 2 days and 10 minutes ).  The result of an expression involving
  Oracle TIMESTAMP data is of type INTERVAL. See Oracle documentation
  for more details.
- INFORMIX automatically converts an integer to a date when the integer
  is used to set a value of a date column. ORACLE does not support this
  automatic conversion.
- Complex DATETIME expressions ( involving INTERVAL values for example)
  are INFORMIX specific and have no equivalent in ORACLE.
- To compare dates that have time data in ORACLE, you can use the
  ROUND() or TRUNC() SQL functions.

**[*Solution:*]{.underline}**

The ORACLE DATE type is used for INFORMIX DATE data. The database
interface automatically sets the time part to midnight (00:00:00) during
input/output operations. You must be very careful since manual
modifications of the database might set the time part, for example :\
    UPDATE table SET date_col = SYSDATE\
(SYSDATE is equivalent to CURRENT YEAR TO SECOND in INFORMIX).\
After this kind of update, when columns have date values with a time
part different from midnight, some SELECT statements might not return
all the expected rows.

INFORMIX DATETIME data with any precision from YEAR to SECOND is stored
in ORACLE DATE columns. The database interface makes the conversion
automatically. Missing date or time parts default to 1900-01-01
00:00:00. For example, when using a DATETIME HOUR TO MINUTE with the
value of \"11:45\", the ORACLE DATE value will be \"1900-01-01
11:45:00\".

When using ORACLE 9i, INFORMIX DATETIME YEAR TO FRACTION(n) data is
stored in ORACLE TIMESTAMP columns. The TIMESTAMP data type can store up
to 9 digits in the fractional part, and therefore can store all
precisions of INFORMIX DATETIME.

**Warning:** Using integers (number of days since 1899/12/31) as dates
is not supported by ORACLE. Check your code to detect where you are
using integers with DATE columns.

**Warning:** Literal DATETIME and INTERVAL expressions (i.e. DATETIME (
1999-10-12) YEAR TO DAY) are not converted.

**Warning:** It is strongly recommended that you use BDL variables in
dynamic SQL statements instead of quoted strings representing DATEs. For
example :\
   LET stmt = \"SELECT \... FROM customer WHERE creat_date \>\'\",
adate,\"\'\"\
is not portable.  Use a question mark place holder instead and OPEN the
cursor by USING adate :\
   LET stmt = \"SELECT \... FROM customer WHERE creat_date \> ?\"

**Warning:** Most arithmetic expressions involving dates ( for example,
to add or remove a number of days from a date ) will produce the same
result with ORACLE. But keep in mind that ORACLE evaluates date
arithmetic expressions to NUMBERs ( \<days\>.\<fraction\> ) while
INFORMIX evaluates to INTEGERs when only DATEs are used in the
expression, or to INTERVALs if at least one DATETIME is used in the
expression.

**Warning:** DATE arithmetic expressions using SQL parameters (USING
variables) are not fully supported. For example: [\" SELECT \... WHERE
datecol \< ? + 1\"]{.small} generates an error at PREPARE time.

**Warning:** SQL Statements using expressions with TODAY / CURRENT / 
EXTEND must be reviewed and adapted to the native syntax.

------------------------------------------------------------------------

[ODIORA003 - Reserved words]{#ODIORA003}

SQL object names like table and column names cannot be SQL reserved
words in ORACLE.

An example of a common word which is part of the ORACLE SQL grammar is
\'**level**\'.

***[Solution:]{.underline}***

Table or column names which are ORACLE reserved words must be renamed.

ORACLE reserved keywords are listed in the ORACLE documentation, or
Oracle 8i provides the V\$RESERVED_WORDS view to track Oracle reserved
words. All BDL application sources must be verified. To check if a given
keyword is used in a source, you can use UNIX \'grep\' or \'awk\' tools.
Most modifications can be done automatically with UNIX tools like
\'sed\' or \'awk\'.

------------------------------------------------------------------------

[ODIORA004 - ROWIDs]{#ODIORA004}

When creating a table, INFORMIX automatically adds a \"ROWID\" integer
column (applies to non-fragmented tables only). The ROWID column is
auto-filled with a unique number and can be used like a primary key to
access a given row.

ORACLE supports ROWIDs, but the data type is different from INFORMIX
ROWIDs: ORACLE rowids are CHAR(18).

For example : **AAAA8mAALAAAAQkAAA**

Since ORACLE rowids are physical addresses, they cannot be used as
permanent row identifiers ( After a DELETE, an INSERT statement might
reuse the physical place of the deleted row, to store the new row ).

With INFORMIX, SQLCA.SQLERRD\[6\] contains the ROWID of the last
INSERTed or UPDATEd row. This is not supported with ORACLE because
ORACLE ROWID are not INTEGERs.

***[Solution:]{.underline}***

If the BDL application uses INFORMIX rowids as primary keys, the program
logic should be reviewed in order to use the real primary keys (usually,
serials which can be supported) or ORACLE rowids as CHAR(18) ( INFORMIX
rowids will fit in this char data type).

If you cannot avoid the use of rowids, you must change the type of the
variables which hold ROWID values. Instead of using INTEGER, you must
use CHAR(18). INFORMIX rowids (INTEGERs) will automatically fit into a
CHAR(18) variable.

All references to SQLCA.SQLERRD\[6\] must be removed because this
variable will not contain the ROWID of the last INSERTed or UPDATEd row
when using the ORACLE interface.

------------------------------------------------------------------------

## [ODIORA005 - SERIAL data types]{#ODIORA005}

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
statements that are using a zero value:\
    CREATE TABLE tab ( k SERIAL );  \--\> internal counter = 0\
    INSERT INTO tab VALUES ( 0 );   \--\> internal counter = 1\
    INSERT INTO tab VALUES ( 10 );  \--\> internal counter = 10\
    INSERT INTO tab VALUES ( 0 );   \--\> internal counter = 11\
    DELETE FROM tab;                \--\> internal counter = 11\
    INSERT INTO tab VALUES ( 0 );   \--\> internal counter = 12

ORACLE sequences:

- Sequences are totally detached from tables.
- The purpose of sequences is to provide unique integer numbers.
- Sequences are identified by a sequence name.
- To create a sequence, you must use the CREATE SEQUENCE statement.\
  Once a sequence is created, it is permanent (like a table).
- To get a new sequence value, you must use the **nextval** keyword,
  preceded by the name of the sequence.\
  The **\<seqname\>.nextval** expression can be used in INSERT
  statements :\
          INSERT INTO tab1 VALUES ( **tab1_seq.nextval**, \... )
- To get the last generated number, ORACLE provides the **currval**
  keyword :\
          SELECT \<seqname\>.**currval** FROM DUAL

Remark: In order to improve performance, ORACLE can handle a set of
sequences in the cache (See CREATE SEQUENCE syntax in the ORACLE
documentation).

**[*Solution:*]{.underline}**

When using Oracle, the SERIAL data type can be emulated with INSERT
TRIGGERs. In BDL programs, the SQLCA structure is filled as expected:
After an insert, SQLCA.SQLERRD\[2\] holds the last generated serial
value. However, SQLCA.SQLERRD\[2\] is defined as an INTEGER, it cannot
hold values from BIGSERIAL (NUMBER(20)) auto incremented columns. If you
are using BIGSERIAL columns, you must the fetch the sequence
pseudo-column CURR_VAL or fetch the LASTSERIAL column from the SERIALREG
table if used.

The triggers can be created [manually]{.underline} during the database
creation procedure, or **automatically** from a BDL program: When a BDL
program executes a CREATE \[TEMP\] TABLE with a SERIAL column, the
Oracle interface automatically converts the SERIAL data type to
NUMBER(10,0) and dynamically creates the trigger. For [temporary
tables](#ODIORA017), the trigger is dropped automatically after a \"DROP
TABLE temptab\" or when the program disconnects from the database.

**Warning:** Users executing programs which create tables with SERIAL
columns must have the **CONNECT** and **RESOURCE** roles assigned to
create triggers and sequences.

In database creation scripts, all SERIAL\[(n)\] data types must be
converted to NUMBER(10,0) data types and you must create the triggers
(and the sequences when using sequence-based triggers). See below for
more details. SERIAL8\[(n)\] and BIGSERIAL\[(n)\] must be replaced by
NUMBER(20,0).

**Warning** : With Oracle, INSERT statements using NULL for the SERIAL
column will produce a new serial value:\
   INSERT INTO tab (col1,col2) VALUES (**NULL**,\'data\')\
This behavior is mandatory in order to support INSERT statements which
do not use the serial column:\
   INSERT INTO tab (col2) VALUES (\'data\')\
Check whether your application uses tables with a SERIAL column that can
contain a NULL value.

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

**Warning:** Since the INFORMIX SERIAL data type simulation is
implemented in the ORACLE database, inserting rows with ORACLE tools
like SQL\*Plus or SQL\*Loader will raise the INSERT triggers. When
loading big tables, you can disable triggers with ALTER TRIGGER \[ENABLE
\| DISABLE\] (see ORACLE documentation for more details). After
re-activation of the serial triggers, the SERIAL sequences must be
re-initialized (use serialpkg.create_sequence(\'tab\',\'col\') or
re-execute the PL/SQL script containing the sequence and trigger
creation.

You are free to use **SEQUENCE based insert triggers** (1) or
**SERIALREG based insert triggers** (2). The second solution needs the
**SERIALREG** table to register serials.

With the following fglprofile entry, you define the technique to be used
for SERIAL emulation:

   dbi.database.\<dbname\>.ifxemul.datatype.serial.emulation =
{\"native\"\|\"regtable\"}

The \'**native**\' value defines the SEQUENCE-based technique and the
\'**regtable**\' defines the SERIALREG-based technique.

This entry must be used with :

   dbi.database.\<dbname\>.ifxemul.serial = {true\|false}

If this entry is set to false, the emulation method specification entry
is ignored.

When no entry is specified, the default is SERIAL emulation enabled with
\'native\' method (SEQUENCE-based).\
\
[1. Using SEQUENCES based triggers]{.underline}

Each table having a SERIAL column needs an INSERT TRIGGER and a SEQUENCE
dedicated to SERIAL generation.

To know how to write those sequences and triggers,  you can create a
small Genero program that creates a table with a SERIAL column. Set the
FGLSQLDEBUG environment variable and run the program. The debug output
will show you the native SQL commands to create the sequence and the
trigger.

[2. Using SERIALREG based triggers]{.underline}

Each table having a SERIAL column needs an INSERT TRIGGER which uses the
SERIALREG table dedicated to SERIAL registration.

First, you must prepare the database and create the SERIALREG table as
follows:\
\
CREATE TABLE SERIALREG (\
     TABLENAME VARCHAR2(50) NOT NULL,\
     LASTSERIAL NUMBER(20,0) NOT NULL,\
     PRIMARY KEY ( TABLENAME )\
)

**Warning:** This table must exist in the database before creating the
serial triggers.

In database creation scripts, all SERIAL\[(n)\] data types must be
converted to INTEGER data types and you must create one trigger for each
table. SERIAL8/BIGSERIAL columns must be converted to NUMBER(20,0). To
know how to write those triggers,  you can create a small Genero program
that creates a table with a SERIAL column. Set the FGLSQLDEBUG
environment variable and run the program. The debug output will show you
the native trigger creation command.

**Warning** : The serial production is based on the SERIALREG table
which registers the last generated number for each table. If you delete
rows of this table, sequences will restart at start values and you might
get duplicated values.

------------------------------------------------------------------------

[ODIORA006 - Outer joins]{#ODIORA006}

In INFORMIX SQL, outer joins can be defined in the **FROM** clause with
the **OUTER** keyword:

> SELECT ... FROM a, OUTER(b) WHERE a.key = b.akey
>
>     SELECT ... FROM a, OUTER(b,OUTER(c)) WHERE a.key = b.akey AND b.key1 = c.bkey1 AND b.key2 = c.bkey2 

ORACLE expects the **(+)** operator in the join condition. You must set
a (+) after columns of the tables which must have NULL values when no
record matches the condition:

> SELECT ... FROM a, b WHERE a.key = b.key (+)
>
>     SELECT ... FROM a, b, c WHERE a.key = b.akey (+)
>        AND b.key1 = c.bkey1 (+)
>        AND b.key2 = c.bkey2 (+) 

When using additional conditions on outer tables, the (+) operator also
has to be used. For example :

> SELECT ... FROM a, OUTER(b) WHERE a.key = b.akey AND b.colx > 10

Must be converted to :

> SELECT ... FROM a, b WHERE a.key = b.akey (+)
>        AND b.colx (+) > 10

The ORACLE outer joins restriction :

In a query that performs outer joins of more than two pairs of tables, a
single table can only be the NULL generated table for one other table.
The following case is not allowed : WHERE a.col = b.col (+) AND b.col
(+) = c.col

[***Solution***]{.underline}:

For better SQL portability, you should use the ANSI outer join syntax
instead of the old Informix OUTER syntax.

The Oracle interface can convert most INFORMIX OUTER specifications to
Oracle outer joins.

Prerequisites :

1.  In the FROM clause, the main table must be the first item and the
    outer tables must figure from left to right in the order of outer
    levels.\
       Example which does not work : \"FROM OUTER(tab2), tab1 \".
2.  The outer join in the WHERE part must use the table name as prefix.\
       Example : \"WHERE tab1.col1 = tab2.col2 \".

Restrictions :

1.  Statements composed by 2 or more SELECT instructions are not
    supported.\
      Example : \"SELECT \... UNION SELECT\" or \"SELECT \... WHERE col
    IN (SELECT\...)\"

Notes::

1.  Table aliases are detected in OUTER expressions.\
       OUTER example with table alias : \"OUTER( tab1 alias1)\".
2.  In the outer join, \<outer table\>.\<col\> can be placed on both
    right or left sides of the equal sign.\
       OUTER join example with table on the left : \"WHERE outertab.col1
    = maintab.col2 \".
3.  Table names detection is not case-sensitive.\
       Example : \"SELECT \... FROM tab1, TAB2 WHERE tab1.col1 =
    tab2.col2\".
4.  [Temporary tables](#ODIORA017) are supported in OUTER
    specifications.

------------------------------------------------------------------------

[ODIORA007a - Database concepts]{#ODIORA007a}

Most of BDL applications use only one database entity (in the meaning of
INFORMIX). But the same BDL application can connect to different
occurrences of the same database schema, allowing several users to
connect to those different databases.

INFORMIX servers can handle multiple database entities, while ORACLE
servers manage only one database. ORACLE can manage multiple schemas,
but by default other users must give the owner name as prefix to the
table name:

      SELECT \* FROM **stores**.customer

**[*Solution:*]{.underline}**

In an ORACLE database, each user can manage his own database schema. You
can dedicate a database user to administer each occurrence of the
application database.

Starting with version 8.1.5, any user can select the current database
schema with the following SQL command:

      ALTER SESSION SET CURRENT_SCHEMA = \"\<schema\>\"

Using this instruction, any user can access the tables without giving
the owner prefix as long as the table owner has granted the privileges
to access the tables.

You can make the database interface select the current schema
automatically with the following fglprofile entry :

       dbi.database.\<dbname\>.schema = \"\<schname\>\"

When using multiple database schemas, it is recommended that you create
them in separated tablespaces to enable independent backups and keep
logical sets of tables together. The simplest way is to define a default
tablespace when creating the schema owner :

      CREATE USER \<user\> IDENTIFIED BY \<pswd\>\
             **DEFAULT TABLESPACE \<tabspacename\>**\
             TEMPORARY TABLESPACE \<tmptabspace\>

------------------------------------------------------------------------

[ODIORA008a - Data consistency and concurrency management]{#ODIORA008a}

**Data consistency** involves readers that want to access data currently
modified by writers and **concurrency data access** involves several
writers accessing the same data for modification. **Locking
granularity** defines the amount of data concerned when a lock is set
(row, page, table, \...).

[INFORMIX]{.underline}

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
- The default locking granularity is page.

[ORACLE]{.underline}

When data is modified, **exclusive locks** are set and held until the
end of the transaction. For data consistency, ORACLE uses a
**multi-version consistency model**: a copy of the original row is kept
for readers before performing writer modifications. Readers do not have
to wait for writers as in INFORMIX. The simplest way to think of
Oracle\'s implementation of read consistency is to imagine each user
accessing a private copy of the database, hence the multi-version
consistency model. The **lock wait mode** cannot be changed session wide
as in INFORMIX; the waiting behavior can be controlled with a SELECT FOR
UPDATE NOWAIT only. Locks are set at the **row level** in ORACLE, and
this cannot be changed.

Control :

- Lock wait mode (on SELECT only): SELECT \... FOR UPDATE NOWAIT
- Isolation level : SET TRANSACTION ISOLATION LEVEL TO \...
- Explicit exclusive lock : SELECT \... FOR UPDATE \[NOWAIT\]

Defaults :

- The default isolation level is Read Committed ( readers cannot see
  uncommitted data, no shared lock is set when reading data ).

The main difference between INFORMIX and ORACLE is that readers do not
have to wait for writers in ORACLE.

**[*Solution:*]{.underline}**

The SET ISOLATION TO \... INFORMIX syntax is replaced by ALTER SESSION
SET ISOLATION_LEVEL \... in Oracle. The next table shows the isolation
level mappings done by the database driver:

::: {align="center"}
  ----------------------------------- -----------------------------------
  **SET ISOLATION instruction in      **Native SQL command**
  program**                           

  SET ISOLATION TO DIRTY READ         ALTER SESSION SET ISOLATION_LEVEL =
                                      READ COMMITTED

  SET ISOLATION TO COMMITTED READ\    ALTER SESSION SET ISOLATION_LEVEL =
    \[READ COMMITTED\] \[RETAIN       READ COMMITTED
  UPDATE LOCKS\]                      

  SET ISOLATION TO CURSOR STABILITY   ALTER SESSION SET ISOLATION_LEVEL =
                                      READ COMMITTED

  SET ISOLATION TO REPEATABLE READ    ALTER SESSION SET ISOLATION_LEVEL =
                                      SERIALIZABLE
  ----------------------------------- -----------------------------------
:::

ORACLE does not provide a dirty read mode, the (session wide) lock wait
mode cannot be changed and the locking precision is always at the row
level. Based on this, it is recommended that you work with INFORMIX in
the read committed isolation level (default), make processes wait for
each other (lock mode wait), and use the default page-level locking
granularity.

See INFORMIX and ORACLE documentation for more details about data
consistency, concurrency and locking mechanisms.

------------------------------------------------------------------------

[ODIORA008b - SELECT FOR UPDATE]{#ODIORA008b}

A lot of BDL programs use pessimistic locking in order to prevent
several users editing the same rows at the same time.

  DECLARE cc CURSOR FOR\
     SELECT \... FOR UPDATE \[OF col-list\]\
  OPEN cc\
  FETCH cc \<\-- lock is acquired\
  CLOSE cc \<\-- lock is released

- The row must be fetched in order to set the lock.
- If the cursor is local to a transaction, the lock is released when the
  transaction ends.\
  If the cursor is declared \"WITH HOLD\", the lock is released when the
  cursor is closed.

ORACLE allows individual and exclusive row locking with :

  SELECT \... FOR UPDATE \[OF col-list\]

- A lock is acquired for each selected row when the cursor is opened,
  before the first fetch.
- Cursors using SELECT \... FOR UPDATE are automatically closed when the
  transaction ends;\
  **Warning :** Locks are **not** released **when a cursor is closed**.

ORACLE\'s locking granularity is at the row level.

To control the behavior of the program when locking rows, INFORMIX
provides a specific instruction to set the wait mode :

   SET LOCK MODE TO { WAIT \| NOT WAIT \| WAIT *seconds* }

The default mode is NOT WAIT. This as an INFORMIX specific SQL
statement.

In order to simulate the same behavior in ORACLE, your can use the
NOWAIT keyword in the SELECT \... FOR UPDATE statement, as follows:

    SELECT \... FOR UPDATE \[OF col-list\] **NOWAIT**

With this option, ORACLE immediately returns an SQL error if the row is
locked by another user.

**[*Solution:*]{.underline}**

**Warning:** The database interface is based on an emulation of an
INFORMIX engine using transaction logging. Therefore, opening a SELECT
\... FOR UPDATE cursor declared outside a transaction will raise an SQL
error -255 (not in transaction).

**Warning :** Cursors declared with SELECT \... FOR UPDATE using the
\"WITH HOLD\" clause cannot be supported with ORACLE. See
[ODIORA031](#ODIORA031) and [ODIORA032](#ODIORA032) for more details.

If your BDL application is using pessimistic locking with SELECT \...
FOR UPDATE, you must review the program logic to OPEN cursor and CLOSE
cursor statements inside transactions (BEGIN WORK + COMMIT WORK /
ROLLBACK WORK).

------------------------------------------------------------------------

[ODIORA009a - Transactions handling]{#ODIORA009a}

INFORMIX and ORACLE handle transactions differently. The differences in
the transactional models can affect the program logic.

INFORMIX native mode (non ANSI):

- DDL statements can be executed (and canceled) in transactions.
- Transactions must be started with BEGIN WORK. Statements executed
  outside of a transaction are automatically committed.

ORACLE :

- Beginnings of transactions are implicit; two transactions are
  delimited by COMMIT or ROLLBACK.
- The current transaction is automatically committed when a DDL
  statement is executed.

Transactions in stored procedures: avoid using transactions in stored
procedures to allow the client applications to handle transactions, in
accordance with the transaction model.

INFORMIX version 11.50 introduces savepoints with the following
instructions:

        SAVEPOINT name [UNIQUE]
        ROLLBACK [WORK] TO SAVEPOINT [name] ]
        RELEASE SAVEPOINT name

ORACLE supports savepoints too. However, there are differences:

1.  Savepoints cannot be declared as UNIQUE
2.  Rollback must always specify the savepoint name
3.  You cannot release savepoints (RELEASE SAVEPOINT)

**[*Solution:*]{.underline}**

Regarding transaction control instructions, BDL applications do not have
to be modified in order to work with ORACLE. The INFORMIX behavior is
simulated with an auto-commit mode in the ORACLE interface. A switch to
the explicit commit mode is done when a BEGIN WORK is performed by the
BDL program.

**Warning** : When executing a DDL statement inside a transaction,
ORACLE automatically commits the transaction. Therefore, you must
extract the DDL statements from transaction blocks.

**Warning:** If you want to use savepoints, do not use the UNIQUE
keyword in the savepoint declaration, always specify the savepoint name
in ROLLBACK TO SAVEPOINT, and do not drop savepoints with RELEASE
SAVEPOINT.

See also [ODIORA008b](#ODIORA008b)

------------------------------------------------------------------------

[ODIORA010 - Handling SQL errors when preparing statements]{#ODIORA010}

The ORACLE interface  is implemented with the ORACLE Call Interface
(OCI). This library does not provide a way to send SQL statements to the
database server during the BDL PREPARE instruction, as in the INFORMIX
interface. The statement is sent to the server only when opening the
cursors or when executing the statement.

Therefore, when preparing an SQL statement with the BDL PREPARE
instruction, no SQL errors can be returned if the statement has syntax
errors, or if a column or a table name does not exist in the database.
However, an SQL error will occur after the OPEN or EXECUTE instructions.

**[*Solution:*]{.underline}**

Make sure your BDL programs do not test the STATUS or SQLCA.SQLCODE
variable just after PREPARE instructions.

Change the program logic in order to handle the SQL errors when opening
the cursors (OPEN) or when executing SQL statements (EXECUTE).

------------------------------------------------------------------------

## [ODIORA041 - BOOLEAN data type]{#ODIORA041}

INFORMIX supports the BOOLEAN data type, which can store \'t\' or \'f\'
values. Genero BDL implements the BOOLEAN data type in a different way:
As in other programming languages, Genero BOOLEAN stores integer values
1 or 0 (for TRUE or FALSE). The type was designed this way to assign the
result of a Boolean expression to a BOOLEAN variable.

Oracle does not implement a native BOOLEAN type in SQL types, but have a
BOOLEAN type in PL/SQL.

**[*Solution:*]{.underline}**

The Oracle database interface converts BOOLEAN type to CHAR(1) columns
and stores \'1\' or \'0\' values in the column.

------------------------------------------------------------------------

[ODIORA011a - CHARACTER data types]{#ODIORA011a}

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

ORACLE provides the following types to store character strings:

- CHAR(N) with an upper limit of 2000 bytes
- VARCHAR2(N) with an upper limit of 4000 bytes
- NCHAR(N) with an upper limit of 2000 bytes
- VARCHAR2(N) with an upper limit of 4000 bytes

With ORACLE \[N\]CHAR(N)/\[N\]VARCHAR2(N) types, the size N can be
specified in character or byte units, according to length semantics
settings.

**Warning** : When comparing VARCHAR2 values in ORACLE, the trailing
blanks are significant; this is not the case when using INFORMIX
VARCHARs. But comparison with columns of type CHAR is similar to
INFORMIX. See blank-padded and non-padded comparison semantics in ORACLE
documentation.

::: {align="center"}
  --------------- --------------------- -------------------------
  **Data type**   **INFORMIX**          **ORACLE**
  CHAR            \'aaa  \' = \'aaa\'   \'aaa   \' = \'aaa\'
  VARCHAR         \'aaa  \' = \'aaa\'   \'aaa   \' \<\> \'aaa\'
  --------------- --------------------- -------------------------
:::

**Warning:** ORACLE treats empty strings like NULL values; INFORMIX
doesn\'t. See issue [ODIORA011c](#ODIORA011c) for more details.

With ORACLE, you can define a Database Character Set and a National
Character Set: ORACLE uses the Database Character Set to store string
data in the CHAR/VARCHAR2 columns, and uses the National Character Set
for NCHAR/NVARCHAR2 columns.

**[*Solution:*]{.underline}**

INFORMIX CHAR(N) types can be mapped to ORACLE CHAR(N) types, with N\<=
2000 bytes. INFORMIX VARCHAR(N) columns must be mapped to ORACLE
VARCHAR2(N), with N\<= 4000 bytes.

**Warning:** Check that your database schema does not use CHAR or
VARCHAR types with a length exceeding the ORACLE limits of
CHAR/VARCHAR2.

Since INFORMIX and Genero are using Byte Length Semantics for
CHAR/VARCHAR sizes, you should use also Byte Length Semantics when
defining ORACLE CHAR/VARCHAR2 columns. The size will be the same for
Genero program variables and ORACLE database columns. 

The ORACLE client character set must correspond to the Genero runtime
system locale (LANG/LC_ALL). You can define the ORACLE client character
set with the NLS_LANG environment variable.

See also the section about [Localization](Localization.html).

------------------------------------------------------------------------

[ODIORA011b - The LENGTH( ) function]{#ODIORA011b}

INFORMIX provides the LENGTH() function:

    SELECT LENGTH(\"aaa\"), LENGTH(col1) FROM table

Oracle has a equivalent function with the same name, but there is some
difference:

INFORMIX does not count the trailing blanks neither for CHAR not for
VARCHAR expressions, while Oracle counts the trailing blanks.

With the Oracle LENGTH function, when using a CHAR column, values are
always blank padded, so the function returns the size of the CHAR
column. When using a VAR CHAR column, trailing blanks are significant,
and the function returns the number of characters, including trailing
blanks.

The INFORMIX LENGTH() function returns 0 when the given string is empty.
That means, LENGTH(\'\') is 0.

Since ORACLE handles empty strings (\'\') as NULL values, writing
\"LENGTH(\'\')\" is equivalent to \"LENGTH(NULL)\". In this case, the
function returns NULL.

**[*Solution:*]{.underline}**

The ORACLE database interface cannot simulate the behavior of the
INFORMIX LENGTH() function.

You must check if the trailing blanks are significant when using the
LENGTH() function.

If you want to count the number of character by ignoring the trailing
blanks, you must use the RTRIM() function:

    SELECT LENGTH(RTRIM(col1)) FROM table

SQL conditions which verify that the result of LENGTH( ) is greater that
a given number do not have to be changed, because the expression
evaluates to false if the given string is empty (NULL\>n) :\
   SELECT \* FROM x WHERE **LENGTH(col)\>0**

Only SQL conditions that compare the result of LENGTH() to zero will not
work if the column is NULL. You must check your BDL code for such
conditions :\
   SELECT \* FROM x WHERE **LENGTH(col)=0**\
\
In this case, you must add a test to verify if the column is null:\
   SELECT \* FROM x WHERE **( LENGTH(col)=0 OR col IS NULL )**

In addition, when retrieving the result of a LENGTH( ) expression into a
BDL variable, you must check that the variable is not NULL.

In ORACLE, you can use the NVL( ) function in order to get a non-null
value :\
      SELECT \* FROM x WHERE **NVL(LENGTH(c),0)**=0\
\
INFORMIX Dynamic Server 7.30 supports the NVL() function, as in ORACLE.
So you can write the same SQL for both INFORMIX 7.30 and ORACLE 8, as
shown in the above example.

If the INFORMIX version supports stored procedures, you can create the
following stored procedure in the INFORMIX database in order to use NVL(
) expressions :

   create procedure nvl( val char(512), def char(512) )\
          returning char(512);\
      if val is null then\
         return def;\
      else\
         return val;\
      end if;\
   end procedure;

With this stored procedure, you can write NVL( ) expressions like
**NVL(LENGTH(c),0)**. This should work in almost all cases and provides
upward compatibility with INFORMIX Dynamic Server 7.30.

------------------------------------------------------------------------

[ODIORA011c - Empty character strings]{#ODIORA011c}

INFORMIX SQL and ORACLE SQL handle empty quoted strings differently.
ORACLE SQL does not distinguish between \'\' and NULL, while INFORMIX
SQL treats\'\' ( or  \"\" ) as a string with a length of zero.

**Warning:** Using literal string values which are empty (\'\' ) for
INSERT or UPDATE statements will result in the storage of NULLs with
ORACLE, while INFORMIX would store the value as a string with a length
of zero:

> insert into tab1 ( col1, col2 ) values ( NULL, \'\' )

**Warning:** Using the comparison expression (col=\'\') with ORACLE has
no meaning because an empty string is equivalent to NULL;  (col=NULL)
expressions will always evaluate to FALSE because this is not a correct
expression: The expression should be ( col IS NULL).

> select \* from tab1 where col2 IS NULL

In INFORMIX 4GL, when setting a variable with an empty string constant,
it is automatically set to a NULL value. When using one or more space
characters, the value is set to one space character:

> define x char(10)\
> let x = \"\"\
> if x is null then [\-- evaluates to TRUE]{.small}\
> let x = \"    \"\
> if x = \" \" then   [\-- evaluates to TRUE]{.small}

***[Solution:]{.underline}***

The ORACLE database interface cannot automatically convert comparison
expressions like (col=\"\") to ( col IS NULL) because this would require
an SQL grammar parser. The interface could convert expressions like (
col=\"\"), but it would do this for the whole SQL statement:

> UPDATE tab1 SET col1 = \"\" WHERE col2 = \"\"

Would be converted to an incorrect SQL statement:

> UPDATE tab1 SET col1 IS NULL WHERE col2 IS NULL

To increase portability, you should avoid the usage of literal string
values with a length of zero in SQL statements; this would resolve
storage and Boolean expressions evaluation differences between INFORMIX
and ORACLE.

NULL or program variables can be used instead. Program variables set
with empty strings (let x=\"\") are automatically converted to NULL by
BDL and therefore are stored as NULL when using both INFORMIX or ORACLE
databases.

------------------------------------------------------------------------

[ODIORA012 - Constraints]{#ODIORA012}

**Constraint naming syntax:**

Both INFORMIX and ORACLE support primary key, unique, foreign key,
default and check constraints, but the constraint naming syntax is
different : ORACLE expects the \"CONSTRAINT\" keyword **before** the
constraint specification and INFORMIX expects it **after**.

**UNIQUE constraint example:**

::: {align="left"}
  ----------------------------------- -----------------------------------
  **INFORMIX**                        **ORACLE**

  CREATE TABLE scott.emp (\           CREATE TABLE scott.emp (\
  \...\                               \...\
  empcode CHAR(10) UNIQUE\            empcode CHAR(10)\
     **\[CONSTRAINT pk_emp\]**,\         **\[CONSTRAINT pk_emp\]**
  \...                                UNIQUE,\
                                      \...
  ----------------------------------- -----------------------------------
:::

**Primary keys:**

Like INFORMIX, ORACLE creates an index to enforce PRIMARY KEY
constraints (some RDBMS do not create indexes for constraints).  Using
\"CREATE UNIQUE INDEX\"  to define unique constraints is obsolete (use
primary keys or a secondary key instead).

**Unique constraints:**

Like INFORMIX, ORACLE creates an index to enforce UNIQUE constraints
(some RDBMS do not create indexes for constraints).

**Warning:** When using a unique constraint, INFORMIX allows only one
row with a NULL value, while ORACLE allows several rows with NULL! Using
CREATE UNIQUE INDEX is obsolete.

**Foreign keys:**

Both INFORMIX and ORACLE support the ON DELETE CASCADE option. To defer
constraint checking, INFORMIX provides the SET CONSTRAINT command while
ORACLE provides the ENABLE and DISABLE clauses.

**Check constraints:**

**Warning:** The check condition may be any valid expression that can be
evaluated to TRUE or FALSE, including functions and literals. You must
verify that the expression is not INFORMIX specific.

**Null constraints:**

INFORMIX and ORACLE support not null constraints, but INFORMIX does not
allow you to give a name to \"NOT NULL\" constraints.

**[*Solution:*]{.underline}**

**Constraint naming syntax:**

The database interface does not convert constraint naming expressions
when creating tables from BDL programs. Review the database creation
scripts to adapt the constraint naming clauses for ORACLE.

------------------------------------------------------------------------

[ODIORA013 - Triggers]{#ODIORA013}

INFORMIX and ORACLE provide triggers with similar features, but the
trigger creation syntax and the programming languages are totally
different.

INFORMIX triggers define the stored procedures to be called when a
database event occurs (before \| after  insert \| update \| delete
\...), while ORACLE triggers can hold a procedural block.

In ORACLE, triggers can be created with \'CREATE OR REPLACE\' to keep
privileges settings. With INFORMIX, you must drop and create again.

ORACLE V8 provides an \'INSTEAD OF\' option to completely replace the
INSERT, UPDATE or DELETE statement. This is provided to implement
complex storage operations, for example on views that are usually
read-only ( you can attach triggers to views ).

**Warning:** ORACLE allows you to create multiple triggers on the same
table for the same trigger event, but it does not guarantee the
execution order.

**[*Solution:*]{.underline}**

INFORMIX triggers must be converted to ORACLE triggers \"by hand\".

------------------------------------------------------------------------

[ODIORA014 - Stored procedures]{#ODIORA014}

Both INFORMIX and ORACLE support stored procedures, but the programming
languages are totally different : **SPL** for INFORMIX versus **PL/SQL**
for ORACLE.

In Oracle, stored procedures and functions can be implemented in
packages (similar to BDL modules). This is a powerful feature which
enables structured procedural programming in the database. ORACLE itself
implements system tools with packages (dbms_sql, dbms_output,
dbms_lock). Procedures, functions and packages can be created with
\'CREATE OR REPLACE\' to keep privileges settings.\
With INFORMIX, you must drop and create again.

**Warning:** ORACLE uses a different privilege context when using
dynamic SQL in PL/SQL; roles are not effective. Users must have direct
privileges settings in order to perform DDL or DML operations inside
dynamic SQL.

**[*Solution:*]{.underline}**

INFORMIX stored procedures must be converted to ORACLE \"by hand\".

Try to use ORACLE packages in order to group stored procedures into
modules.

------------------------------------------------------------------------

[ODIORA016a - Defining database users]{#ODIORA016a}

INFORMIX users are defined at the operating system level, they must be
members of the \'informix\' group, and the database administrator must
grant CONNECT, RESOURCE or DBA privileges to those users.

ORACLE users must be createed in the database with a CREATE USER
command. Oracle supports different sort of user authentications.\
Following command defines a user authenticated by the database server
(must give username and password to connect):\
   CREATE USER \<username\> IDENTIFIED **BY \<pswd\>**\
Users defined at the operating system level can be declared as ORACLE
users with the \"IDENTIFIED EXTERNALLY\" clause :\
   CREATE USER OPS\$\<username\> IDENTIFIED **EXTERNALLY**\
In this case, ORACLE trusts the operating system, and users can connect
to the database without giving any user name and password.

**Warning:** By default, database users authenticated by the operating
systems have a name with the \"OPS\$\" prefix. The \'OPS\$\' prefix can
be changed with the OS_AUTHENT_PREFIX server parameter. You can set this
parameter to blank (\"\") in order to use the same user names in the
system and in the ORACLE database. See ORACLE documentation ( \"Server
Administrators Guide\", \"User authentication\" ) for more details.

**Warning:** When creating a user with OS authentication, the user name
in the database must be in uppercase letters, even if the OS user name
is lowercase.

**Warning:** For Windows NT operating system authentication to work, the
SQLNET.AUTHENTICATION_SERVICES parameter must be set as follows in
%ORACLE_HOME%\\NETWORK\\ADMIN\\SQLNET.ORA :\
\
       SQLNET.AUTHENTICATION_SERVICES = (NTS)

**[*Solution:*]{.underline}**

Based on the application logic (is it a multi-user application ?), you
must create one or several ORACLE users. As INFORMIX users are operating
system users, we recommend that you use the OS authentication services
offered by ORACLE.

------------------------------------------------------------------------

[ODIORA016b - Setting privileges]{#ODIORA016b}

INFORMIX and ORACLE user privileges management are quite similar.

ORACLE provides roles to group privileges which then can be assigned to
users. Starting with version 7.20, INFORMIX provides roles too. But
users must execute the SET ROLE statement in order to enable a role.
ORACLE users do not have to explicitly set a role, they are assigned to
a default privilege domain (set of roles). More than one role can be
enabled at a time with ORACLE.

INFORMIX users must have at least the CONNECT privilege to access the
database:\
    GRANT **CONNECT** TO (PUBLIC\|user)

ORACLE users must have at least the CREATE SESSION privilege to access
the database. This privilege is part of the CONNECT role.\
    GRANT **CONNECT** TO (PUBLIC\|user)

**Warning:** INFORMIX database privileges do NOT correspond exactly to
ORACLE CONNECT, RESOURCE and DBA roles. However, roles can be created
with equivalent privileges.

***[Solution:]{.underline}***

Create a role which groups INFORMIX CONNECT privileges, and assign this
role to the application users :

> CREATE ROLE ifx_connect IDENTIFIED BY oracle;
>     GRANT CREATE SESSION, ALTER SESSION, CREATE ANY VIEW, ... TO ifx_connect;
>     GRANT ifx_connect TO user1;

------------------------------------------------------------------------

[ODIORA017 - Temporary tables]{#ODIORA017}

INFORMIX temporary tables are created through the **CREATE TEMP TABLE**
DDL instruction or through a **SELECT \... INTO TEMP** statement.
Temporary tables are automatically dropped when the SQL session ends,
but they can also be dropped with the DROP TABLE command. There is no
name conflict when several users create temporary tables with the same
name.

Remark: BDL reports create a temporary table when the rows are not
sorted externally (by the source SQL statement).

INFORMIX allows you to create indexes on temporary tables. No name
conflict occurs when several users create an index on a temporary table
by using the same index identifier.

ORACLE does not support temporary tables as INFORMIX does. ORACLE 8.1
provides GLOBAL TEMPORARY TABLEs which are shared among processes (only
data is temporary and local to a SQL process). INFORMIX does not shared
temp tables among SQL processes; each process can create its own temp
table without table name conflicts.

***[Solution:]{.underline}***

In accordance with some prerequisites, temporary tables creation in BDL
programs can be supported by the database interface.

The temporary table emulation can use regular tables or GLOBAL TEMPORARY
tables. The way the driver converts INFORMIX temp table statements to
Oracle regular tables or global temporary tables is driven by the
following FGLPROFILE entry:

dbi.database.\<dbname\>.ifxemul.temptables.emulation = { \"default\" \|
\"global\" }

By default, the database driver uses regular tables (*default*
emulation). This default emulation provides maximum compatibility with
INFORMIX temporary tables, but requires real table creation which can be
a significant overhead with Oracle. The *global* emulation uses native
Oracle Global Temporary Tables, requiring only one initial table
creation and thus making programs run faster. However, the *global*
emulation mode has to be used carefully because of some limitations and
constraints.

**Warning:** When creating a temporary table, you perform a Data
Definition Language statement. Oracle automatically commits the current
transaction when executing a DDL statement. Therefore, you must avoid
temp table creation/destruction in transactions.

### Using the *default* temporary table emulation

**How does the *default* emulation work?**

- INFORMIX CREATE TEMP TABLE and SELECT INTO TEMP statements are
  automatically converted to ORACLE \"CREATE TABLE\". The name of the
  temporary table is converted to a unique table name.\
- Tables are created in the current schema.\
- Temporary tables are created with the option TABLESPACE TEMPTABS so
  that data is stored in a dedicated tablespace named \"**TEMPTABS**\".
  Of course the TEMPTABS tablespace must exist before running programs,
  otherwise temporary table creation will fail. You create a tablespace
  with the CREATE TABLESPACE SQL command. Using a specific tablespace
  for temporary tables allows you to specify storage options, for
  example to use a physical device which can be different from the disk
  drive used for real data storage. Additionally, backups of permanent
  application tables can be performed without the data of temporary
  tables.\
- Starting with Oracle 10g, dropped tables are saved in the recycle bin
  by default. You may want to avoid the recycle bin feature at the
  database level or session level with:\
    ALTER SYSTEM SET recyclebin = OFF scope=both\
  or:\
    ALTER SESSION SET recyclebin = OFF\
- Once the temporary table has been created, all other SQL statements
  performed in the current SQL session are parsed to convert the
  original table name to the corresponding unique table name.\
- When the BDL program disconnects from the database (for example, when
  it ends or when a CLOSE DATABASE instruction is executed), the tables
  which have not been removed with an explicit \"DROP TABLE\" are
  automatically removed by the database interface. However, if the
  program crashes, the tables will remain in the database, so you may
  need to cleanup the database from time to time.

**Prerequisites when using the *default* emulation:**

- Application users must have sufficient **privileges** to create
  database tables in their own schema (usually, \"CONNECT\" and
  \"RESOURCE\" roles).\
- When using the default emulation based on permanent tables, you must
  create a dedicated tablespace named \"**TEMPTABS**\".\
  **Warning:** The TEMPTABS tablespace must be of type
  \"**permanent**\", as it will hold permanent tables used to emulate
  INFORMIX temp tables.\
  Make sure it is big enough to hold all the data, and check for
  automatic extension.\
  For more details, see \"CREATE TABLESPACE\" in the Oracle
  documentation.

**Limitations of the *default* emulation:**

- **Warning:** When using the default emulation, the real name of an
  emulated temporary table will get the following format:\
           tt\<number\>\_\<original_name\>\
  Where \<number\> is the Oracle AUDSID session id returned by:\
     SELECT USERENV(\'SESSIONID\') FROM DUAL\
  As Oracle 9i and 10g table names can\'t exceed 30 characters in
  length, and since session ids are persistent over server shutdown, you
  must pay attention to the names of your temporary tables. For example,
  if you create a temp table with the name TEMP_CUSTOMER_INVOICES (22c)
  it leaves 30 - (3 + 22) = 5 characters left for the session id, which
  gives a limit of 99999 sessions.\
  To workaround this limitation, you can provide your own SQL command to
  generate a unique session id with the following FGLPROFILE entry:\
  **  dbi.database.\<dbname\>.ora.sid.command = \"select \...\"**\
  As an example, you can use the SID column value from V\$SESSION:\
    SELECT SID FROM V\$SESSION WHERE AUDSID = USERENV(\'SESSIONID\')\
- You are not allowed to use the unique table name format in your own
  database schema. Make sure you are not using table or column names
  with the following format:\
           tt\<number\>\_\<original_name\>\
- Tokens matching the original table names are converted to unique names
  in all SQL statements. Make sure you are not using the temp table name
  for other database objects, like columns. The following example
  illustrates this limitation :\
    CREATE TABLE tab1 ( key INTEGER, **tmp1** CHAR(20) )\
    CREATE TEMP TABLE **tmp1** ( col1 INTEGER, col2 CHAR(20) )\
    SELECT **tmp1** FROM tab1 WHERE \...

**Maintenance of *default* emulation:**

- If you want to list the tables created by specific user, do the
  following:\
    SELECT \* FROM ALL_TABLES WHERE OWNER = \'\<user_name\>\'\
  Remark: as with other database object names, the user name is stored
  in uppercase letters if it has been created without using double
  quotes ( create user scott \... = stored name is \"SCOTT\" ).

**Creating indexes on temporary tables with *default* emulation:**

- Indexes created on temporary tables must have unique names too. The
  database interface detects CREATE INDEX statements which are using
  temporary tables and converts the index name to unique names.

<!-- -->

- DROP INDEX statements are also detected to replace the original index
  name by the real name.

**SERIALs in temporary table creation with *default* emulation:**

- You can use the SERIAL data type when creating a temporary table.\
  Sequences and triggers will be created in the current schema.\
  See issue about [SERIALs](#ODIORA005) for more details.

### Using the *global* temporary table emulation

**Warning:** The *global* temporary table emulation is provided to get
benefit of the Oracle GLOBAL TEMPORARY TABLES, by sharing the same table
structure with multiple SQL sessions, reducing the cost of the CREATE
TABLE statement execution. However, this emulation does not provide the
same level of INFORMIX compatibility as the *default* emulation, and
must be used carefully. See below for more details about the limitations
and constraints.

**How does the *global* emulation work?**

- INFORMIX CREATE TEMP TABLE and SELECT INTO TEMP statements are
  automatically converted to ORACLE \"CREATE GLOBAL TEMPORARY TABLE\".
  The original table name is kept, but it gets a \"**TEMPTABS**\" schema
  prefix, to share the underlying table structure with other database
  users.\
- The Global Temporary Tables are created with the \"ON COMMIT PRESERVE
  ROWS\" option, to keep the rows in the table when a transaction ends.\
- The Global Temporary Tables are created in a specific schema called
  \"**TEMPTABS**\". If the table exists already, error ORA-00955 will
  just be ignored by the database driver. This allows to do several
  CREATE TEMP TABLE statements in your programs with no SQL error, to
  emulate the INFORMIX behavior. This works fine as long as the table
  name is unique for a given structure (column count and data types must
  match).\
- Once the Global Temporary Table has been created, all other SQL
  statements performed in the current SQL session are parsed to convert
  the original table name to TEMPTABS.*original-tablename*.\
- When doing a DROP TABLE *temp-table* statement in the program, the
  database driver converts it to a DELETE statement, to remove all data
  added by the current session. A next CREATE TEMP TABLE or SELECT INTO
  TEMP will fail with error ORA-00955 but since this error is ignored,
  it will be transparent for the program. Note that we can\'t use
  TRUNCATE TABLE because that would required at least DROP ANY TABLE
  privileges for all users.\
- When the BDL program disconnects from the database (for example, when
  it ends or when a CLOSE DATABASE instruction is executed), the tables
  which have not been dropped by the program with an explicit DROP TABLE
  statement will be automatically cleaned by Oracle.

**Prerequisites when using the *global* emulation:**

- You must create a database user (schema) dedicated to this emulation,
  with the name \"**TEMPTABS**\".\
- All database users must have sufficient privileges to use Global
  Temporary Tables in the **TEMPTABS** schema: If you want programs to
  create Global Temporary Table on the fly, you must grant a CREATE ANY
  TABLE + CREATE ANY INDEX system privilege to all users. But this means
  that all users will be able to create/drop tables in any schema (Here
  Oracle (10g) is missing some fine-grained system privilege to
  create/drop tables in a particular schema). You better \"prepare\" the
  database by creating the Global Temporary Table with the TEMPTABS user
  (do not forget to specify ON COMMIT PRESERVE ROWS option), and give
  INSERT, UPDATE, DELETE and SELECT object privileges to PUBLIC, for
  example:\
    CREATE GLOBAL TEMPORARY TABLE temptabs.mytable\
          ( k INT PRIMARY KEY, c CHAR(10) ) ON COMMIT PRESERVE ROWS;\
    CREATE UNIQUE INDEX temptabs.ix1 ON temptabs.mytable ( C )\
    GRANT SELECT, UPDATE, INSERT, DELETE ON temptabs.mytable TO PUBLIC;

**Limitations of the *global* emulation:**

- **Warning:** Global Temporary Tables are shared by multiple
  users/sessions. In order to have the *global* emulation working
  properly with your application, each temporary table name must be
  unique for a given table structure, for all programs. You must for
  example avoid to use generic names such as **tmp1**. It is recommended
  to use table names as follows: \
    CREATE TEMP TABLE custinfo_1 ( cust_id INTEGER, cust_name
  VARCHAR(50) )\
    CREATE TEMP TABLE custinfo_2 ( cust_id INTEGER, cust_name
  VARCHAR(50), cust_addr VARCHAR(200) )\
- Tokens matching the original table names are converted to unique names
  in all SQL statements. Make sure you are not using the temp table name
  for other database objects, like columns. The following example
  illustrates this limitation :\
    CREATE TABLE tab1 ( key INTEGER, **tmp1** CHAR(20) )\
    CREATE TEMP TABLE **tmp1** ( col1 INTEGER, col2 CHAR(20) )\
    SELECT **tmp1** FROM tab1 WHERE \...

**Creating indexes on temporary tables with *global* emulation:**

- Indexes created on temporary tables get also the **TEMPTABS** schema
  prefix.\
- When executing a DROP INDEX statement on a temporary table in a
  program, the database driver just ignores the statement.

**SERIALs in temporary table creation with *global* emulation :**

- You can use the SERIAL data type when creating a temporary table.\
  Sequences and triggers will be created in the **TEMPTABS** schema
  too.\
  See issue about [SERIALs](#ODIORA005) for more details.

------------------------------------------------------------------------

[ODIORA018 - Substrings in SQL]{#ODIORA018}

INFORMIX SQL statements can use subscripts on columns defined with the
character data type :\
    SELECT \... FROM tab1 WHERE **col1\[2,3\]** = \'RO\'\
    SELECT \... FROM tab1 WHERE **col1\[10\]**  = \'R\'   \-- Same as
col1\[10,10\]\
    UPDATE tab1 SET **col1\[2,3\]** = \'RO\' WHERE \...\
    SELECT \... FROM tab1 ORDER BY **col1\[1,3\]**

.. while ORACLE provides the SUBSTR( ) function, to extract a sub-string
from a string expression :\
    SELECT \.... FROM tab1 WHERE **SUBSTR(col1,2,2)** = \'RO\'\
    SELECT **SUBSTR(\'Some text\',6,3)** FROM DUAL       \-- Gives
\'tex\'

**[*Solution:*]{.underline}**

You must replace all INFORMIX col\[x,y\] expressions by
SUBSTR(col,x,y-x+1).

**Warning:** In UPDATE instructions, setting column values through
subscripts will produce an error with ORACLE :\
    UPDATE tab1 SET **col1\[2,3\]** = \'RO\' WHERE \...\
is converted to:\
    UPDATE tab1 SET **SUBSTR(col1,2,3-2+1)** = \'RO\' WHERE \...

------------------------------------------------------------------------

[ODIORA019 - Name resolution of SQL objects]{#ODIORA019}

INFORMIX uses the following form to identify an SQL object:\
  \[database\[@dbservername\]:\]\[{owner\|\"owner\"}.\]identifier

The ANSI convention is to use double quotes for identifier delimiters
(For example : \"tabname\".\"colname\").

**Warning:** When using double-quoted identifiers, both INFORMIX and
ORACLE become case sensitive. Unlike INFORMIX, ORACLE database object
names are stored in UPPERCASE in system catalogs. That means that SELECT
\"col1\" FROM \"tab1\" will produce an error because those objects are
identified by \"COL1\" and \"TAB1\" in ORACLE system catalogs.

Remark: in INFORMIX ANSI compliant databases:

- The table name must include \"owner\", unless the connected user is
  the owner of the database object.
- The database server shifts the owner name to uppercase letters before
  the statement executes, unless the owner name is enclosed in double
  quotes.

With ORACLE, an object name takes the following form:\
  
\[(schema\|\"schema\").\](identifier\|\"identifier\")\[@database-link\]

Remark: ORACLE has separate namespaces for different classes of objects
(tables, views, triggers, indexes, clusters).

Object names are limited to 30 chars in ORACLE.

An ORACLE database schema is owned by a user (usually, the application
administrator) and this user must create PUBLIC SYNONYMS to provide a
global scope for his table names. PUBLIC SYNONYMS can have the same name
as the schema objects they point to.

**[*Solution:*]{.underline}**

Check that you do not use singl-quoted or double-quoted table names or
column names in your source. Those quotes must be removed because the
database interface automatically converts double quotes to single
quotes, and ORACLE does not allow single quotes as database object name
delimiters.

See also issue [ODIORA007a](#ODIORA007a)

------------------------------------------------------------------------

[ODIORA020 - String delimiters and object names]{#ODIORA020}

The ANSI string delimiter character is the single quote ( \'string\').
Double quotes are used to delimit database object names
(\"object-name\").

[Example]{.underline}: WHERE \"tabname\".\"colname\" = \'a string
value\'

INFORMIX allows double quotes as string delimiters, but ORACLE doesn\'t.
This is important, since many BDL programs use that character to delimit
the strings in SQL commands.

Remark: this problem concerns only double quotes within SQL statements.
Double quotes used in pure BDL string expressions are not subject to SQL
compatibility problems.

***[Solution:]{.underline}***

The ORACLE database interface can automatically replace all double
quotes by single quotes.

Escaped string delimiters can be used inside strings like the following
:

     \'This is a single quote : \'\'\'\
     \'This is a single quote : \\\'\'\
     \"This is a double quote : \"\"\"\
     \"This is a double quote : \\\"\"

**Warning:** Database object names cannot be delimited by double quotes
because the database interface cannot determine the difference between a
database object name and a quoted string !

For example, if the program executes the SQL statement:\
    WHERE \"tabname\".\"colname\" = \"a string value\"\
replacing all double quotes by single quotes would produce :\
    WHERE \'tabname\'.\'colname\' = \'a string value\'\
This would produce an error since \'tabname\'.\'colname\' is not allowed
by ORACLE.

Although double quotes are replaced automatically in SQL statements, you
should use only single quotes to enforce portability.

------------------------------------------------------------------------

[ODIORA021 - NUMERIC data types]{#ODIORA021}

INFORMIX supports several data types to store numbers:

::: {align="center"}
  ------------------------ --------------------------------------------
  **INFORMIX data type**   **Description**
  SMALLINT                 16 bit signed integer
  INT/INTEGER              32 bit signed integer
  BIGINT                   64 bit signed integer
  INT8                     64 bit signed integer (replaced by BIGINT)
  DEC/DECIMAL(p)           Floating-point decimal number
  DEC/DECIMAL(p,s)         Fixed-point decimal number
  MONEY                    Equivalent to DECIMAL(16,2)
  MONEY(p)                 Equivalent to DECIMAL(p,2)
  MONEY(p,s)               Equivalent to DECIMAL(p,s)
  REAL/SMALLFLOAT          approx floating point (C float)
  DOUBLE PREC./FLOAT       approx floating point (C double)
  ------------------------ --------------------------------------------
:::

ORACLE supports only one data type to store numbers:

::: {align="center"}
  ------------------------------------------------------ ---------------------------------------------------------------------------------
  **ORACLE data type**                                   **Description**
  NUMBER(p,s)   [(1\<=p\<= 38, -84\<=s\<=127)]{.small}   Fixed point decimal numbers.
  NUMBER(p)   [(1\<=p\<= 38)]{.small}                    Integer numbers with a precision of p.
  NUMBER                                                 Floating point decimals with a precision of 38 digits.
  FLOAT(b)   [(1\<=b\<= 126)]{.small}                    Floating point numbers with a binary precision b. This is a sub-type of NUMBER.
  BINARY_FLOAT   [(since Oracle 10g)]{.small}            32-bit floating point number.
  BINARY_DOUBLE   [(since Oracle 10g)]{.small}           64-bit floating point number.
  ------------------------------------------------------ ---------------------------------------------------------------------------------
:::

**Warning:** ANSI types like SMALLINT, INTEGER are supported by ORACLE
but will be converted to the native NUMBER type.

**Warning:** When dividing INTEGERs or SMALLINTs, INFORMIX rounds the
result ( 7 / 2 = 3 ), while ORACLE doesn\'t, because it does not have a
native integer data type ( 7 / 2 = 3.5 )

**[*Solution:*]{.underline}**

We recommend that you use the following conversion rules:

::: {align="center"}
  ----------------------------- ----------------------------------- ----------------------------------
  **INFORMIX data type**        **ORACLE data type (before 10g)**   **ORACLE data type (since 10g)**
  DECIMAL(p,s), MONEY(p,s)      NUMBER(p,s)                         NUMBER(p,s)
  DECIMAL(p)                    FLOAT(p \* 3.32193)                 FLOAT(p \* 3.32193)
  DECIMAL *(not recommended)*   FLOAT                               FLOAT
  SMALLINT                      NUMBER(5,0)                         NUMBER(5,0)
  INTEGER                       NUMBER(10,0)                        NUMBER(10,0)
  BIGINT                        NUMBER(20,0)                        NUMBER(20,0)
  INT8                          NUMBER(20,0)                        NUMBER(20,0)
  SMALLFLOAT                    **NUMBER**                          **BINARY_FLOAT**
  FLOAT\[(p)\]                  **NUMBER**                          **BINARY_DOUBLE**
  ----------------------------- ----------------------------------- ----------------------------------
:::

Avoid dividing integers in SQL statements. If you do divide an integer,
use the TRUNC() function with ORACLE.

**Warning:** When creating a table directly in sqlplus, using ANSI data
types INTEGER, SMALLINT, you do actually create columns with the native
NUMBER type, which has a precision of 38 digits. The NUMBER type cannot
be supported by Genero BDL because there is no equivalent type (DECIMAL
precision limit is 32 digits, not 38). The same problem exists when
using SMALLFLOAT or FLOAT Informix types 4gl in programs doing CREATE
TABLE with Oracle versions older than 10g: These Informix types are
mapped to NUMBER and cannot be used in 4gl or extracted by
[fgldbsch](DatabaseSchema.html) (The native Oracle FLOAT(b) type could
have been used, but this type is reserved to map DECIMAL(p) Informix
types). Starting with Oracle 10g, you can use SMALLFLOAT or FLOAT, these
will respectively be converted to BINARY_DOUBLE and BINARY_FLOAT native
Oracle types.

**Warning:** Mote that when creating a table in a BDL program with
DECIMAL (without precision) or with SMALLFLOAT/FLOAT types (if Oracle
version is older as 10g), the SQL translator will respectively convert
these types to native Oracle FLOAT and NUMBER types, but these types
have a higher precision as the Informix / BDL DECIMAL type, thus the
[fgldbsch schema extractor](DatabaseSchema.html) will fail to extract
such columns. Anyway, as a general recommendation, you should not use
such floating point numeric types in business applications.

------------------------------------------------------------------------

[ODIORA022 - Getting one row with SELECT]{#ODIORA022}

With INFORMIX, you must use the system table with a condition on the
table id :

   SELECT user FROM systables **WHERE tabid=1**

Oracle provides the **DUAL** table to generate one row only.

   SELECT user FROM **DUAL**

**[*Solution:*]{.underline}**

Check the BDL sources for \"FROM systables WHERE tabid=1\" and use
dynamic SQL to resolve this problem.

------------------------------------------------------------------------

[ODIORA024 - MATCHES and LIKE in SQL conditions]{#ODIORA024}

INFORMIX supports MATCHES and LIKE in SQL statements, while ORACLE
supports the LIKE statement only.

MATCHES allows you to use brackets to specify a set of matching
characters at a given position :\
   ( col MATCHES \'\[Pp\]aris\' ).\
   ( col MATCHES \'\[0-9\]\[a-z\]\*\' ).\
In this case, the LIKE statement has no equivalent feature.

The following substitutions must be done to convert a MATCHES condition
to a LIKE condition:

- MATCHES keyword must be replaced by LIKE.
- All \'\*\' characters must be replaced by \'%\'.
- All \'?\' characters must be replaced by \'\_\'.
- Remove all brackets expressions.

***[Solution:]{.underline}***

**Warning:** SQL statements using MATCHES expressions must be reviewed
in order to use LIKE expressions.

ORACLE provides the TRANSLATE function which can be used to replace
MATCHES in specific cases. The TRANSLATE function replaces all
occurrences of characters listed in a \'*from*\' set, with the
corresponding character defined in a \'*to*\' set.\
**INFORMIX** : WHERE col MATCHES \'\[0-9\]\[0-9\]\[0-9\]\'\
**ORACLE**   : WHERE
TRANSLATE(col,\'0123456789\',\'9999999999\')=\'999\'

See also: [MATCHES operator in SQL
Programming](SqlProgramming.html#PORT_MATCHES).

------------------------------------------------------------------------

[ODIORA025 - INFORMIX specific SQL statements in BDL]{#ODIORA025}

The BDL compiler supports several INFORMIX specific SQL statements that
have no meaning when using ORACLE:

deleted the next sentence as not necessary

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

[ODIORA028 - INSERT cursors]{#ODIORA028}

INFORMIX supports insert cursors. An \"insert cursor\" is a special BDL
cursor declared with an INSERT statement instead of a SELECT statement.
When this kind of cursor is open, you can use the PUT instruction to add
rows and the FLUSH instruction to insert the records into the database.

For INFORMIX database with transactions, OPEN, PUT and FLUSH
instructions must be executed within a transaction.

ORACLE does not support insert cursors.

**[*Solution:*]{.underline}**

Insert cursors are emulated by the ORACLE database interface.

------------------------------------------------------------------------

[ODIORA029 - SQL functions and constants]{#ODIORA029}

Almost all INFORMIX functions and SQL constants have a different name or
behavior in ORACLE.

Here is a comparison list of functions and constants:

::: {align="center"}
  ----------------------------------- -----------------------------------
  **INFORMIX**                        **ORACLE**

  today                               trunc( sysdate )

  current year to second              sysdate

  day( value )                        to_number( to_char( value, \'dd\' )
                                      )

  extend( dtvalue, first to last )    to_date( nvl( to_char( dtvalue,
                                      \'fmt-mask\' ), \'19000101000000\'
                                      ), \'fmt-mask\' )

  mdy(m,d,y)                          to_date( to_char(m,\'09\') \|\|
                                      to_char(d,\'09\') \|\|\
                                            to_char(y,\'0009\'),
                                      \'MMDDYYYY\' )

  month( date )                       to_number( to_char( date, \'mm\' )
                                      )

  weekday( date )                     to_number( to_char( date, \'d\' ) )
                                      -1

  year( date )                        to_number( to_char( date, \'yyyy\'
                                      ) )

  date( \"string\" \| integer )       No equivalent - Depends from DBDATE
                                      in IFX

  user                                user *! Uppercase/lowercase: See*
                                      [ODIORA047](#ODIORA047)

  trim( \[leading \| trailing \| both ltrim( ) and rtrim( )
  \"char\" FROM\] \"string\")         

  length( c )                         length( c ) *! Different behavior:
                                      See* [ODIORA011b](#ODIORA011b)

  pow(x,y)                            power(x,y)
  ----------------------------------- -----------------------------------
:::

**[*Solution:*]{.underline}**

**Warning:** You must review the SQL statements using TODAY / CURRENT /
EXTEND expressions.

You can define stored functions in the ORACLE database, to simulate
INFORMIX functions. This works only for functions that are not already
implemented by ORACLE:

  create or replace function month( adate in date )\
  return number\
  is\
    v_month number;\
  begin\
    v_month := to_number( to_char( adate, \'mm\' ) );\
    return (v_month);\
  end month;

------------------------------------------------------------------------

[ODIORA030 - Very large data types]{#ODIORA030}

INFORMIX uses the TEXT and BYTE data types to store very large texts or
images. ORACLE 8 provides CLOB, BLOB, and BFILE data types. Columns of
these types store a kind of pointer ( lob locator ). This technique
allows you to use more than one CLOB / BLOB / BFILE column per a table.

**[*Solution:*]{.underline}**

The ORACLE database interface can convert BDL TEXT data to CLOB and BYTE
data to BLOB.

**Warning:** Genero TEXT/BYTE program variables have a limit of 2
gigabytes, make sure that the large object data does not exceed this
limit.

**Warning** : ORACLE BFILEs are not supported.

------------------------------------------------------------------------

[ODIORA031 - Cursors WITH HOLD]{#ODIORA031}

INFORMIX closes opened cursors automatically when a transaction ends
unless the WITH HOLD option is used in the DECLARE instruction. In
ORACLE, opened cursors using SELECT statements without a FOR UPDATE
clause are not closed when a transaction ends. Actually, all ORACLE
cursors are \'WITH HOLD\' cursors unless the FOR UPDATE clause is used
in the SELECT statement.

**[*Solution:*]{.underline}**

BDL cursors that are not declared \"WITH HOLD\" are automatically closed
by the database interface when a COMMIT WORK or ROLLBACK WORK is
performed.

**Warning:** Since ORACLE automatically closes  FOR UPDATE cursors when
the transaction ends, opening cursors declared FOR UPDATE and WITH HOLD
results in an SQL error that does not normally appear with INFORMIX, in
the same conditions. Review the program logic in order to find another
way to set locks.

------------------------------------------------------------------------

[ODIORA032 - UPDATE/DELETE WHERE CURRENT OF \<cursor\>]{#ODIORA032}

INFORMIX allows positioned UPDATEs and DELETEs with the \"WHERE CURRENT
OF \<cursor\>\" clause, if the cursor has been DECLARED with a SELECT
\... FOR UPDATE statement.

**Warning:** UPDATE/DELETE \... WHERE CURRENT OF \<cursor\> is not
support by the Oracle database API. However, ROWIDs can be used for
positioned updates/deletes.

**[*Solution:*]{.underline}**

UPDATE/DELETE \... WHERE CURRENT OF instructions are managed by the
ORACLE database interface. The ORACLE database interface replaces
\"WHERE CURRENT OF \<cursor\>\"  by  \"WHERE ROWID=:rid\" and sets the
value of the ROWID returned by the last FETCH done with the given
cursor..

------------------------------------------------------------------------

[ODIORA033 - Querying system catalog tables]{#ODIORA033}

As in INFORMIX, ORACLE provides system catalog tables (actually, system
views). But the table names and their structure are quite different.

**[*Solution:*]{.underline}**

**Warning:** No automatic conversion of INFORMIX system tables is
provided by the database interface.

------------------------------------------------------------------------

[ODIORA034 - Syntax of UPDATE statements]{#ODIORA034}

INFORMIX allows a specific syntax for UPDATE statements :

    UPDATE table SET ( \<col-list\> ) = ( \<val-list\> )

or

    UPDATE table SET table.\* = myrecord.\*\
    UPDATE table SET \* = myrecord.\*

**[*Solution:*]{.underline}**

Static UPDATE statements using the above syntax are converted **by the
compiler** to the standard form:\
    UPDATE table SET column=value \[,\...\]

------------------------------------------------------------------------

[ODIORA036 - INTERVAL data type]{#ODIORA036}

INFORMIX\'s INTERVAL data type stores a value that represents a span of
time. INTERVAL types are divided into two classes : ***year-month
intervals*** and ***day-time intervals*.**

ORACLE 8i does not provide a data type similar to INFORMIX INTERVAL.

Starting from version 9i, ORACLE provides the INTERVAL data type similar
to INFORMIX, with two classes (YEAR TO MONTH and DAY TO SECOND), but
Oracle\'s INTERVAL cannot be defined with a precision different from
these two classes (for example, you cannot define an INTERVAL HOUR TO
MINUTE in Oracle). The class DAY TO SECOND(n) is equivalent to the
INFORMIX INTERVAL class DAY TO FRACTION(n).

**[*Solution:*]{.underline}**

**When using Oracle 8i**

It is not recommended that you use the INTERVAL data type because Oracle
8i has no equivalent native data type. This would cause problems when
doing INTERVAL arithmetic on the database server side. However, INTERVAL
values can be stored in CHAR columns.

**When using Oracle 9i and higher**

INFORMIX INTERVAL YEAR(n) TO MONTH data is stored in Oracle INTERVAL
YEAR(n) TO MONTH columns. These data types are equivalent.

INFORMIX INTERVAL DAY(n) TO FRACTION(p) data is stored in Oracle
INTERVAL DAY(n) TO SECOND(p) columns. These data types are equivalent.

Other INFORMIX INTERVAL types must be stored in CHAR() columns as with
Oracle 8i, because the high qualifier precision cannot be specified with
Oracle INTERVALs. For example, INFORMIX INTERVAL HOUR(5) TO MINUTE has
no native equivalent in Oracle.

------------------------------------------------------------------------

## [ODIORA039 - Data storage concepts]{#ODIORA039}

An attempt should be made to preserve as much of the storage
specification as possible when converting from INFORMIX to ORACLE. Most
important storage decisions made for INFORMIX database objects (like
initial sizes and physical placement) can be reused for the ORACLE
database.

Storage concepts are quite similar in INFORMIX and in ORACLE, but the
names are different.

The following table compares INFORMIX storage concepts to ORACLE storage
concepts :

::: {align="center"}
+-------------------------------------+-------------------------------------+
| **INFORMIX**                        | **ORACLE**                          |
+-------------------------------------+-------------------------------------+
| Physical units of storage                                                 |
+-------------------------------------+-------------------------------------+
| The largest unit of physical disk   | One or more \"**data files**\" are  |
| space is a \"**chunk**\", which can | created for each \"tablespace\" to  |
| be allocated either as a cooked     | physically store the data of all    |
| file ( I/O is controlled by the OS) | logical structures. Like INFORMIX   |
| or as raw device (=UNIX partition,  | \"chunks\", a \"data file\" can be  |
| I/O is controlled by the database   | an OS file or a raw device.\        |
| engine). A \"dbspace\" uses at      | You can add \"data files\" to a     |
| least one \"chunk\" for storage.\   | \"tablespace\" in order to increase |
| You must add \"chunks\" to          | the size of the logical unit of     |
| \"dbspaces\" in order to increase   | storage or you can use the          |
| the size of the logical unit of     | AUTOEXTEND option when using OS     |
| storage.                            | files.                              |
+-------------------------------------+-------------------------------------+
| A \"**page**\" is the smallest      | At the finest level of granularity, |
| physical unit of disk storage that  | ORACLE stores data in \"**data      |
| the engine uses to read from and    | blocks**\" which size corresponds   |
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
| A \"**database**\" is a logical     | Same concept as INFORMIX, but one   |
| unit of storage that contains table | ORACLE instance can manage only one |
| and index data. Each database also  | database, in the meaning of         |
| contains a system catalog that      | INFORMIX.                           |
| tracks information about database   |                                     |
| elements like tables, indexes,      |                                     |
| stored procedures, integrity        |                                     |
| constraints and user privileges.    |                                     |
+-------------------------------------+-------------------------------------+
| Database tables are created in a    | Database tables are created in a    |
| specific \"**dbspace**\", which     | specific \"**tablespace**\", which  |
| defines a logical place to store    | defines a logical place to store    |
| data.\                              | data.\                              |
| If no dbspace is given when         | If no tablespace is given when      |
| creating the table, INFORMIX        | creating the table, ORACLE defaults |
| defaults to the current database    | to the user\'s default tablespace.  |
| dbspace.                            |                                     |
+-------------------------------------+-------------------------------------+
| The total disk space allocated for  | A \"**segment**\" is a set of       |
| a table is the \"**tblspace**\",    | \"extents\" allocated for a certain |
| which includes \"pages\" allocated  | logical structure. There are four   |
| for data, indexes, blobs, tracking  | different types of segments,        |
| page usage within table extents.\   | including data segments, index      |
| **Warning:** Do not confuse the     | segments, rollback segments and     |
| INFORMIX \"tblspace\" concept and   | temporary segments.                 |
| ORACLE \"tablespaces\".             |                                     |
+-------------------------------------+-------------------------------------+
| Other concepts                                                            |
+-------------------------------------+-------------------------------------+
| When initializing an INFORMIX       | Each ORACLE database has a          |
| engine, a \"**root dbspace**\" is   | \"**control file**\" that records   |
| created to store information about  | the physical structure of the       |
| all databases, including storages   | database, like the database name,   |
| information (chunks used, other     | location and names of \"data        |
| dbspaces, etc.)                     | files\" and \"redo log\" files, and |
|                                     | time stamp of database creation.    |
+-------------------------------------+-------------------------------------+
| The \"**physical log**\" is a set   | A \"**rollback segment**\" records  |
| of continuous disk pages where the  | the actions of SQL transactions     |
| engine stores \"before-images\" of  | that could be rolled back, and it   |
| data that has been modified during  | records the data as it existed      |
| processing.                         | before an operation in a            |
|                                     | transaction.\                       |
| The \"**logical log**\" is a set of | \                                   |
| \"**logical-log files**\" used to   | The \"**redo log files**\" hold all |
| record logical operations during    | changes made to the database, in    |
| on-line processing. All transaction | case the database experiences an    |
| information is stored in the        | instance failure.\                  |
| logical log files if a database has | Each database has at least two      |
| been created with transaction log.  | \"redo log files\".\                |
|                                     | Redo entries record data that can   |
| INFORMIX combines \"physical log\"  | be used to reconstruct all changes  |
| and \"logical log\" information     | made to the database, including the |
| when doing fast recovery. Saved     | rollback segments stored in the     |
| \"logical logs\" can be used to     | database buffers of the SGA.        |
| restore a database from tape.       | Therefore, the online redo log also |
|                                     | protects rollback data.             |
+-------------------------------------+-------------------------------------+
:::

------------------------------------------------------------------------

## [ODIORA046 - The LOAD and UNLOAD instructions]{#ODIORA046}

INFORMIX provides two SQL instructions to export / import data from /
into a database table: The UNLOAD instruction copies rows from a
database table into a text file and the LOAD instructions insert rows
from a text file into a database table.

ORACLE does not provide LOAD and UNLOAD instructions, but provides
external tools like SQL\*Plus and SQL\*Loader.

**[*Solution:*]{.underline}**

In 4gl programs, the LOAD and UNLOAD instructions are supported with
ORACLE, with some limitations:

**Warning:** There is a difference when using ORACLE DATE columns.  DATE
columns created in the ORACLE database are equivalent to INFORMIX
DATETIME YEAR TO SECOND columns.  In LOAD and UNLOAD, all ORACLE DATE
columns are treated as INFORMIX DATETIME YEAR TO SECOND columns and thus
will be unloaded with the \"YYYY-MM-DD hh:mm:ss\"  format.\
The same problem appears for INFORMIX INTEGER and SMALLINT values, which
are stored in an ORACLE database as NUMBER(?) columns. Those values will
be unloaded as INFORMIX DECIMAL(10) and DECIMAL(5) values, that is, with
a trailing dot-zero \".0\".

**Warning:** When using an INFORMIX database, simple dates are unloaded
using the DBDATE format (ex: \"23/12/1998\"). Therefore, unloading from
an INFORMIX database for loading into an ORACLE database is not
supported.

------------------------------------------------------------------------

[ODIORA047 - The USER constant]{#ODIORA047}

Both INFORMIX and ORACLE provide the **USER** constant, which identifies
the current user connected to the database server.

[Example:]{.underline}

> **INFORMIX**: SELECT **USER** FROM systables WHERE tabid=1\
> **ORACLE**: SELECT **USER** FROM DUAL

However, there is a difference:

- INFORMIX returns the user identifier as defined in the operating
  system, where it can be case sensitive (UNIX) or not (NT).
- ORACLE returns the user identifier which is stored in the database. By
  default ORACLE converts the user name to uppercase letters, if you do
  not put the user name in double quotes when creating it.

This is important if your application stores user names in database
records (for example, to audit data modifications). You can, for
example, connect to ORACLE with the name \'scott\', and perform the
following SQL operations :\
     (1) INSERT INTO mytab ( creator, comment )\
              VALUES ( **USER**, \'example\' );\
     (2) SELECT \* FROM mytab\
               WHERE creator = \'scott\';\
The first command inserts \'SCOTT\' (in uppercase letters) in the
creator column. The second statement will not find the row.

**[*Solution:*]{.underline}**

When creating a user in ORACLE, you can put double quotes around the
user name in order to force ORACLE to store the given user identifier as
is :

> CREATE USER \"scott\" IDENTIFIED BY \<pswd\>

To verify the user names defined in the ORACLE database, connect as
SYSTEM and list the records of the ALL_USERS table as follows :

    SELECT \* FROM ALL_USERS\


        USERNAME     USER_ID      CREATED
        ------------------------------------------------------------
        SYS                0      02-OCT-98
        SYSTEM             5      02-OCT-98
        DBSNMP            17      02-OCT-98
        FBDL              20      03-OCT-98
        Toto              21      03-OCT-98

------------------------------------------------------------------------

[ODIORA051 - Setup database statistics]{#ODIORA051}

INFORMIX provides a special instruction to compute database statistics
in order to help the optimizer to find the right query execution plan :

> UPDATE STATISTICS \...

Oracle has the following instruction to compute database statistics:

> ANALYZE \...

See Oracle documentation for more details.

[***Solution:***]{.underline}

Centralize the optimization instruction in a function.

------------------------------------------------------------------------

[ODIORA052 - The GROUP BY clause]{#ODIORA052}

INFORMIX allows you to use column numbers in the GROUP BY clause

     SELECT ord_date, sum(ord_amount) FROM order **GROUP BY 1**

Oracle does not support column numbers in the GROUP BY clause.

[***Solution:***]{.underline}

Use column names instead:

     SELECT ord_date, sum(ord_amount) FROM order **GROUP BY ord_date**

------------------------------------------------------------------------

[ODIORA053 - The ALTER TABLE instruction]{#ODIORA053}

INFORMIX and ORACLE have different implementations of the ALTER TABLE
instruction. For example, INFORMIX allows you to use multiple ADD
clauses separated by commas. This is not supported by ORACLE :

INFORMIX:\
     ALTER TABLE customer **ADD(col1 INTEGER), ADD(col2 CHAR(20))**

ORACLE:\
     ALTER TABLE customer **ADD(col1 INTEGER, col2 CHAR(20))**

[***Solution:***]{.underline}

**Warning:** No automatic conversion is done by the database interface.
There is no real standard for this instruction ( that is, no common
syntax for all database servers). Read the SQL documentation and review
the SQL scripts or the BDL programs in order to use the database server
specific syntax for ALTER TABLE.

------------------------------------------------------------------------

[ODIORA054 - The star (asterisk) in SELECT statements]{#ODIORA054}

INFORMIX allows you to use the star character in the select list along
with other expressions :

   SELECT col1, **\*** FROM tab1 \...

Oracle does not support this. You must use the table name as a prefix to
the star:

SELECT col1, **tab1.\*** FROM tab1 \...

**[*Solution:*]{.underline}**

Always use the table name before the star.

------------------------------------------------------------------------

[ODIORA055 - NULLs in indexed columns]{#ODIORA055}

Oracle btree indexes do not store null values, while INFORMIX btree
indexes do. This means that if you index a single column and select all
the rows where that column is null, INFORMIX will do an indexed read to
fetch just those rows, but Oracle will do a sequential scan of all rows
to find them. Having an index unusable for \"is null\" criteria can also
completely change the behavior and performance of more complicated
selects without causing a sequential scan.

**[*Solution:*]{.underline}**

Declare the indexed columns as NOT NULL with a default value and change
the programmatic logic. If you do not want to change the programs,
partitioning the table so that the nulls have a partition of their own
will reduce the sequential scan to just the nulls (un-indexed)
partition, which is relatively fast.

------------------------------------------------------------------------

## [ODIORA056 - SQL Interruption]{#ODIORA056}

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

Oracle supports SQL Interruption in a similar way as INFORMIX. The db
client must issue an OCIBreak() OCI call to interrupt a query.

[*Solution:*]{.underline}

The ORACLE database driver supports SQL interruption and converts the
native SQL error code -1013 to the INFORMIX error code -213.

------------------------------------------------------------------------

## [ODIORA057 - Scrollable Cursors]{#ODIORA057}

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

Oracle 9.0 and higher support native scrollable cursors.

***[Solution:]{.underline}***

By default, the Oracle database driver uses native scrollable cursors by
setting the OCI_STMT_SCROLLABLE_READONLY statement attribute.

However, if you experience problems with the native scrollable cursors
provided by Oracle, you can turn on scrollable cursor emulation with the
following FGLPROFILE entry:

   dbi.database.*dbname*.ora.cursor.scroll.emul = true

When this FGLPROFILE setting is defined, the Oracle database driver
emulates scrollable cursors with temporary files. On UNIX, the temp
files are created in the directory defined by the DBTEMP, TMPDIR, TEMP
or TMP environment variables (the default is /tmp). On Windows, the temp
files are created with the \_tempnam() MSVCRT API call.

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

[ODIORA100 - Data type conversion table]{#ODIORA100}

::: {align="center"}
  ----------------- ------------------- ------------------- -------------------
  **INFORMIX Data   **ORACLE Data       **ORACLE Data       **ORACLE Data
  Types**           Types\              Types\              Types\
                    (Versions 8.x)**    (Versions 9.x)**    (Versions 10g and
                                                            higher)**

  CHAR(n)           CHAR(n)\            CHAR(n)\            CHAR(n)\
                    (Oracle limit =     (Oracle limit =     (Oracle limit =
                    2000c!)             2000c!)             2000c!)

  VARCHAR(n)        VARCHAR2(n)\        VARCHAR2(n)\        VARCHAR2(n)\
                    (Oracle limit =     (Oracle limit =     (Oracle limit =
                    4000c!)             4000c!)             4000c!)

  BOOLEAN           CHAR(1)             CHAR(1)             CHAR(1)

  SMALLINT          NUMBER(5,0)         NUMBER(5,0)         NUMBER(5,0)

  INTEGER           NUMBER(10,0)        NUMBER(10,0)        NUMBER(10,0)

  BIGINT            NUMBER(20,0)        NUMBER(20,0)        NUMBER(20,0)

  INT8              NUMBER(20,0)        NUMBER(20,0)        NUMBER(20,0)

  FLOAT\[(n)\]      **NUMBER**          **NUMBER**          **BINARY_DOUBLE**

  SMALLFLOAT        **NUMBER**          **NUMBER**          **BINARY_FLOAT**

  DECIMAL(p,s)      NUMBER(p,s)         NUMBER(p,s)         NUMBER(p,s)

  DECIMAL(p)        FLOAT(p\*3.32193)   FLOAT(p\*3.32193)   FLOAT(p\*3.32193)

  DECIMAL *(not     FLOAT               FLOAT               FLOAT
  recommended)*                                             

  MONEY(p,s)        NUMBER(p,s)         NUMBER(p,s)         NUMBER(p,s)

  TEXT              CLOB (using \<=     CLOB (using \<=     CLOB (using \<=
                    2Gb!)               2Gb!)               2Gb!)

  BYTE              BLOB (using \<=     BLOB (using \<=     BLOB (using \<=
                    2Gb!)               2Gb!)               2Gb!)

  DATE              DATE                DATE                DATE

  DATETIME YEAR TO  DATE                DATE                DATE
  YEAR                                                      

  DATETIME YEAR TO  DATE                DATE                DATE
  MONTH                                                     

  DATETIME YEAR TO  DATE                DATE                DATE
  DAY                                                       

  DATETIME YEAR TO  DATE                DATE                DATE
  HOUR                                                      

  DATETIME YEAR TO  DATE                DATE                DATE
  MINUTE                                                    

  DATETIME YEAR TO  DATE                DATE                DATE
  SECOND                                                    

  DATETIME YEAR TO  ***Not supported*** **TIMESTAMP(n)**    **TIMESTAMP(n)**
  FRACTION(n)                                               

  DATETIME MONTH TO DATE                DATE                DATE
  MONTH                                                     

  DATETIME MONTH TO DATE                DATE                DATE
  DAY                                                       

  DATETIME MONTH TO DATE                DATE                DATE
  HOUR                                                      

  DATETIME MONTH TO DATE                DATE                DATE
  MINUTE                                                    

  DATETIME MONTH TO DATE                DATE                DATE
  SECOND                                                    

  DATETIME MONTH TO ***Not supported*** **TIMESTAMP(n)**    **TIMESTAMP(n)**
  FRACTION(n)                                               

  DATETIME DAY TO   DATE                DATE                DATE
  DAY                                                       

  DATETIME DAY TO   DATE                DATE                DATE
  HOUR                                                      

  DATETIME DAY TO   DATE                DATE                DATE
  MINUTE                                                    

  DATETIME DAY TO   DATE                DATE                DATE
  SECOND                                                    

  DATETIME DAY TO   ***Not supported*** **TIMESTAMP(n)**    **TIMESTAMP(n)**
  FRACTION(n)                                               

  DATETIME HOUR TO  DATE                DATE                DATE
  HOUR                                                      

  DATETIME HOUR TO  DATE                DATE                DATE
  MINUTE                                                    

  DATETIME HOUR TO  DATE                DATE                DATE
  SECOND                                                    

  DATETIME HOUR TO  ***Not supported*** **TIMESTAMP(n)**    **TIMESTAMP(n)**
  FRACTION(n)                                               

  DATETIME MINUTE   DATE                DATE                DATE
  TO MINUTE                                                 

  DATETIME MINUTE   DATE                DATE                DATE
  TO SECOND                                                 

  DATETIME MINUTE   ***Not supported*** **TIMESTAMP(n)**    **TIMESTAMP(n)**
  TO FRACTION(n)                                            

  DATETIME SECOND   DATE                DATE                DATE
  TO SECOND                                                 

  DATETIME SECOND   ***Not supported*** **TIMESTAMP(n)**    **TIMESTAMP(n)**
  TO FRACTION(n)                                            

  DATETIME FRACTION ***Not supported*** **TIMESTAMP(n)**    **TIMESTAMP(n)**
  TO FRACTION(n)                                            

  INTERVAL          **CHAR(50)**        **INTERVAL          **INTERVAL
  YEAR\[(n)\] TO                        YEAR\[(n)\] TO      YEAR\[(n)\] TO
  MONTH                                 MONTH**             MONTH**

  INTERVAL          CHAR(50)            CHAR(50)            CHAR(50)
  MONTH\[(n)\] TO                                           
  MONTH                                                     

  INTERVAL          **CHAR(50)**        **INTERVAL          **INTERVAL
  DAY\[(n)\] TO                         DAY\[(n)\] TO       DAY\[(n)\] TO
  FRACTION(p)                           SECOND(p)**         SECOND(p)**

  INTERVAL          CHAR(50)            CHAR(50)            CHAR(50)
  HOUR\[(n)\] TO                                            
  HOUR                                                      

  INTERVAL          CHAR(50)            CHAR(50)            CHAR(50)
  HOUR\[(n)\] TO                                            
  MINUTE                                                    

  INTERVAL          CHAR(50)            CHAR(50)            CHAR(50)
  HOUR\[(n)\] TO                                            
  SECOND                                                    

  INTERVAL          CHAR(50)            CHAR(50)            CHAR(50)
  HOUR\[(n)\] TO                                            
  FRACTION(p)                                               

  INTERVAL          CHAR(50)            CHAR(50)            CHAR(50)
  MINUTE\[(n)\] TO                                          
  MINUTE                                                    

  INTERVAL          CHAR(50)            CHAR(50)            CHAR(50)
  MINUTE\[(n)\] TO                                          
  SECOND                                                    

  INTERVAL          CHAR(50)            CHAR(50)            CHAR(50)
  MINUTE\[(n)\] TO                                          
  FRACTION(p)                                               

  INTERVAL          CHAR(50)            CHAR(50)            CHAR(50)
  SECOND\[(n)\] TO                                          
  SECOND                                                    

  INTERVAL          CHAR(50)            CHAR(50)            CHAR(50)
  SECOND\[(n)\] TO                                          
  FRACTION(p)                                               

  INTERVAL          CHAR(50)            CHAR(50)            CHAR(50)
  FRACTION\[(n)\]                                           
  TO FRACTION                                               
  ----------------- ------------------- ------------------- -------------------
:::
