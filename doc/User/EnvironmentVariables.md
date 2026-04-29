[Back to Contents](../index.html)

------------------------------------------------------------------------

# [Environment Variables]{#PAGE_HEADER}

Summary:

- [Setting Environment Variables on UNIX](#SETTING_ON_UNIX)
- [Setting Environment Variables on Windows](#SETTING_ON_WINDOWS)
- [Operating System Environment Variables](#EV_OPSYS)
  - [PATH](#EV_PATH)
  - [LD_LIBRARY_PATH](#EV_LD_LIBRARY_PATH)
  - [LC_ALL](#EV_LC_ALL)
  - [TERM](#EV_TERM)
  - [TERMCAP](#EV_TERMCAP)
  - [TMPDIR, TEMP, TMP](#EV_TMPDIR)
- [Database Client Environment Variables](#EV_DBCLI)
- [Genero BDL Environment Variables](#EV_FGL)
  - [DBDATE](#EV_DBDATE)
  - [DBCENTURY](#EV_DBCENTURY)
  - [DBDELIMITER](#EV_DBDELIMITER)
  - [DBEDIT](#EV_DBEDIT)
  - [DBFORMAT](#EV_DBFORMAT)
  - [DBMONEY](#EV_DBMONEY)
  - [DBPATH](#EV_DBPATH)
  - [DBPRINT](#EV_DBPRINT)
  - [DBSCREENDUMP](#EV_DBSCREENDUMP)
  - [DBSCREENOUT](#EV_DBSCREENOUT)
  - [DBTEMP](#EV_DBTEMP)
  - [FGLDBPATH](#EV_FGLDBPATH)
  - [FGLDIR](#EV_FGLDIR)
  - [FGLIMAGEPATH](#EV_FGLIMAGEPATH)
  - [FGLLDPATH](#EV_FGLLDPATH)
  - [FGLGUI](#EV_FGLGUI)
  - [FGLGUIDEBUG](#EV_FGLGUIDEBUG)
  - [FGLPROFILE](#EV_FGLPROFILE)
  - [FGLRESOURCEPATH](#EV_FGLRESOURCEPATH)
  - [FGLSERVER](#EV_FGLSERVER)
  - [FGLSOURCEPATH](#EV_FGLSOURCEPATH)
  - [FGLSQLDEBUG](#EV_FGLSQLDEBUG)
  - [FGLWRTUMASK](#EV_FGLWRTUMASK)

*See also:* [Tools](Tools.html), [Localization
Support](Localization.html), [Connections](Connections.html),
[Installation and Setup](Installation.html)

------------------------------------------------------------------------

## [Setting Environment Variables on UNIX]{#SETTING_ON_UNIX}

On UNIX platforms, environment variables can be set through the
following methods, depending on to the command interpreter used:

Bourne shell:

`  VAR=`*`value`*`; export VAR`

Korn shell:

`  export VAR=`*`value`*

C shell:

`  setenv VAR=`*`value`*

For more details, refer to the documentation for your UNIX system.

------------------------------------------------------------------------

## [Setting Environment Variables on Windows]{#SETTING_ON_WINDOWS}

On Windows platforms, environment variables can be set by one of the
following methods:

- In a command window, with the SET command.
- In the registry, for the current user in `HKEY_CURRENT_USER` or a
  global setting in `HKEY_LOCAL_MACHINE`.

For more details, refer to the documentation of your Windows system.

#### Warnings:

1.  When using Informix, some variables related to the database engine
    must be set using the SETNET32 utility.
2.  On Windows, double quotes do not have the same meaning as on UNIX
    systems. For example, if you set a variable with the command
    `SET VAR="abc"`, the value of the variable will be `"abc"` (with
    double quotes), and not `abc`.

------------------------------------------------------------------------

## [Operating System Environment Variables]{#EV_OPSYS}

This section describes a couple of well-known system environment
variables that are used by Genero software components.

------------------------------------------------------------------------

### [PATH]{#EV_PATH}

#### Purpose:

This variable defines the list of search paths for executables files.

#### Notes:

1.  On Unix platforms, **PATH** defines the search path list for
    executable programs.
2.  On Windows platforms, **PATH** defines the search path for programs
    and DLLs.
3.  The path separator is a colon (`:`) on UNIX and a semicolon `(;)` on
    Windows.

------------------------------------------------------------------------

### [LD_LIBRARY_PATH]{#EV_LD_LIBRARY_PATH}

#### Purpose:

This variable defines the list of search paths for shared libraries
loaded by the *dynamic linker* on Unix platforms.

#### Notes:

1.  On some operating systems, the environment variable defining the
    shared library search path may have a different name. For example,
    on a system where a 32b and a 64b environment coexist, you may need
    to set LD_LIBRARY_PATH_64 to execute the 64b programs. On HP/UX, you
    must set SHLIB_PATH. On AIX, use LIBPATH. On Mac OS/X, use
    DYLD_LIBRARY_PATH.

------------------------------------------------------------------------

### [LC_ALL]{#EV_LC_ALL}

#### Purpose:

This variable defines the locale (language, territory and code-set) for
Unix programs.

#### Notes:

1.  This variable is used by the runtime system to handle character
    strings. It is important to set this variable properly according to
    the character set used by your application.
2.  If LC_ALL is not defined, LANG is used instead.
3.  Read the Unix manual of the setlocale C function for more details
    about this variable. See also the [Localization](Localization.html)
    page.

------------------------------------------------------------------------

### [TERM]{#EV_TERM}

#### Purpose:

This variable defines terminal type (vt100, xterm, xtermix) for terminal
capabilities.

#### Notes:

1.  The **TERM** variable is used by UNIX and Genero applications to
    identify the terminal type when running in
    [TUI](FglTerms.html#TEXT_USER_INTERFACE) mode.
2.  Genero reads terminal capabilities from the file defined by the
    [TERMCAP](#EV_TERMCAP) environment variable.\
    Note that recent applications use the TERMINFO database for terminal
    capabilities.

#### Warnings:

1.  It is important to define this variable properly to match the text
    terminal hardware or the terminal emulation you are using.

------------------------------------------------------------------------

### [TERMCAP]{#EV_TERMCAP}

#### Purpose:

This variable defines the terminal capabilities file to be used with
[TERM](#EV_TERM).

#### Notes:

1.  The **TERMCAP** environment variable points to the terminal
    capabilities file.
2.  The default with Genero is \$FGLDIR/etc/termcap.
3.  You can define additional terminal in this file.

#### Warnings:

1.  It is important to define terminal capabilities properly according
    to the text terminal hardware or the terminal emulation you are
    using.\
    Especially function keys (F1, F16) and display attributes (bold,
    reverse, colors) may not work if the escape sequences do not
    correspond to the terminal used.

For more details about terminal capability configuration, see [Dynamic
User Interface](DynamicUI.html).

------------------------------------------------------------------------

### [TMPDIR, TEMP, TMP]{#EV_TMPDIR}

#### Purpose:

Those environment variables define the directory for temporary files.

#### Notes:

1.  **TMPDIR** and **TMP** are mainly used on Unix platforms, **TEMP**
    and **TMP** are used on Windows.
2.  You should use [DBTEMP](#EV_DBTEMP) to define the temp file
    directory for Genero files.

------------------------------------------------------------------------

## [Database Client Environment Variables]{#EV_DBCLI}

If your Genero programs connect to a database server, you will probably
have to set database vendor specific environment variables (or registry
settings on Windows platforms). You must for example set INFORMIXDIR for
an Informix client, ORACLE_HOME for Oracle, etc. Read carefully the
database client software documentation. You get also some details in the
[Database Connections](Connections.html#DBCENV) page of this
documentation.

------------------------------------------------------------------------

## [Genero Environment Variables]{#EV_FGL}

This section lists and describes in detail all Genero specific
environment variables.

------------------------------------------------------------------------

### [DBDATE]{#EV_DBDATE}

#### Purpose:

Defines the default display format for [DATE](DataTypes.html#DT_DATE)
values and the default picture for automatic string-to-DATE conversions.

#### Values:

Values can be a restricted combination of several symbols described in
the following table:

::: {align="center"}
  ------------ ----------------------------------------------------
  **Symbol**   **Meaning in DBDATE format string**
  `D`          Day of month as one or two digits
  `M`          Month as one or two digits
  `Y2`         Year as two digits
  `Y3`         Year as three digits *(Ming Guo format only)*
  `Y4`         Year as four digits
  `/`          Default time-unit separator for the default locale
  `C1`         Ming Guo format modifier (years as digits)
  `-`          Minus time-unit separator
  `,`          Coma time-unit separator
  `.`          Period time-unit separator
  `0`          Indicates no time-unit separator
  ------------ ----------------------------------------------------
:::

The combinations must follow a specific order:

`  `[`{`]{.underline}` DM `[`|`]{.underline}` MD `[`}`]{.underline}` `[`{`]{.underline}` Y2 `[`|`]{.underline}` Y3 `[`|`]{.underline}` Y4 `[`}`]{.underline}` `[`{`]{.underline}` / `[`|`]{.underline}` - `[`|`]{.underline}` , `[`|`]{.underline}` . `[`|`]{.underline}` 0 `[`}`]{.underline}` `[`[`]{.underline}`C1`[`]`\]{.underline}
`  `[`{`]{.underline}` Y2 `[`|`]{.underline}` Y3 `[`|`]{.underline}` Y4 `[`}`]{.underline}` `[`{`]{.underline}` DM `[`|`]{.underline}` MD `[`}`]{.underline}` `[`{`]{.underline}` / `[`|`]{.underline}` - `[`|`]{.underline}` , `[`|`]{.underline}` . `[`|`]{.underline}` 0 `[`}`]{.underline}` `[`[`]{.underline}`C1`[`]`]{.underline}

#### Usage:

**DBDATE** defines the order of the *month*, *day*, and *year* time
units within a date, whether the *year* is printed with two digits (Y2),
three (Y3+C1) or four digits (Y4) and the time-unit separator between
the *month*, *da*y, and *year.*

In programs, when you assign a string representing a date to a variable
defined with the [DATE](DataTypes.html#DT_DATE) data type, automatic
string-to-DATE conversion takes place based on the **DBDATE**
definition.

In the default locale, the default setting for **DBDATE** is `DMY4/`.

The C1 modifier can be used at the end of the DBDATE value in order to
use [MingGuo](Localization.html#MING_GUO) date format with digit-based
years. When using C1, you can use one of the Y4, Y3 or Y2 symbols for
the year.

Date formatting specified in a [USING](Operators.html#OP_USING) clause
or FORMAT attribute overrides the formatting specified in **DBDATE**.

#### Example:

Gregorian date format:

`DBDATE="DMY4/"`\
`export DBDATE`

Migng Guo date format:

`DBDATE="Y3MD/C1"`\
`export DBDATE`

------------------------------------------------------------------------

### [DBDELIMITER]{#EV_DBDELIMITER}

#### Purpose:

The **DBDELIMITER** environment variable defines the value delimiter for
[LOAD and UNLOAD instructions](InOutSql.html).

#### Usage:

If **DBDELIMITER** is not defined, the default delimiter is a (`|`)
pipe.

#### Warnings:

1.  Do not use backslash or hex digits (0-9, A-F, a-f).

#### Example:

`DBDELIMITER="@"`\
`export DBDELIMITER`

------------------------------------------------------------------------

### [DBCENTURY]{#EV_DBCENTURY}

#### Purpose:

The **DBCENTURY** environment variable specifies how to expand
abbreviated one- and two-digit *year* specifications within DATE and
DATETIME values.

#### Values:

::: {align="center"}
  ------------ -------------------------------------------------------------------------
  **Symbol**   **Algorithm for Expanding Abbreviated Years**
  `C`          Use the past, future, or current year closest to the current date.
  `F`          Use the nearest year in the future to expand the entered value.
  `P`          Use the nearest year in the past to expand the entered value.
  `R`          Prefix the entered value with the first two digits of the current year.
  ------------ -------------------------------------------------------------------------
:::

#### Usage:

Default value is \"R\" (prefix the entered value with the first two
digits of the current year).

Values are case sensitive; only the four uppercase letters are valid.

Three-digit years are not expanded.

If a year is entered as a single digit, it is first expanded to two
digits by prefixing it with a zero; **DBCENTURY** then expands this
value to four digits.

Years before 99 AD (or CE) require leading zeros (to avoid expansion).

#### Warnings:

1.  If the database server and the client system have different settings
    for DBCENTURY, the client system setting takes precedence for
    abbreviations of years in dates entered through the application.
    Expansion is sensitive to the time of execution and to the accuracy
    of the system clock-calendar. You can avoid the need to rely on
    DBCENTURY by requiring the user to enter four-digit years or by
    setting the CENTURY attribute in the form specification of DATE and
    DATETIME fields.

------------------------------------------------------------------------

### [DBEDIT]{#EV_DBEDIT}

#### Purpose:

The **DBEDIT** environment variable defines the editor program to be
used for [TEXT](DataTypes.html#DT_TEXT) fields.

------------------------------------------------------------------------

### [DBFORMAT]{#EV_DBFORMAT}

#### Purpose:

The **DBFORMAT** environment variable defines the input and display
format for numeric values.

See also [DBMONEY](#EV_DBMONEY).

#### Syntax:

*`front`*`:`*`thousands`*`:`*`decimal`*`:`*`back`*

#### Notes:

1.  *front* is the leading currency symbol, can be an asterisk ( \* ).
2.  *throusands* is a character that you specify as a valid thousands
    separator, can be an asterisk ( \* ).
3.  *decimal* is a character that you specify as a valid decimal
    separator.
4.  *back* is the trailing currency symbol, can be an asterisk ( \* ).

#### Usage:

The DBFORMAT environment variable can be set to define the input and
display format for values of the following types:

- [MONEY](DataTypes.html#DT_MONEY) (thousands separator, decimal
  separator and currency symbol)
- [DECIMAL](DataTypes.html#DT_DECIMAL) (thousands separator, decimal
  separator)
- [SMALLFLOAT](DataTypes.html#DT_SMALLFLOAT) (thousands separator,
  decimal separator)
- [FLOAT](DataTypes.html#DT_FLOAT) (thousands separator, decimal
  separator)
- [SMALLINT](DataTypes.html#DT_SMALLINT) (thousands separator)
- [INTEGER](DataTypes.html#DT_INTEGER) (thousands separator)
- [BIGINT](DataTypes.html#DT_BIGINT) (thousands separator)

DBFORMAT can specify the leading and trailing currency symbols (but not
their default positions within a monetary value) and the decimal and
thousands separators. The decimal and thousands separators defined by
DBFORMAT apply to both monetary and other numeric data.

BDL instructions affected by the setting in DBFORMAT include (but are
not restricted to) the following items:

- [USING](Operators.html#OP_USING) operator.
- [FORMAT](FSFAttributes.html#FA_FORMAT) field attribute.
- [DISPLAY](RecordDisplay.html) or [PRINT](Reports.html) statement
  (default formatting of numeric values).
- [LET](Variables.html#VA_LET) statement, where a
  [CHAR](DataTypes.html#DT_CHAR), [VARCHAR](DataTypes.html#DT_VARCHAR)
  or [STRING](DataTypes.html#DT_STRING) variable is assigned a monetary
  or number value.
- [LOAD](InOutSql.html#IO_LOAD) and [UNLOAD](InOutSql.html#IO_LOAD)
  statements that use ASCII files (or whatever the locale regards as a
  *flat* file) to pass data to or from the database.

The asterisk ( \* ) specifies that a symbol or separator is not
applicable; it is the default for any *fron*t, *thousand*s, or *back*
term that you do not define.

If you specify more than one character for *decimal* or *thousand*s, the
values in the *decimal* or *thousands* list cannot be separated by
spaces (nor by any other symbols). BDL uses the first value specified as
the thousands or decimal separator when displaying the number or
currency value in output. The user can include any of the decimal or
thousands separators when entering values.

Any printable character that your locale supports is valid for the
thousands separator or for the decimal separator, except:

- Digits (0, 1, 2, 3, 4, 5, 6, 7, 8, 9)
- \<, \>, \|, ?, !, =, \[, \]

The same character cannot be both the thousands and decimal separator. A
blank space (ASCII 32) can be the thousands separator (and is
conventionally used for this purpose in some locales). The asterisk ( \*
) symbol is valid as the decimal separator, but is not valid as the
thousands separator.

The colon ( : ) symbol is supported as *thousands* or *decimal*
separator but must be preceded by a backslash ( \\ ) symbol, as in the
specification `:\::.:DM`. .

You must include all three colons. Enclosing the DBFORMAT specification
in a pair of single quotation marks is recommended to prevent the shell
from attempting to interpret (or execute) any of the DBFORMAT
characters.

The setting in DBFORMAT affects how formatting masks of the
[FORMAT](FSFAttributes.html#FA_FORMAT) attribute and
[USING](Operators.html#OP_USING) operator are interpreted. In formatting
masks of [FORMAT](FSFAttributes.html#FA_FORMAT) and
[USING](Operators.html#OP_USING), the following symbols are not literal
characters but are placeholders for what DBFORMAT specifies:

- The dollar (\$) sign is a placeholder for the *front* currency symbol.
- The comma (,) is a placeholder for the thousands separator.
- The period (.) is a placeholder for the decimal separator.
- The at (@) sign is a placeholder for the *back* currency symbol.

The following table illustrates the results of different combinations of
DBFORMAT setting and format string on the same value.

  ----------- ------------------- -------------- --------------
  **Value**   **Format String**   **DBFORMAT**   **Result**
  `1234.56`   `$#,###.##`         `$:,:.:`       `$1,234.56`
  `1234.56`   `$#,###.##`         `:.:,:DM`      `1.234,56`
  `1234.56`   `#,###.##@`         `$:,:.:`       `1,234.56`
  `1234.56`   `#,###.##@`         `:.:,:DM`      `1.234,56DM`
  ----------- ------------------- -------------- --------------

When the user enters numeric or currency values in fields, the runtime
system behaves as follows:

- If a symbol is entered that was defined as a decimal separator in
  [DBFORMAT](EnvironmentVariables.html#EV_DBFORMAT), it is interpreted
  as the decimal separator.
- For [MONEY](DataTypes.html#DT_MONEY) fields, it disregards any *front*
  (leading) or *back* (trailing) currency symbol and any thousands
  separators that the user enters.
- For [DECIMAL](DataTypes.html#DT_DECIMAL) fields, the user must enter
  values without currency symbols.

When the runtime system displays or prints values:

- The DBFORMAT-defined leading or trailing currency symbol is displayed
  for [MONEY](DataTypes.html#DT_MONEY) values.
- If a leading or trailing currency symbol is specified by the
  [FORMAT](FSFAttributes.html#FA_FORMAT) attribute for non-MONEY data
  types, the symbol is displayed.
- The thousands separator is not displayed unless it is included in a
  formatting mask of the [FORMAT](FSFAttributes.html#FA_FORMAT)
  attribute or of the [USING](Operators.html#OP_USING) operator.

When [MONEY](DataTypes.html#DT_MONEY) values are converted to character
strings by the [LET](Variables.html#VA_LET) statement, both automatic
data type conversion and explicit conversion with a
[USING](Operators.html#OP_USING) clause insert the DBFORMAT-defined
separators and currency symbol into the converted strings.

For example, suppose DBFORMAT is set as follows:

`*:.:,:DM`

The value 1234.56 will print or display as follows:

`1234,56DM`

Here DM stands for deutsche marks. Values input by the user into a
screen form are expected to contain commas, not periods, as their
decimal separator because DBFORMAT has `*:.:,:DM` as its setting in this
example.

When using a graphical front-end, the decimal separator of the numeric
keypad will produce the character defined by this environment variable.

------------------------------------------------------------------------

### [DBMONEY]{#EV_DBMONEY}

#### Purpose:

The **DBMONEY** environment variable defines the currency symbol and the
decimal separator for numeric values.

See also [DBFORMAT](#EV_DBFORMAT).

#### Syntax:

*`front`*[`{`]{.underline}`.`[`|`]{.underline}`,`[`}`]{.underline}*`back`*

#### Notes:

1.  *front* is a character string representing a leading currency symbol
    that precedes the value.
2.  *back* is a character string representing a trailing currency symbol
    that follows the value.
3.  The currency symbol can be up to seven characters long and can
    contain any character except a comma or a period.
4.  The currency symbol can be non-ASCII characters if your [current
    locale](Localization.html) supports a code set that defines the
    non-ASCII characters you use.

#### Usage:

The DBMONEY environment variable can be set to define the input and
display format for values of the following types:

- [MONEY](DataTypes.html#DT_MONEY) (thousands separator, decimal
  separator and currency symbol)
- [DECIMAL](DataTypes.html#DT_DECIMAL) (thousands separator, decimal
  separator)
- [SMALLFLOAT](DataTypes.html#DT_SMALLFLOAT) (thousands separator,
  decimal separator)
- [FLOAT](DataTypes.html#DT_FLOAT) (thousands separator, decimal
  separator)
- [SMALLINT](DataTypes.html#DT_SMALLINT) (thousands separator)
- [INTEGER](DataTypes.html#DT_INTEGER) (thousands separator)
- [BIGINT](DataTypes.html#DT_BIGINT) (thousands separator)

Numeric values will be displayed in forms and reports according to this
environment variable.

DBMONEY will also be used for implicit [data
conversion](DataConversions.html) between numeric values and character
strings.

DBMONEY can only define the currency symbol and decimal separator
characters must be specified in this environment variable. If you want
to define the thousands separator, use the [DBFORMAT](#EV_DBFORMAT)
environment variable instead. However, if only DBMONEY is used, an
implicit thousands separator is selected.

The position of the currency symbol (relative to the decimal separator)
indicates whether the currency symbol appears before or after the
[MONEY](DataTypes.html#DT_MONEY) value. When the currency symbol is
positioned in DBMONEY [before]{.underline} the decimal separator, it is
displayed before the value (\$1234.56). When it is positioned
[after]{.underline} the decimal separator, it is displayed after the
value (1234.56F).

The runtime system recognizes the period ( . ) and the comma ( , ) as
decimal separators. All other characters are considered to be part of
the currency symbol. For example, \", FR\" defines a MONEY format with
the comma as decimal separator and the string \" FR\" (including the
space) as the currency symbol.

The default value for DBMONEY is \"\$.\", defining the currency symbol
as the dollar sign ( \$ ) and the decimal separator as the period ( . ).

Because only its position within a DBMONEY setting indicates whether a
symbol is the *front* or *back* currency symbol, the decimal separator
is required. If you use DBMONEY to specify a *back* symbol, for example,
you must supply a decimal separator (a comma or period). Similarly, if
you use DBMONEY to change the decimal separator from a period to a
comma, you must also supply a currency symbol.

To avoid ambiguity in displayed numbers and currency values, do not use
the thousands separator of [DBFORMAT](#EV_DBFORMAT) as the decimal
separator of DBMONEY. For example, specifying comma as the DBFORMAT
thousands separator dictates using the period as the DBMONEY decimal
separator.

When using a graphical front-end, the decimal separator of the numeric
keypad will produce the character defined by this environment variable.

#### Example:

`DBMONEY="$."`\
`export DBMONEY`\
`DBMONEY=",F"`\
`export DBMONEY`

------------------------------------------------------------------------

### [DBPATH]{#EV_DBPATH}

#### Purpose:

The **DBPATH** environment variable defines the paths to search for
program resource files.

#### Usage:

The **DBPATH** environment variable contains the search paths for the
following type of files:

1.  Form files loaded by [OPEN FORM](WindowsAndForms.html#OPEN_FORM),
2.  Message files used by [OPTIONS HELP
    FILE](Programs.html#PROGRAM_OPTIONS),
3.  [Action Defaults](ActionDefaults.html) files,
4.  [Presentation Styles](PresentationStyles.html) files,
5.  [Start Menu](StartMenus.html) files,
6.  [Toolbar](Toolbars.html) files,
7.  [TopMenu](Topmenus.html) files,
8.  [Localized strings](LocalizedStrings.html) files.

If **DBPATH** is not defined, the default is the current directory.

You can provide a list of paths, separated by the operating system
specific path separator.

#### Warnings:

1.  The path separator is platform specific ( **\":\"** on UNIX
    platforms and **\";\"** on Windows platforms).
2.  If [FGLRESOURCEPATH](#EV_FGLRESOURCEPATH) is defined, **DBPATH** is
    ignored by the runtime system and **FGLRESOURCEPATH** is used
    instead.

#### Examples:

Unix example:

`DBPATH="/user/forms1:/user/forms2:/usr/strings/french"`\
`export DBPATH`

Windows example:

`set DBPATH=C:\user\forms1;C:\user\forms2;C:\usr\strings\french`

See also: [FGLRESOURCEPATH](#EV_FGLRESOURCEPATH).

------------------------------------------------------------------------

### [DBPRINT]{#EV_DBPRINT}

#### Purpose:

The **DBPRINT** environment variable specifies the print device to be
used by [reports](Reports.html) defined `TO PRINTER`.

#### Usage:

On UNIX systems, the **DBPRINT** environment variable typically contains
the printer queue command (such as **lp**).

To have the DVM print to the printer on the client running the Genero
Desktop Client (GDC), set `DBPRINT=FGLSERVER`.

#### Example (UNIX):

`DBPRINT="lpr"`\
`export DBPRINT`

#### Example (Client):

`DBPRINT=FGLSERVER`\
`export DBPRINT`

------------------------------------------------------------------------

### [DBSCREENDUMP]{#EV_DBSCREENDUMP}

#### Purpose:

The **DBSCREENDUMP** environment variable defines the output file name
for text screen shots when pressing CONTROL-P.

#### Usage:

When using the TUI mode, if the user pressed the CONTROL-P key, the
runtime system will dump the current screen into the file defined by
this variable. Unlike [DBSCREENOUT](#EV_DBSCREENOUT), the output of
**DBSCREENDUMP** includes the escape sequences of TTY attributes, which
makes it less readable.

------------------------------------------------------------------------

### [DBSCREENOUT]{#EV_DBSCREENOUT}

#### Purpose:

The **DBSCREENOUT** environment variable defines the output file name
for text screen shots when pressing CONTROL-P.

#### Usage:

When using the TUI mode, if the user pressed the CONTROL-P key, the
runtime system will dump the current screen into the file defined by
this variable. Unlike [DBSCREENDUMP](#EV_DBSCREENDUMP), the output of
**DBSCREENOUT** excludes the escape sequences of TTY attributes.

------------------------------------------------------------------------

### [DBTEMP]{#EV_DBTEMP}

#### Purpose:

The **DBTEMP** environment variable defines the directory for temporary
files.

#### Usage:

This environment variable is use to create temporary files for:

1.  [TEXT](DataTypes.html#DT_TEXT) or [BYTE](DataTypes.html#DT_BYTE)
    data located in a temporary file (LOCATE IN FILE without file name
    specification).
2.  Temporary files of emulated scrollable cursors. See for example
    [Oracle scrollable cursors](odiagora.html#ODIORA057).

------------------------------------------------------------------------

### [FGLDIR]{#EV_FGLDIR}

#### Purpose:

The **FGLDIR** environment variable defines the Genero BDL software
installation directory.

#### Warnings:

1.  The **FGLDIR** environment variable must be set in order to use the
    product components.

------------------------------------------------------------------------

### [FGLIMAGEPATH]{#EV_FGLIMAGEPATH}

#### Purpose:

The **FGLIMAGEPATH** environment variable defines the search paths to
find images for the front-end.

#### Usage:

When the front-end needs to display an image which is specified with a
simple file name (not an URL), the front end first looks for local image
files on the user workstation. If the image file is not found locally,
the front-end sends an image request to the runtime system, which
provides the image from the server file-system.

You define the search path for images with the **FGLIMAGEPATH**
environment variable.

By default, the image directory is the current directory where the
program was started.

You can provide a list of paths, separated by the operating system
specific path separator.

The runtime system searches for image files in the locations described
below. The search depends on the name of the image file, the list of
directories defined in **FGLIMAGEPATH**, and the expected file
extensions provided by the front-end:

- Name of the image file is: \"*file*\"
- Content of FGLIMAGEPATH: \"*dir1*:*dir2*\"
- List of extensions provided by the front-end: .gif, .png

The search for the image file would be as follows:

1.  *dir1*/*file*
2.  *dir1*/*file*.gif
3.  *dir1*/*file*.png
4.  *dir2*/*file*
5.  *dir2*/*file*.gif
6.  *dir2*/*file*.png

When **FGLIMAGEPATH** is defined, the current working directory is not
searched. If you want to look for image files in the current working
directory and in other directories, add \".\" to the **FGLIMAGEPATH**
path list.

For security reasons, if **FGLIMAGEPATH** is defined, [static
image](FormSpecFiles.html#FF_STATIC_IMAGE) files must be located below
one of the directories listed in this environment variable. For example,
you cannot use an image file \"/home/scott/myicons/smiley\" when
**FGLIMAGEPATH** contains \"/home/myke:/app/icons\". However, this
security restriction does only apply to static images: When an filename
is displayed by program to an [image
field](FormSpecFiles.html#FF_IMAGE_FIELD) with DISPLAY TO / BY NAME or a
field used by a dialog with UNBUFFERED mode, the runtime system
considers that the file can be transferred to the front-end without
risk.

#### Warnings:

1.  The path separator is platform specific ( **\":\"** on UNIX
    platforms and **\";\"** on Windows platforms).
2.  Image files for [static images](FormSpecFiles.html#FF_STATIC_IMAGE)
    must be located in a directory of **FGLIMAGEPATH**, see below for
    details.

#### Example:

`FGLIMAGEPATH="/user/myimages:/user/myicones"`\
`export FGLIMAGEPATH`

See also the [IMAGE](FSFAttributes.html#FA_IMAGE) attribute.

------------------------------------------------------------------------

### [FGLLDPATH]{#EV_FGLLDPATH}

#### Purpose:

The **FGLLDPATH** environment variable defines the search paths to load
C extensions and modules.

#### Usage:

A Genero program can be composed by several p-code modules (**42m**) and
can use [C extensions](CExtensions.html). When linking and when
executing the program, the runtime system must known where to search for
these modules. You can use the **FGLLDPATH** environment variable to
define the search paths to load C extensions and p-code modules.

The directories are searched for the modules in the following order:

1.  The current directory.
2.  The directory where the program (**42r**) file resides.
3.  A path defined in the **FGLLDPATH** environment variable.
4.  The [FGLDIR](#EV_FGLDIR)/lib directory.

#### Warnings:

1.  The path separator is platform specific ( **\":\"** on UNIX
    platforms and **\";\"** on Windows platforms).
2.  This variable is used at [link time and at run time]{.underline}.

#### Example:

`FGLLDPATH="/user/modules1:/user/modules2"`\
`export FGLLDPATH`

*See also*: [IMPORT](Programs.html#IMPORT).

------------------------------------------------------------------------

### [FGLGUI]{#EV_FGLGUI}

#### Purpose:

The **FGLGUI** environment variable indicates whether the applications
are run in [TUI](FglTerms.html#TEXT_USER_INTERFACE) or
[GUI](FglTerms.html#GRAPHICAL_USER_INTERFACE) mode.

#### Usage:

When set to 0 (zero), the application executes in
[TUI](FglTerms.html#TEXT_USER_INTERFACE) mode.

When set to 1 (one), the application executes in
[GUI](FglTerms.html#GRAPHICAL_USER_INTERFACE) mode.

------------------------------------------------------------------------

### [FGLGUIDEBUG]{#EV_FGLGUIDEBUG}

#### Purpose:

The **FGLGUIDEBUG** environment variable defines the debug level in
[GUI](FglTerms.html#GRAPHICAL_USER_INTERFACE) mode.

#### Usage:

By default, the GUI protocol commands are compressed and not easy to
read on the client debug log. If you set this variable to a value
different from zero, the protocol commands are indented for better read.

If **FGLGUIDEBUG** is not set to 0, debug information about the
compression initialization is generated.

------------------------------------------------------------------------

### [FGLRESOURCEPATH]{#EV_FGLRESOURCEPATH}

#### Purpose:

The **FGLRESOURCEPATH** environment variable can be used as replacement
for **DBPATH** when needed.

#### Notes:

1.  You can provide a list of paths, separated by the operating system
    specific path separator.

#### Usage:

For compatibility with Informix 4gl, **DBPATH** is used by default to
search for resource files such as form files and XML files used by the
program. **DBPATH** is also used by the Informix database software to
locate databases: Informix Dynamic Servers uses **DBPATH** to let you
specify fallback servers if **INFORMIXSERVER** is not available, and
former Informix Standard Engine needs **DBPATH** to find **.dbs**
database files. This can be a problem when connecting from a machine
where path format is not the same as on the remote database server: It
is not possible to mix UNIX and DOS path formats in **DBPATH**.

To work around this Informix limitation, **FGLRESOURCEPATH** can be used
instead of **DBPATH** to specify the directories of program resource
files. You are then free to define **DBPATH** as Informix requires.

For more details about the type of files that this environment variable
looks for, see [DBPATH](#EV_DBPATH).

#### Warnings:

1.  The path separator is platform specific ( **\":\"** on UNIX
    platforms and **\";\"** on Windows platforms).

#### Example:

Unix example:

`DBPATH="/usr/informix/data"`\
`export DBPATH`\
`FGLRESOURCEPATH="/user/forms1:/user/forms2:/usr/strings/french"`\
`export FGLRESOURCEPATH`

Windows example:

`set DBPATH=/usr/informix/data`\
`set FGLRESOURCEPATH=C:\user\forms1;C:\user\forms2;C:\usr\strings\french`

*See also*: [DBPATH](#EV_DBPATH).

------------------------------------------------------------------------

### [FGLSERVER]{#EV_FGLSERVER}

#### Purpose:

The **FGLSERVER** defines the front-end location.

#### Syntax:

[`{`]{.underline}*`hostname`*[`|`]{.underline}*`ipaddress`*[`}[`]{.underline}`:`*`servnum`*[`]`]{.underline}

#### Notes:

1.  *hostname* is the name of a machine on the network.
2.  *ipaddress* is the IP V4 address ( Ex: 10:0:0:105 ).
3.  *servnum* identifies the front end.

#### Usage:

**FGLSERVER** defines the hostname and port of the graphical front end
to be used by the runtime system to display the application windows.

The servnum parameter implicitly defines the TCP port number the front
end is listening to, as an offset for the base port 6400. For example,
FGLSERVER=cobra:1 will use the TCP port 6401 (6400 + 1).

#### Warnings:

1.  The *servnum* parameter defines the front end server number (first
    is 0, second is 1, and so on) and implicitly the TCP port. The port
    number base is 6400. For example, when using 1, the runtime system
    connects to the TCP port 6401.

#### Example:

`FGLSERVER="mars:0"`\
`export FGLSERVER`

*See also*: [Automatic front-end startup](DynamicUI.html#AUTOSTART).

------------------------------------------------------------------------

### [FGLSOURCEPATH]{#EV_FGLSOURCEPATH}

#### Purpose:

The **FGLSOURCEPATH** environment variable defines the path to source
files for the [debugger](Debugger.html).

#### Usage:

By default, the current directory and the directories defined by
[FGLLDPATH](#EV_FGLLDPATH) are searched for the source files. You can
provide a list of paths, separated by the operating system specific path
separator.

#### Warnings:

1.  The path separator is platform specific ( **\":\"** on UNIX
    platforms and **\";\"** on Windows platforms).

------------------------------------------------------------------------

### [FGLDBPATH]{#EV_FGLDBPATH}

#### Purpose:

The **FGLDBPATH** environment variable contains the path to [database
schema files](DatabaseSchema.html).

#### Usage:

If **FGLDBPATH** is not defined, the current directory is the default
path for the database schema files. You can provide a list of paths,
separated by the operating system specific path separator. **FGLDBPATH**
is only used in development.

#### Warnings:

1.  The path separator is platform specific ( **\":\"** on UNIX
    platforms and **\";\"** on Windows platforms).

------------------------------------------------------------------------

### [FGLSQLDEBUG]{#EV_FGLSQLDEBUG}

#### Purpose:

The **FGLSQLDEBUG** environment variable defines the debug level for
tracing SQL instructions.

#### Usage:

If **FGLSQLDEBUG** is set to a value greater than zero, you get a debug
trace in the standard error channel.

**FGLSQLDEBUG** is only used in development.

------------------------------------------------------------------------

### [FGLPROFILE]{#EV_FGLPROFILE}

#### Purpose:

The **FGLPROFILE** environment variable defines a list of configuration
files to be used by the runtime system.

#### Usage:

If **FGLPROFILE** is not set, the runtime system reads entries from the
default configuration file located in
[FGLDIR](#EV_FGLDIR)/etc/fglprofile.

**FGLPROFILE** can define one unique configuration file, or a list of
files to be loaded sequentially.

For more information, refer to the [FGLPROFILE](FglProfile.html) section
of this manual.

#### Warnings:

1.  The path separator is platform specific ( **\":\"** on UNIX
    platforms and **\";\"** on Windows platforms).

------------------------------------------------------------------------

### [FGLWRTUMASK]{#EV_FGLWRTUMASK}

#### Purpose:

The **FGLWRTUMASK** environment variable defines the umask for the
FGLDIR/lock directory.

#### Usage:

The **FGLWRTUMASK** environment variable is used by the license manager
**fglWrt**. This variable defines the umask to create the
**FGLDIR/lock** directory. The default is 000, which creates a directory
with **rwxrwxrwx** rights.

For more information, refer to the [Installation](Installation.html)
section of this manual.

------------------------------------------------------------------------
