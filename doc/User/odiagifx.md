[Back to Contents](../index.html)

------------------------------------------------------------------------

# ODI Guide For IBM Informix database servers 5.x, 7.x, 8.x, 9.x, 10.x, 11.x

Introduction

::: {align="center"}
  ------------------------------------------------------
  [Purpose of the Informix ODI guide](#ODIIFX_INTRO_1)
  ------------------------------------------------------
:::

Installation

::: {align="center"}
  -------------------------------------------------------------------
  [Supported IBM Informix server and CSDK versions](#ODIIFX_PREP00)
  [Install IBM Informix and create a database](#ODIIFX_PREP01)
  [Prepare the runtime environment](#ODIIFX_PREP02)
  -------------------------------------------------------------------
:::

Fully supported IBM Informix SQL features

::: {align="center"}
  ------------------------------------------------------------------
  [What are the supported IBM Informix SQL features?](#ODIIFX0000)
  ------------------------------------------------------------------
:::

Partially supported IBM Informix SQL features

::: {align="center"}
  ----------------------------------------------
  [The LVARCHAR data type](#ODIIFX0001)
  [DISTINCT data types](#ODIIFX0002)
  [Transaction savepoints](#ODIIFX0003)
  [Stored Procedures](#ODIIFX0004)
  [Database Triggers](#ODIIFX0005)
  [Optimizer directives](#ODIIFX0006)
  [XML publishing support](#ODIIFX0007)
  [DataBlade modules](#ODIIFX0008)
  [Specific CREATE INDEX clauses](#ODIIFX0009)
  [Other SQL instructions](#ODIIFX0090)
  ----------------------------------------------
:::

Un-supported IBM Informix SQL features

::: {align="center"}
  ------------------------------------------
  [CLOB and BLOB data types](#ODIIFX0101)
  [The LIST data type](#ODIIFX0103)
  [The MULTISET data type](#ODIIFX0104)
  [The SET data type](#ODIIFX0105)
  [The ROW data types](#ODIIFX0106)
  [OPAQUE data types](#ODIIFX0107)
  [The :: cast operator](#ODIIFX0108)
  [Projection clause options](#ODIIFX0109)
  [Table inheritance](#ODIIFX0110)
  [CASE expressions](#ODIIFX0111)
  [IF NOT EXISTS clause](#ODIIFX0112)
  ------------------------------------------
:::

------------------------------------------------------------------------

## [Purpose of the Informix ODI guide]{#ODIIFX_INTRO_1}

This section contains information to configure your Genero runtime
system to work with an Informix database engine, and describes the IBM
Informix SQL features that are not supported (or partially supported) by
Genero BDL.

Understand that Genero BDL was designed to work with IBM Informix
databases, so most of the IBM Informix SQL features are supported.
However, new features implemented in recent server versions need
modifications in the Genero BDL compilers and runtime system to be
supported.

Some topics show an [enhancement reference](DocConv.html#ENH_REF) note
with a number, identifying the request id as filed in our internal
\"TODO\" database. If the SQL feature is mission critical for your
application, contact the support center and mention the enhancement
identifier. 

------------------------------------------------------------------------

## [Runtime configuration]{#ODIIFX_PREP}

> #### [Supported IBM Informix server and CSDK versions]{#ODIIFX_PREP00}
>
> 1.  Genero BDL is certified with all IBM Informix servers from version
>     **5.x** to the latest **11.x** version, including the Standard
>     Engine, On-Line and IDS server families, as long as the IBM
>     Informix Client SDK is compatible with the server.
>
> 2.  Genero BDL is certified with IBM Informix SDK version **3.50** or
>     higher.
>
> ### [[Install IBM Informix and create a database]{.small}]{#ODIIFX_PREP01}
>
> 1.  Install the IBM Informix database software (IDS for example) on
>     your database server.
>
> 2.  Install the IBM Informix Software Development Kit (SDK)  on your
>     application server.\
>     With some IBM Informix distributions (IDS 11), this package is
>     included in the server bundle.\
>     You should check the IBM web site for SDK upgrades or patches.\
>     Genero BDL is certified with IBM Informix SDK version **3.50** or
>     higher.
>
> 3.  Define a database user dedicated to your application: the
>     **application administrator**, referenced as *appadmin* in the
>     next parts of this documentation. This user will manage the
>     database schema of the application (all tables will be owned by
>     it). With IBM Informix, database users reference Operating System
>     users, and must be part of the IBM Informix group. See IBM
>     Informix documentation.
>
> 4.  Connect to the server as *IBM Informix* user (for example with the
>     dbaccess tool) and give all requested database administrator
>     privileges to the **application administrator**.\
>     \
>        GRANT CONNECT TO *appadmin* ;\
>        GRANT RESOURCE TO *appadmin* ;\
>        GRANT DBA TO *appadmin* ;
>
> 5.  Connect as application administrator and create an IBM Informix
>     database entity, for example with the following SQL statement:\
>     \
>      CREATE DATABASE *dbname* WITH BUFFERED LOG;
>
> 6.  Create the **application tables**.

> ### [Prepare the runtime environment]{#ODIIFX_PREP02}
>
> 1.  In order to connect to IBM Informix, you must have a database
>     driver \"**dbmifx\***\" in FGLDIR/dbdrivers.
>
> 2.  Make sure the the IBM Informix client environment variables are
>     properly set. Check for example **INFORMIXDIR** (the path to the
>     installation directory), **INFORMIXSERVER** (the name of the
>     server defined in the sqlhosts list), etc. For more details, see
>     the IBM Informix documentation.
>
> 3.  In order to connect to an IBM Informix server, you must define a
>     line in the \$INFORMIXDIR/etc/sqlhosts file, referencing the
>     server name specified in the **INFORMIXSERVER** environment
>     variable. On Windows platforms, the sqlhost entries are defined in
>     the registry database. See IBM Informix documentation.
>
> 4.  Verify the environment variable defining the search path for IBM
>     Informix SDK database client shared libraries. On UNIX platforms,
>     the variable is specific to the operating system. For example, on
>     Solaris and Linux systems, it is **LD_LIBRARY_PATH**, on AIX it is
>     **LIBPATH**, or HP/UX it is **SHLIB_PATH**. On Windows, you define
>     the DLL search path in the **PATH** environment variable.
>
>     +-----------------------------------+-----------------------------------+
>     | **IBM Informix SDK version**      | **Shared library environment      |
>     |                                   | setting**                         |
>     +-----------------------------------+-----------------------------------+
>     | **All versions**                  | *UNIX*: Add **\$INFORMIXDIR/lib,  |
>     |                                   | \$INFORMIXDIR/lib/esql,           |
>     |                                   | \$INFORMIXDIR/lib/tools and       |
>     |                                   | \$INFORMIXDIR/lib/cli** to        |
>     |                                   | LD_LIBRARY_PATH (or its           |
>     |                                   | equivalent).\                     |
>     |                                   | *Windows*: Add                    |
>     |                                   | **%INFORMIXDIR%\\bin** to PATH.   |
>     +-----------------------------------+-----------------------------------+
>     |                                   |                                   |
>     +-----------------------------------+-----------------------------------+
>
> 5.  Check the database locale settings (**CLIENT_LOCALE**,
>     **DB_LOCALE**, etc). The DB locale must match the locale used by
>     the runtime system (**LANG**).
>
> 6.  To verify if the IBM Informix client environment is correct, you
>     can start the SQL command interpreter:\
>     \
>          \$ dbaccess - -\
>          \> CONNECT TO \"*dbname*\" USER \"*appadmin*\";\
>            ENTER PASSWORD: *password*
>
> 7.  Set up the **fglprofile** entries for [database
>     connections](Connections.html#DS_ODI_DBVSPEC).\
>     \
>     **Warning:** **Make sure that you are using the ODI driver
>     corresponding to the database client and server version.**

------------------------------------------------------------------------

## [ODIIFX0000: What are the supported IBM Informix SQL features?]{#ODIIFX0000}

Genero BDL was first designed for IBM Informix databases. The answer to
the above question is: Every SQL feature that is not listed in the other
sections of this chapter.

The following list gives an idea of the IBM Informix SQL elements you
can use with Genero BDL:

- Database connection control instructions (DATABASE, CONNECT). See
  [Connections](Connections.html).
- Transaction control instructions and concurrency settings (BEGIN WORK,
  SET ISOLATION). See [Transactions](Transactions.html).
- Basic, portable data types (lNT, BIGINT, DECIMAL, CHAR, VARCHAR, DATE,
  DATETIME, TEXT, BYTE, etc). See [Data Types](DataTypes.html).
- Common Data Definition Language statements (CREATE TABLE, DROP TABLE,
  etc). See [Static SQL](StaticSql.html).
- Common Data Manipulation Language statements (SELECT, INSERT, UPDATE,
  DELETE, etc). See [Static SQL](StaticSql.html).
- Result set handling with cursors (DECLARE / OPEN / FETCH / CLOSE /
  FREE). See [Result Sets](ResultSets.html).
- Positioned UPDATEs and DELETEs (UPDATE/DELETE WHERE CURRENT OF). See
  [Positioned Updates](PositionedUpdates.html).
- Cursors to insert rows (DECLARE / OPEN / PUT / FLUSH). See [Insert
  Cursors](InsertCursors.html).
- Stored procedure calls. See [SQL
  Programming](SqlProgramming.html#PROG_STOPROC).
- SQL execution status and error messages (SQLCA, SQLSTATE). See
  [Connections](Connections.html).
- Global Language Support with single and multi-byte character sets for
  CHAR/ VARCHAR data storage. See [Localization](Localization.html).
- LOAD and UNLOAD utility statements. See [I/O SQL
  instructions](InOutSql.html).
- Database schema extraction to define program variables LIKE database
  columns. See [Database Schema](DatabaseSchema.html).

------------------------------------------------------------------------

## [ODIIFX0001: The LVARCHAR data type]{#ODIIFX0001}

IBM Informix provides the LVARCHAR type as a \"large\" VARCHAR type. The
LVARCHAR type was introduced to bypass the 255 bytes size limitation of
the standard VARCHAR type. Starting with IDS version 9.4, the LVARCHAR
size limit is 32739 bytes. In older versions the limit was 2 kilobytes
(2048 bytes).

Genero BDL does not support the LVARCHAR type natively, but it has the
VARCHAR type which can hold up to 65535 bytes. IBM Informix LVARCHAR
values can be inserted or fetched by using the BDL VARCHAR type.

The fglcomp compiler will report a syntax error if you use the LVARCHAR
type in static SQL statements, for example if CREATE TABLE defines an
LVARCHAR column.

When extracting a schema with [fgldbsch](Tools.html#TL_FGLDBSCH), you
will by default get an invalid data type error if a table is defined
with an LVARCHAR column. This is done to alert you to table columns with
this special type. You can bypass the error by using a conversion rule,
with the -cv option of the fgldbsch schema extractor. When using the -cv
conversion option with an argument containing the letter B at the fourth
position, LVARCHAR columns will be mapped to the VARCHAR2 type in the
schema file (VARCHAR2 is a Genero BDL-only type identified with the
[type code 201](DatabaseSchema.html#TYPE_CODES)), and lets you define
VARCHAR variables with a size that can be greater than 255 bytes.

------------------------------------------------------------------------

## [ODIIFX0002: DISTINCT data types]{#ODIIFX0002}

IBM Informix supports DISTINCT data types as User Defined Types based on
a source data type, but with different casts and functions than those on
the source data type.

Genero BDL partially supports the IBM Informix DISTINCT data types:

The [fgldbsch](Tools.html#TL_FGLDBSCH) schema extractor can extract
columns defined with a distinct type and write the distinct type code in
the .sch schema file. For more details, see [Distinct type
codes](DatabaseSchema.html#IFX_DISTINCT_TYPES) in the Database Schema
page. 

However, there are some restrictions you must be aware of:

- It is not possible to define BDL variables explicitly with the name of
  a distinct type. Variables must be defined indirectly with the schema
  by using the DEFINE LIKE statement. 
- The static SQL syntax does not support OPAQUE-related syntax elements:
  - The DDL statements CREATE DISTINCT TYPE, DROP TYPE, CREATE CAST, and
    DROP CAST are not allowed,
  - In CREATE TABLE / ALTER TABLE DDL statements, the data type must be
    a built-in type.
  - The :: cast operator is not supported.

------------------------------------------------------------------------

## [ODIIFX0003: Transaction savepoints]{#ODIIFX0003}

Starting with IBM Informix IDS version 11.50, it is possible to define
savepoints in transaction blocks, to rollback a sub-set of SQL
instructions executed by the transaction:

    BEGIN WORK
    ...
    SAVEPOINT sp1    <-------------+
    ...                            | 
    ROLLBACK TO SAVEPOINT sp1   ---+
    ...
    SAVEPOINT sp2
    ...
    RELEASE SAVEPOINT sp2
    ...
    SAVEPOINT sp3 UNIQUE
    ...
    COMMIT WORK

Genero BDL partially supports transaction savepoints:

- The SAVEPOINT *identifier*, RELEASE SAVEPOINT *identifier*, and
  ROLLBACK WORK TO *identifier* instructions are not part of the static
  SQL syntax of Genero BDL.
- The non-IBM Informix database drivers are not ready to handle
  savepoint instructions.
- With IBM Informix, you can however execute savepoint instructions with
  dynamic SQL (EXECUTE IMMEDIATE).

Note that at the time of this writing, the latest version of IBM
Informix I4GL 7.50 doesn\'t support savepoint instructions as part of
the language. The Genero BDL team would like to implement these
instructions like I4GL, once this is available; we prefer to wait for
the I4GL solution to be sure that we do not take a different path than
the IBM Informix 4gl reference product.

*Enhancement reference: 11849*

------------------------------------------------------------------------

## [ODIIFX0004: Stored Procedures]{#ODIIFX0004}

With IBM Informix database servers, you can write stored procedures with
the SPL (Stored Procedure Language) or with an external language in C or
JAVA.

Note that if you plan to support different types of database servers,
you must be aware that each DB vendor has defined its own stored
procedure language. In such cases, you may consider writing most of your
business logic in BDL, and implementing only some stored procedures in
the database, mainly to get better performance or to use database
features that only exist with stored procedures.

Genero BDL partially supports SP creation, but has full support of SP
invocation:

- The Genero BDL static SQL syntax does not include CREATE FUNCTION and
  CREATE PROCEDURE with a body block. However, you can create stored
  procedures with an body block by using dynamic SQL (EXECUTE
  IMMEDIATE), or with CREATE PROCEDURE and the FROM *filename* clause,
  which is supported by Genero BDL static SQL.
- The EXECUTE FUNCTION or EXECUTE PROCEDURE instruction is not allowed
  in the static SQL syntax. To invoke a stored procedure with Informix,
  you must use the PREPARE instruction, followed by EXECUTE or OPEN. The
  PREPARE instruction must initiate the EXECUTE FUNCTION/PROCEDURE
  instruction. 

For more details about stored procedure invocation, see [SQL
Programming](SqlProgramming.html#PROG_STOPROC).

------------------------------------------------------------------------

## [ODIIFX0005: Database Triggers]{#ODIIFX0005}

Triggers can be created for IBM Informix database tables with the CREATE
TRIGGER instruction.

Note that if you plan to support different types of database servers,
you must be aware that each DB vendor has defined its own trigger
creation syntax and stored procedure language. In such cases, you may
consider writing most your business logic in BDL, and implementing only
some triggers in the database, mainly to get better performance or use
database features that only exist with stored procedures.

Genero BDL partially supports trigger creation:

- The Genero BDL static SQL syntax does not include the CREATE TRIGGER
  and DROP TRIGGER instructions. However, you can create database
  triggers by using dynamic SQL (EXECUTE IMMEDIATE).

------------------------------------------------------------------------

## [ODIIFX0006: Optimizer directives]{#ODIIFX0006}

IBM Informix SQL allows you to specify query optimization directives to
force the query optimizer to use a different path than the implicit
plan. With IBM Informix, optimizer directives are specified with the
following SQL comment markers followed by a plus sign:

    /*+ optimizer-directives */
    {+  optimizer-directives }
    --+ optimizer-directives

Genero BDL partially supports optimizer directives:

- The static SQL syntax does not allow the C-style optimizer syntax.
- The curly-brace and dash-dash optimizer directive syntaxes cannot be
  used in static SQL statements, because these correspond to the [4GL
  language comments](LanguageFeatures.html#LF_COMMENTS).
- However, you can execute queries with optimization directives with
  [Dynamic SQL](DynamicSql.html).

Note that optimization directives are not portable. If you plan to use
different types of database servers, you should avoid the usage of query
plan hints.

------------------------------------------------------------------------

## [ODIIFX0007: XML publishing support]{#ODIIFX0007}

IBM Informix IDS 11.10 introduced a set of XML built-in functions when
the **idsxmlvp** virtual processor is turned on. Built-in XML functions
are of two types: Those returning LVARCHAR values, and those returning
CLOB values. For example, *genxml()* returns an LVARCHAR(32739), while
*genxmlclob()* returns a CLOB. XML data is typically stored in LVARCHAR
or CLOB columns.

Genero BDL partially supports XML functions:

- Because Genero BDL does not support [BLOB/CLOB](#ODIIFX0101) types,
  functions returning CLOB values cannot be used. You can however use
  the XML functions returning LVARCHAR values, and fetch the result into
  a [VARCHAR](DataTypes.html#DT_VARCHAR) variable of the appropriate
  size.
- Some of the XML functions such as genxml() take ROW() values as
  parameters. Because literal unnamed ROW() expressions are like regular
  function calls, you can use XML functions in static SQL statements.

Example:

``` linenumber
01 FUNCTION get_cust_data(id)
02   DEFINE id INT, v VARCHAR(5000)
03   SELECT genxml(ROW(cust_name, cust_address), "custdata") INTO v
04      FROM customers WHERE cust_id = id
05   RETURN v
06 END FUNCTION
```

------------------------------------------------------------------------

## [ODIIFX0008: DataBlade modules]{#ODIIFX0008}

IBM Informix IDS provides several database extensions implemented with
the DataBlade Application Programming Interface, such as MQ Messaging,
Large OBjects management, Text Search DataBlades, Spatial DataBlade
Module, etc.

Genero BDL partially supports DataBlade modules:

- DataBlade extensions are based on User Defined Functions and User
  Defined Types. It is not possible to define program variables with
  specific User Defined Types. For example, you cannot define a program
  variable with the ST_Point type implemented by the Spatial DataBlade
  module.
- The static SQL grammar does not support DataBlade specific syntax. For
  example, it is not possible to create a Basic Text Search index with
  the USING bts clause of the CREATE INDEX statement.

However, as long as the syntax of the DataBlade functions follows basic
SQL expressions, it can be used in static SQL statements. For example,
the next query uses the bts_contains() function of the Basic Text Search
extension:

    SELECT id FROM products WHERE bts_contains( brands, 'standard' )

You can also use [Dynamic SQL](DynamicSql.html) to perform queries with
a syntax that is not allowed in the static SQL grammar.

------------------------------------------------------------------------

## [ODIIFX0009: Specific CREATE INDEX clauses]{#ODIIFX0009}

Additionally to the standard index-key specification using a column
list, the CREATE INDEX statement supported by IBM Informix SQL allows
specific clauses for example to define for storage options.

Genero BDL partially supports the CREATE INDEX statement:

- The following are not supported in static SQL grammar:
  - The IF NOT EXISTS clause.
  - Functional index specification is now allowed in the index-key list.
  - Storage options such as IN *dbspace*, EXTEND SIZE, NEXT SIZE.
  - The index mode clauses such as FILTERING WITH/WITHOUT ERROR.
  - The USING clause.
  - The HASH ON clause.
  - The FILLFACTOR clause.

You can use [Dynamic SQL](DynamicSql.html) to execute CREATE INDEX
statements with clauses that are not allowed in the static SQL grammar.

------------------------------------------------------------------------

## [ODIIFX0090: Other SQL instructions]{#ODIIFX0090}

Genero BDL static SQL syntax implements common Data Manipulation
Statements such as SELECT, INSERT, UPDATE and DELETE. Data Definition
Language statements such as CREATE TABLE, CREATE INDEX, CREATE SEQUENCE
and their corresponding ALTER and DROP statements are also part of the
static SQL grammar. These are supported with a syntax limited to the
standard SQL clauses. For example, Genero BDL might not support the most
recent CREATE TABLE storage options supported by IBM Informix SQL.

Since first days of the 4GL language, the SQL language has been extended
and has become so large that it\'s not possible to embed all the
existing new statements without introducing grammar conflicts with the
4GL language. Additionally, each DB vendor has improved the standard SQL
language with proprietary SQL statements that are not portable, and it
would not be a good idea to use these specific instructions if you plan
to make your application run with different types of database engines.

However, the Genero BDL static SQL is constantly improved with standard
SQL syntax that works with most types of database servers. For example,
Genero BDL supports the ANSI outer join syntax, constraints definition
in DDL statements, sequence instructions, BIGINT and BOOLEAN data types,
and there is more to come.

If a statement is unsupported in static SQL, that does not mean that you
cannot execute it. If you want to execute an SQL instruction that is not
part of the static SQL grammar, you can use [Dynamic
SQL](DynamicSql.html) with PREPARE + EXECUTE for statements that do not
generated a result set, or with (PREPARE/) DECLARE + OPEN for statements
returning a result set, or with EXECUTE IMMEDIATE if no SQL parameters
are required and no result set is generated. The Dynamic SQL
instructions take a string as the input, so there is no limitation
regarding the SQL text you can execute, except that only one statement
can be executed at a time. It is better, however, to write your SQL
statements directly in static SQL when possible, because it makes the
code more readable and the syntax is checked at compiled time.

For more details about statements supported in the static SQL syntax,
see [Static SQL](StaticSql.html).

Below is a list of the IBM Informix SQL statements that are not allowed
in the static SQL syntax (last updated from IDS **11.50** SQL
instructions). Note that the IBM Informix SQL Syntax manual includes
ESQL/C specific statements such as ALLOCATE DESCRIPTOR, which are not
part of the basic SQL statements supported by the engines. ESQL/C
specific statements are not listed here:

    ALTER ACCESS_METHOD
    ALTER FRAGMENT
    ALTER FUNCTION
    ALTER PROCEDURE
    ALTER ROUTINE
    ALTER SECURITY LABEL COMPONENT
    CREATE ACCESS_METHOD
    CREATE AGGREGATE
    CREATE CAST
    CREATE DISTINCT TYPE
    CREATE EXTERNAL TABLE Statement
    CREATE FUNCTION (with body)
    CREATE OPAQUE TYPE
    CREATE OPCLASS
    CREATE PROCEDURE (with body)
    CREATE ROLE
    CREATE ROUTINE FROM
    CREATE ROW TYPE
    CREATE SCHEMA
    CREATE SECURITY LABEL
    CREATE SECURITY LABEL COMPONENT
    CREATE SECURITY POLICY
    CREATE TRIGGER
    CREATE VIEW
    CREATE XADATASOURCE
    CREATE XADATASOURCE TYPE
    DROP ACCESS_METHOD
    DROP AGGREGATE
    DROP CAST
    DROP FUNCTION
    DROP OPCLASS
    DROP PROCEDURE
    DROP ROLE
    DROP ROUTINE
    DROP ROW TYPE
    DROP SECURITY
    DROP TRIGGER
    DROP TYPE
    DROP XADATASOURCE
    DROP XADATASOURCE TYPE
    EXECUTE FUNCTION
    EXECUTE PROCEDURE
    GRANT FRAGMENT
    INFO
    MERGE
    OUTPUT
    RELEASE SAVEPOINT
    RENAME COLUMN
    RENAME DATABASE
    RENAME SECURITY
    REVOKE FRAGMENT
    SAVE EXTERNAL DIRECTIVES
    SAVEPOINT
    SET AUTOFREE
    SET COLLATION
    SET CONSTRAINTS
    SET DATASKIP
    SET DEBUG FILE
    SET ENCRYPTION PASSWORD
    SET ENVIRONMENT
    SET INDEXES
    SET LOG
    SET OPTIMIZATION
    SET PDQPRIORITY
    SET ROLE
    SET SESSION AUTHORIZATION
    SET STATEMENT CACHE
    SET TRANSACTION
    SET TRIGGERS
    START VIOLATIONS TABLE
    STOP VIOLATIONS TABLE

------------------------------------------------------------------------

## [ODIIFX0101: CLOB and BLOB data types]{#ODIIFX0101}

In addition to the TEXT and BYTE data types (known as Simple Large
Objects), IBM Informix servers support the CLOB and BLOB types to store
large objects. CLOB/BLOB are known as Smart Large Objects. The main
difference is that Smart Large Objects support random access to the
data - seek, read and write through the SLO as if it was a OS file.

Genero BDL does not support the CLOB and BLOB types:

- It is not possible to define BDL variables with the CLOB or BLOB
  types, so you cannot manipulate CLOB/BLOB objects within programs.
- Defining a TEXT / BYTE variable to hold CLOB / BLOB column data is not
  supported; you will get error -609 (Illegal attempt to use a Text/Byte
  host variable).
- The static SQL syntax for DDL statements like CREATE TABLE does not
  allow the CLOB / BLOB keywords for column types.
- The [fgldbsch](Tools.html#TL_FGLDBSCH) schema extractor will report an
  invalid data type if you try to get the schema for a table with a CLOB
  or BLOB column.

You can, however:

- Create a table with CLOB/BLOB columns by using [Dynamic
  SQL](DynamicSql.html).
- Use the Smart Large Object functions FILETOBLOB(), FILETOCLOB(),
  LOCOPY(), LOTOFILE() in static SQL statements.

*Enhancement reference: 476*

------------------------------------------------------------------------

## [ODIIFX0103: The LIST data type]{#ODIIFX0103}

In IBM Informix databases, the LIST type is a collection type that can
store ordered elements of a specific base type. Unlike the MULTISET
type, the elements of a LIST have ordinal positions. Elements can be
duplicated.

Genero BDL does not support the IBM Informix LIST data type.

- It is not possible to define BDL variables with the LIST type.
- The static SQL syntax does not support collection-related syntax
  elements:
  - DDL statements like CREATE TABLE cannot use the LIST keyword for
    column types,
  - The collection-derived notation TABLE() is not allowed,
  - The INSERT AT *position* instruction is not supported,
  - The LIST { } literal syntax is not allowed.
  - The \<value\> IN \<identifier\> syntax is not allowed.
- The [fgldbsch](Tools.html#TL_FGLDBSCH) schema extractor will report an
  invalid data type if you try to get the schema for a table with a LIST
  column.

------------------------------------------------------------------------

## [ODIIFX0104: The MULTISET data type]{#ODIIFX0104}

The MULTISET IBM Informix data type is a collection type that can store
non-ordered elements of a specific base type. Unlike the LIST type, the
elements of a MULTISET have no ordinal positions. Elements can be
duplicated.

Genero BDL does not support the IBM Informix MULTISET data type:

- It is not possible to define BDL variables with the MULTISET type.
- The static SQL syntax does not support collection-related syntax
  elements:
  - DDL statements like CREATE TABLE cannot use the MULTISET keyword for
    column types,
  - The collection-derived notation TABLE() is not allowed,
  - The MULTISET { } literal syntax is not allowed.
  - The \<value\> IN \<identifier\> syntax is not allowed.
- The [fgldbsch](Tools.html#TL_FGLDBSCH) schema extractor will report an
  invalid data type if you try to get the schema for a table with a
  MULTISET column.

------------------------------------------------------------------------

## [ODIIFX0105: The SET data type]{#ODIIFX0105}

The SET IBM Informix data type is a collection type that stores
non-ordered unique elements of a specific base type. Unlike the LIST
type, the elements of a LIST have no ordinal positions. Elements cannot
be duplicated.

Genero BDL does not support the IBM Informix SET data type:

- It is not possible to define BDL variables with the SET type.
- The static SQL syntax does not support collection-related syntax
  elements:
  - DDL statements like CREATE TABLE cannot use the SET keyword for
    column types,
  - The collection-derived notation TABLE() is not allowed,
  - The SET { } literal syntax is not allowed.
  - The \<value\> IN \<identifier\> syntax is not allowed.
- The [fgldbsch](Tools.html#TL_FGLDBSCH) schema extractor will report an
  invalid data type if you try to get the schema for a table with a SET
  column.

------------------------------------------------------------------------

## [ODIIFX0106: The ROW data types]{#ODIIFX0106}

IBM Informix supports the named and unnamed ROW data types. A ROW type
is a complex type that combines several table columns. You create a ROW
type with the CREATE ROW TYPE instruction, and then you can reuse the
type definition for a table column.

Genero BDL does not support the IBM Informix ROW data types:

- It is not possible to define BDL variables with a named ROW type. The
  equivalent would be a RECORD variable, but data is not mapped directly
  from a structured ROW column, you must list individual fields of the
  ROW column.
- The static SQL syntax does not support ROW-related syntax elements:
  - The DDL statements CREATE ROW TYPE, DROP ROW TYPE, CREATE CAST and
    DROP CAST are not allowed,
  - In CREATE TABLE / ALTER TABLE DDL statements, the data type must be
    a built-in type.
  - The :: cast operator is not supported when specifying a ROW()
    literal. However, the CAST() expressions are allowed.
- The [fgldbsch](Tools.html#TL_FGLDBSCH) schema extractor will report an
  invalid data type if you try to get the schema for a table with a
  column defined with a ROW type.

However:

- Static SQL allows multi-level single-dot notation, so you can, for
  example, identify a ROW field as *employee.address.city*.
- Dynamic SQL can be used to insert or update rows with ROW type
  columns.
- Individual ROW column fields can be fetched to BDL program variables,
  as long as the basic types match.

*Enhancement reference: 19159*

------------------------------------------------------------------------

## [ODIIFX0107: OPAQUE data types]{#ODIIFX0107}

Opaque User Defined Types can be implemented in IBM Informix with the
CREATE OPAQUE TYPE statement. The storage structure of an OPAQUE type is
unknown to the database server, data can only be accessed through
user-defined routines.

Genero BDL does not support the IBM Informix OPAQUE data types:

- It is not possible to define BDL variables with an opaque type.
- The static SQL syntax does not support OPAQUE-related syntax elements:
  - The DDL statements CREATE OPAQUE TYPE, DROP TYPE, CREATE CAST and
    DROP CAST are not allowed,
  - In CREATE TABLE / ALTER TABLE DDL statements, the data type must be
    a built-in type.
  - The :: cast operator is not supported. However, the CAST()
    expressions are allowed.
- The [fgldbsch](Tools.html#TL_FGLDBSCH) schema extractor will report an
  invalid data type if you try to get the schema for a table with a
  column defined with a OPAQUE type.

------------------------------------------------------------------------

## [ODIIFX0108: The :: cast operator]{#ODIIFX0108}

IBM Informix SQL implements the :: cast operator and the CAST()
expressions to do an explicit cast of a value:

    CREATE TABLE tab ( v INTEGER )
    INSERT INTO tab VALUES ( 123456::INTEGER )
    SELECT 'abcdef'::CHAR(20)||'.' FROM tab
    SELECT CAST('abcdef' AS CHAR(20))||'.' FROM tab

Genero BDL does not support the :: cast operator is the static SQL
grammar. However, the CAST() expressions are allowed. If you need to use
the :: cast operator, you must use [Dynamic SQL](DynamicSql.html) to
perform such queries.

*Enhancement reference: 19190*

------------------------------------------------------------------------

## [ODIIFX0109: Projection clause options]{#ODIIFX0109}

IBM Informix SQL supports result set options to be used in projection
clauses (a.k.a SELECT clause). You can add the SKIP, FIRST/LIMIT
keywords after the SELECT keyword to reduce the number of rows returned
by the query. 

    SELECT FIRST 10 customer.* FROM customer

Genero BDL does not support SELECT clause options in static SQL
statements. You can however use [Dynamic SQL](DynamicSql.html) to
perform such queries.

*Enhancement reference: 19192*

------------------------------------------------------------------------

## [ODIIFX0110: Table inheritance]{#ODIIFX0110}

IBM Informix SQL allows you to define a table hierarchy through named
row types. Table inheritance allows a table to inherit the properties of
the supertable in the meaning of constraints, storage options, triggers.
You must first create the types with CREATE ROW TYPE, then you can
create the tables with the UNDER keyword to define the hierarchy
relationship.

    CREATE ROW TYPE person_t ( name VARCHAR(50) NOT NULL, address VARCHAR(200), birthdate DATE )
    CREATE ROW TYPE employee_t ( salary INTEGER, manager VARCHAR(50) )
    CREATE TABLE person OF TYPE person_t
    CREATE TABLE employee OF TYPE employee_t UNDER person

A table hierarchy allows you to do SQL queries whose row scope is the
supertable and its subtables. For example, after inserting one row in
the person table and another one in the employee table, if you UPDATE
the name column without a WHERE clause, it will update all rows from
both tables. To limit the set of rows affected by the statement to rows
of the supertable, you must use the ONLY keyword:

    UPDATE ONLY(person) SET birthdate = NULL
    SELECT * FROM ONLY(person)

Genero BDL static SQL grammar does not include the syntax elements
related to table hierarchy management. You can however use [Dynamic
SQL](DynamicSql.html) to perform such queries.

*Enhancement reference: 19200*

------------------------------------------------------------------------

## [ODIIFX0111: CASE expressions]{#ODIIFX0111}

IBM Informix SQL implements the CASE expressions like most database
servers. it can for example be used in an UPDATE statement as follows: 

    UPDATE stock SET unit_price =
     CASE
       WHEN stock_type = 1 THEN unit_price * 1.2
       WHEN stock_type = 2 THEN unit_price * 1.9
       ELSE 0
     END

Genero BDL static SQL grammar does not support the CASE expressions. You
can however use [Dynamic SQL](DynamicSql.html) to perform such queries.

*Enhancement reference: 19197*

------------------------------------------------------------------------

## [ODIIFX0112: IF NOT EXISTS clause]{#ODIIFX0112}

IBM Informix IDS 11.70 introduced the IF NOT EXISTS clause in CREATE
statements, to create the database object only if it does not already
exist and avoid an SQL error. The corresponding DROP statements can be
written with an IF EXISTS clause, to avoid errors if you try to drop an
database object which does not exist:

    CREATE TABLE IF NOT EXISTS mytable( ... );
    DROP TABLE IF EXISTS mytable;

Genero BDL static SQL grammar does not support the IF NOT EXISTS and IF
EXISTS clauses. You can however use [Dynamic SQL](DynamicSql.html) to
perform such queries.

*Enhancement reference: 19298*
