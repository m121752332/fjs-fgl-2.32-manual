[Back to Contents](../index.html)

------------------------------------------------------------------------

# [Documentation Conventions]{#PAGE_HEADER}

Summary:

- [TUI Only Features](#DC_CONSOLE)
- [De-supported Features](#DC_DESFEAT)
- [Informix Specific Features](#DC_IFXSPEC)
- [Syntaxes](#DC_SYNTAXES)
- [Notes](#DC_NOTES)
- [Warnings](#DC_WARNINGS)
- [Tips](#DC_TIPS)
- [Code Examples](#DC_EXAMPLES)
- [Enhancement reference](#ENH_REF)

------------------------------------------------------------------------

## [TUI Only Features]{#DC_CONSOLE}

[TUI](FglTerms.html#TEXT_USER_INTERFACE) only features are marked with
the red warning: **TUI Only!**

::: {align="center"}
+-----------------------------------------------------------------------+
| ####  OPTIONS MENU LINE 3 **TUI Only!**                               |
+-----------------------------------------------------------------------+
:::

Elements marked with this flag must only be used in programs designed
for text-based terminals. 

------------------------------------------------------------------------

## [De-supported Features]{#DC_DESFEAT}

Product features that are no longer supported are marked with the red
warning: **De-supported!**

::: {align="center"}
+-----------------------------------------------------------------------+
| ####  The WIDGET=\"BMP\" attribute **De-supported!**                  |
+-----------------------------------------------------------------------+
:::

Elements marked with this flag are no longer supported in the product.

------------------------------------------------------------------------

## [Informix Specific Features]{#DC_IFXSPEC}

Features that are specific to Informix database servers are marked with
the red warning: **Informix only!**

::: {align="center"}
+-----------------------------------------------------------------------+
| ####  DATABASE dbname@dbserver **Informix only!**                     |
+-----------------------------------------------------------------------+
:::

Elements marked with this flag work only with Informix database servers,
and are not recommended for multi-database programming.

------------------------------------------------------------------------

## [Syntaxes]{#DC_SYNTAXES}

The term of \'*syntax*\' is global and indicates the way to use a
product function. For example, it can be used to describe a language
instruction or a system command:

::: {align="center"}
+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| #### Syntax:                                                                                                                                                                     |
|                                                                                                                                                                                  |
| `CALL `*`function`*` ( `[`[`]{.underline}` `*`parameter`*` `[`[,...]`]{.underline}` `[`]`]{.underline}` ) [ RETURNING `*`variable`*` `[`[,...]`]{.underline}` `[`]`]{.underline} |
+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
:::

Wildcard characters in syntax definitions are marked with an underscore:

::: {align="center"}
  ----------------------------------------------------------- ------------------------------------------------------------------------
  **Wildcards**                                               **Description**
  [`[`]{.underline}`   `[`]`]{.underline}                     Square braces indicate an optional element in the syntax.
  [`{`]{.underline}` `[`|`]{.underline}` `[`}`]{.underline}   Curly braces indicate a list of possible elements separated by a pipe.
  [`[...]`]{.underline}                                       Indicates that the previous element can appear more than once.
  [`[,...]`]{.underline}                                      Previous element can appear more than once separated by a comma.
  ----------------------------------------------------------- ------------------------------------------------------------------------
:::

------------------------------------------------------------------------

## [Notes]{#DC_NOTES}

Notes hold a list of technical remarks about the product function:

::: {align="center"}
+-----------------------------------------------------------------------+
| #### Notes:                                                           |
|                                                                       |
| 1.  *identifier* is the name of the variable to be defined.           |
| 2.  *datatype* can be any data type except complex types like TEXT or |
|     BYTE.                                                             |
| 3.  \...                                                              |
+-----------------------------------------------------------------------+
:::

------------------------------------------------------------------------

## [Warnings]{#DC_WARNINGS}

Warnings are important technical remarks, describing special behavior of
the product function:

::: {align="center"}
  -------------------------------------------------------------------------------------------------------------
  **Warning: When a DATE, DATETIME or INTERVAL constant cannot be initialized correctly, it is set to NULL.**
  -------------------------------------------------------------------------------------------------------------
:::

------------------------------------------------------------------------

## [Tips]{#DC_TIPS}

Tips are hints to use the product function more efficiently:

::: {align="center"}
+-----------------------------------------------------------------------+
| #### Tips:                                                            |
|                                                                       |
| 1.  Do not include a NULL value in a Boolean expression.              |
| 2.  \...                                                              |
+-----------------------------------------------------------------------+
:::

------------------------------------------------------------------------

## [Code Examples]{#DC_EXAMPLES}

Code examples are written with line numbers and language syntax
highlighting as follows:

::: {align="center"}
+-----------------------------------------------------------------------+
| #### Example 1:                                                       |
|                                                                       |
| ``` linenumber                                                        |
| 01 MAIN                                                               |
| 02   DEFINE a1 ARRAY[100] OF INTEGER,                                 |
| 03         a2 ARRAY[10,20] OF RECORD                                  |
| 04              id INTEGER,                                           |
| 05   ...                                                              |
| ```                                                                   |
+-----------------------------------------------------------------------+
:::

------------------------------------------------------------------------

## [Enhancement references]{#ENH_REF}

In some parts of the documentation you can find enhancement reference
notes with a number identifying the request in our internal database:

::: {align="center"}
  ----------------------------------
  *Enhancement reference: BZ#1827*
  ----------------------------------
:::
