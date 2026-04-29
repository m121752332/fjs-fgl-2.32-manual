[Back to Contents](../index.html)

------------------------------------------------------------------------

# [User Types]{#PAGE_HEADER}

Summary:

- [Definition](#DEFINITION)
- [Examples](#EXAMPLES)

*See also:* [Variables](Variables.html), [Records](Records.html), [Data
Types](DataTypes.html), [Constants](Constants.html).

------------------------------------------------------------------------

### [Definition]{#DEFINITION}

#### Purpose:

A *user type* is a data type based on [built-in types](DataTypes.html),
[records](Records.html) or [arrays](Arrays.html).

#### Syntax:

[`[`]{.underline}`PUBLIC`[`|`]{.underline}`PRIVATE`[`]`]{.underline}` TYPE `*`type-definition`*` `[`[,...]`]{.underline}

where *type-definition* is:

` `*`identifier`*` `[`{`]{.underline}` `*`datatype`*` `[`|`]{.underline}` LIKE `[`[`]{.underline}*`dbname`*`:`[`]`]{.underline}*`tabname.colname`*` `[`}`]{.underline}

#### Notes:

1.  *identifier* is the name of the user type to be defined.
2.  *definition* is any data type, record structure, or array definition
    supported by the language.

#### Usage:

You can define a user type as a synonym for an existing data type, or as
a shortcut for records and array structures.

After declaring a user type, it can be used as a normal data type to
define [variables](Variables.html).

The scope of a user type is the same as for variables and constants.
Types can be [global](Globals.html), module-specific, or local to a
[function](Functions.html).

By default, module-specific types are private; They cannot be used by an
other module of the program. To make a module type public, add the
`PUBLIC` keyword before `TYPE`. When a module type is declared as
public, it can be referenced by another module by using the
[IMPORT](Programs.html#IMPORT) instruction.

------------------------------------------------------------------------

### [Examples]{#EXAMPLES}

#### Example 1:

``` linenumber
01 TYPE customer RECORD
02        cust_num INTEGER,
03        cust_name VARCHAR(50),
04        cust_addr VARCHAR(200)
05     END RECORD
06 DEFINE c customer
```

#### Example 2:

The following example defines a user type in first module, and then uses
the type in a report program:


    01 -- type_order.4gl
    02
    04 PUBLIC TYPE rpt_order RECORD
    05        order_num  INTEGER,
    06        store_num  INTEGER,
    07        order_date DATE,
    08        cust_num INTEGER,
    09        fac_code   CHAR(3)
    10     END RECORD


    01 -- report.4gl
    02
    03 IMPORT type_order
    04
    05 MAIN
    06   DEFINE o rpt_order  -- could be type_order.rpt_order
    07   CONNECT TO "custdemo"
    08   DECLARE order_c CURSOR FOR
    09     SELECT orders.*
    10       FROM orders ORDER BY cust_num
    11   START REPORT order_list 
    12   FOREACH order_c INTO o.*
    13     OUTPUT TO REPORT order_list(o.*)
    14   END FOREACH
    15   FINISH REPORT order_list
    16   DISCONNECT CURRENT
    17 END MAIN 
    18
    19 REPORT order_list(ro)
    20   DEFINE ro rpt_order
    21   FORMAT
    22     ON EVERY ROW
    23      PRINT ro.order_num, ...
    ...
