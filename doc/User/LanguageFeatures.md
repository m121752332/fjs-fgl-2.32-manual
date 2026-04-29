[Back to Contents](../index.html)

------------------------------------------------------------------------

# [Language Features]{#PAGE_HEADER}

Summary:

- [Introduction](#LF_INTRO)
- [Lettercase Insensitivity](#LF_INSCASE)
- [Whitespace Separators](#LF_SPACE)
- [Quotation Marks](#LF_QUOTES)
- [Statement Terminator](#LF_TERMIN)
- [Character Set](#LF_CHARSET)
- [Comments](#LF_COMMENTS)
- [Program Components](#LF_PROGCOMP)
- [SQL Support](#LF_SQLSUP)
- [Identifiers](#LF_IDENTS)
- [Preprocessor Directives](#LF_PREPRO)

------------------------------------------------------------------------

## [Introduction]{#LF_INTRO}

Genero BDL is an English-like programming language designed for creating
relational database applications.

The language includes high-level instructions to implement the user
interface of the applications, generate reports, and execute SQL
statements to communicate with database servers.

------------------------------------------------------------------------

## [Lettercase Insensitivity]{#LF_INSCASE}

BDL is *case insensitive*, making no distinction between uppercase and
lowercase letters, except within quoted strings. Use pairs of double (
`"` ) or single ( `'` ) quotation marks in the code to preserve the
lettercase of character literals, filenames, and names of database
entities.

You can mix uppercase and lowercase letters in the identifiers that you
assign to language entities, but any uppercase letters in BDL
identifiers are automatically shifted to lowercase during compilation.

#### Tips:

1.  It is strongly recommended that you define a naming convention for
    your projects. For example, you can use underscore notation
    (`get_user_name`). If you plan to use the Java notation
    (`getUserName`), do not forget that BDL is case insensitive
    (`getusername` is the same identifier as `getUserName`).

#### Warnings:

1.  With Genero BDL you can import and use Java classes and objects in
    BDL code. Genero BDL is case-sensitive regarding Java elements. For
    more details about Java support, see the [Java
    Interface](JavaBridge.html). 

------------------------------------------------------------------------

## [Whitespace Separators]{#LF_SPACE}

BDL is free-form, like C or Pascal, and generally ignores TAB
characters, LINEFEED characters, comments, and extra blank spaces
between statements or statement elements. You can freely use these
whitespace characters to enhance the readability of your source code.

Blank (ASCII 32) characters act as delimiters in some contexts. Blank
spaces must separate successive keywords or identifiers, but cannot
appear within a keyword or identifier. Pairs of double ( \" ) or single
( \' ) quotation marks must delimit any character string that contains a
blank (ASCII 32) or other whitespace character, such as LINEFEED or
RETURN.

------------------------------------------------------------------------

## [Quotation Marks]{#LF_QUOTES}

In BDL, string literals are delimited by single (`'`) or double (`"`)
quotation marks:

> 'Valid character string'
>     "Another valid character string"

Do not mix double and single quotation marks as delimiters of the same
string. For example, the following is not a valid character string:

> 'Not A valid character string"

In SQL statements, when accessing a non-Informix relational database,
such as a DB2 database from IBM, double quotation marks might not be
recognized as database object name delimiters. In the SQL language, the
standard specifications recommend that you use single quotes for string
literals and double quotes for database object identifiers like table or
column names. 

To include literal quotation marks within a quoted string, precede each
literal quotation mark with the backslash (\\), or else enclose the
string between a pair of the opposite type of quotation marks:

``` linenumber
01 MAIN
02   DISPLAY "Type 'Y' if you want to reformat your disk."
03   DISPLAY 'Type "Y" if you want to reformat your disk.'
04   DISPLAY 'Type \'Y\' if you want to reformat your disk.'
05 END MAIN
```

A string literal can be written on multiple lines. The compiler merges
lines by removing the new-line character.

For more details, see [String Literals](Literals.html#LT_STRING).

------------------------------------------------------------------------

## [Escape Symbols]{#LF_ESCAPE}

The compiler treats a backslash ( `\` ) as the default escape symbol,
and treats the immediately following symbol as a literal, rather than as
having special significance. To specify anything that includes a literal
backslash, enter double ( `\\` ) backslashes wherever a single backslash
is required. Similarly, use `\\\\` to represent a literal double
backslash.

For more details, see [String Literals](Literals.html#LT_STRING).

------------------------------------------------------------------------

## [Statement Terminator]{#LF_TERMIN}

BDL requires no statement terminators, but you can use the semicolon ( ;
) as a statement terminator in some cases, PREPARE and PRINT statements
for example.

``` linenumber
01 MAIN
02   DISPLAY "Hello, World"  DISPLAY "Hello, World"
03   DISPLAY "Hello, World"; DISPLAY "Hello, World"
04 END MAIN
```

------------------------------------------------------------------------

## [Character Set]{#LF_CHARSET}

The language requires the ASCII character set, but also supports
characters from the client locale in data values, identifiers, form
specifications, and reports.

------------------------------------------------------------------------

## [Comments]{#LF_COMMENTS}

A comment is text in the source code to assist human readers, but which
BDL ignores. (This meaning of *comment* is unrelated to the COMMENTS
attribute in a form, or to the OPTIONS COMMENT LINE statement, both of
which control on-screen text displays to assist users of the
application.)

You can indicate comments in any of several ways:

- A comment can begin with the left-brace ( `{` ) and end with the
  right-brace ( `}` ) symbol. These can be on the same line or on
  different lines.
- The sharp ( `#` ) symbol can begin a comment that terminates at the
  end of the same line.
- You can use a pair of minus signs ( `--` ) to begin a comment that
  terminates at the end of the current line. (This comment indicator
  conforms to the ANSI standard for SQL.)

#### Warnings:

1.  Within a quoted string, 4GL interprets comment indicators as literal
    characters, rather than as comment indicators.
2.  You cannot use braces ( `{ }` ) to nest comments within comments.
3.  Comments cannot appear in the SCREEN section of a [form
    specification file](FormSpecFiles.html).
4.  The `#` symbol cannot indicate comments in an SQL statement block,
    nor in the text of a prepared statement.
5.  You cannot specify consecutive minus signs ( `--` ) in arithmetic
    expressions, because BDL interprets what follows as a comment.
    Instead, use a blank space or parentheses to separate consecutive
    arithmetic minus signs.
6.  The symbol that immediately follows the `--` comment indicator must
    not be the sharp (#) symbol, unless you intend to compile the same
    source file with the Informix 4GL product.

#### Tips:

1.  For clarity and to simplify program maintenance, it is recommended
    that you document your code by including comments in your source
    files.
2.  You can use comment indicators during program development to disable
    statements without deleting them from your source code modules.

------------------------------------------------------------------------

## [Program Components]{#LF_PROGCOMP}

BDL programs are built from source code files with the language
compiler, form compiler, and message compiler. Source code files can be:

### Database Schema Files (`.sch`, `.att`, `.val`)

The Database Schema Files describe the structure of the database tables.
See [Database Schema](DatabaseSchema.html) for more details.

### Form Specification Files (`.per`)

In Form Specification Files, you define the layout of application
screens. See [Forms](FormSpecFiles.html) for more details.

### Program Sources Files (`.4gl`)

In Program Source Files, you define the structure of the program with
instruction blocks ( like `MAIN`, `FUNCTION` or `REPORT` ). The program
starts from the `MAIN` block. The instruction blocks contain BDL
instructions that are be executed by the runtime system in the order
that they appear in the code. Program blocks cannot be nested, nor any
program block divided among more than one source code module.

Some BDL instructions can include other instructions. Such instructions
are called *compound statements*. Every compound statement of BDL
supports the END keyword to mark the end of the compound statement
construct within the source code module. Most compound statements also
support the EXIT *statement* keywords, to transfer control of execution
to the statement that follows the END *statement* keywords, where
*statement* is the name of the compound statement. By definition, every
compound statement can contain at least one statement block, a group of
one or more consecutive SQL statements or other BDL statements. In the
syntax diagram of a compound statement, a statement block always
includes this element.

### Message Files (`.msg`)

The Message Files hold texts that can be loaded at runtime. Each text is
identified by a number. See [Message Files](MessageFiles.html) for more
details.

### Localized Strings (`.str`)

The Localized Strings allow you to customize application strings, which
are loaded automatically at runtime. Each string is identified by an
identifier. See [Localized Strings](LocalizedStrings.html) for more
details.

### Resource Files (`.4st`, `.4ad`, `.4tm`, `.4tb`, `.4sm`)

The Resource Files can be used to centralize application elements and
settings in external XML files. Resource Files include [Presentation
Styles](PresentationStyles.html), [Action
Defaults](ActionDefaults.html), [TopMenu definitions](Topmenus.html),
[ToolBar definitions](Toolbars.html), [StartMenu
definiitions](StartMenus.html).

------------------------------------------------------------------------

## [SQL Support]{#LF_SQLSUP}

A limited syntax of SQL is supported directly by the BDL compiler, so
you can write common SQL statements such as SELECT, INSERT, UPDATE or
DELETE directly in your source code:

``` linenumber
01 MAIN
02   DEFINE n INTEGER, s CHAR(20)
03   DATABASE stores
04   LET s = "Sansino"
05   SELECT COUNT(*) INTO n FROM customer WHERE custname = s
06   DISPLAY "Rows found: " || n
07 END MAIN
```

For SQL statements that have a syntax that is not supported directly by
the compiler, the language provides SQL statement preparation from
strings as in other languages.

``` linenumber
01 MAIN
02   DEFINE txt CHAR(20)
03   DATABASE stores
04   LET txt = "SET DATE_FORMAT = YMD"
05   PREPARE sh FROM txt
06   EXECUTE sh
07 END MAIN
```

For more details about SQL statement preparation, see the [Dynamic SQL
Instructions](DynamicSql.html).

------------------------------------------------------------------------

## [Identifiers]{#LF_IDENTS}

A BDL identifier is a character string that is declared as the name of a
program entity. Identifiers must conform to the following rules:

- It must include at least one character, without any limitation in
  size.
- Only ASCII letters, digits, and underscore ( \_ ) symbols are valid.
- Blanks, hyphens, and other non-alphanumeric characters are not
  allowed.
- The initial character must be a letter or an underscore.
- Common identifiers are not case sensitive, so `my_Var `and `MY_vaR`
  both denote the same identifier. However, in some cases, identifiers
  are case sensitive (like action names in the [AUI
  tree](DynamicUI.html#ABSTRACTUI)). Therefore, it is recommended to
  always write identifiers in lower case to avoid mistakes.

Within non-English locales, BDL identifiers can include non-ASCII
characters in identifiers, if those characters are defined in the code
set of the locale that `CLIENT_LOCALE` specifies. In multibyte East
Asian locales that support languages whose written form is not
alphabet-based, such as Chinese, Japanese, or Korean, an identifier does
not need to begin with a letter. It is however recommended to program in
ASCII.

------------------------------------------------------------------------

## [Preprocessor Directives]{#LF_PREPRO}

The language supports preprocessing instructions, which allow you to
write macros and conditional compilation rules:

``` linenumber
01 &include "myheader.4gl"
02 FUNCTION debug( msg )
03   DEFINE msg STRING
04 &ifdef DEBUG
05   DISPLAY msg
06 &endif
07 END FUNCTION
```

See [The Preprocessor](Preprocessor.html) for more details.

------------------------------------------------------------------------
