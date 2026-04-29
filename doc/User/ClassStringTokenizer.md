[Back to Contents](../index.html)

------------------------------------------------------------------------

# [The StringTokenizer class]{#PAGE_HEADER}

Summary:

- [Syntax](#SYNTAX)
- [Method](#METHODS)[s](#USAGE)
- [Usage](#USAGE)
  - [Create a tokenizer](#create)
  - [Extended create method](#createExt)
  - [Count the number of tokens](#countTokens)
  - [Check if there are more tokens to return](#hasMoreTokens)
  - [Return the next token](#nextToken)
- [Examples](#EXAMPLES)

See also: [Built-in classes](BuiltInClasses.html),
[StringBuffer](ClassStringBuffer.html)

------------------------------------------------------------------------

### [Syntax]{#SYNTAX}

The **StringTokenizer** class is designed to parse a string to extract
tokens according to delimiters.

#### Syntax:

`base.StringTokenizer`

------------------------------------------------------------------------

### [Methods:]{#METHODS}

+--------------------------------------------+-------------------------------------+
| **Class Methods**                                                                |
+--------------------------------------------+-------------------------------------+
| **Name**                                   | **Description**                     |
+--------------------------------------------+-------------------------------------+
| [`create`](#create)`( src `` STRING`       | Returns a StringTokenizer object    |
| `, delim `` STRING` ` )`\                  | prepared to parse the *src* source  |
| `  ``RETURNING` `base.StringTokenizer`     | string according to the *delim*     |
|                                            | delimiters. The *delim* parameter   |
|                                            | is a string that can hold one or    |
|                                            | more delimiters.                    |
+--------------------------------------------+-------------------------------------+
| [`createExt`](#createExt)`( src `` STRING` | Same as create(), except for        |
| `, delim `` STRING``, `\                   | additional options. The *esc*       |
| `           `                              | parameter defines an escape         |
| ` esc ``STRING``, nulls ``INTEGER`` )`\    | character for the delimiter. The    |
| `  ``RETURNING` `base.StringTokenizer`     | *nulls* parameter indicates if      |
|                                            | empty tokens are taken into         |
|                                            | account.                            |
+--------------------------------------------+-------------------------------------+
| **Object Methods**                                                               |
+--------------------------------------------+-------------------------------------+
| **Name**                                   | **Description**                     |
+--------------------------------------------+-------------------------------------+
| [`countTokens`](#countTokens)`()`\         | Returns the number of tokens left   |
| `  ``RETURNING INTEGER`                    | to be returned.                     |
+--------------------------------------------+-------------------------------------+
| [`hasMoreTokens`](#hasMoreTokens)`()`\     | Returns TRUE if there are more      |
| `  ``RETURNING INTEGER`                    | tokens to return.                   |
+--------------------------------------------+-------------------------------------+
| [`nextToken(`](#nextToken)`)`\             | Parses the string and returns the   |
| `  ``RETURNING STRING`                     | next token.                         |
+--------------------------------------------+-------------------------------------+

------------------------------------------------------------------------

### [Usage:]{#USAGE}

The StringTokenizer built-in class is provided to split a source string
into tokens, according to delimiters. The following code uses the
` `[`base.StringTokenizer.create()`]{#create} method to create a
StringTokenizer that will generate 3 tokens with the values \"aaa\",
\"bbb\", \"ccc`":`

``` linenumber
01 DEFINE tok base.StringTokenizer
02 LET tok = base.StringTokenizer.create("aaa|bbb|ccc","|")
```

The StringTokenizer can take a unique or multiple delimiters into
account. A delimiter is always one character long. In the following
example, 3 delimiters are used, and 4 tokens are extracted:

``` linenumber
01 DEFINE tok base.StringTokenizer
02 LET tok = base.StringTokenizer.create("aaa|bbb;ccc+ddd","|+;")
```

If you create a StringTokenizer with the
`base.StringTokenizer.create(`*`src`*`,`*`delim`*`)` method, the empty
tokens are [not]{.underline} taken into account, and no escape character
is defined for the delimiters:

- No escape character can be used.
- The` nextToken()` method will never return NULL strings.
- In the source string, leading and trailing delimiters or the amount of
  delimiters between two tokens do not affect the number of tokens.

If you create a StringTokenizer with the
[`base.StringTokenizer.reateExt(`*`src`*`,`*`delim`*`,`*`esc`*`,`*`nulls`*`)`]{#createExt}
method, you can configure the StringTokenizer:

When passing a character to the *esc* parameter, the delimiters can be
escaped in the source string.

When passing TRUE to the *nulls* parameter, the empty tokens are taken
into account:

- The `nextToken()` method might return NULL strings.
- In the source string, leading and trailing delimiters or the amount of
  delimiters between two tokens affects the number of tokens.

Note that when you want to specify a backslash as a delimiter, you must
use double backslashes in both the source string and as the delimiter,
as shown in Example 3 below.

The [`countTokens()`]{#countTokens} method counts the number of tokens
left to be returned.

The [`hasMoreTokens()`]{#hasMoreTokens} method returns TRUE if there are
more tokens to return.

The [`nextToken()`]{#nextToken} method parses the string and returns the
next token.

------------------------------------------------------------------------

### [Examples]{#EXAMPLES}

#### [Example 1]{#EXAMPLE1}: Split a UNIX directory path

``` linenumber
01 MAIN
02   DEFINE tok base.StringTokenizer
03   LET tok = base.StringTokenizer.create("/home/tomy","/")
04   WHILE tok.hasMoreTokens()
05     DISPLAY tok.nextToken()
06   END WHILE
07 END MAIN
```

#### [Example 2]{#EXAMPLE2}: Taking escaped delimiters and NULL tokens into account

``` linenumber
01 MAIN
02   DEFINE tok base.StringTokenizer
03   LET tok = base.StringTokenizer.createExt("||\\|aaa||bbc|","|","\\",TRUE)
04   WHILE tok.hasMoreTokens()
05     DISPLAY tok.nextToken()
06   END WHILE
07 END MAIN
```

#### [Example 3]{#EXAMPLE3}: Specifying a backslash as the delimiter

``` linenumber
01 MAIN
02   DEFINE tok base.StringTokenizer
03   LET tok = base.StringTokenizer.create("C:\\My Documents\\My Pictures","\\")
04   WHILE tok.hasMoreTokens()
05     DISPLAY tok.nextToken()
06   END WHILE
07 END MAIN
```

     
