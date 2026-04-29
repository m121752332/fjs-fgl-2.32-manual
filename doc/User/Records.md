[Back to Contents](../index.html)

------------------------------------------------------------------------

# [Records]{#PAGE_HEADER}

Summary:

- [Definition](#DEFINITION)
- [Examples](#EXAMPLES)

*See also:* [Variables](Variables.html), [Arrays](Arrays.html), [Data
Types](DataTypes.html), [Database Schema File](DatabaseSchema.html).

------------------------------------------------------------------------

### [Definition]{#DEFINITION}

#### Purpose:

A *record* defines a structured variable.

#### [Syntax]{#RECORD} 1:

`DEFINE `*`variable`*` RECORD`\
`  `*`member`*` `[`{`]{.underline}` `*`datatype`*` `[`|`]{.underline}` LIKE `[`[`]{.underline}*`dbname`*`:`[`]`]{.underline}*`tabname`*`.`*`colname`*` `[`}`]{.underline}\
`  `[`[,...]`\]{.underline}
` END RECORD`

#### Syntax 2:

`DEFINE `*`variable`*` RECORD LIKE `[`[`]{.underline}*`dbname`*`:`[`]`]{.underline}*`tabname`*`.*`

#### Notes:

1.  *variable* defines the name of the record, it can be a single
    variable or an [array](Arrays.html) definition.
2.  *member* is an identifier for a record member variable.
3.  *datatype* can be any [data type](DataTypes.html), a record
    definition, or an [array definition](Arrays.html).
4.  *dbname* identifies a specific [database schema
    file](DatabaseSchema.html).
5.  *tabname* identifies a database table defined in the [database
    schema file](DatabaseSchema.html).
6.  *colname* identifies a database column defined in the [database
    schema file](DatabaseSchema.html).

#### Usage:

A record is an ordered set of variables (called members), where each
member can be of any [data type](DataTypes.html), a record, or an
[array](Arrays.html). Records whose members correspond in number, order,
and data type compatibility to a database table can be useful for
transferring data from the database to the screen, to reports, or to
functions.

In the first form (Syntax 1), record members are defined explicitly. In
the second form (Syntax 2), record members are created implicitly from
the table definition in the [database schema file](DatabaseSchema.html).
The database columns defined as ` SERIAL` will define an
[INTEGER](DataTypes.html#DT_INTEGER) variable, while `SERIAL8/BIGSERIAL`
columns define [BIGINT](DataTypes.html#DT_BIGINT) variables.

**Warning: When using the ` LIKE` clause, the data types are taken from
the [database schema file](DatabaseSchema.html) during compilation. Make
sure that the database schema file of the [development
database](FglTerms.html#DEVELOPMENT_DATABASE) corresponds to the
[production database](FglTerms.html#PRODUCTION_DATABASE), otherwise the
records defined in the compiled version of your programs will not match
the table structures of the production database. Statements like
`SELECT * INTO record.* FROM table` would fail.**

In the rest of the program, record members are accessed by a dot
notation (`record.member`). The notation `record.member` refers to an
individual member of a record. The notation `record.*` refers to the
entire list of record members. The notation
`record.first THRU record.last` refers to a consecutive set of members.
(`THROUGH` is a synonym for `THRU`).

Records can be passed as [function](Functions.html) parameters, and can
be returned from functions. However, when passing records to functions,
you must keep in mind that the record is expanded as if each individual
member would have been passed as parameter. See [BDL
Stack](Functions.html#FGL_STACK) for more details.

It is possible to compare records having the same structure with the
equal operator: `record1.* = record2.*`

------------------------------------------------------------------------

### [Examples]{#EXAMPLES}

#### Example 1:

``` linenumber
01 MAIN
02   DEFINE rec RECORD
03               id INTEGER,
04               name VARCHAR(100),
05               birth DATE
06             END RECORD
07   LET rec.id = 50
08   LET rec.name = 'Scott'
09   LET rec.birth = TODAY
10   DISPLAY rec.*
11 END MAIN
```

#### Example 2:

``` linenumber
01 SCHEMA stores
02 DEFINE cust RECORD LIKE customer.*
03 MAIN
04   SELECT * INTO cust.* FROM customer WHERE customer_num=2
05   DISPLAY cust.*
06 END MAIN
```
