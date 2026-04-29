[Back to Contents](../index.html)

------------------------------------------------------------------------

# [Installation and Setup]{#PAGE_HEADER}

This chapter includes instructions to install and setup Genero BDL.

Summary:

- [1. Resources](#INST_RES)
- [2. Requirements](#INST_REQ)
  - [2.1 Supported Operating Systems](#INST_SUPPOS)
  - [2.2 Database Client Software and Genero Drivers](#INST_SR_DBCLIENT)
  - [2.3 C Compiler for C Extensions](#INST_SR_COMPILER)
  - [2.4 Java Runtime Environment for Java Interface](#INST_SR_JRE)
- [3. Installing the Product](#INST_INSTALLING)
- [4. Upgrading the Product](#INST_UPGRADING)
- [5. Operating System Specific Notes](#INST_OS_SPECNOTES)
  - [5.1 HP/UX](#INST_OS_SN_HPX)
  - [5.2 IBM AIX](#INST_OS_SN_AIX)
  - [5.3 Microsoft Windows](#INST_OS_SN_WNT)

*See also:* [Tools and Components](Tools.html), [Localization
Support](Localization.html), [Environment
Variables](EnvironmentVariables.html).

------------------------------------------------------------------------

## [1. Resources]{#INST_RES}

Before starting your development with a new version of Genero BDL, we
strongly recommend you to read the Upgrade Guide corresponding to the
newly installed version. For example, see the [2.3x Upgrade
Guide](Mig0005.html).

The Genero BDL improvements can be found in the [New
Features](NewFeatures.html) section of this documentation.

Contact you support channel to get the list of corrected defects in the
new Genero BDL version.

------------------------------------------------------------------------

## 2. [Requirements]{#INST_REQ}

------------------------------------------------------------------------

### 2.1 [Supported Operating Systems]{#INST_SUPPOS}

Genero BDL is supported on a large brand of operating systems, such as
Linux, IBM AIX, HP-UX, SUN Solaris, Mac OS/X and Microsoft Windows.

You must install the Genero BDL software package corresponding to the
operating system that you use. For the detailed list of supported
operating systems, refer to the relevant Installation Guide or contact
your support center.

------------------------------------------------------------------------

### 2.2 [Database Client Software and Genero Drivers]{#INST_SR_DBCLIENT}

To connect to a database server, you need the database client software
to be installed on the system where you run the Genero BDL programs.

Below is a list of database client software examples:

- Informix Client SDK (with ESQL/C)
- DB2 Connect (with CLI)
- Oracle Client (with OCI)
- Microsoft SQL Server Client (with ODBC driver)
- PostgreSQL client (libpq)
- MySQL client (libmysqlclient)
- FreeTDS ODBC client (libtdsodbc)
- EasySoft ODBC client for SQL Server (libessqlsrv)
- SQLite 3.x (libsqlite3.so)
- Genero db client (ODBC driver)

Database drivers are provided as pre-linked shared libraries. There is
no need to link a runner or driver on site, but the database client
software must provide a shared library corresponding to the one used to
link the driver. The table in the next section lists supported database
client software versions and the corresponding shared libraries that
must exist on the system.

The database driver to be selected must correspond to the database
client type and version. For the list of supported database drivers, see
the driver table in the [Database Connections](Connections.html)
section. See also [Operating System Specific Notes](#INST_OS_SPECNOTES).

------------------------------------------------------------------------

### 2.3 [C Compiler for C extensions]{#INST_SR_COMPILER}

If your Genero application requires runtime system [C
Extensions](CExtensions.html) to execute, you need a C compiler and
linker to build the extension library.

#### [2.3.1 C compiler On UNIX platforms:]{.underline}

#### Warning: On UNIX platforms, you need a cc compiler on the system where you create the C extension libraries. Some systems may not have a C compiler by default. Make sure you have a C compiler on the system.

#### [2.3.2 C compiler On Microsoft Windows platforms:]{.underline}

#### Warning: On Windows platforms, it is mandatory to install Microsoft Visual C++ version 7.1 or higher on the system where you create the C extension libraries. You must install the appropriate Genero BDL package according to the version of Visual C++ you have installed. For example, when using Visual C++ 8, you must install the package marked by the `w32vc80` operating system identifier.

------------------------------------------------------------------------

### 2.4 [Java Runtime Environment for Java Interface]{#INST_SR_JRE}

If you are using the [Java Interface](JavaBridge.html) in your
application programs, you need to install the latest Java Runtime
Environment (JRE).

Search the internet for latest JRE packages available for your platform.

The minimum required JRE version is **Java 6.10**.

------------------------------------------------------------------------

## 3. [Installing the Product]{#INST_INSTALLING}

The Genero BDL product is provided in different forms of installation
programs, and can also be shipped in a bundle package with other Genero
products. Refer to the appropriate Installation Guide for a detailed
description of the installation procedure. Do not hesitate to contact
your support if you need help.

After installing Genero BDL, you should:

1.  Set FGLDIR to the installation directory of Genero BDL. While
    [FGLDIR](EnvironmentVariables.html#EV_FGLDIR) is not mandatory to
    execute [Genero BDL tools](Tools.html), some components of the
    product may need this environment variable to be set.
2.  If you want to run [Genero BDL tools](Tools.html) from the command
    line without specifying the path the the installation directory, set
    the [PATH](EnvironmentVariables.html#EV_PATH) environment variable
    to the bin directory where Genero BDL has been installed.
3.  Environment variables for the database client software
    (INFORMIXDIR/INFORMIXC, ORACLE_HOME, DB2DIR, SYBASE, PGDIR,
    LD_LIBRARY_PATH, etc) have to be set properly.
4.  Check that you have access to all needed DLLs (PATH) or shared
    libraries (LD_LIBRARY_PATH, LD_LIBRARY_PATH_64, SHLIB_PATH, LIBPATH
    or DYLD_LIBRARY_PATH).
5.  According to the database server you want to connect to, you will
    need to set up the correct database driver in FGLPROFILE. The
    default database driver is Informix. For more details about database
    driver configuration, see [Database Connections](Connections.html).
6.  Depending what rendering mode you want to use (text mode or
    graphical mode), you may have to set environment variables such as
    [FGLGUI](EnvironmentVariables.html#EV_FGLGUI),
    [FGLSERVER](EnvironmentVariables.html#EV_FGLSERVER),
    [TERM](EnvironmentVariables.html#EV_TERM) and
    [TERMCAP](EnvironmentVariables.html#EV_TERMCAP). See [Dynamic User
    Interface](DynamicUI.html) for more details.
7.  If you need to create C Extensions, the system must have a [C
    compiler](#INST_SR_COMPILER) installed.

------------------------------------------------------------------------

## 4. [Upgrading the Product]{#INST_UPGRADING}

After upgrading Genero BDL to a newer version, follow the next steps:

1.  If the new version version is a major upgrade (for exemple, from
    2.20 to 2.21), recompile the sources and form files. While
    recompilation is not needed when migrating to maintenance release
    versions (for example, from 2.21.01 to 2.21.02), it is recommended
    to benefit from potential p-code optimizations in the new version.
2.  If required, you may need to re-create the C Extension libraries. C
    extension libraries must be provided as dynamically loadable modules
    and thus should not required a rebuild. However, if Genero C API
    header files have changed, consider recompiling you C extensions.
    Check FGLDIR/include/f2c for C API header file changes.

------------------------------------------------------------------------

## 5. [Operating System Specific Notes]{#INST_OS_SPECNOTES}

------------------------------------------------------------------------

### 5.1 [HP/UX]{#INST_OS_SN_HPX}

#### [Thread Local Storage in shared libraries]{.underline}

On HP/UX, the shared library loader cannot load libraries using **Thread
Local Storage (TLS)**, like Oracle *libclntsh*. In order to use shared
libraries with TLS, you must use the **LD_PRELOAD_ONCE** environment
variable. For more details, search for \"shl_load + Thread Local
Storage\" on the HP support site.

#### [PostgreSQL on HP/UX LP64]{.underline}

On HP/UX LP64, the PostgreSQL database driver should be linked with the
**libxnet** library if you want to use networking. You can force the
usage of libxnet by setting the **LD_PRELOAD_ONCE** environment variable
to **/lib/pa20_64/libxnet.sl**.

#### [Java Interface]{.underline}

When using the Java Interface with the SUN Hotspot JVM:

If you get an error when fglcomp or fglrun try to load the libjvm
library, use the **LD_PRELOAD** environment variable:

`$ LD_PRELOAD=libjvm.sl`\
`$ export LD_PRELOAD`

Note that using **LD_PREPLOAD** can make other application fail.
**LD_PRELOAD** should only be set for Genero BDL tools. If you need to
run other applications in the same environment as Genero BDL programs,
you can set the **LD_PRELOAD_ONCE** or **JAVA_PRELOAD_ONCE** variable in
the shell scripts found in FGLDIR/bin.

------------------------------------------------------------------------

### 5.2 [IBM AIX]{#INST_OS_SN_AIX}

#### [LIBPATH environment variable]{.underline}

The **LIBPATH** environment variable defines the search path for shared
libraries. Make sure **LIBPATH** contains all required library
directories, including the system library path **/lib** and
**/usr/lib**.

#### [Shared libraries archives]{.underline}

On AIX, shared libraries are usually provided in .a archives containing
the shared object(s). For example, the DB2 client library libdb2.a
contains both the 32 bit (shr.o) and the 64 bit (shr_64.o) versions of
the shared library. Not all products follow this rule: for example
Oracle 9.2 provides libclntsh.a with shr.o on 64 bit platforms, and
Informix provides both .a archives with static objects and .so shared
libraries as on other platforms\...

The Genero database drivers are created with the library archives or
with the .so shared objects, according to the database type and version.
No particular manipulation is needed to use any supported database
client libraries on this platform. 

IBM provides a document describing linking on AIX systems. It is
recommended that you read this document.

http://www.ibm.com/servers/esdd/pdfs/**aix_ll**.**pdf**

#### [The dump command]{.underline}

On IBM AIX, you can check the library dependencies with the **dump**
command:

`$ dump -Hv -X64 dbmora92x.so`

#### [Unloading shared libraries from memory]{.underline}

In production environments, AIX loads shared libraries into the system
shared library segment in order to improve program load time. Once a
shared library is loaded, other programs using the same library are just
attached to that memory segment. This works fine as long as you don\'t
need to change the shared library (to replace it with a new version for
example).

Once a shared library is loaded by the system, you cannot copy the
executable file unless you unload the library from the system memory.
Thus, you will probably need to unload the Genero shared libraries
before installing a new version of the software. This problem occurs
when installing in the same directory, but can also happen when
installing in a different directory. As shared libraries will have the
same name, AIX will not allow to load multiple versions of the same
library. Therefore, before installing a new version of Genero, make sure
all shared libraries are unloaded from the system memory.

To get the list of shared libraries currently loaded into memory, use
the **genkld** command. The **genld** command collects the list of all
processes and reports the list of loaded objects corresponding to each
process. Then, use the **slibclean** command to unload a shared library
from the system shared library segment.

#### [POSIX Threads and shared libraries]{.underline}

When using a thread-enabled shared library like Oracle\'s **libclntsh**,
the program using the shared object must be linked with thread support,
otherwise you can experience problems (like segmentation fault when the
runner program ends). IBM recommends using the xlc_r compiler to link a
program with pthread support.

By default, the runtime system provided for AIX platforms is linked with
pthread support.

------------------------------------------------------------------------

### 5.3 [Microsoft Windows]{#INST_OS_SN_WNT}

#### [Microsoft Visual C version]{.underline}

You need Microsoft Visual C++ compiler to create C Extensions. Make sure
you have installed the correct Genero package, according to the MSVC
version you have installed on your system. MSVC runtime libraries of
different VC++ versions are not compatible. Refer to the name of the
Genero package to check the VC++ version compatibility.

#### [Searching binary]{.underline} [dependencies]{.underline}

Microsoft Visual C provides the **dumpbin** utility.

To check for DLL dependency, you can use the **/dependents** option:

`C:\ dumpbin /dependents mylib.dll`\
`Microsoft (R) COFF/PE Dumper Version 7.10.3077`\
`Copyright (C) Microsoft Corporation. All rights reserved.`\
\
`Dump of file mylib.dll`\
\
`File Type: EXECUTABLE IMAGE`\
\
`Image has the following dependencies:`\
\
`isqlt09a.dll`\
`MSVCR71.dll`\
`KERNEL32.dll`\
\
`Summary`\
\
`1000 .data`\
`1000 .rdata`\
`1000 .text`

#### [Changing the stack size of fglrun]{.underline}

On Windows platforms, the fglrun.exe binary has a predefined C stack
size. In some rare cases (for example, if your programs do deep
recursion), you may need to change the stack size of fglrun.exe binary
to avoid stack overflow. You can change this permanently by patching the
EXE file with a Microsoft Visual C++ utility called **editbin**. By
default, the C stack size of fglrun.exe is 1MB.

You can check the stack size by running the **dumpbin** VC++ utility on
fglrun.exe:

`C:\ dumpbin /headers %FGLDIR%\bin\fglrun.exe`

Search for the line containing \"stack reserve\" words in the OPTIONAL
HEADER VALUES section:

`OPTIONAL HEADER VALUES`\
`   ...`\
`   100000 size of stack reserve`

Note that the stack size is displayed in hexadecimal value, so 100,000 =
1,048,567 bytes = 1MB.

In order to modify the stack size of fglrun.exe, run the the **editbin**
VC++ utility on fglrun.exe:

`C:\ editbin /stack:1000000 %FGLDIR%\bin\fglrun.exe`

See Microsoft Visual C++ documentation for more details about these
tools.

------------------------------------------------------------------------
