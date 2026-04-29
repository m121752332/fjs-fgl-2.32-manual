[Back to Contents](../index.html)

------------------------------------------------------------------------

# [Front End Functions]{#PAGE_HEADER}

Summary:

- [Basics](#DEFINITION)
- [The frontCall method](#FRONTCALL)
- [Standard built-in front end functions](#STANDARD)

See also: [Interface built-in class](ClassInterface.html)

------------------------------------------------------------------------

### [Basics]{#DEFINITION}

The BDL language provides a [specific method](#FRONTCALL) to call
functions defined in the front end that will be executed locally on the
workstation where the front end resides. When you call a user function
from BDL, you specify a module name and a function name. Input and
output parameters can be passed/returned in order to transmit/receive
values to/from the front end. A typical example is an \"open file\"
dialog window that allows you to select a file from the front end
workstation file system.

A set of [standard front end functions](#STANDARD) is built-in by
default in the front end. It is possible to write your own functions in
order to extend the front end possibilities. For example, you can write
a set of functions to wrap an existing API, such as Window DDE or OLE. A
set of user functions is defined in a module, implemented as a Windows
DLL or UNIX shared library. These modules are loaded automatically
according to the module name. See the front end documentation for more
details about creating user function modules in the front end.

Tip: Regarding DDE/OLE APIs to manipulate Microsoft Office documents,
note that there are freeware alternatives such as the Apache POI Java
library which can be used with the Java Interface. See for example [Java
Interface: Example 2](JavaBridge.html#EXAMPLE_2).

------------------------------------------------------------------------

### [The frontCall method]{#FRONTCALL}

#### Purpose:

The [Interface built-in class](ClassInterface.html) provides a special
method to perform front end calls.

#### Syntax:

`ui.Interface.frontCall( `*`module`*`, `*`function`*`, `*`parameter-list`*`, `*`returning-list`*` )`

#### Notes:

1.  *module* defines the shared library where the function is defined. 
2.  *function* defines the name of the function to be called.
3.  *parameter-list* is a list of input parameters.
4.  *returning-list* is a list of output parameters.

#### Usage:

The `ui.Interface.frontCall()` class method can be used to execute a
procedure on the front-end workstation through the front-end software
component. You can for example launch a front-end specific application
like a browser or a text editor, or manage the clipboard content. 

The method takes four parameters:

1.  The module name, identifying the shared library (.so or .DLL) to be
    used.
2.  The function of the module the be executed.
3.  The list of input parameters, using the square brace notation.
4.  The list of output parameters, using the square brace notation.

**Warning: The error -6334 can be raised in case of input or output
parameter mismatch. The control of the number of input and output
parameters is in the hands of the front-end. Most of the standard
front-end calls described in this page have optional returning
parameters and will not raise error -6334 if the output parameter list
is left empty . However, front-end specific extensions or user-defined
front-end functions may return an invalid execution status in case of
input or output parameter mismatch, raising error -6334. Note that if
the front-end sends an call execution status of zero (OK), and the
number of returned values does not match the number of program
variables, the runtime system will set unmatched program variables to
NULL. As a general rule, the program should provide the expected input
and output parameters as specified in the documentation.**

When you specify \"*standard*\" as module name, it references built-in
functions implemented by default by the front end component. Other
module names identify .so or .DLL libraries which must be installed in
the front-end installation directory (see front-end documentation for
more details). If needed, you can customize front-end calls by writing
your own modules.

**Warning: Module and function names are case-sensitive.**

Input and output parameters are provided as a variable list of
parameters, by using the square braces notation (`[param1,param2,...]`).
Input parameters can be an [expression](Expressions.html) supported by
the language, while all output parameters must be variables only, to
receive the returning values. An empty list is specified with `[]`.
Output parameters are optional: If the front-end call returns values,
they will be ignored by the runtime system.

**Warning: Some front calls like *shellexec* need a file path as
parameter. File paths must follow the syntax of the front-end
workstation file system. You may need to escape backslash characters in
such parameters. The next example shows how to pass a file path with a
space in a directory name to a front-end running on a Microsoft Windows
workstation:**

``` linenumber
01 MAIN
02   DEFINE path STRING, res INTEGER
03   LET path = "\"c:\\work dir\\my report.doc\""
04   -- This is: "c:\work dir\my report.doc"
05   CALL ui.Interface.frontCall( "standard", "shellexec", [path], [res] )
06 END MAIN
```

#### Errors:

If the function could not be executed properly, one of the following
[exceptions](Exceptions.html) might occur:

  ------------------ ----------------------------------------------------------------------------------------
  **Error number**   **Description**
  **-6331**          The module specified could not be found.
  **-6332**          The function specified could not be found.
  **-6333**          The function call failed (fatal error in function).
  **-6334**          A function call stack problem occurred (usually, wrong number of parameters provided).
  ------------------ ----------------------------------------------------------------------------------------

#### Example:

``` linenumber
01 MAIN
02   DEFINE data STRING
03   CALL ui.Interface.frontCall( "mymodule", "connect", ["client1",128], [] )
04   LET data = "Hello!"
05   CALL ui.Interface.frontCall( "mymodule", "send", [data, data.getLength()], [] )
06   CALL ui.Interface.frontCall( "mymodule", "receive", [], [data] )
07   DISPLAY data
08   CALL ui.Interface.frontCall( "mymodule", "disconnect", ["client1"], [] )
09 END MAIN
```

------------------------------------------------------------------------

### [Standard built-in front end functions]{#STANDARD}

The following table shows the built-in functions implemented by the
front ends in the \"standard\" module.

**Warning: Additional modules and functions are available for
front-ends, but are specific to the front-end type. Please refer to the
front-end documentation for more details.**

+------------------------------------------------------+-----------------------+---------------------------------------------------------------------------+
| **Function Name**                                    | **Front-ends**        | **Description**                                                           |
+------------------------------------------------------+-----------------------+---------------------------------------------------------------------------+
| [execute]{#standard.execute}                         | GDC                   | Executes a command on the workstation with or without waiting.\           |
|                                                      |                       | Parameters:\                                                              |
|                                                      |                       | - The command to be executed.\                                            |
|                                                      |                       | - The wait option (1=wait, 0=do not wait).\                               |
|                                                      |                       | Returns:\                                                                 |
|                                                      |                       | - The execution result (TRUE=success, FALSE=error).                       |
+------------------------------------------------------+-----------------------+---------------------------------------------------------------------------+
| [feinfo]{#standard.feinfo}                           | GDC, GWC              | Returns front end properties like the front end type, the workstation     |
|                                                      |                       | operating system type.\                                                   |
|                                                      |                       | Parameters:\                                                              |
|                                                      |                       | - The name of the property.\                                              |
|                                                      |                       | Returns:\                                                                 |
|                                                      |                       | - The value of the property.                                              |
|                                                      |                       |                                                                           |
|                                                      |                       |   ----------------------------------- ----------------------------------- |
|                                                      |                       |   **Property name**                   ** Description**                    |
|                                                      |                       |                                                                           |
|                                                      |                       |   fename                              The name of the front end.          |
|                                                      |                       |                                                                           |
|                                                      |                       |   fepath                              The installation directory of the   |
|                                                      |                       |                                       front-end executable.               |
|                                                      |                       |                                                                           |
|                                                      |                       |   ostype                              The operating system type (WINDOWS, |
|                                                      |                       |                                       OSX, HPUX, AIX, SOLARIS, LINUX).    |
|                                                      |                       |                                                                           |
|                                                      |                       |   osversion                           The version of the operating        |
|                                                      |                       |                                       system.                             |
|                                                      |                       |                                                                           |
|                                                      |                       |   numscreens                          Number of screens available.        |
|                                                      |                       |                                                                           |
|                                                      |                       |   screenresolution                    Returns the screen resolution (with |
|                                                      |                       |                                       optional screen number parameter).  |
|                                                      |                       |                                                                           |
|                                                      |                       |   outputmap                           Returns the GWC application         |
|                                                      |                       |                                       OutputMap of the current            |
|                                                      |                       |                                       application.\                       |
|                                                      |                       |                                       **Warning!: GWC Only, use GAS       |
|                                                      |                       |                                       Version \>= 2.22.00**               |
|                                                      |                       |   ----------------------------------- ----------------------------------- |
+------------------------------------------------------+-----------------------+---------------------------------------------------------------------------+
| [shellexec]{#standard.shellexec}                     | GDC                   | Opens a file on the workstation with the program associated to the file   |
|                                                      |                       | extension.\                                                               |
|                                                      |                       | Parameters:\                                                              |
|                                                      |                       | - The document file to be opened.\                                        |
|                                                      |                       | Windows Only!: - the action to perform, related to the way the file type  |
|                                                      |                       | is registered in Windows Registry (Optionnal).\                           |
|                                                      |                       | Returns:\                                                                 |
|                                                      |                       | - The execution result (TRUE=success, FALSE=error)\                       |
|                                                      |                       | **Warning: Under X11 Systems, this uses xdg-open, which needs to be       |
|                                                      |                       | installed and configured on your system. Kfmclient will be used as a      |
|                                                      |                       | workaround when xdg-open is not available.\                               |
|                                                      |                       | Tip: In order to view a document (like a PDF for example), if that        |
|                                                      |                       | document can be displayed by web browsers, we recommend you to use the    |
|                                                      |                       | *lauchurl* function instead. Especially if you want to use the both GDC   |
|                                                      |                       | and the GWC front-ends.**                                                 |
+------------------------------------------------------+-----------------------+---------------------------------------------------------------------------+
| [launchurl]{#standard.launchurl}                     | GDC, GWC              | Opens an url with the default url handler - typically your default        |
|                                                      |                       | browser (http urls), or your default mailer (mailto urls).\               |
|                                                      |                       | Parameters:\                                                              |
|                                                      |                       | - The url to be opened.\                                                  |
|                                                      |                       | Supported schemes depend on your system configuration.\                   |
+------------------------------------------------------+-----------------------+---------------------------------------------------------------------------+
| [getenv]{#standard.getenv}                           | GDC                   | Returns an environment variable set in the user session on the front end  |
|                                                      |                       | workstation.\                                                             |
|                                                      |                       | Parameters:\                                                              |
|                                                      |                       | - The name of the environment variable.\                                  |
|                                                      |                       | Returns:\                                                                 |
|                                                      |                       | - The value of the environment variable.                                  |
+------------------------------------------------------+-----------------------+---------------------------------------------------------------------------+
| [getwindowid]{#standard.getwindowid}                 | GDC                   | Returns the local window manager identifier of the window corresponding   |
|                                                      |                       | to the AUI window id passed as parameter.\                                |
|                                                      |                       | Parameters:\                                                              |
|                                                      |                       | - The id of the Window node in the AUI tree.\                             |
|                                                      |                       | Returns:\                                                                 |
|                                                      |                       | - The local system window manage id of the window.\                       |
|                                                      |                       | The node must be a WINDOW node, otherwise \"0\" is returned ; in          |
|                                                      |                       | traditional mode, WINDOWs widgets are simple frames ; the top level       |
|                                                      |                       | widget is the USERINTERFACE widget. In this case, use \"0\" as parameter  |
|                                                      |                       | to get the top level window id.                                           |
+------------------------------------------------------+-----------------------+---------------------------------------------------------------------------+
| [opendir]{#standard.opendir}                         | GDC                   | Displays a file dialog window to get a directory path on the local file   |
|                                                      |                       | system.\                                                                  |
|                                                      |                       | Parameters:\                                                              |
|                                                      |                       | - The default path.\                                                      |
|                                                      |                       | - The caption to be displayed.\                                           |
|                                                      |                       | Returns:\                                                                 |
|                                                      |                       | - The name of the selected directory (or NULL if canceled).               |
+------------------------------------------------------+-----------------------+---------------------------------------------------------------------------+
| [openfile]{#standard.openfile}                       | GDC                   | Displays a file dialog window to get a path to open a file on the local   |
|                                                      |                       | file system.\                                                             |
|                                                      |                       | Parameters:\                                                              |
|                                                      |                       | - The default path.\                                                      |
|                                                      |                       | - The name to be displayed for the file type.\                            |
|                                                      |                       | - The file types (as a blank separated list of extensions).\              |
|                                                      |                       | - The caption to be displayed.\                                           |
|                                                      |                       | Returns:\                                                                 |
|                                                      |                       | - The name of the selected file (or NULL if canceled).                    |
+------------------------------------------------------+-----------------------+---------------------------------------------------------------------------+
| [savefile]{#standard.savefile}                       | GDC                   | Displays a file dialog window to get a path to save a file on the local   |
|                                                      |                       | file system.\                                                             |
|                                                      |                       | Parameters:\                                                              |
|                                                      |                       | - The default path.\                                                      |
|                                                      |                       | - The name to be displayed for the file type.\                            |
|                                                      |                       | - The file types (as a blank separated list of extensions).\              |
|                                                      |                       | - The caption to be displayed.\                                           |
|                                                      |                       | Returns:\                                                                 |
|                                                      |                       | - The name of the selected file (or NULL if canceled).                    |
+------------------------------------------------------+-----------------------+---------------------------------------------------------------------------+
| [cbclear]{#standard.cbclear}                         | GDC                   | Clears the content of the clipboard.\                                     |
|                                                      |                       | Parameters: none.\                                                        |
|                                                      |                       | Returns:\                                                                 |
|                                                      |                       | - The execution result (TRUE=success, FALSE=error).                       |
+------------------------------------------------------+-----------------------+---------------------------------------------------------------------------+
| [cbset]{#standard.cbset}                             | GDC                   | Set the content of the clipboard.\                                        |
|                                                      |                       | Parameters:\                                                              |
|                                                      |                       | - The text to be set.\                                                    |
|                                                      |                       | Returns:\                                                                 |
|                                                      |                       | - The execution result (TRUE=success, FALSE=error).                       |
+------------------------------------------------------+-----------------------+---------------------------------------------------------------------------+
| [cbget]{#standard.cbget}                             | GDC                   | Gets the content of the clipboard.\                                       |
|                                                      |                       | Parameters: none.\                                                        |
|                                                      |                       | Returns:\                                                                 |
|                                                      |                       | - The text in the clipboard.                                              |
+------------------------------------------------------+-----------------------+---------------------------------------------------------------------------+
| [cbadd]{#standard.cbadd}                             | GDC                   | Adds to the content of the clipboard.\                                    |
|                                                      |                       | Parameters:\                                                              |
|                                                      |                       | - The text to be added.\                                                  |
|                                                      |                       | Returns:\                                                                 |
|                                                      |                       | - The execution result (TRUE=success, FALSE=error).                       |
+------------------------------------------------------+-----------------------+---------------------------------------------------------------------------+
| [cbpaste]{#standard.cbpaste}                         | GDC                   | Pastes the content of the clipboard to the current field.\                |
|                                                      |                       | Parameters: none.\                                                        |
|                                                      |                       | Returns:\                                                                 |
|                                                      |                       | - The execution result (TRUE=success, FALSE=error).                       |
+------------------------------------------------------+-----------------------+---------------------------------------------------------------------------+
| [mdclose]{#standard.mdclose}                         | GDC                   | Unloads a DLL or shared library module.\                                  |
|                                                      |                       | Parameters:\                                                              |
|                                                      |                       | - The name of the module.\                                                |
|                                                      |                       | Returns:\                                                                 |
|                                                      |                       | - 0 = success, -1 = module not found, -2 = cannot unload (busy).          |
+------------------------------------------------------+-----------------------+---------------------------------------------------------------------------+
| [setreportfont]{#standard.setreportfont}             | GDC                   | Override the font used for report generation for the current application. |
|                                                      |                       | You can simply copy/paste the font string from the \"Report To Printer\"  |
|                                                      |                       | font panel from GDC Monitor. An empty or null string reset to the default |
|                                                      |                       | behavior.\                                                                |
|                                                      |                       | Parameter:\                                                               |
|                                                      |                       | - A string that describe the font to use for report generation. for       |
|                                                      |                       | exemple: \"Helvetica, Bold, Italic, 13\". Alternatively you can specify   |
|                                                      |                       | `"<ASK_ONCE>"`, `"<ASK_ALWAYS>"`, `"<USER_DEFINED>"` or                   |
|                                                      |                       | `"<USE_DEFAULT>"`\" which will perform the corresponding actions.\        |
|                                                      |                       | Returns:\                                                                 |
|                                                      |                       | - The execution result (TRUE=success, FALSE=error).                       |
+------------------------------------------------------+-----------------------+---------------------------------------------------------------------------+
| [setreportprinter]{#standard.setreportprinter}       | GDC                   | Override the printer configuration used for report generation for the     |
|                                                      |                       | current application. You can simply copy/paste the printer string from    |
|                                                      |                       | the \"Report To Printer\" printer panel from GDC Monitor. An empty or     |
|                                                      |                       | null string reset to the default behavior.\                               |
|                                                      |                       | Parameter:\                                                               |
|                                                      |                       | - A string that describe the printer to use for report generation. for    |
|                                                      |                       | exemple: \"moliere, Portrait, A4, 96 dpi, 1 copy, Ascendent, Color, Auto. |
|                                                      |                       | Alternatively you can specify `"<ASK_ONCE>"`, `"<ASK_ALWAYS>"`,           |
|                                                      |                       | `"<USER_DEFINED>"` or `"<USE_DEFAULT>"`\" which will perform the          |
|                                                      |                       | corresponding actions.\                                                   |
|                                                      |                       | Returns:\                                                                 |
|                                                      |                       | - The execution result (TRUE=success, FALSE=error).                       |
+------------------------------------------------------+-----------------------+---------------------------------------------------------------------------+
| [setwebcomponentpath]{#standard.setwebcomponentpath} | GDC                   | Defines the base path where [Web Components](WebComponent.html) are       |
|                                                      |                       | located, when GDC is directly connected to the runtime system. This is    |
|                                                      |                       | ignored when GDC is connected to the GAS.\                                |
|                                                      |                       | Parameter:\                                                               |
|                                                      |                       | - The base url (e.g. `"http://myserver/components"` or                    |
|                                                      |                       | `"file:///c:/components"`)\                                               |
|                                                      |                       | Returns:\                                                                 |
|                                                      |                       | - The execution result (TRUE=success, FALSE=error).                       |
+------------------------------------------------------+-----------------------+---------------------------------------------------------------------------+
