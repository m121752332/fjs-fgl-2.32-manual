[Back to Contents](../index.html)

------------------------------------------------------------------------

# [Database Schema Files]{#PAGE_HEADER}

Summary:

- [What are Database Schema Files?](#DEFINITION)
- [Database Schema Extractor](#EXTRACTOR)
- [Schema Files](#SCHEMA_FILES)
  - [Column Definition File (.sch)](#SCH_FILE)
    - [Informix DISTINCT types](#IFX_DISTINCT_TYPES)
  - [Column Validation File (.val)](#VAL_FILE)
  - [Column Video Attributes File (.att)](#ATT_FILE)

*See also:* [Forms](FormSpecFiles.html), [Programs](Programs.html),
[Variables](Variables.html), [fgldbsch](Tools.html#TL_FGLDBSCH)

------------------------------------------------------------------------

### [Definition of Database Schema Files]{#DEFINITION}

Database Schema Files hold the definition of the database tables and
columns. The schema files contain the column data types, validation
rules, form item types, and display attributes for columns.

The schema files are typically used to centralize column data types to
define [program variables](Variables.html), as well as display
attributes which are normally specified in the [form specification
file](FormSpecFiles.html).

**Warning: It is strongly recommended that you re-generate the schema
files when upgrading to a new Genero BDL version. Bug fixes and new data
type support can required schema file changes. If the schema file holds
data type codes that are unknown to the current version, the compilers
will raise the error [-6634](FglErrors.html#-6634). **

The database schema files are generated with the
[fgldbsch](Tools.html#TL_FGLDBSCH) tool from the system tables of an
existing database.

**Warning: For some type of databases, the table owner is mandatory to
extract schema information. If you do not specify the -ow option in the
comment line, fgldbsch will take the -un user name as default. If you do
not use the -un/-up options because you are using [indirect database
connection](Connections.html#DS_ODI_INDIRECT) with FGLPROFILE settings
to identify the database user or if the database user is authenticated
by the operating system, the fgldbsch tool will try to identify the
current database user (USER or CURRENT_USER constant) and use this as
table owner to extract the schema.**

In program sources or form specification files, you must specify the
database schema file with the [SCHEMA](Programs.html#DB_SCHEMA)
instruction. The [FGLDBPATH](EnvironmentVariables.html#EV_FGLDBPATH)
environment variable can be used to define a list of directories where
the compiler can find database schema files.

**Warning: The data types, display attributes, and validation rules are
taken from the *Database Schema Files* **[during
compilation]{.underline}**. Make sure that the schema files of the
[development database](FglTerms.html#DEVELOPMENT_DATABASE) correspond to
the [production database](FglTerms.html#PRODUCTION_DATABASE), otherwise
the elements defined in the compiled version of your modules and
[forms](FormSpecFiles.html) will not match the table structures of the
production database.**

Program variables can be defined with the
[LIKE](Variables.html#DEFINITION) keyword to get the data type defined
in the schema files:

``` linenumber
01 SCHEMA stores
02 MAIN
03   DEFINE custrec RECORD LIKE customer.*
04   DEFINE name LIKE customer.cust_name
05   ...
06 END MAIN
```

Form fields defined with the [FIELD item
type](FormSpecFiles.html#FF_ITEMTYPE_FIELD) can get the form item type
from the schema files:

``` linenumber
01 SCHEMA stores
02 LAYOUT
03 GRID
04 {
05   [f001         ]
06 }
07 TABLES
08   customer
09 END
10 ATTRIBUTES
11 FIELD f001 = customer.cust_name;
12 END
```

**Note:** For handling uppercase characters in the database name you
must quote the name: SCHEMA \"myDatabase\"

------------------------------------------------------------------------

### [Database Schema Extractor]{#EXTRACTOR}

The [fgldbsch](Tools.html#TL_FGLDBSCH) tool extracts the schema
description for any database supported by Genero. Schema information is
extracted from the database specific system tables. The database type is
automatically detected after connection; you do not have to specify any
database server type.

The [database system](FglTerms.html#DATABASE_SYSTEM) must be available
and the database client environment must be set properly in order to
connect to the database engine and generate the schema files.

You must run `fgldbsch` with the `-db dbname` option to identify the
database source to which to connect. The `dbname` and related options
could be present in the [FGLPROFILE](FglProfile.html) file. See
[[Indirect database specification
method](Connections.html#DS_ODI_INDIRECT){#DS_ODI_INDIRECT}]{.underline} 
in [Database Connections](Connections.html){#PAGE_HEADER}. Otherwise,
related options have to be provided with the `fgldbsch` command.

`fgldbsch `**`-db test1`**

The database driver can be specified with the `-dv dbdriver` option, if
the default driver is not appropriate.

`fgldbsch -db test1 `**`-dv dbmoraB2x`**

If the operating system user is not the database user, you can provide a
database user name and password respectively with the `-un` and `-up`
options.

`fgldbsch -db test1 `**`-un scott -up fourjs`**

The [fglcomp](Tools.html#TL_FGLCOMP) and
[fglform](Tools.html#TL_FGLFORM) compilers expect [BDL data
types](DataTypes.html) in the schema file. While most data types
correspond to Informix SQL data types, non-Informix databases can have
different data types. Therefore, data types in the schema file are
generated from the system catalog tables according to some conversion
rules. You can control the conversion method with the `-cv` option. Each
character position of the string passed by this option corresponds to a
line in the conversion table. You must give a conversion code for each
data type (for example: `-cv AABAAAB`). Run the tool with the `-ct`
option to see the conversion tables. When using `X` as conversion code,
the columns using the corresponding data types will be ignored and not
written to the **.sch** file. This is particularly useful in the case of
auto-generated columns like SQL Server\'s *uniqueidentifier* data type,
when using a `DEFAULT NEWID()` clause.

`fgldbsch -ct`\
`...`\
`------------------------------------------------------------------`\
`Informix        Informix A           Informix B`\
`------------------------------------------------------------------`\
`1 BOOLEAN       `**`BOOLEAN (t=45)`**`       CHAR(1)`**\**
` 2 INT8          `**`INT8`**`                 DECIMAL(19,0)`**\**
` 3 SERIAL8       `**`SERIAL8`**`              DECIMAL(19,0)`**\**
` 4 LVARCHAR(m)   LVARCHAR (ns)        `**`VARCHAR2(m)`\**
` 5 BIGINT        `**`BIGINT`**`               DECIMAL(19,0)`**\**
` 6 BIGSERIAL     `**`BIGSERIAL`**`            DECIMAL(19,0)`**\**
` ------------------------------------------------------------------`\
`(ns) = Not supported in 4gl.`\
`...`\
\
`fgldbsch -db test1 `**`-cv AAABAA`**\
`                       123456`

In the example above, the -`cv` option instructs `fgldbsch` to use the
types of the \"Informix A\" column for all original column types except
for LVARCHAR, which must be converted to a VARCHAR2(m), the Genero
VARCHAR without the 255 bytes limit.

Not all native data types can be converted to Genero BDL types. For
example, user-defined types or spatial types are not supported by the
language. When a table column with such unsupported data type is found,
`fgldbsch` stops and displays an error to bring the problem to your
eyes. You can use the -`ie` option to have `fgldbsch` ignore the
database tables having columns with unsupported types. When this option
is used, none of the table columns definition will be written to the
schema file.

With some databases, the owner of tables is mandatory to extract a
schema, otherwise you could get multiple definitions of the same table
in the **.sch** schema file if tables with the same name exist in
different database user schemas. To prevent such mistakes, you can
specify the schema owner with the `-ow owner` option. If this option is
not used, `fgldbsch` will use the database login name passed with the
`-un user` option. This is usually the case with SQL Server and Sybase,
where the owner of tables is \"dbo\".

`fgldbsch -db test1 -un scott -up fourjs `**`-ow dbo`**

By default `fgldbsch` does not generate system table definitions. You
may want to use the `-st` option to extract schema information of system
tables.

`fgldbsch -db test1 `**`-st`**

**Warning: The `fgldbsch` tool in **BDL v1.3x** provides the `-ns`
option to generate [without]{.underline} the database system tables.
This option is no longer supported in the `fgldbsch` tool in **BDL
v2.xx** and is replaced by the `-st` option to generate
[with]{.underline} the database system tables.**

By default, the generated schema files get the name of the database
source specified with the `-db` option. If needed, you can force the
name of the schema file with the `-of name` option. Specify the output
file name without the **.sch** extension. Note that this name will also
be used to extract [syscolval](#VAL_FILE) and [syscolatt](#ATT_FILE)
information.

`fgldbsch -db test1 `**`-of myschema`**

In some cases, you may just want to extract schema file of new created
tables. You can achieve this by using the `-tn tabname` option, to
extract schema information of a specific table.

`fgldbsch -db test1 `**`-tn customers`**

By default, table and column names are converted to lower case letters
to enforce compatibility with Informix. You can force lower case, upper
case or case-sensitive generation by using the `-cl`, `-cu` or `-cc`
options.

`fgldbsch -db test1 `**`-cc`**

**Warning: When using an Informix database,
[fgldbsch](Tools.html#TL_FGLDBSCH) extracts synonyms. By default, only
PUBLIC synonyms are extracted to avoid duplicates in the .sch file when
the same name is used by several synonyms by different owners. If you
want to extract PRIVATE synonyms, you must use the -ow option to specify
the owner of the tables and synonyms.**

Use the `-v` option to get verbose output from `fgldbsch`:

`fgldbsch -db test1 `**`-v`**

------------------------------------------------------------------------

### [Schema Files]{#SCHEMA_FILES}

------------------------------------------------------------------------

#### [Column Definition File (.sch)]{#SCH_FILE}

The **.sch** file contains the data types of table columns.

##### Example:

``` linenumber
01 customer^customer_num^258^4^1^
02 customer^customer_name^256^50^2^
03 customer^customer_address^0^100^3^
04 order^order_num^258^4^1^
05 order^order_custnum^258^4^2^
06 order^order_date^263^4^3^
07 order^order_total^261^1538^4^
```

##### Description:

The data type of [program variables](Variables.html) or [form
fields](FormSpecFiles.html) used to hold data of a given database column
must match the data type used in the database. BDL simplifies the
definition of these elements by centralizing the information in external
**.sch** files, which contain column data types.

In form files, you can directly specify the table and column name in the
field definition in the
[ATTRIBUTES](FormSpecFiles.html#SECTION_ATTRIBUTES) section of forms.

In programs, you can define variables with the data type of a database
column by using the [LIKE](Variables.html#DATABASE_TYPES) keyword.

#### Warnings:

1.  As column data types are extracted from the database system tables,
    you may get different results with different database servers. For
    example, Informix provides the DATE data type to store simple dates
    in year, month, and day format (= BDL
    [DATE](DataTypes.html#DT_DATE)), while Oracle stores DATEs as year
    to second ( = BDL [DATETIME YEAR TO
    SECOND](DataTypes.html#DT_DATETIME)).

The following table describes the fields you will find in a row of the
**.sch** file:

  --------- ---------- -----------------------------------------------------------------------------------
  **Pos**   **Type**   **Description**
  **1**     STRING     Database table name.
  **2**     STRING     Column name.
  **3**     SMALLINT   Coded column data type. If the column is NOT NULL, you must add 256 to the value.
  **4**     SMALLINT   Coded data type length.
  **5**     SMALLINT   Ordinal position of the column in the table.
  --------- ---------- -----------------------------------------------------------------------------------

[Next table]{#TYPE_CODES} shows the data types and their corresponding
type code that can be represented in the **.sch** schema file:

+-----------------------+:---------------------:+--------------------------------------+
| **Data type name**    | **Data type code\     | **Data type length (field #4)\       |
|                       |  (field #3)**         | This is a SMALLINT value encoding    |
|                       |                       | the length or composite length of    |
|                       |                       | the type.**                          |
+-----------------------+-----------------------+--------------------------------------+
| CHAR                  | **0**                 | Maximum number of characters.        |
+-----------------------+-----------------------+--------------------------------------+
| SMALLINT              | **1**                 | Fixed length of 2                    |
+-----------------------+-----------------------+--------------------------------------+
| INTEGER               | **2**                 | Fixed length of 4                    |
+-----------------------+-----------------------+--------------------------------------+
| FLOAT / DOUBLE        | **3**                 | Fixed length of 8                    |
| PRECISION             |                       |                                      |
+-----------------------+-----------------------+--------------------------------------+
| SMALLFLOAT / REAL     | **4**                 | Fixed length of 4                    |
+-----------------------+-----------------------+--------------------------------------+
| DECIMAL               | **5**                 | The length is computed using the     |
|                       |                       | following formula:\                  |
|                       |                       | **length = ( precision \* 256 ) +    |
|                       |                       | scale**                              |
+-----------------------+-----------------------+--------------------------------------+
| SERIAL                | **6**                 | Fixed length of 4                    |
+-----------------------+-----------------------+--------------------------------------+
| DATE                  | **7**                 | Fixed length of 4                    |
+-----------------------+-----------------------+--------------------------------------+
| MONEY                 | **8**                 | Same as DECIMAL                      |
+-----------------------+-----------------------+--------------------------------------+
| *Unused*              | **9**                 | *N/A*                                |
+-----------------------+-----------------------+--------------------------------------+
| DATETIME              | **10**                | For DATETIME and INTERVAL types, the |
|                       |                       | length is determined using the next  |
|                       |                       | formula:\                            |
|                       |                       | **length = ( digits \* 256 ) + (     |
|                       |                       | qual1 \* 16 ) + qual2**\             |
|                       |                       | where *digits* is the total number   |
|                       |                       | of digits used when displaying the   |
|                       |                       | date-time value. For example, a      |
|                       |                       | DATETIME YEAR TO MINUTE (YYYY-MM-DD  |
|                       |                       | hh:mm) uses 12 digits. The *qual1*   |
|                       |                       | and *qual2* elements identify        |
|                       |                       | date-time qualifiers according to    |
|                       |                       | the following list:                  |
|                       |                       |                                      |
|                       |                       | ::: {align="center"}                 |
|                       |                       |   ------------------                 |
|                       |                       |   0 = YEAR                           |
|                       |                       |   2 = MONTH                          |
|                       |                       |   4 = DAY                            |
|                       |                       |   6 = HOUR                           |
|                       |                       |   8 = MINUTE                         |
|                       |                       |   10 = SECOND                        |
|                       |                       |   11 = FRACTION(1)                   |
|                       |                       |   12 = FRACTION(2)                   |
|                       |                       |   13 = FRACTION(3)                   |
|                       |                       |   14 = FRACTION(4)                   |
|                       |                       |   15 = FRACTION(5)                   |
|                       |                       |   ------------------                 |
|                       |                       | :::                                  |
+-----------------------+-----------------------+--------------------------------------+
| BYTE                  | **11**                | Length of descriptor                 |
+-----------------------+-----------------------+--------------------------------------+
| TEXT                  | **12**                | Length of descriptor                 |
+-----------------------+-----------------------+--------------------------------------+
| VARCHAR               | **13**                | If length is positive:\              |
|                       |                       | **length = ( min_space \* 256 ) +    |
|                       |                       | max_size\**                          |
|                       |                       | If length is negative:\              |
|                       |                       | **length + 65536 = ( min_space \*    |
|                       |                       | 256 ) + max_size**                   |
+-----------------------+-----------------------+--------------------------------------+
| INTERVAL              | **14**                | Same as DATETIME                     |
+-----------------------+-----------------------+--------------------------------------+
| NCHAR                 | **15**                | Same as CHAR                         |
+-----------------------+-----------------------+--------------------------------------+
| NVARCHAR              | **16**                | Same as VARCHAR                      |
+-----------------------+-----------------------+--------------------------------------+
| INT8                  | **17**                | Fixed length of 10 (sizeof int8      |
|                       |                       | structure)\                          |
|                       |                       | **Will be converted to a Genero BDL  |
|                       |                       | [BIGINT](DataTypes.html#DT_BIGINT)   |
|                       |                       | type!**                              |
+-----------------------+-----------------------+--------------------------------------+
| SERIAL8               | **18**                | Fixed length of 10 (sizeof int8      |
|                       |                       | structure)\                          |
|                       |                       | **Will be converted to Genero BDL    |
|                       |                       | [BIGINT](DataTypes.html#DT_BIGINT)   |
|                       |                       | type!**                              |
+-----------------------+-----------------------+--------------------------------------+
| SET                   | **19**                | *Not used by Genero BDL*             |
+-----------------------+-----------------------+--------------------------------------+
| MULTISET              | **20**                | *Not used by Genero BDL*             |
+-----------------------+-----------------------+--------------------------------------+
| LIST                  | **21**                | *Not used by Genero BDL*             |
+-----------------------+-----------------------+--------------------------------------+
| Unnamed ROW           | **22**                | *Not used by Genero BDL*             |
+-----------------------+-----------------------+--------------------------------------+
| Variable-length       | **40**                | *Not used by Genero BDL*             |
| opaque type           |                       |                                      |
+-----------------------+-----------------------+--------------------------------------+
| Fixed-length opaque   | **41**                | *Not used by Genero BDL*             |
| type                  |                       |                                      |
+-----------------------+-----------------------+--------------------------------------+
| BOOLEAN (SQLBOOL)     | **45**                | Boolean type, in the meaning of      |
|                       |                       | Informix front-end SQLBOOL           |
|                       |                       | (sqltype.h)                          |
+-----------------------+-----------------------+--------------------------------------+
| BIGINT                | **52**                | Fixed length of 8 (bytes)            |
+-----------------------+-----------------------+--------------------------------------+
| BIGSERIAL             | **53**                | Fixed length of 8 (bytes)            |
+-----------------------+-----------------------+--------------------------------------+
| VARCHAR2              | **201**               | Maximum number of characters\        |
|                       |                       | **Will be converted to a Genero BDL  |
|                       |                       | [VARCHAR](DataTypes.html#DT_VARCHAR) |
|                       |                       | type!**                              |
+-----------------------+-----------------------+--------------------------------------+
| NVARCHAR2             | **202**               | Maximum number of characters\        |
|                       |                       | **Will be converted to a Genero BDL  |
|                       |                       | [VARCHAR](DataTypes.html#DT_VARCHAR) |
|                       |                       | type!**                              |
+-----------------------+-----------------------+--------------------------------------+
| IDSSECURITYLABEL      | **2061**              | DISTINCT type of VARCHAR(128)        |
+-----------------------+-----------------------+--------------------------------------+
| Named ROW             | **4118**              | *Not used by Genero BDL*             |
+-----------------------+-----------------------+--------------------------------------+

##### [Informix DISTINCT types]{#IFX_DISTINCT_TYPES}

Informix IDS version 9.x and higher allow you to define DISTINCT types
from a base types with the CREATE DISTINCT TYPE instruction. In the
*syscolumns* table, Informix identifies distinct types in the *coltype*
column by adding the **0x0800** bit (2048) to the base type code. For
example, a distinct type defined with the VARCHAR [built-in
type]{.underline} (i.e. code **13**) will be identified with the code
**2061** (13 + 2048). Informix sets additional bits when the distinct
type is based on the LVARCHAR or BOOLEAN [opaque types]{.underline}: If
the base type is an LVARCHAR, the type code used in *coltype* gets the
**0x2000** bit set (8192) and when the base type is BOOLEAN, the type
code gets the **0x4000** bit (16384).

When extracting a schema from an Informix database defining columns with
DISTINCT types, the schema extractor will keep the original type code of
the distinct type in the **.sch** file for columns using distinct types
based on [built-in types]{.underline} (with the 0x0800 bit set).
Regarding the exception of [opaque types]{.underline}, BOOLEAN-based
distinct types get the code **45** ( + 256 if NOT NULL), and
LVARCHAR-based distinct types are mapped to the code **201** (+ 256 if
NOT NULL) if the -cv option enables conversion from LVARCHAR to
VARCHAR2.

The [fglcomp](Tools.html#TL_FGLCOMP) and
[fglform](Tools.html#TL_FGLFORM) compilers understand the distinct type
code bit **0x0800**, so you can define program variables with a DEFINE
LIKE instruction based on a column that was created with a distinct
Informix type.

------------------------------------------------------------------------

#### [Column Validation File (.val)]{#VAL_FILE}

The **.val** file holds functional and display attributes of columns.

##### Example:

``` linenumber
01 customer^customer_name^STYLE^"important"^
02 customer^customer_name^SHIFT^UP^
03 customer^customer_name^COMMENTS^"Name of the customer"^
04 order^order_date^DEFAULT^TODAY^
05 order^order_date^COMMENTS^"Creation date of the order"^
```

##### Description:

The **.val** file holds default attributes and validation rules for
database columns.

In form files, the attributes are taken from the **.val** file as
defaults if the corresponding attribute is not explicitly specified in
the field definition of the
[ATTRIBUTES](FormSpecFiles.html#SECTION_ATTRIBUTES) section.

In programs, you can validate variable values in accordance with the
[INCLUDE](FSFAttributes.html#FA_INCLUDE) attribute by using the
[VALIDATE](Variables.html#VA_VALIDATE) instruction.

The **.val** file can be generated by [fgldbsch](Tools.html#TL_FGLDBSCH)
from the Informix-specific `syscolval` table, or can be edited by an
external column attributes editor.

The following table describes the structure of the **.val** file:

  --------- ---------- ------------------------
  **Pos**   **Type**   **Description**
  `1`       STRING     Database table name. 
  `2`       STRING     Column name.
  `3`       STRING     Column property name.
  `4`       STRING     Column property value.
  --------- ---------- ------------------------

The supported attribute definitions are:

  ----------------------------------- -------------------------------------------------------------------------------------------------------------------------------------------------------
  **Attribute Name**                  **Description**

  `ACTION`                            Defines the [ACTION](FSFAttributes.html#FA_ACTION) attribute.\
                                      Value must be an identifier.

  `AUTONEXT`                          Defines the [AUTONEXT](FSFAttributes.html#FA_AUTONEXT) attribute.\
                                      When this attribute is defined, value is `YES`.

  `AUTOSCALE`                         Defines the [AUTOSCALE](FSFAttributes.html#FA_AUTOSCALE) attribute.\
                                      When this attribute is defined, value is `YES`.

  `CENTURY`                           Defines the [CENTURY](FSFAttributes.html#FA_CENTURY) attribute.\
                                      The value must be one of: `R`, `C`, `F`, or `P`.

  `COLOR`                             Defines the [COLOR](FSFAttributes.html#FA_COLOR) attribute.\
                                      The value is a color identifier (RED, GREEN, BLUE, \...)

  `COMMENTS`                          Defines the [COMMENTS](FSFAttributes.html#FA_COMMENT) attribute.\
                                      The value is a quoted string or Localized String (`%"xxx"`).

  `DEFAULT`                           Defines the [DEFAULT](FSFAttributes.html#FA_DEFAULT) attribute.\
                                      Number, quoted string or identifier (`TODAY`).

  `FORMAT`                            Defines the [FORMAT](FSFAttributes.html#FA_FORMAT) attribute.\
                                      The value is a quoted string.

  `HEIGHT`                            Defines the [HEIGHT](FSFAttributes.html#FA_HEIGHT) attribute.\
                                      The value is an integer followed by: { `CHARACTERS`, `COLUMNS`, `LINES`, `POINTS`, or `PIXELS` }

  `IMAGE`                             Defines the [IMAGE](FSFAttributes.html#FA_IMAGE) attribute.\
                                      The value is a quoted string.

  `INCLUDE`                           Defines an include list as the [INCLUDE](FSFAttributes.html#FA_INCLUDE) attribute.\
                                      Value must be a list: `(`*`value`*` `[`[`]{.underline}`,...`[`]`]{.underline}`)`, where *`value`* can be a number, quoted string or identifier
                                      (`TODAY`).

  `INITIALIZER`                       Defines the [INITIALIZER](FSFAttributes.html#FA_INITIALIZER) attribute.\
                                      Value must be an identifier.

  `INVISIBLE`                         Defines the [INVISIBLE](FSFAttributes.html#FA_INVISIBLE) attribute.\
                                      When this attribute is defined, value is `YES`.

  `ITEMS`                             Defines the [VALUEUNCHECKED](FSFAttributes.html#FA_VALUEUNCHECKED) attribute.\
                                      The value must be a list: `(`*`item`*` `[`[`]{.underline}`,...`[`]`]{.underline}`)`, where *`item`* can be a number, a quoted string or
                                      `(`*`value`*`,"label")`.

  `ITEMTYPE`                          Defines the Form Item Type to be used when the column is used as [FIELD](FormSpecFiles.html#FF_ITEMTYPE_FIELD) in forms.\
                                      Value must be an identifier defining the item type (case sensitive!):\
                                      `Edit`,` ButtonEdit`,` Label`,` Image`,` DateEdit`,` TextEdit`,` ComboBox`,` RadioGroup`,` CheckBox`,` Slider`,` SpinEdit`,` TimeEdit`,` ProgressBar`

  `JUSTIFY`                           Defines the [JUSTIFY](FSFAttributes.html#FA_JUSTIFY) attribute.\
                                      The value must be one of: `LEFT`, `CENTER` or `RIGHT`.

  `ORIENTATION`                       Defines the [ORIENTATION](FSFAttributes.html#FA_ORIENTATION) attribute.\
                                      The value must be one of: `VERTICAL` or `HORIZONTAL`.

  `PICTURE`                           Defines the [PICTURE](FSFAttributes.html#FA_PICTURE) attribute.\
                                      The value is a quoted string.

  `SAMPLE`                            Defines the [SAMPLE](FSFAttributes.html#FA_SAMPLE) attribute.\
                                      The value is a quoted string.

  `SCROLL`                            Defines the [SCROLL](FSFAttributes.html#FA_SCROLL) attribute.\
                                      When this attribute is defined, value is `YES`.

  `SCROLLBARS`                        Defines the [SCROLLBARS](FSFAttributes.html#FA_SCROLLBARS) attribute.\
                                      The value must be one of: `X`, `Y` or `BOTH`.

  `SHIFT`                             Corresponds to the [UPSHIFT](FSFAttributes.html#FA_UPSHIFT) and [DOWNSHIFT](FSFAttributes.html#FA_DOWNSHIFT) attributes.\
                                      Values can be `UP` or `DOWN`.

  `SIZEPOLICY`                        Defines the [SIZEPOLICY](FSFAttributes.html#FA_SIZEPOLICY) attribute.\
                                      The value must be one of: `INITIAL`, `DYNAMIC` or `FIXED`.

  `STEP`                              Defines the [STEP](FSFAttributes.html#FA_STEP) attribute.\
                                      The value must be an integer.

  `STRECH`                            Defines the [STRETCH](FSFAttributes.html#FA_STRETCH) attribute.\
                                      The value must be one of: `X`, `Y` or `BOTH`.

  `STYLE`                             Defines the [STYLE](FSFAttributes.html#FA_STYLE) attribute.\
                                      The value is a quoted string.

  `TAG`                               Defines the [TAG](FSFAttributes.html#FA_TAG) attribute.\
                                      The value is a quoted string.

  `TEXT`                              Defines the [TEXT](FSFAttributes.html#FA_TEXT) attribute.\
                                      The value is a quoted string or Localized String (`%"xxx"`).

  `TITLE`                             Defines the [TITLE](FSFAttributes.html#FA_TITLE) attribute.\
                                      The value is a quoted string or Localized String (`%"xxx"`).

  `VALUEMIN`                          Defines the [VALUEMIN](FSFAttributes.html#FA_VALUEMIN) attribute.\
                                      The value must be an integer.

  `VALUEMAX`                          Defines the [VALUEMAX](FSFAttributes.html#FA_VALUEMAX) attribute.\
                                      The value must be an integer.

  `VALUECHECKED`                      Defines the [VALUECHECKED](FSFAttributes.html#FA_VALUECHECKED) attribute.\
                                      The value must be an number or a quoted string.

  `VALUEUNCHECKED`                    Defines the [VALUEUNCHECKED](FSFAttributes.html#FA_VALUEUNCHECKED) attribute.\
                                      The value must be an number or a quoted string.

  `VERIFY`                            Defines the [VERIFY](FSFAttributes.html#FA_VERIFY) attribute.\
                                      When this attribute is defined, value is `YES`.

  `WANTTABS`                          Defines the [WANTTABS](FSFAttributes.html#FA_WANTTABS) attribute.\
                                      When this attribute is defined, value is `YES`.

  `WANTNORETURNS`                     Defines the [WANTNORETURNS](FSFAttributes.html#FA_WANTNORETURNS) attribute.\
                                      When this attribute is defined, value is `YES`.

  `WIDTH`                             Defines the [WIDTH](FSFAttributes.html#FA_WIDTH) attribute.\
                                      The value is an integer followed by: { `CHARACTERS`, `COLUMNS`, `LINES`, `POINTS`, or `PIXELS` }
  ----------------------------------- -------------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------

#### [Column Video Attributes File (.att)]{#ATT_FILE}

The **.att** file contains the default video attributes of columns.

This file is generated by [fgldbsch](Tools.html#TL_FGLDBSCH) from the
Informix-specific `syscolatt` table.

The following table describes the structure of the **.att** file:

  --------- ---------- -----------------------------------------
  **Pos**   **Type**   **Description**
  `1`       STRING     Database table name. 
  `2`       STRING     Column name.
  `3`       SMALLINT   Ordinal number of the attribute record.
  `4`       STRING     COLOR attribute (coded).
  `5`       CHAR(1)    INVERSE attribute (y/n).
  `6`       CHAR(1)    UNDERLINE attribute (y/n).
  `7`       CHAR(1)    BLINK attribute (y/n).
  `8`       CHAR(1)    LEFT attribute (y/n).
  `9`       STRING     FORMAT attribute.
  `10`      STRING     Condition.
  --------- ---------- -----------------------------------------

**Warning: This feature is supported for compatibility with Informix 4GL
only.**
