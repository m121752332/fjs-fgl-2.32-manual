[Back to Contents](../index.html)

------------------------------------------------------------------------

# [Literals]{#PAGE_HEADER}

Summary:

- [Integer Literals](#LT_INTEGER)
- [Decimal Literals](#LT_DECIMAL)
- [String Literals](#LT_STRING)
- [Datetime Literals](#LT_DATETIME)
- [Interval Literals](#LT_INTERVAL)

*See also:* [Variables](Variables.html), [Data Types](DataTypes.html),
[Expressions](Expressions.html).

------------------------------------------------------------------------

### [INTEGER LITERALS]{#LT_INTEGER}

#### Purpose:

The language supports integer literals in base-10 notation, without
blank spaces and commas and without a decimal point.

#### Syntax:

` `[`[`]{.underline}`+`[`|`]{.underline}`-`[`]`]{.underline}` `*`digit`*[`[...]`]{.underline}

#### Notes:

1.  *digit* is a digit character from \'0\' to \'9\'.

#### Warnings:

1.  Integer literals are limited to the ranges of an
    [INTEGER](DataTypes.html#DT_INTEGER) value. 

#### Example:

``` linenumber
01 MAIN
02   DEFINE n INTEGER 
03   LET n = 1234567
04 END MAIN
```

------------------------------------------------------------------------

### [DECIMAL LITERALS]{#LT_DECIMAL}

#### Purpose:

The language supports decimal literals as a base-10 representation of a
real number, with an optional exponent notation.

#### Syntax:

[`[`]{.underline}`+`[`|`]{.underline}`-`[`]`]{.underline}` `*`digit`*[`[...]`]{.underline}` `*`dot`*` `*`digit`*[`[...]`]{.underline}` `[`[`]{.underline}` `[`{`]{.underline}`e`[`|`]{.underline}`E`[`}`]{.underline}` `[`[`]{.underline}`+`[`|`]{.underline}`-`[`]`]{.underline}` `*`digit`*[`[...]`]{.underline}` `[`]`]{.underline}

#### Notes:

1.  *dot* is the decimal separator and is always a dot, independently
    from DBMONEY.
2.  The E character is used to specify the exponent. 

#### Example:

``` linenumber
01 MAIN
02   DEFINE n DECIMAL(10,2)
03   LET n = 12345.67
04   LET n = -1.2356e-10
05 END MAIN
```

------------------------------------------------------------------------

### [STRING LITERALS]{#LT_STRING}

#### Purpose:

The language supports string literals delimited by single quotes or
double quotes.

#### Syntax 1 (using double quotes):

`" `*`alphanum`*` `[`[...]`]{.underline}` "`

#### Syntax 2 (using single quotes):

`' `*`alphanum`*` `[`[...]`]{.underline}` '`

#### Notes:

1.  A string literal defines a character string constant, following the
    current character set.
2.  A string literal can be written on multiple lines, the compiler
    merges lines by removing the new-line character.
3.  The escape character is the back-slash character (`\`).
4.  Quotes can be doubled to be included in strings.

#### Warnings:

1.  An empty string (\"\") is equivalent to
    [NULL](Programs.html#PC_NULL).

#### Escape Sequences in string literals

A string literal can hold the following escape sequences:

1.  `\\` is a backslash character.
2.  `\"` is a double-quote character.
3.  `\'` is a single-quote character.
4.  `\n` is a new-line character.
5.  `\r` is a carriage-return character.
6.  `\0` is a null character.
7.  `\f` is a form-feed character.
8.  `\t` is a tab character.
9.  `\xNN` is a character defined by the hexadecimal code **NN**.

#### Example:

``` linenumber
01 MAIN
02   DISPLAY "Some text in double quotes"
03   DISPLAY 'Some text in single quotes'
04   DISPLAY "Escaped double quotes :  \"  ""  "
05   DISPLAY 'Escaped single quotes :  \'  ''  '
06   DISPLAY 'Insert a new-line character here: \n and continue with text.'
07   DISPLAY "This is a text
08    on multiple
09    lines.\
10    You can insert a new-line with back-slash at the end of the line."
11   IF "" IS NULL THEN DISPLAY 'Empty string is NULL' END IF
12 END MAIN
```

------------------------------------------------------------------------

### [DATETIME LITERALS]{#LT_DATETIME}

#### Purpose:

The language supports datetime literals with the DATETIME () notation.

#### Syntax:

` DATETIME ( `*`dtrep`*` ) `*`qual1`*` TO `*`qual2`*[`[`]{.underline}`(`*`scale`*`)`[`]`]{.underline}

#### Notes:

1.  *dtrep* is the datetime value representation in normalized format
    (YYYY-MM-DD hh:mm:ss.fffff).
2.  *qual1* and *qual2* are the datetime qualifiers as described in the
    [Datetime data type](DataTypes.html#DT_DATETIME).

#### Example:

``` linenumber
01 MAIN
02   DEFINE d1 DATETIME YEAR TO SECOND
03   DEFINE d2 DATETIME HOUR TO FRACTION(5)
04   LET d1 = DATETIME ( 2002-12-24 23:55:56 ) YEAR TO SECOND
05   LET d2 = DATETIME ( 23:44:55.34532 ) HOUR TO FRACTION(5)
06 END MAIN
```

------------------------------------------------------------------------

### [INTERVAL LITERALS]{#LT_INTERVAL}

#### Purpose:

The language supports interval literals with the INTERVAL() notation.

#### Syntax:

` INTERVAL ( `*`inrep`*` ) `*`qual1`*[`[`]{.underline}`(`*`precision`*`)`[`]`]{.underline}` TO `*`qual2`*[`[`]{.underline}`(`*`scale`*`)`[`]`]{.underline}

#### Notes:

1.  *inrep* is the interval value representation in normalized format
    (YYYY-MM or DD hh:mm:ss.fffff).
2.  *qual1* and *qual2* are the interval qualifiers as described in the
    [Interval data type](DataTypes.html#DT_INTERVAL)..

#### Example:

``` linenumber
01 MAIN
02   DEFINE i1 INTERVAL YEAR TO MONTH
03   DEFINE i2 INTERVAL HOUR(5) TO SECOND
04   LET i1 = INTERVAL ( 345-5 ) YEAR TO MONTH
05   LET i2 = INTERVAL ( 34562:12:33 ) HOUR(5) TO SECOND
06 END MAIN
```
