[Back to Contents](../index.html)

------------------------------------------------------------------------

# [Using Windows and Forms]{#PAGE_HEADER}

Summary:

- [Windows and Forms Concepts](#WHAT_IS)
  - [Windows](#CONCEPTS_WINDOWS)
  - [Forms](#CONCEPTS_FORMS)
  - [Windows in MDI mode](#CONCEPTS_MDI)
  - [Traditional text mode](#CONCEPTS_TRADITIONAL)
- [Opening a Window](#OPEN_WINDOW) (`OPEN WINDOW`)
  - [Window Position and Dimensions](#POSDIM)
  - [Open With Form](#WITHFORM)
  - [Window Styles](#WINDOW_STYLES)
  - [Window Titles](#WINDOW_TITLES)
  - [Window Icons](#WINDOW_ICONS)
  - [OPEN WINDOW attributes](#ATTRIBUTES)
- [Closing a Window](#CLOSE_WINDOW) (`CLOSE WINDOW`)
- [Selecting a Window](#CURRENT_WINDOW) (`CURRENT WINDOW IS`)
- [Opening a Form](#OPEN_FORM) (`OPEN FORM`)
- [Displaying a Form](#DISPLAY_FORM) (`DISPLAY FORM`)
- [Closing a Form](#CLOSE_FORM) (`CLOSE FORM`)
- [Clearing a Window](#CLEAR_WINDOW) (`CLEAR WINDOW`) **TUI Only!**
- [Clearing the screen](#CLEAR_SCREEN) (`CLEAR SCREEN`) **TUI Only!**
- [Displaying text by position](#DISPLAY_AT) (`DISPLAY AT`) **TUI
  Only!**

*See also:* [Presentation Styles](PresentationStyles.html), [Window
class](ClassWindow.html), [Form class](ClassForm.html), [Flow
Control](FlowControl.html), [Forms](FormSpecFiles.html), [Input
Array](InputArray.html), [Display Array](DisplayArray.html), [Record
Input](RecordInput.html), [Construct](Construct.html).

------------------------------------------------------------------------

### [Windows and Forms Concepts]{#WHAT_IS}

Programs manipulate \"Window\" and \"Form\" objects to define display
areas for interactive instructions like [INPUT ARRAY](InputArray.html),
[DISPLAY ARRAY](DisplayArray.html), [DIALOG](MultipleDialogs.html),
[INPUT](RecordInput.html) and [CONSTRUCT](Construct.html). When an
interactive instruction takes control, it uses the Form associated with
the current window.

#### [Windows]{#CONCEPTS_WINDOWS}

Windows are created from programs; they define a display context for
sub-elements like forms, ring menus, message and error lines. A window
can contain only one form at a time.

When using a character terminal, windows are displayed as fixed-size
boxes, at a given line and column position, with a given width and
height. When using a graphical front end, windows are displayed as
independent resizable windows by default. This behavior is needed to
create real graphical applications, but it breaks the old-mode layout
implementations.

When a Genero program starts, it creates a default window named SCREEN.
This default window can be used as another window (it can hold a Ring
Menu and a Form), but it can also be closed, with `CLOSE WINDOW SCREEN`.
You can display the main form of your program in the SCREEN window, by
using [OPEN FORM](#OPEN_FORM) + [DISPLAY FORM](#DISPLAY_FORM).

A program creates a new window with the [OPEN WINDOW](#OPEN_WINDOW)
instruction, which also defines the window identifier. The program
destroys a Window with the [CLOSE WINDOW](#CLOSE_WINDOW) instruction.
One or more windows can be displayed concurrently, but there can be only
one current Window. You can use the [CURRENT WINDOW](#CURRENT_WINDOW)
instruction to make a specific window current. This is however not
typical and is not recommended, since the last created window becomes
the current window. When the last created window is closed, the previous
window in the window stack becomes the current window.

When opening a window, the [window style](#WINDOW_STYLES) is used to
specify the type and the decoration of the window.

You can also use the [ui.Window](ClassWindow.html) class to manipulate
windows as objects.

#### [Forms]{#CONCEPTS_FORMS}

Forms define the layout and presentation of areas used by the program to
display or input data. Typically, Forms are loaded by programs from
external files with the **42f** extension, the compiled version of [Form
Specification Files](FormSpecFiles.html).

Forms files are identified by the file name, but you can also specify a
form version with the [VERSION](FSFAttributes.html#FA_VERSION)
attribute. The form version attribute is typically used to indicate that
the form content has changed. The front-end is then able to distinguish
different form versions and avoid saved settings being reloaded for new
form versions.

A program can load a Form file with the [OPEN FORM](#OPEN_FORM)
instruction, then display the Form with [DISPLAY FORM](#DISPLAY_FORM)
into the current window, and release resources with [CLOSE
FORM](#CLOSE_FORM). For temporary popup windows (typical record list
where the user can select a row), you must dedicate a new window for the
form. This can be done wit a unique instruction: [OPEN WINDOW WITH
FORM](#OPEN_WINDOW).

When a Form is displayed, it is attached to the current window and a
[ui.Form](ClassForm.html) object is created internally. You can get this
object with the [ui.Window.getForm()](ClassWindow.html) method. The
[ui.Form](ClassForm.html) built-in class is provided to handle form
elements. You can, for example, hide some parts of a form.

The Form that is used by interactive instructions like
[INPUT](RecordInput.html) is defined by the [current
window](#CURRENT_WINDOW).

#### [Windows in MDI mode]{#CONCEPTS_MDI}

Windows can be displayed in an MDI container application; see [MDI
Windows](MDIWindows.html) for more details.

#### [Traditional text mode]{#CONCEPTS_TRADITIONAL}

To simplify migration from Informix 4GL or Four Js BDS, you can run GUI
application in traditional text mode, displaying windows as simple
boxes. For more details, see [Compatibility with traditional text
mode](DynamicUI.html#TRADITIONAL_MODE).

------------------------------------------------------------------------

### [OPEN WINDOW]{#OPEN_WINDOW}

#### Purpose:

Creates and displays a new [Window](#WHAT_IS).

#### Syntax:

`OPEN WINDOW `*`identifier`\
` `*` `[`[`]{.underline}` AT `*`line`*`, `*`column`*` `[`]`]{.underline}` `*\
`  `*`WITH `[`[`]{.underline}` FORM `*`form-file`*` `[`|`]{.underline}` `*`height`*` ROWS, `*`width`*` COLUMNS `[`]`\]{.underline}
*`  `*[`[`]{.underline}` ATTRIBUTE ( `*`window-attributes`*` ) `[`]`]{.underline}

#### Notes:

1.  *identifier* is the name of the window. It is always converted to
    lowercase by the compiler.
2.  *line* is the integer defining the top position of the window.\
    The first line in the screen is 1, while the relative line number
    inside the window is zero.
3.  *column* is the integer defining the position of the left margin.\
    The first column in the screen is 1, while the relative column
    number inside the window is zero.
4.  *form-file* is a string [literal](Literals.html#LT_STRING) or
    [variable](Variables.html) defining the [form specification
    file](FormSpecFiles.html) to be used, without the file extension.
5.  *height* defines the number of lines of the window in character
    units; includes the borders in character mode.
6.  *width* defines the number of lines of the window in character
    units; includes the borders in character mode.
7.  *window-attributes* defines the window attributes. See
    [below](#ATTRIBUTES) for more details.

#### Tips:

1.  For graphical applications, use this instruction without the `AT`
    clause, and with the `WITH FORM` clause.

#### Warnings:

1.  The compiler converts the window identifier to lowercase for
    internal storage. When using functions or methods receiving the
    window identifier as a string parameter, the window name is
    case-sensitive. We recommend that you always specify the window
    identifier in lowercase letters. 

#### Usage:

An `OPEN WINDOW` statement can have the following effects:

- Declares a name (the *identifier*) for the window.
- Indicates which [form](FormSpecFiles.html) has to be used in that
  window.
- Specifies the display attributes of the window.
- When using character mode, specifies the position and dimensions of
  the window, in character units.

The window identifier must follow the rules for
[identifiers](LanguageFeatures.html#LF_IDENTS) and be unique among all
windows defined in the program. Its scope is the entire program. You can
use this identifier to reference the same Window in other modules with
other statements (for example, [CURRENT WINDOW](#CURRENT_WINDOW) and
[CLOSE WINDOW](#CLOSE_WINDOW)).

The runtime system maintains a stack of all open windows. If you execute
`OPEN WINDOW` to open a new window, it is added to the window stack and
becomes the current window. Other statements that can modify the window
stack are [CURRENT WINDOW](#CURRENT_WINDOW) and [CLOSE
WINDOW](#CLOSE_WINDOW).

#### [Window Position and Dimensions]{#POSDIM}

When using the Genero [GUI](FglTerms.html#GRAPHICAL_USER_INTERFACE) mode
(without [traditional rendering mode](DynamicUI.html#TRADITIONAL_MODE)),
the `AT `*`line`*`, `*`column`* clause is optional and if used, the
`WITH `*`lines`*` ROWS, `*`characters`*` COLUMNS` clause is ignored,
because the size of the window is automatically calculated according to
its contents.

When using the [TUI](FglTerms.html#TEXT_USER_INTERFACE) mode, the the
`AT `*`line`*`, `*`column`* clause defines the position of the top-left
corner of the window on the terminal screen and
`WITH `*`lines`*` ROWS, `*`characters`*` COLUMNS` clause specifies
explicit vertical and horizontal dimensions for the window. The
expression at the left of the `ROWS` keyword specifies the height of the
window, in character unit lines. This must be an integer between 1 and
max, where max is the maximum number of lines that the screen can
display. The integer expression after the comma at the left of the
`COLUMNS` keyword specifies the width of the window, in character unit
columns. This must return a whole number between 1 and length, where
length is the number of characters that your monitor can display on one
line. In addition to the lines needed for a form, allow room for the
Comment line, the Menu line, the Menu comment line and the Error line.
The runtime system issues a runtime error if the window does not include
sufficient lines to display both the form and these additional reserved
lines. The minimum number of lines required to display a form in a
window is the number of lines in the form, plus an additional line below
the form for prompts, messages, and comments.

#### [Open With Form]{#WITHFORM}

As an alternative to specifying explicit dimensions, the `WITH FORM`
clause can specify a [quoted string](Literals.html) or a [character
variable](Variables.html) that specifies the name of a file that
contains the compiled [screen form](FormSpecFiles.html). The runtime
system expects the compiled version of the form, but the file name
should not include the **.42f** file extension. A window is
automatically opened and sized to the [screen layout of the
form](FormSpecFiles.html#SECTION_LAYOUT). When using character mode, the
width of the window is from the left-most character on the screen form
(including leading blank spaces) to the right-most character on the
screen form (truncating trailing blank spaces). The length of the window
is calculated as (form line) + (form length).

It is recommended that you use the `WITH FORM` clause, especially in the
standard [GUI](FglTerms.html#GRAPHICAL_USER_INTERFACE) mode, because the
window is created in accordance with the form. If you use this clause,
you do not need the [OPEN FORM](#OPEN_FORM), [DISPLAY
FORM](#DISPLAY_FORM), or [CLOSE FORM](#CLOSE_FORM) statement to open and
close the form. The [CLOSE WINDOW](#CLOSE_WINDOW) statement closes the
window and the form.

#### [Window Styles]{#WINDOW_STYLES}

By default windows are displayed as normal application windows, but you
can use the window style to show a window at the top of all other
windows, as a \"modal window\".

The window style defines the type of the window (normal, modal) and its
decoration, via a [Presentation Style](PresentationStyles.html). The
Presentation Style specifies a set of attributes in an external file
(.4st).

The `STYLE` attribute can be used in the [OPEN WINDOW](#OPEN_WINDOW)
instruction to define the default style for a Window, but it is better
to specify the window style in the form file, with the `WINDOWSTYLE`
attribute of the [LAYOUT](FormSpecFiles.html#SECTION_LAYOUT) section.
This avoids decoration-specific code in the programs.

#### Warnings:

1.  If you open and display a second form in an existing window, the
    window style of the second form is not applied.

The following standard window styles are defined in the default
presentation style file (FGLDIR/lib/default.4st):

  ----------------------- ----------------------- ------------------------------
  **STYLE attribute**     **Style name in 4st     **Description**
                          file**                  

  *`none`*                `Window`                Defines presentation
                                                  attributes for common
                                                  application windows. When
                                                  using MDI containers, normal
                                                  windows are displayed as MDI
                                                  children.

  `main`                  `Window.main`\          Defines presentation
                          `Window.main2`          attributes for starter
                                                  applications, where the main
                                                  window shows a
                                                  [startmenu](StartMenus.html)
                                                  if one is defined by the
                                                  application.

  `dialog`                `Window.dialog`\        Defines presentation
                          `Window.dialog2`\       attributes for typical
                          `Window.dialog3`\       OK/Cancel modal windows.
                          `Window.dialog4`        

  `naked`                 `Window.naked`          Defines presentation
                                                  attributes for windows that
                                                  should not show the default
                                                  view for ring menus and action
                                                  buttons (OK/Cancel).

  `viewer`                `Window.viewer`         Defines presentation
                                                  attributes for viewers as the
                                                  report pager (fglreport.per).
  ----------------------- ----------------------- ------------------------------

#### Warnings:

1.  It is recommended that you NOT change the default settings of
    windows styles in the **default.4st** file.
2.  If you create your own style file, copy the default styles into your
    file.
3.  It is not possible to change the presentation attributes of windows
    in the AUI tree.

For more details about the attributes you can set for Windows, see
[Presentation Styles](PresentationStyles.html).

#### [Window Titles]{#WINDOW_TITLES}

The `TEXT` attribute in the `ATTRIBUTE` clause defines the default title
of the window. If the window is opened with a form (`WITH FORM`) that
defines a `TEXT` attribute in the
[LAYOUT](FormSpecFiles.html#SECTION_LAYOUT) section, the default is
ignored. Subsequent [OPEN FORM](#OPEN_FORM)/[DISPLAY
FORM](#DISPLAY_FORM) instructions may change the window title if the new
form defines a different title in the
[LAYOUT](FormSpecFiles.html#SECTION_LAYOUT) section.

It is recommended that you specify the window title in the form file,
not with the `TEXT` attribute of the `OPEN WINDOW` instruction.

If you want to set a window title dynamically, you can use the
[Window](ClassWindow.html) built-in class.

#### [Window Icons]{#WINDOW_ICONS}

If the window is opened with a form (`WITH FORM`) that defines an
`IMAGE` attribute in the [LAYOUT](FormSpecFiles.html#SECTION_LAYOUT)
section, the window will use this image as icon. Subsequent [OPEN
FORM](#OPEN_FORM)/[DISPLAY FORM](#DISPLAY_FORM) instructions may change
the window icon if the new form defines a different image in the
[LAYOUT](FormSpecFiles.html#SECTION_LAYOUT) section.

If you want to set a window icon dynamically, you can use the
[Window](ClassWindow.html) built-in class.

#### [OPEN WINDOW attributes]{#ATTRIBUTES}

The following table shows the *window-attributes* supported by the
`OPEN WINDOW` statement:

::: {align="center"}
  ------------------------------------------------------------------------------------- ------------------------------------
  **Attribute**                                                                         **Description**

  `TEXT = `*`string`*                                                                   Defines the default title of the
                                                                                        window. When a form is displayed,
                                                                                        the form title
                                                                                        (`LAYOUT(TEXT="mytitle")`) will be
                                                                                        used as window title.\
                                                                                        ***We recommend that you define the
                                                                                        window title in the form file!***

  `STYLE = `*`string`*                                                                  Defines the default style of the
                                                                                        window. If the form defines a window
                                                                                        style,
                                                                                        (`LAYOUT(WINDOWSTYLE="mystyle")`),
                                                                                        it overwrites the default window
                                                                                        style.\
                                                                                        See [Window Styles](#WINDOW_STYLES)
                                                                                        for more details.\
                                                                                        ***We recommend that you define the
                                                                                        window style in the form file!***

  `BLACK, BLUE, CYAN, GREEN, MAGENTA, RED, WHITE, YELLOW`                               Default TTY color of the data
                                                                                        displayed in the window.

  `BOLD, DIM, INVISIBLE, NORMAL`                                                        Default TTY font attribute of the
                                                                                        data displayed in the window.

  `REVERSE, BLINK, UNDERLINE`                                                           Default TTY video attribute of the
                                                                                        data displayed in the window.

  `PROMPT LINE `*`integer`\*                                                            In character mode, indicates the
  ` `**`TUI Only!`**                                                                    position of the prompt line for this
                                                                                        window. The position can be
                                                                                        specified with `FIRST` and `LAST`
                                                                                        predefined line positions.

  `FORM LINE `*`integer`\*                                                              In character mode, indicates the
  ` `**`TUI Only!`**                                                                    position of the form line for this
                                                                                        window. The position can be
                                                                                        specified with `FIRST` and `LAST`
                                                                                        predefined line positions.

  `MENU LINE `*`integer`\*                                                              In character mode, indicates the
  ` `**`TUI Only!`**                                                                    position of the ring menu line for
                                                                                        this window. The position can be
                                                                                        specified with `FIRST` and `LAST`
                                                                                        predefined line positions.

  `MESSAGE LINE `*`integer`\*                                                           In character mode, indicates the
  ` `**`TUI Only!`**                                                                    position of the message line for
                                                                                        this window. The position can be
                                                                                        specified with `FIRST` and `LAST`
                                                                                        predefined line positions.

  `ERROR LINE `*`integer`\*                                                             In character mode, indicates the
  ` `**`TUI Only!`**                                                                    position of the error line for this
                                                                                        window. The position can be
                                                                                        specified with `FIRST` and `LAST`
                                                                                        predefined line positions.

  `COMMENT LINE `[`{`]{.underline}`OFF`[`|`]{.underline}*`integer`*[`}`\]{.underline}   In character mode, indicates the
  ` `**`TUI Only!`**                                                                    position of the comment line or no
                                                                                        comment line at all, for this
                                                                                        window. The position can be
                                                                                        specified with `FIRST` and `LAST`
                                                                                        predefined line positions.

  `BORDER`\                                                                             Indicates if the window must be
  **`TUI Only!`**                                                                       created with a border in character
                                                                                        mode. A border frame is drawn
                                                                                        [outside]{.underline} the specified
                                                                                        window. This means, that the window
                                                                                        needs 2 additional lines and columns
                                                                                        on the screen.
  ------------------------------------------------------------------------------------- ------------------------------------
:::

The following list describes the default line positions in character
mode:

- **First line:** Prompt line (output from [PROMPT](Prompt.html)
  statement) and Menu line (command value from [MENU](Menus.html)
  statement).
- **Second line:** Message line (output from
  [MESSAGE](MessageDisplay.html#MESSAGE) statement; also the
  descriptions of [MENU](Menus.html) options).
- **Third line:** Form line (output from [DISPLAY FORM](#DISPLAY_FORM)
  statement).
- **Last line:** Error line (output from
  [ERROR](MessageDisplay.html#ERROR) statement); also comment line in
  any window except SCREEN.

#### Example:


    01 MAIN
    02    OPEN WINDOW w1 WITH FORM "customer"
    03    MENU "Test"
    04       COMMAND KEY(INTERRUPT) "exit" EXIT MENU
    05    END MENU
    06    CLOSE WINDOW w1
    07 END MAIN

------------------------------------------------------------------------

### [CLOSE WINDOW]{#CLOSE_WINDOW}

#### Purpose:

Closes and destroys a window. 

#### Syntax:

`CLOSE WINDOW `*`identifier`*

#### Notes:

1.  *identifier* is the name of the window.
2.  If the `OPEN WINDOW` statement includes the `WITH FORM` clause, it
    closes both the form and the window.
3.  Closing a window has no effect on variables that were set while the
    window was open.
4.  Closing the current window makes the next window on the stack the
    new current window. If you close any other window, the runtime
    system deletes it from the stack, leaving the current window
    unchanged.

#### Tips:

1.  You can close the default screen window with the
    `CLOSE WINDOW SCREEN` instruction.

#### Warnings:

1.  If the window is currently being used for input, `CLOSE WINDOW`
    generates a runtime error.

#### Example:


    01 MAIN
    02    OPEN WINDOW w1 WITH FORM "customer"
    03    MENU "Test"
    04       COMMAND KEY(INTERRUPT) "exit" EXIT MENU
    05    END MENU
    06    CLOSE WINDOW w1
    07 END MAIN

------------------------------------------------------------------------

### [CURRENT WINDOW]{#CURRENT_WINDOW}

#### Purpose:

Makes a specified window the [current window](#WHAT_IS).

#### Syntax:

`CURRENT WINDOW IS `*`identifier`*

#### Notes:

1.  *identifier* is the name of the window or the `SCREEN` keyword.

#### Usage:

Programs with multiple windows might need to switch to a different open
window so that input and output occur in the appropriate window. To make
a window the current window, use the `CURRENT WINDOW` statement.

When a program starts, the screen is the current window. Its name is
SCREEN. To make this the current window, specify the keyword `SCREEN`
instead of a window identifier.

If the window contains a form, that form becomes the current form when a
CURRENT WINDOW statement specifies the name of that window. The
CONSTRUCT, DISPLAY ARRAY, INPUT, INPUT ARRAY, and MENU statements use
only the current window for input and output. If the user displays
another form (for example, through an ON KEY clause) in one of these
statements, the window containing the new form becomes the current
window. When the CONSTRUCT, DISPLAY ARRAY, INPUT, INPUT ARRAY, or MENU
statement resumes, its original window becomes the current window.

#### Example:


    01 MAIN
    02    OPEN WINDOW w1 WITH FORM "customer"
    03    ...
    04    OPEN WINDOW w2 WITH FORM "custlist"
    05    ...
    06    CURRENT WINDOW IS w1
    07    ...
    08    CURRENT WINDOW IS w2
    09    ...
    10    CLOSE WINDOW w1
    11    CLOSE WINDOW w2
    12 END MAIN

------------------------------------------------------------------------

### [CLEAR WINDOW]{#CLEAR_WINDOW} TUI Only!

#### Purpose:

Clears the contents of a window in character mode.

#### Syntax:

`CLEAR WINDOW `*`identifier`*

#### Notes:

1.  *identifier* is the name of the window, or the `SCREEN` keyword.

#### Warnings:

1.  This instruction is provided for backward compatibility; it is only
    supported to clear windows created in
    [TUI](FglTerms.html#TEXT_USER_INTERFACE) mode.

------------------------------------------------------------------------

### [OPEN FORM]{#OPEN_FORM}

#### Purpose:

Declares a compiled form in the program.

#### Syntax:

`OPEN FORM `*`identifier`*` FROM `*`file-name`*

#### Notes:

1.  *identifier* is the name of the window object.
2.  The scope of reference of *identifier* is the entire program.
3.  *file-name* is a string [literal](Literals.html) or
    [variable](Variables.html) defining the name of the compiled [Form
    Specification File](FormSpecFiles.html).
4.  Form files are found by using the directory paths defined in the
    [DBPATH](EnvironmentVariables.html#EV_DBPATH)/[FGLRESOURCEPATH](EnvironmentVariables.html#EV_FGLRESOURCEPATH)
    environment variable.

#### Tips:

1.  When the window is dedicated to the form, use the
    `OPEN WINDOW WITH FORM` instruction to create the window and the
    form object in one statement.
2.  It is not recommended that you provide a path for *file-name*; You
    should use the
    [DBPATH](EnvironmentVariables.html#EV_DBPATH)/[FGLRESOURCEPATH](EnvironmentVariables.html#EV_FGLRESOURCEPATH)
    environment variable instead.

#### Usage:

In order to use a **42f** compiled version of a [Form Specification
File](FormSpecFiles.html), the programs must declare the form with the
`OPEN FORM` instruction and then display the form in the current window
by using the [DISPLAY FORM](#DISPLAY_FORM) instruction. `OPEN FORM` /
`DISPLAY FORM` are typically used at the beginning of programs to
display the main form in the default `SCREEN` window:


    01 OPEN FORM f FROM "customer"
    02 DISPLAY FORM f

If you execute an `OPEN FORM` with the name of an open form, the runtime
system first closes the existing form before opening the new form.

In character mode, the form is displayed in the current window at the
position defined by the `FORM LINE` attribute that can be specified in
the `ATTRIBUTE` clause of [OPEN WINDOW](#OPEN_WINDOW) or as default with
the [OPTIONS](Programs.html#PROGRAM_OPTIONS) instruction. 

After the form is loaded, you can activate the form by executing a
[CONSTRUCT](Construct.html), [DISPLAY ARRAY](DisplayArray.html),
[INPUT](RecordInput.html), [INPUT ARRAY](InputArray.html), or
[DIALOG](MultipleDialogs.html) statement. When the runtime system
executes the `OPEN FORM` instruction, it allocates resources and loads
the form into memory. To release the allocated resources when the form
is no longer needed,  the program must execute the [CLOSE
FORM](#CLOSE_FORM) instruction. This is a memory-management feature to
recover memory from forms that the program no longer displays on the
screen. If the form was loaded with a window by using the `WITH FORM`
clause, it is automatically closed when the window is closed with a
[CLOSE WINDOW](#CLOSE_WINDOW) instruction.

The quoted string that follows the FROM keyword must specify the name of
the file that contains the compiled screen form. This filename can
include a pathname, but this is not recommended.

The form *identifier* does not need to match the name of the [Form
Specification File](FormSpecFiles.html), but it must be unique among
form names in the program. Its scope of reference is the entire program.

#### Example:


    01 MAIN
    02    OPEN FORM f1 FROM "customer"
    03    DISPLAY FORM f1
    04    CALL input_customer()
    05    CLOSE FORM f1
    06    OPEN FORM f2 FROM "custlist"
    07    DISPLAY FORM f2
    08    CALL input_custlist()
    09    CLOSE FORM f2
    10 END MAIN

------------------------------------------------------------------------

### [DISPLAY FORM]{#DISPLAY_FORM}

#### Purpose:

Displays and associates a form with the [current window](#WHAT_IS).

#### Syntax:

`DISPLAY FORM `*`identifier`*\
*`  `*[`[`]{.underline}` ATTRIBUTE ( `*`display-attributes`*` ) `[`]`]{.underline}

#### Notes:

1.  *identifier* is the name of the form.
2.  *window-attributes* defines the display attributes of the form. See
    below for more details.

#### Usage:

The following table shows the *display-attributes* supported by the
`DISPLAY FORM` statement:

::: {align="center"}
  --------------------------------------------------------- -----------------------------------
  **Attribute**                                             **Description**

  `BLACK, BLUE, CYAN, GREEN, MAGENTA, RED, WHITE, YELLOW`   Default TTY color of the data
                                                            displayed in the form.

  `BOLD, DIM, INVISIBLE, NORMAL`                            Default TTY font attribute of the
                                                            data displayed in the form.\
                                                            **Warning:** The `INVISIBLE`
                                                            attribute is ignored.

  `REVERSE, BLINK, UNDERLINE`                               Default TTY video attribute of the
                                                            data displayed in the form.
  --------------------------------------------------------- -----------------------------------
:::

The runtime system applies any other display attributes that you specify
in the `ATTRIBUTE` clause to any fields that have not been assigned
attributes by the [ATTRIBUTES
section](FormSpecFiles.html#SECTION_ATTRIBUTES) of the [Form
Specification File](FormSpecFiles.html), or by the [database schema
files](DatabaseSchema.html), or by the
[OPTIONS](Programs.html#PROGRAM_OPTIONS) statement. If the form is
displayed in a window, color attributes from the `DISPLAY FORM`
statement supersede any from the [OPEN WINDOW](#OPEN_WINDOW) statement.
If subsequent [CONSTRUCT](Construct.html),
[DISPLAY](RecordDisplay.html), or [DISPLAY ARRAY](DisplayArray.html)
statements that include an `ATTRIBUTE` clause reference the form,
however, their attributes take precedence over those specified in the
`DISPLAY FORM` instruction.

------------------------------------------------------------------------

### [CLOSE FORM]{#CLOSE_FORM}

#### Purpose:

Closes a form.

#### Syntax:

`CLOSE FORM `*`identifier`*

#### Notes:

1.  *identifier* is the name of the form.
2.  Releases the memory allocated to the form.

#### Tips:

1.  A form associated with a window by the `OPEN WINDOW WITH FORM`
    instruction is automatically closed when the program closes the
    window with a [CLOSE WINDOW](#CLOSE_WINDOW) instruction.

------------------------------------------------------------------------

### [CLEAR SCREEN]{#CLEAR_SCREEN} TUI Only!

#### Purpose:

Clears the complete application screen in character mode.

#### Syntax:

`CLEAR SCREEN`

#### Notes:

1.  Clears the complete screen.

#### Warnings:

1.  The `CLEAR SCREEN` instruction is provided for backward
    compatibility when using the
    [TUI](FglTerms.html#TEXT_USER_INTERFACE) mode.

------------------------------------------------------------------------

### [DISPLAY AT]{#DISPLAY_AT} TUI Only!

#### Purpose:

Displays text at a given position in character mode in the current
window.

#### Syntax:

`DISPLAY `*`text`*` AT `*`line`*`, `*`column`*` `[`[`]{.underline}` ATTRIBUTE ( `*`display-attributes`*` ) `[`]`]{.underline}

#### Notes:

1.  *text* is any [expression](Expressions.html) to be evaluated and
    displayed at the given position in the current window.
2.  *line* is an integer [literal](Literals.html) or
    [variable](Variables.html) defining the line position in the current
    window.
3.  *column* is an integer [literal](Literals.html) or
    [variable](Variables.html) defining the column position on the
    screen.
4.  *display-attributes* defines the display attributes for the *text*.
    See below for more details.

#### Warnings:

1.  The `DISPLAY AT` instruction is provided for backward compatibility
    and should only be used in [TUI](FglTerms.html#TEXT_USER_INTERFACE)
    mode. To display data at a given place in a graphical form, use
    [form fields](FormSpecFiles.html) and the [DISPLAY
    TO](RecordDisplay.html#DISPLAY_TO) instruction.

#### Usage:

The following table shows the *display-attributes* supported by the
`DISPLAY AT` statement:

::: {align="center"}
  --------------------------------------------------------- ------------------------------------------------
  **Attribute**                                             **Description**
  `BLACK, BLUE, CYAN, GREEN, MAGENTA, RED, WHITE, YELLOW`   The TTY color of the displayed text.
  `BOLD, DIM, INVISIBLE, NORMAL`                            The TTY font attribute of the displayed text.
  `REVERSE, BLINK, UNDERLINE`                               The TTY video attribute of the displayed text.
  --------------------------------------------------------- ------------------------------------------------
:::
