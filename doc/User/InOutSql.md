[Back to Contents](../index.html)

------------------------------------------------------------------------

# [I/O SQL Instructions]{#PAGE_HEADER}

Summary:

- [Loading data from files](#IO_LOAD) (`LOAD`)
  - [Syntax](#LOAD_SYNTAX)
  - [Usage](#LOAD_USAGE)
    - [Standard Genero BDL format with LOAD](#LOAD_STANDARD)
    - [Comma Separated Value format with LOAD](#LOAD_CSV)
  - [Example](#LOAD_EXAMPLE_1)

- [Writing data to files](#IO_UNLOAD) (`UNLOAD`)

  - [Syntax](#UNLOAD_SYNTAX)
  - [Usage](#UNLOAD_USAGE)
    - [Standard Genero BDL format with UNLOAD](#UNLOAD_STANDARD)
    - [Comma Separated Value format with UNLOAD](#UNLOAD_CSV)
  - [Example](#UNLOAD_EXAMPLE_1)

*See also:* [Connections](Connections.html).

------------------------------------------------------------------------

### [LOAD]{#IO_LOAD}

#### Purpose:

The `LOAD` instruction inserts data from a file into an existing table
in the [current database connection](Connections.html).

#### [Syntax:]{#LOAD_SYNTAX}

`LOAD FROM `*`filename`*` `[`[`]{.underline}` DELIMITER `*`delimiter`*` `[`]`]{.underline}\
[`{`]{.underline}\
`  INSERT INTO `*`table-specification`*` `[`[`]{.underline}` ( `*`column`*` `[`[,...]`]{.underline}` ) `[`]`]{.underline}\
[`|`]{.underline}\
`  `*`insert-string`*\
[`}`]{.underline}

where *table-specification* is:

`[`*`dbname`*`[@`*`dbserver`*`]:][`*`owner`*`.]`*`table`*

#### Notes:

1.  *filename* is the name of the file the data is read from.
2.  *delimiter* is the character used as the value delimiter (see
    [Usage](#LOAD_USAGE) for more details).
3.  The `INSERT` clause is a pseudo [INSERT](StaticSql.html#SS_INSERT)
    statement (without the `VALUES` clause), where you can specify the
    list of columns in braces.
4.  *dbname* identifies the database name. **Informix only!**
5.  *dbserver* identifies the Informix database server (INFORMIXSERVER).
    **Informix only!**
6.  *owner* identifies the owner of the table, with optional double
    quotes. **Informix only!**
7.  *table* is the name of the database table.
8.  *column* is a name of a table column.
9.  *insert-string* is a program [variable](Variables.html) or a [string
    literal](Literals.html#LT_STRING) containing the pseudo-INSERT
    statement. This allows you to create the pseudo-INSERT statement at
    runtime. 

#### Warnings:

1.  The number and the order of columns in the INSERT statement must
    match in the input file.
2.  You cannot use the [PREPARE](DynamicSql.html#DS_PREPARE) statement
    to preprocess a `LOAD` statement.
3.  At this time, data type description of the input file fields is
    implicit; in order to create the SQL parameter buffers to hold the
    field values for inserts, the `LOAD` instruction uses the current
    database connection to get the column data types of the target
    table. Those data types depend on the type of database server. For
    example, IBM Informix DATE columns do not store the same data as the
    Oracle DATE data type. Therefore, be careful when using this
    instruction; if your application connects to different kinds of
    database servers, you may get data conversion errors.

#### Tips:

1.  `LOAD` provides better performance when the *table* that the
    `INSERT INTO` clause references has no index, no constraint, and no
    trigger. If one or more triggers, constraints, or indexes exist on
    the table, however, it is recommended that you disable these objects
    if the database server allows such SQL operations. For example, with
    IBM Informix, you can issue one of the following SQL statements:
    - `SET INDEX ... DISABLED`
    - `SET CONSTRAINT ... DISABLED`
    - `SET TRIGGER ... DISABLED`

#### [Usage:]{#LOAD_USAGE}

The `LOAD` instruction reads serialized data from an input file and
inserts new rows in a database table specified in the `INSERT` clause. A
file created by the [UNLOAD](#IO_UNLOAD) statement can be used as input
for the `LOAD` statement if its values are compatible with the schema of
*tabl*e.

The `LOAD` statement must include a pseudo-INSERT statement (either
directly or as text in a variable) to specify where to store the data.
`LOAD` appends the new rows to the specified table, synonym, or view,
but does not overwrite existing data. It cannot add a row that has the
same key as an existing row.

The variable or string following the `LOAD FROM` keywords must specify
the name of a file of ASCII characters (or characters that are valid for
the [current code-set](Localization.html)) that holds the data values
that are to be inserted.

Each set of data values in *filename* that represents a new row is
called an input record. Each input record must contain the same number
of delimited data values. If the `INSERT` clause has no list of columns,
the sequence of values in each input record must match the columns of
*table* in number and order. Each value must have the literal format of
the column data type, or of a [compatible data
type](DataConversions.html).

If `LOAD` is executed within a [transaction](Transactions.html), the
inserted rows are locked, and they remain locked until the
` COMMIT WORK` or ` ROLLBACK WORK` statement terminates the transaction.
If no other user is accessing the table, you can avoid locking limits
and reduce locking overhead by locking the table with the ` LOCK TABLE`
statement after the transaction begins. This exclusive table lock is
released when the transaction terminates. Consult the documentation for
your database server about the limit on the number of locks available
during a single transaction.

If the current database has no transaction log, a failing `LOAD`
statement cannot remove any rows that were loaded before the failure
occurred. You must manually remove the already loaded records from
either the load file or from the receiving table, repair the erroneous
records, and rerun `LOAD`.

Regarding [transaction](Transactions.html), you can take one of the
following actions when the database has a transaction log:

- Run `LOAD` as a singleton transaction, so that any error causes the
  entire `LOAD` statement to be automatically rolled back.
- Run `LOAD` within an explicit transaction with ` BEGIN WORK` /
  ` COMMIT WORK`, so that a data error merely stops the `LOAD` statement
  in place with the transaction still open.

A single character delimiter instructs `LOAD` to read data in the
[Standard BDL format](#LOAD_STANDARD). When using \"CSV\" as delimiter
specification, the `LOAD` instruction will read the data in [Comma
Separate Value format](#LOAD_CSV). If the `DELIMITER` clause is not
specified, the delimiter is defined by the
[DBDELIMITER](EnvironmentVariables.html#EV_DBDELIMITER) environment
variable. If the DBDELIMITER environment variable is not set, the
default is a \| pipe. 

#### Warning: The DELIMITER cannot be backslash or any hexadecimal digit (0-9, A-F, a-f).

##### [Standard Genero BDL format with LOAD]{#LOAD_STANDARD}

The next table describes how data values should be represented in the
input file. Values must be serialized with a character string following
the SQL data type of the receiving column in *table.*

  ----------------------------------- -----------------------------------------------------
  **Data Type**                       **Input Format**

  `CHAR, VARCHAR, TEXT`               Values can have more characters than the declared
                                      maximum length of the column, but any extra
                                      characters are ignored. A backslash ( \\ ) is
                                      required before any literal backslash or any literal
                                      delimiter character, and before any NEWLINE character
                                      anywhere in character value. Blank values can be
                                      represented as one or more blank characters between
                                      delimiters, but leading blanks must not precede other
                                      CHAR, VARCHAR, or TEXT values.

  `DATE`                              In the default locale, values must be in
                                      *month/day/year* format unless another format is
                                      specified by
                                      [DBDATE](EnvironmentVariables.html#EV_DBDATE)
                                      environment variable. You must represent the month as
                                      a 2-digit number. You can use a 2-digit number for
                                      the year if you are satisfied with the
                                      [DBCENTURY](EnvironmentVariables.html#EV_DBCENTURY)
                                      setting. Values must be actual dates; for example,
                                      February 30 is invalid.

  `DATETIME`                          DATETIME values must be in the format:\
                                         *year-month-day hour:minute:second.fraction\*
                                      or a contiguous subset, without the DATETIME keyword
                                      or qualifiers. Time units outside the declared column
                                      precision can be omitted. The *year* must be a
                                      four-digit number; all other time units (except
                                      *fractio*n) require two digits.

  `INTERVAL`                          INTERVAL values must be formatted:\
                                         *yea*r-*month\*
                                      or else\
                                         *day hou*r:*minut*e:*secon*d.*fractio*n\
                                      or a contiguous subset thereof, without the INTERVAL
                                      keyword or qualifiers. Time units outside the
                                      declared column precision can be omitted. All time
                                      units (except *year* and *fractio*n) require two
                                      digits.

  `MONEY`                             Values can include currency symbols, but these are
                                      not required.

  `BYTE`                              Values must be ASCII-hexadecimals; no leading or
                                      trailing blanks.

  `SERIAL, BIGSERIAL, SERIAL8`        Values can be represented as 0 to tell the database
                                      server to supply a new serial value. You can specify
                                      a literal integer greater than zero, but if the
                                      column has a unique index, an error results if this
                                      number duplicates an existing value.
  ----------------------------------- -----------------------------------------------------

The NEWLINE character must terminate each input record in *filenam*e.
Specify only values that the language can convert to the data type of
the database column. For database columns of character data types,
inserted values are truncated from the right if they exceed the declared
length of the column.

NULL values of any data type must be represented by consecutive
delimiters in the input file; you cannot include anything between the
delimiter symbols.

The `LOAD` statement expects incoming data in the format specified by
environment variables like DBFORMAT, DBMONEY, DBDATE, GL_DATE, and
GL_DATETIME. The precedence of these format specifications is consistent
with forms and reports. If there is an inconsistency, an error is
reported and the LOAD is cancelled.

The backslash symbol (`\`) serves as an escape character in the input
file to indicate that the next character in a data value is a literal.
The `LOAD` statement scans for backslash escaped elements to read
special characters in the following contexts:

- The backslash character appears anywhere in the value.
- The delimiter character appears anywhere in the value.
- The NEWLINE character appears anywhere in a value.

##### [Comma Separate Value format with LOAD]{#LOAD_CSV}

The CSV format is similar to the standard format when using a simple
comma delimiter, with the following differences:

- Input values might be surrounded with \" double quotes.
- If an input value contains a comma or a NEWLINE, it is not escaped be
  the value must be quoted in the file.
- Double-quote characters in input values are doubled and will be
  converted to a unique \" character; the value must be quoted.
- Backslash characters are not escaped in the input file and are read
  as; the value must be quoted.
- Leading and trailing blanks are kept (no truncation).
- No ending delimiter is expected at the end of the input record.

#### [Example:]{#LOAD_EXAMPLE_1}

``` linenumber
01 MAIN
02    DATABASE stores
03    BEGIN WORK
04    DELETE FROM items
05    LOAD FROM "items01.unl" INSERT INTO items
06    LOAD FROM "items02.unl" INSERT INTO items
07    COMMIT WORK
08 END MAIN
```

------------------------------------------------------------------------

### [UNLOAD]{#IO_UNLOAD}

#### Purpose:

The `UNLOAD` instruction copies data from a [current
database](Connections.html) to a file.

#### [Syntax:]{#UNLOAD_SYNTAX}

`UNLOAD TO `*`filename`*` `[`[`]{.underline}` DELIMITER `*`delimiter`*` `[`]`]{.underline}\
[`{`]{.underline}\
`  `*`select-statement`*\
[`|`]{.underline}\
`  `*`select-string`*\
[`}`]{.underline}

#### Notes:

1.  *filename* is the name of the file the data is written to.
2.  *delimiter* is the character used as the value delimiter (see
    [Usage](#UNLOAD_USAGE) for more details).
3.  *select-statement* is any kind of [Static SELECT
    statement](StaticSql.html#SS_SELECT) supported by the language.
4.  *select-string* is a program [variable](Variables.html) or a [string
    literal](Literals.html#LT_STRING) containing the `SELECT` statement
    to produce the rows. This allows you to create the `SELECT`
    statement at runtime. 

#### Warnings:

1.  You cannot use the [PREPARE](DynamicSql.html#DS_PREPARE) statement
    to preprocess an `UNLOAD` statement.
2.  When using a *select-string*, do not attempt to substitute question
    marks (`?`) in place of host variables to make the `SELECT`
    statement dynamic, because this usage has binding problems.
3.  At this time, data type description of the output file fields is
    implicit; in order to create the fetch buffers to hold the column
    values, the `UNLOAD` instruction uses the current database
    connection to get the column data types of the generated [result
    set](ResultSets.html). Those data types depend on the type of
    database server. For example, IBM Informix INTEGER columns are
    4-bytes integer values, while Oracle INTEGER data type is actually a
    NUMBER value. Therefore, you should take care when using this
    instruction; if your application connects to different kinds of
    database servers, you may get data conversion errors.

#### [Usage:]{#UNLOAD_USAGE}

The `UNLOAD` instruction serializes into a file the SQL data produced
from an SELECT statement.

The *filename* after the `TO` keyword identifies an output file in which
to store the rows retrieved from the database by the `SELECT` statement.
In the default (U.S. English) locale, this file contains only ASCII
characters. (In other locales, output from `UNLOAD` can contain
characters from the code-set of the locale.)

The `UNLOAD` statement must include a `SELECT` statement (directly, or
in a variable) to specify what rows to copy into *filenam*e. `UNLOAD`
does not delete the copied data.

A single character delimiter instruct `UNLOAD` to write data in the
[Standard BDL format](#LOAD_STANDARD). When using \"CSV\" as delimiter
specification, the `UNLOAD` instruction will write the data in [Comma
Separate Value format](#UNLOAD_CSV). If the `DELIMITER` clause is not
specified, the delimiter is defined by the
[DBDELIMITER](EnvironmentVariables.html#EV_DBDELIMITER) environment
variable. If the DBDELIMITER environment variable is not set, the
default is a \| pipe.

#### Warning: The DELIMITER cannot be backslash or any hexadecimal digit (0-9, A-F, a-f).

##### [Standard Genero BDL format with UNLOAD]{#UNLOAD_STANDARD}

A set of values in output representing a row from the database is called
an *output recor*d. A NEWLINE character (ASCII 10) terminates each
output record.

The `UNLOAD` statement represents each value in the output file as a
character string by using the [current code-set](Localization.html),
according to the declared data type of the database column:

  -------------------------------------------------------- -----------------------------------------------
  **Data Type**                                            **Output Format**

  `CHAR, VARCHAR, TEXT`                                    Trailing blanks are dropped from CHAR and TEXT
                                                           (but not from VARCHAR) values. A backslash ( \\
                                                           ) is inserted before any literal backslash or
                                                           delimiter character and before a NEWLINE
                                                           character in a character value.

  `DECIMAL, FLOAT, INTEGER, MONEY, SMALLFLOAT, SMALLINT`   Values are written as literals with no leading
                                                           blanks. MONEY values are represented with no
                                                           leading currency symbol. Zero values are
                                                           represented as 0 for INTEGER or SMALLINT
                                                           columns, and as 0.00 for FLOAT, SMALLFLOAT,
                                                           DECIMAL, and MONEY columns.

  `DATE`                                                   Values are written in the format
                                                           *month/day/year* unless some other format is
                                                           specified by the
                                                           [DBDATE](EnvironmentVariables.html#EV_DBDATE)
                                                           environment variable.

  `DATETIME`                                               DATETIME values are formatted\
                                                              *year-month-day
                                                           hour:minute:second.fraction\*
                                                           or a contiguous subset, without DATETIME
                                                           keyword or qualifiers. Time units outside the
                                                           declared precision of the database column are
                                                           omitted.

  `INTERVAL`                                               INTERVAL values are formatted\
                                                              *yea*r-*month\*
                                                           or else as\
                                                              *day hou*r:*minut*e:*secon*d.*fractio*n\
                                                           or a contiguous subset, without INTERVAL
                                                           keyword or qualifiers. Time units outside the
                                                           declared precision of the database column are
                                                           omitted.

  `BYTE`                                                   BYTE Values are written in ASCII hexadecimal
                                                           form, without any added blank or NEWLINE
                                                           characters. The logical record length of an
                                                           output file that contains BYTE values can be
                                                           very long, and thus might be very difficult to
                                                           print or to edit.
  -------------------------------------------------------- -----------------------------------------------

NULL values of any data type are represented by consecutive delimiters
in the output file, without any characters between the delimiter
symbols.

The backslash symbol (`\`) serves as an escape character in the output
file to indicate that the next character in a data value is a literal.
The `UNLOAD` statement automatically inserts a preceding backslash to
prevent literal characters from being interpreted as special characters
in the following contexts:

- The backslash character appears anywhere in the value.
- The delimiter character appears anywhere in the value.
- The NEWLINE character appears anywhere in a value.

##### [Comma Separate Value format with UNLOAD]{#UNLOAD_CSV}

The CSV format is similar to the standard format when using a simple
comma delimiter, with the following differences:

- A comma character generates a quoted output value, and the comma is
  written as is (not escaped).
- A \" double-quote character generate quoted output value and the quote
  in the value is doubled.
- NEWLINE characters generate a quoted output value, and the NEWLINE is
  written as is (not escaped).
- Backslash characters are written as is in the output value (i.e. not
  escaped).
- Leading and trailing blanks are not truncated in the output value.
- No ending delimiter is written at the end of the output record.

#### [Example:]{#UNLOAD_EXAMPLE_1}

``` linenumber
01 MAIN
02    DEFINE var INTEGER
03    DATABASE stores
04    LET var = 123
05    UNLOAD TO "items.unl" SELECT * FROM items WHERE item_num > var
06 END MAIN
```
