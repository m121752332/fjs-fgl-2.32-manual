[Back to Contents](../index.html)

------------------------------------------------------------------------

# [Compiling Programs]{#PAGE_HEADER}

Summary:

- [Compiling Source Code](#COMPSRC)
- [Importing modules](#IMPORT)
- [Creating Libraries](#CREATELIBS)
- [Linking Programs](#LINKPROGS)
- [Using Makefiles](#MAKEFILES)
- [Getting Build Information](#BUILDINFO)

*See also:* [Tools](Tools.html), [Form
Files](FormSpecFiles.html#COMPILING), [Message
Files](MessageFiles.html#COMPILING), [Localized
Strings](LocalizedStrings.html#COMPILING).

------------------------------------------------------------------------

## [Compiling Source Code]{#COMPSRC}

Source code modules (**4gl**) must be compiled to p-code modules
(**42m**) with the [fglcomp](Tools.html#TL_FGLCOMP) tool. Compiled
p-code modules are portable; you can compile a module on a Windows
platform and install it on a Unix production machine.

The following lines show a compilation in a Unix shell session:

`$ cat xx.4gl`\
`main`\
`  display "hello"`\
`end main`\
\
`$ fglcomp xx.4gl`\
\
`$ ls -s xx.42m`\
`   4 xx.42m`

If an error occurs, the compiler writes an error file with the **.err**
extension.

`$ cat xx.4gl`\
`main`\
`  let x = "hello"`\
`end main`\
\
`$ fglcomp xx.4gl`\
`Compilation was not successful.  Errors found: 1.`\
` The file xx.4gl has been written.`\
\
`$ cat xx.err`\
`main`\
`  let x = "hello"`\
`| The symbol 'x' does not represent a defined variable.`\
`| See error number -4369. `\
`end main`

With the `-M `option, you can force the compiler to display an error
message instead of generating a **.err** error file:

` $ fglcomp xx.4gl`\
`xx.4gl:2:8 error:(-4369) The symbol 'x' does not represent a defined variable.`

By default, the compiler does not raise any warnings. You can turn on
warnings with the `-W` option:

`$ cat xx.4gl`\
`main`\
`  database test1`\
`  select count(*) from x, outer(y) where x.k = y.k`\
`end main`\
\
`$ fglcomp -W stdsql xx.4gl`\
`xx.4gl:3: warning: SQL statement or language instruction with specific SQL syntax.`

When a warning is raised, you can use the `-W error` option to force the
compiler to stop as if an error was found.

For more details about warning options, see the [fglcomp
tool](Tools.html#FglCompWarningFlags).

------------------------------------------------------------------------

## [Importing Modules]{#IMPORT}

Starting with Genero BDL 2.21, it is possible to define module
dependencies with the `IMPORT FGL` instruction. Imported module elements
such as functions, variables, user types and constants can be shared and
used in the current module. Module importation is a straightforward way
to define module dependencies, allowing program compilation without a
link phase.

The next source example imports the *myutils* and *account* modules, and
uses the *init()* and *set_account()* functions of the imported modules
(note that the first function call is qualified with the module name -
this is optional but required to resolve ambiguities when the same
function name is used by different modules):

``` linenumber
01 IMPORT FGL myutils
02 IMPORT FGL account
03 MAIN
04   CALL myutils.init()
05   CALL set_account("CFX4559")
06   ...
07 END MAIN
```

By declaring module dependencies with the `IMPORT FGL` instruction, you
instruct the [fglcomp](Tools.html#TL_FGLCOMP) compiler and
[fglrun](Tools.html#TL_FGLRUN) runtime system to load/check the
specified modules, and there is no longer a need to [link](#LINKPROGS)
programs or use libraries.

**Warning: Imported modules must be compiled before compiling the
importing module, and no circular references are allowed (module A
importing module B, which imports module A).**

Note that the [FGLLDPATH](EnvironmentVariables.html#EV_FGLLDPATH)
environment variable specifies the directories to search for the Genero
BDL modules used by `IMPORT`.

With the `IMPORT FGL` instruction, language elements such as module
variables, user types and constants can be shared between modules. The
`PRIVATE` / `PUBLIC` modifiers can be used to hide / publish elements to
other modules. The next example declares a module variable that can be
used by other modules, and a private function to be used only locally:

``` linenumber
01 PUBLIC DEFINE custlist DYNAMIC ARRAY OF RECORD
02   id INT,
03   name VARCHAR(50),
04   address VARCHAR(200)
05 END RECORD
06 ...
07 PRIVATE FUNCTION myfunction()
08 ...
```

For more details, see [IMPORT](Programs.html#IMPORT).

------------------------------------------------------------------------

## [Creating Libraries]{#CREATELIBS}

Compiled **42m** modules can be grouped in a library file using the
**42x** extension.

Library linking is done with the [fglrun](Tools.html#TL_FGLRUN) tool by
using the` -l `option. You can also use the
[fgllink](Tools.html#TL_FGLLINK) tool.

The following lines show a link procedure to create a library in a Unix
shell session:

` $ fglcomp fileutils.4gl`\
`$ fglcomp userutils.4gl`\
`$ fgllink -o libutils.42x fileutils.42m userutils.42m`

When you create a library, all functions of the **42m** modules used in
the link command are registered in the **42x** file.

**Warning: The 42x library file does not contain the 42m files. When
deploying your application, you must provide all p-code modules as well
as 42f, 42r and 42x files.**

The **42x** libraries are typically used to link the final **42r**
programs:

` $ fglcomp mymain.4gl`\
`$ fgllink -o myprog.42r mymain.42m libutils.42x`

Note that **42r** programs must be re-linked if the content of **42x**
libraries have changed. In the above example, if a function of the
**userutils.4gl** source file was removed, you must recompile
**userutils.4gl**, re-link the **libutils42x** library and re-link the
**myprog.42r** program.

It is possible to create a library by referencing other **42x** library
files in the link command, as long as modules can be found according to
[FGLLDPATH](EnvironmentVariables.html#EV_FGLLDPATH):

` $ fglcomp module_1.4gl`\
`$ fglcomp module_2.4gl`\
`$ fgllink -o `**`lib_A.42x`**` module_1.42m`\
`$ fgllink -o lib_B.42x module_2.42m `**`lib_A.42x`\**
` $ fgllink -o myprog.42r lib_B.42x  -- will hold functions of module_1 and module_2.`

If you are using C Extensions, you may need to use the **-e** option to
specify the list of extension modules if the [IMPORT](CExtensions.html)
keyword is not used:

` $ fgllink -e extlib,extlib2,extlib3 -o libutils.42x fileutils.42m userutils.42m`

------------------------------------------------------------------------

## [Linking Programs]{#LINKPROGS}

Genero programs are created by linking several **42m** modules and/or
**42x** libraries together, to produce a file with the **42r**
extension. Note that the generated 42r program file does not contain the
42m files. When deploying your application, you must provide all p-code
modules as well as 42f, 42r and 42x files.

Program linking is done with the [fglrun](Tools.html#TL_FGLRUN) tool by
using the `-l `option. You can also use the
[fgllink](Tools.html#TL_FGLLINK) tool.

The following lines show a link procedure to create a library in a Unix
shell session:

` $ fglcomp main.4gl`\
`$ fglcomp store.4gl`\
`$ fgllink -o stores.42r main.42m store.42m`

By default, if you do not specify an absolute path for a file, the
linker searches for **42m** modules and **42x** libraries in the current
directory.

Additionally, you can specify a search path with the
[FGLLDPATH](EnvironmentVariables.html#EV_FGLLDPATH) environment
variable:

` $ FGLLDPATH=/usr/dev/lib/maths:/usr/dev/lib/utils`\
`$ export FGLLDPATH`\
`$ ls /usr/dev/lib/maths`\
`mathlib1.42x`\
`mathlib2.42x`\
`mathmodule11.42m`\
`mathmodule12.42m`\
`mathmodule22.42m`\
`$ ls /usr/dev/lib/utils`\
`fileutils.42m`\
`userutils.42m`\
`dbutils.42m`\
`$ fgllink -o myprog.42r mymodule.42m mathlib1.42x fileutils.42m`

In this example the linker will find the specified files in the
`/usr/dev/lib/maths` and `/usr/dev/lib/utils` directories defined in
[FGLLDPATH](EnvironmentVariables.html#EV_FGLLDPATH).

When creating a .42r program by linking .42m modules with .42x
libraries, if the same function is defined in a .42m and in a module of
a 42x library, the function of the specified .42m module will be
selected by the linker, and the function of the library will be ignored.
However, the linker will raise error -6203 if two .42m modules specified
in the link command define the same function.

Note that if none of the functions of a module are used by a program,
the complete module is excluded when the program is linked. This may
cause undefined function errors at runtime, such as when a function is
only used in a dynamic call (an initialization function, for example.) 

If you are using C Extensions, you may need to use the -e option to
specify the list of extension modules if the [IMPORT](CExtensions.html)
keyword is not used:

` $ fgllink -e extlib,extlib2,extlib3 -o stores.42r main.42m store.42m`

The following case illustrates this behavior:

` $ cat x1.4gl`\
`function fx1A()`\
`end function`\
`function fx2A()`\
`end function`\
\
`$ cat x2.4gl`\
`function fx2A()`\
`end function`\
`function fx2B()`\
`end function`\
\
`$ cat prog.4gl`\
`main`\
`  call fx1A()`\
`end main`\
\
`$ fglcomp x1.4gl`\
`$ fglcomp x2.4gl`\
`$ fglcomp prog.4gl`\
\
`$ fgllink -o lib.42x x1.42m x2.42m`\
\
`$ fgllink -o prog.42r prog.42m lib.42x`

Here, module `x1.42m` will be included in the program, but module
`x2.42m` will not. At runtime, any dynamic call to `fx2A()` or `fx2B()`
will fail.

The link process searches *recursively* for the functions used by the
program. For example, if the MAIN block calls function FA in module MA,
and FA calls FB in module MB, all functions from module MA and MB will
be included in the **42r** program definition.

------------------------------------------------------------------------

## [Using Makefiles]{#MAKEFILES}

Most UNIX platforms provide the **make** utility program to compile
projects. The **make** program is an interpreter of *Makefiles*. These
files contain directives to compile and link programs and/or generate
other kind of files.

When developing on Microsoft Windows platforms, you may use the
**NMAKE** utility provided with Visual C++, however this tool does not
have the same behavior as the Unix make program. To have a compatible
make on Windows, you can install a GNU make or third party Unix tools
such as Cygwin.

For more details about the **make** utility, see the platform-specific
documentation.

The follow example shows a typical *Makefile* for Genero applications:

    #------------------------------------------------------
    # Generic makefile rules to be included in Makefiles

    .SUFFIXES: .42s .42f .42m .42r .str .per .4gl .msg .hlp

    FGLFORM=fglform -M
    FGLCOMP=fglcomp -M
    FGLLINK=fglrun -l
    FGLMKMSG=fglmkmsg
    FGLMKSTR=fglmkstr
    FGLLIB=$$FGLDIR/lib/libfgl4js.42x

    all::

    .msg.hlp:
        $(FGLMKMSG) $*.msg $*.hlp

    .str.42s:
        $(FGLMKSTR) $*.str $*.42s

    .per.42f:
        $(FGLFORM) $*.per

    .4gl.42m:
        $(FGLCOMP) $*.4gl

    clean::
        rm -f *.hlp *.42? *.out


    #-----------------------------
    # Makefile example

    include Makeincl

    FORMS=\
     customers.42f\
     orderlist.42f\
     itemlist.42f

    MODULES=\
     customerInput.42m\
     zoomOrders.42m\
     zoomItems.42m

    customer.42x: $(MODULES)
        $(FGLLINK) -o customer.42x $(MODULES)

    all:: customer.42x $(FORMS)

------------------------------------------------------------------------

## [Getting Build Information]{#BUILDINFO}

The compiler version used to build the **42m** modules must be
compatible to the runtime system used to execute the programs. The
[fglcomp](Tools.html#TL_FGLCOMP) compiler writes version information in
the generated **42m** files. This can be useful on site, if you need to
check the version of the compiler that was used to build the **42m**
nodules.

To extract build information, run [fglrun](Tools.html#TL_FGLRUN) with
the `-b `option:

`$ fglrun -b mymodule.42m`\
`2.11.01-1161.12 /home/devel/stores/mymodule.4gl 15`

The output shows the following fields:

1.  The product version and build number (`2.11.01-1161.12`).
2.  The full path of the source file (/home/devel/stores/mymodule.4gl).
3.  The internal identifier of the pcode version. 

**Tip: fglrun -b can read the header of pcode modules compiled with
older versions of fglcomp and display version information for such old
modules. If fglrun cannot recognize a pcode module, it returns with an
execution status is different from zero.**

When reading build information of a 42x or 42r file, fglrun scans all
modules used to build the library or program. You will see different
versions in the first column if the modules where compiled with
different versions of fglcomp. Note however that it\'s not recommended
to end up with mixed versions on a production site:

`$ fglrun -b myprogram.42r`\
`2.11.01-1161.12 /home/devel/stores/mymodule1.4gl 15`\
`2.10.02-1148.36 /home/devel/stores/mymodule2.4gl 15`\
`2.11.01-1161.12 /home/devel/stores/mymodule3.4gl 15`

If you need to write timestamp information in the pcode modules, you can
use the \--timestamp option of fglcomp:

`$ fglcomp --timestamp mymodule.4gl`\
`$ fglrun -b mymodule.42m`\
`2008-12-24 11:22:33 2.11.05-1169.84 /home/devel/stores/mymodule.4gl 15`

However, with timestamp information in pcode modules, you will not be
able to easily compare 42m files (based on a checksum for example).
Without the timestamp, fglcomp generates exactly the same pcode module
if the source file was not modified.

To check if the version of the runtime system corresponds to the pcode
version, run [fglrun](Tools.html#TL_FGLRUN) with the `-V` option.
