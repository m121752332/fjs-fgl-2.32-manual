[Back to Contents](../index.html)

------------------------------------------------------------------------

# [Frequently Asked Questions]{#PAGE_HEADER}

This page contains questions frequently asked when migrating
applications from BDL V3 to Genero BDL.

[FAQ001: When using Genero, why do I have a different display than with
BDL V3?\
](#FAQ001) [FAQ002: Why does an empty window always appear?\
](#FAQ002) [FAQ003: Why do some COMMAND KEY buttons no longer appear?\
](#FAQ003) [FAQ004: Why aren\'t the elements of my forms aligned
properly?\
](#FAQ004) [FAQ005: Why doesn\'t the ESC key validate my input?\
](#FAQ005) [FAQ006: Why doesn\'t the CTRL-C key cancel my input?\
](#FAQ006) [FAQ007: Why do the gui.\* FGLPROFILE entries have no
effect?\
](#FAQ007) [FAQ008: Why do I get a link error when using the
FGL_GETKEY() function?\
](#FAQ008) [FAQ009: Why do large static arrays raise a stack overflow
error?\
](#FAQ009) [FAQ010: Why do get error -6366 \"Could not load database
driver *drivername*\"?](#FAQ010)\
[FAQ011: Why do get invalid characters in my forms?](#FAQ011)

------------------------------------------------------------------------

### [FAQ001: When using Genero, why do I have a different display than with BDL V3?]{#FAQ001}

#### Explanation:

Genero introduces major Graphical User Interface enhancements that
sometimes require code modification. With BDL V3, application windows
created with the [OPEN WINDOW](WindowsAndForms.html#OPEN_WINDOW)
instruction were displayed as static boxes in the main graphical window.
In the new GUI mode of Genero, application windows are displayed as
independent, resizable graphical windows.

*Links:* [Dynamic User Interface](DynamicUI.html),
[Windows](WindowsAndForms.html), [Application
class](ClassApplication.html).

------------------------------------------------------------------------

### [FAQ002: Why does an empty window always appear?]{#FAQ002}

#### Description:

An additional empty window appears when I explicitly create a window
with [OPEN WINDOW](WindowsAndForms.html#OPEN_WINDOW) (following the [new
window management rules](WindowsAndForms.html)).

``` linenumber
01 MAIN
02   OPEN WINDOW w1 AT 1,1 WITH FORM "form1"
03   MENU "Example"
04    COMMAND "Exit"
05     EXIT MENU
06   END MENU
07   CLOSE WINDOW w1
08 END MAIN
```

#### Explanation:

In the new standard [GUI](FglTerms.html#GRAPHICAL_USER_INTERFACE) mode,
all Windows are displayed as real front-end windows, including the
default `SCREEN` Window. When an application starts, the runtime system
creates this default SCREEN Window, as in version 3. This is required
because some applications use the `SCREEN` Window to display forms (they
do not use the [OPEN WINDOW](WindowsAndForms.html#OPEN_WINDOW)
instruction to create new windows). So, to facilitate BDS V3 to Genero
migration, the runtime system must keep the default `SCREEN` window
creation; otherwise, existing applications would fail if their code was
not modified.

#### Solution:

You can either execute a [CLOSE WINDOW
SCREEN](WindowsAndForms.html#CLOSE_WINDOW) at the beginning of the
program, to close the default window created by the runtime system, or
use the [OPEN FORM](WindowsAndForms.html#OPEN_FORM) + [DISPLAY
FORM](WindowsAndForms.html#DISPLAY_FORM) instructions, to display the
main form in the default `SCREEN` window.

#### Example:

``` linenumber
01 MAIN
03   OPEN FORM f FORM "form1"
03   DISPLAY FORM f
04   MENU "Example"
05    COMMAND "Exit"
06     EXIT MENU
07   END MENU
08 END MAIN
```

------------------------------------------------------------------------

### [FAQ003: Why do some COMMAND KEY buttons no longer appear?]{#FAQ003}

#### Description:

When creating a [MENU](Menus.html) with
`COMMAND KEY(`*`keyname`*`) "`*`option`*`"` clause, the button for
*keyname* is no longer displayed:

``` linenumber
01 MAIN
02   MENU "Example"
03     COMMAND "First"
04       EXIT PROGRAM
05     COMMAND KEY (F5) "Second"
06       EXIT PROGRAM
07     COMMAND KEY (F6) -- Third is a hidden option
08       EXIT PROGRAM
09   END MENU
10 END MAIN
```

#### Explanation:

In BDL Version 3, when using the [MENU](Menus.html) instruction, several
buttons are displayed for each clause of the type
`COMMAND KEY(`*`keyname`*`) "`*`option`*`"`: one for the menu option,
and others for each associated key.

When using Genero, for a named [MENU](Menus.html) option defined with
`COMMAND KEY`, the buttons of associated keys are no longer displayed
(F5 in our example), because there is already a button created for the
named menu option. The so called \"hidden menu options\" created by a
`COMMAND KEY(`*`keyname`*`)` clause (F6 in our example) are not
displayed as long as you do not associate a label, for example with the
[FGL_SETKEYLABEL()](BuiltInFunctions.html#BF_FGL_DIALOG_SETKEYLABEL)
function.

------------------------------------------------------------------------

### [FAQ004: Why aren\'t the elements of my forms aligned properly?]{#FAQ004}

#### Description:

In my forms, I used to align labels and fields by character, for typical
terminal display. But now, when using the new [LAYOUT
section](FormSpecFiles.html#SECTION_LAYOUT), some elements are not
aligned as expected. In the following example, the beginning of the
field `f001` is expected in the column near the end of the digit-based
text of the first line, but the field is actually displayed just after
the label \"`Name:`\":

``` linenumber
01 DATABASE FORMONLY
02
03 LAYOUT
04   GRID {
05   01234567890123456789
06    Name:             [f001       ]
07   }
08   END
09 END
10
11 ATTRIBUTES
12 f001 = formonly.field1 TYPE CHAR;
13 END
```

#### Explanation:

By default, Genero BDL displays form elements with proportional fonts,
using layout managers to align these elements inside the window. In some
cases, this requires a review of the content of form screens when using
the new layout management, because the layout is based on new alignment
rules which are more abstract and automatic than the character-based
grids in Version 3.

In most cases, the [form compiler](Tools.html#TL_FGLFORM) is able to
analyze the layout section of [form specification
files](FormSpecFiles.html) in order to produce an acceptable
presentation, but sometimes you will have to touch the form files to
give hints for the alignment of elements.

#### Solution:

In the above example, the field `f001` is aligned according to the label
appearing on the same line. By adding one space before the field
position, the form compiler will understand that the field must be
aligned to the text in the first line:

``` linenumber
01 DATABASE FORMONLY
02
03 LAYOUT
04  GRID {
05  01234567890123456789
06   Name:              [f001       ]
07  }
08  END
09 END
10
11 ATTRIBUTES
12 f001 = formonly.field1 TYPE CHAR;
13 END
```

In the next example, the fields are automatically aligned to the text in
the first line:

``` linenumber
01 DATABASE FORMONLY
02
03 LAYOUT
04  GRID {
05                 First         Last
06    Name:        [f001      ]  [f002       ]
07  }
08  END
09 END
10
11 ATTRIBUTES
12 f001 = formonly.field1 TYPE CHAR;
13 f002 = formonly.field2 TYPE CHAR;
14 END
```

------------------------------------------------------------------------

### [FAQ005: Why doesn\'t the ESC key validate my input?]{#FAQ005}

#### Description:

The traditional 4GL ESC key does not validate an
[INPUT](RecordInput.html), but cancels it instead!

#### Explanation:

To follow front end platform standards (like Microsoft Windows for
example), Genero must reserve the ESC key as the standard key to cancel
the current interactive statement.

#### Solution:

You can change the accelerator keys for the \'accept\' action with
[Action Defaults](ActionDefaults.html). However, is not recommended to
change the defaults, because ESC is the standard key to be used to
cancel a dialog in GUI applications.

------------------------------------------------------------------------

### [FAQ006: Why doesn\'t the CTRL-C key cancel my input?]{#FAQ006}

#### Description:

The traditional 4GL CTRL-C key does not cancel an
[INPUT](RecordInput.html).

#### Explanation:

To follow front end platform standards (like Microsoft Windows for
example), Genero BDL must reserve the CTRL-C key as the standard key to
copy the current selected text to the clipboard, for cut and paste.

#### Solution:

You can change the accelerator keys for the \'cancel\' action with
[Action Defaults](ActionDefaults.html). However, is not recommended to
change the defaults, because ESC is the standard key to be used to
cancel a dialog in GUI applications.

------------------------------------------------------------------------

### [FAQ007: Why do the gui.\* FGLPROFILE entries have no effect?]{#FAQ007}

#### Description:

The `gui.*` and some other [FGLPROFILE](FglProfile.html) entries related
to graphics no longer have effect.

#### Explanation:

These entries are related to the old user interface. They are no longer
supported. In version 3, the `gui.*` entries were interpreted by the
front end. As the user interface has completely been re-designed, the
` gui.*` entries have been removed, too .

#### Solution:

Review the definition of these entries and use the new possibilities of
the [Dynamic User Interface](DynamicUI.html).

  ------------------------------------------------- --------------------------------------------------------------------------------
  **Entry**                                         **Replacement**
  `menu.Style`                                      None, no longer needed.
  `key.`*`key-name`*`.order`                        None, no longer needed.
  `Menu.defKeys`                                    None, no longer needed.
  `InputArray.defKeys`                              None, no longer needed.
  `DisplayArray.defKeys`                            None, no longer needed.
  `Input.defKeys`                                   None, no longer needed.
  `Construct.defKeys`                               None, no longer needed.
  `Prompt.defKeys`                                  None, no longer needed.
  `Sleep.defKeys`                                   None, no longer needed.
  `GetKey.defKeys`                                  None, no longer needed.
  `gui.local.edit.*`                                None, no longer needed.
  `gui.preventClose.message`                        None, *cancel* [action](DynamicUI.html) is sent when the user closes a window.
  `gui.chartable`                                   None, no longer needed.
  `gui.whatch.delay`                                None.
  `gui.useOOB.interrupt`                            None.
  `gui.containerType`                               None.
  `gui.containerName`                               None.
  `gui.mdi.*`                                       None.
  `gui.screen.clientPositioning`                    None.
  `gui.screen.size.*`                               None.
  `gui.screen.x`                                    None.
  `gui.screen.incrx`                                None.
  `gui.screen.y`                                    None.
  `gui.screen.incry`                                None.
  `gui.screen.withwm`                               None.
  `gui.workSpaceFrame.noList`                       None.
  `gui.workSpaceFrame.screenArray.optimalStretch`   None.
  `gui.workSpaceFrame.screenArray.compressed`       None.
  `gui.controlFrame.visible`                        None.
  `gui.controlFrame.position`                       None.
  `gui.controlFrame.scrollVisible`                  None.
  `gui.controlFrame.scroll.*`                       None.
  `gui.bubbleHelp.*`                                None, front end specific.
  `gui.directory.images`                            None, front end specific.
  `gui.toolbar.dir`                                 None, front end specific.
  `gui.toolbar.*`                                   The [new toolbar definition](Toolbars.html).
  `gui.menu.*`                                      None.
  `gui.menuButton.*`                                None.
  `gui.button.*`                                    None.
  `gui.empty.button.visible`                        None.
  `gui.keyButton.*`                                 None, front end specific.
  `gui.key.add_function`                            None.
  `gui.key.interrupt`                               None.
  `gui.key.doubleClick.left`                        None.
  `gui.key.click.right`                             None.
  `gui.key.`*`num`*`.translate`                     None.
  `gui.key.copy`                                    None, front end specific.
  `gui.key.paste`                                   None, front end specific.
  `gui.key.cut`                                     None, front end specific.
  `gui.form.foldertab.*`                            None.
  `gui.key.forldertab.input.sendNextField`          None.
  `gui.key.foldertab.num.selection`                 None.
  `gui.mswindow.button`                             None, front end specific.
  `gui.fieldButton.style`                           None, front end specific.
  `gui.BMPButton.style`                             None, front end specific.
  `gui.key.radiocheck.invokeexit`                   None.
  `gui.entry.style`                                 None, front end specific.
  `gui.interaction.inputarray.usehighlightcolor`    None, front end specific.
  `gui.mswindow.scrollbar`                          None, front end specific.
  `gui.scrollbar.expandwindow`                      None, front end specific.
  `gui.statusbar.*`                                 None, front end specific.
  `gui.display.*`                                   None.
  `gui.user.font.choice`                            None.
                                                    
                                                    
                                                    
  ------------------------------------------------- --------------------------------------------------------------------------------

------------------------------------------------------------------------

### [FAQ008: Why do I get a link error when using the FGL_GETKEY() function?]{#FAQ008}

#### Description:

This function is no longer supported; it has been removed from the
language.

#### Explanation:

That function waited for a key-press from the user, but this kind of
interaction does not fit into the new user interface protocol.

#### Solution:

Review the program and use standard interactive instructions to manage
the interaction with the user.\
See the [Dynamic User Interface concept](DynamicUI.html).

------------------------------------------------------------------------

### [FAQ009: Why do large static arrays raise a stack overflow?]{#FAQ009}

#### Description:

When using very large static arrays (DEFINE a1 ARRAY\[10000\] OF \...),
I get a stack overflow on Windows platforms.

#### Explanation:

The runtime system uses the default stack size defined by the C
compiler. As function static arrays are allocated on the C stack, using
very large static arrays in functions can result in a stack overflow
error. 

#### Solution:

Review the program and use [dynamic arrays](Arrays.html) instead of
static arrays..

------------------------------------------------------------------------

### [FAQ010: Why do I get error -6366 \"Could not load database driver *drivername*\"?]{#FAQ010}

#### Description:

Error **[-6366](FglErrors.html#-6366)** occurs when the runtime system
fails to load the specified database driver.

#### Explanation:

The database driver shared object (.so or . DLL) or a dependent library
could not be found.

#### Solution:

Make sure that the specified driver name does not have a spelling
mistake. If the driver name is correct, there is probably an environment
problem. Make sure that the [database client software is
installed](Installation.html#INST_SR_DBCLIENT) on the system (Genero
does not communicate directly with the database server, you need the
client library). Check the UNIX LD_LIBRARY_PATH environment variable or
the PATH variable on Windows. These must point to the database client
libraries. Another common error is the installation of a database client
software of a different object type as the Genero runtime system. For
example, if you install a 32 bit Genero version, you must install a 32
bit version of the database client software, the 64 bit version will not
work.

------------------------------------------------------------------------

### [FAQ011: Why do I get invalid characters in my form?]{#FAQ011}

#### Description:

The application starts, connects to the database and seams to work
properly, but strange symbols (rectangles, question marks) are displayed
in the forms for non-ASCII characters. The ASCII characters display
properly.

#### Explanation:

The is certainly a character set configuration mistake.

#### Solution:

You have probably defined a wrong - or missed the - runtime system
locale or the database client locale. Read carefully the section
\"[Understanding locale settings](Localization.html#LOCALE_SETTINGS)\"
in the Localization page.
