[Back to Contents](../index.html)

------------------------------------------------------------------------

# [Tools and Components]{#PAGE_HEADER}

Summary:

- [Runtime System Program](#TL_FGLRUN) (`fglrun`)
- [Form Compiler](#TL_FGLFORM) (`fglform`)
- [Program Compiler](#TL_FGL2P) (`fgl2p`)
- [Module Compiler](#TL_FGLCOMP) (`fglcomp`)
- [Module Linker](#TL_FGLLINK) (`fgllink`)
- [Message Compiler](#TL_FGLMKMSG) (`fglmkmsg`)
- [Database Schema Extractor](#TL_FGLDBSCH) (`fgldbsch`)
- [Localized String File Compiler](#TL_FGLMKSTR) (`fglmkstr`)

*See also:* [Installation and Setup](Installation.html).

------------------------------------------------------------------------

### [fglrun]{#TL_FGLRUN}

#### Purpose:

The `fglrun` tool is the runtime system program that executes p-code BDL
programs.

#### Syntax:

`fglrun `[`[`]{.underline}*`options`*[`]`]{.underline}` `[`[`]{.underline}` `*`program`*[`[`]{.underline}`.42r`[`]`]{.underline}` `[`|`]{.underline}` `*`module`*[`[`]{.underline}`.42m`[`]`]{.underline}` `[`]`]{.underline}` `[`[`]{.underline}*`argument`*` `[`[...]]`]{.underline}

#### Notes:

1.  *options* are described below.
2.  *program*.42r is the name of a program file linked with
    [fgllink](#TL_FGLLINK).
3.  *module*.42m is the name of a module containing the
    [MAIN](Programs.html#MAIN_BLOCK) routine.
4.  *argument* is a program argument passed to the program, see
    [arg_val()](BuiltInFunctions.html#BF_ARG_VAL).
5.  Note that the **.42r** or **.42m** extension is optional: if not
    used, fglrun will automaticall search for files with these
    extensions.

#### Options:

::: {align="center"}
  --------------------------------------------------------------- -----------------------------------------
  **Option**                                                      **Description**

  `-V`                                                            Display version information for the tool.

  `-h`                                                            Displays options for the tool. Short
                                                                  help.

  `-i `[`{`]{.underline}` mbcs `` `[`}`]{.underline}              Displays information. `-i mbcs` displays
                                                                  information about multi-byte character
                                                                  set settings.

  `-d`                                                            Start in debug mode. See
                                                                  [Debugger](Debugger.html) for more
                                                                  details.

  `-e `*`extfile`*` `[`[`]{.underline}*`,...`*[`]`]{.underline}   Specify a [C
                                                                  extension](CExtensions.html#LOADEXT)
                                                                  module to be loaded. This option can take
                                                                  a comma-separated list of extensions.

  `-l`                                                            Link pcode nodules together, see
                                                                  [Compiling
                                                                  Programs](CompilingPrograms.html).

  `-o `*`outfile`*                                                Specify the output file for the link mode
                                                                  (-l option).

  `-b`                                                            Displays compiler version information of
                                                                  the module, see [Compiling
                                                                  Programs](CompilingPrograms.html).

  `-p`                                                            Generate profiling information to stderr
                                                                  (UNIX only). See
                                                                  [Profiler](Profiler.html) for more
                                                                  details.

  `-s`                                                            Displays size information in bytes about
                                                                  the module, see
                                                                  [Optimization](Optimization.html).

  `-M`                                                            Display a memory usage diagnostic when
                                                                  program ends, see
                                                                  [Optimization](Optimization.html).

  `-m`                                                            Check for memory leaks. If leaks are
                                                                  found, displays memory usage diagnostic
                                                                  and stops with status 1, see
                                                                  [Optimization](Optimization.html).

  `--java-option=`*`option`*                                      Passes Java runtime options when
                                                                  initializing the JNI interface.\
                                                                  See [Java
                                                                  Interface](JavaBridge.html#JNI_OPTIONS)
                                                                  for more details.
  --------------------------------------------------------------- -----------------------------------------
:::

#### Usage:

This tool executes BDL programs.

`fglrun myprogram.42r -x 123`

For more details, see [Executing FGL
Programs](Programs.html#START_FGLRUN).

------------------------------------------------------------------------

### [fglform]{#TL_FGLFORM}

#### Purpose:

The `fglform` tool compiles [form specification
files](FormSpecFiles.html) into XML formatted files used by the
programs.

#### Syntax:

`fglform `[`[`]{.underline}*`options`*[`]`]{.underline}` `*`srcfile`*[`[`]{.underline}`.per`[`]`]{.underline}

#### Notes:

1.  *options* are described below.
2.  *srcfile*.per is the form specification file.
3.  The **.per** form file extension is optional.

#### Warning:

1.  All **.per** form specification files used by the program must be
    compiled before usage.

#### Options:

::: {align="center"}
  ---------------------------------------------------- -----------------------------------
  **Option**                                           **Description**

  `-V`                                                 Display version information for the
                                                       tool.

  `-h`                                                 Displays options for the tool.
                                                       Short help.

  `-i `[`{`]{.underline}` mbcs `` `[`}`]{.underline}   Displays information. `-i mbcs`
                                                       displays information about
                                                       multi-byte character set settings.

  `-m`                                                 Extract [localized
                                                       strings](LocalizedStrings.html).

  `-M`                                                 Write error messages to standard
                                                       output instead of creating a
                                                       **.err** error file.

  `-W `[`{`]{.underline}` all `` `[`}`]{.underline}    Display warning messages. Only
                                                       `-W all` option is supported for
                                                       now.

  `-E`                                                 Preprocess only.

  `-p `*`option`*                                      Preprocessing control, where
                                                       *option* can be one of:\
                                                       - nopp: Disable preprocessing.\
                                                       - noli: No line number information
                                                       (only with -E option).\
                                                       - fglpp: Use \# syntax instead of &
                                                       syntax.

  `-I `*`path`*                                        Provides a path to search for
                                                       include files.

  `-D `*`ident`*                                       Defines the macro \'ident\' with
                                                       the value 1.
  ---------------------------------------------------- -----------------------------------
:::

#### Usage:

This tool compiles a **.per** [form specification
file](FormSpecFiles.html) into a **.42f** compiled version:

`fglform custform.per`

The **.42f** compiled version is an XML formatted file used by BDL
programs when a form definition is loaded with the [OPEN
FORM](WindowsAndForms.html#OPEN_FORM) or [OPEN WINDOW WITH
FORM](WindowsAndForms.html#OPEN_WINDOW) instructions.

------------------------------------------------------------------------

### [fglmkmsg]{#TL_FGLMKMSG}

#### Purpose:

The `fglmkmsg` tool compiles [message files](MessageFiles.html) into a
binary version used by the BDL programs.

#### Syntax:

`fglmkmsg `[`[`]{.underline}*`options`*[`]`]{.underline}` `*`srcfile`*` `[`[`]{.underline}*`outfile`*[`]`]{.underline}

#### Notes:

1.  *options* are described below.
2.  *srcfile* is the source message file.
3.  *outfile* is the destination file.

#### Warning:

1.  All **.msg** message files used by the program must be compiled
    before usage.

#### Options:

::: {align="center"}
  ------------------ --------------------------------------------
  **Option**         **Description**
  `-V`               Display version information for the tool.
  `-h`               Displays options for the tool. Short help.
  `-r `*`msgfile`*   De-compiles a binary message file.
  ------------------ --------------------------------------------
:::

#### Usage:

This tool compiles a **.msg** [message file](MessageFiles.html) into a
**.iem** compiled version:

`fglmkmsg mess01.msg`

For backward compatibility, you can specify the output file as second
argument:

`fglmkmsg mess01.msg mess01.iem`

The **.iem** compiled version can be used by BDL programs, for example,
when the `HELP` clause is used in a [MENU](Menus.html) or
[INPUT](RecordInput.html) instruction.

See [message files](MessageFiles.html) for more details.

------------------------------------------------------------------------

### [fglcomp]{#TL_FGLCOMP}

#### Purpose:

The `fglcomp` tool compiles [BDL program sources files](Programs.html)
into a p-code version.

#### Syntax:

`fglcomp `[`[`]{.underline}*`options`*[`]`]{.underline}` `*`srcfile`*[`[`]{.underline}`.4gl`[`]`]{.underline}

#### Notes:

1.  *options* are described below.
2.  *srcfile*.4gl is the program source file.
3.  The **.4gl** extension is optional.

#### Warnings:

1.  The **.42m** p-code modules must be linked together with
    [fgllink](#TL_FGLLINK) or [fgl2p](#TL_FGL2P) in order to create a
    runable program.

#### Options:

::: {align="center"}
  ---------------------------------------------------- ------------------------------------------------
  **Option**                                           **Description**

  `-V or --version`                                    Display version information for the tool.

  `-h or --help`                                       Displays options for the tool. Short help.

  `-i `[`{`]{.underline}` mbcs `` `[`}`]{.underline}   Displays information. `-i mbcs` displays
                                                       information about multi-byte character set
                                                       settings.

  `-S`                                                 Dump [Static SQL statements](StaticSql.html)
                                                       found in the source to stdout.

  `-m`                                                 Extract %\"string\" [Localized
                                                       Strings](LocalizedStrings.html) from source to
                                                       stdout.

  `-M`                                                 Write error messages to standard output instead
                                                       of creating a **.err** error file.

  `-W `*`what`*                                        Display warning messages. For a complete
                                                       description, [see below](#FglCompWarningFlags).

  `-E`                                                 Preprocess only. See
                                                       [Preprocessor](Preprocessor.html) for more
                                                       details.

  `--timestamp`                                        Add compilation timestamp to build information
                                                       in 42m header.

  `-p `*`option`*                                      Preprocessing control, where *option* can be one
                                                       of:\
                                                       - nopp: Disable preprocessing.\
                                                       - noli: No line number information (only with -E
                                                       option).\
                                                       - fglpp: Use \# syntax instead of & syntax.

  `-G`                                                 Produce .c and .h globals interface files for [C
                                                       Extensions](CExtensions.html#SHARING_GLOBALS).

  `-I `*`path`*                                        Provides a path to search for include files. See
                                                       [Preprocessor](Preprocessor.html) for more
                                                       details.

  `-D `*`ident`*                                       Defines the macro \'ident\' with the value 1.
                                                       See [Preprocessor](Preprocessor.html) for more
                                                       details.

  `--build-doc`                                        Generate [source documentation](AutoDoc.html).

  `--build-rdd`                                        Generate the .rdd data definition during
                                                       compilation.

  `--verbose`                                          Print detailed compilation information

  `--java-option=`*`option`*                           Passes Java runtime options when initializing
                                                       the JNI interface.\
                                                       See [Java
                                                       Interface](JavaBridge.html#JNI_OPTIONS) for more
                                                       details.
  ---------------------------------------------------- ------------------------------------------------
:::

#### Usage:

This tool compiles a **.4gl** into a **.42m** p-code module that can be
linked to other modules to create a program or a library.

`fglcomp customers.4gl`

If a compilation error occurs, the tool generates a file that has the
**.err** extension, with the error message inserted at the line where
the error occurred. You can change this behavior by using the -`M`
option to display the error message to the standard output.

To create a executable program, the [fgllink](#TL_FGLLINK) or
[fgl2p](#TL_FGL2P) tool must be used to link the **.42m** compiled file
with other modules.

#### [The -W option]{#FglCompWarningFlags}

The ` -W` option can be used to check for wrong language usage, that
must be supported for backward compatibility. When used, this option
helps to write better source code.

The argument following ` -W` option can be one of ` return`, `unused`,
`stdsql`, `print`, `error` and `all`.

- Using `-W all` enables all warning flags.
- Using `-W error` makes the compiler stop if any warning is raised, as
  if an error occurred.
- The `-W unused` option displays a message for all unused variables.
- The `-W return` option displays a warning if the same function returns
  different number of values with several [RETURN](Functions.html).
- The `-W stdsql` option displays a message for all non-portable SQL
  statements or language instructions.
- The `-W print` option displays a message when the
  [PRINT](Reports.html#RPT_STMT_PRINT) instruction is used outside a
  `REPORT`.
- The `-W implicit` option prints a warning for functions calls when the
  function was not declared inside the module or in an [inported
  module](Programs.html#IMPORT).

The ` -W` option also supports the negative form of arguments by using
the `no-` prefix as in: `no-return`, `no-unused`, `no-stdsql`. You might
need to use these negative form in order to disable some warning when
using the `-W all` option:

`fglcomp -Wall -Wno-stdsql customers.4gl`

The order of warning arguments is important: switches will be
enabled/disabled in the order of appearance in the command line. Using
the negative form of warning arguments *before* `-W all` makes no
sense. 

------------------------------------------------------------------------

### [fgllink]{#TL_FGLLINK}

#### Purpose:

The `fgllink` tool assembles p-code modules compiled with
[fglcomp](#TL_FGLCOMP) into a **.42r** program or a **.42x** library.

#### Syntax:

To create a library:

`fgllink `[`[`]{.underline}*`options`*`] -o `*`outfile`*`.42x `*`module`*`.42m `[`[...]`]{.underline}

To create a program:

`fgllink `[`[`]{.underline}*`options`*[`]`]{.underline}` -o `*`outfile`*`.42r `[`{`]{.underline}` `*`module`*`.42m `[`|`]{.underline}` `*`library`*`.42x `[`}`]{.underline}` `[`[...]`]{.underline}

#### Notes:

1.  *options* are described below.
2.  *outfile*.42r is the name of the program to be created.
3.  *outfile*.42x is the name of the library to be created.
4.  *module*.42m is a p-code module compiled with
    [fglcomp](#TL_FGLCOMP).
5.  *library*.42x is the name of a library to be linked.

#### Options:

::: {align="center"}
  ---------------------------- -----------------------------------------------------------------------------------------------
  **Option**                   **Description**
  `-V`                         Display version information for the tool.
  `-h`                         Displays options for the tool. Short help.
  `-o `*`outfile`*`.`*`ext`*   Output file specification, where *ext* can be **42r** for a program or **42x** for a library.
  *`otheroption`*              Other options are passed to fglrun for linking.
  ---------------------------- -----------------------------------------------------------------------------------------------
:::

#### Usage:

This tool links **.42m** p-code modules together to create a **.42x**
library or a **.42r** program file.

`fgllink -o myprog.42x module1.42m module2.42m lib1.42x`

Note that `fgllink` is just a wrapper calling [fglrun](#TL_FGLRUN) with
the **-l** option.

------------------------------------------------------------------------

### [fgl2p]{#TL_FGL2P}

#### Purpose:

The `fgl2p` tool compiles source files and assembles p-code modules into
a **.42r** program or a **.42x** library.

#### Syntax:

To create a library:

`fgl2p `[`[`]{.underline}*`options`*[`]`]{.underline}` -o `*`outfile`*`.42x `[`{`]{.underline}` `*`pcodem`*`.42m `[`|`]{.underline}` `*`srcfile`*`.4gl `[`}`]{.underline}` `[`[...]`]{.underline}

To create a program:

`fgl2p `[`[`]{.underline}*`options`*[`]`]{.underline}` -o `*`outfile`*`.42r `[`{`]{.underline}` `*`pcodem`*`.42m `[`|`]{.underline}` `*`srcfile`*`.4gl `[`|`]{.underline}` `*`library`*`.42x `[`}`]{.underline}` `[`[...]`]{.underline}

#### Notes:

1.  *options* are described below.
2.  *outfile*.42r is the name of the program to be created.
3.  *outfile*.42x is the name of the library to be created.
4.  *pcodem*.42m is a p-code module compiled with
    [fglcomp](#TL_FGLCOMP).
5.  *source*.4gl is a program source file.
6.  *library*.42x is the name of a library to be linked.

#### Options:

::: {align="center"}
  ---------------------------- -----------------------------------------------------------------------------------------------
  **Option**                   **Description**
  `-V`                         Display version information for the tool.
  `-h`                         Displays options for the tool. Short help.
  `-o `*`outfile`*`.`*`ext`*   Output file specification, where *ext* can be **42r** for a program or **42x** for a library.
  *`otheroption`*              Other options are passed to the linker or compiler.
  ---------------------------- -----------------------------------------------------------------------------------------------
:::

#### Usage:

This tool can compile **.4gl** source files and link **.42m** p-code
modules together, to create a **.42x** library or a **.42r** program
file.

`fgl2p -o myprog.42x module1.4gl module2.42m lib1.42x`

This tool is provided for convenience, in order to create programs or
libraries in one command line. It uses the [fglcomp](#TL_FGLCOMP) and
the [fgllink](#TL_FGLLINK) tools to compile and link modules together.

------------------------------------------------------------------------

### [fgldbsch]{#TL_FGLDBSCH}

#### Purpose

The *Database schema extractor* is the tool provided to generate the
[Database Schema Files](DatabaseSchema.html) from an existing database.

#### Syntax:

`fgldbsch -db `*`dbname`*` `[`[`]{.underline}*`options`*[`]`]{.underline}

#### Notes:

1.  *dbname* is the name of the database from which the schema is to be
    extracted.
2.  *options* are described below.

#### Options:

::: {align="center"}
  -------------------- -----------------------------------------------------------------------------------------
  **Option**           **Description**
  `-V`                 Display version information for the tool.
  `-h`                 Displays options for the tool. Short help.
  `-H`                 Display long help.
  `-v`                 Enable verbose mode (display information messages).
  `-ct`                Display data type conversion tables.
  `-db `*`dbname`*     Specify the database as *dbname*. This option is required to generate the schema files.
  `-dv `*`dbdriver`*   Specify the database driver to be used.
  `-un `*`user`*       Define the user name for database connection as *user*.
  `-up `*`pswd`*       Define the user password for database connection as *pswd*.
  `-ow `*`owner`*      Define the owner of the database tables as *owner*.
  `-cv `*`string`*     Specify the data type conversion rules by character positions in *string*.
  `-of `*`name`*       Specify output files prefix, default is database name.
  `-tn `*`tabname`*    Extract the description of a specific table.
  `-ie`                Ignore tables with columns having data types that cannot be converted.
  `-cu`                Generate upper case table and column names.
  `-cl`                Generate lower case table and column names.
  `-cc`                Generate case-sensitive table and column names.
  `-st`                Generate database system tables.
  -------------------- -----------------------------------------------------------------------------------------
:::

#### Usage:

The `fgldbsch` tool extracts the schema description for any database
supported by the product.

For more details about generated schema files, see [Database Schema
Files](DatabaseSchema.html).

------------------------------------------------------------------------

### [fglmkstr]{#TL_FGLMKSTR}

#### Purpose:

The `fglmkstr` tool compiles [localized string
files](LocalizedStrings.html).

#### Syntax:

`fglmkstr `[`[`]{.underline}*`options`*[`]`]{.underline}` `*`source-file`*[`[`]{.underline}`.str`[`]`]{.underline}

#### Notes:

1.  *options* are described below.
2.  *source-file* is the **.str** string file. You can omit the file
    extension.

#### Options:

::: {align="center"}
  ------------ --------------------------------------------
  **Option**   **Description**
  `-V`         Display version information for the tool.
  `-h`         Displays options for the tool. Short help.
  ------------ --------------------------------------------
:::

#### Usage:

This tool is used to compile **.str** localized string files into
**.42s** files. 

For more details, see [Localized Strings](LocalizedStrings.html).
