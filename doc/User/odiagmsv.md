[Back to Contents](../index.html)

------------------------------------------------------------------------

# ODI Adaptation Guide For SQL SERVER 2000, 2005, 2008

Installation

::: {align="center"}
  ------------------------------------------------------------
  [Install SQL SERVER and create a database](#ODIMSV_PREP01)
  [Prepare the runtime environment](#ODIMSV_PREP02)
  ------------------------------------------------------------
:::

Database concepts

::: {align="center"}
  ------------------------------------------------------------
  [Database concepts](#ODIMSV007a)
  [Data storage concepts](#ODIMSV039)
  [Data consistency and concurrency management](#ODIMSV008a)
  [Transactions handling](#ODIMSV009)
  [Defining database users](#ODIMSV016a)
  [Setting privileges](#ODIMSV016b)
  ------------------------------------------------------------
:::

Data dictionary

::: {align="center"}
  ----------------------------------------------
  [BOOLEAN data type](#ODIMSV010)
  [CHARACTER data types](#ODIMSV011)
  [NUMERIC data types](#ODIMSV021)
  [DATE and DATETIME data types](#ODIMSV001)
  [INTERVAL data type](#ODIMSV036)
  [SERIAL data types](#ODIMSV005)
  [ROWIDs](#ODIMSV004)
  [Case sensitivity](#ODIMSV047)
  [Very large data types](#ODIMSV030)
  [The ALTER TABLE instruction](#ODIMSV053)
  [Constraints](#ODIMSV012)
  [Triggers](#ODIMSV013)
  [Stored procedures](#ODIMSV014)
  [Name resolution of SQL objects](#ODIMSV019)
  [Setup database statistics](#ODIMSV051)
  [Data type conversion table](#ODIMSV100)
  ----------------------------------------------
:::

Data manipulation

::: {align="center"}
  ----------------------------------------------
  [Reserved words](#ODIMSV003)
  [Outer joins](#ODIMSV006)
  [Transactions handling](#ODIMSV009)
  [Temporary tables](#ODIMSV017)
  [Substrings in SQL](#ODIMSV018)
  [Name resolution of SQL objects](#ODIMSV019)
  [String delimiters](#ODIMSV020)
  [Getting one row with SELECT](#ODIMSV022)
  [MATCHES and LIKE conditions](#ODIMSV024)
  [Querying system catalog tables](#ODIMSV033)
  [Syntax of UPDATE statements](#ODIMSV034)
  [The LENGTH() function](#ODIMSV035)
  ----------------------------------------------
:::

BDL programming

::: {align="center"}
  -------------------------------------------------------
  [Executing SQL statements](#ODIMSV041)
  [SERIAL data type](#ODIMSV005)
  [INFORMIX specific SQL statements in BDL](#ODIMSV025)
  [INSERT cursors](#ODIMSV028)
  [Cursors WITH HOLD](#ODIMSV031)
  [SELECT FOR UPDATE](#ODIMSV008b)
  [The LOAD and UNLOAD instructions](#ODIMSV046)
  [SQL Interruption](#ODIMSV054)
  [Scrollable Cursors](#ODIMSV055)
  -------------------------------------------------------
:::

------------------------------------------------------------------------

## [Runtime configuration]{#ODIMSV_PREP} {#runtime-configuration align="left"}

> ### [Install SQL SERVER and create a database]{#ODIMSV_PREP01} {#install-sql-server-and-create-a-database align="left"}
>
> 1.  Install the Microsoft SQL SERVER on your computer.\
>     \
>     **Warning: Make sure that you select the correct collation when
>     installing SQL Server: The default collation will apply to the
>     tempdb database and will also be used for temporary tables,
>     instead of inheriting the collation of the current database. If
>     the default server collation does not match the collation of the
>     current database, you will experience character set conflicts
>     between permanent tables and temporary tables (SQL Server error
>     message 468).**
>
> 2.  Create a SQL SERVER **database** entity with the SQL SERVER
>     Management Studio.\
>     \
>     In the database properties:
>
>     - Choose the right **code page / collation** to get a
>       case-sensitive database; this cannot be changed later. Remember
>       collation defines the character set for CHAR/VARCHAR columns,
>       while NCHAR/NVARCHAR columns are always storing UNICODE (UCS-2)
>       characters.\
>       Note that Informix collation order is code-set based for
>       CHAR/VARCHAR/TEXT columns. If you want to get the same sort
>       order with SQL Server, you will need to use a binary collation
>       such as Latin1_General_BIN.
>
>     - Make sure the **\"ANSI NULL Default\"** option is **TRUE** if
>       you want to have the same default NULL constraint as in INFORMIX
>       (i.e. a column created without a NULL constraint will allow null
>       values, users must specify NOT NULL to deny nulls).
>
>     - Make sure the **\"Quoted Identifiers Enabled\"** option is
>       **FALSE** to use database object names without quotes as in
>       INFORMIX.
>
> 3.  Create and declare a database user dedicated to your application:
>     the **application administrator**.
>
> 4.  If you plan to use SERIAL emulation based on triggers using a
>     registration table, create the SERIALREG table and create the
>     serial triggers for all tables using a SERIAL. See issue
>     [ODIMSV005](#ODIMSV005) for more details.
>
> 5.  Create the **application tables**. Do not forget to convert
>     INFORMIX data types to SQL SERVER data types. See  issue
>     [ODIMSV100](#ODIMSV100) for more details.\
>     **Warning:** In order to make application tables visible to all
>     users, make sure that the tables are created with the \'**dbo**\'
>     owner.
>
> ### [Prepare the runtime environment]{#ODIMSV_PREP02} {#prepare-the-runtime-environment align="left"}
>
> 1.  Genero BDL provides several database drivers based on different
>     ODBC clients. The list below describes each of them:
>
>     - The **MSV** database driver works with the Microsoft Data Access
>       Components (MDAC) ODBC driver (SQLSVR32.DLL), and can be used
>       with SQL SERVER 2000.\
>       The **MSV** database driver has always been supported by Genero,
>       but is not available for SQL SERVER 2008.\
>       The **MSV** database driver does not support multi-byte
>       character sets.\
>       This driver is provided for backward compatibility with SQL
>       SERVER 2000, you must use the SNC driver for younger SQL SERVER
>       versions.
>
>     - Starting with SQL SERVER 2005, it is recommended that you use
>       the **SNC** database driver based on the new SQL Native Client
>       ODBC driver (SQLNCLI.DLL). This is the new ODBC driver provided
>       by Microsoft for SQL SERVER 2005 and higher.\
>       Note that the **SNC** database driver is not supported in a VC++
>       6 environment.\
>       The **SNC** database driver is supported starting from Genero
>       2.10.
>
>     - The **FTM** driver is based on the FreeTDS ODBC client
>       ([www.freetds.org](http://www.freetds.org)). This driver can be
>       used with FreeTDS to connect from a UNIX platform to a Windows
>       platform running SQL SERVER.\
>       You need at least FreeTDS version **0.83**.\
>       The **FTM** driver is supported starting from Genero 2.11.
>
>     - The **ESM** driver is based on the EasySoft ODBC driver for SQL
>       Server ([www.easysoft.com](http://www.easysoft.com)). This
>       driver can be used with EasySoft to connect from a UNIX platform
>       to a Windows platform running SQL SERVER.\
>       You need at least EasySoft version **1.2.3**.\
>       The **ESM** driver is supported starting from Genero 2.21.
>
> 2.  Check that the Genero distribution package has installed the SQL
>     SERVER database driver you need (i.e. a \"**dbmmsv\***\",
>     \"**dbmsnc\***\", \"**dbmftm**\*\" or \"**dbmesm**\*\" driver must
>     exist in FGLDIR/dbdrivers.
>
> 3.  An ODBC data source must be configured to allow the BDL program to
>     establish connections to SQL SERVER. Make sure you select the
>     correct ODBC driver (**MSV** = \"SQL SERVER\", **SNC** = \"SQL
>     Native Client\", **FTM** = \"FreeTDS\", **ESM** = \"EasySoft\").\
>     **Warning:** When using the **FTM** (FreeTDS) or **ESM**
>     (EasySoft) database driver, you have to define the ODBCINI and
>     ODBCINST environment variable to point to the odbc.ini and
>     odbcinst.ini files.
>
> 4.  Install and configure the database client software:
>
>     - When using the **MSV** database driver, you must have the
>       **Microsoft Data Access Components (MDAC)** installed on the
>       computer running Genero applications.\
>       \
>       Since the MSV driver is using **ODBC32.DLL**, there is no need
>       to set the PATH environment variable to a specific database
>       client library path.\
>       \
>       The database client **locale** is defined by the regional
>       settings of the application server and must match the locale
>       used by the BDL application. If the LANG environment variable is
>       not defined, the application character set defaults to the
>       current ANSI code page (ACP).\
>       \
>       Make sure that the ODBC data source has the \"Perform
>       translation for character data\" option checked: Character set
>       conversions between the client ANSI Code Page and the server
>       collation must be done by the MDAC ODBC client.
>
>     - When using the **SNC** database driver, you must have the
>       **Microsoft SQL SERVER Native Client software** installed on the
>       computer running Genero applications.\
>       \
>       Since the SNC driver is using **ODBC32.DLL**, there is no need
>       to set the PATH environment variable to a specific database
>       client library path.\
>       \
>       The database client **locale** is defined by the regional
>       settings of the application server and must match the locale
>       used by the BDL application. Character set conversion (Current
>       code set \<=\> Wide-Char) is done by the SNC ODI driver
>       according to the LANG environment variable. If the LANG
>       environment variable is not defined, the application character
>       set defaults to the ANSI code page (ACP).
>
>     <!-- -->
>
>     - When using the **FTM** database driver, you must install
>       **FreeTDS** ([www.freetds.org](http://www.freetds.org)).\
>       \
>       Make sure the FreeTDS environment variables are properly set.
>       Check for example **FREETDS** (the path to the configuration
>       file). See FreeTDS documentation for more details.\
>       \
>       Note that with the FTM driver, there is no need to install a
>       driver manager like unixODBC: The **FTM** database driver is
>       linked directly with the **libtdsodbc.so** shared library.
>       Verify the environment variable defining the search path for
>       that database client shared library. On UNIX platforms, the
>       variable is specific to the operating system. For example, on
>       Solaris and Linux systems, it is **LD_LIBRARY_PATH**, on AIX it
>       is **LIBPATH**, or HP/UX it is **SHLIB_PATH**.\
>       \
>       You must create the odbc.ini and odbcinst.ini files to defined
>       the data source.\
>       \
>       Do not forget to define the client character set for FreeTDS
>       (**client charset** parameter in freetds.conf or
>       **ClientCharset** parameter in odbc.ini). You may need to link
>       FreeTDS with the libiconv library to support character set
>       conversions.\
>       **\
>       Warning:** You must set the TDS protocol version according to
>       the SQL Server version (2000, 2005, 2008, etc), by setting the
>       **tds version** parameter in freetds.conf or **TDS_Version** in
>       odbc.ini. For example, when using SQL Server 2005 and 2008, you
>       must use the TDS protocol version **8.0** or higher.\
>       \
>       See FreeTDS documentation for more details about installation
>       and data source configuration in ODBC files.
>
>     - When using the **ESM** database driver, you must install
>       **EasySoft ODBC for SQL Server**
>       ([www.easysoft.com](http://www.easysoft.com)).\
>       \
>       Make sure the EasySoft environment variables are properly set.
>       Check for example **EASYSOFT_ROOT** (the path to the
>       installation directory). See FreeTDS documentation for more
>       details.\
>       \
>       Note that with the ESM driver, there is no need to install a
>       driver manager like unixODBC: The **ESM** database driver is
>       linked directly with the **libessqlsrv.so** shared library.
>       Verify the environment variable defining the search path for
>       that database client shared library. On UNIX platforms, the
>       variable is specific to the operating system. For example, on
>       Solaris and Linux systems, it is **LD_LIBRARY_PATH**, on AIX it
>       is **LIBPATH**, or HP/UX it is **SHLIB_PATH**.\
>       \
>       You must create the odbc.ini and odbcinst.ini files to defined
>       the data source.\
>       \
>       Do not forget to define the client character set for EasySoft
>       with the **Client_CSet** parameter in odbc.ini. The client
>       character set is an iconv name and must match the
>       [locale](Localization.html) of your Genero application.\
>       **Warning:** When using CHAR/VARCHAR types in the database and
>       when the database collation is different from the client locale,
>       you must also set the **Server_CSet** parameter to an iconv name
>       corresponding to the database collation. For example, if
>       Client_CSet=BIG5 and the db collation is
>       Chinese_Taiwan_Stroke_BIN, you must set Server_CSet=BIG5HKSCS,
>       otherwise invalid data will be returned from the server.\
>       **\
>       Warning:** You must also set the following DSN parameters:\
>          **AnsiNPW=Yes\
>          Mars_Connection=No\
>          QuotedId=No**\
>       \
>       See EasySoft documentation for more details about installation
>       and data source configuration in ODBC files.
>
> 5.  **Warning:** On Windows platforms, BDL programs are executed in a
>     CONSOLE environment, not a GUI environment. CONSOLE and GUI
>     environments may use different code pages on your system. Start
>     the **SQL SERVER** **Configuration Manager** to setup your client
>     environment and make sure no wrong character conversion occurs.
>     See Microsoft SQL SERVER documentation for more details.
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
>     You may want to set the **logintime** parameter to change the
>     default login timeout period, increase the **prefetch.rows**
>     parameter to get better performances with result sets, etc.\
>     \
>     With the **SNC** driver you might consider setting the
>     **snc.widechar** parameter to false if your database columns are
>     defined with the CHAR/VARCHAR/TEXT types (by default the driver is
>     prepared to work with the \"UNICODE\" types NCHAR/NVARCHAR/NTEXT).
>     See [National character data types](#ODIMSV040) for more details.

------------------------------------------------------------------------

[ODIMSV001 - DATE and DATETIME data types]{#ODIMSV001}

INFORMIX provides two data types to store dates and time information:

- **DATE** = for year, month and day storage.
- **DATETIME** = for year to fraction(1-5) storage.

Microsoft SQL SERVER provides two data type to store dates:

- **DATETIME** = for year, month, day, hour, min, second, fraction(3)
  storage (from January 1, 1753 through December 31, 9999). Values are
  rounded to increments of .000, .003, or .007 seconds.
- **SMALLDATETIME** = for year, month, day, hour, minutes storage (from
  January 1, 1900, through June 6, 2079). Values with 29.998 seconds or
  lower are rounded down to the nearest minute; values with 29.999
  seconds or higher are rounded up to the nearest minute.

Starting with Microsoft SQL SERVER 2008, following new date data types
are available:

- **DATE** = for year, month, day storage as INFORMIX DATEs.
- **TIME(n)** = for hour, minute, second and fraction(7) storage. Here
  **n** defines the precision of fractional seconds.
- **DATETIME2(n)** = for year, month, day, hour, minute, second and 
  fraction(7) storage. Here **n** defines the precision of fractional
  seconds.
- **DATETIMEOFFSET(n)** = for year, month, day, hour, minute, second, 
  fraction(7) and time zone information storage. Here **n** defines the
  precision of fractional seconds.

**String representing date time information:**

INFORMIX is able to convert quoted strings to DATE / DATETIME data if
the string contents matches environment parameters (i.e. DBDATE,
GL_DATETIME). As in INFORMIX, Microsoft SQL SERVER can convert quoted
strings to DATETIME data. The CONVERT( ) SQL function allows you to
convert strings to dates.

**Date time arithmetic:**

- INFORMIX supports date arithmetic on DATE and DATETIME values. The
  result of an arithmetic expression involving dates/times is a number
  of days when only DATEs are used and an INTERVAL value if a DATETIME
  is used in the expression.
- INFORMIX automatically converts an integer to a date when the integer
  is used to set a value of a date column. Microsoft SQL SERVER does not
  support this automatic conversion.
- Complex DATETIME expressions ( involving INTERVAL values for example)
  are INFORMIX specific and have no equivalent in Microsoft SQL SERVER.
- Microsoft SQL SERVER does not allow direct arithmetic operations on
  datetimes; the date handling SQL functions must be used instead
  (DATEADD & DATEDIFF).
- The SQL SERVER provides equivalent functions for YEAR(), MONTH() and
  DAY(). Be careful with the DAY(*n*) function on SQL SERVER because it
  begins from January 1, 1900 while INFORMIX begins from December 31,
  1899.

::: {align="center"}
+-----------------------------------+-----------------------------------+
| **INFORMIX**                      | **Microsoft SQL SERVER**          |
+-----------------------------------+-----------------------------------+
| select day(0), month(0), year(0)  | select day(0), month(0), year(0)\ |
| FROM systables WHERE tabid=1;\    | \-\-\-\-\-\-\-\-\-\--             |
| \-\-\-\-\-- \-\-\-\-\--           | \-\-\-\-\-\-\-\-\-\--             |
| \-\-\-\-\--\                      | \-\-\-\-\-\-\-\-\-\--\            |
|     31     12   1899\             |           1           1           |
| 1 Row(s) affected                 | 1900\                             |
|                                   | (1 row(s) affected)               |
+-----------------------------------+-----------------------------------+
:::

- The SQL SERVER equivalent for WEEKDAY() is the DATEPART(dw,\<date\>)
  function. The weekday date part depends on the value set by SET
  DATEFIRST *n*, which sets the first day of the week
  (1=Monday\...7=Sunday-default).
- SQL SERVER uses a different basis for the day of the week. In SQL
  SERVER, Sunday is day 7 and Monday is day 1 while INFORMIX defines
  Sunday as the day 0 (zero) and Monday as 1.

**[*Solution:*]{.underline}**

The SQL SERVER database drivers will automatically map INFORMIX
date/time types to native SQL SERVER type, according the server version.
Conversions are described in this table:

+----------------------+----------------------+----------------------+
| **INFORMIX date/time | **Microsoft SQL SERVER date/time type**     |
| type**               |                                             |
+----------------------+----------------------+----------------------+
|                      | **Before SQL SERVER  | **Since SQL SERVER   |
|                      | 2008**               | 2008**               |
+----------------------+----------------------+----------------------+
| DATE                 | DATETIME             | DATE                 |
+----------------------+----------------------+----------------------+
| DATETIME HOUR TO     | DATETIME (filled     | TIME(0)              |
| SECOND               | with 1900-01-01)     |                      |
+----------------------+----------------------+----------------------+
| DATETIME HOUR TO     | DATETIME (filled     | TIME(n)              |
| FRACTION(n)          | with 1900-01-01)     |                      |
+----------------------+----------------------+----------------------+
| DATETIME YEAR TO     | DATETIME             | DATETIME2(0)         |
| SECOND               |                      |                      |
+----------------------+----------------------+----------------------+
| Any other sort of    | DATETIME (filled     | DATETIME2(n)         |
| DATETIME type        | with 1900-01-01)     |                      |
+----------------------+----------------------+----------------------+

With SQL SERVER 2005 and lower, INFORMIX DATETIME with any precision
from YEAR to FRACTION(3) is stored in SQL SERVER DATETIME columns.

For heterogeneous DATETIME types like DATETIME HOUR TO MINUTE, the
database interface fills missing date or time parts to 1900-01-01
00:00:00.0. For example, when using a DATETIME HOUR TO MINUTE with the
value of \"11:45\", the SQL SERVER datetime value will be \"1900-01-01
11:45:00.0\".

**Warning:** SQL SERVER SMALLDATETIME can store dates from January 1,
1900, through June 6, 2079. Therefore, we do not recommend to use this
data type.

**Warning:** With SQL SERVER 2005 and lower, the fractional second part
of a SQL SERVER DATETIME has a precision of 3 digits while INFORMIX has
a precision up to 5 digits. Do not try to insert a datetime value in a
SQL SERVER DATETIME with a precision more than 3 digits or a conversion
error could occur. You can use the MS SUBSTRING() function to truncate
the fraction part of the INFORMIX datetimes or another BDL solution. The
fraction part of a SQL SERVER DATETIME is an approximate value. For
example, when you insert a datetime value with a fraction of 111, the
database actually stores 110. This may cause problems because INFORMIX
DATETIMEs with a fraction part are exact values with a precision up to 5
digits. Starting with SQL SERVER 2008, the DATETIME2 native type will be
used. This new type can store fraction of seconds with a precision of 7
digits, so INFORMIX DATETIME values can be stored without precision
lost.

**Warning:** When migrating to SQL SERVER 2008, you must pay attention
if the database has DATETIME columns used to store INFORMIX DATETIME
HOUR TO SECOND or DATETIME HOUR TO FRACTION(n) types: Before version
2008, those types were stored in SQL SERVER DATETIME columns (filling
missing date part with 1900-01-01). The SNC database driver for SQL
SERVER 2008 maps now DATETIME HOUR TO SECOND / FRACTION(n) to a TIME
data type, which is not compatible with an SQL SERVER DATETIME type. To
solve this problem, SQL SERVER DATETIME columns used to store DATETIME
HOUR TO SECOND/FRACTION(n) must be converted to TIME columns (ALTER
TABLE).

**Warning:** When fetching a TIME or DATETIME2 with a precision that is
greater as 5 (the 4gl DATETIME precision limit), the database interface
will allocate a buffer of VARCHAR(16) for the TIME and VARCHAR(27) for
the DATETIME2 column. As a result, you can fetch such data into a CHAR
or VARCHAR variable.

**Warning:** Using integers as a number of days in an expression with
dates is not supported by SQL SERVER. Check your code to detect where
you are using integers with DATE columns.

**Warning:** Literal DATETIME and INTERVAL expressions (i.e. DATETIME (
1999-10-12) YEAR TO DAY) are not converted.

**Warning:** It is strongly recommended to use BDL variables in dynamic
SQL statements instead of quoted strings representing DATEs. For example
:\
   LET stmt = \"SELECT \... FROM customer WHERE creat_date \>\'\",
adate,\"\'\"\
is not portable; use a question mark place holder instead and OPEN the
cursor USING adate:\
   LET stmt = \"SELECT \... FROM customer WHERE creat_date \> ?\"

**Warning:** Review the program logic if you are using the INFORMIX
WEEKDAY()  function because SQL SERVER uses a different basis for the
days numbers ( Monday = 1 ).

**Warning:** SQL Statements using expressions with TODAY / CURRENT / 
EXTEND must be reviewed and adapted to the native syntax. Use the MS
GETDATE() function to get the system current date.

------------------------------------------------------------------------

[ODIMSV003 - Reserved words]{#ODIMSV003}

Microsoft Transact-SQL does not allow you to use reserved words as
database object names ( tables, columns, constraint, indexes, triggers,
stored procedures, \...).  An example of a common word which is part of
SQL SERVER grammar is \'**go**\' (see the \'Reserved keywords\' section
in the SQL SERVER Documentation).

***[Solution:]{.underline}***

Database objects having a name which is a Transact-SQL reserved word
must be renamed.

All BDL application sources must be verified. To check if a given
keyword is used in a source, you can use UNIX \'grep\' or \'awk\' tools.
Most modifications can be automatically done with UNIX tools like
\'sed\' or \'awk\'.

**Warning:** You can use SET QUOTED_IDENTIFIER ON with double-quotes to
enforce the use of keywords in the database objects naming, but it is
not recommended.

------------------------------------------------------------------------

[ODIMSV004 - ROWIDs]{#ODIMSV004}

When creating a table, INFORMIX automatically adds a \"ROWID\" integer
column (applies to non-fragmented tables only). The ROWID column is
auto-filled with a unique number and can be used like a primary key to
access a given row.

Microsoft SQL SERVER tables have no ROWIDs.

***[Solution:]{.underline}***

If the BDL application uses ROWIDs, the program logic should be reviewed
in order to use the real primary keys (usually, serials which can be
supported).

However, if your existing INFORMIX application depends on using ROWID
values, you can use the IDENTITY property of the DECIMAL, INT, NUMERIC,
SMALLINT, BIGINT, or TINYINT data types, to simulate this functionality.

All references to SQLCA.SQLERRD\[6\] must be removed because this
variable will not hold the ROWID of the last INSERTed or UPDATEd row
when using the Microsoft SQL SERVER interface.

------------------------------------------------------------------------

## [ODIMSV005 - SERIAL data types]{#ODIMSV005}

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
    CREATE TABLE tab ( k SERIAL );  \--\> internal counter = 0\
    INSERT INTO tab VALUES ( 0 );   \--\> internal counter = 1\
    INSERT INTO tab VALUES ( 10 );  \--\> internal counter = 10\
    INSERT INTO tab VALUES ( 0 );   \--\> internal counter = 11\
    DELETE FROM tab;                \--\> internal counter = 11\
    INSERT INTO tab VALUES ( 0 );   \--\> internal counter = 12

Microsoft SQL SERVER **IDENTITY** columns:

- When creating a table, the IDENTITY keyword must be specified after
  the column data type:\
     CREATE TABLE tab1 ( k integer identity, c char(10) )
- You can specify a start value and an increment with
  \"identity(start,incr)\".\
     CREATE TABLE tab1 ( k integer identity(100,2), \...
- A new number is automatically created when inserting a new row:\
     INSERT INTO tab1 ( c ) VALUES ( \'aaa\' )
- To get the last generated number, Microsoft SQL SERVER provides a
  global variable:\
     SELECT **@@IDENTITY**
- To put a specific value into a IDENTITY column, the SET command must
  be used:\
     SET IDENTITY_INSERT tab1 ON\
     INSERT INTO tab1 ( k, c ) VALUES ( 100, \'aaa\' )\
     SET IDENTITY_INSERT tab1 OFF

INFORMIX SERIALs and MS SQL SERVER IDENTITY columns are quite similar;
the main difference is that MS SQL SERVER does not allow you to use the
zero value for the identity column when inserting a new row.

This problem cannot be resolved with triggers because Microsoft SQL
SERVER does not support row-level triggers (INSERT Triggers are fired
only once per INSERT statement).

**[*Solution:*]{.underline}**

To emulation INFORMIX serials, you can use **IDENTITY columns** (1) or
**insert triggers based on the SERIALREG** table (2). The first solution
is faster, but does not allow explicit serial value specification in
insert statements; the second solution is slower but allows explicit
serial value specification.

**Warning:** The second emulation based on triggers is provided to
simplify the conversion to SQL SERVER. We strongly recommend you to use
native IDENTITY columns instead.

With the following fglprofile entry, you define the technique to be used
for SERIAL emulation :

   dbi.database.\<dbname\>.ifxemul.datatype.serial.emulation =
{\"native\"\|\"regtable\"}

The \'**native**\' value defines the IDENTITY column technique and the
\'**regtable**\' defines the trigger technique.

This entry must be used with:

   dbi.database.\<dbname\>.ifxemul.datatype.serial = {true\|false}

If this entry is set to false, the emulation method specification entry
is ignored.

**Warning:** When no entry is specified, the default is SERIAL emulation
enabled with \'native\' method (IDENTITY-based).\
\
[1. Using IDENTITY columns]{.underline}

In database creation scripts, all SERIAL\[(n)\] data types must be
converted by hand to INTEGER IDENTITY\[(n,1)\] data types.

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

**Warning:** By default (see SET IDENTITY_INSERT), MS SQL SERVER does
not allow you to specify the IDENTITY column in INSERT statements; You
must convert all INSERT statements to remove the identity column from
the list.\
For example, the following statement:\
   INSERT INTO tab (col1,col2) VALUES (**0**, p_value)\
must be converted to:\
   INSERT INTO tab (col2) VALUES (p_value)\
Static SQL INSERT using records defined from the schema file must also
be reviewed:\
   DEFINE rec LIKE tab.\*\
   INSERT INTO tab VALUES ( rec.\* )   \-- will use the serial column\
must be converted to :\
   INSERT INTO tab VALUES rec.\* \-- without braces, serial column is
removed

Since 2.10.06, SELECT \* FROM table INTO TEMP with original table having
an IDENTITY column are supported: The database driver converts the
INFORMIX SELECT INTO TEMP to the following sequence of statements:

1.  SELECT \<*selection items*\>  INTO #table FROM \... WHERE 1=2
2.  SET IDENTITY\_ INSERT #table ON
3.  INSERT INTO #table ( *column-list* ) SELECT \<*original select
    clauses*\>
4.  SET IDENTITY\_ INSERT #table OFF

See also [temporary tables](#ODIMSV017).

[2. Using triggers with the SERIALREG table]{.underline}

First, you must prepare the database and create the SERIALREG table as
follows:\
\
CREATE TABLE serialreg (\
     tablename VARCHAR(50) NOT NULL,\
     lastserial BIGINT NOT NULL,\
     PRIMARY KEY ( tablename )\
)

**Warning:** Note that the SERIALREG table and columns have to be
created with lower case names, since the SQL SERVER database is created
with case sensitive names, because triggers are using this table in
lower case.

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

**Warning:** This serial emulation is only supported with **SQL SERVER**
**2000** and higher, because it is implemented with INSTEAD OF triggers.

**Warning:** SQL SERVER does not allow you to create triggers on
temporary tables. Therefore, you cannot create temp tables with a SERIAL
column when using this solution.

**Warning:** SELECT \... INTO TEMP statements using a table created with
a SERIAL column do not automatically create the SERIAL triggers in the
temporary table. The type of the column in the new table is INTEGER.

**Warning:** When a table is dropped, all associated triggers are also
dropped.

**Warning:** INSERT statements using NULL for the SERIAL column will
produce a new serial value, instead of using NULL:\
   INSERT INTO tab (col1,col2) VALUES (**NULL**,\'data\')\
This behavior is mandatory in order to support INSERT statements which
do not use the serial column:\
   INSERT INTO tab (col2) VALUES (\'data\')\
Check if your application uses tables with a SERIAL column that can
contain a NULL value.

**Warning:** The serial production is based on the SERIALREG table which
registers the last generated number for each table. If you delete rows
of this table, sequences will restart at 1 and you will get unexpected
data.

------------------------------------------------------------------------

[ODIMSV006 - Outer joins]{#ODIMSV006}

The original OUTER join syntax of INFORMIX is different from Microsoft
SQL SERVER outer join syntax:

In INFORMIX SQL, outer tables can be defined in the **FROM** clause with
the **OUTER** keyword:

> SELECT ... FROM cust, OUTER(order)
>      WHERE cust.key = order.custno
>
>     SELECT ... FROM cust, OUTER(order,OUTER(item))
>      WHERE cust.key = order.custno
>        AND order.key = item.ordno
>        AND order.accepted = 1

Microsoft SQL SERVER supports the ANSI outer join syntax :

> SELECT ... FROM cust LEFT OUTER JOIN order
>                          ON cust.key = order.custno
>
>     SELECT ...
>       FROM cust LEFT OUTER JOIN order
>                 ON cust.key = order.custno
>                 LEFT OUTER JOIN item
>                 ON order.key = item.ordno
>      WHERE order.accepted = 1

Remark: The old way to define outers in SQL SERVER looks like the
following :

> SELECT ... FROM a, b WHERE a.key *= b.key

See the SQL SERVER reference manual for a complete description of the
syntax.

***[Solution:]{.underline}***

For better SQL portability, you should use the ANSI outer join syntax
instead of the old Informix OUTER syntax.

The Microsoft SQL SERVER interface can convert simple INFORMIX OUTER
specifications to Microsoft SQL SERVER ANSI outer joins.

Prerequisites:

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
4.  [Temporary tables](#ODIMSV017) are supported in OUTER
    specifications.

------------------------------------------------------------------------

[ODIMSV007a - Database concepts]{#ODIMSV007a}

As in INFORMIX, an SQL SERVER engine can manage multiple database
entities. When creating a database object like a table, Microsoft SQL
SERVER allows you to use the same object name in different databases.

------------------------------------------------------------------------

[ODIMSV008a - Data consistency and concurrency management]{#ODIMSV008a}

[Data consistency]{.underline} involves readers which want to access
data currently modified by writers and [concurrency data
access]{.underline} involves several writers accessing the same data for
modification. [Locking granularity]{.underline} defines the amount of
data concerned when a lock is set (row, page, table, \...).

[INFORMIX]{.underline}

INFORMIX uses a locking mechanism to manage data consistency and
concurrency. When a process modifies data with UPDATE, INSERT or DELETE,
an [exclusive lock]{.underline} is set on the affected rows. The lock is
held until the end of the transaction. Statements performed outside a
transaction are treated as a transaction containing a single operation
and therefore release the locks immediately after execution. SELECT
statements can set [shared locks]{.underline} according to the
[isolation level]{.underline}. In case of locking conflicts (for
example, when two processes want to acquire an exclusive lock on the
same row for modification or when a writer is trying to modify data
protected by a shared lock), the behavior of a process can be changed by
setting the [lock wait mode]{.underline}.

Control:

- Isolation level : SET ISOLATION TO \...
- Lock wait mode : SET LOCK MODE TO \...
- Locking granularity : CREATE TABLE \... LOCK MODE {PAGE\|ROW}
- Explicit locking : SELECT \... FOR UPDATE

Defaults:

- The default isolation level is READ COMMITTED.
- The default lock wait mode is NOT WAIT.
- The default locking granularity is per page.

[SQL SERVER]{.underline}

As in INFORMIX, SQL SERVER uses locks to manage data consistency and
concurrency. The database manager sets [exclusive locks]{.underline} on
the modified rows and [shared locks]{.underline} or [update
locks]{.underline} when data is read, according to the [isolation
level]{.underline}. The locks are held until the end of the transaction.
When multiple processes want to access the same data, the latest
processes must wait until the first finishes its transaction or the lock
timeout occurred. The locking strategy of SQL SERVER is row locking with
possible promotion to page or table locking. SQL SERVER dynamically
determines the appropriate level at which to place locks for each
Transact-SQL statement.

Starting with SQL Server 2005, you can enhance concurrency by turning on
snapshot isolation level, to make SQL Server use a copy of the row when
it is changed by a transaction. To turn this feature on, you must set
the database property ALLOW_SNAPSHOT_ISOLATION ON. Setting the
READ_COMMITTED_SNAPSHOT ON option allows access to versioned rows under
the default READ COMMITTED isolation level (otherwise, snapshot
isolation must be specified by every SQL Session).

Control:

- Lock wait mode : SET LOCK_TIMEOUT \<milliseconds\> (returns error 1222
  on time out).
- Isolation level : SET TRANSACTION ISOLATION LEVEL \...
- Locking granularity : Row, Page or Table level (Automatic - See
  Dynamic Locking).
- Explicit locking : SELECT \... FROM \... WITH (UPDLOCK) (See Locking
  Hints)

Defaults:

- The default isolation level is READ COMMITTED (readers cannot see
  uncommitted data).
- The default LOCK_TIMEOUT is -1 (indicates no time-out period, wait
  forever).

**[*Solution:*]{.underline}**

The **SET ISOLATION TO \...** in programs is converted to SET
TRANSACTION ISOLATION LEVEL \... for SQL Server. The next table shows
the isolation level mappings done by the database driver:

::: {align="center"}
  ----------------------------------- -----------------------------------
  **SET ISOLATION instruction in      **Native SQL command**
  program**                           

  SET ISOLATION TO DIRTY READ         SET TRANSACTION ISOLATION LEVEL
                                      READ UNCOMMITTED

  SET ISOLATION TO COMMITTED READ\    SET TRANSACTION ISOLATION LEVEL
    \[READ COMMITTED\] \[RETAIN       READ COMMITTED
  UPDATE LOCKS\]                      

  SET ISOLATION TO CURSOR STABILITY   SET TRANSACTION ISOLATION LEVEL
                                      REPEATABLE READ

  SET ISOLATION TO REPEATABLE READ    SET TRANSACTION ISOLATION LEVEL
                                      SERIALIZABLE
  ----------------------------------- -----------------------------------
:::

For portability, it is recommended that you work with INFORMIX in the
read committed isolation level, to make processes wait for each other
(lock mode wait) and to create tables with the \"lock mode row\" option.

When using **SET LOCK MODE \...** in the programs, it will be converted
to a SET LOCK_TIMEOUT instruction for SQL SERVER:

::: {align="center"}
  ----------------------------------------- ------------------------------------------------------------
  **SET LOC MODE instruction in program**   **Native SQL command**
  SET LOCK MODE TO WAIT                     SET LOCK_TIMEOUT -1   (wait forever)
  SET LOCK MODE TO WAIT *seconds*           SET LOCK_TIMEOUT *seconds* \* 1000   (wait N milliseconds)
  SET LOCK MODE TO NOT WAIT                 SET LOCK_TIMEOUT 0   (do not wait)
  ----------------------------------------- ------------------------------------------------------------
:::

See INFORMIX and SQL SERVER documentation for more details about data
consistency, concurrency and locking mechanisms.

------------------------------------------------------------------------

[ODIMSV008b - SELECT FOR UPDATE]{#ODIMSV008b}

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

Microsoft SQL SERVER allows individual and exclusive row locking by
using the (UPDLOCK) hint after the table names in the FROM clause :

   SELECT \... FROM tab1 WITH (UPDLOCK) WHERE \...

The FOR UPDATE clause is not mandatory; the (UPDLOCK) hint is important.

- Individual locks are acquired when fetching the rows.
- When the cursor (WITH HOLD) is opened outside a transaction, locks are
  released when the cursor is closed.
- When the cursor is opened inside a transaction, locks are released
  when the transaction ends.

SQL SERVER\'s locking granularity is at the row level, page level or
table level (the level is automatically selected by the engine for
optimization).

To control the behavior of the program when locking rows, INFORMIX
provides a specific instruction to set the wait mode :

   SET LOCK MODE TO { WAIT \| NOT WAIT \| WAIT *seconds* }

The default mode is NOT WAIT. This as an INFORMIX specific SQL
statement.

**[*Solution:*]{.underline}**

The SQL SERVER database driver for MS SQL SERVER uses the SCROLL LOCKS
concurrency options for cursors (SQL_ATTR_CONCURRENCY =
SQL_CONCUR_LOCK).

This option implements pessimistic concurrency control, in which the
application attempts to lock the underlying database rows at the time
they are read into the cursor result set.\
When using server cursors, an update lock is placed on the row when it
is read into the cursor.\
If the cursor is opened within a transaction, the transaction update
lock is held until the transaction is either committed or rolled back;
the cursor lock is dropped when the next row is fetched.\
If the cursor has been opened outside a transaction, the lock is dropped
when the next row is fetched.\
Therefore, a cursor should be opened in a transaction whenever the user
wants full pessimistic concurrency control.\
An update lock prevents any other task from acquiring an update or
exclusive lock, which prevents any other task from updating the row.\
An update lock, however, does not block a shared lock, so it does not
prevent other tasks from reading the row unless the second task is also
requesting a read with an update lock.

SELECT FOR UPDATE statements are well supported in BDL as long as they
are used inside a transaction. Avoid cursors declared WITH HOLD.

**Warning:** The database interface is based on an emulation of an
INFORMIX engine using transaction logging. Therefore, opening a SELECT
\... FOR UPDATE cursor declared outside a transaction will raise an SQL
error -255 (not in transaction).

**Warning:** The SELECT FOR UPDATE statement cannot contain an ORDER BY
clause if you want to perform positioned updates/deletes with WHERE
CURRENT OF.

**Warning:** Cursors declared with SELECT \... FOR UPDATE using the
\"WITH HOLD\" clause cannot be supported with SQL SERVER.

You must review the program logic if you use pessimistic locking because
it is based on the NOT WAIT mode which is not supported by SQL SERVER.

------------------------------------------------------------------------

[ODIMSV009 - Transactions handling]{#ODIMSV009}

INFORMIX and Microsoft SQL SERVER handle transactions in a similar
manner.

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

Microsoft SQL SERVER supports named and nested transactions:

- Transactions are started with BEGIN TRANSACTION \[*name*\].
- Transactions are validated with COMMIT TRANSACTION \[*name*\].
- Transactions are canceled with ROLLBACK TRANSACTION \[*name*\].
- Savepoints can be placed with SAVE TRANSACTION *name*.
- Transactions can be rolled back to a savepoint with ROLLBACK
  TRANSACTION TO *name*.
- Savepoints can not be released.
- Statements executed outside of a transaction are automatically
  committed (autocommit mode).\
  This behavior can be changed with \"SET IMPLICIT_TRANSACTION ON\".
- DDL statements are not supported in transactions blocks.

Transactions in stored procedures: avoid using transactions in stored
procedure to allow the client applications to handle transactions,
according to the transaction model.

**[*Solution:*]{.underline}**

INFORMIX transaction handling commands are automatically converted to
Microsoft SQL SERVER instructions to start, validate or cancel
transactions.

Regarding the transaction control instructions, the BDL applications do
not have to be modified in order to work with Microsoft SQL SERVER.

**Warning:** If you want to use savepoints, do not use the UNIQUE
keyword in the savepoint declaration, always specify the savepoint name
in ROLLBACK TO SAVEPOINT, and do not drop savepoints with RELEASE
SAVEPOINT.

------------------------------------------------------------------------

## [ODIMSV010 - BOOLEAN data type]{#ODIMSV010}

INFORMIX supports the BOOLEAN data type, which can store \'t\' or \'f\'
values. Genero BDL implements the BOOLEAN data type in a different way:
As in other programming languages, Genero BOOLEAN stores integer values
1 or 0 (for TRUE or FALSE). The type was designed this way to assign the
result of a Boolean expression to a BOOLEAN variable.

SQL SERVER provides the BIT data type to store Boolean values.

**[*Solution:*]{.underline}**

The SQL SERVER database interfaces converts BOOLEAN type to BIT columns
and stores 1 or 0 values in the column.

------------------------------------------------------------------------

[ODIMSV011 - CHARACTER data types]{#ODIMSV011}

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

SQL Server provides the following data types to store character data:

- CHAR(N) with N\<= 8000 bytes (single or multi-byte charset)
- VARCHAR(N) with N\<= 8000 bytes (single or multi-byte charset)
- VARCHAR(MAX) with a limit of 2\^31-1 bytes (single or multi-byte
  charset)
- NCHAR(N) with N\<= 8000 bytes (Unicode/UCS-2)
- NVARCHAR(N) with N\<= 8000 bytes (Unicode/UCS-2)
- NVARCHAR(MAX) with a limit of 2\^31-1 bytes (Unicode/UCS-2)

Note that to store large text data (LOBs), Microsoft SQL Server version
2005 introduced the VARCHAR(MAX) type as a replacement for the old TEXT
type.

The use of NCHAR, NVARCHAR character types is the same as CHAR, VARCHAR,
TEXT respectively, except:

- The encoding is UCS-2 (an UTF-16 sub-set).
- Since each character occupies 2 bytes, twice the space is needed to
  store the same strings as with CHAR/VARCHAR.
- The maximum size of NCHAR and NVARCHAR column is 4000 characters,
  compared to 8000 characters for CHAR/VARCHAR.
- Unicode string literals are specified with a leading N. For example:
  N'日本語'

Note that SQL Server uses Byte Length Semantics to define the size of
CHAR/VARCHAR columns, while NCHAR and NVARCHAR sizes are expressed in
character units.

SQL Server defines the character encoding for CHAR and VARCHAR columns
with the database collation. The database collation can be specified
when creating a new database. Character strings are always stored in the
UCS-2 encoding for NCHAR/NVARCHAR columns.

Automatic charset conversion is supported by SQL Server between the
client application and the server. The client charset is defined by the
Windows operating system, in the language settings for non-Unicode
applications.

**[*Solution:*]{.underline}**

According to the character set used by your Genero application, you must
either use CHAR/VARCHAR or NCHAR/NVARCHAR columns with SQL Server. If
the charset is single-byte , you can use CHAR/VARCHAR columns. If the
charset set is multi-byte or Unicode (i.e. UTF-8), you must use
NCHAR/NVARCHAR columns in SQL Server. However, not all SQL Server ODI
drivers support NCHAR/NVARCHAR.

See also the section about [Localization](Localization.html).

Make sure that the regional language settings for non-Unicode
applications corresponds to the locale used by Genero programs.

Check that your database schema does not use CHAR or VARCHAR types with
a length exceeding the SQL SERVER limit.

**Warning: On Windows, SQL Server national character set data types are
not supported with the MSV database driver: You must use the SNC
database driver based on the SQL Native Client library. On UNIX, you can
use the FTM or ESM driver, both support SQL Server national character
set data.**

[Using the SNC driver]{.underline}

The **SNC** driver can work in *char* or in *wide-char* mode. The
character size mode can be controlled by the following FGLPROFILE entry:

   dbi.database.\<dbname\>.snc.widechar = [{]{.underline} true
[\|]{.underline} false [}]{.underline}

By default the **SNC** database driver works in Wide Char mode (true).

[*Using SNC driver in char mode:*]{.underline}

The *char* mode can be used with applications defining character string
columns with CHAR/VARCHAR/TEXT types. It is not mandatory (i.e. the
*wide-char* mode could be used), but it appears that SQL Server behaves
in different ways when wide-char bindings are used for CHAR/VARCHAR/TEXT
columns.

When defining CHAR(*n*)/VARCHAR(*n*) columns in SQL Server, you specify
*n* as a number of bytes, and this follows the byte-length semantics
used in Genero BDL when declaring variables (i.e. SQL Server VARCHAR(10)
column = Genero BDL VARCHAR(10) variable).

In *char* mode, the **SNC** driver will pass the character strings of
SQL text and SQL parameters as is to SQL Server Native Client, using the
current character set encoding. SQL Parameters will be bound with the
SQL_C_CHAR + SQL_CHAR/SQL_VARCHAR ODBC types, and string literals in SQL
statements will not get the N prefix as when using the *wide-char* mode.

[*Using SNC driver in wide-char mode:*]{.underline}

The *wide-char* mode should be used for applications defining character
string columns with NCHAR/NVARCHAR/NTEXT types. Such types can store
Unicode characters and it is preferable that the **SNC** driver works in
*wide-char* mode. By the way, the Genero BDL runtime system should also
work in UTF-8 mode.

NCHAR / NVARCHAR and NTEXT SQL SERVER column data types can be used in
tables. However, you must use CHAR / VARCHAR / TEXT Genero types for
program variable to hold NCHAR, NVARCHAR and NTEXT data. Make sure the
size of the program variables is large enough to hold all sort of
UNICODE characters in the code page used by the program. In order to
store the same strings as with INFORMIX databases, the SNC database
driver applies the following rules:

1.  In FGL, when declaring a \[VAR\]CHAR(*n*) variable to be used as SQL
    parameter (in a USING clause for example), the length *n* is
    specified in bytes. The **SNC** database driver maps this type to an
    ODBC parameter as N\[VAR\]CHAR with a precision of *n*, in the
    meaning of characters. In SQL SERVER, the target column must be
    defined as N\[VAR\]CHAR with the same size *n*, to be able to store
    *n* ASCII characters like the INFORMIX equivalent UNICODE (UTF-8)
    column. The SQL SERVER column can actually hold more non-ASCII
    characters as the INFORMIX column (using byte length semantics), but
    this is the only way to store the same strings. 
2.  Following the above rule, when fetching rows from SQL SERVER, the
    **SNC** database driver maps an N\[VAR\]CHAR(*n*) (with *n* as
    chars) to an intermediate fetch buffer as \[VAR\]CHAR(*n*) (with *n*
    as bytes), and the program variable will certainly be defined as
    \[VAR\]CHAR(*n bytes*) from a database schema. As a result, if
    another application has inserted in the N\[VAR\]CHAR(*n chars*)
    column more characters as can fit in the \[VAR\]CHAR(*n bytes*)
    program variable, the string value will be truncated.

All string literals of an SQL statement are automatically changed to get
the N prefix. Thus, you don\'t need to add the N prefix by hand in all
of your programs. This solution makes your Genero code portable to other
databases.

Character string data is converted from the current Genero BDL locale to
Wide Char (i.e. WCHAR/wchar_t 16-bit Unicode = UCS-2), before is it used
in an ODBC call such as SQLPrepareW or SQLBindParameter(SQL_C_WCHAR).
When fetching character data, the **SNC** database driver converts from
Wide Char to the current Genero BDL locale. The current Genero BDL
locale is defined by LANG, and if LANG is not defined, the default is
the ANSI Code Page of the Windows operating system. 

[Using the FTM driver]{.underline}

When using the **FTM** (FreeTDS) database driver, string literals get
the N prefix only if the current locale (LANG / LC_ALL) defines a
multi-byte code set such as **.big5** or **.utf8**. String literals are
not touched if the locale uses a single-byte character set.

With the **FTM** (FreeTDS) database driver, SQL Statements are prepared
with SQLPrepare(), by using the current character set. FreeTDS takes in
charge the conversion from the client charset to UCS-2 before sending
the SQL text to the server. ODBC SQL parameters with character string
data are bound (SQLBindParameter) with the C type SQL_C_CHAR and with
the SQL type SQL_W\[VAR\]CHAR (=UNICODE) or with SQL\_\[VAR\]CHAR,
according to the current locale. The SQL_W\[VAR\]CHAR type is used if
the current locale is a multi-byte encoding. When using a single-byte
encoding, parameters are bound with the SQL\_\[VAR\]CHAR type. As a
result, the necessary character set conversion is taken in charge by
FreeTDS and is optimized when using a single-byte character set.
However, [it is critical to declare the correct client character set in
FreeTDS configuration files]{.underline}. The FreeTDS client character
set is defined by the \"**client charset**\" parameter in
**freetds.conf**, or (since 0.83 only) with \"**ClientCharset**\"
parameter in **odbc.ini**.

[Using the ESM driver]{.underline}

When using the **ESM** (EasySoft) database driver, string literals get
the N prefix only if the current locale (LANG / LC_ALL) defines a
multi-byte code set such as **.big5** or **.utf8**. String literals are
not touched if the locale uses a single-byte character set.

When using the **ESM** (EasySoft) database driver, SQL Statements are
prepared with SQLPrepare(), by using the current character set. EasySoft
takes in charge the conversion from the client charset to UCS-2 before
sending the SQL text to the server. ODBC SQL parameters with character
string data are bound (SQLBindParameter) with the C type SQL_C_CHAR and
with the SQL type SQL_W\[VAR\]CHAR  (=UNICODE) type. As a result, the
necessary character set conversion is taken in charge by EasySoft.
However, [it is critical to declare the correct client character set in
EasySoft configuration files]{.underline}. The EasySoft client character
set is defined by the \"**Client_CSet**\" parameter in **odbc.ini**.

------------------------------------------------------------------------

[ODIMSV012 - Constraints]{#ODIMSV012}

[Constraint naming syntax:]{.underline}

Both INFORMIX and Microsoft SQL SERVER support primary key, unique,
foreign key, default and check constraints. But the constraint naming
syntax is different : SQL SERVER expects the \"CONSTRAINT\" keyword
**before** the constraint specification and INFORMIX expects it
**after**.

UNIQUE constraint example:

::: {align="center"}
  ----------------------------------- -----------------------------------
  **INFORMIX**                        **Microsoft SQL SERVER**

  CREATE TABLE scott.emp (\           CREATE TABLE scott.emp (\
  \...\                               \...\
  empcode CHAR(10) UNIQUE\            empcode CHAR(10)\
     **\[CONSTRAINT pk_emp\]**,\         **\[CONSTRAINT pk_emp\]**
  \...                                UNIQUE,\
                                      \...
  ----------------------------------- -----------------------------------
:::

**Warning:** SQL SERVER does not produce an error when using the
INFORMIX syntax of constraint naming

**The NULL / NOT NULL constraint:**

**Warning:** Microsoft SQL SERVER creates columns as **NOT NULL by
default**, when no NULL constraint is specified (**[colname datatype
{NULL \| NOT NULL}]{.small}**). A special option is provided to invert
this behavior: ANSI_NULL_DFLT_ON. This option can be enabled with the
SET command, or in the database options of SQL SERVER Management Studio.

**[*Solution:*]{.underline}**

**Constraint naming syntax:**

The database interface does not convert constraint naming expressions
when creating tables from BDL programs. Review the database creation
scripts to adapt the constraint naming clauses for Microsoft SQL SERVER.

**The NULL / NOT NULL constraint:**

**Warning:** Before using a database, you must check the \"ANSI NULL
Default\" option in the database properties if you want to have the same
default NULL constraint as in INFORMIX databases.

------------------------------------------------------------------------

[ODIMSV013 - Triggers]{#ODIMSV013}

INFORMIX and Microsoft SQL SERVER provide triggers with similar
features, but the programming languages are totally different.

**Warning:** Microsoft SQL SERVER does not support \"BEFORE\" triggers.

**Warning:** Microsoft SQL SERVER does not support row-level triggers.

**[*Solution:*]{.underline}**

INFORMIX triggers must be converted to Microsoft SQL SERVER triggers
\"by hand\".

------------------------------------------------------------------------

[ODIMSV014 - Stored procedures]{#ODIMSV014}

Both INFORMIX and Microsoft SQL SERVER support stored procedures, but
the programming languages are totally different :

- INFORMIX stored procedures must be written in **SPL**.
- Microsoft SQL SERVER stored procedures must be written in
  **Transact-SQL**.

**[*Solution:*]{.underline}**

INFORMIX stored procedures must be converted to Microsoft SQL SERVER
\"by hand\".

------------------------------------------------------------------------

[ODIMSV016a - Defining database users]{#ODIMSV016a}

INFORMIX users are defined at the operating system level, they must be
members of the \'informix\' group, and the database administrator must
grant CONNECT, RESOURCE or DBA privileges to those users.

Before a user can access an SQL SERVER database, the system
administrator (SA) must add the user\'s **login** to the SQL SERVER
Login list and add a **user name** for that database. The user name is a
name that is assigned to a login ID for the purpose of allowing that
user to access a specified database. Database users are members of a
**user group**; the default group is \'public\'.

Microsoft SQL SERVER offers two authentication modes : The **SQL
SERVER** **authentication mode**, which requires a login name and a
password, and the **Windows NT authentication mode**, which uses the
security mechanisms within Windows NT when validating login connections.
With this mode, user do not have to enter a login ID and password -
their login information is taken directly from the network connection.

**Warning:** SQL SERVER 2000 supports only Windows NT authentication by
default. If you want to use SQL SERVER authentication, you must change a
parameter in the server properties.

**[*Solution:*]{.underline}**

Both SQL SERVER and Windows NT authentication methods can be used to
allow BDL program users to connect to Microsoft SQL SERVER and access a
specific database.

See SQL SERVER documentation for more details on database logins and
users.

------------------------------------------------------------------------

[ODIMSV016b - Setting privileges]{#ODIMSV016b}

INFORMIX and Microsoft SQL SERVER user privileges management are quite
similar.

Microsoft SQL SERVER provides **user groups** to grant or revoke
permissions to more than one user at the same time.

------------------------------------------------------------------------

[ODIMSV017 - Temporary tables]{#ODIMSV017}

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

Microsoft SQL SERVER provides local (SQL session wide) or global
(database wide) temporary tables by using the \'#\' or \'##\' characters
as table name prefix. No \'TEMP\' keyword is required in CREATE TABLE,
and the INTO clause can be used within a SELECT statement to create and
fill a temporary table in one step :

    CREATE TABLE **#temp1** ( kcol INTEGER, \.... )\
    SELECT \* **INTO #temp2** FROM customers WHERE \...

Unfortunately, SQL Server temporary tables are created by default with
the collation of the tempdb database, instead of inheriting the
collation of the current database you are connected to.

***[Solution:]{.underline}***

In BDL, INFORMIX temporary tables instructions are converted to generate
native SQL SERVER temporary tables.

**Warning:** Microsoft SQL SERVER does not support scroll cursors based
on a temporary table.

**Warning:** You must install SQL Server with the same collation as your
database, see [Installation](#ODIMSV_PREP01) for more details.

------------------------------------------------------------------------

[ODIMSV018 - Substrings in SQL]{#ODIMSV018}

INFORMIX SQL statements can use subscripts on columns defined with the
character data type:\
    SELECT \... FROM tab1 WHERE  **col1\[2,3\]** = \'RO\'\
    SELECT \... FROM tab1 WHERE **col1\[10\]**  = \'R\'   \-- Same as
col1\[10,10\]\
    UPDATE tab1 SET **col1\[2,3\]** = \'RO\' WHERE \...\
    SELECT \... FROM tab1 ORDER BY **col1\[1,3\]**

.. while Microsoft SQL SERVER provides the SUBSTR( ) function, to
extract a substring from a string expression:\
    SELECT \.... FROM tab1 WHERE  **SUBSTRING(col1,2,2)** = \'RO\'\
    SELECT **SUBSTRING(\'Some text\',6,3)** FROM tab1  \-- Gives \'tex\'

**[*Solution:*]{.underline}**

You must replace all INFORMIX col\[x,y\] expressions by
SUBSTRING(col,x,y-x+1).

**Warning:** In UPDATE instructions, setting column values through
subscripts will produce an error with Microsoft SQL SERVER:\
    UPDATE tab1 SET **col1\[2,3\]** = \'RO\' WHERE \...\
is converted to:\
    UPDATE tab1 SET **SUBSTRING(col1,2,3-2+1)** = \'RO\' WHERE \...

**Warning:** Column subscripts in ORDER BY expressions are also
converted and produce an error with Microsoft SQL SERVER:\
    SELECT \... FROM tab1 ORDER BY **col1\[1,3\]**\
is converted to:\
    SELECT \... FROM tab1 ORDER BY **SUBSTRING(col1,1,3-1+1)**

------------------------------------------------------------------------

[ODIMSV019 - Name resolution of SQL objects]{#ODIMSV019}

INFORMIX uses the following form to identify an SQL object:\
  \[database\[@dbservername\]:\]\[{owner\|\"owner\"}.\]identifier

With Microsoft SQL SERVER, an object name takes the following form:\
  \[\[database.\]owner.\]identifier

Object names are limited to 128 characters in SQL SERVER and cannot
start with one of the following characters : @ (local variable) \# (temp
object).

To support double quotes as string delimiters in SQL SERVER, switch
**OFF** the database option \"Use quoted identifiers\" in the database
properties panel. But quoted table and column names are not supported
when this option is OFF.

**[*Solution:*]{.underline}**

Switch **OFF** the database option \"Use quoted identifiers\" to support
double quoted strings.

Check for single or double quoted table or column names in your source
and remove them.

------------------------------------------------------------------------

[ODIMSV020 - String delimiters]{#ODIMSV020}

The ANSI string delimiter character is the single quote (\'string\').
Double quotes are used to delimit database object names
(\"object-name\").

[Example]{.underline}: WHERE \"tabname\".\"colname\" = \'a string
value\'

INFORMIX allows double quotes as string delimiters, but SQL SERVER
doesn\'t. This is important, since many BDL programs use that character
to delimit the strings in SQL commands.

Note: This problem concerns only double quotes within SQL statements.
Double quotes used in BDL string expressions are not subject of SQL
compatibility problems.

[National character strings:]{.underline}

With SQL SERVER, all UNICODE strings must be prefaced with an N
character:

     UPDATE cust SET cust_name = N\'矇閬頝\' WHERE cust_id=123

If you don\'t specify the N prefix, SQL SERVER will convert the
characters from the current system locale to the database locale. If the
string is prefixed with N, the server can recognize a UNICODE string and
use it as is to insert into NCHAR or NVARCHAR columns.

***[Solution:]{.underline}***

The SQL SERVER database interface can automatically replace all double
quotes by single quotes.

Escaped string delimiters can be used inside strings like the following:

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

[National character strings:]{.underline}

When using the **SNC** database driver, all string literals of an SQL
statement are automatically changed to get the N prefix. Thus, you
don\'t need to add the N prefix by hand in all of your programs. This
solution makes by the way your Genero code portable to other databases.

With the **SNC** database driver, character string data is converted
from the current Genero BDL locale to Wide Char (Unicode UCS-2), before
is it used in an ODBC call such as SQLPrepareW or
SQLBindParameter(SQL_C_WCHAR). When fetching character data, the **SNC**
database driver converts from Wide Char to the current Genero BDL
locale. The current Genero BDL locale is defined by LANG, and if LANG is
not defined, the default is the ANSI Code Page of the Windows operating
system. See [National character data types](#ODIMSV040) for more
details.

When using the **FTM** (FreeTDS) or the **ESM** (EasySoft) database
driver on UNIX, string literals get the N prefix if the current locale
is a multi-byte encoding like BIG5, EUC-JP or UTF-8. If the current
locale is a single-byte encoding like ISO-8859-1, no prefix will be
added to the string literals.

------------------------------------------------------------------------

[ODIMSV021 - NUMERIC data types]{#ODIMSV021}

Microsoft SQL SERVER offers numeric data types which are quite similar
to INFORMIX numeric data types. The table below shows general conversion
rules for numeric data types :

::: {align="center"}
  ----------------------------------- -----------------------------------
  **INFORMIX**                        **Microsoft SQL SERVER**

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
  right of the decimal point.\        right of the decimal point. The
  DECIMAL(p) defines a [floating      maximum precision is 38.\
  point]{.underline} decimal where    Without any decimal storage
  **p** is the total number of        specification, [the precision
  significant digits.\                defaults to 18]{.underline} and
  The precision **p** can be from 1   [the scale defaults to
  to 32.\                             zero]{.underline}:\
  DECIMAL is treated as DECIMAL(16).  - DECIMAL in SQL SERVER =
                                      DECIMAL(18,0) in INFORMIX\
                                      - DECIMAL(p) in SQL SERVER =
                                      DECIMAL(p,0) in INFORMIX

  **MONEY\[(p\[,s\])**\               SQL SERVER provides the MONEY and
  \                                   SMALLMONEY data types, but the
  \                                   currency symbol handling is quite
                                      different. Therefore, INFORMIX
                                      MONEY columns should be implemented
                                      as **DECIMAL** columns in SQL
                                      SERVER.

  **SMALLFLOAT**  (synonyms: REAL)    **REAL**

  **FLOAT\[(n)\]** (synonyms: DOUBLE  **FLOAT(n)** (synonyms: DOUBLE
  PRECISION)\                         PRECISION)\
  The precision (n) is ignored.       Where n must be from 1 to 15.
  ----------------------------------- -----------------------------------
:::

***[Solution:]{.underline}***

[In BDL programs:]{.underline}

When creating tables from BDL programs, the database interface
automatically converts INFORMIX numeric data types to corresponding
Microsoft SQL SERVER data types.

**Warning: There is no SQL Server equivalent for the INFORMIX DECIMAL(p)
floating point decimal (i.e. without a scale). If your application is
using such data types, you must review the database schema in order to
use SQL Server compatible types. To workaround the SQL Server
limitation, the SQL Server database drivers convert DECIMAL(p) types to
a DECIMAL( 2\*p, p ), to store all possible numbers an INFORMIX
DECIMAL(p) can store. However, the original INFORMIX precision cannot
exceed 19, since SQL Server maximum DECIMAL precision is 38 (2\*19). If
the original precision is bigger as 19, a CREATE TABLE statement
executed from a Genero program will fail with an SQL Server error
2750.**

[In database creation scripts:]{.underline}

- SMALLINT, INTEGER and BIGINT columns do not have to use another data
  type in SQL SERVER.
- For DECIMALs, check the precision limit. Always use a precision and a
  scale.
- Convert MONEY columns to DECIMAL(p,s) columns. Always use a precision
  and a scale.
- Convert SMALLFLOAT columns to REAL columns.
- Since FLOAT precision is ignored in INFORMIX, convert this data type
  to FLOAT(15).

------------------------------------------------------------------------

[ODIMSV022 - Getting one row with SELECT]{#ODIMSV022}

With INFORMIX, you must use the system table with a condition on the
table id :

   SELECT user FROM systables **WHERE tabid=1**

With SQL SERVER, you can omit the FROM clause to generate one row only:

   SELECT user

**[*Solution:*]{.underline}**

Check the BDL sources for \"FROM systables WHERE tabid=1\" and use
dynamic SQL to resolve this problem.

------------------------------------------------------------------------

[ODIMSV024 - MATCHES and LIKE in SQL conditions]{#ODIMSV024}

INFORMIX supports MATCHES and LIKE in SQL statements, while Microsoft
SQL SERVER supports the LIKE statement only.

The MATCHES operator of INFORMIX uses the star (\*), question mark (?)
and square braces (\[ \]) wildcard characters.\
The LIKE operator of SQL SERVER offers the percent (%), underscore (\_)
and square braces (\[ \]) wildcard characters.

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

[ODIMSV025 - INFORMIX specific SQL statements in BDL]{#ODIMSV025}

The BDL compiler supports several INFORMIX specific SQL statements that
have no meaning when using Microsoft SQL SERVER.

Examples:

- CREATE DATABASE dbname **IN dbspace WITH BUFFERED LOG**
- **START DATABASE** (SE only)
- **ROLLFORWARD DATABASE**
- CREATE TABLE \... **IN dbspace WITH LOCK MODE ROW**

***[Solution:]{.underline}***

Review your BDL source and remove all static SQL statements that are
INFORMIX specific.

------------------------------------------------------------------------

[ODIMSV028 - INSERT cursors]{#ODIMSV028}

INFORMIX supports insert cursors. An \"insert cursor\" is a special BDL
cursor declared with an INSERT statement instead of a SELECT statement.
When this kind of cursor is open, you can use the PUT instruction to add
rows and the FLUSH instruction to insert the records into the database.

For INFORMIX database with transactions, OPEN, PUT and FLUSH
instructions must be executed within a transaction.

Microsoft SQL SERVER does not support insert cursors.

**[*Solution:*]{.underline}**

Insert cursors are emulated by the Microsoft SQL SERVER database
interface.

------------------------------------------------------------------------

[ODIMSV030 - Very large data types]{#ODIMSV030}

INFORMIX and Genero support the **TEXT** and **BYTE** types. TEXT is
used to store large text data, while BYTE is used to store large binary
data like images or sound.

Microsoft SQL SERVER provides **text**, **ntext** and **image** data
types to store large data, but these data types are considered as
obsolete in SQL SERVER 2005 and will be removed in a future version.
When using SQL SERVER 2005, Microsoft recommends to user
**varchar(max)**, **nvarchar(max)** and **varbinary(max)** data type
instead. These \"max\" data types are not supported with the **MSV**
database driver, since it is based on MDAC ODBC. You must use the new
**SNC** database driver based on the SQL Native Client ODBC driver
shipped with SQL SERVER 2005.

In SQL Server 2005 and 2008, the \*var\*(max) types have a limit of 2
gigabytes (2\^31 -1 actually). Old text, ntext and image types have the
same limit.

**[*Solution:*]{.underline}**

**Warning:** Genero TEXT/BYTE program variables have a limit of 2
gigabytes, make sure that the large object data does not exceed this
limit. This is the case with SQL Server 2005 and 2008 when using the
\*var\*(max) types.

**Warning:** When using a stored procedure that has SET/IF statements
and produces a result set with LOBs, the LOB columns must appear at the
end of the SELECT list. If LOB columns are followed by other columns
with regular types, fetching rows will fail. Using SET NOCOUNT ON in the
stored procedure does not help: The reason is because the cursor type is
changed from server cursor to a default result set cursor.

When using the **MSV** database driver based on MDAC ODBC, the **TEXT**
and **BYTE** data types of a static CREATE TABLE statement are converted
to **text** and **image** SQL SERVER types.

When using the **SNC, FTM or ESM** database drivers, the **TEXT** and
**BYTE** data types of a static CREATE TABLE statement are converted to
**varchar(max)** and **varbinary(max)** SQL SERVER types.

All database drivers make the appropriate bindings to use TEXT and BYTE
types as SQL parameters and fetch buffers.

------------------------------------------------------------------------

[ODIMSV031 - Cursors WITH HOLD]{#ODIMSV031}

INFORMIX automatically closes opened cursors when a transaction ends
unless the WITH HOLD option is used in the DECLARE instruction.

Microsoft SQL SERVER does not close cursors when a transaction ends. You
can change this behavior using the SET CURSOR_CLOSE_ON_COMMIT ON.

**[*Solution:*]{.underline}**

BDL cursors that are not declared \"WITH HOLD\" are automatically closed
by the database interface when a COMMIT WORK or ROLLBACK WORK is
performed by the BDL program.

------------------------------------------------------------------------

[ODIMSV033 - Querying system catalog tables]{#ODIMSV033}

As in INFORMIX, Microsoft SQL SERVER provides system catalog tables
(sysobjects,syscolumns,etc) in each database, but the table names and
their structure are quite different.

**[*Solution:*]{.underline}**

**Warning:** No automatic conversion of INFORMIX system tables is
provided by the database interface.

------------------------------------------------------------------------

[ODIMSV034 - Syntax of UPDATE statements]{#ODIMSV034}

INFORMIX allows a specific syntax for UPDATE statements:

    UPDATE table SET ( \<col-list\> ) = ( \<val-list\> )

or

    UPDATE table SET table.\* = myrecord.\*\
    UPDATE table SET \* = myrecord.\*

**[*Solution:*]{.underline}**

Static UPDATE statements using the above syntax are converted **by the
compiler** to the standard form :\
\
    UPDATE table SET column=value \[,\...\]

------------------------------------------------------------------------

[ODIMSV035 - The LENGTH() function]{#ODIMSV035}

INFORMIX provides the LENGTH() function:

    SELECT LENGTH(\"aaa\"), LENGTH(col1) FROM table

Microsoft SQL SERVER has a equivalent function called LEN().

Do not confuse LEN() with DATALEN(), which returns the data size used
for storage(number of bytes).

Both INFORMIX and SQL SERVER ignore trailing blanks when computing the
length of a string.

**[*Solution:*]{.underline}**

You must adapt the SQL statements using LENGTH() and use the LEN()
function.

**Warning:** If you create a user function in SQL SERVER as follows:

create function length(@s varchar(8000))\
returns integer\
as\
begin\
return len(@s)\
end

You must qualify the function with the owner name:

    SELECT dbo.length(col1) FROM table

------------------------------------------------------------------------

[ODIMSV036 - INTERVAL data type]{#ODIMSV036}

INFORMIX\'s INTERVAL data type stores a value that represents a span of
time. INTERVAL types are divided into two classes : *year-month
intervals* and *day-time intervals.*

SQL SERVER does not provide a data type corresponding to the INFORMIX
INTERVAL data type.

**[*Solution:*]{.underline}**

**Warning:** The INTERVAL data type is not well supported because the
database server has no equivalent native data type. However, you can
store into and retrieve from CHAR columns BDL INTERVAL values.

------------------------------------------------------------------------

[ODIMSV039 - Data storage concepts]{#ODIMSV039}

An attempt should be made to preserve as much of the storage information
as possible when converting from INFORMIX to Microsoft SQL SERVER. Most
important storage decisions made for INFORMIX database objects (like
initial sizes and physical placement) can be reused in an SQL SERVER
database.

Storage concepts are quite similar in INFORMIX and in Microsoft SQL
SERVER, but the names are different.

The following table compares INFORMIX storage concepts to Microsoft SQL
SERVER storage concepts :

::: {align="center"}
**INFORMIX**
:::

**Microsoft SQL SERVER**

Physical units of storage

The largest unit of physical disk space is a \"**chunk**\", which can be
allocated either as a cooked file ( I/O is controlled by the OS) or as
raw device (=UNIX partition, I/O is controlled by the database engine).
A \"dbspace\" uses at least one \"chunk\" for storage.\
You must add \"chunks\" to \"dbspaces\" in order to increase the size of
the logical unit of storage.

SQL SERVER uses \"**filegroups**\", based on Windows NT operating system
files and therefore define the physical location of data.

A \"**page**\" is the smallest physical unit of disk storage that the
engine uses to read from and write to databases.\
A \"chunk\" contains a certain number of \"pages\".\
The size of a \"page\" must be equal to the operating system\'s block
size.

As in INFORMIX, SQL SERVER stores data in \"**pages**\" with a size
fixed at 2Kb in V6.5 and 8Kb in V7 and later.

An \"**extent**\" consists of a collection of continuous \"pages\" that
the engine uses to allocate both initial and subsequent storage space
for database tables.\
When creating a table, you can specify the first extent size and the
size of future extents with the EXTENT SIZE and NEXT EXTENT options.\
For a single table, \"extents\" can be located in different \"chunks\"
of the same \"dbspace\".

An \"**extent**\" is a specific number of 8 contiguous pages, obtained
in a single allocation.\
Extents are allocated in the filegroup used by the database.

Logical units of storage

A \"**table**\" is a logical unit of storage that contains rows of data
values.

Same concept as INFORMIX.

A \"**database**\" is a logical unit of storage that contains table and
index data. Each database also contains a system catalog that tracks
information about database elements like tables, indexes, stored
procedures, integrity constraints and user privileges.

Same concept as INFORMIX.\
When creating a \"**database**\", you must specify which \"database
devices\" (V6.5) or \"filegroup\" (V7) has to be used for physical
storage.

Database tables are created in a specific \"**dbspace**\", which defines
a logical place to store data.\
If no dbspace is given when creating the table, INFORMIX defaults to the
current database dbspace.

Database tables are created in a database based on \"database devices\"
(V6.5) or a \"filegroup\" (V7), which defines the physical storage.

The total disk space allocated for a table is the \"**tblspace**\",
which includes \"pages\" allocated for data, indexes, blobs, tracking
page usage within table extents..

No equivalent.

Other concepts

When initializing an INFORMIX engine, a \"**root dbspace**\" is created
to store information about all databases, including storage information
(chunks used, other dbspaces, etc.).

SQL SERVER uses the \"**master**\" database to hold system stored
procedures, system messages, SQL SERVER logins, current activity
information, configuration parameters of other databases.

The \"**physical log**\" is a set of continuous disk pages where the
engine stores \"before-images\" of data that has been modified during
processing.\
The \"**logical log**\" is a set of \"**logical-log files**\" used to
record logical operations during on-line processing. All transaction
information is stored in the logical log files if a database has been
created with transaction log.\
INFORMIX combines \"physical log\" and \"logical log\" information when
doing fast recovery. Saved \"logical logs\" can be used to restore a
database from tape.

Each database has its own \"**transaction log**\" that records all
changes to the database. The \"transaction log\" is based on a
\"database device\" (V6.5) or \"filegroup\" (V7) which is specified when
creating the database.\
SQL SERVER checks the \"transaction logs\" for automatic recovery.

------------------------------------------------------------------------

[ODIMSV040 - National characters data types]{#ODIMSV040}

------------------------------------------------------------------------

## [ODIMSV041 - Executing SQL statements]{#ODIMSV041}

The database driver for Microsoft SQL SERVER is based on ODBC. The ODBC
driver implementation provided with SQL SERVER uses system stored
procedures to prepare and execute SQL statements (You can see this with
the Profiler).

Some Transact-SQL statements like SET DATEFORMAT have a local execution
context effect (for example, when executed in a stored procedure, it is
reset to the previous values when procedure execution is finished).

To support such statements in BDL programs, the database driver uses the
SQLExecDirect() ODBC API function when the SQL statement is not a
SELECT, INSERT, UPDATE or DELETE. This way the SET statement is executed
\'directly\', without using the system stored procedures. The result is
that the SET statement has the expected effect (i.e. a permanent
effect).

However, if the SQL statement uses parameters, the ODBC driver forces
the use of system stored procedures to execute the statement.

See the MSDN for more details about system stored procedures used by
Microsoft APIs.

------------------------------------------------------------------------

## [ODIMSV046 - The LOAD and UNLOAD instructions]{#ODIMSV046}

INFORMIX provides two SQL instructions to export / import data from /
into a database table: The UNLOAD instruction copies rows from a
database table into an text file and the LOAD instruction inserts rows
from an text file into a database table.

**Warning:** Microsoft SQL SERVER has LOAD and UNLOAD instructions, but
those commands are related to database backup and recovery. Do not
confuse with INFORMIX commands.

**[*Solution:*]{.underline}**

LOAD and UNLOAD instructions are supported.

**Warning:** The LOAD instruction does not work with tables using
emulated SERIAL columns because the generated INSERT statement holds the
\"SERIAL\" column which is actually a IDENTITY column in SQL SERVER. See
the limitations of INSERT statements when using [SERIALs](#ODIMSV005).

**Warning:** With Microsoft SQL SERVER versions prior to 2008, INFORMIX
DATE data is stored in DATETIME columns, but DATETIME columns are
similar to INFORMIX DATETIME YEAR TO FRACTION(3) columns. Therefore,
when using LOAD and UNLOAD, those columns are converted to text data
with the format \"YYYY-MM-DD hh:mm:ss.fff\". However, since SQL SERVER
2008, INFORMIX DATE data is stored in SQL SERVER DATE columns, so the
result of a LOAD or UNLOAD statement is equivalent when using a DATE
column with SQL SERVER 2008.

**Warning:** With Microsoft SQL SERVER versions prior to 2008, INFORMIX
DATETIME data is stored in DATETIME columns, but DATETIME columns are
similar to INFORMIX DATETIME YEAR TO FRACTION(3) columns. Therefore,
when using LOAD and UNLOAD, those columns are converted to text data
with the format \"YYYY-MM-DD hh:mm:ss.fff\". With SQL SERVER 2008,
INFORMIX DATETIME data is stored in SQL SERVER DATETIME2(n\<=5) or
TIME(n\<=5) columns. Concerning DATETIME2(n\<=5) columns, the result of
LOAD and UNLOAD is equivalent to INFORMIX DATETIME columns, as long as
the original INFORMIX type starts with the YEAR qualifier. The text data
will be \"YYYY-MM-DD hh:mm:ss.\<*fraction-digits*\>\", where
*fraction-digits* depends on the precision (n) of the DATETIME2(n)
column. Concerning TIME(n) columns, the type is converted to an INFORMIX
DATETIME HOUR TO SECOND or FRACTION(n). The text data will be
\"hh:mm:ss.\<*fraction-digits*\>\", where *fraction-digits* depends on
the precision (n) of the TIME(n) column.

**Warning:** When using an INFORMIX database, simple dates are unloaded
with the DBDATE format (ex: \"23/12/1998\"). Therefore, unloading from
an INFORMIX database for loading into a Microsoft SQL SERVER database is
not supported.

------------------------------------------------------------------------

[ODIMSV047 - Case sensitivity]{#ODIMSV047}

In INFORMIX, database object names like table and column names are not
case sensitive :

> CREATE TABLE Customer ( Custno INTEGER, \... )\
> SELECT CustNo FROM cuSTomer \...

In SQL SERVER, database object names **and character data** are
case-**in**sensitive by default:

> CREATE TABLE Customer ( Custno INTEGER, CustName CHAR(20) )\
> INSERT INTO CUSTOMER VALUES ( 1, \'TECHNOSOFT\' )\
> SELECT CustNo FROM cuSTomer WHERE custname = \'techNOSoft\'

The installation program of SQL SERVER allows you to customize the
**sort order**. The sort order specifies the rules used by SQL SERVER to
collate, compare, and present character data. **It also specifies
whether SQL SERVER is case-sensitive**.

**[*Solution:*]{.underline}**

Select the case-sensitive sort order when installing SQL SERVER.

------------------------------------------------------------------------

[ODIMSV051 - Setup database statistics]{#ODIMSV051}

INFORMIX provides a special instruction to compute database statistics
in order to help the optimizer find the right query execution plan :

> UPDATE STATISTICS \...

Microsoft SQL SERVER offers a similar instruction, but it uses different
clauses :

> UPDATE STATISTICS \...

See SQL SERVER documentation for more details.

[***Solution:***]{.underline}

Centralize the optimization instruction in a function.

------------------------------------------------------------------------

## [ODIMSV052 - String concatenation operator]{#ODIMSV052}

INFORMIX concatenation operator is the double pipe ( \|\| ) :

     SELECT firstname \|\| \' \' \|\| lastname FROM employee

Microsoft SQL SERVER concatenation operator is the plus sign :

     SELECT firstname + \' \' + lastname FROM employee

[***Solution:***]{.underline}

The database interface detects double-pipe operators in SQL statements
and converts them to a plus sign automatically.

------------------------------------------------------------------------

## [ODIMSV053 - The ALTER TABLE instruction]{#ODIMSV053}

INFORMIX and MS SQL SERVER use different implementations of the ALTER
TABLE instruction. For example, INFORMIX allows you to use multiple ADD
clauses separated by comma. This is not supported by SQL SERVER :

INFORMIX:\
     ALTER TABLE customer  **ADD(col1 INTEGER), ADD(col2 CHAR(20))**

SQL SERVER:\
     ALTER TABLE customer  **ADD col1 INTEGER, col2 CHAR(20)**

[***Solution:***]{.underline}

**Warning:** No automatic conversion is done by the database interface.
There is even no real standard for this instruction ( that is, no common
syntax for all database servers). Read the SQL documentation and review
the SQL scripts or the BDL programs in order to use the database server
specific syntax for ALTER TABLE.

------------------------------------------------------------------------

## [ODIMSV054 - SQL Interruption]{#ODIMSV054}

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

SQL SERVER 2005 supports SQL Interruption in a similar way as INFORMIX.
The db client must issue an SQLCancel() ODBC call to interrupt a query.

[*Solution:*]{.underline}

The **SNC** and **ESM** database drivers support SQL interruption and
return the INFORMIX error code **-213** if the statement is interrupted.

**Warning:** Make sure you have SQL SERVER 2005 or higher installed and
that you use the **SNC** or **ESM** database driver.

------------------------------------------------------------------------

## [ODIMSV055 - Scrollable Cursors]{#ODIMSV055}

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

SQL Server supports native scrollable cursors.

***[Solution:]{.underline}***

All the SQL SERVER database drivers uses the native SQL Server
scrollable cursors by setting the ODBC statement attribute
SQL_ATTR_CURSOR_SCROLLABLE to SQL_SCROLLABLE.

------------------------------------------------------------------------

[ODIMSV100 - Data type conversion table]{#ODIMSV100}

::: {align="center"}
  ----------------------- ----------------------- -----------------------
  **INFORMIX Data Types** **SQL SERVER** **Data   **SQL SERVER** **Data
                          Types (\<2008)**        Types (\>=2008)**

  CHAR(n)                 CHAR(n) (limit =        CHAR(n) (limit =
                          8000c!)                 8000c!)

  VARCHAR(n)              VARCHAR(n) (limit =     VARCHAR(n) (limit =
                          8000c!)                 8000c!)

  BOOLEAN                 BIT                     BIT

  SMALLINT                SMALLINT                SMALLINT

  INTEGER                 INTEGER                 INTEGER

  BIGINT                  BIGINT                  BIGINT

  INT8                    BIGINT                  BIGINT

  FLOAT\[(n)\]            FLOAT(n)                FLOAT(n)

  SMALLFLOAT              REAL                    REAL

  DECIMAL(p,s)            DECIMAL(p,s)            DECIMAL(p,s)

  DECIMAL(p) with p\<=19  DECIMAL(2\*p,p)         DECIMAL(2\*p,p)

  DECIMAL(p) with p\>19   *N/A*                   *N/A*

  MONEY(p,s)              DECIMAL(p,s)            DECIMAL(p,s)

  MONEY(p)                DECIMAL(p,2)            DECIMAL(p,2)

  MONEY                   DECIMAL(16,2)           DECIMAL(16,2)

  DATE                    DATETIME                DATE

  DATETIME HOUR TO MINUTE DATETIME                TIME(0)

  DATETIME HOUR TO        DATETIME                TIME(n)
  FRACTION(n)                                     

  DATETIME YEAR TO SECOND DATETIME                DATETIME2(0)

  Other sort of DATETIME  DATETIME                DATETIME2(n)
  type                                            

  INTERVAL q1 TO q2       CHAR(n)                 CHAR(n)

  TEXT                    VARCHAR(MAX)\           VARCHAR(MAX)
                          *(TEXT with MSV         
                          driver)*                

  BYTE                    VARBINARY(MAX)\         VARBINARY(MAX)
                          *(IMAGE with MSV        
                          driver)*                
  ----------------------- ----------------------- -----------------------
:::
