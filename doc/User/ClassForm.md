[Back to Contents](../index.html)

------------------------------------------------------------------------

# [The Form class]{#PAGE_HEADER}

Summary:

- [Syntax](#SYNTAX)
- [Methods](#METHODS)
- [Usage](#USAGE)
  - [Defining the default initializer for all
    forms](#setDefaultInitializer)
  - [Getting the DOM node of the form](#getNode)
  - [Loading Action Defaults form the form](#loadActionDefaults)
  - [Loading the form ToolBar](#loadToolBar)
  - [Loading the form TopMenu](#loadTopMenu)
  - [Searching for a specific child node in the form](#findNode)
  - [Changing the text of form elements](#setElementText)
  - [Changing the image of form elements](#setElementImage)
  - [Changing the style of form elements](#setElementStyle)
  - [Hiding or showing form elements](#setElementHidden)
  - [Hiding or showing a form field](#setFieldHidden)
  - [Changing the style of a form field](#setFieldStyle)
  - [Ensure the visibility of a form field](#ensureFieldVisible)
  - [Ensure the visibility of a form element](#ensureElementVisible)
- [Examples](#EXAMPLES)
  - [Example 1: Implement a global form initialization
    function](#EXAMPLE_1)
  - [Example 2: Hiding form elements dynamically](#EXAMPLE_2)

See also: [Built-in classes](BuiltInClasses.html), [Window
class](ClassWindow.html), [Windows and Forms](WindowsAndForms.html)

------------------------------------------------------------------------

### [Syntax]{#SYNTAX}

The **Form** class is a [built-in class](BuiltInClasses.html) that
provides an interface to the [forms](WindowsAndForms.html) used by the
program.

#### Syntax:

`ui.Form`

------------------------------------------------------------------------

### [Methods:]{#METHODS}

+-----------------------------------------------------------------------------+-------------------------------------+
| **Class Methods**                                                                                                 |
+-----------------------------------------------------------------------------+-------------------------------------+
| **Name**                                                                    | **Description**                     |
+-----------------------------------------------------------------------------+-------------------------------------+
| [`setDefaultInitializer`](#setDefaultInitializer)`( fn ``STRING`` )`        | Defines the default initialization  |
|                                                                             | function for all forms used by the  |
|                                                                             | program. The function gets a        |
|                                                                             | `ui.Form` object as parameter.      |
+-----------------------------------------------------------------------------+-------------------------------------+
| **Object Methods**                                                                                                |
+-----------------------------------------------------------------------------+-------------------------------------+
| **Name**                                                                    | **Description**                     |
+-----------------------------------------------------------------------------+-------------------------------------+
| [`ensureFieldVisible`](#ensureFieldVisible)`( name ``STRING`` )`            | Adapts the current form to make a   |
|                                                                             | field visible.                      |
+-----------------------------------------------------------------------------+-------------------------------------+
| [`ensureElementVisible`](#ensureElementVisible)`( name ``STRING`` )`        | Adapts the current form to make a   |
|                                                                             | form element visible.               |
+-----------------------------------------------------------------------------+-------------------------------------+
| [`findNode`](#findNode)`( t ``STRING``, n ``STRING`` )`\                    | Returns the first descendant DOM    |
| `  ``RETURNING` `om.DomNode`                                                | node of type *t* and matching the   |
|                                                                             | name *n* in the abstract            |
|                                                                             | representation of this window       |
|                                                                             | object.                             |
+-----------------------------------------------------------------------------+-------------------------------------+
| [`getNode`](#getNode)`( )`\                                                 | Returns the DOM representation of   |
| `  ``RETURNING` `om.DomNode`                                                | this Form.                          |
+-----------------------------------------------------------------------------+-------------------------------------+
| [`loadActionDefaults`](#loadActionDefaults)`( fn `` STRING`` )`             | Loads the decoration for actions    |
|                                                                             | from a specific XML file into the   |
|                                                                             | [AUI tree](DynamicUI.html). These   |
|                                                                             | action defaults are local to the    |
|                                                                             | form and take precedence over       |
|                                                                             | action defaults defined at the      |
|                                                                             | Interface level. See [Action        |
|                                                                             | Defaults](ActionDefaults.html) for  |
|                                                                             | more details.                       |
+-----------------------------------------------------------------------------+-------------------------------------+
| [`loadToolBar`](#loadToolBar)`( fn ``STRING`` )`                            | Loads a [Toolbar](Toolbars.html)    |
|                                                                             | XML definition into this Form,      |
|                                                                             | where *fn* is the name of the file, |
|                                                                             | without extension. If a toolbar     |
|                                                                             | exists already in the form, it is   |
|                                                                             | replaced.                           |
+-----------------------------------------------------------------------------+-------------------------------------+
| [`loadTopMenu`](#loadTopMenu)`( fn ``STRING`` )`                            | Loads a [Topmenu](Topmenus.html)    |
|                                                                             | XML definition into this Form,      |
|                                                                             | where *fn* is the name of the file, |
|                                                                             | without extension. If a topmenu     |
|                                                                             | exists already in the form, it is   |
|                                                                             | replaced.                           |
+-----------------------------------------------------------------------------+-------------------------------------+
| [`setElementHidden`](#setElementHidden)`( name ``STRING``, v ``INTEGER`` )` | Changes the \'hidden\' attribute of |
|                                                                             | all elements identified by *name*.  |
|                                                                             | Values of *v* can be 0,1 or 2.      |
+-----------------------------------------------------------------------------+-------------------------------------+
| [`setElementText`](#setElementText)`( name ``STRING``, v ``STRING`` )`      | Changes the \'text\' attribute of   |
|                                                                             | all elements identified by *name*.  |
+-----------------------------------------------------------------------------+-------------------------------------+
| [`setElementImage`](#setElementImage)`( name ``STRING``, v ``STRING`` )`    | Changes the \'image\' attribute of  |
|                                                                             | all elements identified by *name*.  |
+-----------------------------------------------------------------------------+-------------------------------------+
| [`setElementStyle`](#setElementStyle)`( name ``STRING``, v ``STRING`` )`    | Changes the \'style\' attribute of  |
|                                                                             | all elements identified by *name*.  |
+-----------------------------------------------------------------------------+-------------------------------------+
| [`setFieldHidden`](#setFieldHidden)`( name ``STRING``, v ``INTEGER`` )`     | Changes the \'hidden\' attribute of |
|                                                                             | a form field identified by *name*.  |
|                                                                             | The *name* is a string containing   |
|                                                                             | the field qualifier, with an        |
|                                                                             | optional prefix                     |
|                                                                             | (\"`[table.]column`\"). Values of   |
|                                                                             | *v* can be 0,1 or 2.                |
+-----------------------------------------------------------------------------+-------------------------------------+
| [`setFieldStyle`](#setFieldStyle)`( name ``STRING``, v ``STRING`` )`        | Changes the \'style\' attribute of  |
|                                                                             | the view of a form field identified |
|                                                                             | by *name*. The *name* is a string   |
|                                                                             | containing the field qualifier,     |
|                                                                             | with an optional prefix             |
|                                                                             | (\"`[table.]column`\").             |
+-----------------------------------------------------------------------------+-------------------------------------+

------------------------------------------------------------------------

### [Usage:]{#USAGE}

The Form class provides an interface to form objects created by an [OPEN
WINDOW WITH FORM](WindowsAndForms.html#OPEN_WINDOW) or [DISPLAY
FORM](WindowsAndForms.html#DISPLAY_FORM) instruction.

A form object allows you to manipulate form elements by program,
typically to hide some parts of a form with the `setElementHidden()`
method. The runtime system is able to handle hidden fields during a
dialog instruction. You can, for example, hide a GRO containing fields
and labels.

You can get a [ui.Form](ClassForm.html) instance of the current form
with the [ui.Window.getForm()](ClassWindow.html) method.

**Warning:** The [OPEN FORM](WindowsAndForms.html#OPEN_FORM) instruction
does not create a `ui.Form` object; it just declares a handle. It is
actually the [DISPLAY FORM](WindowsAndForms.html#DISPLAY_FORM)
instruction that instantiates a `ui.Form` object that will be attached
to the [current window](WindowsAndForms.html). When a form is displayed
with [DISPLAY FORM](WindowsAndForms.html#DISPLAY_FORM) in different
windows, the same [form specification file](FormSpecFiles.html) will be
used to create different `ui.Form` objects. 

#### [Defining the default initializer for all forms]{#setDefaultInitializer}

With the `setDefaultInitializer()` method, you can specify a default
initialization function to implement global processing when a form is
opened. The method takes the name of the initialization function as a
parameter. That function will be called with a `ui.Form` object as a
parameter. 

**Warning:** You must give the initialization function name in
lower-case letters to the `setDefaultInitializer()` method. The BDL
syntax allows case-insensitive functions names, but the runtime system
must reference functions in lower-case letters internally.

#### [Getting the DOM node of the form]{#getNode}

The `getNode()` method returns the DOM node containing the abstract
representation of the window.

#### [Loading Action Defaults for the form]{#loadActionDefaults}

You may want to load form specific [Action
Defaults](ActionDefaults.html) at runtime with the
`loadActionDefaults()` method. This method takes the file name as
parameter without the **.4ad** suffix. Existing action defaults will be
replaced.

#### [Loading the form ToolBar]{#loadToolBar}

The `loadToolBar()` method can be used to load a
[Toolbar](Toolbars.html) XML definition file into the form; for example,
in the initialization function. If the form already contains a toolbar,
it will be replaced by the new toolbar loaded from this function.

#### [Loading the form TopMenu]{#loadTopMenu}

The `loadTopMenu()` method can be used to load a
[Topmenu](Topmenus.html) XML definition file into the form; for example,
in the initialization function. If the form alreadycontains a topmenu,
it will be replaced by the new topmenu loaded by this function.

#### [Searching for a specific child node in the form]{#findNode}

The `findNode()` method allows you to search for a specific DOM node in
the abstract representation of the form. You search for a child node by
giving its type and the name of the element (i.e. the tagname and the
value of the \'name\' attribute).

#### [Changing the text of form elements]{#setElementText}

You may want to modify the text of a static label or group box during
program execution. This can be done with the `setElementText()` method.
You must pass the identifier of the form element (i.e. the element must
have a name in the **.per** file).

Note that all elements with this name will be affected.

#### [Changing the image of form elements]{#setElementImage}

The image of a form element can be changed with the `setElementImage()`
method. You must pass the identifier of the form element (i.e. the
element must have a name in the **.per** file).

Note that all elements with this name will be affected.

#### [Changing the style of form elements]{#setElementStyle}

To change the decoration style of a form element, you can use the
`setElementStyle()` method, by passing the identifier of the form
element (i.e. the element must have a name in the **.per** file).

Note that all elements with this name will be affected.

#### [Hiding or showing form elements]{#setElementHidden}

The `setElementHidden()` method changes the \'hidden\' attribute of all
form elements identified by a name.

You specify an integer value for the \'hidden\' attribute as follows:

  ------------------ ---------------------------------------------------------------------------------------------------------------------------------------------
   **Hidden Value**  **Description**
         `0`         The element is visible.
         `1`         The element is hidden and the user [cannot]{.underline} make it visible, typically used to hide information the user is not allowed to see.
         `2`         The element is hidden and the user can make it visible.
  ------------------ ---------------------------------------------------------------------------------------------------------------------------------------------

Note that you should not hide all fields of a dialog, otherwise the
dialog execution stops (at least one field must get the focus during a
dialog execution).

#### [Hiding or showing a form field]{#setFieldHidden}

You can use the `setFieldHidden()` method to change the \'hidden\'
attribute of a form field.

Form fields are identified by a fully qualified field name in lower case
letters (`"table.column"` or `"formonly.field"`).

 You specify an integer value for the \'hidden\' attribute as follows:

  ------------------ ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   **Hidden Value**  **Description**
         `0`         The field is visible.
         `1`         The field is hidden and the user [cannot]{.underline} make it visible, typically used to hide information the user is not allowed to see.
         `2`         The field is hidden and the user can make it visible (for example with a contextual menu, as in tables). This allows you to define columns that are hidden by default, but can be shown by the user.
  ------------------ ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#### [Changing the style of a form field]{#setFieldStyle}

To change the style of the view node of a form field, you must use the
`setFieldStyle()` method.

The form field is identified by a name with an optional prefix
(`"table.column"` or `"column"`).

#### [Ensure the visibility of a form field]{#ensureFieldVisible}

The `ensureFieldVisible()` method can be used to make sure that the
given form field is visible to the user. This method can for example be
used to show a folder page by passing a field that is located in the
folder page, even if the field is not used in a dialog.

The form field is identified by a name with an optional prefix
(`"table.column"` or `"column"`).

Understand that this method does not give the focus to the field passed
as parameter. The folder page or screen area shown by this method call
is temporarily visible and can disappear at the next user interaction,
resulting in the field being no longer visible. For example, with a
folder having two pages, if the focus is in a field of the first page,
and you make the second page visible with a call to the
`ensureFieldVisible()` method by passing a field located in the second
page, when the user presses the TAB key, the focus will go to the next
field in the first page and thus bring the first page to the top. If you
want to show a folder page and give the focus to a specific field in
that page, use [NEXT FIELD](MultipleDialogs.html#NEXT_FIELD) instead.

#### [Ensure the visibility of a form element]{#ensureElementVisible}

The `ensureElementVisible()` method is similar to
[ensureFieldVisible()](#ensureFieldVisible), except that it is designed
to make any kind of form element visible, even if it\'s not a form
field, such as a [static label](FormSpecFiles.html#FF_ITEMTYPE_LABEL) or
[static image](FormSpecFiles.html#FF_ITEMTYPE_IMAGE).

The form element is identified by its name. As several form elements can
have the same name, the first form element found will be selected. 

------------------------------------------------------------------------

### [Examples]{#EXAMPLES}

#### [Example 1: Implement a global form initialization function.]{#EXAMPLE_1}

``` linenumber
01 MAIN
02    CALL ui.Form.setDefaultInitializer("init")
03    OPEN FORM f1 FROM "items"
04    DISPLAY FORM f1 -- Form appears in the default SCREEN window
05    OPEN WINDOW w1 WITH FORM "customer"
06    OPEN WINDOW w2 WITH FORM "orders"
07    DISPLAY FORM f1 -- Form appears in w2 window
08    MENU "Test"
09       COMMAND "exit" EXIT MENU
10    END MENU
11 END MAIN
12 
13 FUNCTION init(f)
14    DEFINE f ui.Form
15    DEFINE n om.DomNode
16    CALL f.loadTopMenu("mymenu")
17    LET n = f.getNode()
18    DISPLAY "Init: ", n.getAttribute("name")
19 END FUNCTION
```

#### [Example 2: Hiding form elements dynamically.]{#EXAMPLE_2}

``` linenumber
01 MAIN
02    DEFINE w ui.Window
03    DEFINE f ui.Form
04    DEFINE custid INTEGER
05    DEFINE custname CHAR(10)
06    OPEN WINDOW w1 WITH FORM "customer"
07    LET w = ui.Window.getCurrent()
08    LET f = w.getForm()
09    INPUT BY NAME custid, custname
10      ON ACTION hide
11        CALL f.setFieldHidden("customer.custid",1)
12        CALL f.setElementHidden("label_custid",1)
13      ON ACTION show
14        CALL f.setFieldHidden("customer.custid",0)
15        CALL f.setElementHidden("label_custid",0)
16    END INPUT
17 END MAIN
```
