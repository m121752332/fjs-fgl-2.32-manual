[Back to Contents](../index.html)

------------------------------------------------------------------------

# [Implementing C-Extensions]{#PAGE_HEADER}

Summary:

- [Basics](#BASICS)
- [Prerequisites](#PREREQ)
- [Creating C-Extensions](#CREATEEXT)
  - [Creating ESQL/C extensions](#CREATESQLCEXT)
    - [ESQL/C Extensions with non-Informix databases](#NON_IFX_ESQLC)
    - [ESQL/C Extensions with Informix](#IFX_ESQLC)
- [C interface file](#CEXTFILE)
- [Linking programs using C-Extensions](#LINKING)
- [Loading C-Extensions](#LOADEXT)
  - [Using the IMPORT instruction](#IMPORT)
  - [Using the default extension name](#DEFNAME)
  - [Using the -e fglrun option](#E_OPTION)
- [Stack Functions](#STACK)
- [C Data Types and Structures](#TYPEDEFS)
- [Available Macros](#MACROS)
  - [VARCHAR Macros](#VCMACROS)
  - [DECIMAL Macros](#DECMACROS)
  - [DATETIME/INTERVAL Macros](#DTMACROS)
  - [DATETIME/INTERVAL Constants](#DTCONST)
- [Calling C functions from BDL](#CFCALL)
- [Calling BDL functions from C](#FGLCALL)
- [Sharing global variables](#SHARING_GLOBALS)
- [Example](#EXAMPLE)
- [C API Functions](#CAPI)
- [Formatting directives](#FMT)

*See also:* [Programs](Programs.html), [Installation and
Setup](Installation.html).

------------------------------------------------------------------------

## [Basics]{#BASICS}

With C-Extensions, you can integrate your own C libraries in the
[runtime system](FglTerms.html#RUNTIME_SYSTEM), to call C function from
the BDL code. This feature allows you to extend the language with custom
libraries, or existing standard libraries, just by writing some
\'wrapper functions\' to interface with BDL.

C-Extensions are implemented with [shared libraries](#CREATEEXT). Using
shared libraries avoids the need to re-link the
[fglrun](Tools.html#TL_FGLRUN) program and simplifies deployment.

Function parameters and returned values are passed/returned on the legal
BDL stack, using [pop/push functions](#STACK). Be sure to pop and push
the exact number of parameters/returns expected by the caller;
otherwise, a fatal stack error will be raised at runtime.

Inside the C Extension, you can manipulate 4GL-specific data types with
the [C API functions](#CAPI) supported by Genero BDL. For example, you
can do DECIMAL computation.

In order to use a C-Extension in your program, you typically specify the
library name with the [IMPORT](#IMPORT) instruction at the beginning of
the BDL module calling the C-Extension functions. The compiler can then
check for function existence and the library will be automatically
loaded at runtime.

#### Notes:

- The C code written in C Extensions becomes usually platform specific
  and does not ease the migration of your application to a different
  operating system. For example, you can expect problems when porting an
  application from UNIX to Windows when using UNIX specific system
  calls. Additionally, C data types that are defined differently
  according to the processor architecture (32 / 64 bits issues) will
  also be an issue.
- In earlier versions of Genero, static C extensions could define global
  variables to be shared between the runtime system and the extension;
  This was done by using the \"userData\" structure in the extension
  interface file. With Dynamic C extensions, global variables cannot be
  shared any longer. You must use functions to pass global variable
  values. For an example, see [Sharing global
  variables](#SHARING_GLOBALS).
- Make sure that the functions defined in your C Extensions do not
  conflict with BDL functions. In case of conflict, you will get a
  compiler or a runtime error, according to the [loading technique
  used](#LOADEXT). 

------------------------------------------------------------------------

## [Prerequisites]{#PREREQ}

To compile C Extensions using complex data types such as DECIMAL,
DATETIME/INTERVAL or BYTE/TEXT, you need IBM Informix ESQL/C data type
structure definitions such as dec_t, dtime_t, intrvl_t, as well as
macros like DECLEN() or TU_ENCODE(). These definitions are not required
if you use standard C types such as short, int or char\[\].

The definition of the ESQL/C structures like dec_t are property of IBM
and cannot be provided in the Genero BDL package. Note also that some
definitions are platform specific, for example, the *mlong* typedef is
different on 32bit and 64bit machines.

The IBM Informix CSDK must be installed on the development machine in
order to get the ESQL/C structures and macro definitions specific to
Informix data types. Understand that the IBM Informix CSDK is only
required on the computer used for [development,]{.underline} where you
compile and link your C Extensions shared libraries: It is not required
to install the CSDK on the production machines, except of course if you
want to connect to an IBM Informix database server.

The INFORMIXDIR environment variable must be set and point to the
directory where the IBM Informix CSDK is installed.

------------------------------------------------------------------------

## [Creating C-Extensions]{#CREATEEXT}

Custom C Extensions must be provided to the runtime system as Shared
Objects (**.so**) on UNIX, and as Dynamically Loadable Libraries
(**.DLL**) on Windows.

In order to create a C-Extension, you must:

1.  Define the list of user functions in the [C interface
    file](#CEXTFILE).
2.  Compile the C interface file and the C modules with the
    position-independent code option, by including the **fglExt.h**
    header file.
3.  Create the shared library with the compiled C interface file and C
    modules by linking with the **libfgl** runtime system library.

In your C source files, you must include the **fglExt.h** header file in
the following way:

``` linenumber
01 #include <f2c/fglExt.h>
```

When migrating from IBM Informix 4GL, it is possible that existing C
extension sources include Informix specific headers like sqlhdr.h or
decimal.h. You can either remove or keep the original includes, but if
you want to keep them, the Informix specific header files must be
included [before]{.underline} the **fglExt.h** header file, in order to
let fglExt.h detect that typedefs such as dec_t or dtime_t are already
defined by Informix headers. If you include Informix headers
[after]{.underline} fglExt.h, you will get a compilation error. As
fglExt.h defines all Informix-like typedef structures, you can remove
the inclusion of Informix specific header files.

Your C functions must be known by the runtime system. To do so, each C
extension library must publish its functions in a **UsrFunction array**,
which is read by the runtime system when the module is loaded. The
UsrFunction array describes the user functions by specifying the name of
the function, the C function pointer, the number of parameters and the
number of returned values. You typically define the UsrFunction array in
the [C interface file](#CEXTFILE).

After compiling the C sources, you must link them together with the
**libfgl** runtime system library. See below for examples.

Carefully read the man page of the ld dynamic loader, and any
documentation of your operating system related to shared libraries. Some
platforms require specific configuration and command line options when
linking a shared library, or when linking a  program using a shared
library (+s option on HP for example).

Linux command-line example:

    gcc -c -I $FGLDIR/include -fPIC myext.c
    gcc -c -I $FGLDIR/include -fPIC cinterf.c
    gcc -shared -o myext.so myext.o cinterf.o -L$FGLDIR/lib -lfgl

Windows command-line example using Visual C 7.1:

    cl /DBUILDDLL /I%FGLDIR%/include /c myext.c
    cl /DBUILDDLL /I%FGLDIR%/include /c cintref.c
    link /dll /out:myext.dll myext.obj cinterf.obj %FGLDIR%\lib\libfgl.lib

Windows command-line example using Visual C 8.0 (you must create a
manifest file for the DLL!):

    cl /DBUILDDLL /I%FGLDIR%/include /c myext.c
    cl /DBUILDDLL /I%FGLDIR%/include /c cintref.c
    link /dll /manifest /out:myext.dll myext.obj cinterf.obj %FGLDIR%\lib\libfgl.lib
    mt -manifest myext.dll.manifest -outputresource:myext.dll

### [Creating ESQL/C Extensions]{#CREATESQLCEXT}

You can create user extension libraries from ESQL/C sources, as long as
you have an ESQL/C compiler which is compatible with your Genero runtime
system. In order to create these user extensions, you must first compile
the **.ec** sources to object files by including the **fglExt.h** header
file. Then you must create the shared library by linking with additional
SQL libraries to resolve the functions used in the **.ec** source to
execute SQL statements.

#### [ESQL/C extensions with non-Informix databases]{#NON_IFX_ESQLC}

If you need to use ESQL/C extensions with database clients such as
Oracle, SQL Server or Genero db, you must use the **fesqlc** compiler,
and link the objects with the FESQLC libraries in order to use the same
SQL API as the Genero BDL runtime system database interface.

#### [ESQL/C extensions with Informix]{#IFX_ESQLC}

You can compile .ec extensions with the native Informix esql compiler,
or with the fesqlc compiler provided by Genero. This section describes
how to use the Informix esql compiler.

The following example shows how to compile and link an extension library
with Informix **esql** compiler:

Linux command-line example:

    esql -c -I$FGLDIR/include myext.ec
    gcc -c -I$FGLDIR/include -fPIC cinterf.c
    gcc -shared -o myext.so myext.o cinterf.o -L$FGLDIR/lib -lfgl \
        -L$INFORMIXDIR/lib -L$INFORMIXDIR/lib/esql `esql -libs`

Windows command-line example (using VC 7.1):

    esql -c myext.ec -I%FGLDIR%/include
    cl /DBUILDDLL /I%FGLDIR%/include /c cintref.c
    esql -target:dll -o myext.dll myext.obj cinterf.obj %FGLDIR%\lib\libfgl.lib

When using Informix **esql**, you link the extension library with
*Informix client libraries*. These libraries will be shared by the
extension module and the Informix database driver loaded by the Genero
runtime system. Since both the extension functions and the runtime
database driver use the same functions to execute SQL queries, you can
share the current SQL connection opened in the Genero program to execute
SQL queries in the extension functions. However, mixing connection
management instructions (DATABASE, CONNECT TO) as well as database
creation can produce unexpected results. For example you cannot do a
CREATE DATABASE in your ESQL/C extension, and expect that the Genero BDL
code can use it to execute SQL statements.

------------------------------------------------------------------------

## [C Interface File]{#CEXTFILE}

To make your C functions visible to the runtime system, you must define
all the functions in the **C Interface File**. This is a C source file
that defines the **usrFunctions** array. This array defines C functions
that can be called from BDL. The last record of each array must be a
line with all the elements set to 0, to define the end of the list.

The first member of a **usrFunctions** element is the BDL name of the
function, provided as a character string. The second member is the C
function symbol. Therefore, you typically do a forward declaration of
the C functions before the **usrFunctions** array initializer. The third
member is the number of BDL parameters passed thru the stack to the
function. The last member is the number of values returned by the
function; you can use -1 to specify a variable number of arguments.

#### Example:

``` linenumber
01 #include <f2c/fglExt.h>
02 
03 int c_log(int);
04 int c_cos(int);
05 int c_sin(int);
06 
07 UsrFunction usrFunctions[]={
08   {"log",c_log,1,1},
09   {"cos",c_cos,1,1},
10   {"sin",c_sin,1,1},
11   {0,0,0,0}
12 };
```

------------------------------------------------------------------------

## [Linking programs using C-Extensions]{#LINKING}

When [creating a 42r program or 42x library](CompilingPrograms.html),
the Genero BDL linker needs to resolve all function names, including C
extension functions. Thus, if extension modules are not specified
explicitly in the source files with the [IMPORT](#IMPORT) directive, you
must give the extension modules with the **-e** option in the command
line:

    fgllink -e myext1,myext2,myext3   -o myprog.42r   moduleA.42m moduleB.42m ...

The **-e** option is not needed when using the default
[userextension](#DEFNAME) module, or if C extensions are specified with
the [IMPORT](#IMPORT) directive.

------------------------------------------------------------------------

## [Loading C-Extensions]{#LOADEXT}

The runtime system can load several C-Extensions libraries, allowing you
to properly split your libraries by defining each group of functions in
separate C interface files.

Directories are searched for the C-Extensions libraries according to the
[FGLLDPATH](EnvironmentVariables.html#EV_FGLLDPATH) environment variable
rules. See environment variable definition for more details.

If the C-Extension library depends from other shared libraries, make
sure that the library loader of the operating system can find theses
shared objects: You may need to set the LD_LIBRARY_PATH environment
variable on UNIX or the PATH environment variable on Windows to point to
the directory where these other libraries are located.

There are three ways to bind a C Extension with the runtime system:

1.  Using the [`IMPORT`](Programs.html#IMPORT) instruction in sources.
2.  Using the default C Extension name.
3.  Using the -e option of [fglrun](Tools.html#TL_FGLRUN).

### [Using the IMPORT instruction]{#IMPORT}

The `IMPORT` instruction allows you to declare an external module in a
.4gl source file. It must appear at the beginning of the source file.

Note that the name of the module specified after the `IMPORT` keyword
[is converted to lowercase]{.underline} by the compiler. Therefore it is
recommended to use lowercase file names only.

The compiler and the runtime system automatically know which C
extensions must be loaded, based on the `IMPORT` instruction:

``` linenumber
01 IMPORT mylib1
02 MAIN
03   CALL myfunc1("Hello World")  -- defined in mylib1
04 END MAIN
```

When the `IMPORT` instruction is used, no other action has to be taken
at runtime: The module name is stored in the **42m** pcode and is
automatically loaded when needed.

For more details, see [Importing modules](Programs.html#IMPORT).

### [Using the default C Extension name]{#DEFNAME}

Normally, all Genero BDL modules using a function from a C extension
should now use the `IMPORT` instruction. This could be a major change in
your sources.

To simplify migration of existing C extensions, the runtime system loads
by default a module with the name **userextension.** Create this shared
library with your existing C extensions, and the runtime system will
load it automatically if it is in the directories specified by
[FGLLDPATH](EnvironmentVariables.html#EV_FGLLDPATH).

### [Using the -e fglrun option]{#E_OPTION}

In some cases you need several C extension libraries, which are used by
different group of programs, so you can\'t use the default
**userextension** solution. However, you don\'t want to review all your
sources in order to use the `IMPORT` instruction.

You can specify the C Extensions to be loaded by using the **-e** option
of [fglrun](Tools.html#TL_FGLRUN). The -e option takes a comma-separated
list of module names, and can be specified multiple times in the command
line. The next example loads five extension modules:

    fglrun -e myext1,myext2,myext3   -e myext4,myext5   myprog.42r

By using the **-e** option, the runtime system loads the modules
specified in the command line instead of loading the default
**userextension** module.

------------------------------------------------------------------------

## [Stack Functions]{#STACK}

To pass values between a C function and a program, the C function and
the runtime system use the BDL stack. The **int** parameter of the C
function defines the number of input parameters passed on the stack, and
the function must return an **int** value defining the number of values
returned on the stack. The parameters passed to the C function must be
popped from the stack at the beginning of the C function, and the return
values expected by the 4gl call must be pushed on the stack before
leaving the C function. If you don\'t pop / push the specified number of
parameters / return values, you corrupt the stack and get a fatal error.

The runtime system library includes a set of functions to retrieve the
values passed as parameters on the stack. The following table shows the
library functions provided to pop values from the stack into C buffers:

  ----------------------- ----------------------- -----------------------
  **Function**            **BDL Type**            **Notes**

  void popdate(int4       DATE                    4-byte integer value
  \*dst);                                         corresponding to days
                                                  since 12/31/1899.

  void popboolean(signed  BOOLEAN                 1-byte integer boolean
  char \*dst);                                    (1/0/-1)

  void popbigint(bigint   BIGINT                  8-byte integer value
  \*dst);                                         

  void popint(mint        INTEGER                 System dependent
  \*dst);                                         integer value (int)

  void popshort(int2      SMALLINT                2-byte integer value
  \*dst);                                         

  void poplong(int4       INTEGER                 4-byte integer value
  \*dst);                                         

  void popflo(float       SMALLFLOAT              4-byte floating point
  \*dst);                                         value

  void popdub(double      FLOAT                   8-byte floating point
  \*dst);                                         value

  void popdec(dec_t       DECIMAL                 See structure
  \*dst);                                         definition in
                                                  \$FGLDIR/include/f2c
                                                  headers

  void popquote(char      CHAR(n)                 len = strlen(val)+1
  \*dst, int len);                                (for the \'/0\')

  void popvchar(char      VARCHAR(n)              len = strlen(val)+1
  \*dst, int len);                                (for the \'/0\')

  void popdtime(dtime_t   DATETIME                See structure
  \*dst, int size);                               definition in
                                                  \$FGLDIR/include/f2c
                                                  headers\
                                                  size =
                                                  TU_DTENCODE(start, end)

  void popinv(intrvl_t\*  INTERVAL                See structure
  dst, int size);                                 definition in
                                                  \$FGLDIR/include/f2c
                                                  headers\
                                                  size = TU_IENCODE(len,
                                                  start, end)

  void poplocator(loc_t   BYTE, TEXT              See structure
  \*\*dst);                                       definition in
                                                  \$FGLDIR/include/f2c
                                                  headers\
                                                  Warning: this function
                                                  pops the pointer of a
                                                  loc_t object!
  ----------------------- ----------------------- -----------------------

When using a pop function, the value is copied from the stack to the
local C variable and the value is removed from the stack.

In BDL, Strings (CHAR, VARCHAR) are not terminated by \'\\0\'.
Therefore, the C variable must have one additional character to store
the \'\\0\'. For example, the equivalent of a VARCHAR(100) in BDL is a
char \[101\] in C.

To return a value from the C function, you must use one of the following
functions provided in the runtime system library:

  ------------------------------------------------------- -------------- -----------------------------------------------------------------
  **Function**                                            **BDL Type**   **Notes**
  void pushdate(int4 val);                                DATE           4-byte integer value corresponding to days since 12/31/1899.
  void pushdec(const dec_t\* val, const unsigned decp);   DECIMAL        See structure definition in \$FGLDIR/include/f2c headers
  void pushboolean(const signed char);                    BOOLEAN        1-byte integer boolean (1/0/-1)
  void pushbigint(bigint val);                            BIGINT         8-byte integer value
  void pushint(mint val);                                 INTEGER        System dependent integer value (int)
  void pushlong(int4 val);                                INTEGER        4-byte integer value
  void pushshort(int2 val);                               SMALLINT       2-byte integer value
  void pushflo( float\* val);                             SMALLFLOAT     4-byte floating point value. Warning: function takes a pointer!
  void pushdub( double\* val);                            FLOAT          8-byte floating point value. Warning: function takes a pointer!
  void pushquote(const char \*val, int l);                CHAR(n)        len = strlen(val) (without \'\\0\')
  void pushvchar(const char \*val, int l);                VARCHAR(n)     len = strlen(val) (without \'\\0\')
  void pushdtime(const dtime_t \*val);                    DATETIME       See structure definition in \$FGLDIR/include/f2c headers
  void pushinv(const intrvl_t \*val);                     INTERVAL       See structure definition in \$FGLDIR/include/f2c headers
  ------------------------------------------------------- -------------- -----------------------------------------------------------------

When using a push function, the value of the C variable is copied at the
top of the stack.

------------------------------------------------------------------------

## [C Data Types and Structures]{#TYPEDEFS}

The fglExt.h header file defines the following C types:

  --------------- -----------------------------------------
  **Type name**   **Description**
  bigint          signed integer with a size of 8 bytes
  ubigint         unsigned integer with a size of 8 bytes
  int4            signed integer with a size of 4 bytes
  uint4           unsigned integer with a size of 4 bytes
  int2            signed integer with a size of 2 bytes
  uint2           unsigned integer with a size of 2 bytes
  int1            signed integer with a size of 1 byte
  uint1           unsigned integer with a size of 1 byte
  mint            signed machine-dependent C int
  muint           unsigned machine-dependent C int
  mlong           signed machine-dependent C long
  mulong          unsigned machine-dependent C long
  dec_t           DECIMAL data type structure
  dtime_t         DATETIME data type structure
  intrvl_t        INTERVAL data type structure
  loc_t           TEXT / BYTE Locator structure
  --------------- -----------------------------------------

### Basic data types

Basic data types such as **bigint**, **int4** and **int2** are provided
to define variables that must hold BIGINT (bigint), SMALLINT (int2),
INTEGER (int4) and DATE (int4) values. Standard **char** array can be
used to hold CHAR and VARCHAR data.

### DATE

No specific typedef exists for DATEs; you can use the **int4** type to
store a DATE value.

### DECIMAL/MONEY

The **dec_t** structure is provided to hold DECIMAL and MONEY values.

The internals of dec_t structure can be ignored during C extension
programming, because decimal API functions are provided to manipulate
any aspects of a decimal.

### DATETIME

The **dtime_t** structure holds a DATETIME value.

Before manipulating a dtime_t, you must initialize its qualifier
qt_qual, by using the TU_DTENCODE macro, as in the following example:

``` linenumber
01 dtime_t dt;
02 dt.dt_qual = TU_DTENCODE(TU_YEAR, TU_SECOND);
03 dtcvasc( "2004-02-12 12:34:56", &dt );
```

### INTERVAL

The **intrvl_t** structure holds an INTERVAL value.

Before manipulating a intrvl_t, you must initialize its qualifier
in_qual, by using the TU_IENCODE macro, as in the following example:

``` linenumber
01 intrvl_t in;
02 in.in_qual = TU_IENCODE(5, TU_YEAR, TU_MONTH);
03 incvasc( "65234-02", &in );
```

### TEXT/BYTE Locator

The **loc_t** structure is used to declare host variables for a
TEXT/BYTE values (simple large objects). Because the potential size of
the data can be quite large, this is a locator structure that contains
information about the size and location of the TEXT/BYTE data, rather
than containing the actual data.

The fields of the loc_t structure are:

  ---------------- --------------- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  **Field name**   **Data Type**   **Description**
  loc_indicator    int4            Null indicator; a value of -1 indicates a null TEXT/BYTE value. Your program can set the field to indicate the insertion of a null value. FESQLC or ESQL/C libraries set the value for selects and fetches.
  loc_type         int4            Data type - SQLTEXT (for TEXT values) or SQLBYTES (for BYTE values).
  loc_size         int4            Size of the TEXT/BYTE value in bytes; your program sets the size of the large object for insertions. FESQLC or ESQL/C libraries set the size for selects and fetches.
  loc_loctype      int2            Location - LOCMEMORY (in memory) or LOCFNAME (in a named file). Set loc_loctype after you declare the locator variable and before this declared variable receives the large object value.
  loc_buffer       char \*         If loc_loctype is LOCMEMORY, this is the location of the TEXT/BYTE value; your program must allocate space for the buffer and store its address here.
  loc_bufsize      int4            IF loc_loctype is LOCMEMORY, this is the size of the buffer loc_buffer; If you set loc_bufsize to -1, FESQLC or ESQL/C libraries will allocate the memory buffer for selects and fetches. Otherwise, it is assumed that your program will handle memory allocation and de-allocation.
  loc_fname        char \*         IF loc_loc_type is LOCFNAME, this is the address of the pathname string that contains the file.
  ---------------- --------------- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

**Example:**

``` linenumber
01 loc_t *pb1
02 double ratio; 
03 char *source = NULL, *psource = NULL;
04 int size; 
05
06 if (pb1->loc_loctype == LOCMEMORY) { 
07     psource = pb1->loc_buffer; 
08     size = pb1->loc_size; 
09 } else if (pb1->loc_loctype == LOCFNAME) { 
10     int fd; 
11     struct stat st; 
12     fd = open(pb1->loc_fname, O_RDONLY); 
13     fstat(fd, &st); 
14     size = st.st_size; 
15     psource = source = (char *) malloc(size); 
16     read(fd, source, size); 
17     close(fd); 
18 }
```

------------------------------------------------------------------------

## [Available Macros]{#MACROS}

### [Varchar type related macros]{#VCMACROS}

The following macros allow you to obtain the size information stored by
the database server for a VARCHAR column:

  ----------------- -----------------------------------------------------------------------------
  **Macro**         **Description**
  MAXVCLEN (255)    Returns maximum number of characters allowed in a VARCHAR column
  VCMIN(size)       Returns minimum number of characters that you can store in a VARCHAR column
  VCLENGTH(len)     Returns length of the host variable
  VCMAX(size)       Returns maximum number of characters that you can store in a VARCHAR column
  VCSIZ(max, min)   Returns encoded size for the VARCHAR column
  ----------------- -----------------------------------------------------------------------------

### [Decimal type related macros]{#DECMACROS}

Decimals are defined by an encoded **length** - the total number of
significant digits (**precision**), and the significant digits to the
right of the decimal (**scale**). The following macros handle decimal
length:

  ------------------- ------------------------------------------------------------------------------------------------
  **Macro**           **Description**
  DECLEN(m,n)         Calculates the minimum number of bytes necessary to hold a decimal ( m = precision, n = scale)
  DECLENGTH(length)   Calculates the minimum number of bytes necessary to hold a decimal, given the encoded length
  DECPREC(size)       Calculates a default precision, given the size (the number of bytes used to store a number)
  PRECTOT(length)     Returns the precision from an encoded length
  PRECDEC(length)     Returns the scale from an encoded length
  PRECMAKE(p,s)       Returns the encoded decimal length from a precision and scale
  ------------------- ------------------------------------------------------------------------------------------------

### [Datetime/Interval related macros]{#DTMACROS}

Datetime and Interval need qualifiers (ex: YEAR TO MONTH) to complete
the type definition. The following macros can be used to manage those
qualifiers and set the qt_qual or in_qual members of dtime_t and
intrvl_t structures.

  ----------------------- -------------------------------------------------------
  **Macro**               **Description**
  TU_YEAR                 Defines the YEAR qualifier
  TU_MONTH                Defines the MONTH qualifier
  TU_DAY                  Defines the DAY qualifier
  TU_HOUR                 Defines the HOUR qualifier
  TU_MINUTE               Defines the MINUTE qualifier
  TU_SECOND               Defines the SECOND qualifier
  TU_FRAC                 Defines default FRACTION(3) qualifier
  TU_F1                   Defines the FRACTION(1) qualifier
  TU_F2                   Defines the FRACTION(2) qualifier
  TU_F3                   Defines the FRACTION(3) qualifier
  TU_F4                   Defines the FRACTION(4) qualifier
  TU_F5                   Defines the FRACTION(5) qualifier
  TU_END(q)               Returns the end qualifier of a composed qualifier
  TU_START(q)             Returns the start qualifier of a composed qualifier
  TU_LEN(q)               Returns the length in digits of a datetime qualifier
  TU_DTENCODE(q1,q2)      Build a datetime qualifier as DATETIME q1 TO q2
  TU_IENCODE(len,q1,q2)   Build an interval qualifier as INTERVAL q1(len) TO q2
  TU_CURRQUAL             Default qualifier used by current
  ----------------------- -------------------------------------------------------

### [Data type identification macros]{#DTCONST}

The following macros are used by functions like [rsetnull()](#rsetnull),
[risnull()](#risnull), [rtypalign()](#rtypalign),
[rtypmsize()](#rtypmsize):

+----------------+-----------------------------------+
| **SQL Types**                                      |
+----------------+-----------------------------------+
| **Macro name** | **Description**                   |
+----------------+-----------------------------------+
| SQLBOOL        | SQL BOOLEAN data type             |
+----------------+-----------------------------------+
| SQLINFXBIGINT  | SQL BIGINT data type              |
+----------------+-----------------------------------+
| SQLCHAR        | SQL CHAR data type                |
+----------------+-----------------------------------+
| SQLSMINT       | SQL SMALLINT data type            |
+----------------+-----------------------------------+
| SQLINT         | SQL INTEGER data type             |
+----------------+-----------------------------------+
| SQLFLOAT       | SQL FLOAT data type               |
+----------------+-----------------------------------+
| SQLSMFLOAT     | SQL SMALLFLOAT data type          |
+----------------+-----------------------------------+
| SQLDECIMAL     | SQL DECIMAL data type             |
+----------------+-----------------------------------+
| SQLSERIAL      | SQL SERIAL data type              |
+----------------+-----------------------------------+
| SQLDATE        | SQL DATE data type                |
+----------------+-----------------------------------+
| SQLMONEY       | SQL MONEY data type               |
+----------------+-----------------------------------+
| SQLDTIME       | SQL DATETIME data type            |
+----------------+-----------------------------------+
| SQLBYTES       | SQL BYTE data type                |
+----------------+-----------------------------------+
| SQLTEXT        | SQL TEXT data type                |
+----------------+-----------------------------------+
| SQLVCHAR       | SQL VARCHAR data type             |
+----------------+-----------------------------------+
| SQLINTERVAL    | SQL INTERVAL data type            |
+----------------+-----------------------------------+
| SQLNCHAR       | SQL NCHAR data type               |
+----------------+-----------------------------------+
| SQLNVCHAR      | SQL NVARCHAR data type            |
+----------------+-----------------------------------+
| SQLINT8        | SQL INT8 data type                |
+----------------+-----------------------------------+
| SQLSERIAL8     | SQL SERIAL8 data type             |
+----------------+-----------------------------------+
| **C Types**                                        |
+----------------+-----------------------------------+
| **Macro name** | **Description**                   |
+----------------+-----------------------------------+
| CBOOLTYPE      | C boolean data type (signed char) |
+----------------+-----------------------------------+
| CBIGINTTYPE    | C bigint data type (long long)    |
+----------------+-----------------------------------+
| CCHARTYPE      | C char data type                  |
+----------------+-----------------------------------+
| CSHORTTYPE     | C short int data type             |
+----------------+-----------------------------------+
| CINTTYPE       | C int4 data type                  |
+----------------+-----------------------------------+
| CLONGTYPE      | C long data type                  |
+----------------+-----------------------------------+
| CFLOATTYPE     | C float data type                 |
+----------------+-----------------------------------+
| CDOUBLETYPE    | C double data type                |
+----------------+-----------------------------------+
| CDECIMALTYPE   | C dec_t data type                 |
+----------------+-----------------------------------+
| CFIXCHARTYPE   | C fixchar data type               |
+----------------+-----------------------------------+
| CSTRINGTYPE    | C string data type                |
+----------------+-----------------------------------+
| CDATETYPE      | C int4/date data type             |
+----------------+-----------------------------------+
| CMONEYTYPE     | C dec_t data type                 |
+----------------+-----------------------------------+
| CDTIMETYPE     | C dtime_t data type               |
+----------------+-----------------------------------+
| CLOCATORTYPE   | C loc_t data type                 |
+----------------+-----------------------------------+
| CVCHARTYPE     | C varchar data type               |
+----------------+-----------------------------------+
| CINVTYPE       | C intrvl_t data type              |
+----------------+-----------------------------------+

------------------------------------------------------------------------

## [Calling C functions from BDL]{#CFCALL}

With C-Extensions you can call C functions from the program in the same
way that you call normal [functions](Functions.html).

The C functions that can be called from BDL must use the following
signature:

    int function-name( int )

Note that *function-name* must be written in lowercase letters. The
fglcomp compiler converts all BDL functions names to lowercase.

The C function must be declared in the **usrFunctions** array in the [C
Interface File](#CEXTFILE), as described below.

------------------------------------------------------------------------

## [Calling BDL functions from C]{#FGLCALL}

It is possible to call an [BDL function](Functions.html) from a C
function, by using the **fgl_call** macro in your C function, as
follows:

    fgl_call ( function-name, nbparams );

*function-name* is the name of the BDL function to call, and *nbparams*
is the number of parameters pushed on the stack for the BDL function.

Note that *function-name* must be written in lowercase letters (The
fglcomp compiler converts all BDL functions names to lowercase)

The fgl_call macro is converted to a function that returns the number of
values returned on the stack. The BDL function parameters must be pushed
on the stack before the call, and the return values must be popped from
the stack after returning. See [Calling C functions from BDL](#CFCALL)
for more details about push and pop library functions.

#### Example:

``` linenumber
01 #include <stdio.h>
02 #include <f2c/fglExt.h>
03 int c_fct( int n )
04 {
05    int rc, r1, r2;
06       pushint(123456);
07    rc = fgl_call( fgl_fct, 1 );
08    if (rc != 2) ... error ...
09    popint(&r1);
10    popint(&r2);
11    return 0;
12 }
```

------------------------------------------------------------------------

## [Sharing global variables]{#SHARING_GLOBALS}

In order to share the global variables declared in your BDL program, you
must do the following:

1\. Generate the .c and .h interface files by using **fglcomp -G** with
the BDL module defining the global variables:

``` linenumber
01 GLOBALS
02 DEFINE g_name CHAR(100)
03 END GLOBALS
```

    fglcomp -G myglobals.4gl

This will produce two files named **myglobals.h** and **myglobals.c**.

2\. In the C module, include the generated header file and use the
global variables directly:

``` linenumber
01 #include <string.h>
02 #include <f2c/fglExt.h>
03 #include "myglobals.h"
04
05 int myfunc1(int c)
06 {
07    strcpy(g_name, "new name");
08    return 0;
09 }
```

3\. When creating the C Extension library, compile and link with the
myglobals.c generated file.

**Tip:** It is not recommended to use global variables, because it makes
your code much more difficult to maintain. If you need persistent
variables, use BDL module variables and write set/get functions that you
can interface with.

------------------------------------------------------------------------

## [Example]{#EXAMPLE}

This example shows how to create a C extension library on Linux using
gcc. The command line options to compile and link shared libraries can
change depending on the operating system and compiler/linker used.

#### Create the \"split.c\" file:

``` linenumber
01 #include <string.h>
02 #include <f2c/fglExt.h>
03
04 int fgl_split( int in_num );
05 int fgl_split( int in_num )
06 {
07        char c1[101];
08        char c2[101];
09        char z[201];
10        char *ptr_in;
11        char *ptr_out;
12        popvchar(z, 200); /* Getting input parameter */
13        strcpy(c1, "");
14        strcpy(c2, "");
15        ptr_out = c1;
16        ptr_in = z;
17        while (*ptr_in != ' ' && *ptr_in != '\0')
18        {
19                *ptr_out = *ptr_in;
20                ptr_out++;
21                ptr_in++;
22        }
23        *ptr_out=0;
24        ptr_in++;
25        ptr_out = c2;
26        while (*ptr_in != '\0')
27        {
28                *ptr_out = *ptr_in;
29                ptr_out++;
30                ptr_in++;
31        }
32        *ptr_out=0;
33        pushvchar(c1, 100); /* Returning the first output parameter */
34        pushvchar(c2, 100); /* Returning the second output parameter */
35        return 2; /* Returning the number of output parameters (MANDATORY) */
36 }
```

#### Create the \"splitext.c\" C interface file:

``` linenumber
01 #include <f2c/fglExt.h>
02 
03 int fgl_split(int);
04 
05 UsrFunction usrFunctions[]={
06   { "fgl_split", fgl_split, 1, 2 },
07   { 0,0,0,0 }
08 };
```

#### Compile the C Module and the interface file:

    gcc -c -I $FGLDIR/include -fPIC split.c
    gcc -c -I $FGLDIR/include -fPIC splitext.c

#### Create the shared library:

    gcc -shared -o libsplit.so split.o splitext.o -L$FGLDIR/lib -lfgl

#### Create the BDL program \"split.4gl\":

``` linenumber
01 IMPORT libsplit
02 MAIN
03       DEFINE str1, str2 VARCHAR(100)
04       CALL fgl_split("Hello World") RETURNING str1, str2
05       DISPLAY "1: ", str1
06       DISPLAY "2: ", str2
07 END MAIN
```

#### Compile the 4gl module:

    fglcomp split.4gl

#### Run the program without the -e option:

    fglrun split

------------------------------------------------------------------------

## [C API Functions]{#CAPI}

  -------------------------------------- -----------------------------------------------------------------------------------------------------------------
  **Function**                           **Description**
  [bycmpr()](#bycmpr)                    Compares two groups of contiguous bytes
  [byleng()](#byleng)                    Returns the number of bytes as significant characters in the specified string
  [bycopy()](#bycopy)                    Copies a specified number of bytes to another location in memory
  [byfill()](#byfill)                    Fills a specified number of bytes in memory
  [risnull()](#risnull)                  Checks whether a given value is NULL
  [rsetnull()](#rsetnull)                Sets a variable to NULL for a given data type
  [rgetmsg()](#rgetmsg)                  Returns a message text
  [rgetlmsg()](#rgetlmsg)                Returns a message text
  [rtypalign()](#rtypalign)              Returns the position to align a variable at the proper boundary for its data type
  [rtypmsize()](#rtypmsize)              Returns the size in bytes required for a specified data type
  [rtypname()](#rtypname)                Returns the name of a specified data type
  [rtypwidth()](#rtypwidth)              Returns the minimum number of characters required to convert a specified data type to a character data type
  [rdatestr()](#rdatestr)                Converts a date to a string
  [rdayofweek()](#rdayofweek)            Returns the week day of a date
  [rdefmtdate()](#rdefmtdate)            Converts a string to a date by using a specific format
  [ifx_defmtdate()](#ifx_defmtdate)      Converts a string to a date by using a specific format, with century option
  [rfmtdate()](#rfmtdate)                Converts a date to a string by using a specific format
  [rjulmdy()](#rjulmdy)                  Extracts month, day and year from a date
  [rleapyear()](#rleapyear)              Checks whether a year is a leap year
  [rmdyjul()](#rmdyjul)                  Builds a date from month, day, year
  [rstrdate()](#rstrdate)                Converts a string to a date
  [ifx_strdate()](#ifx_strdate)          Converts a date to a string by using a specific format, with the century option
  [rtoday()](#rtoday)                    Returns the current date
  [ldchar()](#ldchar)                    Copies a fixed-length string into a null-terminated string without trailing spaces
  [rdownshift()](#rdownshift)            Converts a string to lowercase characters
  [rfmtdouble()](#rfmtdouble)            Formats a double value in a specified format
  [rfmtint4()](#rfmtint4)                Formats a 4-byte int value in a specified format
  [rstod()](#rstod)                      Converts a string to a double
  [rstoi()](#rstoi)                      Converts a string to a 2-byte integer (but it takes an int pointer as parameter!)
  [rstol()](#rstol)                      Converts a string to a 4-byte integer (but it takes an long pointer as parameter!)
  [rupshift()](#rupshift)                Converts a string to uppercase characters
  [stcat()](#stcat)                      Concatenates a null-terminated string to another
  [stchar()](#stchar)                    Concatenates a null-terminated string to a fixed char
  [stcmpr()](#stcmpr)                    Compares two strings
  [stcopy()](#stcopy)                    Copies a string into another
  [stleng()](#stleng)                    Returns the number of bytes of significant characters, including trailing spaces
  [decadd()](#decadd)                    Adds two decimals
  [deccmp()](#deccmp)                    Compares two decimals
  [deccopy()](#deccopy)                  Copies one decimal into another
  [deccvasc()](#deccvasc)                Converts a string to a decimal
  [deccvdbl()](#deccvdbl)                Converts a double to a decimal
  [deccvflt()](#deccvflt)                Converts a float to a decimal
  [deccvint()](#deccvint)                Converts a 4-byte integer to a decimal (parameter is a machine-dependent int pointer)
  [deccvlong()](#deccvlong)              Converts a 4-byte integer to a decimal
  [decdiv()](#decdiv)                    Divides a decimal by another decimal
  [dececvt()](#dececvt)                  To convert a decimal value to a string value, specifying the length of the string (the total number of digits)
  [decfcvt()](#decfcvt)                  To convert a decimal value to a string value, specifying the number of digits to the right of the decimal point
  [decmul()](#decmul)                    Multiplies a decimal by another
  [decround()](#decround)                Rounds a decimal to the specified number of digits
  [decsub()](#decsub)                    Subtracts two decimals
  [dectoasc()](#dectoasc)                Formats a decimal
  [dectodbl()](#dectodbl)                Converts a decimal to a double
  [dectoflt()](#dectoflt)                Converts a decimal to a float
  [dectoint()](#dectoint)                Converts a decimal to a 2-byte integer (parameter is machine-dependent int pointer)
  [dectolong()](#dectolong)              Converts a decimal to a 4-byte integer
  [dectrunc()](#dectrunc)                Truncates a decimal to a given number of digits
  [rfmtdec()](#rfmtdec)                  Formats a decimal
  [dtaddinv](#dtaddinv)[()](#dtaddinv)   Adds an interval to a datetime
  [dtcurrent()](#dtcurrent)              Returns the current datetime
  [dtcvasc()](#dtcvasc)                  Converts a string in ISO format to a datetime
  [ifx_dtcvasc()](#ifx_dtcvasc)          Converts a string in ISO format to a datetime, with century option
  [dtcvfmtasc()](#dtcvfmtasc)            Converts a string to a datetime by using a specific format
  [ifx_dtcvfmtasc()](#ifx_dtcvfmtasc)    Converts a string to a datetime by using a specific format, with the century option
  [dtextend()](#dtextend)                Extends a datetime
  [dtsub()](#dtsub)                      Subtracts a datetime from another datetime
  [dtsubinv()](#dtsubinv)                Subtracts an interval from a datetime
  [dttoasc()](#dttoasc)                  Formats a datetime in ISO format
  [dttofmtasc()](#dttofmtasc)            Formats a datetime in a specified format
  [ifx_dttofmtasc()](#ifx_dttofmtasc)    Formats a datetime in a specified format, with the century option
  [incvasc()](#incvasc)                  Converts a string in ISO format to an interval
  [incvfmtasc()](#incvfmtasc)            Converts a string to an interval by using a specific format
  [intoasc()](#intoasc)                  Formats an interval in ISO format
  [intofmtasc()](#intofmtasc)            Formats an interval in a specified format
  [invdivdbl()](#invdivdbl)              Divides an interval by using a double
  [invdivinv()](#invdivinv)              Divides an interval by using another interval
  [invextend()](#invextend)              Extends an interval
  [invmuldbl()](#invmuldbl)              Multiplies an interval by a double
  -------------------------------------- -----------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------

### [decadd]{#decadd}()

#### Purpose:

To add two decimal values

#### Syntax:

    mint decadd(dec_t *n1, struct decimal *n2, struct decimal *n3);

#### Notes:

1.  *n1* is a pointer to the decimal structure of the first operand.
2.  *n2* is a pointer to the decimal structure of the second operand.
3.  *n3* is a pointer to the decimal structure that contains the sum
    (*n1* + *n2*).

#### Returns:

  ---------- --------------------------------------
  **Code**   **Description**
  0          The operation was successful.
  -1200      The operation resulted in overflow.
  -1201      The operation resulted in underflow.
  ---------- --------------------------------------

------------------------------------------------------------------------

### [decsub]{#decsub}()

#### Purpose:

To subtract two decimal values

#### Syntax:

    mint decsub(dec_t *n1, struct decimal *n2, struct decimal *n3);

#### Notes:

1.  *n1* is a pointer to the decimal structure of the first operand.
2.  *n2* is a pointer to the decimal structure of the number to be
    subtracted.
3.  *n3* is a pointer to the decimal structure that contains the result
    of (*n1* minus *n2*).

#### Returns:

  ---------- --------------------------------------
  **Code**   **Description**
  0          The operation was successful.
  -1200      The operation resulted in overflow.
  -1201      The operation resulted in underflow.
  ---------- --------------------------------------

------------------------------------------------------------------------

### [decmul]{#decmul}()

#### Purpose:

To multiply two decimal values

#### Syntax:

    int decmul(dec_t *n1, struct decimal *n2, struct decimal *n3);

#### Notes:

1.  *n1* is a pointer to the decimal structure of the first operand.
2.  *n2* is a pointer to the decimal structure of the second operand.
3.  *n3* is a pointer to the decimal structure that contains the product
    of (*n1* times *n2*).

#### Returns:

  ---------- --------------------------------------
  **Code**   **Description**
  0          The operation was successful.
  -1200      The operation resulted in overflow.
  -1201      The operation resulted in underflow.
  ---------- --------------------------------------

------------------------------------------------------------------------

### [decdiv]{#decdiv}()

#### Purpose:

To divide one decimal value by another(*n1* divided by *n2*)

#### Syntax:

    mint decdiv(dec_t *n1, struct decimal *n2, struct decimal *n3);

#### Notes:

1.  *n1* is a pointer to the decimal structure of the number to be
    divided.
2.  *n2* is a pointer to the decimal structure of the number that is the
    divisor.
3.  *n3* is a pointer to the decimal structure that contains the
    quotient of (*n1* divided by *n2*).

#### Returns:

  ---------- --------------------------------------------
  **Code**   **Description**
  0          The operation was successful.
  -1200      The operation resulted in overflow.
  -1201      The operation resulted in underflow.
  -1202      The operation attempted to divide by zero.
  ---------- --------------------------------------------

------------------------------------------------------------------------

### [deccmp]{#deccmp}()

#### Purpose:

To compare two decimal values

#### Syntax:

    mint deccmp(dec_t *n1, struct decimal *n2);

#### Notes:

1.  *n1* is a pointer to the decimal structure of the first number to
    compare.
2.  *n2* is a pointer to the decimal structure of the second number to
    compare.

#### Returns:

  ---------- ---------------------------------------------------
  **Code**   **Description**
  0          The two values are identical.
  1          The first value is greater than the second value.
  -1         The first value is less than the second value.
  -2         Either value is null.
  ---------- ---------------------------------------------------

------------------------------------------------------------------------

### [deccopy]{#deccopy}()

#### Purpose:

To copy one decimal value to another

#### Syntax:

    void deccopy(dec_t *n1, struct decimal *n2);

#### Notes:

1.  *n1* is a pointer to the value held in the source decimal structure.
2.  *n2* is a pointer to the target decimal structure.

------------------------------------------------------------------------

### [deccvasc]{#deccvasc}()

#### Purpose:

To convert a string value to a decimal

#### Syntax:

    mint deccvasc(char *cp, mint len, dec_t *np);

#### Notes:

1.  *cp* is a pointer to a string to be converted to a decimal value.
2.  *len* is the length of the string.
3.  *np* is a pointer to the decimal structure which contains the result
    of the conversion.

#### Returns:

  ---------- ---------------------------------------------------------------
  **Code**   **Description**
  0          The conversion was successful.
  -1200      The number is too large to fit into a decimal type structure.
  ---------- ---------------------------------------------------------------

------------------------------------------------------------------------

### [deccvdbl]{#deccvdbl}()

#### Purpose:

To convert a double value to a decimal

#### Syntax:

    mint deccvdbl(double dbl, dec_t *np);

#### Notes:

1.  *dbl* is the double value to convert to a decimal type value.
2.  *np* is a pointer to a decimal structure containing the result of
    the conversion.

#### Returns:

  ---------- --------------------------------
  **Code**   **Description**
  0          The conversion was successful.
  \<0        The conversion failed.
  ---------- --------------------------------

------------------------------------------------------------------------

### [deccvint]{#deccvint}()

#### Purpose:

To convert a 4-byte integer value to a decimal

#### Syntax:

    mint deccvint(mint in, dec_t *np);

#### Notes:

1.  *in* is the mint value to convert to a decimal type value.
2.  *np* is a pointer to a decimal structure to contain the result of
    the conversion.

#### Returns:

  ---------- --------------------------------
  **Code**   **Description**
  0          The conversion was successful.
  \<0        The conversion failed.
  ---------- --------------------------------

------------------------------------------------------------------------

### [deccvlong]{#deccvlong}()

#### Purpose:

To convert a 4-byte integer value to a decimal

#### Syntax:

    mint deccvlong(int4 lng, dec_t *np);

#### Notes:

1.  *lng* is the int4 value to convert to a decimal type value.\
    *np* is a pointer to a decimal structure to contain the result of
    the conversion.

#### Returns:

  ---------- --------------------------------
  **Code**   **Description**
  0          The conversion was successful.
  \<0        The conversion failed.
  ---------- --------------------------------

**Warning: Even if the function name is \"deccvlong\", it takes a 4-byte
int as argument.**

------------------------------------------------------------------------

### [dececvt]{#dececvt}()

#### Purpose:

To convert a decimal value to a string value, specifying the length of
the string (the total number of digits)

#### Syntax:

    char *dececvt(dec_t *np, mint ndigit, mint *decpt, mint *sign);

#### Notes:

1.  *np* is a pointer to a decimal structure that contains the decimal
    value you want to convert.
2.  *ndigit* is the length of the ASCII string.
3.  *decpt* is a pointer to an integer that is the position of the
    decimal point relative to the start of the string. A negative or
    zero value for\
    *decpt* means to the left of the returned digits.
4.  *sign* is a pointer to the sign of the result. If the sign of the
    result is negative, *sign* is nonzero; otherwise, *sign* is zero.

#### Returns:

This function returns a pointer to the result string. This string is
temporary and has to be copied into your own string buffer.

------------------------------------------------------------------------

### [decfcvt]{#decfcvt}()

#### Purpose:

To convert a decimal value to a string value, specifying the number of
digits to the right of the decimal point

#### Syntax:

    char *decfcvt(dec_t *np, mint ndigit, mint *decpt, mint *sign);

#### Notes:

1.  *np* is a pointer to a decimal structure that contains the decimal
    value you want to convert.
2.  *ndigit* is the number of digits to the right of the decimal point.
3.  *decpt* is a pointer to an integer that is the position of the
    decimal point relative to the start of the string. A negative or
    zero value for\
    *decpt* means to the left of the returned digits.
4.  *sign* is a pointer to the sign of the result. If the sign of the
    result is negative, *sign* is nonzero; otherwise, *sign* is zero.

#### Returns:

This function returns a pointer to the result string. This string is
temporary and has to be copied into your own string buffer.

------------------------------------------------------------------------

### [decround]{#decround}()

#### Purpose:

To round a decimal value, specifying the number of digits to the right
of the decimal point

#### Syntax:

    void decround(dec_t *np, mint dec_round);

#### Notes:

1.  *np* is a pointer to a decimal structure whose value is to be
    rounded. Use a positive number for the *np* argument.
2.  *dec_round* is the number of fractional digits to which the value is
    rounded.

------------------------------------------------------------------------

### [dectoasc]{#dectoasc}()

#### Purpose:

To convert a decimal value to an ASCII string, specifying the length of
the string and the number of digits to the right of the decimal point

#### Syntax:

    mint dectoasc(dec_t *np, char *cp, mint len, mint right);

#### Notes:

1.  *np* is a pointer to the decimal structure to convert to a text
    string.
2.  *cp* is a pointer to the first byte of the character buffer to hold
    the text string.
3.  *len* is the size of strng_val, in bytes, minus 1 for the null
    terminator.
4.  *right* is an integer that indicates the number of decimal places to
    the right of the decimal point.
5.  Because the character string that dectoasc() returns is not null
    terminated, your program must add a null character to the string
    before you print it.

#### Returns:

  ---------- --------------------------------
  **Code**   **Description**
  0          The conversion was successful.
  \<0        The conversion failed.
  ---------- --------------------------------

------------------------------------------------------------------------

### [dectodbl]{#dectodbl}()

#### Purpose:

To convert a decimal value to a double value

#### Syntax:

    mint dectodbl(dec_t *np, double *dblp);

#### Notes:

1.  *np* is a pointer to the decimal structure to convert to a double
    type value.
2.  *dblp* is a pointer to a double type where dectodbl() places the
    result of the conversion.

#### Returns:

  ---------- --------------------------------
  **Code**   **Description**
  0          The conversion was successful.
  \<0        The conversion failed.
  ---------- --------------------------------

------------------------------------------------------------------------

### [dectoint]{#dectoint}()

#### Purpose:

To convert a decimal value to a SMALLINT equivalent (2-byte integer)

#### Syntax:

    mint dectoint2(dec_t *np, mint *ip);

#### Notes:

1.  *np* is a pointer to the decimal structure to convert to a mint type
    value.
2.  *ip* is a pointer to a mint value where dectoint() places the result
    of the conversion.

#### Returns:

  ---------- -----------------------------------------------------------------
  **Code**   **Description**
  0          The conversion was successful.
  \<0        The conversion failed.
  -1200      The magnitude of the decimal type number is greater than 32767.
  ---------- -----------------------------------------------------------------

**Warning: This functions takes a machine-dependent int pointer as
argument (usually 4 bytes), but converts the decimal to a SMALLINT
equivalent, with possible overflow errors.**

------------------------------------------------------------------------

### [dectolong]{#dectolong}()

#### Purpose:

To convert a decimal value to a long integer

#### Syntax:

    mint dectolong(dec_t *np, int4 *lngp);

#### Notes:

1.  *np* is a pointer to the decimal structure to convert to an int4
    integer.
2.  *lngp* is a pointer to an int4 integer where dectolong() places the
    result of the conversion.

#### Returns:

  ---------- -------------------------------------------------------------------------
  **Code**   **Description**
  0          The conversion was successful.
  \<0        The conversion failed.
  -1200      The magnitude of the decimal type number is greater than 2,147,483,647.
  ---------- -------------------------------------------------------------------------

**Warning: Even if the function name is \"dectolong\", it takes a 4-byte
int pointer as argument, and converts the decimal to an INTEGER
equivalent.**

------------------------------------------------------------------------

### [dectrunc]{#dectrunc}()

#### Purpose:

To truncate a decimal value, specifying the number of digits to the
right of the decimal point

#### Syntax:

    void dectrunc(dec_t *np, mint trunc);

#### Notes:

1.  *np* is a pointer to the decimal structure for a rounded number to
    truncate.
2.  *trunc* is the number of fractional digits to which dectrunc()
    truncates the number. Use a positive number or zero for this
    argument.

------------------------------------------------------------------------

### [deccvflt]{#deccvflt}()

#### Purpose:

[To convert a float to a decimal
value]{style="background-color: #FFFFFF"}

#### Syntax:

    mint deccvflt(float source, dec_t *destination);

#### Notes:

1.  *source* is the float value to be converted.
2.  *destination* is a pointer to the structure where the decimal value
    is placed.

#### Returns:

  ---------- --------------------------------
  **Code**   **Description**
  0          The conversion was successful.
  \<0        The conversion failed.
  ---------- --------------------------------

------------------------------------------------------------------------

### [dectoflt]{#dectoflt}()

#### Purpose:

#### [To convert a decimal value to a float]{style="background-color: #FFFFFF"}

#### Syntax:

    mint dectoflt(dec_t *source, float *destination);

#### Notes:

1.  *source* is a pointer to the decimal value to convert.
2.  *destination* is a pointer to the resulting float value.

#### Returns:

  ---------- --------------------------------
  **Code**   **Description**
  0          The conversion was successful.
  \<0        The conversion failed.
  ---------- --------------------------------

------------------------------------------------------------------------

### [rfmtdec]{#rfmtdec}()

#### Purpose:

To convert a decimal value to a string having a specified format

#### Syntax:

    int rfmtdec(dec_t *dec, char *format, char *outbuf);

#### Notes:

1.  *dec* is a pointer to the decimal value to format.
2.  *format* is a pointer to a character buffer that contains the
    formatting mask to use.
3.  *outbuf* is a pointer to a character buffer that receives the
    resulting formatted string.

#### Returns:

  ---------- ----------------------------------------------------------
  **Code**   **Description**
  0          The conversion was successful.
  \<0        The conversion failed.
  -1211      The program ran out of memory (memory-allocation error).
  -1217      The format string is too large.
  ---------- ----------------------------------------------------------

------------------------------------------------------------------------

### [bycmpr]{#bycmpr}()

#### Purpose:

To compare two groups of contiguous bytes, for a specified length,
byte-by-byte.

#### Syntax:

    mint bycmpr(char *st1, char *st2, mint count);

#### Notes:

1.  *st1* is a pointer to the location where the first group of bytes
    starts.
2.  *st2* is a pointer to the location where the second group of bytes
    starts.
3.  *count* is the number of bytes to compare.

#### Returns:

  ---------- ----------------------------------------------------------
  **Code**   **Description**
  0          The two groups of bytes are identical.
  1          The *st1* group of bytes is less than the *st2* group.
  -1         The *st1* group of bytes is greater than the *st2*group.
  ---------- ----------------------------------------------------------

------------------------------------------------------------------------

### [bycopy]{#bycopy}()

#### Purpose:

To copy a specified number of bytes to another location in memory

#### Syntax:

    void bycopy(char *s1, char *s2, mint n);

#### Notes:

1.  *s1* is a pointer to the first byte of the group of bytes that you
    want to copy.
2.  *s2* is a pointer to the first byte of the destination group of
    bytes.\
    If the location pointed to by *s2* overlaps the location pointed to
    by *s1*, the function will not preserve the value of *s1*.
3.  *n* is the number of bytes to be copied.

**Warning: Do not overwrite the memory areas adjacent to the destination
area.**

------------------------------------------------------------------------

### [byfill]{#byfill}()

#### Purpose:

To fill a specified number of bytes with a specified character

#### Syntax:

    void byfill(char *s1, mint n, char c);

#### Notes:

1.  *s1* is a pointer to the first byte of the memory area that you want
    to fill.\
    *n* is the number of times that you want to repeat the character
    within the area.\
    *c* is the character that you want to use to fill the area.

**Warning: Do not overwrite the memory areas adjacent to the destination
area.**

------------------------------------------------------------------------

### [risnull]{#risnull}()

#### Purpose:

To check whether a variable is null

#### Syntax:

    int risnull(int vtype, char *pcvar);

#### Notes:

1.  *vtype* is an integer corresponding to the data type of the
    variable.\
    This parameter must be one of the [Date Type Constants](#DTCONST)
    defined in fglExt.h.
2.  *pcvar* is a pointer to the C variable.

#### Returns:

  ---------- ---------------------------------------------
  **Code**   **Description**
  1          The variable does contain a null value.
  0          The variable does not contain a null value.
  ---------- ---------------------------------------------

------------------------------------------------------------------------

### [rsetnull]{#rsetnull}()

#### Purpose:

To set a variable to NULL

#### Syntax:

    mint rsetnull(mint vtype, char *pcvar);

#### Notes:

1.  *type* is an integer corresponding to the data type of the
    variable.\
    This parameter must be one of the [Date Type Constants](#DTCONST)
    defined in fglExt.h.
2.  *pcvar* is a pointer to the variable.

#### Returns:

  ---------- -------------------------------
  **Code**   **Description**
  0          The operation was successful.
  \<0        The operation failed.
  ---------- -------------------------------

------------------------------------------------------------------------

### [rgetmsg]{#rgetmsg}()

#### Purpose:

Returns the error message for a specified error number, restricted to
two-byte integers.

#### Syntax:

    mint rgetmsg(int msgnum, char *s, mint maxsize);

#### Notes:

1.  *msgnum* is the error number, restricted to error numbers between
    -32768 and +32767.
2.  *s* is a pointer to the buffer that receives the message string (the
    output buffer).
3.  *maxsize* is the size of the output buffer. This value should be set
    to the size of the largest message that you expect to retrieve.
4.  The Informix message text files are used to retrieve the message.

#### Returns:

  ---------- -------------------------------------------
  **Code**   **Description**
  0          The operation was successful.
  -1227      Message file not found.
  -1228      Message number not found in message file.
  -1231      Cannot seek within message file.
  -1232      Message buffer is too small.
  ---------- -------------------------------------------

**Warning: This function returns Informix specific messages; it will not
work properly if the Informix client software is not installed.**

------------------------------------------------------------------------

### [rgetlmsg]{#rgetlmsg}()

#### Purpose:

Returns the error message for a specified error number, which can be a
4-byte integer.

#### Syntax:

    int4 rgetlmsg(int msgnum, char *s, mint maxsize, mint *msg_length);

#### Notes:

1.  *msgnum* is the error number. The four-byte parameter provides for
    the full range of Informix-specific error numbers.
2.  *s* is a pointer to the buffer that receives the message string (the
    output buffer).
3.  *maxsize* is the size of the msgstr output buffer. Make this value
    the size of the largest message that you expect to retrieve.
4.  *msg_length* is a pointer to the mint that contains the actual
    length of the message that rgetlmsg() returns.

#### Returns:

  ---------- -------------------------------------------
  **Code**   **Description**
  0          The operation was successful.
  -1227      Message file not found.
  -1228      Message number not found in message file.
  -1231      Cannot seek within message file.
  -1232      Message buffer is too small.
  ---------- -------------------------------------------

**Warning: This function returns Informix specific messages; it will not
work properly if the Informix client software is not installed.**

------------------------------------------------------------------------

### [rtypalign]{#rtypalign}()

#### Purpose:

Returns the position to align a variable at the proper boundary for its
data type

#### Syntax:

    mlong rtypalign(mlong pos, mint datatype)

#### Notes:

1.  *pos* is the current position in the buffer.
2.  *datatype* is an integer code defining the data type.\
    This parameter must be one of the [Date Type Constants](#DTCONST)
    defined in fglExt.h.

#### Returns:

  ---------- ----------------------------------------------------------------------------------------------
  **Code**   **Description**
  \>0        The return value is the offset of the next proper boundary for a variable of type data type.
  ---------- ----------------------------------------------------------------------------------------------

------------------------------------------------------------------------

### [rtypmsize]{#rtypmsize}()

#### Purpose:

Returns the size in bytes required for a specified data type

#### Syntax:

    mint rtypmsize(mint datatype, mint length)

#### Notes:

1.  *datatype* is an integer code defining the data type.\
    This parameter must be one of the [Date Type Constants](#DTCONST)
    defined in fglExt.h.
2.  *length* is the number of bytes in the data file for the specified
    type.

#### Returns:

  ---------- ----------------------------------------------------------------------
  **Code**   **Description**
  0          The *datatype* is not a valid SQL type.
  \>0        The return value is the number of bytes that the data type requires.
  ---------- ----------------------------------------------------------------------

------------------------------------------------------------------------

### [rtypname]{#rtypname}()

#### Purpose:

Returns a pointer to a null-terminated string containing the name of the
data type

#### Syntax:

    char *rtypname(mint datatype)

#### Notes:

1.  *datatype* is an integer code defining the data type.\
    This parameter must be one of the [Date Type Constants](#DTCONST)
    defined in fglExt.h.

#### Returns:

The rtypname function returns a pointer to a string that contains the
name of the data type specified *datatype*.

If *datatype* is an invalid value, rtypname() returns a null string (\"
\").

------------------------------------------------------------------------

### [rtypwidth()]{#rtypwidth}

#### Purpose:

Returns the minimum number of characters required to convert a specified
data type to a character data type

#### Syntax:

    mint rtypwidth(mint datatype, mint length)

#### Notes:

1.  *datatype* is an integer code defining the data type.\
    This parameter must be one of the [Date Type Constants](#DTCONST)
    defined in fglExt.h.
2.  *length* is the number of bytes in the data file for the specified
    data type.

#### Returns:

  ---------- -------------------------------------------------------------------
  **Code**   **Description**
  0          The sqltype is not a valid SQL data type.
  \>0        Minimum number of characters that the sqltype data type requires.
  ---------- -------------------------------------------------------------------

------------------------------------------------------------------------

### [rdatestr]{#rdatestr}()

#### Purpose:

To convert a date that is in the native database date format to a string

#### Syntax:

`mint rdatestr(int4 `*`jdate`*`, char *`*`str`*`);`

#### Notes:

1.  *jdate* is the internal representation of the date to format.
2.  *str* is a pointer to the buffer that receives the string for the
    date value.

#### Returns:

  ---------- --------------------------------------------------------------------------
  **Code**   **Description**
  0          The conversion was successful.
  \<0        The conversion failed.
  -1210      The internal date could not be converted to the character string format.
  -1212      Data conversion format must contain a month, day, or year component.
  ---------- --------------------------------------------------------------------------

#### Usage:

The [DBDATE](EnvironmentVariables.html#EV_DBDATE) environment variable
specifies the data conversion format.

------------------------------------------------------------------------

### [rdayofweek]{#rdayofweek}()

#### Purpose:

Returns the day of the week of a date that is in the native database
format

#### Syntax:

`mint rdayofweek(int4 `*`jdate`*`);`

#### Notes:

1.  *jdate* is the internal representation of the date.

#### Returns:

  ---------- --------------------
  **Code**   **Description**
  \<0        Invalid date value
  0          Sunday
  1          Monday
  2          Tuesday
  3          Wednesday
  4          Thursday
  5          Friday
  6          Saturday
  ---------- --------------------

------------------------------------------------------------------------

### [rdefmtdate]{#rdefmtdate}()

#### Purpose:

To convert a string in a specified format to the native database date
format

#### Syntax:

`mint rdefmtdate(int4 *`*`pdate`*`, char *`*`fmt`*`, char *`*`input`*`);`

#### Notes:

1.  *pdate* is a pointer to an int4 integer value that receives the
    internal DATE value for the *input* string.
2.  *fmt* is a pointer to the buffer that contains the [formatting
    mask](#FMT_DATE) for the string.
3.  *input* is a pointer to the buffer that contains the string to
    convert.

#### Returns:

  ---------- ---------------------------------------------------------------------------------------------------------------------------------------
  **Code**   **Description**
  0          The operation was successful.
  -1204      The *input* parameter specifies an invalid year.
  -1205      The *input* parameter specifies an invalid month.
  -1206      The *input* parameter specifies an invalid day.
  -1209      Because *input* does not contain delimiters between the year,month,and day, the length of *input* must be exactly six or eight bytes.
  -1212      *fmt* does not specify a year, a month, and a day.
  ---------- ---------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------

### [rfmtdate]{#rfmtdate}()

#### Purpose:

To convert a date that is in the native database date format to a string
having a specified format

#### Syntax:

`mint rfmtdate(int4 `*`jdate`*`, char *`*`fmt`*`, char *`*`result`*`);`

#### Notes:

1.  *jdate* is the internal representation of a date to convert.
2.  *fmt* is a pointer to the buffer containing the [formatting
    mask](#FMT_DATE).
3.  *result* is a pointer to the buffer that receives the formatted
    string.

#### Returns:

  ---------- -----------------------------------------------------------------
  **Code**   **Description**
  0          The operation was successful.
  -1210      The internal date cannot be converted to month-day-year format.
  -1211      The program ran out of memory (memory-allocation error).
  -1212      Format string is NULL or invalid.
  ---------- -----------------------------------------------------------------

------------------------------------------------------------------------

### [rjulmdy]{#rjulmdy}()

#### Purpose:

To create an array of short integer values representing year, month, and
day from a date that is in the native database date format

#### Syntax:

`mint rjulmdy(int4 `*`jdate`*`, int2 `*`mdy`*`[3]`*`)`*`;`

#### Notes:

1.  *jdate* is the internal representation of a date.
2.  *mdy* is an array of short integers, where mdy\[0\] is the month (1
    to 12), mdy\[1\] is the day (1 to 31), and mdy\[2\] is the year (1
    to 9999).

#### Returns:

  ---------- --------------------------------------------------------------------------
  **Code**   **Description**
  1          The year is a leap year.
  0          The operation was successful.
  \<0        The operation failed.
  -1210      The internal date could not be converted to the character string format.
  ---------- --------------------------------------------------------------------------

------------------------------------------------------------------------

### [rleapyear]{#rleapyear}()

#### Purpose:

To determine whether the value passed as a parameter is a leap year;
returns 1 when TRUE.

#### Syntax:

`mint rleapyear(mint `*`year`*`);`

#### Notes:

1.  year is an integer, representing the year component of a date, in
    the full form yyyy (i.e., 2004).

#### Returns:

  ---------- ------------------------------
  **Code**   **Description**
  1          The year is a leap year.
  0          The year is not a leap year.
  ---------- ------------------------------

------------------------------------------------------------------------

### [rmdyjul]{#rmdyjul}()

#### Purpose:

To create a value in the native database date format from an array of
short integer values representing month, day, and year

#### Syntax:

`mint rmdyjul(int2 `*`mdy`*`[3], int4 *`*`jdate`*`);`

#### Notes:

1.  *mdy* is an array of short integer values, where *mdy*\[0\] is the
    month (1 to12), *mdy*\[1\] is the day (1 to 31), and *mdy*\[2\] is
    the year (1 to 9999).
2.  *jdate* is a pointer to a long integer that receives the internal
    DATE value for the *mdy* array.

#### Returns:

  ---------- ----------------------------------------------------
  **Code**   **Description**
  0          The operation was successful.
  -1204      The *mdy*\[2\] variable contains an invalid year.
  -1205      The *mdy*\[0\] variable contains an invalid month.
  -1206      The *mdy*\[1\] variable contains an invalid day.
  ---------- ----------------------------------------------------

------------------------------------------------------------------------

### [rstrdate]{#rstrdate}()

#### Purpose:

To convert a character string to the native database date format.

#### Syntax:

`mint rstrdate(char *`*`str`*`, int4 *`*`jdate`*`);`

#### Notes:

1.  *str* is a pointer to a char string containing the date to convert.
2.  *jdate* is a pointer to an int4 integer that receives the converted
    date value.

#### Returns:

  ---------- -------------------------------------------------------------------------------------------------------------------
  **Code**   **Description**
  0          The conversion was successful.
  \<0        The conversion failed.
  -1204      The *str* parameter specifies an invalid year.
  -1205      The *str* parameter specifies an invalid month.
  -1206      The *str* parameter specifies an invalid day.
  -1212      Data conversion format must contain a month, day, or year component. DBDATE specifies the data conversion format.
  -1218      The date specified by the *str* argument does not properly represent a date.
  ---------- -------------------------------------------------------------------------------------------------------------------

#### Usage:

The [DBDATE](EnvironmentVariables.html#EV_DBDATE) environment variable
specifies the data conversion format.

------------------------------------------------------------------------

### [rtoday]{#rtoday}()

#### Purpose:

Returns the system date in the internal database date format

#### Syntax:

`void rtoday(int4 *`*`today`*`);`

#### Notes:

1.  *today* is a pointer to an int4 value that receives the internal
    date.

------------------------------------------------------------------------

### [ifx_defmtdate]{#ifx_defmtdate}()

#### Purpose:

To convert a string in a specified format to the native database date
format; allows you to specify the century setting for two-digit dates.

#### Syntax:

`mint ifx_defmtdate(int4 *`*`pdate`*`, char *`*`fmt`*`, char *`*`input`*`, char `*`c`*`);`

#### Notes:

1.  *pdate* is a pointer to an int4 integer value that receives the
    internal DATE value for the *input* string.
2.  *fmt* is a pointer to the buffer that contains the [formatting
    mask](#FMT_DATE) to use for the *input* string.
3.  *input* is a pointer to the buffer that contains the date string to
    convert.
4.  *c* is one of [CENTURY](EnvironmentVariables.html#EV_DBCENTURY)
    characters, which determines which century to apply to the year
    portion of the date.

#### Returns:

  ---------- -----------------------------------------------------------------------------------------------------------------------------------------
  **Code**   **Description**
  0          The conversion was successful.
  \<0        The conversion failed.
  -1204      The *str* parameter specifies an invalid year.
  -1205      The *str* parameter specifies an invalid month.
  -1206      The *str* parameter specifies an invalid day.
  -1212      Data conversion format must contain a month, day, or year component. DBDATE specifies the data conversion format.
  -1209      Because \*input does not contain delimiters between the year, month, and day, the length of \*input must be exactly six or eight bytes.
  ---------- -----------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------

### [ifx_strdate]{#ifx_strdate}()

#### Purpose:

To convert a character string to the native database date format; allows
you to specify the century setting for two-digit dates.

#### Syntax:

`mint ifx_strdate(char *`*`str`*`, int4 *`*`jdate`*`, char `*`c`*`);`

#### Notes:

1.  *str* is a pointer to the string that contains the date to convert.
2.  *jdate* is a pointer to a int4 integer that receives the internal
    DATE value for the *str* string.
3.  *c* is one of [CENTURY](EnvironmentVariables.html#EV_DBCENTURY)
    characters, which determines which century to apply to the year
    portion of the date.

#### Returns:

  ---------- -------------------------------------------------------------------------------------------------------------------
  **Code**   **Description**
  0          The conversion was successful.
  \<0        The conversion failed.
  -1204      The *str* parameter specifies an invalid year.
  -1205      The *str* parameter specifies an invalid month.
  -1206      The *str* parameter specifies an invalid day.
  -1212      Data conversion format must contain a month, day, or year component. DBDATE specifies the data conversion format.
  -1218      The date specified by the *str* argument does not properly represent a date.
  ---------- -------------------------------------------------------------------------------------------------------------------

#### Usage:

The [DBDATE](EnvironmentVariables.html#EV_DBDATE) environment variable
specifies the data conversion format.

------------------------------------------------------------------------

### [byleng]{#byleng}()

#### Purpose:

Returns the number bytes as significant characters in the specified
string; omitting trailing blanks

#### Syntax:

    mint byleng(char *s1, mint count);

#### Notes:

1.  *s1* is a pointer to a fixed-length string, not null-terminated.
2.  *count* is the number of bytes in the fixed-length string.

#### Returns:

Number of bytes.

------------------------------------------------------------------------

### [ldchar(]{#ldchar})

#### Purpose:

To copy a fixed-length string into a null-terminated string without
trailing blanks

#### Syntax:

    void ldchar(char *from, mint count, char *to);

#### Notes:

1.  *from* is a pointer to a fixed-length source string.
2.  *count* is the number of bytes in the source string.
3.  *to* is a pointer to the first byte of a null-terminated destination
    string. If the *to* argument points to the same location as the
    *from* argument, or to a location that overlaps the *from* argument,
    ldchar() does not preserve the original value.

------------------------------------------------------------------------

### [rdownshift]{#rdownshift}()

#### Purpose:

To convert all the characters in a null-terminated string to lowercase.

#### Syntax:

    void rdownshift(char *s);

#### Notes:

1.  *s* is a pointer to a null-terminated string.

------------------------------------------------------------------------

### [rupshift]{#rupshift}()

#### Purpose:

To convert all the characters in a null-terminated string to uppercase.

#### Syntax:

    void rupshift(char *s);

#### Notes:

1.  *s* is a pointer to a null-terminated string.

------------------------------------------------------------------------

### [stcat]{#stcat}()

#### Purpose:

To concatenate one null-terminated string to another (*src* is added to
the end of *dst)*.

#### Syntax:

    void stcat(char *src, char *dst);

#### Notes:

1.  *src* is a pointer to the start of the string that is put at the end
    of the destination string.
2.  *dst* is a pointer to the start of the null-terminated destination
    string.
3.  The resulting string is *dstsrc.*

------------------------------------------------------------------------

### [stcopy]{#stcopy}()

#### Purpose:

To copy a string to another location

#### Syntax:

    void stcopy(char *src, char *dst);

#### Notes:

1.  *src* is a pointer to the string that you want to copy.
2.  *dst* is a pointer to a location in memory where the string is
    copied.

------------------------------------------------------------------------

### [stleng]{#stleng}()

#### Purpose:

Returns the number of bytes of significant characters, including
trailing blanks

#### Syntax:

    mint stleng(char *src);

#### Notes:

1.  *src* is a pointer to a null-terminated string.
2.  The length does not include the null terminator.

#### Returns:

Number of bytes.

------------------------------------------------------------------------

### [stcmpr]{#stcmpr}()

#### Purpose:

To compare two strings

#### Syntax:

    mint stcmpr(char *s1, char *s2);

#### Notes:

1.  *s1* is a pointer to the first null-terminated string.
2.  *s2* is a pointer to the second null-terminated string.
3.  *s1* is greater than *s2* when *s1* appears after *s2* in the ASCII
    collation sequence.

#### Returns:

  ---------- -----------------------------------------------------
  **Code**   **Description**
  0          The two strings are identical.
  \<0        The first string is less than the second string.
  \>0        The first string is greater than the second string.
  ---------- -----------------------------------------------------

------------------------------------------------------------------------

### [stchar]{#stchar}()

#### Purpose:

To copy a null-terminated string into a fixed-length string

#### Syntax:

    void stchar(char *from, char *to, mint count);

#### Notes:

1.  *from* is a pointer to the first byte of a null-terminated source
    string.
2.  *to* is a pointer to a fixed-length destination string. If this
    argument points to a location that overlaps the location to which
    the *from* argument points, the *from* value is discarded.
3.  *count* is the number of bytes in the fixed-length destination
    string.

------------------------------------------------------------------------

### [rstod]{#rstod}()

#### Purpose:

To convert a string to a double.

#### Syntax:

    mint rstod(char *str, double *val);

#### Notes:

1.  *str* is a pointer to a null-terminated string.
2.  *val* is a pointer to a double value that holds the converted value.

#### Returns:

  ---------- --------------------------------
  **Code**   **Description**
  0          The conversion was successful.
  \<0        The conversion failed.
  ---------- --------------------------------

------------------------------------------------------------------------

### [rstoi]{#rstoi}()

#### Purpose:

To convert a string to a 2-byte integer.

#### Syntax:

    mint rstoi(char *str, mint *val);

#### Notes:

1.  *str* is a pointer to a null-terminated string.
2.  *val* is a pointer to a mint value that holds the converted value.

**Warning: The function takes a machine-dependent int pointer (usually 4
bytes), but the function converts to a 2 byte integer (overflow error
may occur if string does not represent a valid 2-byte integer).**

#### Returns:

  ---------- --------------------------------
  **Code**   **Description**
  0          The conversion was successful.
  \<0        The conversion failed.
  ---------- --------------------------------

------------------------------------------------------------------------

### [rstol]{#rstol}()

#### Purpose:

To convert a string to a 4-byte integer (machine dependent)

#### Syntax:

    mint rstol(char *str, mlong *val);

#### Notes:

1.  *str* is a pointer to a null-terminated string.
2.  *val* is a pointer to an mlong value that holds the converted value.

**Warning: The function takes a machine-dependent long pointer (4 bytes
on 32b and 8 bytes on 64b architectures), but the function converts to a
4-byte integer (overflow error may occur if string does not represent a
valid 2 byte integer).**

#### Returns:

  ---------- --------------------------------
  **Code**   **Description**
  0          The conversion was successful.
  \<0        The conversion failed.
  ---------- --------------------------------

------------------------------------------------------------------------

### [rfmtdouble]{#rfmtdouble}()

#### Purpose:

To convert a double value to a character string having a specified
format.

#### Syntax:

    mint rfmtdouble(double dvalue, char *format, char *outbuf);

#### Notes:

1.  *dvalue* is the double value to format.
2.  *format* is a pointer to a char buffer that contains the [formatting
    mask](#FMT_NUM).
3.  *outbuf* is a pointer to a char buffer that receives the formatted
    string.

#### Returns:

  ---------- ----------------------------------------------------------
  **Code**   **Description**
  0          The conversion was successful.
  \<0        The conversion failed.
  -1211      The program ran out of memory (memory-allocation error).
  -1217      The format string is too large.
  ---------- ----------------------------------------------------------

------------------------------------------------------------------------

### [rfmtint4]{#rfmtint4}()

#### Purpose:

To convert a 4-byte integer to a character string having a specified
format

#### Syntax:

    mint rfmtint4(int4 lvalue, char *format, char *outbuf);

#### Notes:

1.  *lvalue* is the int4 integer to convert.
2.  *format* is a pointer to the char buffer that contains the
    [formatting mask](#FMT_NUM).
3.  *outbuf* is a pointer to a char buffer that receives the formatted
    string for the integer value.

#### Returns:

  ---------- ----------------------------------------------------------
  **Code**   **Description**
  0          The conversion was successful.
  \<0        The conversion failed.
  -1211      The program ran out of memory (memory-allocation error).
  -1217      The format string is too large.
  ---------- ----------------------------------------------------------

------------------------------------------------------------------------

### [dtaddinv]{#dtaddinv}()

#### Purpose:

To add an interval value to a datetime value

#### Syntax:

    mint dtaddinv(dtime_t *d, intrvl_t *i, dtime_t *r);

#### Notes:

1.  *d* is a pointer to the initialized datetime host variable. The
    variable must include all the fields present in the interval value.
2.  *i* is a pointer to the initialized interval host variable. The
    interval value must be in the year to month or the day to
    fraction(5) range.
3.  *r* is a pointer to the result. The result inherits the qualifier of
    *d*.
4.  Failure to initialize the host variables can produce unpredictable
    results.

#### Returns:

  ---------- ------------------------------
  **Code**   **Description**
  0          The addition was successful.
  \<0        The addition failed.
  ---------- ------------------------------

------------------------------------------------------------------------

### [dtcurrent]{#dtcurrent}()

#### Purpose:

Returns the current date and time

#### Syntax:

    void dtcurrent(dtime_t *d);

#### Notes:

1.  *d* is a pointer to the initialized datetime host variable.
2.  The function extends the current date and time to agree with the
    qualifier of the host variable.

------------------------------------------------------------------------

### [dtcvasc]{#dtcvasc}()

#### Purpose:

To convert an ASCII-standard character string to a datetime value

#### Syntax:

    mint dtcvasc(char *str, dtime_t *d);

#### Notes:

1.  *str* is a pointer to the buffer that contains the ASCII-standard
    datetime string.
2.  *d* is a pointer to a datetime variable, initialized with the
    qualifier that you want the datetime value to have.

#### Returns:

  ---------- -----------------------------------------------------------------------
  **Code**   **Description**
  0          The conversion was successful.
  \<0        The conversion failed.
  -1260      It is not possible to convert between the specified types.
  -1261      Too many digits in the first field of datetime or interval.
  -1262      Non-numeric character in datetime or interval.
  -1263      A field in a datetime or interval value is out of range or incorrect.
  -1264      Extra characters exist at the end of a datetime or interval.
  -1265      Overflow occurred on a datetime or interval operation.
  -1266      A datetime or interval value is incompatible with the operation.
  -1267      The result of a datetime computation is out of range.
  -1268      A parameter contains an invalid datetime qualifier.
  ---------- -----------------------------------------------------------------------

------------------------------------------------------------------------

### [ifx_dtcvasc]{#ifx_dtcvasc}()

#### Purpose:

To convert a character string to a datetime value; allows you to specify
the century setting for 2-digit years

#### Syntax:

    mint ifx_dtcvasc(char *str, dtime_t *d, char c);

#### Notes:

1.  *str* is a pointer to a buffer that contains an ANSI-standard
    datetime string.
2.  *d* is a pointer to a datetime variable, initialized with the
    desired qualifier.
3.  *c* is one of [CENTURY](EnvironmentVariables.html#EV_DBCENTURY)
    characters, which determines which century to apply to the year
    portion of the date.

#### Returns:

  ---------- -----------------------------------------------------------------------
  **Code**   **Description**
  0          The conversion was successful.
  \<0        The conversion failed.
  -1260      It is not possible to convert between the specified types.
  -1261      Too many digits in the first field of datetime or interval.
  -1262      Non-numeric character in datetime or interval.
  -1263      A field in a datetime or interval value is out of range or incorrect.
  -1264      Extra characters exist at the end of a datetime or interval.
  -1265      Overflow occurred on a datetime or interval operation.
  -1266      A datetime or interval value is incompatible with the operation.
  -1267      The result of a datetime computation is out of range.
  -1268      A parameter contains an invalid datetime qualifier.
  ---------- -----------------------------------------------------------------------

------------------------------------------------------------------------

### [dtcvfmtasc]{#dtcvfmtasc}()

#### Purpose:

To convert a character string to a datetime value, specifying the format
of the string

#### Syntax:

    mint dtcvfmtasc(char *input, char *fmt, dtime_t *d);

#### Notes:

1.  *input* is a pointer to a buffer that contains the string to
    convert.
2.  *fmt* is a pointer to a buffer containing the [formatting
    mask](#FMT_DATETIME).\
    The default date format conforms to the standard ANSI SQL format:
    `%Y-%m-%d %H:%M:%S`
3.  *d* is a pointer to the datetime variable, which must be initialized
    with the desired qualifier.

#### Returns:

  ---------- --------------------------------
  **Code**   **Description**
  0          The conversion was successful.
  \<0        The conversion failed.
  ---------- --------------------------------

------------------------------------------------------------------------

### [ifx_dtcvfmtasc]{#ifx_dtcvfmtasc}()

#### Purpose:

To convert a character string to a datetime value, specifying the format
of the string

#### Syntax:

    mint ifx_dtcvfmtasc(char *input, char *fmt, dtime_t *d, char c);

#### Notes:

1.  *input* is a pointer to a buffer that contains the string to
    convert.
2.  *fmt* is a pointer to a buffer containing the [formatting
    mask](#FMT_DATETIME).\
    The default date format conforms to the standard ANSI SQL format:
    `%Y-%m-%d %H:%M:%S`
3.  *d* is a pointer to the datetime variable, which must be initialized
    with the desired qualifier.
4.  *c* is one of [CENTURY](EnvironmentVariables.html#EV_DBCENTURY)
    characters, which determines which century to apply to the year
    portion of the date.

#### Returns:

  ---------- --------------------------------
  **Code**   **Description**
  0          The conversion was successful.
  \<0        The conversion failed.
  ---------- --------------------------------

------------------------------------------------------------------------

### [dtextend]{#dtextend}()

#### Purpose:

To copy a datetime value *id* to the datetime value *od*, adding or
dropping fields based on the qualifier of *od*

#### Syntax:

    mint dtextend(dtime_t *id, dtime_t *od);

#### Notes:

1.  *id* is a pointer to the datetime variable to extend.
2.  *od* is a pointer to the datetime variable containing a valid
    qualifier to use for the extension.

#### Returns:

  ---------- ----------------------------------------------------
  **Code**   **Description**
  0          The operation was successful.
  \<0        The operation failed.
  -1268      A parameter contains an invalid datetime qualifier
  ---------- ----------------------------------------------------

------------------------------------------------------------------------

### [dtsub]{#dtsub}()

#### Purpose:

To subtract one datetime value from another

#### Syntax:


    mint dtsub(dtime_t *d1, dtime_t *d2, intrvl_t *i);

#### Notes:

1.  *d1* is a pointer to an initialized datetime host variable.
2.  *d2* is a pointer to an initialized datetime host variable.
3.  *i* is a pointer to the interval host variable that contains the
    result.

#### Returns:

  ---------- ---------------------------------
  **Code**   **Description**
  0          The subtraction was successful.
  \<0        The subtraction failed.
  ---------- ---------------------------------

------------------------------------------------------------------------

### [dtsubinv]{#dtsubinv}()

#### Purpose:

To subtract an interval value from a datetime value

#### Syntax:

    mint dtsubinv(dtime_t *d, intrvl_t *i, dtime_t *r);

#### Notes:

1.  *d* is a pointer to an initialized datetime host variable. This must
    include all the fields present in the interval value *i*.
2.  *i* is a pointer to an initialized interval host variable.
3.  *r* is a pointer to the datetime host variable that contains the
    result.

#### Returns:

  ---------- ---------------------------------
  **Code**   **Description**
  0          The subtraction was successful.
  \<0        The subtraction failed.
  ---------- ---------------------------------

------------------------------------------------------------------------

### [dttoasc]{#dttoasc}()

#### Purpose:

To convert a datetime value to an ANSI-standard character string

#### Syntax:

    mint dttoasc(dtime_t *d, char *str);

#### Notes:

1.  *d* is a pointer to the initialized datetime variable to convert.
2.  *str* is a pointer to the buffer that receives the ANSI-standard
    DATETIME string for the value in *d*.

#### Returns:

  ---------- --------------------------------
  **Code**   **Description**
  0          The conversion was successful.
  \<0        The conversion failed.
  ---------- --------------------------------

#### Usage:

The *str* parameter includes one character for each delimiter, plus the
fields, which are of the following sizes:

  ---------------------- -----------------------------
        **Field**        ** Field Size**
           year            four digits
   fraction of datetime    as specified by precision
     all other fields      two digits
  ---------------------- -----------------------------

For example, datetime year to fraction(5):


    YYYY-MM-DD HH:MM:SS.FFFFF

------------------------------------------------------------------------

### [dttofmtasc()]{#dttofmtasc}

#### Purpose:

To convert a datetime value to a character string, specifying the format

#### Syntax:

    mint dttofmtasc(dtime_t *d, char *output, mint len, char *fmt);

#### Notes:

1.  *d* is a pointer to the initialized datetime variable to convert.
2.  *output* is a pointer to the buffer that receives the string for the
    value in *d*.
3.  *len* is the length of the *output* buffer.
4.  *fmt* is a pointer to a buffer containing the [formatting
    mask](#FMT_DATETIME).\
    The default date format conforms to the standard ANSI SQL format:
    `%Y-%m-%d %H:%M:%S`

#### Returns:

  ---------- --------------------------------
  **Code**   **Description**
  0          The conversion was successful.
  \<0        The conversion failed.
  ---------- --------------------------------

------------------------------------------------------------------------

### [ifx_dttofmtasc()]{#ifx_dttofmtasc}

#### Purpose:

To convert a datetime value to a character string, specifying the format

#### Syntax:

    mint ifx_dttofmtasc(dtime_t *d, char *output, mint len, char *fmt, char c);

#### Notes:

1.  *d* is a pointer to the initialized datetime variable to convert.
2.  *output* is a pointer to the buffer that receives the string for the
    value in *d*.
3.  *len* is the length of the *output* buffer.
4.  *fmt* is a pointer to a buffer containing the [formatting
    mask](#FMT_DATETIME).\
    The default date format conforms to the standard ANSI SQL format:
    `%Y-%m-%d %H:%M:%S`
5.  *c* is one of [CENTURY](EnvironmentVariables.html#EV_DBCENTURY)
    characters, which determines which century to apply to the year
    portion of the date.

#### Returns:

  ---------- --------------------------------
  **Code**   **Description**
  0          The conversion was successful.
  \<0        The conversion failed.
  ---------- --------------------------------

------------------------------------------------------------------------

### [incvasc]{#incvasc}()

#### Purpose:

To convert an ANSI-standard character string to an interval value

#### Syntax:

    mint incvasc(char *str, intrvl_t *i);

#### Notes:

1.  *str* a pointer to a buffer containing an ANSI-standard INTERVAL
    string.
2.  *i* is a pointer to an initialized interval variable.

#### Returns:

  ---------- -------------------------------------------------------------
  **Code**   **Description**
  0          The conversion was successful.
  \<0        The conversion failed.
  -1260      It is not possible to convert between the specified types.
  -1261      Too many digits in the first field of datetime or interval.
  ---------- -------------------------------------------------------------

------------------------------------------------------------------------

### [incvfmtasc]{#incvfmtasc}()

#### Purpose:

To convert a character string having the specified format to an interval
value

#### Syntax:

    mint incvfmtasc(char *input, char *fmt, intrvl_t *intvl);

#### Notes:

1.  *input* is a pointer to the string to convert.
2.  *fmt* is a pointer to the buffer containing the [formatting
    mask](#FMT_INTERVAL) to use for the input string.\
    It must be either in year to month, or in day to fraction ranges.
3.  *intvl* is a pointer to the initialized interval variable.

#### Returns:

  ---------- --------------------------------
  **Code**   **Description**
  0          The conversion was successful.
  \<0        The conversion failed.
  ---------- --------------------------------

------------------------------------------------------------------------

### [intoasc]{#intoasc}()

#### Purpose:

To convert an interval value to an ANSI-standard character string

#### Syntax:

    mint intoasc(intrvl_t *i, char *str);

#### Notes:

1.  *i* is a pointer to the initialized interval variable.
2.  *str* is a pointer to the buffer containing the ANSI-standard
    interval string.

#### Returns:

  ---------- --------------------------------
  **Code**   **Description**
  0          The conversion was successful.
  \<0        The conversion failed.
  ---------- --------------------------------

------------------------------------------------------------------------

### [intofmtasc]{#intofmtasc}()

#### Purpose:

To convert an interval value to a character string, specifying the
format 

#### Syntax:

    mint intofmtasc(intrvl_t *i, char *output, mint len, char *fmt);

#### Notes:

1.  *i* is a pointer to an initialized interval variable to convert.
2.  *output* is a pointer to the buffer that receives the string for the
    value in i.
3.  *strlen* is the length of the outbuf buffer.
4.  *fmt* is a pointer to the buffer containing the [formatting
    mask](#FMT_INTERVAL).\
    It must be either in year to month, or in day to fraction ranges.

#### Returns:

  ---------- --------------------------------
  **Code**   **Description**
  0          The conversion was successful.
  \<0        The conversion failed.
  ---------- --------------------------------

------------------------------------------------------------------------

### [invdivdbl]{#invdivdbl}()

#### Purpose:

To divide an interval value by a numeric value

#### Syntax:

    mint invdivdbl(intrvl_t *iv, double dbl, intrvl_t *ov);

#### Notes:

1.  iv is a pointer to an initialized interval variable to be divided.
2.  *dbl* is a numeric divisor value, which can be a positive or
    negative number.
3.  *ov* is a pointer to an interval variable with a valid qualifier in
    the year to month class or the day to fraction(5) class.
4.  Both th*e iv* and *ov* qualifiers must belong to the same qualifier
    class

#### Returns:

  ---------- ----------------------------------------------
  **Code**   **Description**
  0          The division was successful.
  \<0        The division failed.
  -1200      A numeric value is too large (in magnitude).
  -1201      A numeric value is too small (in magnitude).
  -1202      The *dbl* parameter is zero (0).
  ---------- ----------------------------------------------

------------------------------------------------------------------------

### [invdivinv]{#invdivinv}()

#### Purpose:

To divide one interval value by another

#### Syntax:

    mint invdivinv(intrvl_t *i1, intrvl_t *i2, double *res);

#### Notes:

1.  *i1* is a pointer to an initialized interval variable that is the
    dividend.
2.  *i2* is a pointer to an initialized interval variable that is the
    divisor.
3.  *res* is a pointer to the double value that is the quotient.
4.  The qualifiers for *i1* and *i2* must belong to the same interval
    class, either year to month or day to fraction(5).

#### Returns:

  ---------- -------------------------------------------------------
  **Code**   **Description**
  0          The division was successful.
  \<0        The division failed.
  -1200      A numeric value is too large (in magnitude).
  -1201      A numeric value is too small (in magnitude).
  -1266      An interval value is incompatible with the operation.
  -1268      A parameter contains an invalid interval qualifier.
  ---------- -------------------------------------------------------

------------------------------------------------------------------------

### [invextend]{#invextend}()

#### Purpose:

To copy an interval value *i* to the interval value *o*, adding or
dropping fields based on the qualifier of *o*

#### Syntax:

    mint invextend(intrvl_t *i, intrvl_t *o);

#### Notes:

1.  *i* a pointer to the initialized interval variable to extend.
2.  *o* is a pointer to the interval variable with a valid qualifier to
    use for the extension.

#### Returns:

  ---------- -------------------------------------------------------
  **Code**   **Description**
  0          The conversion was successful.
  \<0        The conversion failed.
  -1266      An interval value is incompatible with the operation.
  -1268      A parameter contains an invalid interval qualifier.
  ---------- -------------------------------------------------------

------------------------------------------------------------------------

### [invmuldbl]{#invmuldbl}()

#### Purpose:

To multiply an interval value by a numeric value

#### Syntax:

    mint invmuldbl(intrvl_t *iv, double dbl, intrvl_t *ov);

#### Notes:

1.  *iv* is a pointer to the interval variable to multiply.
2.  *dbl* is the numeric double value, which can be a positive or
    negative number.
3.  *ov* is a pointer to the resulting interval variable containing a
    valid qualifier.
4.  Both *iv* and *ov* must belong to the same interval class, either
    year to month or day to fraction(5).

#### Returns:

  ---------- -------------------------------------------------------
  **Code**   **Description**
  0          The multiplication was successful.
  \<0        The multiplication failed.
  -1200      A numeric value is too large (in magnitude).
  -1201      A numeric value is too small (in magnitude).
  -1266      An interval value is incompatible with the operation.
  -1268      A parameter contains an invalid interval qualifier.
  ---------- -------------------------------------------------------

------------------------------------------------------------------------

### [Formatting Directives]{#FMT}

#### [Numeric Formatting Mask]{#FMT_NUM}

A numeric-formatting mask specifies a format to apply to some numeric
value.

This mask is a combination of the following formatting directives:

  ----------------------------------- -------------------------------------------------
             **Character**            ** Description**

                 \*                   This character fills with asterisks any positions
                                      in the display field that would otherwise be
                                      blank.

                  &                   This character fills with zeros any positions in
                                      the display field that would otherwise be blank.

                  #                   This character changes leading zeros to blanks.
                                      Use this character to specify the maximum
                                      leftward extent of a field.

                 \<                   This character left-justifies the numbers in the
                                      display field. It changes leading zeros to a null
                                      string.

                  , \                 This character indicates the symbol that
                   \                  separates groups of three digits (counting
                                      leftward from the units position) in the
                                      whole-number part of the value. By default, this
                                      symbol is a comma. You can set the symbol with
                                      the
                                      [DBMONEY](EnvironmentVariables.html#EV_DBMONEY)
                                      environment variable. In a formatted number, this
                                      symbol appears only if the whole-number part of
                                      the value has four or more digits.

                 .  \                 This character indicates the symbol that
                   \                  separates the whole-number part of a money value
                                      from the fractional part. By default, this symbol
                                      is a period. You can set the symbol with the
                                      [DBMONEY](EnvironmentVariables.html#EV_DBMONEY)
                                      environment variable. You can have only one
                                      period in a format string.

                 -  \                 This character is a literal. It appears as a
                   \                  minus sign when the expression  is less than
                                      zero. When you group several minus signs in a
                                      row, a single minus sign floats to the rightmost
                                      position that it can occupy; it does not
                                      interfere with the number and its currency
                                      symbol.

                  + \                 This character is a literal. It appears as a plus
                   \                  sign when the expression is greater than or equal
                                      to zero and as a minus sign when expr1 is less
                                      than zero. When you group several plus signs in a
                                      row, a single plus or minus sign floats to the
                                      rightmost position that it can occupy; it does
                                      not interfere with the number and its currency
                                      symbol.

                  ( \                 This character is a literal. It appears as a left
                   \                  parenthesis to the left of a negative number. It
                                      is one of the pair of accounting parentheses that
                                      replace a minus sign for a negative number. When
                                      you group several in a row, a single left
                                      parenthesis floats to the rightmost position that
                                      it can occupy; it does not interfere with the
                                      number and its currency symbol.

                  )                   This is one of the pair of accounting parentheses
                                      that replace a minus sign for a negative value.

                 \$  \                This character displays the currency symbol that
                   \                  appears at the front of the numeric value. By
                   \                  default, the currency symbol is the dollar sign
                                      (\$). You can set the currency symbol with the
                                      [DBMONEY](EnvironmentVariables.html#EV_DBMONEY)
                                      environment variable. When you group several
                                      dollar signs in a row, a single currency symbol
                                      floats to the rightmost position that it can
                                      occupy; it does not interfere with the number.
  ----------------------------------- -------------------------------------------------

Any other characters in the formatting mask are reproduced literally in
the result.

#### Examples:

  ----------------------- ----------------------- -----------------------
         **Mask**         ** Numeric value**         **Formatted String**

        -##,###.##\        -12345.67\                         -12,234.67\
             \               12345.67\                        b12,345.67\
                                 113.11                        bbbb113.11

        ##,###.##\         -12345.67\                          12,345.67\
                             12345.67                           12,345.67

       \--,\-\--.&&        -445.67                              bb-445.67

      \$\$,\$\$\$.&&\     2345.67\                            \$2,345.67\
                          445.67                               bb\$445.67
  ----------------------- ----------------------- -----------------------

#### [Date Formatting Mask]{#FMT_DATE}

A date-formatting mask specifies a format to apply to some date value.

This mask is a combination of the following formatting directives:

  --------------- -----------------------------------------------------------------------------------------------------------
   **Character**  ** Description**
        dd         Day of the month as a two-digit number (01 through 31)
        ddd        Day of the week as a three-letter abbreviation (Sun through Sat)
        mm         Month as a two-digit number (01 through 12)
        mmm        Month as a three-letter abbreviation (Jan through Dec)
        yy         Year as a two-digit number (00 through 99)
       yyyy        Year as a four-digit number (0001 through 9999)
        ww         Day of the week as a two-digit number (00 for Sunday, 01 for Monday, 02 for Tuesday ... 06 for Saturday)
  --------------- -----------------------------------------------------------------------------------------------------------

Any other characters in the formatting mask are reproduced literally in
the result.

#### [Datetime Formatting Mask]{#FMT_DATETIME}

A datetime-formatting mask specifies a format to apply to some datetime
value.

This mask is a combination of the following formatting directives: 

+:-----------------------------------:+------------------------------------:+
| **Directive**                       | ** Description**                    |
+-------------------------------------+-------------------------------------+
| Date related directives                                                   |
+-------------------------------------+-------------------------------------+
| %a                                  | Identifies abbreviated weekday name |
|                                     | as defined in locale.               |
+-------------------------------------+-------------------------------------+
| %A                                  | Identifies full weekday name as     |
|                                     | defined in locale.                  |
+-------------------------------------+-------------------------------------+
| %b                                  | Identifies abbreviated month name   |
|                                     | as defined in locale.               |
+-------------------------------------+-------------------------------------+
| %B                                  | Identifies full month name as       |
|                                     | defined in locale.                  |
+-------------------------------------+-------------------------------------+
| %C                                  | Identifies century number (year     |
|                                     | divided by 100 and truncated to an  |
|                                     | integer)                            |
+-------------------------------------+-------------------------------------+
| %d                                  | Identifies the day of the month (01 |
|                                     | to 31). Single digit is preceded by |
|                                     | zero.                               |
+-------------------------------------+-------------------------------------+
| %D                                  | Identifies commonly used date       |
|                                     | format (%m/%d/%y).                  |
+-------------------------------------+-------------------------------------+
| %e                                  | Identifies the day of the month as  |
|                                     | a number (1 to 31). Single digit is |
|                                     | preceded by space.                  |
+-------------------------------------+-------------------------------------+
| %h                                  | Same as %b.                         |
+-------------------------------------+-------------------------------------+
| %iy                                 | Identifies the year as a 2-digit    |
|                                     | number (00 to 99).                  |
+-------------------------------------+-------------------------------------+
| %iY                                 | Identifies the year as a 4-digit    |
|                                     | number (0000 to 9999).              |
+-------------------------------------+-------------------------------------+
| %m                                  | Identifies the month as a number    |
|                                     | (01 to 12). Single digit is         |
|                                     | preceded by zero.                   |
+-------------------------------------+-------------------------------------+
| %w                                  | Identifies the weekday as a number  |
|                                     | (0 to 6), where 0 is the locale     |
|                                     | equivalent of Sunday.               |
+-------------------------------------+-------------------------------------+
| %x                                  | Identifies a special date           |
|                                     | representation that the locale      |
|                                     | defines.                            |
+-------------------------------------+-------------------------------------+
| %y                                  | Identifies the year as a 2-digit    |
|                                     | number (00 to 99).                  |
+-------------------------------------+-------------------------------------+
| %Y                                  | Identifies the year as a 4-digit    |
|                                     | number (0000 to 9999).              |
+-------------------------------------+-------------------------------------+
| Time related directives                                                   |
+-------------------------------------+-------------------------------------+
| %c                                  | Identifies special date/time        |
|                                     | representation that locale defines. |
+-------------------------------------+-------------------------------------+
| %Fn                                 | Identifies value of the fraction of |
|                                     | a second, with precision specified  |
|                                     | by integer *n*. Range of *n* is 0   |
|                                     | to 5.\                              |
|                                     | Note that the %Fn directive         |
|                                     | includes the dot character: For     |
|                                     | example, if you want to specify a   |
|                                     | format a time value as              |
|                                     | 23:35:17.9123, you must use         |
|                                     | %H:%M:%S%F4                         |
+-------------------------------------+-------------------------------------+
| %H                                  | Identifies the hour as 24-hour      |
|                                     | clock integer (00-23).              |
+-------------------------------------+-------------------------------------+
| %I                                  | Identifies the hour as 12-hour      |
|                                     | clock integer (00-12).              |
+-------------------------------------+-------------------------------------+
| %M                                  | Identifies the minute as an integer |
|                                     | (00-59).                            |
+-------------------------------------+-------------------------------------+
| %p                                  | Identifies AM or PM equivalent as   |
|                                     | defined in locale.                  |
+-------------------------------------+-------------------------------------+
| %r                                  | Identifies commonly used time       |
|                                     | representation for a 12-hour clock. |
+-------------------------------------+-------------------------------------+
| %R                                  | Identifies commonly used time       |
|                                     | representation for a 24-hour clock  |
|                                     | (%H:%M).                            |
+-------------------------------------+-------------------------------------+
| %S                                  | Identifies the second as an integer |
|                                     | (00-61). Second can be up to 61     |
|                                     | instead of 59 to allow for the      |
|                                     | occasional leap second and double   |
|                                     | leap second.                        |
+-------------------------------------+-------------------------------------+
| %T                                  | Identifies commonly used time       |
|                                     | format (%H:%M:%S).                  |
+-------------------------------------+-------------------------------------+
| %X                                  | Identifies commonly used time       |
|                                     | representation as defined in the    |
|                                     | locale.                             |
+-------------------------------------+-------------------------------------+
| Specials                                                                  |
+-------------------------------------+-------------------------------------+
| %%                                  | Identifies the % character.         |
+-------------------------------------+-------------------------------------+
| %n                                  | Identifies a new-line character.    |
+-------------------------------------+-------------------------------------+
| %t                                  | Identifies a TAB character.         |
+-------------------------------------+-------------------------------------+

Any other characters in the formatting mask are reproduced literally in
the result.

#### [Interval Formatting Mask]{#FMT_INTERVAL}

An interval-formatting mask specifies a format to apply to some interval
value.

This mask must be combination of Class 1 interval or Class 2 interval
formatting directives:

+:-------------------------:+-----------------------------------------:+
| **Character**             | ** Description**                         |
+---------------------------+------------------------------------------+
| Class 1 formatting directives ( YEAR to MONTH )                      |
+---------------------------+------------------------------------------+
| %C                        | Identifies century number (year divided  |
|                           | by 100 and truncated to an integer)      |
+---------------------------+------------------------------------------+
| %iy                       | Identifies the year as a 2-digit number  |
|                           | (00 to 99).                              |
+---------------------------+------------------------------------------+
| %iY                       | Identifies the year as a 4-digit number  |
|                           | (0000 to 9999).                          |
+---------------------------+------------------------------------------+
| %m                        | Identifies the month as a number (01 to  |
|                           | 12). Single digit is preceded by zero.   |
+---------------------------+------------------------------------------+
| %y                        | Identifies the year as a 2-digit number  |
|                           | (00 to 99).                              |
+---------------------------+------------------------------------------+
| %Y                        | Identifies the year as a 4-digit number  |
|                           | (0000 to 9999).                          |
+---------------------------+------------------------------------------+
| Class 2 formatting directives ( DAY to FRACTION )                    |
+---------------------------+------------------------------------------+
| %a                        | Identifies abbreviated weekday name as   |
|                           | defined in locale.                       |
+---------------------------+------------------------------------------+
| %A                        | Identifies full weekday name as defined  |
|                           | in locale.                               |
+---------------------------+------------------------------------------+
| %d                        | Identifies the day of the month (01 to   |
|                           | 31). Single digit is preceded by zero.   |
+---------------------------+------------------------------------------+
| %e                        | Identifies the day of the month as a     |
|                           | number (1 to 31). Single digit is        |
|                           | preceded by space.                       |
+---------------------------+------------------------------------------+
| %Fn                       | Identifies value of the fraction of a    |
|                           | second, with precision specified by      |
|                           | integer *n*. Range of *n* is 0 to 5.     |
+---------------------------+------------------------------------------+
| %H                        | Identifies the hour as 24-hour clock     |
|                           | integer (00-23).                         |
+---------------------------+------------------------------------------+
| %I                        | Identifies the hour as 12-hour clock     |
|                           | integer (00-12).                         |
+---------------------------+------------------------------------------+
| %M                        | Identifies the minute as an integer      |
|                           | (00-59).                                 |
+---------------------------+------------------------------------------+
| %S                        | Identifies the second as an integer      |
|                           | (00-61). Second can be up to 61 instead  |
|                           | of 59 to allow for the occasional leap   |
|                           | second and double leap second.           |
+---------------------------+------------------------------------------+
| %w                        | Identifies the weekday as a number (0 to |
|                           | 6), where 0 is the locale equivalent of  |
|                           | Sunday.                                  |
+---------------------------+------------------------------------------+
| Specials                                                             |
+---------------------------+------------------------------------------+
| %%                        | Identifies the % character.              |
+---------------------------+------------------------------------------+
| %n                        | Identifies a new-line character.         |
+---------------------------+------------------------------------------+
| %t                        | Identifies a TAB character.              |
+---------------------------+------------------------------------------+
