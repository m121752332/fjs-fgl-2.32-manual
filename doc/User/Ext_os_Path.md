[Back to Contents](../index.html)

------------------------------------------------------------------------

# [File Management Class]{#PAGE_HEADER}

Summary:

- [Basics](#BASICS)
- [Syntax](#SYNTAX)
- [Methods](#METHODS)
- [Examples](#EXAMPLES)
  - [Example 1: Extracting the parts of a file name](#EXAMPLE_1)
  - [Example 2: Browsing directories](#EXAMPLE_2)

*See also:* [Built-in Functions](BuiltInFunctions.html)

------------------------------------------------------------------------

## [Basics]{#BASICS}

The Path class provides functions to manipulate files and directories on
the machine where the BDL program executes.

This API is provided as a [Dynamic C Extension](CExtensions.html)
library; it is part of the standard package.

To use this extension, you must import the **os** package in your
program:

    IMPORT os

**Warning: In order to manipulate files, this API give you access to
low-level system functions. Pay attention to operating system specific
conventions like path separators. Some functions are OS specific, like
[rwx()](#FILE_RWX) which works only on UNIX systems.**

------------------------------------------------------------------------

## [Syntax]{#SYNTAX}

The **Path** class provides an interface to manipulate files and
directories.

#### Syntax:

`os.Path`

#### Notes:

1.  This class does not have to be instantiated; it provides class
    methods for the current program.

------------------------------------------------------------------------

## [Methods:]{#METHODS}

+--------------------------------------+----------------------------------+
| **Class Methods**                                                       |
+--------------------------------------+----------------------------------+
| **Name**                             | **Description**                  |
+--------------------------------------+----------------------------------+
| [separator](#FILE_SEPARATOR)         | Returns the character used to    |
|                                      | separate path segments.          |
+--------------------------------------+----------------------------------+
| [pathseparator](#FILE_PATHSEPARATOR) | Returns the character used in    |
|                                      | environment variables to         |
|                                      | separate path elements.          |
+--------------------------------------+----------------------------------+
| [basename](#FILE_BASENAME)           | Returns the last element of a    |
|                                      | path.                            |
+--------------------------------------+----------------------------------+
| [dirname](#FILE_DIRNAME)             | Returns all components of a path |
|                                      | excluding the last one.          |
+--------------------------------------+----------------------------------+
| [rootname](#FILE_ROOTNAME)           | Returns the file path without    |
|                                      | the file extension of the last   |
|                                      | element of the file path.        |
+--------------------------------------+----------------------------------+
| [join](#FILE_JOIN)                   | Joins two path segments adding   |
|                                      | the platform-dependent           |
|                                      | separator.                       |
+--------------------------------------+----------------------------------+
| [pathtype](#FILE_PATHTYPE)           | Checks whether a path is a       |
|                                      | relative path or an absolute     |
|                                      | path.                            |
+--------------------------------------+----------------------------------+
| [exists](#FILE_EXISTS)               | Checks if a file exists.         |
+--------------------------------------+----------------------------------+
| [extension](#FILE_EXTENSION)         | Returns the file extension.      |
+--------------------------------------+----------------------------------+
| [readable](#FILE_READABLE)           | Checks if a file is readable.    |
+--------------------------------------+----------------------------------+
| [writable](#FILE_WRITABLE)           | Checks if a file is writable.    |
+--------------------------------------+----------------------------------+
| [executable](#FILE_EXECUTABLE)       | Checks if a file is executable.  |
+--------------------------------------+----------------------------------+
| [isfile](#FILE_ISFILE)               | Checks if a file is a regular    |
|                                      | file.                            |
+--------------------------------------+----------------------------------+
| [isdirectory](#FILE_ISDIRECTORY)     | Checks if a file is a directory. |
+--------------------------------------+----------------------------------+
| [ishidden](#FILE_ISHIDDEN)           | Checks if a file is hidden.      |
+--------------------------------------+----------------------------------+
| [islink](#FILE_ISLINK)               | Checks if a file is a UNIX       |
|                                      | symbolic link.                   |
+--------------------------------------+----------------------------------+
| [isroot](#FILE_ISROOT)               | Checks if a file is a root path. |
+--------------------------------------+----------------------------------+
| [type](#FILE_TYPE)                   | Returns the file type as a       |
|                                      | string.                          |
+--------------------------------------+----------------------------------+
| [size](#FILE_SIZE)                   | Returns the file size.           |
+--------------------------------------+----------------------------------+
| [atime](#FILE_ATIME)                 | Returns the time of the last     |
|                                      | file access.                     |
+--------------------------------------+----------------------------------+
| [chown](#FILE_CHOWN)                 | Changes the UNIX owner and group |
|                                      | of a file.                       |
+--------------------------------------+----------------------------------+
| [uid](#FILE_UID)                     | Returns the UNIX user id of the  |
|                                      | file.                            |
+--------------------------------------+----------------------------------+
| [gid](#FILE_GID)                     | Returns the UNIX group id of the |
|                                      | file.                            |
+--------------------------------------+----------------------------------+
| [rwx](#FILE_RWX)                     | Returns the UNIX permissions on  |
|                                      | the file.                        |
+--------------------------------------+----------------------------------+
| [chrwx](#FILE_CHRWX)                 | Changes the UNIX permissions of  |
|                                      | a file.                          |
+--------------------------------------+----------------------------------+
| [mtime](#FILE_MTIME)                 | Returns the time of the last     |
|                                      | file modification.               |
+--------------------------------------+----------------------------------+
| [homedir](#FILE_HOMEDIR)             | Returns the path to the HOME     |
|                                      | directory of the current user.   |
+--------------------------------------+----------------------------------+
| [rootdir](#FILE_ROOTDIR)             | Returns the root directory of    |
|                                      | the current path.                |
+--------------------------------------+----------------------------------+
| [dirfmask](#FILE_DIRFMASK)           | Defines the filter mask for a    |
|                                      | [diropen](#FILE_DIROPEN) call    |
+--------------------------------------+----------------------------------+
| [dirsort](#FILE_DIRSORT)             | Defines the sort criteria and    |
|                                      | sort order for a                 |
|                                      | [diropen](#FILE_DIROPEN) call    |
+--------------------------------------+----------------------------------+
| [diropen](#FILE_DIROPEN)             | Opens a directory and returns an |
|                                      | integer handle to this           |
|                                      | directory.                       |
+--------------------------------------+----------------------------------+
| [dirclose](#FILE_DIRCLOSE)           | Closes the directory referenced  |
|                                      | by the directory handle.         |
+--------------------------------------+----------------------------------+
| [dirnext](#FILE_DIRNEXT)             | Reads the next entry of the      |
|                                      | directory referenced by the      |
|                                      | directory handle.                |
+--------------------------------------+----------------------------------+
| [pwd](#FILE_PWD)                     | Returns the current working      |
|                                      | directory.                       |
+--------------------------------------+----------------------------------+
| [chdir](#FILE_CHDIR)                 | Changes the current working      |
|                                      | directory                        |
+--------------------------------------+----------------------------------+
| [volumes](#FILE_VOLUMES)             | Returns the list of available    |
|                                      | volumes.                         |
+--------------------------------------+----------------------------------+
| [chvolume](#FILE_CHVOLUME)           | Changes the current working      |
|                                      | volume.                          |
+--------------------------------------+----------------------------------+
| [mkdir](#FILE_MKDIR)                 | Creates a new directory.         |
+--------------------------------------+----------------------------------+
| [delete](#FILE_DELETE)               | Deletes a file or a directory.   |
+--------------------------------------+----------------------------------+
| [rename](#FILE_RENAME)               | Renames a file or a directory.   |
+--------------------------------------+----------------------------------+
| [copy](#FILE_COPY)                   | Copies a regular file.           |
+--------------------------------------+----------------------------------+

------------------------------------------------------------------------

### [os.Path.separator]{#FILE_SEPARATOR}

#### Purpose:

Returns the character used to separate path segments.

#### Syntax:

`CALL os.Path.separator() RETURNING `*`separator`*` STRING`

#### Notes:

1.  *separator* contains the separator.
2.  On Unix, the separator is \'/\'
3.  On Windows, the separator is \'\\\'

------------------------------------------------------------------------

### [os.Path.pathseparator]{#FILE_PATHSEPARATOR}

#### Purpose:

Returns the character used in environment variables to separate path
elements.

#### Syntax:

`CALL os.Path.pathseparator() RETURNING `*`separator`*` STRING`

#### Notes:

1.  *separator* contains the path separator.
2.  On Unix, the separator is \':\'
3.  On Windows, the separator is \';\'

#### Usage:

You typically use this method to build a path from two components.

------------------------------------------------------------------------

### [os.Path.basename]{#FILE_BASENAME}

#### Purpose:

This method returns the last element of a path.

#### Syntax:

`CALL os.Path.basename(`*`filename`*` STRING) RETURNING `*`basename`*` STRING`

#### Notes:

1.  *filename* is the name of the file.
2.  *basename* is the last element of the path.

#### Usage:

This method extracts the last component of a path. For example, if you
pass `"/root/dir1/file.ext"` as the parameter, it will return
`"file.ext"`.

See [Example 1](#EXAMPLE_1) for more examples.

------------------------------------------------------------------------

### [os.Path.dirname]{#FILE_DIRNAME}

#### Purpose:

Returns all components of a path excluding the last one.

#### Syntax:

`CALL os.Path.dirname(`*`filename`*` STRING) RETURNING `*`dirname`*` STRING`

#### Notes:

1.  *filename* is the name of the file.
2.  *dirname* contains all the elements of the path excluding the last
    one.

#### Usage:

This method removes the last component of a path. For example, if you
pass `"/root/dir1/file.ext"` as the parameter, it will return
`"/root/dir1"`.

See [Example 1](#EXAMPLE_1) for more examples.

------------------------------------------------------------------------

### [os.Path.rootname]{#FILE_ROOTNAME}

#### Purpose:

Returns the file path without the file extension of the last element of
the file path.

#### Syntax:

`CALL os.Path.rootname(`*`filename`*` STRING) RETURNING `*`rootname`*` STRING`

#### Notes:

1.  *filename* is the file path.
2.  *rootname* contains the file path without the file extension of the
    last element.

#### Usage:

This method removes the file extension from the path. For example, if
you pass `"/root/dir1/file.ext"` as the parameter it will return
`"/root/dir1/file"`.

See [Example 1](#EXAMPLE_1) for more examples.

------------------------------------------------------------------------

### [os.Path.join]{#FILE_JOIN}

#### Purpose:

Joins two path segments adding the platform-dependent separator.

#### Syntax:

`CALL os.Path.join(`*`begin`*` STRING, `*`end`*` STRING) RETURNING `*`newpath`*` STRING`

#### Notes:

1.  *begin* is the beginning path segment.
2.  *end* is the ending path segment.
3.  *newpath* contains the joined path segments.

#### Usage:

You typically use this method to construct a path with no
system-specific code to use the correct path separator:

``` linenumber
01   LET path = os.Path.join(os.Path.homedir(), name)
```

This method returns the ending path segment if it is an absolute path.

------------------------------------------------------------------------

### [os.Path.pathtype]{#FILE_PATHTYPE}

#### Purpose:

Checks if a path is a relative path or an absolute path.

#### Syntax:

`CALL os.Path.pathtype(`*`path`*` STRING) RETURNING `*`pathtype`*` STRING`

#### Notes:

1.  *path* is the path to check.
2.  *pathtype* can be \"absolute\" if the path is an absolute path, or
    \"relative\" if the path is a relative path.

------------------------------------------------------------------------

### [os.Path.exists]{#FILE_EXISTS}

#### Purpose:

Checks if a file exists.

#### Syntax:

`CALL os.Path.exists(`*`fname`*` STRING) RETURNING `*`result`*` INTEGER`

#### Notes:

1.  *fname* is the file name.
2.  *result* is TRUE if the file exists, FALSE otherwise.

------------------------------------------------------------------------

### [os.Path.extension]{#FILE_EXTENSION}

#### Purpose:

Returns the file extension.

#### Syntax:

`CALL os.Path.extension(`*`fname`*` STRING) RETURNING `*`extension`*` STRING`

#### Notes:

1.  *fname* is the file name.
2.  *extension* is the string following the last dot found in *fname*.
3.  If fname does not have an extension, the function returns
    [NULL](Programs.html#PC_NULL).

------------------------------------------------------------------------

### [os.Path.readable]{#FILE_READABLE}

#### Purpose:

Checks if a file is readable.

#### Syntax:

`CALL os.Path.readable(`*`fname`*` STRING) RETURNING `*`result`*` INTEGER`

#### Notes:

1.  *fname* is the file name.
2.  *result* is TRUE if the file is readable, FALSE otherwise.

------------------------------------------------------------------------

### [os.Path.writable]{#FILE_WRITABLE}

#### Purpose:

Checks if a file is writable.

#### Syntax:

`CALL os.Path.writable(`*`fname`*` STRING) RETURNING `*`result`*` INTEGER`

#### Notes:

1.  *fname* is the file name.
2.  *result* is TRUE if the file is writable, FALSE otherwise.

------------------------------------------------------------------------

### [os.Path.executable]{#FILE_EXECUTABLE}

#### Purpose:

Checks if a file is executable.

#### Syntax:

`CALL os.Path.executable(`*`fname`*` STRING) RETURNING `*`result`*` INTEGER`

#### Notes:

1.  *fname* is the file name.
2.  *result* is TRUE if the file is executable, FALSE otherwise.

------------------------------------------------------------------------

### [os.Path.isfile]{#FILE_ISFILE}

#### Purpose:

Checks if a file is a regular file.

#### Syntax:

`CALL os.Path.isfile(`*`fname`*` STRING) RETURNING `*`result`*` INTEGER`

#### Notes:

1.  *fname* is the file name.
2.  *result* is TRUE if the file is a regular file, FALSE otherwise.

------------------------------------------------------------------------

### [os.Path.isdirectory]{#FILE_ISDIRECTORY}

#### Purpose:

Checks if a file is a directory.

#### Syntax:

`CALL os.Path.isdirectory(`*`fname`*` STRING) RETURNING `*`result`*` INTEGER`

#### Notes:

1.  *fname* is the file name.
2.  *result* is TRUE if the file is a directory, FALSE otherwise.

------------------------------------------------------------------------

### [os.Path.ishidden]{#FILE_ISHIDDEN}

#### Purpose:

Checks if a file is hidden.

#### Syntax:

`CALL os.Path.ishidden(`*`fname`*` STRING) RETURNING `*`result`*` INTEGER`

#### Notes:

1.  *fname* is the file name.
2.  *result* is TRUE if the file is hidden, FALSE otherwise.

------------------------------------------------------------------------

### [os.Path.islink]{#FILE_ISLINK}

#### Purpose:

Checks if a file is UNIX symbolic link.

#### Syntax:

`CALL os.Path.islink(`*`fname`*` STRING) RETURNING `*`result`*` INTEGER`

#### Notes:

1.  *fname* is the file name.
2.  *result* is TRUE if the file is a symbolic link, FALSE otherwise.

**Warning: This method can only be used on UNIX!**

------------------------------------------------------------------------

### [os.Path.isroot]{#FILE_ISROOT}

#### Purpose:

Checks if a file path is a root path.

#### Syntax:

`CALL os.Path.isroot(`*`path`*` STRING) RETURNING `*`result`*` STRING`

#### Notes:

1.  *path* is the path to check.
2.  *result* is TRUE if the path is a root path, FALSE otherwise.
3.  On Unix the root path is \'/\'
4.  On Windows the root path matches \"\[a-zA-Z\]:\\\"

------------------------------------------------------------------------

### [os.Path.type]{#FILE_TYPE}

#### Purpose:

Returns the file type as a string

#### Syntax:

`CALL os.Path.type(`*`fname`*` STRING) RETURNING `*`ftype`*` STRING`

#### Notes:

1.  *fname* is the file name.
2.  *ftype* can be one of:
    1.  file : the file is a regular file
    2.  directory : the file is a directory
    3.  socket : the file is a socket
    4.  fifo : the file is a fifo
    5.  block : the file is a block device
    6.  char : the file is a character device

**Warning: On UNIX, this method follows symbolic links. You must use the
islink() method to identify symbolic links.**

------------------------------------------------------------------------

### [os.Path.size]{#FILE_SIZE}

#### Purpose:

Returns the size of a file.

#### Syntax:

`CALL os.Path.size(`*`fname`*` STRING) RETURNING `*`size`*` INTEGER`

#### Notes:

1.  *fname* is the file name.
2.  *size* is the file size

------------------------------------------------------------------------

### [os.Path.atime]{#FILE_ATIME}

#### Purpose:

Returns the time of the last file access.

#### Syntax:

`CALL os.Path.atime(`*`fname`*` STRING) RETURNING `*`atime`*` STRING`

#### Notes:

1.  *fname* is the name of the file.
2.  *atime* is a string containing the last access time for the
    specified file in the standard format \'YYYY-MM-DD HH:MM:SS\'.
3.  If the function failed, it returns NULL.

------------------------------------------------------------------------

### [os.Path.mtime]{#FILE_MTIME}

#### Purpose:

Returns the time of the last file modification.

#### Syntax:

`CALL os.Path.mtime(`*`fname`*` STRING) RETURNING `*`mtime`*` STRING`

#### Notes:

1.  *fname* is the name of the file.
2.  *mtime* is a string containing the last modification time for the
    specified file in the standard format \'YYYY-MM-DD HH:MM:SS\'.
3.  If the function failed, it returns NULL.

------------------------------------------------------------------------

### [os.Path.rwx]{#FILE_RWX}

#### Purpose:

Returns the UNIX file permissions of a file.

#### Syntax:

`CALL os.Path.rwx(`*`fname`*` STRING) RETURNING `*`mode`*` INTEGER`

#### Notes:

1.  *fname* is the name of the file.
2.  *mode* is the combination of permissions for user, group and other.
3.  Function returns -1 if it fails to get the permissions.

**Warning: This method can only be used on UNIX!**

#### Usage:

The *mode* is returned as a decimal value which is the combination of
read, write and execution bits for the user, group and other part of the
UNIX file permission. For example, if a file has the `-rwxr-xr-x`
permissions, you get ( (4+2+1) \* 64 + (4+1) \* 8) + (4+1) ) = 493 from
this method.

------------------------------------------------------------------------

### [os.Path.chrwx]{#FILE_CHRWX}

#### Purpose:

Changes the UNIX permissions of a file.

#### Syntax:

`CALL os.Path.chrwx(`*`fname`*` STRING, `*`mode`*` INTEGER) RETURNING `*`res`*` INTEGER`

#### Notes:

1.  *fname* is the name of the file.
2.  *mode* is the UNIX permission combination in decimal (not octal!).
3.  Function returns TRUE on success, FALSE otherwise.

**Warning: This method can only be used on UNIX!**

#### Usage:

The *mode* must be a decimal value which is the combination of read,
write and execution bits for the user, group and other part of the UNIX
file permission. Make sure to pass the *mode* as the decimal version of
permissions, not as octal (the chrwx UNIX command takes an octal value
as parameter). For example, to set `-rw-r--r--` permissions, you must
pass ( ((4+2) \* 64) + (4 \* 8) + 4 ) = 420 to this method.

------------------------------------------------------------------------

### [os.Path.chown]{#FILE_CHOWN}

#### Purpose:

Changes the UNIX owner and group of a file.

#### Syntax:

`CALL os.Path.chown(`*`fname`*` STRING, uid INT, gui INT) RETURNING `*`res`*` INTEGER`

#### Notes:

1.  *fname* is the name of the file.
2.  *uid* is the user id.
3.  gui is the group id.
4.  Function returns TRUE on success, FALSE otherwise.

**Warning: This method can only be used on UNIX!**

------------------------------------------------------------------------

### [os.Path.uid]{#FILE_UID}

#### Purpose:

Returns the UNIX user id of a file.

#### Syntax:

`CALL os.Path.uid(`*`fname`*` STRING) RETURNING `*`id`*` INTEGER`

#### Notes:

1.  *fname* is the name of the file.
2.  *id* is the user id.
3.  Function returns -1 if it fails to get the user id.

**Warning: This method can only be used on UNIX!**

------------------------------------------------------------------------

### [os.Path.gid]{#FILE_GID}

#### Purpose:

Returns the UNIX group id of a file.

#### Syntax:

`CALL os.Path.gid(`*`fname`*` STRING) RETURNING `*`id`*` INTEGER`

#### Notes:

1.  *fname* is the name of the file.
2.  *id* is the group id.
3.  Function returns -1 if it fails to get the user id.

**Warning: This method can only be used on UNIX!**

------------------------------------------------------------------------

### [os.Path.homedir]{#FILE_HOMEDIR}

#### Purpose:

Returns the path to the HOME directory of the current user.

#### Syntax:

`CALL os.Path.homedir() RETURNING `*`homedir`*` STRING`

#### Notes:

1.  *homedir* Path to the HOME directory of the user.

------------------------------------------------------------------------

### [os.Path.rootdir]{#FILE_ROOTDIR}

#### Purpose:

Returns the root directory of the current working path.

#### Syntax:

`CALL os.Path.rootdir() RETURNING `*`rootdir`*` STRING`

#### Notes:

1.  *rootdir* is the root directory of the current working path.
2.  On Unix, it always returns \'/\'
3.  On Windows it returns the current working drive as \"\[a-zA-Z\]:\\\"

------------------------------------------------------------------------

### [os.Path.dirfmask]{#FILE_DIRFMASK}

#### Purpose:

Defines a filter mask for [diropen](#FILE_DIROPEN).

#### Syntax:

`CALL os.Path.dirfmask(`*`mask`*` INTEGER)`

#### Notes:

1.  *mask* defines the filter mask (see below for possible values).

#### Usage:

When you call this function, you define the filter mask for any
subsequent [diropen](#FILE_DIROPEN) call.

By default, all kinds of directory entries are selected by the
[diropen](#FILE_DIROPEN) function. You can restrict the number of
entries by using a filter mask.

The parameter of the `dirfmask` function must be a combination of the
following bits:

- `0x01` = Exclude hidden files (.\*)
- `0x02` = Exclude directories
- `0x04` = Exclude symbolic links
- `0x08` = Exclude regular files

For example, to retrieve only regular files, you must call:

``` linenumber
01 CALL os.Path.dirfmask( 1 + 2 + 4 )
```

------------------------------------------------------------------------

### [os.Path.dirsort]{#FILE_DIRSORT}

#### Purpose:

Defines the sort criteria and sort order for [diropen](#FILE_DIROPEN).

#### Syntax:

`CALL os.Path.dirsort(`*`criteria`*` STRING, `*`order`*` INTEGER)`

#### Notes:

1.  *criteria* is the sort criteria (see below for possible values).
2.  *order* defines ascending (1) or descending (-1) order.

#### Usage:

When you call this function, you define the sort criteria and sort order
for any subsequent [diropen](#FILE_DIROPEN) call.

The *criteria* parameter must be one of the following strings:

- `"undefined"` = No sort. This is the default. Entries are read as
  returned by the OS functions.
- `"name"` = Sort by file name.
- `"size"` = Sort by file size.
- `"type"` = Sort by file type (directory, link, regular file).
- `"atime"` = Sort by access time.
- `"mtime"` = Sort by modification time.
- `"extension"` = Sort by file extension.

When sorting by name, directory entries will be ordered according to the
[current locale](Localization.html).

When sorting by any criteria other than the file name, entries having
the same value for the given criteria are ordered by name following the
value of the *order* parameter.

------------------------------------------------------------------------

### [os.Path.diropen]{#FILE_DIROPEN}

#### Purpose:

Opens a directory and returns an integer handle to this directory.

#### Syntax:

`CALL os.Path.diropen(`*`dname`*` STRING) RETURNING `*`dirhandle`*` INTEGER`

#### Notes:

1.  *dname* is the name of the directory.
2.  *dirhandle* is the directory handle. A dirhandle value of 0
    indicates a failure when opening the directory.

#### Usage:

This function creates a list of directory

*See also:* [dirfmask](#FILE_DIRFMASK), [dirsort](#FILE_DIRSORT)

------------------------------------------------------------------------

### [os.Path.dirclose]{#FILE_DIRCLOSE}

#### Purpose:

Closes the directory referenced by the directory handle *dirhandle*.

#### Syntax:

`CALL os.Path.dirclose(`*`dirhandle`*` INTEGER)`

#### Notes:

1.  *dirhandle* is the directory handle of the directory to close.

------------------------------------------------------------------------

### [os.Path.dirnext]{#FILE_DIRNEXT}

#### Purpose:

Reads the next entry in the directory.

#### Syntax:

`CALL os.Path.dirnext(`*`dirhandle`*` INTEGER) RETURNING `*`direntry`*` STRING`

#### Notes:

1.  *dirhandle* is the directory handle of the directory to read.
2.  *direntry* is the name of the entry read or NULL if all entries have
    been read.

------------------------------------------------------------------------

### [os.Path.pwd]{#FILE_PWD}

#### Purpose:

Returns the current working directory.

#### Syntax:

`CALL os.Path.pwd() RETURNING `*`cwd`*` STRING`

#### Notes:

1.  *cwd* is the current working directory.

------------------------------------------------------------------------

### [os.Path.chdir]{#FILE_CHDIR}

#### Purpose:

Changes the current working directory.

#### Syntax:

`CALL os.Path.chdir(`*`newdir`*` STRING) RETURNING `*`result`*` INTEGER`

#### Notes:

1.  *newdir* is the directory to select.
2.  *result* is TRUE if the current directory could be successfully
    selected.

------------------------------------------------------------------------

### [os.Path.volumes]{#FILE_VOLUMES}

#### Purpose:

Returns the available volumes.

#### Syntax:

`CALL os.Path.volumes() RETURNING `*`volumes`*` STRING`

#### Notes:

1.  *volumes* contains the list of all available volumes separated by
    \"\|\".

------------------------------------------------------------------------

### [os.Path.chvolume]{#FILE_CHVOLUME}

#### Purpose:

Changes the current working volume.

#### Syntax:

`CALL os.Path.chvolume(`*`newvolume`*` STRING) RETURNING `*`result`*` INTEGER`

#### Notes:

1.  *newvolume* is the volume to select as the new current working
    volume.
2.  *result* is TRUE if the current working volume could be successfully
    changed.
3.  Sample : CALL os.Path.chvolume(\"C:\\\\\") RETURNING result

------------------------------------------------------------------------

### [os.Path.mkdir]{#FILE_MKDIR}

#### Purpose:

Creates a new directory.

#### Syntax:

`CALL os.Path.mkdir(`*`dname`*` STRING) RETURNING `*`result`*` INTEGER`

#### Notes:

1.  *dname* is the name of the directory to create
2.  *result* is TRUE if the directory has been successfully created,
    FALSE otherwise.

------------------------------------------------------------------------

### [os.Path.delete]{#FILE_DELETE}

#### Purpose:

Deletes a file or a directory.

#### Syntax:

`CALL os.Path.delete(`*`dname`*` STRING) RETURNING `*`result`*` INTEGER`

#### Notes:

1.  *fname* is the name of the file or directory to delete
2.  *result* is TRUE if the file or directory has been successfully
    deleted, FALSE otherwise.
3.  A directory can only be deleted if it is empty.

------------------------------------------------------------------------

### [os.Path.rename]{#FILE_RENAME}

#### Purpose:

Renames a file or a directory.

#### Syntax:

`CALL os.Path.rename(`*`oldname`*` STRING, `*`newname`*` STRING) RETURNING `*`result`*` INTEGER`

#### Notes:

1.  *oldname* is the current name of the file or directory to be
    renamed.
2.  *newname* is the new name to assign to the file or directory.
3.  *result* is TRUE if the file or directory has been successfully
    renamed, FALSE otherwise.

------------------------------------------------------------------------

### [os.Path.copy]{#FILE_COPY}

#### Purpose:

Copies a regular file or.

#### Syntax:

`CALL os.Path.copy(`*`source`*` STRING, `*`dest`*` STRING) RETURNING `*`result`*` INTEGER`

#### Notes:

1.  *source* is the name of the file to copy.
2.  *dest* is the destination name of the copied file.
3.  *result* is TRUE if the file has been successfully copied, FALSE
    otherwise.

------------------------------------------------------------------------

### [Examples:]{#EXAMPLES}

------------------------------------------------------------------------

#### [Example 1]{#EXAMPLE_1}: Extracting the parts of a file name

This program uses the file functions to extract the directory name, the
base name, the root name, and the file extension:

``` linenumber
01 IMPORT os
02 MAIN
03   DISPLAY "Dir name   = ", os.Path.dirname(arg_val(1))
04   DISPLAY "Base name  = ", os.Path.basename(arg_val(1))
05   DISPLAY "Root name  = ", os.Path.rootname(arg_val(1))
06   DISPLAY "Extension  = ", os.Path.extension(arg_val(1))
07 END MAIN
```

Example results:

  ---------------------- --------------------- ---------------------- ---------------------- -----------------------
  **Path**               **os.Path.dirname**   **os.Path.basename**   **os.Path.rootname**   **os.Path.extension**
  `.`                    `.`                   `.`                                           `NULL`
  `..`                   `.`                   `..`                   `.`                    `NULL`
  `/`                    `/`                   `/`                    `/`                    `NULL`
  `/usr/lib`             `/usr`                `lib`                  `/usr/lib`             `NULL`
  `/usr/`                `/`                   `usr`                  `/usr/`                `NULL`
  `usr`                  `.`                   `usr`                  `usr`                  `NULL`
  `file.xx`              `.`                   `file.xx`              `file`                 `xx`
  `/tmp.yy/file.xx`      `/tmp.yy`             `file.xx`              `/tmp.yy/file`         `xx`
  `/tmp.yy/file.xx.yy`   `/tmp.yy`             `file.xx.yy`           `/tmp.yy/file.xx`      `yy`
  `/tmp.yy/`             `/`                   `tmp.yy`               `/tmp.yy/`             `NULL`
  `/tmp.yy/.`            `/tmp.yy`             `.`                    `/tmp.yy/`             `NULL`
  ---------------------- --------------------- ---------------------- ---------------------- -----------------------

**Warning: The above examples use Unix file names. On Windows the result
would be different, as the file name separator is \'\\\'.**

------------------------------------------------------------------------

#### [Example 2]{#EXAMPLE_2}: Browsing directories.

This program takes a directory path as an argument and scans the content
recursively:

``` linenumber
01 IMPORT os
02 MAIN
03   CALL showDir(arg_val(1))
04 END MAIN
05 FUNCTION showDir(path)
06   DEFINE path STRING
07   DEFINE child STRING
08   DEFINE h INTEGER
09   IF NOT os.Path.exists(path) THEN
10      RETURN
11   END IF
12   IF NOT os.Path.isdirectory(path) THEN
13      DISPLAY " ", os.Path.basename(path)
14      RETURN
15   END IF
16   DISPLAY "[", path, "]"
17   CALL os.Path.dirsort("name", 1)
18   LET h = os.Path.diropen(path)
19   WHILE h > 0
20      LET child = os.Path.dirnext(h)
21      IF child IS NULL THEN EXIT WHILE END IF
22      IF child == "." OR child == ".." THEN CONTINUE WHILE END IF
23      CALL showDir( os.Path.join( path, child ) )
24   END WHILE
25   CALL os.Path.dirclose(h)
26 END FUNCTION
```
