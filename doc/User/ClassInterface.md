[Back to Contents](../index.html)

------------------------------------------------------------------------

# [The Interface class]{#PAGE_HEADER}

Summary:

- [Syntax](#SYNTAX)
- [Methods](#METHODS)
- [Usage](#USAGE)
- [Examples](#EXAMPLES)
  - [Getting the type and name of the front-end](#EXAMPLE1)
  - [Get the AUI root node and write it to XML file](#EXAMPLE2)
  - [Using the Windows Container Interface](#EXAMPLE3)
  - [Synchronizing the AUI tree with the front-end](#EXAMPLE4)

See also: [Built-in classes](BuiltInClasses.html).

------------------------------------------------------------------------

### [Syntax]{#SYNTAX}

The **Interface** class is a [built-in class](BuiltInClasses.html)
provided to manipulate the [user interface](DynamicUI.html).

#### Syntax:

`ui.Interface`

#### Notes:

1.  This class does not have to be instantiated.

------------------------------------------------------------------------

### [Methods:]{#METHODS}

+-----------------------------------------------------------------------------------------------------------------------------------------+-------------------------------------+
| **Class Methods**                                                                                                                                                             |
+-----------------------------------------------------------------------------------------------------------------------------------------+-------------------------------------+
| **Name**                                                                                                                                | **Description**                     |
+-----------------------------------------------------------------------------------------------------------------------------------------+-------------------------------------+
| ` `[`frontCall`](FrontEndFunctions.html#FRONTCALL)`( module ``STRING``, name `` STRING``, `*`parameter-list`*`, `*`returning-list`*` )` | Calls the front end function *name* |
|                                                                                                                                         | of the module *module*.\            |
|                                                                                                                                         | See [Front End                      |
|                                                                                                                                         | Functions](FrontEndFunctions.html)  |
|                                                                                                                                         | for more details.                   |
+-----------------------------------------------------------------------------------------------------------------------------------------+-------------------------------------+
| [`getDocument`](#getDocument)`()`\                                                                                                      | Returns the [DOM                    |
| `  ``RETURNING` `om.DomDocument`                                                                                                        | document](ClassDomDocument.html)    |
|                                                                                                                                         | owning the [Abstract User Interface |
|                                                                                                                                         | tree](DynamicUI.html).              |
+-----------------------------------------------------------------------------------------------------------------------------------------+-------------------------------------+
| [`getFrontEndName`](#getFrontEndName)`()`\                                                                                              | Returns the type of the front end ( |
| `  ``RETURNING STRING`                                                                                                                  | `'Gdc'`, `'Gwc'`, `'Gjc'`,          |
|                                                                                                                                         | `'Console'` ).                      |
+-----------------------------------------------------------------------------------------------------------------------------------------+-------------------------------------+
| [`getFrontEndVersion`](#getFrontEndVersion)`()`\                                                                                        | Returns the front end version       |
| `  ``RETURNING STRING`                                                                                                                  | string.                             |
+-----------------------------------------------------------------------------------------------------------------------------------------+-------------------------------------+
| [`getRootNode`](#getRootNode)`()`\                                                                                                      | Returns the root [DOM               |
| `  ``RETURNING` `om.DomNode`                                                                                                            | node](ClassDomNode.html) of the     |
|                                                                                                                                         | Abstract User Interface tree.       |
+-----------------------------------------------------------------------------------------------------------------------------------------+-------------------------------------+
| [`loadStartMenu`](StartMenus.html)`( file `` STRING` ` )`                                                                               | [Loads the start                    |
|                                                                                                                                         | menu]{#loadStartMenu} defined in an |
|                                                                                                                                         | XML file into the [AUI              |
|                                                                                                                                         | tree](DynamicUI.html). See          |
|                                                                                                                                         | [StartMenus](StartMenus.html) for   |
|                                                                                                                                         | more details.                       |
+-----------------------------------------------------------------------------------------------------------------------------------------+-------------------------------------+
| [`loadToolBar`](Toolbars.html)`( file `` STRING` ` )`                                                                                   | Loads the toolbar defined in an XML |
|                                                                                                                                         | file into the [AUI                  |
|                                                                                                                                         | tree](DynamicUI.html). See          |
|                                                                                                                                         | [Toolbars](Toolbars.html) for more  |
|                                                                                                                                         | details.                            |
+-----------------------------------------------------------------------------------------------------------------------------------------+-------------------------------------+
| [`loadTopMenu`](Topmenus.html)`( file `` STRING` ` )`                                                                                   | Loads the topmenu defined in an XML |
|                                                                                                                                         | file into the [AUI                  |
|                                                                                                                                         | tree](DynamicUI.html). See          |
|                                                                                                                                         | [TopMenus](Topmenus.html) for more  |
|                                                                                                                                         | details.                            |
+-----------------------------------------------------------------------------------------------------------------------------------------+-------------------------------------+
| [`loadActionDefaults`](ActionDefaults.html)`( file `` STRING`` )`                                                                       | [Loads the                          |
|                                                                                                                                         | default]{#loadActionDefaults}       |
|                                                                                                                                         | decoration for actions from a       |
|                                                                                                                                         | specific XML file into the [AUI     |
|                                                                                                                                         | tree](DynamicUI.html). See [Action  |
|                                                                                                                                         | Defaults](ActionDefaults.html) for  |
|                                                                                                                                         | more details.                       |
+-----------------------------------------------------------------------------------------------------------------------------------------+-------------------------------------+
| [`loadStyles`](PresentationStyles.html)`( file `` STRING` ` )`                                                                          | [Loads styles]{#loadStyles} defined |
|                                                                                                                                         | in an XML file into the [AUI        |
|                                                                                                                                         | tree](DynamicUI.html). See          |
|                                                                                                                                         | [Presentation                       |
|                                                                                                                                         | Styles](PresentationStyles.html)    |
|                                                                                                                                         | for more details.                   |
+-----------------------------------------------------------------------------------------------------------------------------------------+-------------------------------------+
| [`setName`](#setName)`( name ``STRING` `)`                                                                                              | Sets the name to identify the       |
|                                                                                                                                         | program on the front-end.           |
+-----------------------------------------------------------------------------------------------------------------------------------------+-------------------------------------+
| [`getName`](#getName)`()`\                                                                                                              | Returns the identifier of the       |
| `  ``RETURNING STRING`                                                                                                                  | program.                            |
+-----------------------------------------------------------------------------------------------------------------------------------------+-------------------------------------+
| [`setText`](#setText)`( title `` STRING` `)`                                                                                            | Defines a title for the program.    |
+-----------------------------------------------------------------------------------------------------------------------------------------+-------------------------------------+
| [`getText`](#getText)`()`\                                                                                                              | Returns the title of the program.   |
| `  ``RETURNING STRING`                                                                                                                  |                                     |
+-----------------------------------------------------------------------------------------------------------------------------------------+-------------------------------------+
| [`setImage`](#setImage)`( name ``STRING` `)`                                                                                            | Sets the name of the icon to be     |
|                                                                                                                                         | used for this program.              |
+-----------------------------------------------------------------------------------------------------------------------------------------+-------------------------------------+
| [`getImage`](#getImage)`()`\                                                                                                            | Returns the name of the icon.       |
| `  ``RETURNING STRING`                                                                                                                  |                                     |
+-----------------------------------------------------------------------------------------------------------------------------------------+-------------------------------------+
| [`setType`](#setType)`( type `` STRING` `)`                                                                                             | Defines the type of program.        |
+-----------------------------------------------------------------------------------------------------------------------------------------+-------------------------------------+
| [`getType`](#getType)`()`\                                                                                                              | Returns the type of the program.    |
| `  ``RETURNING STRING`                                                                                                                  |                                     |
+-----------------------------------------------------------------------------------------------------------------------------------------+-------------------------------------+
| [`setSize`](#setSize)`( height `` STRING``, width `` STRING` `)`                                                                        | Defines the initial size of the     |
|                                                                                                                                         | main window when using the          |
|                                                                                                                                         | traditional mode or when            |
|                                                                                                                                         | configuring a WCI container.        |
+-----------------------------------------------------------------------------------------------------------------------------------------+-------------------------------------+
| [`setContainer`](#setContainer)`( name ``STRING`` )`                                                                                    | Defines the name of the parent      |
|                                                                                                                                         | container of this program.          |
+-----------------------------------------------------------------------------------------------------------------------------------------+-------------------------------------+
| [`getContainer`](#getContainer)`()`\                                                                                                    | Returns the name of the parent      |
| `  ``RETURNING STRING`                                                                                                                  | container of this program.          |
+-----------------------------------------------------------------------------------------------------------------------------------------+-------------------------------------+
| [`getChildCount`](#getChildCount)`()`\                                                                                                  | Returns the number of children in   |
| `  ``RETURNING INTEGER`                                                                                                                 | this container.                     |
+-----------------------------------------------------------------------------------------------------------------------------------------+-------------------------------------+
| [`getChildInstances`](#getChildInstances)`( name ``STRING ``)`\                                                                         | Returns the number of children      |
| `  ``RETURNING INTEGER`                                                                                                                 | identified by *name*.               |
+-----------------------------------------------------------------------------------------------------------------------------------------+-------------------------------------+
| [`refresh`](#refresh)`()`                                                                                                               | Synchronizes the front end with the |
|                                                                                                                                         | current [AUI tree](DynamicUI.html). |
+-----------------------------------------------------------------------------------------------------------------------------------------+-------------------------------------+

------------------------------------------------------------------------

### [Usage]{#USAGE}

#### [Getting the root DOM document]{#getDocument}

The `ui.Interface.getDocument()` class method returns the
[DomDocument](ClassDomDocument.html) object of the [Abstract user
Interface](DynamicUI.html) tree.

#### [Getting the current front-end identifier]{#getFrontEndName}

The `ui.Interface.getFrontEndName()` class method returns the type of
the front-end used by the application. This is mainly provided for
debugging purposes.

#### [Getting the current front-end version]{#getFrontEndVersion}

The `ui.Interface.getFrontEndVersion()` class method returns the version
number of the front-end used by the application. This is mainly provided
for debugging purposes.

#### [Getting the root node of the DOM document]{#getRootNode}

The `ui.Interface.getRootNode()` class method returns the root
[DomNode](ClassDomNode.html) of the [Abstract user
Interface](DynamicUI.html) tree.

#### [Defining the name of the application]{#setName}

The `ui.Interface.setName()` class method can be used to identify the
application on the front-end. For example, this name is used in [MDI
configuration](MDIWindows.html).

#### [Getting the name of the application]{#getName}

Use the `ui.Interface.getName()` class method to get the name of the
application previously set by `setName()`.

#### [Defining the title of the application]{#setText}

The `ui.Interface.setText()` class method can be used to define a main
title for the application on the front-end. This title is displayed in
the main Window.

#### [Getting the title of the application]{#getText}

Use the `ui.Interface.getText()` class method to get the title of the
application previously set by `setText()`.

#### [Defining the icon of the application]{#setImage}

The `ui.Interface.setImage()` class method can be used to define the
icon of the application on the front-end. This icon will be used in
taskbars, for example.

#### [Getting the icon of the application]{#getImage}

Use the `ui.Interface.getImage()` class method to get the image name of
the application previously set by `setImage()`.

#### [Defining the type of the application]{#setType}

The `ui.Interface.setType()` class method can be used to define the type
of the application, typically used in [MDI
configurations](MDIWindows.html).

Possible values can be `'normal'`, `'container'` or `'child'`.

#### [Getting the type of the application]{#getType}

Use the `ui.Interface.getType()` class method to get the type of the
application, previously set by `setType()`.

#### [Specify the initial size of the parent container window]{#setSize}

The `ui.Interface.setSize(height,width)` class method can be used to
define the initial size of the parent container window of an MDI
application. The parameters can be integer or string values. By default
the unit is the character grid cells, but you can add the **px** unit to
specify the height and width in pixels.

The `setSize()` method can also be used to configure the size of the
main window when using [traditional
mode](DynamicUI.html#TRADITIONAL_MODE), as a replacement of
[fgl_setsize()](BuiltInFunctions.html#BF_FGL_SETSIZE) built-in function.

See also [MDI configuration](MDIWindows.html).

#### [Defining the parent container of the application]{#setContainer}

The parent container can be specified with the
`ui.Interface.setContainer()` class method, typically used in [MDI
configurations](MDIWindows.html).

#### [Getting the parent container of the application]{#getContainer}

Use the  `ui.Interface.getContainer()` method to get the name of the
parent container of the application.

#### [Getting the number of children in a parent container]{#getChildCount}

Use the `ui.Interface.getChildCount()` class method to get the current
number of child applications in this parent WCI.

See also [MDI configuration](MDIWindows.html).

#### [Getting the number of child instances for a given application name]{#getChildInstances}

If you need to known how many child instances of the same application
are started in the current WCI container,  call the
`ui.Interface.getChildInstances()` class method. This method takes the
application name as a parameter (the one defined with
[setName()](#setName))

See also [MDI configuration](MDIWindows.html).

#### [Refreshing the user interface]{#refresh}

Use the ` ui.Interface.refresh()` class method to synchronize the
server-side AUI tree with the frond-end AUI tree. For more details, see
[\"When is the front-end synchronized?\"](DynamicUI.html#FE_SYNC).

------------------------------------------------------------------------

### [Examples]{#EXAMPLES}

#### [Example 1]{#EXAMPLE1}: Get the type and version of the front end.

``` linenumber
01 MAIN
02   MENU "Test"
03     COMMAND "Get"
04       DISPLAY "Name = " || ui.Interface.getFrontEndName()
05       DISPLAY "Version = " || ui.Interface.getFrontEndVersion()
06     COMMAND "Exit"
07       EXIT MENU
08   END MENU
09 END MAIN
```

#### [Example 2]{#EXAMPLE2}: Get the AUI root node and save it to a file in XML format.

``` linenumber
01 MAIN
02   DEFINE n om.DomNode
03   MENU "Test"
04     COMMAND "SaveUI"
05       LET n = ui.Interface.getRootNode()
06       CALL n.writeXml("auitree.xml")
07     COMMAND "Exit"
08       EXIT MENU
09   END MENU
10 END MAIN
```

#### [Example 3]{#EXAMPLE3}: Using the Window Container Interface

The WCI parent program:

``` linenumber
01 MAIN
02   CALL ui.Interface.setName("main1")
03   CALL ui.Interface.setText("This is the MDI container")
04   CALL ui.Interface.setType("container")
05   CALL ui.Interface.setSize("600px","600px")
06   CALL ui.Interface.loadStartMenu("appmenu")
07   MENU "Main"
08     COMMAND "Help" CALL help()
09     COMMAND "About" CALL aboutbox()
10     COMMAND "Exit"
11       IF ui.Interface.getChildCount()>0 THEN
12          ERROR "You must first exit the child programs."
13       ELSE
14          EXIT MENU
15       END IF
16   END MENU
17 END MAIN
```

The WCI child program:

``` linenumber
01 MAIN
02   CALL ui.Interface.setName("prog1")
03   CALL ui.Interface.setText("This is module 1")
04   CALL ui.Interface.setType("child")
05   CALL ui.Interface.setContainer("main1")
06   MENU "Test"
07     COMMAND "Exit"
08       EXIT MENU
09   END MENU
10 END MAIN
```

#### [Example 4]{#EXAMPLE4}: Synchronizing the AUI tree with the front end.

``` linenumber
01 MAIN
02   DEFINE cnt INTEGER
03   OPEN WINDOW w WITH FORM "myform"
04   FOR cnt=1 TO 10
05     DISPLAY BY NAME cnt
06     CALL ui.Interface.refresh()
07     SLEEP 1
08   END FOR
09 END MAIN
```
