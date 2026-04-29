[Back to Contents](../index.html)

------------------------------------------------------------------------

# ODI Adaptation Guide For MySQL 5.x.x

Installation

::: {align="center"}
  -------------------------------------------------------
  [Install MySQL and create a database](#ODIMYS_PREP01)
  [Prepare the runtime environment](#ODIMYS_PREP02)
  -------------------------------------------------------
:::

Database concepts

::: {align="center"}
  ------------------------------------------------------------
  [Database concepts](#ODIMYS007a)
  [Data storage concepts](#ODIMYS039)
  [Data consistency and concurrency management](#ODIMYS008a)
  [Transactions handling](#ODIMYS009)
  [Defining database users](#ODIMYS016)
  ------------------------------------------------------------
:::

Data dictionary

::: {align="center"}
  ----------------------------------------------
  [BOOLEAN data type](#ODIMYS010)
  [CHARACTER data types](#ODIMYS011)
  [NUMERIC data types](#ODIMYS021)
  [DATE and DATETIME data types](#ODIMYS001)
  [INTERVAL data type](#ODIMYS036)
  [SERIAL data type](#ODIMYS005)
  [ROWIDs](#ODIMYS004)
  [Very large data types](#ODIMYS030)
  [Constraints](#ODIMYS012)
  [Name resolution of SQL objects](#ODIMYS019)
  [Data type conversion table](#ODIMYS100)
  ----------------------------------------------
:::

Data manipulation

::: {align="center"}
  -----------------------------------------------
  [Reserved words](#ODIMYS003)
  [Outer joins](#ODIMYS006)
  [Transactions handling](#ODIMYS009)
  [Temporary tables](#ODIMYS017)
  [Substrings in SQL](#ODIMYS018)
  [Name resolution of SQL objects](#ODIMYS019)
  [Database object name delimiters](#ODIMYS020)
  [MATCHES and LIKE conditions](#ODIMYS024)
  [Syntax of UPDATE statements](#ODIMYS034)
  -----------------------------------------------
:::

BDL programming

::: {align="center"}
  ---------------------------------------------------------
  [SERIAL data type](#ODIMYS005)
  [INFORMIX specific SQL statements in BDL](#ODIMYS025)
  [INSERT cursors](#ODIMYS028)
  [Cursors WITH HOLD](#ODIMYS031)
  [SELECT FOR UPDATE](#ODIMYS008b)
  [UPDATE/DELETE WHERE CURRENT OF \<cursor\>](#ODIMYS032)
  [The LOAD and UNLOAD instructions](#ODIMYS046)
  [SQL Interruption](#ODIMYS047)
  [Scrollable Cursors](#ODIMYS048)
  ---------------------------------------------------------
:::

------------------------------------------------------------------------

## [Runtime configuration]{#ODIMYS_PREP}

> ### [Install MySQL and create a database]{#ODIMYS_PREP01}
>
> 1.  **Warning:** Supported MySQL versions are **5.0** and higher,
>     MySQL **4.1.2** drivers are still be available, but MySQL version
>     4.1 is de-supported by the database vendor since January 2010.
>
> 2.  Install the MySQL Server on your computer. You can download
>     packages from [www.mysql.com](http://www.mysql.com).
>
> 3.  Configure the server with the appropriate *storage engine*:\
>     **Warning**: In order to have transaction support by default, you
>     must use a storage engine that supports transactional tables.\
>     The **INNODB** is a storage engine supporting transactions. In
>     order to use this storage engine as default, set the next
>     configuration parameter in the **my.cnf** or **my.ini** file:\
>       \[mysqld\]\
>       default-storage-engine = INNODB\
>     You can also set the default table type option in the command line
>     when starting the engine:\
>       mysqld_safe \--default-storage-engine=InnoDB
>
> 4.  The **mysqld** process must be started to listen to database
>     client connections. See MySQL documentation for more details about
>     starting the database server process.
>
> 5.  Create a database user dedicated to your application, the
>     **application administrator.**  Connect as the MySQL root user and
>     GRANT all privileges to this user:\
>       mysql -u root\
>       \...\
>       mysql\> grant all privileges on \*.\*\
>                    to \'*mysuser*\'@\'localhost\'\
>                    identified by \'*password*\';
>
> 6.  Connect as the application administrator and create a MySQL
>     database with the **CREATE DATABASE** statement:\
>       mysql -u *mysuser*\
>       \...\
>       mysql\> create database *mydatabase*;
>
> 7.  Create the **application tables**. Do not forget to convert
>     INFORMIX data types to MySQL data types. See issue
>     [ODIMYS100](#ODIMYS100) for more details. If you have a
>     transactional-safe table handler activated by default, you do not
>     need to specify the TYPE option.
>
> ### [Prepare the runtime environment]{#ODIMYS_PREP02}
>
> 1.  In order to connect to MySQL, you must have a MySQL database
>     driver \"**dbmmys\***\" in FGLDIR/dbdrivers.
>
> 2.  The **MySQL client software** is required to connect to a database
>     server. Check if the MySQL client library (**libmysqlclient.\***)
>     is installed on the system.\
>     \
>     **Warning: MySQL ships the client library as a simple .a archive,
>     there is no shared library provided by default. You must create a
>     .so or .DLL library in order to use one of the MySQL database
>     drivers.**\
>     \
>     For example, to create a **libmysqlclient.so** shared library on
>     Linux, execute the following commands:\
>     \
>     \$ cd \$MYSQL_HOME/lib\
>     \$ mkdir tmp\
>     \$ cd tmp\
>     \$ ar -x ../libmysqlclient.a\
>     \$ gcc \--shared -o ../libmysqlclient.so \*.o -lz\
>     \$ cd ..\
>     % rm -rf tmp
>
> 3.  Make sure that the MySQL client environment variables are properly
>     set. Check for example **MYSQL_HOME** (the path to the
>     installation directory), **DATADIR** (the path to the data files
>     directory), etc. See MySQL documentation for more details about
>     client environment variables to be set.
>
> 4.  Verify the environment variable defining the search path for the
>     database client shared library (libmysqlclient.so on UNIX,
>     LIBMYSQL.dll on Windows). On UNIX platforms, the variable is
>     specific to the operating system. For example, on Solaris and
>     Linux systems, it is **LD_LIBRARY_PATH**, on AIX it is
>     **LIBPATH**, or HP/UX it is **SHLIB_PATH**. On Windows, you define
>     the DLL search path in the **PATH** environment variable.
>
>     +-----------------------------------+-----------------------------------+
>     | **MySQL version**                 | **Shared library environment      |
>     |                                   | setting**                         |
>     +-----------------------------------+-----------------------------------+
>     | **MySQL 5.0 and higher**          | *UNIX*: Add **\$MYSQL_HOME/lib**  |
>     |                                   | to LD_LIBRARY_PATH (or its        |
>     |                                   | equivalent).\                     |
>     |                                   | *Windows*: Add                    |
>     |                                   | **%MYSQL_HOME%\\bin** to PATH.    |
>     +-----------------------------------+-----------------------------------+
>     |                                   |                                   |
>     +-----------------------------------+-----------------------------------+
>
> 5.  To verify if the MySQL client environment is correct, you can
>     start the MySQL command interpreter:\
>     \
>          \$ mysql *dbname* -u *appadmin* -p
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

[ODIMYS001 - DATE and DATETIME data types]{#ODIMYS001}

INFORMIX provides two data types to store dates and time information:

- **DATE** = for year, month and day storage.
- **DATETIME** = for year to fraction(1-5) storage.

MySQL provides the following data type to store dates:

- **DATE** = for year, month, day storage.
- **TIME** = for hour, minute, second storage.
- **DATETIME** = for year, month, day, hour, minute, second storage.
- **TIMESTAMP** = automatically updated when row is touched.

**String representing date time information:**

INFORMIX is able to convert quoted strings to DATE / DATETIME data if
the string contents matches environment parameters (i.e. DBDATE,
GL_DATETIME). As in INFORMIX, MySQL can convert quoted strings to
datetime data according the ISO datetime format ( YYYY-MM-DD hh:mm:ss\'
).

**Date arithmetic:**

- INFORMIX supports date arithmetic on DATE and DATETIME values. The
  result of an arithmetic expression involving dates/times is a number
  of days when only DATEs are used and an INTERVAL value if a DATETIME
  is used in the expression.
- In MySQL, the result of an arithmetic expression involving DATE values
  is an INTEGER representing a number of days.
- INFORMIX automatically converts an integer to a date when the integer
  is used to set a value of a date column. MySQL does not support this
  automatic conversion.
- Complex DATETIME expressions ( involving INTERVAL values for example)
  are INFORMIX specific and have no equivalent in MySQL.

**[*Solution:*]{.underline}**

MySQL has the same **DATE** data type as INFORMIX ( year, month, day ).
So you can use MySQL DATE data type for INFORMIX DATE columns.

MySQL **TIME** data type can be used to store INFORMIX DATETIME HOUR TO
SECOND values. The database interface makes the conversion
automatically.

INFORMIX DATETIME values with any precision from YEAR to SECOND can be
stored in MySQL **DATETIME** columns. The database interface makes the
conversion automatically. Missing date or time parts default to
1900-01-01 00:00:00. For example, when using a DATETIME HOUR TO MINUTE
with the value of \"11:45\", the MySQL DATETIME value will be
\"1900-01-01 11:45:00\".

**Warning:** SQL Statements using expressions with TODAY / CURRENT / 
EXTEND must be reviewed and adapted to the native syntax.

**Warning:** Literal DATETIME and INTERVAL expressions (i.e. DATETIME (
1999-10-12) YEAR TO DAY) are not converted.

------------------------------------------------------------------------

[ODIMYS003 - Reserved words]{#ODIMYS003}

SQL object names like table and column names cannot be SQL reserved
words in MySQL.

***[Solution:]{.underline}***

Table or column names which are MySQL reserved words must be renamed.

------------------------------------------------------------------------

[ODIMYS004 - ROWIDs]{#ODIMYS004}

When creating a table, INFORMIX automatically adds a \"ROWID\" integer
column (applies to non-fragmented tables only). The ROWID column is
auto-filled with a unique number and can be used like a primary key to
access a given row.

MySQL does not have an equivalent for the INFORMIX ROWID pseudo-column.

***[Solution:]{.underline}***

**Warning:** ROWIDs are not supported. You must review the code using
ROWIDs and use primary key columns instead.

------------------------------------------------------------------------

## [ODIMYS030 - Very large data types]{#ODIMYS030}

INFORMIX uses the TEXT and BYTE data types to store very large texts or
images. MySQL provides TINYTEXT, TEXT, MEDIUMTEXT, LONGTEXT, TINYBLOB,
BLOB, MEDIUMBLOB and LONGBLOB data types.

**[*Solution:*]{.underline}**

Starting with MySQL version 5.0, the database interface can convert BDL
TEXT data to LONGTEXT and BYTE data to LONG BLOB.

**Warning:** Genero TEXT/BYTE program variables have a limit of 2
gigabytes, make sure that the large object data does not exceed this
limit.

**Warning:** Because MySQL CHAR and VARCHAR cannot exceed 255 bytes, we
recommend to use the MySQL TEXT type to store CHAR/VARCHAR values with a
size larger as 255 bytes. When fetching TEXT columns from a MySQL
database, these will be treated as CHAR/VARCHAR types by the MySQL
database driver. See [CHAR/VARCHAR types](#ODIMYS011) for more details.

------------------------------------------------------------------------

[ODIMYS005 - SERIAL data type]{#ODIMYS005}

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

MySQL supports the AUTO_INCREMENT column definition option as well as
the SERIAL keyword:

- In CREATE TABLE, you specify a auto-incremented column with the
  AUTO_INCREMENT attribute
- Auto-incremented columns have the same behavior as INFORMIX SERIAL
  columns
- You define a start value with ALTER TABLE tabname AUTO_INCREMENT =
  value
- The column must be the primary key.
- When using the InnoDB engine, AUTO_INCREMENTED columns might re-use
  unused sequences after a server restart.\
  Actually, when the server restarts, it issues a SELECT
  MAX(auto_increment_column) on each table with such as column to
  identify the next sequence to be generated. If you insert rows that
  generate the numbers 101, 102 and 103, then you delete rows 102 and
  103; When the server is restarted next generated number will be 101 +
  1 = 102.
- SERIAL is a synonym for BIGINT UNSIGNED NOT NULL AUTO_INCREMENT
  UNIQUE.

**[*Solution:*]{.underline}**

The INFORMIX SERIAL data type is emulated with MySQL **AUTO_INCREMENT**
option. After an insert, SQLCA.SQLERRD\[2\] holds the last generated
serial value. However, SQLCA.SQLERRD\[2\] is defined as an INTEGER, it
cannot hold values from BIGINT auto incremented columns. If you are
using BIGINT auto incremented columns, you must use the LAST_INSERT_ID()
SQL function.

**Warning:** AUTO_INCREMENT columns must be primary keys. This is
handled automatically when you create a table in a BDL program.

Like Informix, MySQL allows to specify a zero for auto-incremented
columns, however, for SQL portability, INSERT statements should be
reviewed to remove the SERIAL column from the list.\
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

[ODIMYS006 - Outer joins]{#ODIMYS006}

In INFORMIX SQL, outer tables can be defined in the **FROM** clause with
the **OUTER** keyword:

> SELECT ... FROM a, OUTER(b)
>      WHERE a.key = b.akey
>
>     SELECT ... FROM a, OUTER(b,OUTER(c))
>      WHERE a.key = b.akey
>        AND b.key1 = c.bkey1
>        AND b.key2 = c.bkey2 

MySQL 3.23 supports the ANSI outer join syntax:

> SELECT ... FROM cust LEFT OUTER JOIN order
>                          ON cust.key = order.custno
>
>     SELECT ...
>       FROM cust LEFT OUTER JOIN order
>                      LEFT OUTER JOIN item
>                      ON order.key = item.ordno
>                 ON cust.key = order.custno
>      WHERE order.cdate > current date

See the MySQL reference for a complete description of the syntax.

***[Solution:]{.underline}***

For better SQL portability, you should use the ANSI outer join syntax
instead of the old Informix OUTER syntax.

The MySQL interface can convert most INFORMIX OUTER specifications to
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
    therefore are not supported :\
      Example : \"\... FROM tab1, OUTER(tab2) WHERE tab1.col1 =
    tab2.col2 AND tab2.colx \> 10\".
2.  Statements composed by 2 or more SELECT instructions using OUTERs
    are not supported.\
      Example : \"SELECT \... UNION SELECT\" or \"SELECT \... WHERE col
    IN (SELECT\...)\"

Notes:

1.  Table aliases are detected in OUTER expressions.\
       OUTER example with table alias : \"OUTER( tab1 alias1)\".
2.  In the outer join, \<outer table\>.\<col\> can be placed on both
    right or left side of the equal sign.\
       OUTER join example with table on the left : \"WHERE outertab.col1
    = maintab.col2 \".
3.  Table names detection is not case-sensitive.\
       Example : \"SELECT \... FROM tab1, TAB2 WHERE tab1.col1 =
    tab2.col2\".
4.  [Temporary tables](#ODIMYS017) are supported in OUTER
    specifications.

------------------------------------------------------------------------

[ODIMYS007a - Database concepts]{#ODIMYS007a}

Most BDL applications use only one database entity (in the meaning of
INFORMIX). But the same BDL application can connect to different
occurrences of the same database schema, allowing several users to
connect to those different databases.

Like INFORMIX servers, MySQL can handle multiple database entities.
Tables created by a user can be accessed without the owner prefix by
other users as long as they have access privileges to these tables.

**[*Solution:*]{.underline}**

Create a MySQL database for each INFORMIX database. 

------------------------------------------------------------------------

[ODIMYS008a - Data consistency and concurrency management]{#ODIMYS008a}

**Data consistency** involves readers which want to access data
currently modified by writers and **concurrency data access** involves
several writers accessing the same data for modification. **Locking
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
- The default locking granularity is per page.

[MySQL]{.underline}

When data is modified, **exclusive locks** are set and held until the
end of the transaction. For data consistency, MySQL uses a **locking
mechanism**. Readers must wait for writers as in INFORMIX.

Control:

- No lock wait mode control is provided.
- Isolation level : SET TRANSACTION ISOLATION LEVEL \...
- Explicit exclusive lock : SELECT \... FOR UPDATE

Defaults:

- The default isolation level is Read Committed.
- The default locking granularity is per table (pre page when using BDB
  tables).

**[*Solution:*]{.underline}**

The SET ISOLATION TO \... INFORMIX syntax is replaced by SET SESSION
TRANSACTION ISOLATION LEVEL \... in MySQL. The next table shows the
isolation level mappings done by the MySQL database driver:

::: {align="center"}
  ----------------------------------- -----------------------------------
  **SET ISOLATION instruction in      **Native SQL command**
  program**                           

  SET ISOLATION TO DIRTY READ         SET SESSION TRANSACTION ISOLATION
                                      LEVEL READ UNCOMMITTED

  SET ISOLATION TO COMMITTED READ\    SET SESSION TRANSACTION ISOLATION
    \[READ COMMITTED\] \[RETAIN       LEVEL READ COMMITTED
  UPDATE LOCKS\]                      

  SET ISOLATION TO CURSOR STABILITY   SET SESSION TRANSACTION ISOLATION
                                      LEVEL READ COMMITTED

  SET ISOLATION TO REPEATABLE READ    SET SESSION TRANSACTION ISOLATION
                                      LEVEL REPEATABLE READ
  ----------------------------------- -----------------------------------
:::

For portability, it is recommended that you work with INFORMIX in the
read committed isolation level, make processes wait for each other (lock
mode wait), and create tables with the \"lock mode row\" option.

See INFORMIX and MySQL documentation for more details about data
consistency, concurrency and locking mechanisms.

------------------------------------------------------------------------

[ODIMYS008b - SELECT FOR UPDATE]{#ODIMYS008b}

A lot of BDL programs use pessimistic locking in order to avoid several
users editing the same rows at the same time.

   DECLARE cc CURSOR FOR\
         SELECT \... FROM tab WHERE \... FOR UPDATE\
   OPEN cc\
   FETCH cc \<\-- lock is acquired\
   \...\
   CLOSE cc \<\-- lock is released

**Warning:** MySQL locking mechanism depends upon the transaction
manager. The default locking granularity is per table when you use the
default non-transactional configuration. You must use the InnoDB Storage
Engine to get transactions and locking mechanisms.

SELECT \... FOR UPDATE is only supported since MySQL version 6.0. Locks
are released at the end of the transaction.

**[*Solution:*]{.underline}**

Check if the MySQL storage engine supports SELECT FOR UPDATE, otherwise
review the program logic.

------------------------------------------------------------------------

[ODIMYS009 - Transactions handling]{#ODIMYS009}

INFORMIX and MySQL handle transactions in a similar manner.

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

MySQL :

- Transactions are started with START TRANSACTION.
- Transactions are validated with COMMIT \[WORK\].
- Transactions are canceled with ROLLBACK \[WORK\].
- Savepoints can be placed with SAVEPOINT *name*.
- Transactions can be rolled back to a savepoint with ROLLBACK \[WORK\]
  TO \[SAVEPOINT\] *name*.
- Savepoints can be be released with RELEASE SAVEPOINT *name*.
- Statements executed outside of a transaction are automatically
  committed.
- DDL statements can be executed (and canceled) in transactions.

**[*Solution:*]{.underline}**

INFORMIX transaction handling commands are automatically converted to
MySQL instructions to start, validate or cancel transactions.

**Warning:** MySQL does not support transactions by default. You must
set the server system parameter **table_type=InnoDB**.

Regarding the transaction control instructions, the BDL applications do
not have to be modified in order to work with MySQL, as long as you have
a transaction manager installed with MySQL.

**Warning:** If you want to use savepoints, do not use the UNIQUE
keyword in the savepoint declaration, always specify the savepoint name
in ROLLBACK TO SAVEPOINT, and do not drop savepoints with RELEASE
SAVEPOINT.

------------------------------------------------------------------------

## [ODIMYS010 - BOOLEAN data type]{#ODIMYS010}

INFORMIX supports the BOOLEAN data type, which can store \'t\' or \'f\'
values. Genero BDL implements the BOOLEAN data type in a different way:
As in other programming languages, Genero BOOLEAN stores integer values
1 or 0 (for TRUE or FALSE). The type was designed this way to assign the
result of a Boolean expression to a BOOLEAN variable.

MySQL supports the BOOLEAN data type and stores 1 or 0 integer values
for TRUE and FALSE.

**[*Solution:*]{.underline}**

The MySQL database interface supports the BOOLEAN data type.

------------------------------------------------------------------------

[ODIMYS011 - CHARACTER data types]{#ODIMYS011}

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

MySQL supports the following character data types:

- CHAR(N) with N\<= 255 characters
- VARCHAR(N) with N\<= 65535 characters
- NCHAR(N) with N\<= 255 characters (UTF-8 only)
- NVARCHAR(N) with N\<= 65535 characters (UTF-8 only)

**Warning:** With MySQL version 4, CHAR/VARCHAR with a size exceeding
255 characters are silently converted to TEXT columns. With later
versions, you get now an SQL error when trying to define a CHAR or
VARCHAR column with a size greater as the limit. Also, before version
MySQL 5.0.3, VARCHAR limit was 255 characters, starting with 5.0.3 the
limit is 65535 characters (but INFORMIX VARCHAR has a limit of 255
bytes, anyway).

Note that MySQL uses Character Length Semantics to define the size of
CHAR/VARCHAR columns, while INFORMIX and Genero use Byte Length
Semantics.

MySQL can support multiple character sets, you can run the SHOW
CHARACTER SET statement to list supported encodings. There are different
configuration levels to define the character set used by MySQL to store
data. The [server character set]{.underline} defines the default for
[database character sets]{.underline} if not specified in the CREATE
DATABASE command. You can even define a specific character set at the
table and column level, but this is not recommended with Genero
applications. The database character set is used to store CHAR and
VARCHAR columns. The NCHAR and NATIONAL VARCHAR types use a predefined
character which can be different from the database character set. In
MySQL the national character set is UTF-8.

MySQL can automatically convert from/to the client and server characters
sets. In the client applications, you define the character set with the
SET NAMES instruction.

**[*Solution:*]{.underline}**

INFORMIX \[VAR\]CHAR(N) types can be mapped to MySQL \[VAR\]CHAR(N)
types, as long as the MySQL size limit is not reached.

Review your database schema when using CHAR and VARCHAR columns with a
size exceeding the MySQL limits: If you need to store CHAR or VARCHAR
strings larger as the MySQL limit, you can use the MySQL **text** type.
When using CHAR/VARCHAR types in CREATE TABLE, the SQL Translator
converts to **text** if the size is bigger as 255. When fetching
**tinytext** and **text** columns from the MySQL database, the MySQL
database driver treats such columns as CHAR/VARCHAR, to emulate INFORMIX
CHAR columns with a size greater as 255.

**Warning:** For each **text** column fetched from MySQL, the MySQL
database driver needs to allocate a temporary string buffer of **65535
bytes**. Keep in mind that **text** columns may have be created by
CREATE TABLE using CHAR/VARCHAR with size\>255. The memory used by this
temporary buffer is freed when freeing the cursor.

Keep in mind that MySQL uses Character Length Semantics regarding
CHAR/VARCHAR sizes: When you define a CHAR(20) and the database
character set is multi-byte, the MySQL column can hold more
bytes/characters as the INFORMIX CHAR(20) type. For example, in UTF-8,
you can store 20 é (e-acute) characters in PGS CHAR(20), but only IFX
CHAR(20) can only store 10 of such characters, because in UTF-8, é is
encoded with 2 bytes. Even if Genero uses Byte Length Semantics when you
define a CHAR/VARCHAR variable, a good practice is to use the same sizes
for MySQL CHAR/VARCHAR columns: You could then store more characters in
the PGS columns as the Genero variable can hold, but this is not a
problem.

You can store single-byte or multi-byte character strings in MySQL CHAR,
VARCHAR and TEXT columns.

Do not forget to properly define the client character set, which must
correspond to the runtime system character set.

See also the section about [Localization](Localization.html).

------------------------------------------------------------------------

[ODIMYS012 - Constraints]{#ODIMYS012}

**Constraint naming syntax:**

Both INFORMIX and MySQL support primary key, unique, foreign key and
default, but the constraint naming syntax is different : MySQL expects
the \"CONSTRAINT\" keyword **before** the constraint specification and
INFORMIX expects it **after**.

**UNIQUE constraint example:**

  ----------------------------------- -----------------------------------
  **INFORMIX**                        **MySQL**

  CREATE TABLE scott.emp (\           CREATE TABLE scott.emp (\
  \...\                               \...\
  empcode CHAR(10) UNIQUE\            empcode CHAR(10)\
     **\[CONSTRAINT pk_emp\]**,\         **\[CONSTRAINT pk_emp\]**
  \...                                UNIQUE,\
                                      \...
  ----------------------------------- -----------------------------------

**Primary keys:**

Like INFORMIX, MySQL creates an index to enforce PRIMARY KEY constraints
(some RDBMS do not create indexes for constraints).  Using \"CREATE
UNIQUE INDEX\" to define unique constraints is obsolete (use primary
keys or a secondary key instead).

**Warning:** In MySQL, the name of a PRIMARY KEY is PRIMARY.

**Unique constraints:**

Like INFORMIX, MySQL creates an index to enforce UNIQUE constraints
(some RDBMS do not create indexes for constraints).

**Warning:** When using a unique constraint, INFORMIX allows only one
row with a NULL value, while MySQL allows several rows with NULL! Using
CREATE UNIQUE INDEX is obsolete.

**Foreign keys:**

Both INFORMIX and MySQL support the ON DELETE CASCADE option. In MySQL,
foreign key constraints are checked immediately, so NO ACTION and
RESTRICT are the same.

**Check constraints:**

**Warning:** Check constraints are not yet supported in MySQL.

**[*Solution:*]{.underline}**

**Constraint naming syntax:**

The database interface does not convert constraint naming expressions
when creating tables from BDL programs. Review the database creation
scripts to adapt the constraint naming clauses for MySQL.

------------------------------------------------------------------------

[ODIMYS016 - Defining database users]{#ODIMYS016}

INFORMIX users are defined at the operating system level, they must be
members of the \'informix\' group, and the database administrator must
grant CONNECT, RESOURCE or DBA privileges to those users.

MySQL users must be registered in the database. They are created with
the **GRANT** SQL instruction:

   \$ mysql -u root -pmanager \--host orion test

   mysql\> GRANT ALL PRIVILEGES ON \* TO mike IDENTIFIED BY \'pswd\';

**[*Solution:*]{.underline}**

According to the application logic (is it a multi-user application ?),
you have to create one or several MySQL users.

------------------------------------------------------------------------

[ODIMYS017 - Temporary tables]{#ODIMYS017}

INFORMIX temporary tables are created through the **CREATE TEMP TABLE**
DDL instruction or through a **SELECT \... INTO TEMP** statement.
Temporary tables are automatically dropped when the SQL session ends,
but they can be dropped with the DROP TABLE command. There is no name
conflict when several users create temporary tables with the same name.

INFORMIX allows you to create indexes on temporary tables. No name
conflict occurs when several users create an index on a temporary table
by using the same index identifier.

MySQL support temporary tables with the following syntax:

    CREATE TEMPORARY TABLE tablename ( *coldefs* )\
    CREATE TEMPORARY TABLE tablename LIKE *other-table*

***[Solution:]{.underline}***

In BDL, INFORMIX temporary tables instructions are converted to generate
native SQL Server temporary tables.

------------------------------------------------------------------------

[ODIMYS018 - Substrings in SQL]{#ODIMYS018}

INFORMIX SQL statements can use subscripts on columns defined with the
character data type:

    SELECT \... FROM tab1 WHERE **col1\[2,3\]** = \'RO\'\
    SELECT \... FROM tab1 WHERE **col1\[10\]**  = \'R\'   \-- Same as
col1\[10,10\]\
    UPDATE tab1 SET **col1\[2,3\]** = \'RO\' WHERE \...\
    SELECT \... FROM tab1 ORDER BY **col1\[1,3\]**

.. while MySQL provides the SUBSTR( ) function, to extract a substring
from a string expression :

    SELECT \.... FROM tab1 WHERE **SUBSTRING(col1,2,3)** = \'RO\'\
    SELECT **SUBSTRING(\'Some text\',6,3)** \...   \-- Gives \'tex\'

**[*Solution:*]{.underline}**

You must replace all INFORMIX col\[x,y\] expressions by
SUBSTRING(col,x,y-x+1).

**Warning:** In UPDATE instructions, setting column values through
subscripts will produce an error with MySQL :\
    UPDATE tab1 SET **col1\[2,3\]** = \'RO\' WHERE \...\
is converted to:\
    UPDATE tab1 SET **SUBSTRING(col1,2,(3-2+1))** = \'RO\' WHERE \...

**Warning:** Column subscripts in ORDER BY expressions are also
converted and produce an error with MySQL :\
    SELECT \... FROM tab1 ORDER BY **col1\[1,3\]**\
is converted to:\
    SELECT \... FROM tab1 ORDER BY **SUBSTRING(col1,1,(3-1+1))**

------------------------------------------------------------------------

[ODIMYS019 - Name resolution of SQL objects]{#ODIMYS019}

INFORMIX uses the following form to identify a SQL object:

  \[database\[@dbservername\]:\]\[{owner\|\"owner\"}.\]identifier

With MySQL, an object name takes the following form:\
\
  \[database.\]identifier

**[*Solution:*]{.underline}**

Check for single or double quoted table or column names in your source
and remove them.

------------------------------------------------------------------------

[ODIMYS020 - Database object name delimiters]{#ODIMYS020}

INFORMIX identifies database object names with double quotes, while
MySQL does not use the double quotes as database object identifiers.

***[Solution:]{.underline}***

Check your programs for database object names having double quotes:\
\
   WHERE \"tabname\".\"colname\" = \"a string value\"\
\
should be written as follows:\
\
   WHERE tabname.colname = \'a string value\'

------------------------------------------------------------------------

[ODIMYS021 - NUMERIC data types]{#ODIMYS021}

INFORMIX supports several data types to store numbers:

::: {align="center"}
  ------------------------ --------------------------------------------
  **INFORMIX Data Type**   **Description**
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

**[*Solution:*]{.underline}**

MySQL supports the following data types to store numbers:

::: {align="center"}
  ------------------------------- ------------------------------------------------------------------
  **MySQL data type**             **Description**
  DECIMAL(p)                      Stores whole numeric numbers up to p digits (not floating point)
  DECIMAL(p,s)                    Maximum precision depends on MySQL Version, see documentation.
  FLOAT\[(M,D)[\]]{.underline}    4 bytes variable precision
  DOUBLE\[(M,D)[\]]{.underline}   8 bytes variable precision
  SMALLINT                        16 bit signed integer
  INTEGER                         32 bit signed integer
  BIGINT                          64 bit signed integer
  ------------------------------- ------------------------------------------------------------------
:::

**Warning:** Before MySQL 5.0.3, the maximum range of DECIMAL values is
the same as for DOUBLE. Since MySQL 5.0.3, DECIMAL can store real
precision numbers as INFORMIX, however, the maximum number of digits
depends on the version of MySQL, see documentation for more details. We
strongly recommend to make tests (INSERT+SELECT) to check if large
decimals are properly inserted and fetched back. 

------------------------------------------------------------------------

[ODIMYS024 - MATCHES and LIKE in SQL conditions]{#ODIMYS024}

INFORMIX supports MATCHES and LIKE in SQL statements. MySQL supports the
LIKE statement as in INFORMIX, plus the \~ operators that are similar
but different from the INFORMIX MATCHES operator.

MATCHES allows brackets to specify a set of matching characters at a
given position:\
   ( col MATCHES \'\[Pp\]aris\' )\
   ( col MATCHES \'\[0-9\]\[a-z\]\*\' )\
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

See also: [MATCHES operator in SQL
Programming](SqlProgramming.html#PORT_MATCHES).

------------------------------------------------------------------------

[ODIMYS025 - INFORMIX specific SQL statements in BDL]{#ODIMYS025}

The BDL compiler supports several INFORMIX specific SQL statements that
have no meaning when using MySQL:

(removed a sentence as unnecessary)

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

[ODIMYS028 - INSERT cursors]{#ODIMYS028}

INFORMIX supports insert cursors. An \"insert cursor\" is a special BDL
cursor declared with an INSERT statement instead of a SELECT statement.
When this kind of cursor is open, you can use the PUT instruction to add
rows and the FLUSH instruction to insert the records into the database.

For INFORMIX database with transactions, OPEN, PUT and FLUSH
instructions must be executed within a transaction.

MySQL does not support insert cursors.

**[*Solution:*]{.underline}**

Insert cursors are emulated by the MySQL database interface.

------------------------------------------------------------------------

[ODIMYS031 - Cursors WITH HOLD]{#ODIMYS031}

INFORMIX closes opened cursors automatically when a transaction ends
unless the WITH HOLD option is used in the DECLARE instruction. In
MySQL, opened cursors using SELECT statements without a FOR UPDATE
clause are not closed when a transaction ends. Actually, all MySQL
cursors are \'WITH HOLD\' cursors unless the FOR UPDATE clause is used
in the SELECT statement.

**Warning:** Cursors declared FOR UPDATE and using the WITH HOLD option
cannot be supported with MySQL because FOR UPDATE cursors are
automatically closed by MySQL when the transaction ends.

**[*Solution:*]{.underline}**

BDL cursors that are not declared \"WITH HOLD\" are automatically closed
by the database interface when a COMMIT WORK or ROLLBACK WORK is
performed.

**Warning:** Since MySQL automatically closes FOR UPDATE cursors when
the transaction ends, opening cursors declared FOR UPDATE and WITH HOLD
option results in an SQL error that does not normally appear with
INFORMIX, in the same conditions. Review the program logic in order to
find another way to set locks.

------------------------------------------------------------------------

[ODIMYS032 - UPDATE/DELETE WHERE CURRENT OF \<cursor\>]{#ODIMYS032}

INFORMIX allows positioned UPDATEs and DELETEs with the \"WHERE CURRENT
OF \<cursor\>\" clause, if the cursor has been DECLARED with a SELECT
\... FOR UPDATE statement.

**[*Solution:*]{.underline}**

**Warning:** WHERE CURRENT OF is not supported by MySQL.

------------------------------------------------------------------------

[ODIMYS034 - Syntax of UPDATE statements]{#ODIMYS034}

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

[ODIMYS036 - INTERVAL data type]{#ODIMYS036}

INFORMIX INTERVAL data type stores a value that represents a span of
time. INTERVAL types are divided into two classes : *year-month
intervals* and *day-time intervals*.

MySQL provides an INTERVAL data type, but it is totally different from
the INFORMIX INTERVAL type. For example, you specify an INTERVAL literal
as follows :

    25 years 2 months 23 days

**[*Solution:*]{.underline}**

**Warning:** The INTERVAL data type is not well supported because the
database server has no equivalent native data type. However, you can
store into and retrieve from CHAR columns BDL INTERVAL values.

------------------------------------------------------------------------

[ODIMYS039 - Data storage concepts]{#ODIMYS039}

An attempt should be made to preserve as much of the storage information
as possible when converting from INFORMIX to MySQL. Most important
storage decisions made for INFORMIX database objects (like initial sizes
and physical placement) can be reused for the MySQL database.

Storage concepts are quite similar in INFORMIX and in MySQL, but the
names are different.

------------------------------------------------------------------------

[ODIMYS046 - The LOAD and UNLOAD instructions]{#ODIMYS046}

INFORMIX provides two SQL instructions to export / import data from /
into a database table: The UNLOAD instruction copies rows from a
database table into a text file and the LOAD instructions insert rows
from a text file into a database table.

MySQL does not provide LOAD and UNLOAD instructions.

**[*Solution:*]{.underline}**

LOAD and UNLOAD instructions are supported.

------------------------------------------------------------------------

[ODIMYS047 - SQL Interruption]{#ODIMYS047}

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

**Warning:** SQL Interruption is not supported with MySQL.

------------------------------------------------------------------------

## [ODIMYS048 - Scrollable Cursors]{#ODIMYS048}

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

MySQL 6.0 does not support native scrollable cursors.

***[Solution:]{.underline}***

The MySQL database driver emulates scrollable cursors with temporary
files. On UNIX, the temp files are created in the directory defined by
the DBTEMP, TMPDIR, TEMP or TMP environment variables (the default is
/tmp). On Windows, the temp files are created with the \_tempnam()
MSVCRT API call. 

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

[ODIMYS100 - Data type conversion table]{#ODIMYS100}

::: {align="center"}
  -------------------------- ----------------------------------------
  **INFORMIX Data Types**    **MySQL Data Types**
  CHAR(n)                    CHAR(n) (n\>255c =\> TEXT(n))
  VARCHAR(n)                 VARCHAR(n) (n\>255c =\> TEXT(n))
  BOOLEAN                    BOOLEAN
  SMALLINT                   SMALLINT
  INTEGER                    INTEGER
  BIGINT                     BIGINT
  DOUBLE PREC/FLOAT\[(n)\]   DOUBLE
  REAL/SMALLFLOAT            FLOAT
  DECIMAL(p,s)               DECIMAL(p,s)
  MONEY(p,s)                 DECIMAL(p,s)
  DATE                       DATE
  DATETIME HOUR TO SECOND    TIME
  DATETIME q1 TO q2          DATETIME (YYY-MM-DD hh:mm:ss)
  INTERVAL q1 TO q2          CHAR(50)
  TEXT                       MEDIUMTEXT / LONGTEXT (using \<= 2Gb!)
  BYTE                       MEDIUMBLOB / LONGBLOB (using \<= 2Gb!)
  -------------------------- ----------------------------------------
:::
