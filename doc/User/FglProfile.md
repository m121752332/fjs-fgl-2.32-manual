[Back to Contents](../index.html)

------------------------------------------------------------------------

# [The FGLPROFILE configuration file]{#PAGE_HEADER}

Summary:

- [Basics](#BASICS)
- [FGLPROFILE Entry Syntax](#ENTRYSYNTAX)
- [Supported Entries](#ENTRYLIST)

*See also:* [Programs](Programs.html)

------------------------------------------------------------------------

### [Basics]{#BASICS}

The runtime system uses one or more configuration files in which you can
define [entries](#ENTRYSYNTAX) to change the behavior of the programs.

There is no specific naming convention for the configuration files,
however, we recommend to use an extension such as **prf**.

There are three different levels to specify a configuration file, and
these files are loaded in the following order:

1.  First, the runtime system reads the configuration file provided in
    [FGLDIR](EnvironmentVariables.html#EV_FGLDIR)/etc/fglprofile. This
    file contains all supported entries, identifies the possible values
    for an entry, and documents default values. You should not modify
    this default configuration file, see warning below.
2.  Then, if the [FGLPROFILE](EnvironmentVariables.html#EV_FGLPROFILE)
    environment variable is set, the runtime system reads entries from
    the files specified by this environment variable. A list of files
    can be provided with FGLPROFILE. Files must be separated by the
    operating system specific path separator.
3.  After loading and merging the two previous levels, the runtime
    system checks if the **fglrun.defaults** entry is set. This entry
    defines the *program-specific profile directory*. If this directory
    contains a file with the same name as the current program (without
    .42x extension), the runtime system reads the entries from that
    file.

**Warning: It is not recommended to change the default configuration
file in FGLDIR/etc/fglprofile. This file will be overwritten by a new
installation and your changes will be lost. You better make a copy and
define your private configuration file with the
[FGLPROFILE](EnvironmentVariables.html#EV_FGLPROFILE) environment
variable.**

The runtime system merges the different configuration files found at the
three levels. If the same entry is defined in several files, the last
loaded entry wins. This means that the order of precedence is:

1.  Program specific configuration file (if **fglrun.defaults** is
    defined in one of the other levels).
2.  Configuration files defined by the FGLPROFILE environment variable.
3.  The default configuration file FGLDIR/etc/fglprofile.

------------------------------------------------------------------------

### [FGLPROFILE Entry Syntax]{#ENTRYSYNTAX}

#### Purpose:

An FGLPROFILE entry is a line in the configuration file associating a
parameter name to a value that can be specified as a numeric, string or
boolean.

#### Syntax:

*`entry`*` = `*`value`*

where *entry* is:

*`ident`*` `[`[`]{.underline}`.`*`ident`*` `[`[`]{.underline}`.`*`ident`*[`]`]{.underline}` `[`[...]`]{.underline}` `[`]`]{.underline}` `[`]`]{.underline}

and *value* is:

`  `[`[`]{.underline}`-`[`]{`]{.underline}` `*`digit`*` `[`[...]`]{.underline}` `[`}[`]{.underline}` . `*`digit`*` `[`[...]`]{.underline}` `[`]`\
`|`]{.underline}` " `*`alphanum`*` `[`[...]`]{.underline}` "`\
[`|`]{.underline}` `[`{`]{.underline}`true`[`|`]{.underline}`false`[`}`]{.underline}

#### Notes:

1.  *entry* identifies the name of the entry. This can be a
    dot-separated list of identifiers.
2.  *value* is the value of the entry; it might be a numeric value, a
    string literal, or a Boolean value (true/false).

#### Usage:

The entries are defined by a name composed of a list of identifiers
separated by a dot character. Entry names are converted to lower case
when loaded by the runtime system. In order to avoid any confusion, it
is recommended to write FGLPROFILE entry names in lower case. If an
entry is defined several times in the same file, the last entry found in
the file is used. No error is raised.

The value can be a numeric literal, a string literal, or a Boolean
(true/false).

Numeric values are composed by an optional sign, followed by digits,
followed by an optional decimal point and digits:

`my.numeric.entry = -1566.57`

String values must be delimited by single or double quotes. [The escape
character is backslash]{.underline}, \\t \\n \\r \\f are interpreted as
TAB, NL, CR, FF.

`my.string.entry = "C:\\data\\test1.dbf"`

Boolean values must be either the *true* or *false* keyword:

`my.boolean.entry = true`

For the complete list of supported entries, see [Supported
Entries](#ENTRYLIST).

#### Example:

``` linenumber
01 report.aggregatezero = true
02 gui.connection.timeout = 100
03 dbi.database.stores.source = "C:\\data\\test1.dbf"
04 dbi.database.stores.prefetch.rows = 200
```

------------------------------------------------------------------------

### [Supported Entries]{#ENTRYLIST}

The following table shows the a partial list of supported FGLPROFILE
entries. You can find the complete usage for an entry in the
corresponding documentation section referenced in the description of the
entry.

**Entry**

**Values**

**Default**

**Description**

`dbi.*`

N/A

N/A

Database interface configuration.\
See [Connections](Connections.html) for more details.

`gui.connection.timeout`

integer

30

Defines the timeout delay (in seconds) the runtime system waits when it
establishes a connection to the front-end. After this delay the program
stops with an error.\
See [Dynamic User Interface](DynamicUI.html#FECONN_TIMEOUT) for more
details.

`gui.key.add_function`

integer

none

If set, this entry defines the offset for function key mapping when
using Shift-Fx and Control-Fx key modifiers.\
See [Dynamic User Interface](DynamicUI.html#TRADITIONAL_MODE) for more
details.

`gui.protocol.pingTimeout`

integer

600

Defines the timeout delay (in seconds) the runtime system waits for a
front-end ping when there is no user activity. After this delay the
program stops with an error.\
See [Dynamic User Interface](DynamicUI.html#FECONN_LOST) for more
details.

`gui.protocol.format`

string

default

Controls Front-End protocol format.\
Possible values are: \"block\", \"zlib\".\
Default is \"block\" (encapsulation only).\
See [Front-End Protocol](FEProtocol.html#COMPRESSION) for more details.

`gui.server.autostart.*`

N/A

N/A

Defines automatic front-end startup parameters.\
See [Dynamic User Interface](DynamicUI.html#AUTOSTART) for more details.

`gui.uiMode`

string

NULL

Defines the user interface mode, to render windows in traditional 4GL
mode.\
Possible values are: \"default\" or \"traditional\". Default is the new
Genero GUI mode with real resizable windows.\
See [Dynamic User Interface](DynamicUI.html#TRADITIONAL_MODE) for more
details.

`fglrun.arrayIgnoreRangeError`

boolean

false

Controls runtime behavior when array index is out of bounds.\
See [Arrays](Arrays.html#arrayIgnoreRangeError) for more details.

`fglrun.mapAnyErrorToError`

boolean

false

Controls default action of WHENEVER ANY ERROR.\
See [Exceptions](Exceptions.html#mapAnyErrorToError) for more details.

`fglrun.default`

string

NULL

Defines the directory where program specific configuration files are
located.\
See [Basics](#BASICS) for more details.

`fglrun.ignoreLogoffEvent`

boolean

false

Defines whether the DVM ignores a CTRL_LOGOFF_EVENT on Windows
platforms.\
See [Programs](Programs.html#CTRL_LOGOFF_EVENT) for more details.

`fglrun.ignoreDebuggerEvent`

boolean

false

Defines whether the DVM ignores a SIGTRAP (Unix) or CTRL-Break (Windows)
to switch into debug mode.\
See [Debugger](Debugger.html#SIGTRAP) for more details.

`fglrun.localization.*`

N/A

N/A

Defines load parameters for localized string resource files.\
See [Localized Strings](LocalizedStrings.html#RUNTIME) for more details.

`fglrun.mmapDisable`

boolean

false

Memory mapping control. When set to true, memory mapping is disabled and
standard memory allocation method takes place. For more details about
memory mapping, run \"man mmap\" on UNIX.\
See [Basics](#BASICS) for more details.

`flm.*`

N/A

N/A

License management related entries.

`Dialog.currentRowVisibleAfterSort`

boolean

false

Forces current row to be shown after a sort in a table.\
See [Runtime Configuration](Programs.html#RUNTIMECONFIG) for more
details.

`Dialog.fieldOrder`

boolean

false

Defines if the intermediate field triggers must be executed when a new
field gets the focus with a mouse click.\
See [Runtime Configuration](Programs.html#RUNTIMECONFIG) for more
details.

`key.`*`key-name`*`.text`

string

N/A

Defines a label for an action defined with an ON KEY clause.\
*Provided for V3 compatibility only.*\
See [Settings Key labels](DynamicUI.html#SETTING_KEY_LABELS) for more
details.

`Report.aggregateZero`

boolean

false

Defines if the report aggregate functions must return zero or NULL when
all values are NULL.\
*Provided for V3 compatibility only.*\
See [Report Configuration](Reports.html#RPT_CONFIG) for more details.
