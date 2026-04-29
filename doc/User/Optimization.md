[Back to Contents](../index.html)

------------------------------------------------------------------------

# [Optimization]{#PAGE_HEADER}

Summary:

- [Genero runtime system basics](#BASICS)
  - [Dynamic module loading](#MODULE_LOADING)
  - [Objects shared by multiple programs](#PROGRAM_SHARED)
  - [Objects shared by multiple modules](#MODULE_SHARED)
  - [Objects private to a program](#PRIVATE_STUFF)
- [Size information of a program](#SIZEINFO)
- [Check runtime system memory leaks](#MEMLEAKS)
- [Programming Tips](#PROGTIPS)
  - [Finding program bottlenecks with the profiler](#PT_PROFILER)
  - [Optimizing SQL statements](#PT_SQLSTMTS)
  - [Passing small CHAR parameters to function](#PT_CHARPARAMS)
  - [Compiler removes unused variables](#PT_UNUSEDVARS)
  - [Saving memory by splitting modules](#PT_UNUSEDMODULES)
  - [Saving memory by using STRING variables](#PT_STRINGS)
  - [Saving memory by using dynamic arrays](#PT_DYNARRAYS)

*See also:* [Tools](Tools.html), [SQL Programming](SqlProgramming.html).

------------------------------------------------------------------------

## [Genero runtime system basics]{#BASICS}

### [Dynamic module loading]{#MODULE_LOADING}

A Genero program is typically constructed by linking several 42m modules
together. Except when using the debugger, modules are loaded dynamically
as needed. For example, when executing a
[CALL](FlowControl.html#FC_CALL) instruction, the runtime system checks
if the module of the function is already in memory. If not, the module
is first loaded, then module variables are instantiated, and then the
function is called.

### [Objects shared by multiple programs]{#PROGRAM_SHARED}

The p-code instructions and the constants are shared among several
Genero programs running on the same machine. These elements are loaded
with the system memory mapping facility, which allows multiple processes
to access the same unique memory area.

### [Objects shared by multiple modules]{#MODULE_SHARED}

By definition, global variables are visible to all modules of a program,
and thus shared among all modules of the program. While global variables
are an easy way to share data among multiple modules, it is not
recommended that you use too many global variables.

The data type definitions ([DEFINE](Variables.html#VA_DEFINE) or RECORDs
and ARRAYs) are shared by all modules of a program instance. By data
type definition we mean the type descriptions, not the data itself. This
applies only to the same data types used in different modules.

### [Objects private to a program]{#PRIVATE_STUFF}

Program objects such as global variables, module variables as well as
resources used by the user interface and SQL connections and cursors,
are private to a program. This implies that each of these objects
requires private memory to be allocated. If memory is an issue, do not
allocate unnecessary resources. For example, don\'t create windows /
load forms or declare / prepare cursors until these are really needed by
the program.

------------------------------------------------------------------------

## [Size information of a program]{#SIZEINFO}

When a **42m** module is loaded, the runtime system allocates memory for
module components such as variables, types, constants and code.

The size information of 42m modules can be extracted by using
[fglrun](Tools.html#TL_FGLRUN) with the **-s** option; The sizes are
displayed in [bytes]{.underline}.

**Warning: The -s option displaying size information of 42m modules is
provided for optimization purpose only. The output format is subject of
changes. If you want to analyze the produced output with external tools,
you must be ready to adapt the processing of this output, if the format
is modified in a new version of Genero BDL. Note that this option may be
removed in a next major version of the product.**

When using the **-s** option on a **42r** program,
[fglrun](Tools.html#TL_FGLRUN) searches for all the modules used by the
program.

Example:

    $ fglrun -s t.42r

    == Module:  t ==
                            function    local
                                main  1024004

                      module   global   module     code    types
                           t      268   512004       92      660

    == Module:  t2 ==
                            function    local
                                 foo        8

                      module   global   module     code    types
                          t2      472        0       43      360

    == Program globals ==
                             GLOBALS     size
                                   h      201
                                garr      264
                                   v        4
                               sqlca      116
                           quit_flag        4
                            int_flag        4
                              status        4

                               TOTAL     size
                                          597

    == Program totals ==
                        name   global   module     code    types
                       t.42r      597   512004      135     1020

    == Program types ==
     PROGRAM TYPES                                      (types)     1020
    - UNIQUE TYPES                                     - (size)      864
                                                              =      156

First the dvm will display each module statistics in the *Module*
section: Each Module section displays the list of functions declared by
the module and the size of its local variables in the column *local*.
Then the module statistics are displayed:\

  ------------ ---------------------------------------------------------------------------------------------
  **Column**   **Description**
  `module`     The 42m module name
  `global`     Size used by the global variables imported by the module.
  `module`     Size used by the module variables.
  `code`       Size used by the code itself (shared by all program instances running on the same machine).
  `types`      Size used by data types.
  ------------ ---------------------------------------------------------------------------------------------

The next section *Program Globals* displays all the global variables
referenced by the program with their size (column *size*). The *TOTAL*
line shows the total amount of memory needed by the program global
variables.

The section *Program totals* shows the program totals.

The last section called *Program types* provides additional information
about the memory consumed by *data types*. Identical type definitions
are shared between all modules of a program. This amount of memory is
showed by the line *UNIQUE TYPES*.

When several instances of the same program are started, the memory used
by the *code* and *constants* [is shared]{.underline}.

------------------------------------------------------------------------

## [Check runtime system memory leaks]{#MEMLEAKS}

To improve the quality of the runtime system, fglrun supports options to
count the creation of built-in class objects and some internal objects.
This allows to check for memory leaks in the runtime system: The runtime
system counts the object creations and destructions for each class. The
right-most column of the output is the different between created and
destroyed objects, it must show a zero for all type of objects.

**Warning: The -M / -m options are provided for debugging purpose only.
The output format is subject of changes. If you want to analyze the
produced output with external tools, you must be ready to adapt the
processing of this output, if the format is modified in a new version of
Genero BDL. Note that these option may be removed in a next major
version of the product.**

You can enable this feature by using the **-M** or **-m** options of
[fglrun](Tools.html#TL_FGLRUN).

` $ fglrun -M stores.42r`\
`FunctionI         :       10 -      10 =      0`\
`Module            :        3 -       3 =      0`\
`...`\
`FieldType         :       19 -      19 =      0`

The **-M** option displays memory counters at the end of the program
execution.

The **-m** option checks for memory leaks, and displays memory counters
at the end of the program execution if leaks were found.

Each line shows the number of objects allocated, and the number of
objects freed. If the difference is not zero, there is a memory leak.

If you are doing automatic regression tests, we recommend that you run
all your programs with **fglrun -m** to check for memory leaks in the
runtime system.

------------------------------------------------------------------------

## [Programming Tips]{#PROGTIPS}

This section lists some programming tips and tricks to optimize the
execution of your application.

### [Finding program bottlenecks with the profiler]{#PT_PROFILER}

The best way to find out why a program is slow (and also, to optimize an
already fast-running program), it to use the Profiler. This tool is
included in the runtime system, and generates a report that shows what
function in your program is the most time-consuming. For more details,
see [Profiler](Profiler.html).

### [Optimizing SQL statements]{#PT_SQLSTMTS}

SQL statement execution is often the code part of the program that
consumes a lot of processor, disk and network resources. Therefore, it
is critical to pay attention to SQL execution. Advice for this can be
found in [SQL Programming](SqlProgramming.html).

### [Passing small CHAR parameters to functions]{#PT_CHARPARAMS}

In Genero, function parameters of most data types are passed by value
(i.e. the value of the caller variable is copied on the stack, and then
copied back into a local variable of the called function.) When large
data types are used,  this can introduce a performance issue.

For example, the following code defines a logging function that takes a
[CHAR(2000)](DataTypes.html#DT_CHAR) as parameter:

``` linenumber
01 FUNCTION log_msg( msg )
02   DEFINE msg CHAR(2000)
03   CALL myLogChannel.writeLine(msg)
04 END FUNCTION
```

If you call this function with a string having 19 bytes:

``` linenumber
01 CALL log_msg( "Start processing..." )
```

The runtime system copies the 19 bytes string on that stack, calls the
function, and then copies the value into the the **msg** local variable.
When doing this, since the values in CHAR variables must always have a
length matching the variable definition size, the runtime system fills
the remaining 1981 bytes with blanks. Each time you call this function,
2000 bytes are copied into a buffer.

By using a [VARCHAR(2000)](DataTypes.html#DT_VARCHAR) (or a
[STRING](DataTypes.html#DT_STRING)) data type in this function, you
optimize the execution because no trailing blanks need to be added.

### [Compiler removes unused variables]{#PT_UNUSEDVARS}

If you have declared a large static array without any reference to that
variable in the rest of the module,  you will not see the memory grow at
runtime. The compiler has removed its definition from the **42m**
module.

To get the defined variable in the 42m module, you must at least use it
once in the source (for example, with a [LET](Variables.html#VA_LET)
statement). Note that memory might only be allocated when reaching the
lines using the variable.

### [Saving memory by splitting modules]{#PT_UNUSEDMODULES}

As described in [dynamic module loading](#MODULE_LOADING), **42m**
modules are loaded on demand. If a program only needs some independent
functions of a given module, all module resources will be allocated just
to call these functions. By independent, we mean functions that do not
use module objects such as variables defined outside function or SQL
cursors. To avoid unnecessary resource allocation, you can extract these
independent functions into another module and save a lot of memory at
runtime.

Additionally, it is recommended that you create **42x** libraries with
the **42m** modules that belong to the same functionality group. For
example, group all accounting modules together in an accounting.42x
library. By doing this, programmers using the **42x** libraries are not
dependent from module re-organizations.

### [Saving memory by using STRING variables]{#PT_STRINGS}

The [CHAR](DataTypes.html#DT_CHAR) and
[VARCHAR](DataTypes.html#DT_VARCHAR) data types are provided to hold
string data from a database column. When you define a `CHAR` or
`VARCHAR` variable with a length of 1000, the runtime system must
allocate the entire size, to be able to fetch SQL data directly into the
internal string buffer.

To save memory, Genero BDL introduced the
[STRING](DataTypes.html#DT_STRING) data type. The `STRING` type is
similar to `VARCHAR`, except that you don\'t need to specify a maximum
length and the internal string buffer is allocated dynamically as
needed. Thus, by default, a `STRING` variable initially requires just a
bunch of bytes, and grows during the program life time, with a
limitation of 65534 bytes.

A `STRING` variable should typically be used to build SQL statements
dynamically, for example from a [CONSTRUCT](Construct.html) instruction.
You may also use the `STRING` type for utility function parameters, to
hold file names for example.

After a large `STRING` variable is used, it should be cleared with a
[LET](Variables.html#VA_LET) or a [INITIALIZE TO
NULL](Variables.html#VA_INITIALIZE) instruction. However, this is only
needed for `STRING` variables declared as global or module variables.
The variables defined in functions will be automatically destroyed when
the program returns from the function.

Note that Genero also introduced the
[base.StringBuffer](ClassStringBuffer.html) build-in class, which should
be used for heavy string manipulation and modifications. String data is
not copied on the stack when an object of this class is passed to a
function, or when the string is modified with class methods. This can
have a big impact on performance when very large strings are processed.

### [Saving memory by using dynamic arrays]{#PT_DYNARRAYS}

Genero BDL supports both [static arrays and dynamic
arrays](Arrays.html). For compatibility reasons, static arrays must be
allocated in their entirety. This can result in huge memory usage when
big structures are declared, such as: 

``` linenumber
01 DEFINE my_big_array ARRAY[100,50] OF RECORD
02           id CHAR(200),
02           comment1 CHAR(2000),
02           comment2 CHAR(2000)
04 END RECORD
```

If possible, replace such static arrays with dynamic arrays. However, be
aware that dynamic arrays have a slightly different behavior than static
arrays.

Note that after using a large dynamic array, you should clean the
content by using the [clear()](Arrays.html) method. This will free all
the memory used by the array elements. However, this is only needed for
arrays declared as global or module variables. The arrays defined in
functions will be automatically cleaned and destroyed when the program
returns from the function.
