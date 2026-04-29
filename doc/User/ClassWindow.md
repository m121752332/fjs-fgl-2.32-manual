[Back to Contents](../index.html)

------------------------------------------------------------------------

# [The Window class]{#PAGE_HEADER}

Summary:

- [Syntax](#SYNTAX)
- [Methods](#METHODS)
- [Usage](#USAGE)
  - [Getting a window by name](#forName)
  - [Getting the current window](#getCurrent)
  - [Getting the current form of a window](#getForm)
  - [Getting the DOM node of a window](#getNode)
  - [Search for a specific element in a window](#findNode)
  - [Create a new empty form in a window](#createForm)
  - [Setting the window title](#setText)
  - [Getting the window title](#getText)
  - [Setting the window icon](#setImage)
  - [Getting the window icon](#getImage)
- [Examples](#EXAMPLES)

See also: [Built-in classes](BuiltInClasses.html), [Windows and
Forms](WindowsAndForms.html), [Form Class](ClassForm.html)

------------------------------------------------------------------------

### [Syntax]{#SYNTAX}

The **Window** class is a [built-in class](BuiltInClasses.html)
providing an interface to the window objects.

#### Syntax:

`ui.Window`

------------------------------------------------------------------------

### [Methods:]{#METHODS}

+----------------------------------------------------------+-------------------------------------+
| **Class Methods**                                                                              |
+----------------------------------------------------------+-------------------------------------+
| **Name**                                                 | **Description**                     |
+----------------------------------------------------------+-------------------------------------+
| [`forName`](#forName)`( name ``STRING`` )`\              | Returns a Window object according   |
| `  ``RETURNING` `ui.Window`                              | to the name used in an [OPEN        |
|                                                          | WINDOW](WindowsAndForms.html)       |
|                                                          | statement.                          |
+----------------------------------------------------------+-------------------------------------+
| [`getCurrent`](#getCurrent)`( )`\                        | Returns a Window object referencing |
| `  ``RETURNING` `ui.Window`                              | the [current                        |
|                                                          | window](WindowsAndForms.html).      |
+----------------------------------------------------------+-------------------------------------+
| **Object Methods**                                                                             |
+----------------------------------------------------------+-------------------------------------+
| **Name**                                                 | **Description**                     |
+----------------------------------------------------------+-------------------------------------+
| [`findNode`](#findNode)`( t ``STRING``, n ``STRING`` )`\ | Returns the first descendant DOM    |
| `  ``RETURNING` `om.DomNode`                             | node of type *t* and matching the   |
|                                                          | name *n* in the abstract            |
|                                                          | representation of this form object. |
+----------------------------------------------------------+-------------------------------------+
| [`createForm`](#createForm)`( n ``STRING`` )`\           | Creates an empty form and returns   |
| `  ``RETURNING` `ui.Form`                                | the new [Form](ClassForm.html)      |
|                                                          | object.                             |
+----------------------------------------------------------+-------------------------------------+
| [`getForm`](#getForm)`( )`\                              | Returns a [Form](ClassForm.html)    |
| `  ``RETURNING` `ui.Form`                                | object to handle the current form.  |
+----------------------------------------------------------+-------------------------------------+
| [`getNode`](#getNode)`( )`\                              | Returns the DOM representation of   |
| `  ``RETURNING` `om.DomNode`                             | this Window.                        |
+----------------------------------------------------------+-------------------------------------+
| [`setText`](#setText)`( t ``STRING`` )`                  | Sets the title of this window       |
|                                                          | object.                             |
+----------------------------------------------------------+-------------------------------------+
| [`getText`](#getText)`( )`\                              | Returns the title of this window    |
| `  ``RETURNING STRING`                                   | object.                             |
+----------------------------------------------------------+-------------------------------------+
| [`setImage`](#setImage)`( n ``STRING`` )`                | Sets the image for the icon of this |
|                                                          | window object.                      |
+----------------------------------------------------------+-------------------------------------+
| [`getImage`](#getImage)`( )`\                            | Returns the icon image of this      |
| `  ``RETURNING STRING`                                   | window object.                      |
+----------------------------------------------------------+-------------------------------------+

------------------------------------------------------------------------

### [Usage:]{#USAGE}

Windows are created with the [OPEN WINDOW](WindowsAndForms.html)
instruction, identifying the window by a static handle:

``` linenumber
01 OPEN WINDOW w1 WITH FORM "customer"
```

#### [Getting a window object by name]{#forName}

You can get the window object corresponding to an identifier used in
OPEN WINDOW with the `ui.Window.forName()` class method. You must
declare a variable of type `ui.Window` to hold the window object
reference:

``` linenumber
01 DEFINE w ui.Window
02 LET w = ui.Window.forName("w1")
```

#### [Getting the current window object]{#getCurrent}

The `ui.Window.getCurrent()` class method returns a window object
corresponding to the [current window](WindowsAndForms.html). You must
declare a variable of type `ui.Window` to hold the window object
reference:

``` linenumber
01 DEFINE w ui.Window
02 LET w = ui.Window.getCurrent()
```

#### [Getting the current form of a window]{#getForm}

You can get a [ui.Form](ClassForm.html) instance of the current form
with the `getForm()` method. This allows you to manipulate form elements
by program. You can, for example, hide some parts of a form with
[setElementHidden()](ClassForm.html#setElementHidden).

#### [Getting the DOM node of a window]{#getNode}

The `getNode()` method returns the DOM node containing the abstract
representation of the window.

#### [Search for a specific element in the window]{#findNode}

The `findNode()` method allows you to search for a specific DOM node in
the abstract representation of the window content (i.e. the form). You
search for a child node by giving its type and the name of the element
(i.e. the tagname and the value of the \'name\' attribute).

#### [Create a new empty form in a window]{#createForm}

The `createForm()` method can be used to create a new empty form. The
method returns a new [ui.Form](ClassForm.html) instance or
[NULL](Programs.html#PC_NULL) if the form name passed as the parameter
identifies an existing form used by the window.

#### [Setting the window title]{#setText}

Use the `setText()` method to define the title of the window. By
default, the title of a window is defined by the
[TEXT](FSFAttributes.html#FA_TEXT) attribute of the
[LAYOUT](FormSpecFiles.html#SECTION_LAYOUT) definition in form files.

#### [Getting the window title]{#getText}

The `getText()` method can be used to get the current title of a window.

#### [Setting the window icon]{#setImage}

Use the `setImage()` method to define the image to be used for the icon
of the window. By default, the icon image of a window is defined by the
[IMAGE](FSFAttributes.html#FA_IMAGE) attribute of the
[LAYOUT](FormSpecFiles.html#SECTION_LAYOUT) definition in form files.

#### [Getting the window icon]{#getImage}

The `getImage()` method can be used to get the current icon image of a
window.

------------------------------------------------------------------------

### [Examples]{#EXAMPLES}

#### Example 1: Get a window by name and change the title.

``` linenumber
01 MAIN
02    DEFINE w ui.Window
03    OPEN WINDOW w1 WITH FORM "customer" ATTRIBUTE(TEXT="Unknown")
04    LET w = ui.Window.forName("w1")
05    IF w IS NULL THEN EXIT PROGRAM 1 END IF
06    CALL w.setText("Customer")
07    MENU "Test"
08       COMMAND "exit" EXIT MENU
09    END MENU
10    CLOSE WINDOW w1
11 END MAIN
```

#### Example 2: Get a the current form and hide a groupbox.

``` linenumber
01 MAIN
02    DEFINE w ui.Window
03    DEFINE f ui.Form
04    OPEN WINDOW w1 WITH FORM "customer"
05    LET w = ui.Window.getCurrent()
06    IF w IS NULL THEN EXIT PROGRAM 1 END IF
07    LET f = w.getForm()
08    MENU "Test"
09       COMMAND "hide" CALL f.setElementHidden("gb1",1)
10       COMMAND "exit" EXIT MENU
11    END MENU
12    CLOSE WINDOW w1
13 END MAIN
```
