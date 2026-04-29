[Back to Contents](../index.html)

------------------------------------------------------------------------

# ODI Adaptation Guide For Genero db 3.6x, 3.8x

Installation

::: {align="center"}
  -------------------------------------------------------------------
  [Install Genero db and create a database](#ODIADS_PREP01)
  [Prepare the runtime environment](#ODIADS_PREP02)
  [Driver availability matrix](#ODIADS_DRVAV)
  [Migrating from Genero db 3.61 to 3.80 and +](#ODIADS_MIG01)
  [Driver Manager independency with Genero BDL 2.21](#ODIADS_MIG02)
  -------------------------------------------------------------------
:::

Database concepts

::: {align="center"}
  ------------------------------------------------------------
  [Database concepts](#ODIADS007a)
  [Data consistency and concurrency management](#ODIADS008a)
  [Transactions handling](#ODIADS009a)
  [Defining database users](#ODIADS016a)
  [Setting privileges](#ODIADS016b)
  ------------------------------------------------------------
:::

Data dictionary

::: {align="center"}
  ----------------------------------------------
  [BOOLEAN data type](#ODIADS010)
  [CHARACTER data types](#ODIADS011a)
  [NUMERIC data types](#ODIADS021)
  [DATE data type](#ODIADS001)
  [DATETIME data type](#ODIADS001b)
  [INTERVAL data type](#ODIADS001c)
  [SERIAL data types](#ODIADS005)
  [ROWIDs](#ODIADS004)
  [The ALTER TABLE instruction](#ODIADS053)
  [Constraints](#ODIADS012)
  [Triggers and Stored Procedures](#ODIADS013)
  [Name resolution of SQL objects](#ODIADS019)
  [Setup database statistics](#ODIADS051)
  [Data type conversion table](#ODIADS100)
  ----------------------------------------------
:::

Data manipulation

::: {align="center"}
  ------------------------------------------------------------
  [Genero db](#ODIADS101) [Sql Error Management](#ODIADS101)
  [Reserved words](#ODIADS003)
  [Outer joins](#ODIADS006)
  [Transactions handling](#ODIADS009a)
  [Temporary tables](#ODIADS017)
  [Substrings in SQL](#ODIADS018)
  [Name resolution of SQL objects](#ODIADS019)
  [String delimiters and object names](#ODIADS020)
  [Getting one row with SELECT](#ODIADS022)
  [MATCHES and LIKE conditions](#ODIADS024)
  [Querying system catalog tables](#ODIADS033)
  [Syntax of UPDATE statements](#ODIADS034)
  [The USER constant](#ODIADS047)
  ------------------------------------------------------------
:::

BDL programming

::: {align="center"}
  -----------------------------------------------------------
  [SERIAL data type](#ODIADS005)
  [IBM®INFORMIX®specific SQL statements in BDL](#ODIADS025)
  [INSERT cursors](#ODIADS028)
  [Cursors WITH HOLD](#ODIADS031)
  [SELECT FOR UPDATE](#ODIADS008b)
  [UPDATE/DELETE WHERE CURRENT OF \<cursor\>](#ODIADS032)
  [The LOAD and UNLOAD instructions](#ODIADS046)
  [SQL Interruption](#ODIADS054)
  [Scrollable Cursors](#ODIADS055)
  -----------------------------------------------------------
:::

------------------------------------------------------------------------

## [Runtime configuration]{#ODIADS_PREP} {#runtime-configuration align="left"}

[[Install Genero db and create a database]{.small}]{#ODIADS_PREP01}

> 1.  Install Genero db on your computer.
>
>     By default, Genero db is configured to run alone on a networked
>     machine, having client applications hosted on other machines. Here
>     are some tips to setup Genero db , you should change some
>     configuration parameters:
>
>     - If applications and the database server are colocated on the
>       same machine: By default, Genero db uses nearly all the memory
>       available on the computer. To share the memory with
>       applications, you must change the **MEMORY_OVERRIDE** parameter
>       in \$ANTSHOME/Server/config.txt.
>
>     - If applications and the database server are colocated on the
>       same machine: If memory is not a concern and if the number of
>       connections is about 50, you may want to try the
>       **networking=IPC** communication protocol in the data source
>       definition to get better performance. Over 50 simultaneous
>       connections, you should use the default TCP-socket protocol.
>
>     - For production use, a caching RAID controller on which to do
>       logging is highly recommended. For maximum data integrity,
>       **LOG_MODE** should be set to **DURABLE**, and **LOGPATH**
>       should point to a different disk than the disk containing data.
>       If **LOGPATH** does not point to a disk managed by a RAID
>       controller, **LOG_MODE** should be set to **OSDURABLE**. See the
>       Genero db documentation for more details.
>
>     - By default, Genero db relies on local area network multicast to
>       enable clients and servers to find each other. If you have a
>       firewall, you must allow **UDP** connections on port **12345**
>       for the multicast address **255.0.0.37**. If you want to disable
>       multicast search: on the server side, set
>       **MULTICAST_ENABLED=FALSE** in \$ANTSHOME/Server/config.txt. On
>       the client side, for Unix platforms, you must set
>       **overridebroadcast=yes** in the ODBC data source definition.
>       For Windows platforms, check the \"**Override Multicast**\"
>       option in the ODBC data source configuration (click the
>       \"*Advanced*\" button, then click \"*Connection Method*\" in the
>       \"*Networking*\" section).
>
>     - If you are running Genero db **3.80** or higher, you must set
>       the server configuration parameter
>       **COMPATIBILITY_MODE=INFORMIX**.**\**
>       For details about the SQL features affected by this parameter,
>       see the *Genero db Migration Guide*.\
>       For details about disabling the compatibility mode check , see
>       below the FGLPROFILE configuration settings.
>
> 2.  Set up an ODBC data source, called *mydb*.\
>     \
>     The default ODBC data source settings need to be adapted:
>
>     - Set **overridebroadcast=yes** if you don\'t need multicast, as
>       described in (1).
>
>     - During the installation of Genero db, the data source might have
>       been created with the login and password of the SYSTEM user. If
>       you leave these default user and password entries, anyone can
>       connect to the database as the user SYSTEM (a superuser). You
>       must clean the **user** and **password** ODBC parameters. This
>       will force client programs to specify a login and password to
>       connect to the database. 
>
>     - By default, the Genero db client re-connects automatically to
>       the server if the connection is lost. This is a useful feature
>       as long as the SQL session is stateless. However, if you create
>       temporary tables or if you change session parameters with ALTER
>       SESSION, the session context will be silently lost if a
>       re-connect occurs. To get an SQL error when DB connection is
>       lost, you can deny the client to re-connect by setting
>       **automaticfailover=no** in the ODBC parameters. Note that the
>       Genero db client does not re-connect automatically if a
>       transaction was started. In such case the program gets and SQL
>       error.
>
>     - Typical Genero applications connect only once to the database
>       server. By default, the Genero db client uses connection
>       aggregators, which re-use connection resources and server
>       bindings for new connections. This is useful when the same
>       client process opens and closes many connections, but is
>       unnecessary overhead in typical Genero applications.\
>       Additionally, using aggregation implies multithreading. UNIX
>       signal handling are not thread safe. Since the runtime system
>       uses the UNIX signal() function, **you [must]{.underline}
>       disable aggregation by setting noaggregators=0 in the ODBC data
>       source definition.** On Windows platforms, the noaggregators
>       property can only be changed with the registry editor, under the
>       ODBC.INI key.
>
>     - The Genero db client library maintains a statement pool by
>       default. When you FREE a cursor or statement in your programs,
>       the underlying ODBC statement handle structure goes to the
>       statement pool for future reuse. You can disable the ODBC
>       statement pool by setting the **disableStmtPool** ODBC.INI
>       parameter to **Yes**. When this parameter is set, fetch buffers
>       are  freed as well an the process consumes less memory.
>
>     - Set the correct database client character set with the
>       **characterset** parameter. This character set must match the
>       character set used by the locale of the runtime system
>       (**LANG/LC_ALL**).
>
>     - You may want to set **useinfxenvvars** to yes to take
>       environment variables such as DBDATE into account regarding date
>       to/from string conversions.
>
> 3.  Create a database user dedicated to your application. You can
>     create database users authenticated by a password or use OS
>     authentication. The example below creates a user authenticated by
>     a password. See the *Genero db Programmer\'s Guide* for more
>     details about OS authentication.\
>     \
>        \$ antscmd -d mydb -u SYSTEM -p SYSTEM\
>        \...\
>         mydb\> CREATE USER *appadmin* IDENTIFIED BY *password*;\
>     \
>     Grant database privileges to the user:\
>     \
>        mydb\> GRANT CREATE SESSION TO *appadmin*;\
>        mydb\> GRANT CREATE TABLE TO *appadmin*;\
>        mydb\> GRANT CREATE VIEW TO *appadmin*;\
>        mydb\> GRANT CREATE SYNONYM TO *appadmin*;\
>        mydb\> GRANT CREATE PROCEDURE TO *appadmin*;\
>        mydb\> GRANT CREATE SEQUENCE TO *appadmin*;
>
> 4.  Create the application tables.\
>     \
>     Do not forget to convert INFORMIX data types to Genero db data
>     types. See issue [ODIADS100](#ODIADS100) for more details.\
>     \
>     Check for reserved words in your table and column names. See the
>     *Genero db SQL Syntax Guide: Appendix B, Reserved Words*

[[Prepare the runtime environment]{.small}]{#ODIADS_PREP02}

> 1.  If you want to connect to a remote Genero db server from an
>     application server, you must have ODBC properly configured on your
>     application server.
>
> 2.  Make sure the the Genero db client environment variables are
>     properly set. Check for example **ANTSHOME** (the path to the
>     installation directory). See Genero db documentation for more
>     details.
>
> 3.  On UNIX systems, verify the ODBC environment variables **ODBCINI**
>     and **ODBCINST**. These must respectively point to the ODBC Data
>     Source definition file (usually, /etc/odbc.ini) and to the ODBC
>     Database Driver definition file (usually, /etc/odbcinst.ini). You
>     will not be able to connect to Genero db if these environment
>     variables are not set.
>
> 4.  Verify the environment variable defining the search path for
>     database client shared libraries (libaodbc.so on UNIX, AODBC.DLL
>     on Windows). On UNIX platforms, the variable is specific to the
>     operating system. For example, on Solaris and Linux systems, it is
>     **LD_LIBRARY_PATH**, on AIX it is **LIBPATH**, or HP/UX it is
>     **SHLIB_PATH**. On Windows, you define the DLL search path in the
>     **PATH** environment variable.
>
>     +-----------------------------------+-----------------------------------+
>     | **Genero db version**             | **Shared library environment      |
>     |                                   | setting**                         |
>     +-----------------------------------+-----------------------------------+
>     | **Version 3.81 and lower**        | *UNIX*: Add                       |
>     |                                   | **\$ANTSHOME/antsodbc** (or       |
>     |                                   | **\$ANTSHOME/antsodbc/64** for 64 |
>     |                                   | bit) to LD_LIBRARY_PATH (or its   |
>     |                                   | equivalent).\                     |
>     |                                   | *Windows*: Add                    |
>     |                                   | **%ANTSHOME%\\antsodbc** to PATH. |
>     +-----------------------------------+-----------------------------------+
>     |                                   |                                   |
>     +-----------------------------------+-----------------------------------+
>
> 5.  To verify if the ODBC environment is correct, you can for example
>     start the Genero db SQL command interpreter:\
>     \
>          \$ antscmd -d *dns-name* -u *appadmin* -p *password*
>
> 6.  Set up the **fglprofile** entries for [database
>     connections](Connections.html#DS_ODI_DBVSPEC) to your data source.
>
> 7.  Starting with the dbmads380 driver, the driver will check for
>     COMPATIBILITY_MODE=INFORMIX at connection time. If you don\'t want
>     to use this compatibility mode in the server, you can bypass the
>     checking with following FGLPROFILE entry:\
>     \
>        dbi.database.*dbname*.ads.compatibility.check = \"none\"\
>     \
>     **Warning: Before disabling the INFORMIX compatibility mode and
>     bypassing its checking in the driver, you must understand that the
>     Genero db server will not behave like Informix servers in some
>     particular cases, like date/numeric formatting and conversions,
>     blank padding semantics in string expressions, and
>     locking/concurrency behavior. For more details about the SQL
>     features affected by the COMPATIBILITY_MODE parameter, see the
>     *Genero db Migration Guide*.**
>
> 8.  Create normal application users and define the schema to be used.\
>     \
>     With Genero db, a schema is created when creating a user. If the
>     *APPADMIN* user creates the tables, the schema for application
>     tables will be \"APPADMIN\".\
>     \
>     In order to make application tables visible to normal DB users,
>     you can specify a default schema for normal users by adding the
>     DEFAULT SCHEMA clause in CREATE USER:\
>     \
>        mydb\> CREATE USER username IDENTIFIED BY password DEFAULT
>     SCHEMA appadmin;\
>     \
>     You can also use the following FGLPROFILE entry to make the
>     database driver select a default schema after connection:\
>     \
>        dbi.database.*dbname*.ads.schema = \"*name*\"\
>     \
>     Here \<**dbname**\> identifies the database name used in the BDL
>     program ( DATABASE **dbname** ) and \<**name**\> is the schema
>     name to be used.\
>     \
>     If needed, database users can be authenticated as *Operating
>     System users*. In order to create a DB user authenticated by the
>     operating system, use the IDENTIFIED EXTERNALLY clause in CREATE
>     USER:\
>     \
>        mydb\> CREATE USER username IDENTIFIED EXTERNALLY;\
>     \
>     The OS users will be able to connect to the database if the
>     \$ANTSHOME/Server/ants.rhosts file contains an entry to identify
>     the OS user.\
>     \
>     **Warning:** Pay attention to the user name, which can be
>     case-sensitive according to the database configuration settings.
>     You can check the name of the database users by querying the
>     system tables (ANTS_ALL_USERS in 3.80).\
>     \
>     See the Genero db documentation for more details about OS users
>     creation.
>
> 9.  Grant privileges to application users:\
>     \
>     By default the tables created by the *appadmin* user cannot be
>     modified by the application users; you must first grant
>     privileges:\
>     \
>        mydb\> GRANT SELECT, INSERT, UPDATE, DELETE ON tablename TO
>     username;\
>     \
>     You can do this for all existing and future users by specifying
>     PUBLIC as the grantee:\
>     \
>        mydb\> GRANT SELECT, INSERT, UPDATE, DELETE ON tablename TO
>     PUBLIC;\
>     \
>     If the database has stored procedures, you must also grant execute
>     permission to application users:\
>     \
>        mydb\> GRANT EXECUTE ON procname TO username;\
>
> 10. In order to connect to Genero db, you must have a database driver
>     \"dbmads\*\" in FGLDIR/dbdrivers.
>     1.  If the server is Genero db version **3.61**, use the
>         **dbmads3x** driver.
>     2.  If the server is Genero db version **3.80**, use the
>         **dbmads380** driver.
>     3.  If the server is Genero db version **3.81**, use the
>         **dbmads381** driver.\
>
> 11. To simplify migration to newer database servers, you can define
>     the driver mode to an older version as the default, and keep using
>     Informix emulations of the old driver (supported starting with
>     Genero BDL 2.20.05):\
>     \
>        dbi.database.*dbname*.ads.driver.mode = [{]{.underline}
>     \"3.61\" [\|]{.underline} \"3.80\" [\|]{.underline} \"3.81\"
>     [}]{.underline}\
>     \
>     See below for more details about server migration.

### [[Driver availability matrix]{.small}]{#ODIADS_DRVAV} {#driver-availability-matrix align="left"}

The next table lists the Genero BDL versions including the different
Genero db drivers:

::: {align="center"}
+---------------+--------------+--------------+--------------+--------------+--------------+--------------+--------------+--------------+
|               | **Genero BDL versions**                                                                                               |
+---------------+--------------+--------------+--------------+--------------+--------------+--------------+--------------+--------------+
| **Genero db   | **2.3x**\    | **2.21\      | **2.20\      | **2.11\      | **2.10\      | **2.02\      | **2.00\      | **1.33\      |
| driver**      | **(from      | (from        | (from        | (from        | (from        | (from        | (from        | (from        |
|               | 2.30.05)**   | 2.21.02)**   | 2.20.09)**   | 2.11.17)**   | 2.10.06)**   | 2.02.18)**   | 2.00.1p)**   | 1.33.2r)**   |
+---------------+--------------+--------------+--------------+--------------+--------------+--------------+--------------+--------------+
| **dbmads3x**  |              |              |              |              |              |              |              |              |
+---------------+--------------+--------------+--------------+--------------+--------------+--------------+--------------+--------------+
| **dbmads380** |              |              |              |              |              |              |              |              |
+---------------+--------------+--------------+--------------+--------------+--------------+--------------+--------------+--------------+
| **dbmads381** |              |              |              |              |              |              |              |              |
+---------------+--------------+--------------+--------------+--------------+--------------+--------------+--------------+--------------+
:::

### [[Migrating from Genero db 3.61 to 3.80 and +]{.small}]{#ODIADS_MIG01} {#migrating-from-genero-db-3.61-to-3.80-and align="left"}

This section lists several issues to be addressed when migrating from
Genero db 3.61 to Genero db 3.80 (and higher). As described later in
this page for some SQL topics, there are important differences with
Informix emulations when using Genero db 3.61 versus Genero db 3.80.
Migrating to a major new version of Genero db should not only be
motivated by bug fixes. You should also benefit from the new Informix
feature emulations implemented in the Genero db server. For example, the
main Informix-compatibility improvement in Genero db 3.80 is the support
for Informix-style DATETIME and INTERVAL data types.

While we strongly recommend that you take the time to migrate your
database schema and use the new native types provided by the last Genero
db server, you may want to install the most recent server but keep using
the old Informix emulations. Starting with Genero BDL 2.20.05, you can
define an [FGLPROFILE parameter](Connections.html#DS_ODI_DBVSPEC) to
force the database driver to work in a specific mode:

   dbi.database.*dbname*.ads.driver.mode = [{]{.underline} \"3.61\"
[\|]{.underline} \"3.80\" [\|]{.underline} \"3.81\" [}]{.underline}

Here is a checklist to help you prepare for your migration to Genero db
3.80:

> 1.  Make sure that you use the correct database driver, as described
>     in the [above](#ODIADS_PREP02) section. Starting with
>     **dbmads380** (since Genero BDL version 2.11.14), the server
>     version string is tested by the driver. If the server version does
>     not match, the program will stop with error
>     **[-6319](FglErrors.html#-6319)**.\
> 2.  **DATETIME** and **INTERVAL** types are now native data types in
>     Genero db 3.80. Before 3.80, DATETIME and INTERVAL had to be
>     stored in TIME, TIMESTAMP and CHAR(50) columns. In order to use
>     the new Informix-compatible data types, you must modify the
>     existing database tables (ALTER TABLE) as well as your database
>     creation scripts . Keep in mind that when creating permanent or
>     temporary tables in your programs at runtime, the dbmads380 driver
>     will no longer convert DATETIME and INTERVAL types to TIME,
>     TIMESTAMP or CHAR(50); the native Genero db DATETIME and INTERVAL
>     types will be used. New data type usage also has an impact on the
>     formatting with LOAD and UNLOAD instructions.\
>     For more details, see [DATETIME data type](#ODIADS001b), [INTERVAL
>     data type](#ODIADS001c) and the [data type conversion
>     matrix](#ODIADS100) at the end of this page.\
> 3.  **DECIMAL(p,s)** data type now supports a precision of 38 digits.
>     With 3.61, the precision was 15 digits, and it was not possible to
>     store DECIMAL or MONEY data using a higher precision. This was a
>     3.61 limitation/bug. With 3.80, the DECIMAL(p,s) data type can
>     support the 32-digit maximum imposed by Informix. Migrating to
>     3.80 will not have an impact.\
> 4.  If new data types hare being used (DATETIME/INTERVAL), you must
>     re-generate the [database schema file](DatabaseSchema.html) and
>     recompile your programs and forms.\
> 5.  We strongly recommend that you set the
>     **COMPATIBILITY_MODE=INFORMIX** server parameter. Without this
>     configuration setting, the dbmads380 and + drivers will refuse to
>     connect to the server. You can disable this checking with an
>     [FGLPROFILE parameter](Connections.html#DS_ODI_DBVSPEC), but it is
>     not recommended, as some SQL features will then not work as
>     expected.\
> 6.  **SQL Interruption** (OPTIONS SQL INTERRUPT ON/OFF) can now be
>     used with Genero db 3.80. This important feature was not working
>     with 3.61. With this feature, you can cancel long running queries.
>     See [SQL Interruption](#ODIADS054) for more details.\
> 7.  You must also consider **Genero db product specific changes**
>     independent from Genero BDL and Genero db database driver changes,
>     which are not covered by this ODI migration guide. For example,
>     Genero db 3.80 includes enhancements in user management and
>     policy. You must now GRANT CREATE SESSION privileges to let users
>     connect to the server. See Genero db documentation and release
>     notes for more details. 

### [[Driver Manager independency with Genero Genero BDL 2.21]{.small}]{#ODIADS_MIG02} {#driver-manager-independency-with-genero-genero-bdl-2.21 align="left"}

Starting with Genero BDL version **2.21.00**, like UNIX/Linux ODI
drivers linked to libaodbc.so, the Windows drivers are now directly
linked with the Genero db client library (AODBC.DLL), to by-pass the
Windows Driver Manager (ODBC32.DLL). This was required to avoid the
charset conversions done by the Windows DM, to support UTF-8 characters
in SQL Text (bug 14789).

The ODBC data source and settings must still be configured with the ODBC
Data Source Administrator on Windows. However, some Driver Manager
features such as ODBC trace will no longer work, and the Genero db
client DLL specification (*Driver* entry) will be ignored by Genero BDL
runtime system, since the dbmads\* drivers are directly linked to
AODBC.DLL.

**Warning: Assuming that the AODBC.DLL library is not copied into the
C:\\WINDOWS\\SYSTEM32 directory, the AODBC.DLL used by Genero BDL will
now be found from the PATH environment variable, while with older
versions, AODBC.DLL was loaded dynamically by the Driver Manager
according to DSN settings. You must pay attention to this change if you
are using different versions of Genero db client on the same machine. If
you have installed multiple versions of the Genero db client, you better
remove the AODBC.DLL file from the SYSTEM32 directory.**

------------------------------------------------------------------------

## [ODIADS001 - DATE data type]{#ODIADS001}

INFORMIX supports the DATE data type to store year, month and day
information:

- **DATE** = for year, month and day storage.

Genero db has an equivalent type with the same name.

String representing date time information: INFORMIX is able to convert
quoted strings to DATE data, if the string formatting matches the
formatting set by environment parameters (DBDATE). Genero db can also
convert quoted strings to DATE; by default, date/time formats follow the
ISO standard (2005-01-30).

Date arithmetic:

- INFORMIX supports date arithmetic on DATE values. The result of an
  arithmetic expression involving dates is a number of days when DATEs
  are used.
- In Genero db, the result of an arithmetic expression involving DATE
  values is a number of days. You can subtract or add a integer to a
  DATE column.
- INFORMIX automatically converts an integer to a date when the integer
  is used to set a value of a date column. Genero db does not do this
  conversion; review your code and change it to use a DATE type
  variable.

***[Solution:]{.underline}***

The Genero db DATE type is used for INFORMIX DATE data. Arithmetic
expressions involving dates (for example, to add or remove a number of
days from a date) will produce the same results with Genero db as
INFORMIX.

**Warning:** Using integers (the number of days since 1899/12/31) as
dates is supported by Genero db in a SELECT INTO statement but not in a
WHERE clause. Check your code to detect the use of integers with DATE
columns. With INFORMIX and Genero db, a date of 1900/1/1 when selected
into an INTEGER will be converted to 1.

**Warning:** It is strongly recommended that you use BDL variables in
dynamic SQL statements instead of quoted strings representing DATEs. For
example:\
   LET stmt = \"SELECT \... FROM customer WHERE create_date \>\'\",
adate,\"\'\"\
is not portable.  Use a question mark place holder instead and OPEN the
cursor by USING a date:\
   LET stmt = \"SELECT \... FROM customer WHERE create_date \> ?\"

**Warning:** Before Genero db **3.80**, DATE arithmetic expressions
using SQL parameters (USING variables) are not fully supported. For
example: \"SELECT \... WHERE datecol \< ? + 1\" generates an error at
PREPARE time.

------------------------------------------------------------------------

## [ODIADS001b - DATETIME data type]{#ODIADS001b}

INFORMIX has the DATETIME data type to store year to fraction
information.

- **DATETIME** = for year to fraction of a second (1-5) storage.

Genero db **3.61** has the following equivalents for INFORMIX DATETIME:

- **TIME** = for hour, minute, and second storage.
- **TIMESTAMP** = for year, month, day, hour, min, second, and fraction
  of second storage.
- **DATETIME** = Synonym for TIMESTAMP.

Genero db **3.80** supports DATETIME and INTERVAL types likes INFORMIX:

- **DATETIME start TO end**
- **INTERVAL start\[(prec)\] TO end**

String representing date time information: INFORMIX is able to convert
quoted strings to DATETIME data, if the string formatting matches the
formatting set by environment parameters (GL_DATETIME). Genero db can
also convert quoted strings to DATE / TIME / TIMESTAMP; by default,
date/time formats follow the ISO standard (2005-01-30).

Date arithmetic:

- INFORMIX supports date arithmetic on DATETIME values. The result of an
  arithmetic expression involving DATETIME expressions is an INTERVAL
  expression.
- In Genero db **3.80**, DATETIME arithmetic and INTERVAL arithmetic are
  supported by the server.

***[Solution:]{.underline}***

With Genero db **3.80**:

DATETIME and INTERVAL types can be used as with INFORMIX, since these
types are supported as native server types.

With Genero db **3.61**:

INFORMIX DATETIME data with a precision from HOUR TO SECOND is stored in
a Genero db TIME column. DATETIME data with any other precision is
stored in Genero db TIMESTAMP columns. The database interface makes the
conversion automatically. Missing date or time parts default to
1900-01-01 00:00:00. For example, when using a DATETIME HOUR TO MINUTE
with the value of \"11:45\", the Genero db DATETIME value will be
\"1900-01-01 11:45:00\".

**Warnings:**

1.  Literal DATETIME expressions (i.e. DATETIME 1999-10-12 YEAR TO DAY)
    are not converted.
2.  SQL Statements using expressions with EXTEND must be reviewed and
    adapted to the native syntax.

------------------------------------------------------------------------

## [ODIADS001c - INTERVAL data type]{#ODIADS001c}

INFORMIX\'s INTERVAL data type stores a value that represents a span of
time.

INTERVAL types are divided into two classes: *year-month intervals* and
*day-time intervals*.

Genero db **3.61** does not provide a data type similar to INFORMIX
INTERVAL, but since version **3.80**, Genero db supports DATETIME and
INTERVAL data types as INFORMIX.

***[Solution:]{.underline}***

Use Genero db version **3.80** if you want to store INFORMIX-like
INTERVAL values, with full support of DATETIME arithmetics.

------------------------------------------------------------------------

## [ODIADS003 - Reserved words]{#ODIADS003}

SQL object names, like table and column names, cannot be SQL reserved
words in Genero db. An example of a common word which is part of the
Genero db SQL grammar is **\'level**\'

***[Solution:]{.underline}***

You must rename those table or column names that are Genero db reserved
words. Genero db reserved keywords are listed in the Genero db
documentation. \
Another solution is to enclose the table/column name in double quotes.
Double-quoted table/column names are case-sensitive. If this
double-quoted syntax is used, all subsequent references to this
table/column must be in the same double-quoted format.

------------------------------------------------------------------------

## [ODIADS004 - ROWIDs]{#ODIADS004}

Genero db provides ROWIDs, but the data type is different from INFORMIX.
INFORMIX ROWIDs are INTEGERs, while Genero db ROWIDs are BIGINT.

**Warning:** Genero db ROWIDs can be used to identify a unique row
during the lifetime of the transaction. After the transaction is
committed, the ROWID may change.

With INFORMIX, SQLCA.SQLERRD\[6\] contains the ROWID of the last
INSERTed or UPDATEd row. This is not currently supported with Genero db.

***[Solution:]{.underline}***

**Warning:** Genero db ROWIDs are not fully compatible with INFORMIX
ROWIDs.

It is recommended that you review the code and remove any usage of
ROWIDs, as their usage is not portable to other databases and may lead
to problems when the code runs against any other databases. (For
example, Oracle has ROWIDs, but they are CHARs instead of numeric.)

------------------------------------------------------------------------

## **[ODIADS005 - SERIAL data types]{#ODIADS005}**

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

INFORMIX allows you to insert rows with a value other than zero for a
serial column. Using an explicit value automatically increments the
internal serial counter, to avoid conflicts with future INSERTs that are
using a zero value:\
    CREATE TABLE tab ( k SERIAL );  \--\> internal counter = 0\
    INSERT INTO tab VALUES ( 0 );   \--\> internal counter = 1\
    INSERT INTO tab VALUES ( 10 );  \--\> internal counter = 10\
    INSERT INTO tab VALUES ( 0 );   \--\> internal counter = 11\
    DELETE FROM tab;                \--\> internal counter = 11\
    INSERT INTO tab VALUES ( 0 );   \--\> internal counter = 12

Genero db supports serial types like INFORMIX.

***[Solution:]{.underline}***

When using Genero db, the SERIAL data type works the same as in
INFORMIX. After an insert, sqlca.sqlerrd\[2\] holds the last generated
serial value.

CREATE \[TEMP\] TABLE with a SERIAL column works as in INFORMIX.

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

## [ODIADS006 - Outer joins]{#ODIADS006}

The Genero db syntax for OUTER joins is different from the original
INFORMIX outer join syntax:

In INFORMIX SQL, outer tables are defined in the FROM clause using the
OUTER keyword:

> SELECT ... FROM a, OUTER(b)
>      WHERE a.key = b.akey
>
>     SELECT ... FROM a, OUTER(b,OUTER(c))
>      WHERE a.key = b.akey
>        AND b.key1 = c.bkey1
>        AND b.key2 = c.bkey2 

Genero db version 3.60 supports the same OUTER joins syntax as INFORMIX.

Genero db also supports ANSI syntax joins:

> SELECT ... FROM a, LEFT OUTER JOIN b ON a.key = b.key
>
>     SELECT ... FROM a 
>         LEFT OUTER JOIN  b LEFT OUTER JOIN c
>         ON ( (b.key1 = c.bkey1) AND (b.key2 = c.bkey2) ) ON ( (a.key = b.akey) )

***[Solution:]{.underline}***

Genero db supports INFORMIX outer joins syntax, with the following
limitation:

1.  Sub-queries are not allowed in outer-join predicates.

However, for SQl portability, you should use the ANSI outer join syntax
instead of the old Informix OUTER syntax.

------------------------------------------------------------------------

## [ODIADS007a - Database concepts]{#ODIADS007a}

Most BDL applications use only one database instance (in the meaning of
INFORMIX). But INFORMIX servers can handle multiple database instances,
while Genero db servers manage only one database instance. However,
Genero db can manage multiple schemas.

      SELECT \* FROM **stores**.customer

***[Solution:]{.underline}***

With Genero db, you can create as many  users as database schemas are
needed. You typically dedicate a database user to administer each
occurrence of the application database (i.e. schema in Genero db).

Any user can select the current database schema with the following SQL
command:

      SET SCHEMA \"\<schema\>\"

Using this instruction, any user can access the tables without giving
the owner prefix, as long as the table owner has granted privileges
required to access the tables.

Genero db users can be associated to a default schema as follows:

      CREATE USER \"\<username\>\" IDENTIFIED \...\
             DEFAULT SCHEMA \"\<schema\>\"

This is the preferred way to assign a schema to DB users.

You can also make the database interface select the current schema
automatically using the following FGLPROFILE entry:

       dbi.database.\<dbname\>.ads.schema = \"\<schema\>\"

**Warning:** double-quoted schema/user names are case-sensitive.

------------------------------------------------------------------------

## [ODIADS008a - Data consistency and concurrency management]{#ODIADS008a}

[Data consistency]{.underline} involves readers that want to access data
currently being modified. [Concurrency data access]{.underline} involves
several writers accessing the same data for modification. [Locking
granularity]{.underline} defines the amount of data involved when a lock
is set (row, page, table, and other groupings).

[INFORMIX:]{.underline}

INFORMIX uses a locking mechanism to handle data consistency and
concurrency. When a process changes database information with UPDATE,
INSERT or DELETE, an [exclusive lock]{.underline} is set on the touched
rows. The lock remains active until the end of the transaction.
Statements performed outside a transaction are treated as a transaction
containing a single operation, and release the locks immediately after
execution. SELECT statements can set [shared locks]{.underline}
according to the [isolation level]{.underline}. In case of locking
conflicts (for example, when two processes want to acquire an exclusive
lock on the same row for modification, or when a writer is trying to
modify data protected by a shared lock), the behavior of a process can
be changed by setting the [lock wait mode]{.underline}.

Control:

- Lock wait mode: SET LOCK MODE TO \...
- Isolation level: SET ISOLATION TO \...
- Locking granularity: CREATE TABLE \... LOCK MODE {PAGE\|ROW}
- Explicit exclusive lock: SELECT \... FOR UPDATE

Defaults:

- The default isolation level is READ COMMITTED.
- The default lock wait mode is **NOT WAIT**.
- The default locking granularity is PAGE.

[Genero db:]{.underline}

Genero db does not use the same locking mechanism as INFORMIX; Genero db
is a lock-avoidance database and thus behaves differently to other
database regarding concurrency.

The following transaction control instructions exist in Genero db:

- Lock wait mode: SET LOCK MODE TO \...
- Isolation level: SET TRANSACTION ISOLATION LEVEL \...
- Explicit exclusive lock: SELECT \... FOR UPDATE

Defaults:

- The default isolation level is READ COMMITTED.
- The default lock wait mode is **WAIT** *(not that this is different
  from Informix default, but follows SQL programming recommendations)*

In order to reduce locking, Genero db supports \"**commutative
updates**\", which allows concurrent transactions to update the same row
without the need to wait for each other. In most cases the result of
concurrent transactions will be the same, however, you better review
programs if some part of the code relies on the fact that an UPDATE
statement sets a lock on the row during the transaction, to avoid other
db sessions to read / modify the row like INFORMIX does in READ
COMMITTED isolation level. Workarounds will be discussed in the
*Solution* part.

***[Solution:]{.underline}***

**Warning:** The LOCK MODE {PAGE\|ROW} is not supported by Genero db.
This is specific to data storage mechanisms and cannot be supported in
the Genero db concurrency model.

You can use the same transaction control instructions and update clauses
as in INFORMIX:

- SET LOCK MODE \...
- SELECT \... FOR UPDATE

The SET ISOLATION TO \... INFORMIX syntax is replaced by SET TRANSACTION
ISOLATION LEVEL \... in Genero db. The next table shows the isolation
level mappings done by the database driver:

::: {align="center"}
  ----------------------------------- -----------------------------------
  **SET ISOLATION instruction in      **Native SQL command**
  program**                           

  SET ISOLATION TO DIRTY READ         SET TRANSACTION ISOLATION LEVEL
                                      READ COMMITTED

  SET ISOLATION TO COMMITTED READ\    SET TRANSACTION ISOLATION LEVEL
    \[READ COMMITTED\] \[RETAIN       READ COMMITTED
  UPDATE LOCKS\]                      

  SET ISOLATION TO CURSOR STABILITY   SET TRANSACTION ISOLATION LEVEL
                                      READ COMMITTED

  SET ISOLATION TO REPEATABLE READ    SET TRANSACTION ISOLATION LEVEL
                                      SERIALIZABLE
  ----------------------------------- -----------------------------------
:::

**Warning:** Since Genero db may not set locks on modified rows during a
transaction, you must check that your code does not rely of the fact
that UPDATE or DELETE statements set locks on the modified rows to
prevent other db session to access the rows.

For example, see the next SQL code sequence, to be run in READ COMMITTED
isolation level:

   BEGIN WORK\
   **UPDATE incr SET value = value + 1 WHERE key = 45**\
   SELECT value FROM incr WHERE key = 45\
   COMMIT WORK

While in INFORMIX the UPDATE statement will set a lock and prevent other
db sessions to access the row for modification until the transaction
ends, Genero db (allowing commutative updates) will not set a lock and
thus let other db sessions increment the row, while the first
transaction is still under progress. As result, a concurrent transaction
may increment the column before the first sessions could actually read
the value it has incremented itself and thus get the last value
incremented by the concurrent transaction.

To workaround this behavior, you can:

1.  use the SERIALIZABLE isolation level (for the duration of this
    transaction only, you better leave COMMITTED READ as default),
2.  do a SELECT FOR UPDATE when entering the transaction:\
       BEGIN WORK\
       **SELECT value FROM incr WHERE key = 45 FOR UPDATE**\
       UPDATE incr SET value = value + 1 WHERE key = 45\
       SELECT value FROM incr WHERE key = 45\
       COMMIT WORK
3.  add an index on the column that is updated. Commutative updates are
    not supported on indexed columns.

------------------------------------------------------------------------

## [ODIADS008b - SELECT FOR UPDATE]{#ODIADS008b}

Many BDL programs implement pessimistic locking in order to prevent
several users editing the same rows at the same time.

  DECLARE cc CURSOR FOR\
     SELECT \... FOR UPDATE \[OF column-list\]\
  OPEN cc\
  FETCH cc \<\-- lock is acquired\
  CLOSE cc \<\-- lock is released

- The row must be fetched in order to set the lock.
- If the cursor is local to a transaction, the lock is released when the
  transaction ends.\
  If the cursor is declared \"WITH HOLD\", the lock is released when the
  cursor is closed.

Genero db allows individual and exclusive row locking with:

  SELECT \... FOR UPDATE \[OF column-list\]

- A lock is acquired for each selected row when the cursor is opened
  (before the first fetch).
- The lock is only released when the transaction ends.
- FOR UPDATE cursors can only be OPENed inside a transaction.

Genero db locking granularity is at the row level.

To control the behavior of the program when locking rows, INFORMIX
provides a specific instruction to set the wait mode:

   SET LOCK MODE TO { WAIT \| NOT WAIT \| WAIT seconds }

The default mode is NOT WAIT. This is an INFORMIX-specific SQL
statement.

***[Solution:]{.underline}***

Genero db supports SELECT .. FOR UPDATE as in INFORMIX, but the rows are
locked when the cursor is opened, not when the first row is fetched.

Ensure that the use of \'FOR UPDATE\' is always inside a transaction.

Ensure that you COMMIT the transaction as soon as possible to prevent
rows being locked longer than necessary.

------------------------------------------------------------------------

## [ODIADS009a - Transactions handling]{#ODIADS009a}

INFORMIX and Genero db handle transactions in a similar manner: In both
INFORMIX and Genero db, transactions must be started with BEGIN WORK and
finished with COMMIT WORK or ROLLBACK WORK.

Statements executed outside a transaction are automatically committed.

**Warning:** With INFORMIX in native mode (non-ANSI), DDL statements can
be executed (and cancelled) in transactions. Genero db does not support
DDL statements inside transactions.

Informix version 11.50 introduces savepoints with the following
instructions:

        SAVEPOINT name [UNIQUE]
        ROLLBACK [WORK] TO SAVEPOINT [name] ]
        RELEASE SAVEPOINT name

Genero db supports savepoints too. However, there are differences:

1.  Savepoints cannot be declared as UNIQUE
2.  Rollback must always specify the savepoint name
3.  You cannot release savepoints (RELEASE SAVEPOINT)

***[Solution:]{.underline}***

Regarding transaction control instructions, existing applications do not
have to be modified in order to work with Genero db.

**Warning:** You must extract the DDL statements from transaction
blocks.

Transactions in stored procedures: avoid using transactions in stored
procedures and allow the client applications to handle transactions, in
accordance with the transaction model.

**Warning:** If you want to use savepoints, do not use the UNIQUE
keyword in the savepoint declaration, always specify the savepoint name
in ROLLBACK TO SAVEPOINT, and do not drop savepoints with RELEASE
SAVEPOINT.

See also [ODIADS008b](#ODIADS008b)

------------------------------------------------------------------------

## [ODIADS010 - BOOLEAN data type]{#ODIADS010}

INFORMIX supports the BOOLEAN data type, which can store \'t\' or \'f\'
values. Genero BDL implements the BOOLEAN data type in a different way:
As in other programming languages, Genero BOOLEAN stores integer values
1 or 0 (for TRUE or FALSE). The type was designed this way to assign the
result of a Boolean expression to a BOOLEAN variable.

Genero db 3.60 supports a BOOLEAN type which can store the following
values (case-insensitive): TRUE/FALSE or 1/0. You can\'t use the \'t\'
or \'f\' character values as in INFORMIX.

***[Solution:]{.underline}***

The Genero db database interface supports the BOOLEAN data type.

------------------------------------------------------------------------

## [ODIADS011a - CHARACTER data types]{#ODIADS011a}

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

Genero db implements the following character types:

- CHAR(N) with N\<= 60000 bytes, 3000 if the column is indexed
- VARCHAR(N) with N\<= 60000 bytes, 3000 if the column is indexed

String comparison semantics are equivalent in INFORMIX and Genero db:

- Trailing blanks are ignored when comparing CHAR and VARCHAR values.
- Genero db treats empty strings as NOT NULL values.

In Genero db, CHAR and VARCHAR types store data in single byte or in
UTF-8 character sets. For CHAR and VARCHAR, the size is specified in a
number of bytes, like INFORMIX. The character set used to store data for
these types is defined by a database configuration parameter called
CHARACTER_SET, this parameter must be defined before starting the server
for the first time and cannot be changed later on.

Automatic character set conversion between the Genero db client and
server is supported. You must properly specify the client character set
for Genero db, this is done with an ODBC configuration parameter called
*characterset*.

**[*Solution:*]{.underline}**

INFORMIX \[VAR\]CHAR(N) types can be mapped to Genero db \[VAR\]CHAR(N)
types.

Since both databases use Byte Length Semantics, you can use the same
size to define \[VAR\]CHAR columns in both environments.

Do not forget to properly define the client character set, which must
correspond to the runtime system character set (LANG/LC_ALL).

See also the section about [Localization](Localization.html).

------------------------------------------------------------------------

## [ODIADS012 - Constraints]{#ODIADS012}

**Constraint naming syntax:**

Both INFORMIX and Genero db support primary key, unique, foreign key,
default and check constraints, but the constraint naming syntax is
different : Genero db expects the \"CONSTRAINT\" keyword **before** the
constraint specification and INFORMIX expects it **after**.

**UNIQUE constraint example:**

  ----------------------------------- -----------------------------------
  **INFORMIX**                        **Genero db**

  CREATE TABLE scott.emp (\           CREATE TABLE scott.emp (\
  \...\                               \...\
  empcode CHAR(10) UNIQUE\            empcode CHAR(10)\
     **\[CONSTRAINT pk_emp\]**,\         **\[CONSTRAINT pk_emp\]**
  \...                                UNIQUE,\
                                      \...
  ----------------------------------- -----------------------------------

**Primary keys:**

Like INFORMIX, Genero db creates an index to enforce PRIMARY KEY
constraints (some RDBMS do not create indexes for constraints). 

**Unique constraints:**

Like INFORMIX, Genero db creates an index to enforce UNIQUE constraints
(some RDBMS do not create indexes for constraints).

**Warning:** Using CREATE UNIQUE INDEX is silently converted to a unique
constraint. To drop an index created as CREATE UNIQUE INDEX, you must do
an ALTER TABLE DROP CONSTRAINT.

**Warning:** When using a unique constraint, INFORMIX allows only one
row with a NULL value, while Genero db allows several rows with NULL!

**Foreign keys:**

Both INFORMIX and Genero db support the ON DELETE CASCADE option. To
defer constraint checking, INFORMIX provides the SET CONSTRAINT command
while Genero db provides the DISABLE CONSTRAINTS hint.

**Check constraints:**

**Warning:** The check condition may be any valid expression that can be
evaluated to TRUE or FALSE, including functions and literals. You must
verify that the expression is not INFORMIX specific.

**Null constraints:**

INFORMIX and Genero db support not null constraints, but INFORMIX does
not allow you to give a name to \"NOT NULL\" constraints.

***[Solution:]{.underline}***

**Constraint naming syntax:**

The database interface does not convert constraint naming expressions
when creating tables from BDL programs. Review the database creation
scripts to adapt the constraint naming clauses for Genero db.

------------------------------------------------------------------------

## [ODIADS013 - Triggers and Stored Procedures]{#ODIADS013}

Genero db supports the INFORMIX trigger and stored procedure language.

However, Genero db (\<=3.81) does not support user function calls within
queries, for example:

    SELECT getage(patient_bd) FROM patient WHERE patient_id = 12345

See Genero db documentation for more details.

***[Solution:]{.underline}***

Until Genero db supports user function calls inside SQL queries, you
need to extract the stored procedure/function and call it with a
secondary statement handle as described
[here](SqlProgramming.html#SP_GDB).

------------------------------------------------------------------------

## [ODIADS016a - Defining database users]{#ODIADS016a}

INFORMIX users are defined at the operating system level. They must be
members of the \'INFORMIX\' group. The database administrator must grant
CONNECT, RESOURCE or DBA privileges to those users.

Genero db users must be registered in the database. They are created by
the database administrator (SYSTEM) with the following command:

   CREATE USER \<username\> IDENTIFIED BY \<password\>\
\
or for Operating System authentication:

   CREATE USER \<username\> IDENTIFIED EXTERNALLY

**Warning: Additional configuration is required for Operating System
authentication, see database server documentation for more details.**

***[Solution:]{.underline}***

For migration and testing purposes only, you can specify the user name
and password in the FGLPROFILE.

For a live system, it is recommended that you use the CONNECT TO
statement and supply the user name and password, or create database
users IDENTIFIED EXTERNALLY.

Prior to Genero db 3.81, it was necessary to use quotes around user
names:

    CREATE USER harry IDENTIFIED EXTERNALLY [DEFAULT SCHEMA stores];

The quotes was necessary to force lower case, as most Linux/UNIX user
names are by convention in lower case. Since the release of Genero db
3.81, when COMPATIBILTY_MODE = INFORMIX is set in the configuration
file, this is no longer needed, and should NOT be used. Instead, create
the user name WITHOUT quotes:

    CREATE USER harry IDENTIFIED EXTERNALLY [DEFAULT SCHEMA stores];

In this case, Genero db would internally map the lower case name to the
OS user, and would use OS authentication when connecting to the
database.

A few additional changes are required to make OS authentication work:

1.  Change the ants.rhosts file\'s permission to 600. By default, this
    file has greater permission for "groups" and "other", and Genero db
    would refuse to load the file if the permission is something
    like 644. It needs to be 0 for "group" and 0 for "other". This file
    resides in \$ANTSHOME/Server
2.  Edit the file ants.rhosts and comment out the "+". This would allow
    permissions for all user names created as OS users.
3.  Restart Genero db or execute the following SQL statement: ALTER
    SYSTEM REFRESHTRUST;
4.  Remove or comment out the "user" and "password" entries in odbc.ini.
    The default values for these parameters are "SYSTEM" and "SYSTEM"
    respectively.

------------------------------------------------------------------------

## [ODIADS016b - Setting privileges]{#ODIADS016b}

INFORMIX and Genero db user privileges management are similar.

Genero db provides roles to group privileges which then can be assigned
to users. Starting with version 7.20, INFORMIX also provides roles.

INFORMIX users must have at least the CONNECT privilege to access the
database:\
    GRANT CONNECT TO (PUBLIC\|user)

To be able to create tables, views or synonyms, Genero db users need:\
    GRANT CREATE TABLE TO \<user\>\
    GRANT CREATE VIEW TO \<user\>\
    GRANT CREATE SYNONYM TO \<user\>

**Warning:** Genero db does NOT provide the INFORMIX CONNECT, RESOURCE
and DBA roles.

***[Solution:]{.underline}***

In Genero db, roles can be created with database privileges to simulate
INFORMIX system roles.

------------------------------------------------------------------------

## [ODIADS017 - Temporary tables]{#ODIADS017}

INFORMIX supports temporary tables with the following statements:

  SELECT \... INTO TEMP *tmpname* \[WITH NO LOG\]\
  CREATE TEMP TABLE *tmpname* ( \... ) \[WITH NO LOG\]

Genero db supports the same temporary table SQL instructions as
INFORMIX.

However, there are some restrictions with Genero db temporary tables:

1.  Genero db does not support DDL statements inside transaction blocks.
2.  Genero db does not support the WITH NO LOG clause.
3.  Genero db does not support CREATE UNIQUE INDEX on temporary tables.

***[Solution:]{.underline}***

You do not need to modify your code, as long as CREATE TEMP TABLE or
SELECT INTO TEMP statements do not use any of the restrictions listed
above.

------------------------------------------------------------------------

## [ODIADS018 - Substrings in SQL]{#ODIADS018}

INFORMIX SQL statements can use substrings on columns defined with the
character data type:\
    SELECT \... FROM tab1 WHERE col1\[2,3\] = \'RO\'\
    SELECT \... FROM tab1 WHERE col1\[10\]  = \'R\'   \-- Same as
col1\[10,10\]\
    UPDATE tab1 SET col1\[2,3\] = \'RO\' WHERE \...\
    SELECT \... FROM tab1 ORDER BY col1\[1,3\]

Genero db provides the SUBSTRING( ) function, to extract a sub-string
from a string expression:\
    SELECT \.... FROM tab1 WHERE SUBSTRING(col1,2,2) = \'RO\'\
    SELECT **SUBSTRING(\'Some text\' FROM 6 FOR 3)**        \-- Gives
\'tex\'

Genero db 3.60 has implemented the col\[x,y\] expression but not the
col\[x\] one.

***[Solution:]{.underline}***

With Genero db **3.61**:

The Genero db database driver will convert SQL expressions containing
INFORMIX substring syntax for you. It is recommended, however, that you
replace all INFORMIX col\[x,y\] expressions with SUBSTRING(col FROM x
FOR y-x+1).

**Warning:** In UPDATE instructions, setting column values using
subscripts will produce an error with Genero db:\
    UPDATE tab1 SET col1\[2,3\] = \'RO\' WHERE \...\
is converted to:\
    UPDATE tab1 SET SUBSTRING(col1 FROM 2 FOR 3-2+1) = \'RO\' WHERE \...

With Genero db **3.80**:

The server supports all the INFORMIX-style substrings and no conversion
is done by the database driver.

------------------------------------------------------------------------

## [ODIADS019 - Name resolution of SQL objects]{#ODIADS019}

INFORMIX uses the following to identify an SQL object:\
  \[database\[@dbservername\]:\]\[{owner\|\"owner\"}.\]identifier

The ANSI convention is to use double-quotes for identifier delimiters
(For example: \"tabname\".\"colname\").

**Warning:** When using double-quoted identifiers, both INFORMIX and
Genero db become case-sensitive. Unlike INFORMIX, Genero db object names
are stored in UPPERCASE in system catalogs. That means that SELECT
\"col1\" FROM \"tab1\" will produce an error if those objects are
created without double-quotes; they are identified by COL1 and TAB1 in
Genero db system catalogs.

With INFORMIX ANSI-compliant databases:

- The table name must include \"owner\", unless the connected user is
  the owner of the database object.
- The database server shifts the owner name to uppercase letters before
  the statement executes, unless the owner name is enclosed in double
  quotes.

With Genero db, an object name takes the following form:\
   \[(schema\|\"schema\").\](identifier\|\"identifier\")

Object names are limited to 128 chars in Genero db.

A Genero db schema is owned by a user (usually the application
administrator).

***[Solution:]{.underline}***

Check that you do not use single-quoted or double-quoted table names or
column names in your static SQL statements. Those quotes must be removed
because the database interface automatically converts double quotes to
single quotes, and Genero db does not allow single quotes as database
object name delimiters.

See also issue [ODIADS007a](#ODIADS007a)

------------------------------------------------------------------------

## [ODIADS020 - String delimiters and object names]{#ODIADS020}

The ANSI string delimiter character is the single quote ( \'string\').
Double quotes are used to delimit database object names
(\"object-name\").

[Example]{.underline}: WHERE \"tabname\".\"colname\" = \'a string
value\'

INFORMIX allows double quotes as string delimiters, but Genero db
doesn\'t. This is an important distinction, as many BDL programs use
double quotes to delimit the strings in SQL commands.

Remark: This problem concerns only double quotes within dynamic SQL
statements. Double quotes used in pure BDL string expressions are not
subject to SQL compatibility problems. Double-quoted string literals in
static SQL statements are converted to single-quoted strings by
compilers.

Genero db implements ANSI-compliant SQL syntax and therefore does not
support double-quoted string literals; only database object names can be
double-quoted.

***[Solution:]{.underline}***

- With Genero db **3.61** and **3.80**, double quoted strings are
  converted by the Genero db database driver (dbmads3x or dbmads380).
- Starting with Genero db **3.81**, double quoted string literals are
  supported by the server.

------------------------------------------------------------------------

## [ODIADS021 - NUMERIC data types]{#ODIADS021}

INFORMIX supports several data types to store numbers:

::: {align="center"}
  ------------------------ ----------------------------------------------------------
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
  REAL/SMALLFLOAT          Approximate 32-bit floating point real number (C float)
  DOUBLE PREC./FLOAT       Approximate 64-bit floating point real number (C double)
  ------------------------ ----------------------------------------------------------
:::

Genero db supports the following:

::: {align="center"}
  ---------------------------------- ----------------------- ----------------------------------------------------------
  Genero db data type                Pseudotype              Description
  SMALLINT                           TINYINT / BIT           16-bit signed integer
  INT / INTEGER                                              32-bit signed integer
  BIGINT                                                     64-bit signed integer
  INT8                                                       64-bit signed integer
  DECIMAL(p,s)                                               Fixed-point decimal number **(p\<=15 with GDS 3.61)**
  NUMERIC(p,s)                                               Fixed-point decimal number **(p\<=15 with GDS 3.61)**
  MONEY                                                      Number with precision nearly 19 and scale 4
  DOUBLE / DOUBLE PRECISION / REAL   SMALLFLOAT / FLOAT(n)   Approximate 64-bit floating point real number (C double)
  ---------------------------------- ----------------------- ----------------------------------------------------------
:::

**Warnings:**

1.  With Genero db 3.61, the maximum number of digits is **15**, while
    Genero db 3.80 supports up to **36** digits.
2.  The only difference between DECIMAL and NUMERIC is that NUMERIC
    guarantees the specified precision, whereas DECIMAL guarantees at
    least the specified precision.
3.  A pseudotype is accepted anywhere a regular type name is, but is
    silently converted into another type which is supported by Genero
    db.

***[Solution:]{.underline}***

We recommend that you use the following conversion rules:

::: {align="center"}
  -------------------- -------------------------------------------------
  INFORMIX data type   Genero db data type
  SMALLINT             SMALLINT
  INTEGER              INTEGER
  BIGINT               BIGINT
  INT8                 BIGINT
  DECIMAL(p)           **N/A until Genero db 3.90**
  DECIMAL(p,s)         DECIMAL(p,s) **with p \<=15 if Genero db 3.61**
  MONEY(p,s)           DECIMAL(p,s) **with p \<=15 if Genero db 3.61**
  SMALLFLOAT           REAL (64b!)
  FLOAT(n)             FLOAT
  -------------------- -------------------------------------------------
:::

**Warning: Genero db does not have a 32b floating point type, Informix
SMALLFLOAT has to be converted to REAL, which is a 64b floating point
type in Genero db. Later, when extracting the schema of the database,
the original type name used to create the table in Genero db can be used
to distinguish 32b from 64b types in the .sch schema file.**

------------------------------------------------------------------------

## [ODIADS022 - Getting one row with SELECT]{#ODIADS022}

With INFORMIX, you must use the SYSTABLES system table with a condition
on the table id:

> SELECT user FROM systables WHERE tabid=1

With Genero db some statements can be as follows:

> PREPARE pre FROM "SELECT USER" EXECUTE pre INTO l_user

***[Solution:]{.underline}***

Check the BDL sources for \"FROM systables WHERE tabid=1\" and use
dynamic SQL to resolve this problem.

------------------------------------------------------------------------

## [ODIADS024 - MATCHES and LIKE in SQL conditions]{#ODIADS024}

INFORMIX and Genero db both support MATCHES and LIKE in SQL statements.

MATCHES allows you to use brackets to specify a set of matching
characters at a given position:\
   ( col MATCHES \'\[Pp\]aris\' )\
   ( col MATCHES \'\[0-9\]\[a-z\]\*\' )

In this case, the LIKE statement has no equivalent feature.

Genero db implements the MATCHES operator.

***[Solution:]{.underline}***

None required.

See also: [MATCHES operator in SQL
Programming](SqlProgramming.html#PORT_MATCHES).

------------------------------------------------------------------------

## [ODIADS025 - INFORMIX specific SQL statements in BDL]{#ODIADS025}

The BDL compiler supports several INFORMIX-specific SQL statements that
have no meaning when using Genero db:

- CREATE DATABASE
- DROP DATABASE
- START DATABASE (SE only)
- ROLLFORWARD DATABASE
- SET \[BUFFERED\] LOG
- CREATE TABLE with special options (storage, lock mode, etc.)

***[Solution:]{.underline}***

Review your BDL source and remove all static SQL statements which are
INFORMIX-specific SQL statements.

------------------------------------------------------------------------

## [ODIADS028 - INSERT cursors]{#ODIADS028}

INFORMIX supports insert cursors. An \"insert cursor\" is a special BDL
cursor declared with an INSERT statement instead of a SELECT statement.
When this kind of cursor is open, you can use the PUT instruction to add
rows and the FLUSH instruction to insert the records into the database.

For INFORMIX database with transactions, OPEN, PUT and FLUSH
instructions must be executed within a transaction.

Genero db does not support insert cursors.

***[Solution:]{.underline}***

Insert cursors are emulated by the Genero db database driver.

------------------------------------------------------------------------

## [ODIADS030 - Very large data types]{#ODIADS030}

INFORMIX uses the TEXT and BYTE data types to store very large texts or
images.

Genero db 3.6 provides CLOB and BLOB data types, and provides TEXT/BYTE
synonyms for INFORMIX compatibility.

***[Solution:]{.underline}***

The TEXT and BYTE data types are supported by Genero db and by the
Genero db database driver.

**Warning:** Genero TEXT/BYTE program variables have a limit of 2
gigabytes, make sure that the large object data does not exceed this
limit.

------------------------------------------------------------------------

## [ODIADS031 - Cursors WITH HOLD]{#ODIADS031}

INFORMIX closes opened cursors automatically when a transaction ends
unless the WITH HOLD option is used in the DECLARE instruction. 

By default Genero db keeps cursors open when a transaction ends
(however, FOR UPDATE locks are released at the end of a transaction).

***[Solution:]{.underline}***

BDL cursors are automatically closed when a COMMIT WORK or ROLLBACK WORK
is performed.

WITH HOLD cursors with a SELECT FOR UPDATE can be supported, if the
table has a primary key or a unique index.

------------------------------------------------------------------------

## [ODIADS032 - UPDATE/DELETE WHERE CURRENT OF \<cursor\>]{#ODIADS032}

INFORMIX allows positioned UPDATEs and DELETEs with the \"WHERE CURRENT
OF \<cursor\>\" clause, if the cursor has been DECLARED with a SELECT
\... FOR UPDATE statement.

**Warning:** UPDATE/DELETE \... WHERE CURRENT OF \<cursor\> is supported
by the Genero db API. However, the cursor must be OPENed and used inside
a transaction. 

    DECLARE cur1 CURSOR FOR SELECT \* FROM mytable WHERE 1=1 FOR UPDATE\
    BEGIN WORK\
    OPEN cur1\
    FETCH cur1 INTO x,chr\
    UPDATE mytable SET mycol2 = \"updated\" WHERE CURRENT OF cur1\
    CLOSE cur1\
    COMMIT WORK

***[Solution:]{.underline}***

Check that your programs correctly put WHERE CURRENT OF \<cursorname\>
inside a transaction.

------------------------------------------------------------------------

## [ODIADS033 - Querying system catalog tables]{#ODIADS033}

Both INFORMIX and Genero db provides system catalog tables, however the
table names and structure are different.

Genero db provides the standard views for system catalog:
INFORMATION_SCHEMA.TABLES, INFORMATION_SCHEMA.COLUMNS, and so on.

***[Solution:]{.underline}***

**Warning:** No automatic conversion of INFORMIX system tables is
provided by the database interface.

------------------------------------------------------------------------

## [ODIADS034 - Syntax of UPDATE statements]{#ODIADS034}

INFORMIX allows a specific syntax for UPDATE statements:

    UPDATE table SET ( \<col-list\> ) = ( \<val-list\> )

Genero db supports this syntax.

BDL programs can have the following type of statements:

    UPDATE table SET table.\* = myrecord.\*\
    UPDATE table SET \* = myrecord.\*

Static UPDATE statements using the above syntax are converted [by the
compiler]{.underline} to the standard form:\
\
    UPDATE table SET column=value \[,\...\]

**Warning:** With Genero db 3.81, correlated sub-queries cannot be used
for multi-column assignment in an UPDATE statement:\
\
    UPDATE main_table SET (main_col1, main_col2)\
       = ( SELECT sub_col1, sub_col2 FROM sub_table WHERE sub_table.mkey
= main_table.key )

***[Solution:]{.underline}***

Regular UPDATE statements without sub-queries do not need to be
modified. However, you should check your code for UPDATE statements with
sub-selects using multiple columns: Such statements need to be splitted
to use only one column at the time.

Replace:

    UPDATE main_table SET (**main_col1**, **main_col2**)\
       = ( SELECT **sub_col1**, **sub_col2** FROM sub_table WHERE
sub_table.mkey = main_table.key )

By:

    UPDATE main_table SET (**main_col1**)\
       = ( SELECT **sub_col1** FROM sub_table WHERE sub_table.mkey =
main_table.key )\
    UPDATE main_table SET (**main_col2**)\
       = ( SELECT **sub_col2** FROM sub_table WHERE sub_table.mkey =
main_table.key )

------------------------------------------------------------------------

## [ODIADS046 - The LOAD and UNLOAD instructions]{#ODIADS046}

INFORMIX provides SQL instructions to export data from a database table
and import data into a database table: The UNLOAD instruction copies
rows from a database table into a text file; the LOAD instructions
insert rows from a text file into a database table.

Genero db does not provide LOAD and UNLOAD instructions.

Genero db provides an Import/Export Utility (impexp) that will convert a
specified set of tables, or an entire database, to or from a Comma
Separated Value (CSV) external format.

***[Solution:]{.underline}***

In 4gl programs, the LOAD and UNLOAD instructions are supported with
Genero db, with some limitations:

**Warning:** When using Genero db versions before **3.80**, there is a
difference when you use Genero db DATETIME columns. DATETIME columns
created in Genero db are equivalent to INFORMIX DATETIME YEAR TO SECOND
columns.  In LOAD and UNLOAD, all Genero db DATE columns are treated as
INFORMIX DATETIME YEAR TO SECOND columns and thus will be unloaded with
the \"YYYY-MM-DD hh:mm:ss\"  format.

------------------------------------------------------------------------

## [ODIADS047 - The USER constant]{#ODIADS047}

Both INFORMIX and Genero db provide the USER constant, which identifies
the current user connected to the database server. However, there is a
difference:

- INFORMIX returns the user identifier as defined in the operating
  system, where it can be case-sensitive (UNIX) or not (NT).
- Genero db returns the user identifier that is stored in the database.
  By default, Genero db converts the user name to uppercase letters if
  you do not put the user name in double quotes when creating it.

This is important if your application stores user names in database
records (for example, to audit data modifications). You can, for
example, connect to Genero db with the name \'scott\', and perform the
following SQL operations:\
     (1) INSERT INTO mytab ( creator, comment )\
              VALUES ( USER, \'example\' );\
      (2) SELECT \* FROM mytab\
               WHERE creator = \'scott\';\
The first command inserts \'SCOTT\' (in uppercase letters) in the author
column. The second statement will not find the row.

***[Solution:]{.underline}***

When creating a user in Genero db, you can put double quotes around the
user name in order to force Genero db to store the given user identifier
as is:

> CREATE USER \"scott\" IDENTIFIED BY \<pswd\>

To verify the user names defined in Genero db, connect as SYSTEM and
list the records of the ALL_USERS table as follows:

> CREATE USER john IDENTIFIED BY \<pswd\>
>
> SELECT user_name FROM table_of_users
>
> USER_NAME\
> \-\-\-\-\-\-\-\-\-\--\
> SYSTEM\
> JOHN\
> scott

 

------------------------------------------------------------------------

## [ODIADS051 - Setup database statistics]{#ODIADS051}

INFORMIX provides a special instruction to compute database statistics
in order to help the optimizer determine the best query execution plan:

> UPDATE STATISTICS \...

Genero db provides the following instruction to collect statistics:

> SET GATHERSTATS *tablename*

***[Solution:]{.underline}***

Replace the UPDATE STATISTICS by multiple SET GATHERSTATS statements
(one for each table)

------------------------------------------------------------------------

## [ODIADS053 - The ALTER TABLE instruction]{#ODIADS053}

INFORMIX and Genero db have different implementations of the ALTER TABLE
instruction. For example, INFORMIX allows you to use multiple ADD
clauses separated by commas; this is not supported by Genero db.

INFORMIX:\
     ALTER TABLE customer ADD(col1 INTEGER), ADD(col2 CHAR(20))

Genero db:\
     ALTER TABLE customer ADD COLUMN col1 INTEGER ADD COLUMN col2
CHAR(20)

***[Solution:]{.underline}***

**Warning:** No automatic conversion is done by the database interface.
There is no real standard for this instruction ( that is, no common
syntax for all database servers). Read the SQL documentation and review
the SQL scripts or the BDL programs in order to use the database
server-specific syntax for ALTER TABLE.

------------------------------------------------------------------------

## [ODIADS054 - SQL Interruption]{#ODIADS054}

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

Genero db 3.80 supports SQL Interruption in a similar way as INFORMIX.
The db client must issue an SQLCancel() ODBC call to interrupt a query.

***[Solution:]{.underline}***

The Genero db database driver supports SQL interruption and converts the
native SQL error code -30005 to the INFORMIX error code -213.

**Warning:** Make sure you have Genero db 3.80 or higher installed.
Older versions do not support SQL interruption.

Note that when writing these lines, Genero db 3.80 does not support
interruption of a DDL statement or an SQL statement waiting for a lock
to be released (such as SELECT FOR UPDATE). Those limitations should be
removed in a later Genero db version.

------------------------------------------------------------------------

## [ODIADS055 - Scrollable Cursors]{#ODIADS055}

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

Genero db 3.80 does not support native scrollable cursors.

***[Solution:]{.underline}***

The Genero db database driver emulates scrollable cursors with temporary
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

## [ODIADS100 - Data type conversion table]{#ODIADS100}

::: {align="center"}
  --------------------------------------- ------------------------------------ ------------------------------------------
  INFORMIX Data Types                     Genero db Data Types (before 3.80)   Genero db Data Types (since 3.80)
  BIGINT                                  BIGINT                               BIGINT
  BIGSERIAL\[(start)\]                    BIGSERIAL\[(start)\]                 BIGSERIAL\[(start)\]
  BLOB                                    BLOB                                 BLOB
  BOOLEAN                                 BOOLEAN                              BOOLEAN
  BYTE                                    BYTE (= BLOB) (using \<= 2Gb!)       BYTE (= BLOB) (using \<= 2Gb!)
  CHAR(n)                                 CHAR(n)                              CHAR(n) 
  CHARACTER VARYING(n,m)                  VARCHAR(n,m) (= VARCHAR (n))         VARCHAR(n,m) (= VARCHAR (n))
  CHARACTER(n)                            CHARACTER(n) (= CHAR (n))            CHARACTER(n) (= CHAR (n))
  CLOB                                    CLOB                                 CLOB
  DATE                                    DATE                                 DATE
  DATETIME HOUR TO SECOND                 **TIME**                             DATETIME HOUR TO SECOND
  DATETIME x TO y (not HOUR TO  SECOND)   **TIMESTAMP**                        DATETIME x TO y
  DEC                                     DECIMAL                              DECIMAL
  DECIMAL(p)                              **N/A until Genero db 3.90**         **N/A until Genero db 3.90**
  DECIMAL(p,s)                            DECIMAL(p,s)**! p\<=15**             DECIMAL(p,s) **(p\<=32, FGL/IFX limit)**
  DOUBLE                                  DOUBLE                               DOUBLE
  DOUBLE PRECISION                        DOUBLE PRECISION (= DOUBLE)          DOUBLE PRECISION (= DOUBLE)
  FLOAT(n)                                FLOAT(n) (= DOUBLE)                  FLOAT(n) (= DOUBLE)
  INT                                     INT                                  INT
  INT8                                    INT8 (= BIGINT)                      INT8 (= BIGINT)
  INTEGER                                 INTEGER                              INTEGER
  INTERVAL x TO y                         **CHAR(50)**                         INTERVAL x TO y
  MONEY(p,s)                              **DECIMAL(p,s)! p\<=15**             DECIMAL(p,s) **(p\<=32, FGL/IFX limit)**
  NCHAR(n)                                NCHAR(n)                             NCHAR(n) 
  NUMERIC(p,s)                            NUMERIC(p,s)                         NUMERIC(p,s) 
  NVARCHAR(n)                             NVARCHAR(n)                          NVARCHAR(n) 
  REAL                                    REAL (= DOUBLE)                      REAL (= DOUBLE)
  SERIAL\[(start)\]                       SERIAL\[(start)\]                    SERIAL\[(start)\]
  SERIAL8\[(start)\]                      SERIAL8\[(start)\]                   SERIAL8\[(start)\]
  SMALLFLOAT                              SMALLFLOAT (64b in Genero db!)       SMALLFLOAT (64b in Genero db!)
  SMALLINT                                SMALLINT                             SMALLINT
  TEXT                                    TEXT (= CLOB) (using \<= 2Gb!)       TEXT (= CLOB) (using \<= 2Gb!)
  VARCHAR(n,m)                            VARCHAR(n,m) (= VARCHAR(n))          VARCHAR(n,m) (= VARCHAR(n))
  VARCHAR(n)                              VARCHAR(n)                           VARCHAR(n) 
  --------------------------------------- ------------------------------------ ------------------------------------------
:::

------------------------------------------------------------------------

## [ODIADS101 - Genero db Sql Error management]{#ODIADS101}

For a general idea on how Genero handles SqlErrors in the BDL language,
check the following links:

[Error Handling](Connections.html#ERRORINFO)\
[SQL Errors](Exceptions.html#SQLERRORS)\
[STATUS](Programs.html#PV_STATUS)\
[SQLSTATE](Operators.html#OP_SQLSTATE)\
[SQLERRMESSAGE](Operators.html#OP_SQLERRMESSAGE)\
[SQLCA Record](Connections.html#SQLCA_RECORD)\
[Portability: SQLCA](SqlProgramming.html#PORT_SQLCA)

[*Genero db*]{.underline} [*has some specific rules that need to be
highlighted:*]{.underline}

1.  To handle SQL errors, you can use the
    [SQLCA.SQLCODE](Connections.html#SQLCA_RECORD) register, which gives
    the INFORMIX error code converted from the native Genero db error.
    Additional SQL error information can be checked with following
    registers:

> - The native Genero db error code is stored in **SQLCA.SQLERRD\[2\]**
>   register
> - The native Genero db error message is stored in
>   **[SQLERRMESSAGE](Operators.html#OP_SQLERRMESSAGE)** operator
>
> Next table shows the native Genero db errors and the corresponding
> Informix SQL error returned in SQLCA.SQLCODE:

::: {align="center"}
  ----------------------- ----------------------- -----------------------
  Genero db\              INFORMIX\               Error description\
  SQLCA.SQLERRD\[2\]      SQLCA.SQLCODE           (SQLERRMESSAGE)

  -1                      -201                    syntax error 

  -3                      -206                    table not found 

  -4                      -201                    syntax error 

  -6                      -217                    column not found 

  -17                     -743                    object exists 

  -24                     -201                    syntax error 

  -35                     -236                    cols/vals mismatch 

  -10014                  -213                    SQL interrupted 

  -30004                  -263                    *Cannot wait on another
                                                  session.*

  -30005                  -213                    SQL interrupted 

  -60001                  -268                    *Uniqueness constraint
                                                  violation.*

  -80002                  -387                    no connect permission 
  ----------------------- ----------------------- -----------------------
:::

2.  Many different formerly INFORMIX errors can be returned by the
    Genero db database driver; For example, fetch on open cursor, commit
    on unopened transaction, \...\
    Here is the list of known errors the Genero db database driver can
    return:

::: {align="center"}
  ----------------------- ----------------------- -----------------------
  SQLCA.SQLERRD\[2\]      SQLERRMESSAGE           Reason

  -213                    Query canceled          Long running query
                                                  interrupted by user

  -254                    Too many or too few     PREPARE s FROM \"insert
                          host variables given.   into t values (?,?)\"\
                                                  EXECUTE s USING x,y,z
                                                  (z en trop)

  -255                    Not in transaction.     OPEN insert cursor
                                                  without BEGIN WORK

  -284                    A subquery has not      SELECT \* INTO \...
                          returned exactly one    FROM tab, returns more
                          row.                    than one row

  -400                    Fetch attempted on      FETCH on cursor not
                          unopened cursor.        opened

  -404                    The cursor or statement OPEN cursor after a
                          is not available.       FREE

  -410                    Prepare statement       EXECUTE a statement
                          failed or was not       where PREPARE has
                          executed.               failed

  -413                    Insert attempted on     PUT on insert cursor
                          unopened cursor.        not opened

  -481                    Invalid statement name  EXECUTE a statement
                          or statement was not    without PREPARE
                          prepared.               

  -482                    Invalid operation on a  FETCH LAST/PREV/\... on
                          non-SCROLL cursor.      non SCROLL cursor

  -526                    Updates are not allowed SELECT FOR UPDATE with
                          on a scroll cursor.     SCROLL cursor

  -535                    Already in transaction. BEGIN WORK x2

  -6370                   Unsupported SQL         CREATE DATABASE, SET
                          feature.                CONNECTION DORMANT,
                                                  CREATE PROCEDURE FROM,
                                                  DATABASE IN EXCLUSIVE
                                                  MODE, CONNECT TO
                                                  \@server, \...
  ----------------------- ----------------------- -----------------------
:::

1.  If an unknown error comes from the DB Server and therefore is not
    mapped as an INFORMIX error, you\'ll get:

> **-6372 General SQL error, check SQLCA.SQLERRD\[2\]**
>
> When this SQL error occurs, you can check the native SQL error in the
> SQLCA.SQLERRD\[2\] register.

1.  If an unexpected problem happens within the database driver, the
    driver will return:

> **-6319 Internal error in the database library. Set FGLSQLDEBUG to get
> more details**
>
> When this SQL error occurs, you should set the FGLSQLDEBUG environment
> variable to get more details about the internal error.

[Error handling example:]{.underline}

    MAIN
     WHENEVER ERROR CONTINUE
     CONNECT TO dsn_connectstring
     IF STATUS <> 0 THEN
        DISPLAY "ERROR: Connection to the database failed."
        DISPLAY SQLCA.SQLCODE, ": ",
                SQLCA.SQLERRD[2], "-", 
                SQLERRMESSAGE
        EXIT PROGRAM 1
     END IF 

     WHENEVER ERROR STOP 

    END MAIN
