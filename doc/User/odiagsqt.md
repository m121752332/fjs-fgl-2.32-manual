[Back to Contents](../index.html)

------------------------------------------------------------------------

# ODI Adaptation Guide For SQLite 3.5.x, 3.6.x

Installation

::: {align="center"}
  --------------------------------------------------------
  [Install SQLite and create a database](#ODISQT_PREP01)
  [Prepare the runtime environment](#ODISQT_PREP02)
  --------------------------------------------------------
:::

Database concepts

::: {align="center"}
  ----------------------------------------
  [Database concepts](#ODISQT007a)
  [Concurrency management](#ODISQT008a)
  [Transactions handling](#ODISQT009a)
  [Defining database users](#ODISQT016a)
  ----------------------------------------
:::

Data dictionary

::: {align="center"}
  --------------------------------------------
  [CHARACTER data types](#ODISQT011a)
  [NUMERIC data types](#ODISQT021)
  [DATE and DATETIME data types](#ODISQT001)
  [INTERVAL data type](#ODISQT036)
  [SERIAL data types](#ODISQT005)
  [ROWIDs](#ODISQT004)
  [Very large data types](#ODISQT030)
  [Data type conversion table](#ODISQT100)
  --------------------------------------------
:::

Data manipulation

::: {align="center"}
  -------------------------------------------
  [Outer joins](#ODISQT006)
  [Transactions handling](#ODISQT009a)
  [Temporary tables](#ODISQT017)
  [MATCHES and LIKE conditions](#ODISQT024)
  [Syntax of UPDATE statements](#ODISQT034)
  -------------------------------------------
:::

BDL programming

::: {align="center"}
  ---------------------------------------------------------
  [SERIAL data type](#ODISQT005)
  [INFORMIX specific SQL statements in BDL](#ODISQT025)
  [INSERT cursors](#ODISQT028)
  [SELECT FOR UPDATE](#ODISQT008b)
  [UPDATE/DELETE WHERE CURRENT OF \<cursor\>](#ODISQT032)
  [The LOAD and UNLOAD instructions](#ODISQT046)
  [Scrollable Cursors](#ODISQT048)
  ---------------------------------------------------------
:::

------------------------------------------------------------------------

## [Runtime configuration]{#ODISQT_PREP} {#runtime-configuration align="left"}

> ### [Install SQLite and create a database]{#ODISQT_PREP01} {#install-sqlite-and-create-a-database align="left"}
>
> 1.  Install the SQLite software on your computer. The minimum required
>     version is SQLite **3.5.9**.
>
> 2.  To create a new database with SQLite, you just need to start the
>     sqlite3 command line tool and issue an SQL statement.\
>     \
>        \$ sqlite3-3.5.9.bin /var/data/stores.db\
>        sqlite\> CREATE TABLE customer ( cust_id INT PRIMARY KEY, \...
>     );\
>        \$ .exit 

> ### [Prepare the runtime environment]{#ODISQT_PREP02} {#prepare-the-runtime-environment align="left"}
>
> 1.  In order to connect to SQLite, you must have a database driver
>     \"**dbmsqt\***\" in FGLDIR/dbdrivers.
>
> 2.  Make sure that the SQLite environment variables are properly set.
>     You may want to define an environment variable such as
>     **SQLITEDIR** the hold the installation directory of SQLite, which
>     can then be used to set PATH and LD_LIBRARY_PATH. See SQLite
>     documentation for more details.
>
> 3.  Verify the environment variable defining the search path for
>     database client shared library. On UNIX platforms, the variable is
>     specific to the operating system. For example, on Solaris and
>     Linux systems, it is **LD_LIBRARY_PATH**, on AIX it is
>     **LIBPATH**, or HP/UX it is **SHLIB_PATH**. On Windows, you define
>     the DLL search path in the **PATH** environment variable.
>
>     +-----------------------------------+-----------------------------------+
>     | **SQLite version**                | **Shared library environment      |
>     |                                   | setting**                         |
>     +-----------------------------------+-----------------------------------+
>     | **SQLite 3.5 and higher**         | *UNIX*: Add **\$SQLITEDIR/lib**   |
>     |                                   | to LD_LIBRARY_PATH (or its        |
>     |                                   | equivalent).\                     |
>     |                                   | *Windows*: Add                    |
>     |                                   | **%SQLITEDIR%\\bin** to PATH.     |
>     +-----------------------------------+-----------------------------------+
>     |                                   |                                   |
>     +-----------------------------------+-----------------------------------+
>
> 4.  Make sure that all operating system users running the application
>     have read/write access to the database file.
>
> 5.  SQLite uses UTF-8 encoding. If the locale used by the runtime
>     system (**LANG/LC_ALL**) is not compatible to UTF-8 (for example,
>     fr_FR.iso88591), you need the **iconv** library to be installed on
>     the system. The iconv library will be automatically used if the
>     current character set is not compatible with UTF-8, to make
>     charset conversion between the application locale and the SQLite
>     UTF-8 charset. 
>
> 6.  Set up the **fglprofile** entries for [database
>     connections](Connections.html#DS_ODI_DBVSPEC).\
>     \
>     **Warning:** **Make sure that you are using the ODI driver
>     corresponding to the database client and server version. Because
>     Informix features emulation are dependant from the database server
>     version, it is mandatory to use the same version of the database
>     client and ODI driver as the server version.**\
>     \
>     Note that the \'**source**\' parameter defines the path to the
>     SQLite database file.

------------------------------------------------------------------------

## [ODISQT001 - DATE and DATETIME data types]{#ODISQT001}

INFORMIX provides two data types to store date and time information:

- **DATE** = for year, month and day storage.
- **DATETIME** = for year to fraction(1-5) storage.

SQLite 3 does not have a native type for date/time storage, but you can
use data/time type names and functions based on the string
representation of dates and times. The date/time values are stored in
the TEXT native type. The date/time functions of SQLite are based on
standard DATE (YYYY-MM-DD), TIME (hh:mm:ss) and TIMESTAMP (YYYY-MM-DD
hh:mm:ss) concepts.

**[*Solution:*]{.underline}**

INFORMIX DATE type is not translated, it will be used as is by SQLite.

INFORMIX DATETIME HOUR TO SECOND type is translated to TIME.

INFORMIX DATETIME YEAR TO FRACTION and all other combinations are
translated to TIMESTAMP.

------------------------------------------------------------------------

## [ODISQT004 - ROWIDs]{#ODISQT004}

When creating a table, INFORMIX automatically adds a \"ROWID\" integer
column (applies to non-fragmented tables only). The ROWID column is
auto-filled with a unique number and can be used like a primary key to
access a given row.

SQLite supports ROWIDs columns as 64-bit integers. INFORMIX ROWIDs are
16-bit integers.

With INFORMIX, SQLCA.SQLERRD\[6\] contains the ROWID of the last
INSERTed or UPDATEd row. This is not supported with SQLite because
SQLite ROWID are not INTEGERs.

***[Solution:]{.underline}***

If the BDL application uses INFORMIX ROWIDs as primary keys, the program
logic should be reviewed in order to use the real primary keys.

If you cannot avoid the use of rowids, you must change the type of the
variables which hold ROWID values. Instead of using INTEGER, you must
use DECIMAL(20).

**Warning:** All references to SQLCA.SQLERRD\[6\] must be removed
because this variable will not contain the ROWID of the last INSERTed or
UPDATEd row when using the SQLite interface.

------------------------------------------------------------------------

## [ODISQT005 - SERIAL data types]{#ODISQT005}

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

SQLite supports the **AUTOINCREMENT** attribute for columns:

- Only one column must be declared as INTEGER PRIMARY KEY AUTOINCREMENT.
- To get the last generated number, SQLite provides the
  **sqlite_sequence** table:\
     SELECT seq FROM sqlite_sequence WHERE name=\'table_name\';
- When inserting a zero in the auto-increment column, SQLite will not
  generate a new sequence like Informix.
- When inserting a NULL in the auto-increment column, SQLite generates a
  new sequence, Informix denies NULLs in SERIALs.

INFORMIX allows you to insert rows with a value different from zero for
a serial column. Using an explicit value will automatically increment
the internal serial counter, to avoid conflicts with future INSERTs that
are using a zero value:\
    CREATE TABLE tab ( k SERIAL );  \--\> internal counter = 0\
    INSERT INTO tab VALUES ( 0 );   \--\> internal counter = 1\
    INSERT INTO tab VALUES ( 10 );  \--\> internal counter = 10\
    INSERT INTO tab VALUES ( 0 );   \--\> internal counter = 11\
    DELETE FROM tab;                \--\> internal counter = 11\
    INSERT INTO tab VALUES ( 0 );   \--\> internal counter = 12

**[*Solution:*]{.underline}**

When using SQLite, the SERIAL data type is converted to INTEGER PRIMARY
KEY AUTOINCREMENT.

**Warning:** Because SQLite does not behave like Informix regarding zero
and NULL value specification for auto-incremented columns, all INSERT
statements must be reviewed to remove the SERIAL column from the list.\
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

[ODISQT006 - Outer joins]{#ODISQT006}

The original syntax of OUTER joins of INFORMIX is different from the
SQLite outer join syntax:

In INFORMIX SQL, outer tables are defined in the FROM clause with the
**OUTER** keyword :

> SELECT ... FROM a, OUTER(b) WHERE a.key = b.akey
>
>     SELECT ... FROM a, OUTER(b,OUTER(c)) WHERE a.key = b.akey AND b.key1 = c.bkey1 AND b.key2 = c.bkey2 

SQLite 3 supports the ANSI outer join syntax:

> SELECT ... FROM cust LEFT OUTER JOIN order
>                          ON cust.key = order.custno
>
>     SELECT ...
>       FROM cust LEFT OUTER JOIN order
>                      LEFT OUTER JOIN item
>                      ON order.key = item.ordno
>                 ON cust.key = order.custno
>      WHERE order.accepted = 1

See the SQLite 3 SQL reference for a complete description of the syntax.

***[Solution:]{.underline}***

For better SQL portability, you should use the ANSI outer join syntax
instead of the old Informix OUTER syntax.

The SQLite 3 interface can convert most INFORMIX OUTER specifications to
SQLite 3 outer joins.

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
4.  [Temporary tables](#ODISQT017) are supported in OUTER
    specifications.

------------------------------------------------------------------------

[ODISQT007a - Database concepts]{#ODISQT007a}

INFORMIX servers can handle multiple database entities, while SQLite can
manage several database files.

**[*Solution:*]{.underline}**

Map each INFORMIX database to a SQLite database file.

------------------------------------------------------------------------

## [ODISQT008a - Concurrency management]{#ODISQT008a}

INFORMIX is a multi-user database engine, while SQLite is typically used
for a single-user application. SQLite 3 supports multi-user access to
the same database file, but this lightweight database engine is not
designed for large multi-user applications.

**[*Solution:*]{.underline}**

We recommend to use SQLite for single-user DB applications.

------------------------------------------------------------------------

[ODISQT008b - SELECT FOR UPDATE]{#ODISQT008b}

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

SQLite does not support the FOR UPDATE close in SELECT syntax.

**[*Solution:*]{.underline}**

**Warning:** You must review the program logic and remove SELECT \...
FOR UPDATE statements.

------------------------------------------------------------------------

[ODISQT009a - Transactions handling]{#ODISQT009a}

INFORMIX and SQLite have similar commands to begin, commit or rollback
transaction. There are however some important differences you must be
aware of.

With SQLite, DDL statements can be executed (and canceled) in
transaction blocks, as with INFORMIX.

INFORMIX version 11.50 introduces savepoints with the following
instructions:

        SAVEPOINT name [UNIQUE]
        ROLLBACK [WORK] TO SAVEPOINT [name] ]
        RELEASE SAVEPOINT name

SQLite supports savepoints too. However, there are differences:

1.  SAVEPOINT can be used instead of BEGIN TRANSACTION. In this case,
    RELEASE is like a COMMIT.
2.  The syntax of rollback to savepoint is ROLLBACK \[TRANSACTION\] TO
    \[SAVEPOINT\] *name*.
3.  The syntax of release to savepoint is RELEASE \[SAVEPOINT\] *name*.
4.  Rollback must always specify the savepoint name.
5.  **You cannot rollback to a savepoint if cursors are opened.**

**[*Solution:*]{.underline}**

Regarding transaction control instructions, BDL applications do not have
to be modified in order to work with SQLite. The BEGIN WORK, COMMIT WORK
and ROLLBACK WORK commands are translated the native commands of SQLite.

**Warning:** If you want to use savepoints, always specify the savepoint
name in ROLLBACK TO SAVEPOINT and do not open cursors during
transactions using savepoints.

See also [ODISQT008b](#ODISQT008b)

------------------------------------------------------------------------

## [ODIMYS010 - BOOLEAN data type]{#ODIMYS010}

INFORMIX supports the BOOLEAN data type, which can store \'t\' or \'f\'
values. Genero BDL implements the BOOLEAN data type in a different way:
As in other programming languages, Genero BOOLEAN stores integer values
1 or 0 (for TRUE or FALSE). The type was designed this way to assign the
result of a Boolean expression to a BOOLEAN variable.

SQLite does not implement a native BOOLEAN type, but accepts BOOLEAN in
the SQL syntax.

**[*Solution:*]{.underline}**

The SQLite database interface supports the BOOLEAN data type, and
converts the BDL BOOLEAN integer values to a CHAR(1) of \'1\' or \'0\'.

------------------------------------------------------------------------

[ODISQT011a - CHARACTER data types]{#ODISQT011a}

INFORMIX provides the CHAR and VARCHAR data types to store characters.
CHAR columns can store up to **32767** chars, and VARCHARs are limited
to **255**. Starting with IDS 2000, INFORMIX provides the LVARCHAR data
type which is limited to 2K.

SQLite 3 provides the TEXT native data type with no strict size
limitation. CHAR(n), VARCHAR(n), NCHAR(n) and NVARCHAR(n) type names can
be used and will be stored as TEXT.

SQLite treats empty strings as NOT NULL values like INFORMIX.

**Warning**: When comparing VARCHAR [or CHAR]{.underline} values in
SQLite, the trailing blanks are significant; this is not the case when
using INFORMIX VARCHAR and CHAR values.

::: {align="center"}
  --------------- --------------------- -------------------------
  **Data type**   **INFORMIX**          **SQLite**
  CHAR            \'aaa  \' = \'aaa\'   \'aaa   \' \<\> \'aaa\'
  VARCHAR         \'aaa  \' = \'aaa\'   \'aaa   \' \<\> \'aaa\'
  --------------- --------------------- -------------------------
:::

**Warning** : SQLite supports only the UTF-8 character encoding. Thus,
client applications must provide UTF-8 encoded strings.

**[*Solution:*]{.underline}**

The database interface supports character string variables in SQL
statements for input (BDL USING) and output (BDL INTO).

**Warning:** Since CHAR and VARCHAR comparison in SQLite takes trailing
blanks into account, some queries returning rows with INFORMIX may not
return the same result set with SQLite.

Regarding character sets, the SQLite database driver automatically
converts character strings used in the Genero programs to/from UTF-8 for
SQLite, as long as the iconv library is available on the system and can
be loaded. For more details, see installation & setup at the beginning
of this guide.

See also the section about [Localization](Localization.html).

------------------------------------------------------------------------

[ODISQT016a - Defining database users]{#ODISQT016a}

INFORMIX supports database users that must be explicitly declared to the
database by granting privileges.

SQLite does not have database users concept. However, the operating
system user must have read/write access to the database file. 

**[*Solution:*]{.underline}**

SQLite is mainly designed for single-user applications.

------------------------------------------------------------------------

[ODISQT017 - Temporary tables]{#ODISQT017}

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

SQLite supports temporary tables with the **CREATE TEMP TABLE**
statement.

***[Solution:]{.underline}***

INFORMIX CREATE TEMP TABLE statements are kept as is and SELECT INTO
TEMP statements are converted to SQLite native SQL CREATE TEMP TABLE AS
SELECT \...

------------------------------------------------------------------------

[ODISQT021 - NUMERIC data types]{#ODISQT021}

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

SQLite 3 supports only INTEGER and FLOAT native types to store numbers,
but allows synonyms for these native types:

::: {align="center"}
  ------------------------ --------------------------------------------------------------
  **SQLite data type**     **Description**
  INTEGER                  4 byte integer like INFORMIX
  REAL                     8 byte floating point like INFORMIX DOUBLE PRECISION / FLOAT
  **Supported synonyms**   **Native type**
  SMALLINT                 INTEGER
  SMALLFLOAT               FLOAT
  DECIMAL(p,s)             FLOAT
  MONEY(p,s)               FLOAT
  ------------------------ --------------------------------------------------------------
:::

**Warning:** Exact decimal types like DECIMAL(p,s) may be stored as
floating point numbers (REAL), INTEGERs or TEXT, according to the type
affinity selected by SQLite. When converted to FLOAT, data loss and
rounding rule differences are possible with SQLite.

**[*Solution:*]{.underline}**

INFORMIX numeric types are not translated by the database driver.

**Warning:** Since SQLite 3 does not have exact decimal types like
DECIMAL(p,s), you must pay attention to the rounding rules and data loss
when using numbers with many significant digits. Arithmetic operations
like division have different results as with INFORMIX. You better fetch
the original column value into a DECIMAL variable and do arithmetic
operations in the application program.

------------------------------------------------------------------------

[ODISQT024 - MATCHES and LIKE in SQL conditions]{#ODISQT024}

INFORMIX supports MATCHES and LIKE in SQL statements, while SQLite
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

See also: [MATCHES operator in SQL
Programming](SqlProgramming.html#PORT_MATCHES).

------------------------------------------------------------------------

## [ODISQT025 - INFORMIX specific SQL statements in BDL]{#ODISQT025}

The BDL compiler supports several INFORMIX specific SQL statements that
have no meaning when using SQLite:

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

[ODISQT028 - INSERT cursors]{#ODISQT028}

INFORMIX supports insert cursors. An \"insert cursor\" is a special BDL
cursor declared with an INSERT statement instead of a SELECT statement.
When this kind of cursor is open, you can use the PUT instruction to add
rows and the FLUSH instruction to insert the records into the database.

For INFORMIX database with transactions, OPEN, PUT and FLUSH
instructions must be executed within a transaction.

SQLite does not support insert cursors.

**[*Solution:*]{.underline}**

Insert cursors are emulated by the SQLite database interface.

------------------------------------------------------------------------

[ODISQT030 - Very large data types]{#ODISQT030}

INFORMIX uses the TEXT and BYTE data types to store very large texts or
images.SQLite 3 provides TEXT and BLOB native data types.

**[*Solution:*]{.underline}**

The SQLite database interface can convert BDL TEXT data to TEXT and BYTE
data to BLOB.

------------------------------------------------------------------------

[ODISQT032 - UPDATE/DELETE WHERE CURRENT OF \<cursor\>]{#ODISQT032}

INFORMIX allows positioned UPDATEs and DELETEs with the \"WHERE CURRENT
OF \<cursor\>\" clause, if the cursor has been DECLARED with a SELECT
\... FOR UPDATE statement.

**Warning:** SELECT \... FOR UPDATE is not supported by SQLite.

**[*Solution:*]{.underline}**

Review the program logic and use primary keys to update the rows.

------------------------------------------------------------------------

[ODISQT034 - Syntax of UPDATE statements]{#ODISQT034}

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

[ODISQT036 - INTERVAL data type]{#ODISQT036}

INFORMIX\'s INTERVAL data type stores a value that represents a span of
time. INTERVAL types are divided into two classes : ***year-month
intervals*** and ***day-time intervals*.**

SQLite 3 does not provide a data type similar to INFORMIX INTERVAL.

**[*Solution:*]{.underline}**

It is not recommended that you use the INTERVAL data type because SQLite
3 has no equivalent native data type. This would cause problems when
doing INTERVAL arithmetic on the database server side. However, INTERVAL
values can be stored in CHAR(TEXT) columns.

------------------------------------------------------------------------

[ODISQT046 - The LOAD and UNLOAD instructions]{#ODISQT046}

INFORMIX provides two SQL instructions to export / import data from /
into a database table: The UNLOAD instruction copies rows from a
database table into a text file and the LOAD instructions insert rows
from a text file into a database table.

SQLite 3.0 does not natively provide LOAD / UNLOAD instructions.

***[Solution:]{.underline}***

LOAD and UNLOAD instructions are supported.

------------------------------------------------------------------------

## [ODISQT048 - Scrollable Cursors]{#ODISQT048}

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

SQLite 3.x does not support native scrollable cursors.

***[Solution:]{.underline}***

The SQLite database driver emulates scrollable cursors with temporary
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

[ODISQT100 - Data type conversion table]{#ODISQT100}

::: {align="center"}
  --------------------------- -----------------------
  **INFORMIX Data Types**     **SQLite Data Types**
  CHAR(n)                     CHAR(n)
  VARCHAR(n)                  VARCHAR(n)
  BOOLEAN                     BOOLEAN
  SMALLINT                    SMALLINT
  INTEGER                     INTEGER
  BIGINT                      BIGINT
  INT8                        BIGINT
  FLOAT\[(n)\]                FLOAT
  SMALLFLOAT                  SMALLFLOAT
  DECIMAL(p,s)                DECIMAL(p,s)
  DECIMAL(p)                  DECIMAL(p,s)
  MONEY(p,s)                  DECIMAL(p,s)
  TEXT                        TEXT
  BYTE                        BLOB
  DATE                        DATE
  DATETIME HOUR TO SECOND     TIME
  DATETIME YEAR TO FRACTION   TIMESTAMP
  --------------------------- -----------------------
:::
