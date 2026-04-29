[Back to Contents](../index.html)

------------------------------------------------------------------------

# [The Channel class]{#PAGE_HEADER}

Summary:

- [Syntax](#SYNTAX)
- [Methods](#METHODS)
- [Usage](#USAGE)
  - [Creating a Channel object](#create-channel)
  - [Setting the value delimiter](#setDelimiter)
  - [Opening a Channel](#OPEN_CHANNEL)
    - [Opening a file Channel](#open-file)
    - [Opening a pipe Channel](#open-pipe)
    - [Opening a client socket Channel](#open-client-socket)
  - [Closing a Channel](#close)
  - [Exception handling](#EXCEPTIONS)
  - [Detecting end of file](#isEof)
  - [Reading and writing complete lines](#read-write-lines)
  - [Reading and writing formatted data](#read-write-channel)
  - [Managing line terminators with read() / write()](#LINETERM_RW)
  - [Managing line terminators with readLine() /
    writeLine()](#LINETERM_RWLINE)
  - [Line terminators on Windows platforms](#LINETERM_WINDOWS)
- [Examples](#EXAMPLES)
  - [Example 1: Reading formatted data from a file](#example-1)
  - [Example 2: Executing the ls UNIX command](#example-2)
  - [Example 3: Reading lines from a file](#example-3)
  - [Example 4: Communicating with an HTTP server](#example-4)

See also: [Built-in classes](BuiltInClasses.html)

------------------------------------------------------------------------

### [Syntax]{#SYNTAX}

The **Channel** class provides basic read/write functionality for access
to files or communication with sub-processes.

#### Syntax:

`base.Channel`

------------------------------------------------------------------------

### [Methods:]{#METHODS}

+-------------------------------------------------------------------------------------------------------------------------+----------------------------------+
| **Class Methods**                                                                                                                                          |
+-------------------------------------------------------------------------------------------------------------------------+----------------------------------+
| **Name**                                                                                                                | **Description**                  |
+-------------------------------------------------------------------------------------------------------------------------+----------------------------------+
| [`create`](#create-channel)`()`` RETURNING`` base.Channel`                                                              | Creates a new Channel object.    |
+-------------------------------------------------------------------------------------------------------------------------+----------------------------------+
| **Object Methods**                                                                                                                                         |
+-------------------------------------------------------------------------------------------------------------------------+----------------------------------+
| **Name**                                                                                                                | **Description**                  |
+-------------------------------------------------------------------------------------------------------------------------+----------------------------------+
| [`isEof`](#isEof)`() ``RETURNING INTEGER`                                                                               | Returns TRUE if end of file is   |
|                                                                                                                         | reached.                         |
+-------------------------------------------------------------------------------------------------------------------------+----------------------------------+
| [`openFile`](#open-file)`( path ``STRING``, flags ``STRING`` )`                                                         | Opens a [Channel to a            |
|                                                                                                                         | file]{#openFile} identified by   |
|                                                                                                                         | *path*, with options.            |
+-------------------------------------------------------------------------------------------------------------------------+----------------------------------+
| [`openPipe`](#open-pipe)`( scmd ``STRING``, flags ``STRING`` )`                                                         | Opens a [Channel to a            |
|                                                                                                                         | process]{#openPipe} by executing |
|                                                                                                                         | the command *scmd*, with         |
|                                                                                                                         | options.                         |
+-------------------------------------------------------------------------------------------------------------------------+----------------------------------+
| [`openClientSocket`](#open-client-socket)`( host ``STRING``, port ``INTEGER``, flags ``STRING``, timeout ``INTEGER`` )` | Opens a [Channel to a            |
|                                                                                                                         | socke]{#openClientSocket}t       |
|                                                                                                                         | server identified by *host* and  |
|                                                                                                                         | *port*, with options.            |
+-------------------------------------------------------------------------------------------------------------------------+----------------------------------+
| [`setDelimiter`](#setDelimiter)`( d ``STRING`` )`                                                                       | Sets the field delimiter of the  |
|                                                                                                                         | Channel.                         |
+-------------------------------------------------------------------------------------------------------------------------+----------------------------------+
| [`read`](#read-write-channel)`( `*`buffer-list`*` ) ``RETURNING INTEGER`                                                | [Reads]{#read} data from the     |
|                                                                                                                         | input.                           |
+-------------------------------------------------------------------------------------------------------------------------+----------------------------------+
| [`write`](#read-write-channel)`( `*`buffer-list`*` )`                                                                   | [Writes]{#write} data to the     |
|                                                                                                                         | output.                          |
+-------------------------------------------------------------------------------------------------------------------------+----------------------------------+
| [`readLine`](#read-write-lines)`() ``RETURNING STRING`                                                                  | [Reads a complete                |
|                                                                                                                         | line]{#readLine} of data from    |
|                                                                                                                         | the Channel and returns the      |
|                                                                                                                         | string.                          |
+-------------------------------------------------------------------------------------------------------------------------+----------------------------------+
| [`writeLine`](#read-write-lines)`( `*`buffer`*` ``STRING`` )`                                                           | [Writes a complete               |
|                                                                                                                         | line]{#writeLine} of data to the |
|                                                                                                                         | Channel.                         |
+-------------------------------------------------------------------------------------------------------------------------+----------------------------------+
| [`close`](#close)`()`                                                                                                   | Closes the Channel.              |
+-------------------------------------------------------------------------------------------------------------------------+----------------------------------+

------------------------------------------------------------------------

### [Usage:]{#USAGE}

The Channel class is a [built-in class](BuiltInClasses.html) that
provides basic read/write functionality for accessing files or
communicating with sub-processes.

**Warning: As with other BDL instructions, when you are reading or
writing strings the escape character is the backslash \"\\\".**

**Warning: No character set conversion is done when reading or writing
data with channel objects: The code-set used in the data file must
correspond to the [locale](Localization.html) of the runtime system, for
both input and output.**

------------------------------------------------------------------------

#### [Creating a Channel object]{#create-channel}

First you must declare a `base.Channel` variable; then, create a Channel
object and optionally set the field delimiter:

``` linenumber
01 DEFINE ch base.Channel
02 LET ch = base.Channel.create()
```

------------------------------------------------------------------------

#### [Setting the value delimiter]{#setDelimiter}

After creating the Channel object, you typically set the field value
delimiter with:

``` linenumber
01 CALL ch.setDelimiter("^")
```

The default is [DBDELIMITER](EnvironmentVariables.html#EV_DBDELIMITER),
or ` "|"` if DBDELIMITER is not defined. If you pass
[NULL](Programs.html#PC_NULL), no delimiter is used.

**Warning: If the delimiter is set to NULL, the read() and write()
methods do not use the backslash \\ escape character. See
[read()/write()](#read-write-channel) methods for more details.**

You can specify \"CSV\" as the delimiter to read/write in Comma
Separated Value format. This format is similar to the standard Channel
format described in this page, with the following differences:

- Values in the file might be surrounded with \" double quotes.
- If a value contains a comma or a NEWLINE, it is not escaped; the value
  must be quoted in the file.
- Double-quote characters in values are doubled in the output file and
  the output value must be quoted.
- Backslash characters are not escaped and are read as is; the value
  must be quoted.
- Leading and trailing blanks are kept (no truncation).
- No ending delimiter is expected at the end of the record line.

Example:

``` linenumber
01 CALL ch.setDelimiter("CSV")
```

------------------------------------------------------------------------

#### [Opening a Channel]{#OPEN_CHANNEL}

##### [Opening a file Channel]{#open-file}

You can open a file for reading, writing, or both, by using the
`openFile()` method:

``` linenumber
01 CALL ch.openFile( "file.txt", "w" )
```

The parameters for this method are:

1.  The path to the file
2.  The opening flags

The opening *flags* can be one of:

- `r` : For Read mode: reads from a file (standard input if *path* is
  NULL).
- `w` : For Write mode: starts with an empty file (standard output if
  the *path* is NULL). 
- `a` : For Append mode: writes at the end of a file (standard output if
  the *path* is NULL).
- `u` : For Read from standard input and Write to standard output
  (*path* must be NULL).

Any of the above options can be followed by:

- `b` : Open in binary mode, to avoid CR/LF  (carriage return/line feed)
  translation.

When you use the `"w"` or `"a"` modes, the file is created if it does
not exist.

##### [Opening a pipe Channel]{#open-pipe}

With the `openPipe()` method, you can read from the standard output of a
sub-process, write to the standard input, or both.

``` linenumber
01 CALL ch.openPipe( "ls", "r" )
```

The parameters for this method are:

1.  The command to be executed
2.  The opening flags

The opening *flags* can be one of:

- `r` : For Read Only from standard output of the command
- `w` : For Write Only to standard input of the command
- `a` : For Write Only to standard input of the command
- `u` : For Read from standard output and Write to standard input of the
  command

##### [Opening a client socket Channel]{#open-client-socket}

Use the `openClientSocket()` method to establish a TCP connection to a
server.

**Warning: The network protocol must be based on ASCII, or must use the
same character set as the application.**

Example:

``` linenumber
01 CALL ch.openClientSocket( "localhost", 80, "ub", 5 )
```

The parameters for this method are:

1.  The name of the host machine you want to connect to
2.  The port number of the service
3.  The opening flags
4.  The timeout in seconds. -1 indicates no timeout (wait forever)

The *timeout* is specified in seconds, -1 waits forever.

The opening *flags* can be one of:

- `r` : For Read mode: only to read from the socket
- `w` : For Write mode: only to write to the socket
- `u` : For Read and Write mode: To read and write from/to the socket

Any of the above options can be followed by:

- `b` : Open in binary mode, to avoid CR/LF (carriage return / line
  feed) translation.

------------------------------------------------------------------------

#### [Closing a Channel]{#close}

When you have finished with the Channel, close it with the `close()`
method:

``` linenumber
01 CALL ch.close()
```

A Channel is automatically closed when the last reference to the Channel
object is deleted.

------------------------------------------------------------------------

#### [Exception handling]{#EXCEPTIONS}

You can trap [exceptions](Exceptions.html) with the standard
`WHENEVER ERROR` exception handler:

``` linenumber
01 WHENEVER ERROR CONTINUE
02 CALL ch.write([num,label])
03 IF STATUS THEN
04    ERROR "An error occurred while reading from Channel"
05    CALL ch.close()
06    RETURN -1
07 END IF
08 WHENEVER ERROR STOP
```

------------------------------------------------------------------------

#### [Detecting end of file]{#isEof}

To detect the end of a file while reading from a Channel, you can use
the `isEof()` method:

``` linenumber
01 DEFINE s STRING
02 WHILE TRUE
03    LET s = ch.readLine()
04    IF ch.isEof() THEN EXIT WHILE END IF
05    DISPLAY s
06 END WHILE
```

**Warning: The End Of File can only be detected after the last read
(first read, then check EOF and process if not EOF).**

------------------------------------------------------------------------

#### [Reading and writing complete lines]{#read-write-lines}

When the Channel is open, you can use the `readLine()` and `writeLine()`
method to read/write a complete line from/to the Channel, by ignoring
the delimiter defined by `setDelimiter()`:

``` linenumber
01 DEFINE buff STRING
02 CALL ch.writeLine("this is a complete line")
03 LET buff = ch.readLine()
```

The `readLine()` method must be used if the source stream does not
contain lines with field separators.

The `readLine()` method returns an empty string if the line is empty.

**Warning: The readLine() function returns NULL if end of file is
reached. To distinguish empty lines from NULL, you must use the STRING
data type. If you use a CHAR or VARCHAR, you will get NULL for empty
lines. To properly detect end of file, you can use the isEof()
method. **

------------------------------------------------------------------------

#### [Reading and writing formatted data]{#read-write-channel}

When the Channel is open, you can use the the `read()/write()` methods
to read/write data records where field values are separated by a
delimiter. If you want to read simple lines, use the
[readLine()/writeLine()](#read-write-lines) methods instead.

You must provide a variable list by using the square brace notation
(`[param1,param2,...]`):

``` linenumber
01 DEFINE a,b INTEGER
02 DEFINE c,d CHAR(20)
03 ...
04 WHILE ch1.read([a,b,c,d])
05   CALL ch2.write([a,b,c,d])
06 END WHILE
```

You can also pass all members of a [record variable](Variables.html)
with the dot-star notation:

``` linenumber
01 DEFINE rec RECORD
02        a,b INTEGER,
03        c,d CHAR(20)
04      END RECORD
05 ...
06 WHILE ch1.read([rec.*])
07   CALL ch2.write([rec.*])
08 END WHILE
```

The ` read()` function returns [TRUE](Programs.html#PC_TRUE) if data
could be read. Otherwise, it returns [FALSE](Programs.html#PC_FALSE),
which indicates the end of the file or stream.

The input or output stream is text data where each line contains the
string representation of a record. Field values are separated by the
delimiter character defined with the [setDelimiter()](#setDelimiter)
method.

For example, a formatted text file corresponding to the above code would
look like this, when using a default pipe `|` delimiter:

    1|22|aaaaa|bbbbbbbb|
    1234|456|xxxaa|bbbzzz|
    12|4111|xxxaa|bbbzzz|
    333||xxxaa||

Note that empty fields have a length of zero (`||`) and will be read as
[NULL](Programs.html#PC_NULL).

If and only if a delimiter is used, the backslash `\` becomes the
implicit escape character: When writing data with `write()`, special
characters like the backslash, line-feed or the delimiter character will
be escaped. When reading data with `read()`, any escaped `\`*`char`*
character will be converted to *`char`*.

For example, the next code writes a single field value where the
character string contains a backslash, the pipe delimiter and a
line-feed character. Note that the backslash is also the escape
character for string literals in Genero BDL, therefore we need to double
the backslash to get a backslash in the string, while the line-feed
character (`<lf>)` is represented by backslash-n (`\n`) in BDL string
literals:

``` linenumber
01 CALL ch.setDelimiter("|")
02 CALL ch.write("aaa\\bbb|ccc\nddd")   -- [aaa<bs>bbb|ccc<lf>ddd]
```

The above code will produce the following text file:

    aaa\\bbb\|ccc\
    ddd|

When reading such a line back into memory with the `read()` method, all
escaped characters will be converted back to the single character. In
this example, `\\` becomes `\`, `\|` becomes `|` and `\<lf>` becomes
`<lf>`.

**Warning: If the delimiter is set to NULL, the read() and write()
methods do not use the backslash \\ escape character. As a result, data
with special characters like backslash, delimiter or line-feed will be
written as is, and reading data will ignore escaped characters in the
source stream. If you need to read or write non-formatted data, you
should use the [readLine()/writeLine()](#read-write-lines) methods
instead: These methods do not use a delimiter, nor do they use the
backslash escape character.**

Note that the
[LOAD](InOutSql.html#IO_LOAD)/[UNLOAD](InOutSql.html#IO_UNLOAD) SQL
instructions follow the same formatting rules as the `read()/write()`
channel methods, except that you can not define an NULL delimiter,
because an empty [DBDELIMITER](EnvironmentVariables.html#EV_DBDELIMITER)
environment variable defaults to the `|` pipe.

------------------------------------------------------------------------

#### [Managing line terminators with read() and write()]{#LINETERM_RW}

When using the `read()`/`write()` functions, the escaped line-feed (LF,
\\n) characters are written as BS + LF to the output. When reading data,
BS + LF are detected and interpreted, to be restituted as if the value
was assigned by a [LET](Variables.html#VA_LET) instruction, with the
same string used in the `write()` function.

If you want to write a LF as part of a value, the string must contain
the backslash and line-feed as two independent characters. You need to
escape the backslash when you write the string constant in the BDL
source file.

In the following code example, an empty delimiter is used to simplify
explanation:

``` linenumber
01 CALL ch.setDelimiter("")
02 CALL ch.write("aaa\\\nbbb")  -- [aaa<bs><lf>bbb]
03 CALL ch.write("ccc\nddd")    -- [aaa<lf>bbb]
```

\... would generate the following output:

``` linenumber
01 aaa\
02 bbb
03 ccc
04 ddd
```

where line `01`{.linenumber} and `02`{.linenumber} contain data for the
same line, in the meaning of a Channel record.

When you read these lines back with a `read()` call, you get the
following strings in memory:

``` linenumber
Read 1 aaa<bs><lf>bbb
Read 2 ccc
Read 3 ddd
```

These reads would correspond to the following assignments when using
string constants:

``` linenumber
01 LET s = "aaa\\\nbbb"
02 LET s = "ccc"
03 LET s = "ddd"
```

------------------------------------------------------------------------

#### [Managing line terminators with readLine() and writeLine()]{#LINETERM_RWLINE}

When using the `readLine()` and `writeLine()` functions, a LF character
represents the end of a line.

**Warning: LF characters escaped by a backslash [are not]{.underline}
interpreted as part of the line during a readLine() call.**

When a line is written, any LF characters in the string will be written
as is to the output. When a line is read, the LF escaped by a backslash
[is not]{.underline} interpreted as part of the line.

For example, the following code:

``` linenumber
01 CALL ch.writeLine("aaa\\\nbbb")  -- [aaa<bs><lf>bbb]
02 CALL ch.writeLine("ccc\nddd")    -- [aaa<lf>bbb]
```

\... would generate the following output:

``` linenumber
01 aaa\
02 bbb
03 ccc
04 ddd
```

\... and the subsequent `readLine()` will read four different lines,
where the first line would be ended by a backslash:

``` linenumber
Read 1 aaa<bs>
Read 2 bbb
Read 3 ccc
Read 4 ddd
```

------------------------------------------------------------------------

#### [Line terminators on Windows platforms]{#LINETERM_WINDOWS}

On Windows platforms, DOS formatted text files use CR/LF as line
terminators. You can manage this type of files with the Channel class.

By default, [on both Windows and Unix platforms]{.underline}, when
records are read from a DOS file with the Channel class, the CR/LF line
terminator is removed. When a record is written to a file on Windows,
the lines are terminated with CR/LF in the file; on UNIX, the lines are
terminated with LF only.

If you want to avoid the automatic translation of CR/LF [on
Windows]{.underline}, you can use the `b` option of the `openFil``e()`
and `openPipe()` methods. You typically combine the `b` option with `r`
or `w`, based on  the read or write operations that you want to do:

``` linenumber
01 CALL ch.openFile( "mytext.txt", "rb" )
```

[On Windows]{.underline}, when lines are read  with the `b` option, only
LF is removed from CR/LF line terminators; CR will be copied as a
character part of the last field. In contrast, when lines are written
with the `b` option, LF characters will not be converted to CR/LF.

[On UNIX]{.underline}, writing lines with or without the binary mode
option does not matter.

------------------------------------------------------------------------

### [Examples]{#EXAMPLES}

#### [Example 1:]{#example-1} Reading formatted data from a file

This program reads data from the \"file.txt\"  file that contains two
columns separated by a \| (pipe) character, and re-writes this data at
the end of the \"fileout.txt\" file, separated by \"%\"

``` linenumber
01 MAIN
02     DEFINE buff1, buff2 STRING
03     DEFINE ch_in, ch_out base.Channel
04     LET ch_in = base.Channel.create()
05     CALL ch_in.setDelimiter("|")
06     LET ch_out = base.Channel.create()
07     CALL ch_out.setDelimiter("%")
08     CALL ch_in.openFile("file.txt","r")
09     CALL ch_out.openFile("fileout.txt","w")
10     WHILE ch_in.read([buff1,buff2])
11         CALL ch_out.write([buff1,buff2])
12     END WHILE
13     CALL ch_in.close()
14     CALL ch_out.close()
15 END MAIN
```

#### [Example 2:]{#example-2} Executing the ls UNIX command

This program executes the \"ls\" command and displays the filenames and
extensions separately:

``` linenumber
01 MAIN
02     DEFINE fn CHAR(40)
03     DEFINE ex CHAR(10)
04     DEFINE ch base.Channel
05     LET ch = base.Channel.create()
06     CALL ch.setDelimiter(".")
07     CALL ch.openPipe("ls -l","r")
08     WHILE ch.read([fn,ex])
09         DISPLAY fn, "   ", ex
10     END WHILE
11     CALL ch.close()
12 END MAIN
```

#### [Example 3:]{#example-3} Reading lines from a file:

``` linenumber
01 MAIN
02     DEFINE i INTEGER
03     DEFINE s STRING
04     DEFINE ch base.Channel
05     LET ch = base.Channel.create()
06     CALL ch.openFile("file.txt","r")
07     LET i = 1
08     WHILE TRUE
09         LET s = ch.readLine()
10         IF ch.isEof() THEN EXIT WHILE END IF
11         DISPLAY i, " ", s
12         LET i = i + 1
13     END WHILE
14     CALL ch.close()
15 END MAIN
```

#### [Example 4:]{#example-4} Communicating with an HTTP server:

``` linenumber
01 MAIN
02     DEFINE ch base.Channel, eof INTEGER
03     LET ch = base.Channel.create()
04     -- We open the Channel in binary mode to control CR+LF
05     CALL ch.openClientSocket("localhost",80,"ub", 30)
06     -- HTTP expects CR+LF: Note that LF is added by writeLine()!
07     CALL ch.writeLine("GET / HTTP/1.0\r")
08     -- No HTTP headers...
09     -- Empty line = end of headers
10     CALL ch.writeLine("\r")
11     WHILE NOT eof
12         DISPLAY ch.readLine()
13         LET eof = ch.isEof()
14     END WHILE
15     CALL ch.close()
16 END MAIN
```
