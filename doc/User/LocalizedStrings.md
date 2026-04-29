[Back to Contents](../index.html)

------------------------------------------------------------------------

# Localized Strings

Summary:

- [What are Localized Strings?](#DEFINITION)
  - [Identifying localized strings in .4gl and .per
    sources](#DEF_4GL_PER)
  - [Identifying localized strings in XML files](#DEF_XML)
- [Syntax](#SYNTAX)
  - [Syntax 1](#SYNTAX1)
  - [Syntax 2](#SYNTAX2)
  - [Syntax 3](#SYNTAX3)
- [Internationalization steps](#STEPS)
- [Source String Files](#SOURCES)
- [Extracting Strings](#EXTRACTING)
- [Compiling String Files](#COMPILING)
- [Using String Files at Runtime](#RUNTIME)
- [Predefined Application Strings](#PREDSTRINGS)
- [Example](#EXAMPLE)

*See also:* [Localization](Localization.html),
[Programs](Programs.html), [FGLPROFILE](FglProfile.html)

------------------------------------------------------------------------

### [What are Localized Strings?]{#DEFINITION}

Localized Strings provide a means of writing applications in which the
text of strings can be customized on site. This feature can be used to
implement internationalization in your application, or to use
site-specific text (for example, when business terms change based on
territory).

This string localization feature does not define language
identification.  It is a simple way to define external resource files
which the runtime system can search, in order to assign text to strings
in the BDL application. The text is replaced at runtime in the p-code
modules (**42m**), in the compiled [form specification
files](FormSpecFiles.html) (**42f**), and in any XML resource files
loaded in the [Abstract User Interface tree](DynamicUI.html) (**4ad**,
**4st**, **4tb**, and so on).

#### [Identifying localized strings in **.4gl** and **.per** sources]{#DEF_4GL_PER}

By using a simple [notation](#SYNTAX), you can identify the Localized
Strings in the source code:

``` linenumber
01 MAIN
02   DISPLAY %"my text"
03 END MAIN
```

The [fglcomp](Tools.html#TL_FGLCOMP) and
[fglform](Tools.html#TL_FGLFORM) compilers have been extended to support
a new option to extract the Localized Strings. This allows the Localized
Strings to be extracted into [Source String Files](#SOURCES). From the
original **.str** Source String File, you can create other files
containing different text (for example, one file for each language you
want to support). Then, you must use the
[fglmkstr](Tools.html#TL_FGLMKSTR) tool to compile the source string
files into a binary version. By convention, compiled string resource
files must have the **42s** extension.

By default, the compiled string files are loaded at runtime, according
to the name of the program (**42r**). It is also possible to define
global string files in the [FGLPROFILE](FglProfile.html) configuration
file. *See also:* [Using String Files at Runtime](#RUNTIME).

#### [Identifying localized strings in XML files]{#DEF_XML}

In **42m** p-code modules, the Localized Strings are coded in a
proprietary binary format. But, for XML files such as [Action
Defaults](ActionDefaults.html) files (**4ad**), the localized strings
must be written with a specific node, following the XML standards. To
support localized strings in XML files, any file loaded into the
Abstract User Interface tree is parsed to search for `<LStr>` nodes. The
`<LStr>` nodes define the same attributes as in the parent node with
localized string identifiers, for example:

``` linenumber
01 <Label text="Hello!" >
02   <LStr text="label01" />
03 </Label>
```

The runtime system automatically replaces corresponding attributes in
the parent node (text=\"Hello!\"), with the localized text found in the
compiled string files, according to the string identifier (label01).
After interpretation, the `<LStr>` nodes are removed from the XML data.

**Warning: To take effect, a localized attribute in the LStr node must
have a corresponding attribute in the parent node.**

------------------------------------------------------------------------

### [Syntax]{#SYNTAX}

#### [Syntax 1: Static Localized String]{#SYNTAX1}

`  %"`*`sid`*`"`

#### [Syntax 2: Dynamic Localized String]{#SYNTAX2}

`  LSTR(`*`eid`*`)`

#### [Syntax 3: Localized String in XML files]{#SYNTAX3}

`  <`*`ParentNode`*` `*`attribute`*` = "`*`default-text`*`" `[`[`]{.underline}`...`[`]`]{.underline}` >`\
`     <LStr `*`attribute`*` = "`*`sid`*`" `[`[`]{.underline}`...`[`]`]{.underline}` />`\
`  </`*`ParentNode`*`>`

#### Notes:

1.  *sid* is a character [string literal](Literals.html#LT_STRING) that
    defines both the string identifier and the default text.
2.  *eid* is a character [string expression](Expressions.html#EX_STRING)
    used at runtime as string identifier to load the text.
3.  *attribute* is the attribute in the parent node that will get the
    localized string identified by *sid*.
4.  *default-test* is the default text of an attribute, if not localized
    string is found for *sid*.
5.  *ParentNode* is the node type of the parent where the localized
    strings must be applied.

#### Usage:

A Localized String can be used in the source code of program modules or
form specification files to identify a text string that must be
converted at runtime.

[Static Localized Strings]{.underline}

A Localized String begins with a percent sign (`%`),  followed by the
name of the string which will be used to identify the text to be loaded.
Since the name is a string, you can use any type of characters in the
name, but it is recommended that you use a naming convention. For
example, you can specify a path by using several identifiers separated
by a dot, without any special characters such as space or tab:

``` linenumber
01 MAIN
02   DISPLAY %"common.helloworld"
03 END MAIN
```

The string after the percent sign defines both the localized string
identifier and the default text to be used for extraction, or the
default text when no string resource files are provided at runtime.

You can use this notation in form specification files as well, at any
place where a string literal can be used.

``` linenumber
01 LAYOUT
02   VBOX
03     GROUP g1 (TEXT=%"group01")
04 ...
```

**Warning: It is not possible to specify a static localized string
directly in the area of containers like
[GRID](FormSpecFiles.html#FF_CONTAINER_GRID),
[TABLE](FormSpecFiles.html#FF_CONTAINER_TABLE) or
[SCROLLGRID](FormSpecFiles.html#FF_CONTAINER_SCROLLGRID). You must use
label fields to use localized strings in layout labels:**

``` linenumber
01 LAYOUT
02   GRID
03   {
04     [lab01  |f001              ]
05   {
06   END
07 END
08 ATTRIBUTES
09 LABEL lab01 : TEXT=%"myform.label01";
10 EDIT f001 = FORMONLY.field01;
11 END
```

[Dynamic Localized Strings]{.underline}

The language provides a special operator to load a Localized String
dynamically, using an expression as string identifier. The name of this
operator is `LSTR()`, and the syntax is described above.

The following code example builds a Localized String identifier with an
integer and loads the corresponding string with the ` LSTR()` operator:

``` linenumber
01 MAIN
02   DEFINE n INTEGER
03   LET n = 234
04   DISPLAY LSTR("str"||n)  -- loads string 'str234'
05 END MAIN
```

*See also:* The [SFMT() operator](Operators.html#OP_SFMT)

------------------------------------------------------------------------

### [Internationalization steps]{#STEPS}

In order to internationalize an existing application, follow the process
described below:

1.  Identify the current character set used in your sources and make
    sure the [locale](Localization.html) is set correctly.
2.  In .**4gl** sources, add a [% prefix](#SYNTAX) to the strings that
    must be localized / translated.
3.  In **.per** sources, replace hard-coded text with [static
    labels](FormSpecFiles.html#FF_ITEMTYPE_LABEL) and define
    [TEXT](FSFAttributes.html#FA_TEXT) attributes with a % prefix.
4.  [Extract](#EXTRACTING) the strings from the sources with **fglcomp
    -m** and **fglform -m**.
5.  Organize the generated **.str** files (identify duplicated strings
    and put them in a common file).\
    You can, for example, extract all strings of the application in a
    unique file, sort the lines, and use the *uniq* UNIX command.
6.  At this point, the string keys are the same as the string text.\
    These string keys could be used as is, but it\'s better to define a
    normalized name using ASCII characters only.\
    For example, replace:\
    `   "Customer List" = "Customer List"`\
    With:\
    `   "customer.list.title" = "Customer List"`
7.  In sources, replace the original string text with the new string
    keys. Strings to be replaced can be located by their % prefix.\
    You can, for example, use a script with an utility like the *sed*
    UNIX command to read the .**str** files and apply the changes
    automatically.
8.  Recompile the **.4gl** and **.per** sources (these should be ASCII
    now, so the locale should not matter).
9.  Compile the .**str** files in the locale used by these files, and
    check whether the application displays the text properly.
10. Copy the existing **.str** files, and translate the string text into
    another language (making sure the locale is correct).
11. Compile the new **.str** files, and copy the **.42s** files into
    another distribution directory, defined with the [environment
    variable](#RUNTIME) search path.\
    A set of **.42s** files using the same language and code-set is
    typically copied in a distribution directory with a name identifying
    the locale.\
    For example:\
    `   /opt/app/resource/strings/en_US.iso8859-1       -- English strings in iso8859-1 code-set`\
    `   /opt/app/resource/strings/fr_FR.iso8859-1       -- French strings in iso8859-1 code-set`\
    `   /opt/app/resource/strings/jp_JP.utf8            -- Japanese strings in utf-8 code-set`

Future edits to the .**per** and .**4gl** source files should be done in
the ASCII locale, and .**str** string files must be edited with their
specific locale.

------------------------------------------------------------------------

### [Source String Files]{#SOURCES}

By convention, the source files of Localized Strings have the **.str**
extension.

#### Defining a string:

You define a list of string identifiers, and the corresponding text, by
using the following syntax:

`"`*`identifier`*`" = "`*`string`*`"`

#### Special characters:

The [fglmkstr](Tools.html#TL_FGLMKSTR) compiler accepts the backslash
\"\\\" as the escape character, to define non-printable characters:

`\l   \n   \r   \t   \\`

#### Example:

``` linenumber
01 "id001" = "Some text"
02 "this.is.a.path.for.a.very.long.string.identifier" = "Customer List"
03 "special.characters.backslash" = "\\"
04 "special.characters.newline" = "\n"
```

------------------------------------------------------------------------

### [Extracting Strings]{#EXTRACTING}

In order to extract Localized String from [Source String
Files](#SOURCES), use the [fglcomp](Tools.html#TL_FGLCOMP) and
[fglform](Tools.html#TL_FGLFORM) compilers with the `-m` option:

`$ fglcomp -m mymodule.4gl`

The compilers dumps all localized string to stdout. This output can be
redirected to a file to generate the default [Source String
File](#SOURCES) with all the localized strings used in the 4gl file.

------------------------------------------------------------------------

### [Compiling String Files]{#COMPILING}

The [Source String Files](#SOURCES) (**.str**) must be compiled to
binary files (**.42s**) in order to be used at runtime.

To compile a Source String File, use the
[fglmkstr](Tools.html#TL_FGLMKSTR) compiler:

`$ fglmkstr `*`filename`*`.str`

This tool generates a **.42s** file with the *filename* prefix.

**Warning: When compiling a string file, you must set the
[locale](Localization.html) (character set) corresponding to the
encoding used in the .str file.**

------------------------------------------------------------------------

### [Using String Files at Runtime]{#RUNTIME}

#### Distributing string resource files

The \"`42s`\" [Compiled String Files](#COMPILING) must be distributed
with the program files in a directory specified in the
[DBPATH](EnvironmentVariables.html#EV_DBPATH)/[FGLRESOURCEPATH](EnvironmentVariables.html#EV_FGLRESOURCEPATH)
environment variable.

#### Setting the correct locale

The [locale](Localization.html) (character set) corresponding to the
encoding used in the **.42s** files must be set before starting the
application. If the locale is wrong, the strings will not be loaded
correctly.

#### How does the runtime system load the strings?

Searching for a string resource in the **.42s** files follows this order
of precedence:

1.  The files defined in [FGLPROFILE](FglProfile.html) (see below),
2.  A file having the same name prefix as the current \"`42r`\" program,
3.  A file with the name \"`default.42s`\".

For each string file, the runtime system searches in the following
directories:

1.  The current directory,
2.  The path list defined in the
    [DBPATH](EnvironmentVariables.html#EV_DBPATH)/[FGLRESOURCEPATH](EnvironmentVariables.html#EV_FGLRESOURCEPATH)
    environment variable,
3.  The `FGLDIR/lib` directory.

A string is loaded in memory only once (if the same string is defined in
another file, it is ignored).

#### What happens if a string is not defined in a resource file?

If a localized string is not defined in a resource files, the runtime
system uses the string identifier as default text. 

#### What happens if a string is defined more that once?

When a localized string is defined in several resource files, the
runtime system uses the first string found.

For example, if the string \"hello\" is defined in `program.42s` as
\"hello from program\", and in `default.42s` as \"hello from default\",
the runtime system will use the text \"hello from program\".

#### Defining a list of string resource files in FGLPROFILE

You can specify a list of Compiled String Files with entries in the
[FGLPROFILE](FglProfile.html) configuration file. The file name must be
specified without a file extension. The runtime system searches for a
file with the \"`42s`\" extension in the current directory and in the
path list defined in the
[DBPATH](EnvironmentVariables.html#EV_DBPATH)/[FGLRESOURCEPATH](EnvironmentVariables.html#EV_FGLRESOURCEPATH)
environment variable.

[List of resource files]{.underline}

To define the list of resource files to be used, specify the total
number of files with:

`fglrun.localization.file.count = `*`integer`*

And for each file, define the filename (without the **42s** extension),
including an index number, with:

`fglrun.localization.file.`*`index`*`.name = "`*`filename`*`"`

Start *index* at 1.

[Warning switches]{.underline}

If the text of a string is not found at runtime, the DVM can show a
warning, for development purposes.

`fglrun.localization.warnKeyNotFound = `*`boolean`*

By default, this warning switch is disabled.

#### Organizing .42s resource files in distribution directories

A set of **.42s** files using the same language and code-set is
typically copied in a distribution directory with a name identifying the
locale.

For example:

`   /opt/app/resource/strings/en_US.iso8859-1       -- English strings in iso8859-1 code-set`\
`   /opt/app/resource/strings/fr_FR.iso8859-1       -- French strings in iso8859-1 code-set`\
`   /opt/app/resource/strings/jp_JP.utf8            -- Japanese strings in utf-8 code-set`

At runtime, the list of string files is defined with
**fglrun.localization** entries in [FGLPROFILE](FglProfile.html), and
you specify the search path for the current locale with the
[DBPATH](EnvironmentVariables.html#EV_DBPATH)/[FGLRESOURCEPATH](EnvironmentVariables.html#EV_FGLRESOURCEPATH)
environment variable.

------------------------------------------------------------------------

### [Predefined Application Strings]{#PREDSTRINGS}

#### What is a Predefined Application String?

In some situations, the runtime system needs to display text to the
user. For example, the runtime system library includes a report viewer,
which displays a form. By default the text is in English, and you may
need to localize the text in another language. So the strings of this
component must be \'localizable\', as in other application strings. 

To customize the built-in strings, the runtime system uses the mechanism
of localized strings.

All strings used by the runtime system are centralized in a unique file:

`$FGLDIR/src/default.str`

which is compiled into:

`$FGLDIR/lib/default.42s`

This file is always loaded by the runtime system.

To overwrite the defaults, you can re-define these strings in your own
localized string files. *See also:* [Using String Files at
Runtime](#RUNTIME).

------------------------------------------------------------------------

### [Example]{#EXAMPLE}

The [Source String File](#SOURCES) \"common.str\" (a [compiled
version](#COMPILING) must be created):

``` linenumber
01 "common.accept" = "OK"
02 "common.cancel" = "Cancel"
03 "common.quit" = "Quit"
```

The [Source String File](#SOURCES) \"actions.str\" (a [compiled
version](#COMPILING) must be created):

``` linenumber
01 "action.append" = "Append"
02 "action.modify" = "Modify"
03 "action.delete" = "Delete"
```

The [Source String File](#SOURCES) \"customer.str\" (a [compiled
version](#COMPILING) must be created):

``` linenumber
01 "customer.mainwindow.title" = "Customers"
02 "customer.listwindow.title" = "Customer List"
03 "customer.l_custnum" = "Number:"
04 "customer.l_custname" = "Name:"
05 "customer.c_custname" = "The customer name"
06 "customer.g_data" = "Customer data"
07 "customer.g_actions" = "Actions"
08 "customer.qdelete" = "Are you sure you want to delete this customer?"
```

The [FGLPROFILE configuration file parameters](#COMPILING):

``` linenumber
01 fglrun.localization.file.count = 2
02 fglrun.localization.file.1.name = "common"
03 fglrun.localization.file.2.name = "actions"
```

Remark: The \'customer\' string file does not have to to listed in
FGLPROFILE since it is loaded as it has the same name as the program.

The form specification file \"f1.per\":

``` linenumber
01 LAYOUT (TEXT=%"customer.mainwindow.title")
02   GRID
03   {
04    <g g1                                    >
05     [lab1       ] [f01            ]
06     [lab2       ] [f02                     ]
07 
08    <g g2                                    >
09     [b1               ] [b2                ]
10 
11   }
12   END
13 END
14 ATTRIBUTES
15   LABEL  lab1 : TEXT=%"customer.l_custnum";
16   EDIT   f01  = FORMONLY.custnum;
17   LABEL  lab2 : TEXT=%"customer.l_custname";
18   EDIT   f02  = FORMONLY.custname, COMMENT=%"customer.c_custname";
19   BUTTON b1   : edit, TEXT=%"action.modify";
20   BUTTON b2   : quit, TEXT=%"common.quit";
21   GROUP  g1   : TEXT=%"customer.g_data";
22   GROUP  g2   : TEXT=%"customer.g_actions";
23 END
```

The program \"customer.4gl\" using the strings file:

``` linenumber
01 MAIN
02   DEFINE rec RECORD
03             custnum INTEGER,
04             custname CHAR(20)
05          END RECORD
06   OPEN WINDOW w1 WITH FORM "f1"
07   MENU
08     ON ACTION edit
09        INPUT BY NAME rec.*
10     ON ACTION quit
11        EXIT MENU
12   END MENU
13 END MAIN
```
