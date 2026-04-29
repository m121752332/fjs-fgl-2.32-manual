[Back to Contents](../index.html)

------------------------------------------------------------------------

# [Toolbars]{#PAGE_HEADER}

Summary:

- [Basics](#BASICS)
- [Syntax](#SYNTAX)
- [Usage](#USAGE)
  - [Defining ToolBars](#DEFINING)
  - [Toolbar structure](#STRUCT)
  - [Defining a Toolbar in form file](#FORMSECTION)
  - [Loading a Toolbar from a file](#LOADFORM)
  - [Loading the default Toolbar from a file](#LOADDEFAULT)
  - [Creating a Toolbar dynamically](#DYNAMIC)
- [Examples](#EXAMPLES)
  - [Simple Toolbar in XML format](#EXAMPLE_1)
  - [Program creating a Toolbar dynamically](#EXAMPLE_2)
  - [Toolbar definition in a PER file](#EXAMPLE_3)

*See also:* [Action Defaults](ActionDefaults.html),
[Topmenus](Topmenus.html), [Form Specification
Files](FormSpecFiles.html)

------------------------------------------------------------------------

### [Basics]{#BASICS}

A [Toolbar]{#ToolBar} is a [view for actions](InteractionModel.html)
presented as a set of buttons that can trigger events in an interactive
instruction. This page describes how to use toolbars in programs; it is
also possible to define toolbars in forms with the [TOOLBAR
section](FormSpecFiles.html#SECTION_TOOLBAR).

------------------------------------------------------------------------

### [Syntax]{#SYNTAX}

`<ToolBar `[`[`]{.underline}` `*`toolbar-attribute`*`="`*`value"`*` `[`[...]`]{.underline}` `[`]`]{.underline}` >`\
`  `[`{`]{.underline}` <ToolBarSeparator `*`separator-attribute`*`="`*`value"`*` `[`[...]`]{.underline}` />`\
`  `[`|`]{.underline}` <ToolBarItem `*`item-attribute`*`="`*`value"`*` `[`[...]`]{.underline}` />`\
`  `[`}`]{.underline}` `[`[...]`]{.underline}\
`</ToolBar>`

#### Notes:

1.  *toolbar-attribute* defines a property of the toolbar.
2.  *item-attribute* defines a property of the toolbar item.

#### Warnings:

1.  The DOM tag names are case sensitive; `Toolbar` is different from
    `ToolBar`.
2.  When binding to an action, make sure that you are using the right
    value in the `name` attribute. As `ON ACTION` and `COMMAND` generate
    lowercase identifiers, it is recommended to use **lowercase**
    `names`.
3.  When binding to a key, make sure the `name` attribute value is in
    lowercase letters (\"`f5`\").
4.  Make sure that the image file is available to the Front End.

#### Tips:

1.  It is recommended that you define the decoration of a Toolbar item
    for common actions with [Action Defaults](ActionDefaults.html).

------------------------------------------------------------------------

### **[Usage]{#USAGE}**

#### **[Defining Toolbars]{#DEFINING}**

You can define a global/default toolbar at the program level, or you can
define form-specific toolbars. The global toolbar is displayed by
default in all windows, or in the global window container when using
[MDI](MDIWindows.html). The form-specific toolbar is displayed in the
form where it is defined. You can control the position and visibility of
toolbars with a [window style
attribute](WindowsAndForms.html#WINDOW_STYLES). Typical \"modal
windows\" do not display toolbars.

The Toolbar items (or buttons) are enabled according to the
[actions](InteractionModel.html) defined by the current interactive
instruction, which can be [MENU](Menus.html), [INPUT](RecordInput.html),
[INPUT ARRAY](InputArray.html), [DISPLAY ARRAY](DisplayArray.html), or
[CONSTRUCT](Construct.html). The action trigger bound to a Toolbar
button is executed when the button is clicked.

A Toolbar item is bound to an *action node* of the current interactive
instruction if its `name` attribute corresponds to an *action node* name
(typically, the name of a ring menu option). A click on the Toolbar
button has the same effect as raising the action. For example, if the
current interactive instruction is a ring menu, this would have the same
effect as selecting the ring menu option.

A Toolbar item is bound to a key trigger if the `name` attribute of the
item corresponds to a valid hot key, [in lowercase letters]{.underline}.
In this case, a click on the Toolbar button has the same effect as
pressing the hot key.

A Toolbar button is automatically disabled if the corresponding action
is not available (for example, when a ring menu option is hidden).

Toolbar elements can get a `style` attribute in order to use a specific
rendering/decoration following [Presentation
Style](PresentationStyles.html) definitions.

------------------------------------------------------------------------

**[Toolbar Structure]{#STRUCT}**

The following table shows the list of *toolbar-attributes* supported for
the `ToolBar` node:

::: {align="center"}
  -------------------- ----------- ------------------------------------------------------------------------------------------
  **Attribute**        **Type**    **Description**
  `style`              `STRING`    Can be used to decorate the element with a [Presentation Style](PresentationStyles.html)
  `tag`                `STRING`    User-defined attribute to identify the node.
  `name`               `STRING`    Identifies the Toolbar.
  `buttonTextHidden`   `INTEGER`   Defines if the text of toolbar buttons must appear by default.
  -------------------- ----------- ------------------------------------------------------------------------------------------
:::

The following table shows the list of *item-attributes* supported for
the `ToolBarItem` node:

::: {align="center"}
  ----------------------- ----------------------- ----------------------------------------------------
  **Attribute**           **Type**                **Description**

  `name`                  `STRING`                Identifies the [action](InteractionModel.html)
                                                  corresponding to the toolbar button.\
                                                  Can be prefixed with the [sub-dialog
                                                  identifier](MultipleDialogs.html#binding-actions).

  `style`                 `STRING`                Can be used to decorate the element with a
                                                  [Presentation Style](PresentationStyles.html)

  `tag`                   `STRING`                User-defined attribute to identify the node.

  `text`                  `STRING`                The text to be displayed in the toolbar button.

  `comment`               `STRING`                The message to be shown as tooltip when the user
                                                  selects a toolbar button.

  `hidden`                `INTEGER`               Indicates if the item is hidden.

  `image`                 `STRING`                The icon to be used in the toolbar button.
  ----------------------- ----------------------- ----------------------------------------------------
:::

The following table shows the list of *separator-attributes* supported
for the `ToolBarSeparator` node:

::: {align="center"}
  --------------- ----------- ------------------------------------------------------------------------------------------
  **Attribute**   **Type**    **Description**
  `name`          `STRING`    Identifies the Toolbar separator.
  `style`         `STRING`    Can be used to decorate the element with a [Presentation Style](PresentationStyles.html)
  `tag`           `STRING`    User-defined attribute to identify the node.
  `hidden`        `INTEGER`   Indicates if the separator is hidden.
  --------------- ----------- ------------------------------------------------------------------------------------------
:::

------------------------------------------------------------------------

#### [Defining toolbars in the form file]{#FORMSECTION}

You can define a toolbar in the form specification file with the
[TOOLBAR section](FormSpecFiles.html#SECTION_TOOLBAR); see the
[example](#EXAMPLES) below.

------------------------------------------------------------------------

#### [Loading a Toolbar from an XML file]{#LOADFORM}

To load a Toolbar definition file, use the utility method provided by
the [Form built-in class](ClassForm.html):


    01 CALL myform.loadToolbar("standard")

This method accepts a filename [with]{.underline} or
[without]{.underline} the \"`4tb`\" extension. If you omit the file
extension (recommended), the runtime system adds the extension
automatically. If the file does not exist in the current directory, it
is searched in the directories defined in the
[DBPATH](EnvironmentVariables.html#EV_DBPATH)/[FGLRESOURCEPATH](EnvironmentVariables.html#EV_FGLRESOURCEPATH)
environment variable.

If a form contains a specific toolbar loaded by the
[ui.Form.loadToolbar()](ClassForm.html) method or defined in the [Form
Specification File](FormSpecFiles.html#SECTION_TOOLBAR), it will be
replaced by the new toolbar loaded from this function.

------------------------------------------------------------------------

#### [Loading a default toolbar from an XML file]{#LOADDEFAULT}

To load a default toolbar from an XML definition file, use the utility
method provided by the [Interface built-in class](ClassInterface.html):


    01 CALL ui.Interface.loadToolbar("standard")

This method accepts a filename [with]{.underline} or
[without]{.underline} the \"`4tb`\" extension. If you omit the file
extension (recommended), the runtime system adds the extension
automatically. If the file does not exist in the current directory, it
is searched in the directories defined in the
[DBPATH](EnvironmentVariables.html#EV_DBPATH)/[FGLRESOURCEPATH](EnvironmentVariables.html#EV_FGLRESOURCEPATH)
environment variable.

The default toolbar loaded by this method is also used for the MDI
container.

------------------------------------------------------------------------

#### [Creating the toolbar manually with DOM]{#DYNAMIC}

This example shows how to create a Toolbar in all forms by using the
default initialization function and the [DomNode
class](ClassDomNode.html):


    01 CALL ui.Form.setDefaultInitializer("myinit")
    02 OPEN FORM f1 FROM "form1"
    03 DISPLAY FORM f1
    04 ...
    05 FUNCTION myinit(form)
    06   DEFINE form ui.Form
    06   DEFINE f om.DomNode
    08   LET f = form.getNode()
    09   ...
    10 END FUNCTION

After getting the DOM node of the form, create a node with the
\"`ToolBar`\" tag name:


    01 DEFINE tb om.DomNode
    02 LET tb = f.createChild("ToolBar")

For each toolbar button, create a sub-node with the \"`ToolBarItem`\"
tag name and set the attributes to define the button:


    01 DEFINE tbi om.DomNode
    02 LET tbi = tb.createChild("ToolBarItem")
    03 CALL tbi.setAttribute("name","update")
    04 CALL tbi.setAttribute("text","Modify")
    05 CALL tbi.setAttribute("comment","Modify the current record")
    06 CALL tbi.setAttribute("image","change")

If needed, you can create a \"`ToolBarSeparator`\" node to separate
Toolbar buttons:


    01 DEFINE tbs om.DomNode
    02 LET tbs = tb.createChild("ToolBarSeparator")

------------------------------------------------------------------------

### [Examples]{#EXAMPLES}

#### [Example 1: Simple Toolbar in XML format]{#EXAMPLE_1}


    01 <ToolBar style="mystyle">
    02    <ToolBarItem name="f5" text="List" image="list" />
    03    <ToolBarSeparator/>
    04    <ToolBarItem name="query" text="Query" image="search" />
    05    <ToolBarItem name="add" text="Append" image="add" />
    06    <ToolBarItem name="delete" text="Delete" image="delete" />
    07    <ToolBarItem name="modify" text="Modify" image="change" />
    08    <ToolBarSeparator/>
    09    <ToolBarItem name="f1" text="Help" image="list" />
    10    <ToolBarSeparator/>
    11    <ToolBarItem name="quit" text="Quit" image="quit" />
    12 </ToolBar>

#### [Example 2: Program creating the Toolbar dynamically]{#EXAMPLE_2}


    01 MAIN
    02   DEFINE aui om.DomNode
    03   DEFINE tb  om.DomNode
    04   DEFINE tbi om.DomNode
    05   DEFINE tbs om.DomNode
    06 
    07   LET aui = ui.Interface.getRootNode()
    08 
    09   LET tb = aui.createChild("ToolBar")
    10 
    11   LET tbi = createToolBarItem(tb,"f1","Help","Show help","help")
    12   LET tbs = createToolBarSeparator(tb)
    13   LET tbi = createToolBarItem(tb,"upd","Modify","Modify current record","change")
    14   LET tbi = createToolBarItem(tb,"del","Remove","Remove current record","delete")
    15   LET tbi = createToolBarItem(tb,"add","Append","Add a new record","add")
    16   LET tbs = createToolBarSeparator(tb)
    17   LET tbi = createToolBarItem(tb,"xxx","Exit","Quit application","quit")
    18 
    19   MENU "Example"
    20     COMMAND KEY(F1)
    21       DISPLAY "F1 action received"
    22     COMMAND "upd"
    23       DISPLAY "Update action received"
    24     COMMAND "Del"
    25       DISPLAY "Delete action received"
    26     COMMAND "Add"
    27       DISPLAY "Append action received"
    28     COMMAND "xxx"
    29       EXIT PROGRAM
    30   END MENU
    31 
    32 END MAIN
    33 
    34 FUNCTION createToolBarSeparator(tb)
    35   DEFINE tb om.DomNode
    36   DEFINE tbs om.DomNode
    37   LET tbs = tb.createChild("ToolBarSeparator")
    38   RETURN tbs
    39 END FUNCTION
    40 
    41 FUNCTION createToolBarItem(tb,n,t,c,i)
    42   DEFINE tb om.DomNode
    43   DEFINE n,t,c,i VARCHAR(100)
    44   DEFINE tbi om.DomNode
    45   LET tbi = tb.createChild("ToolBarItem")
    46   CALL tbi.setAttribute("name",n)
    47   CALL tbi.setAttribute("text",t)
    48   CALL tbi.setAttribute("comment",c)
    49   CALL tbi.setAttribute("image",i)
    50   RETURN tbi
    51 END FUNCTION

#### [Example 3: Toolbar definition in a PER file]{#EXAMPLE_3}


    01 TOOLBAR ( STYLE="mystyle" )
    02   ITEM accept ( TEXT="Ok", IMAGE="ok" )
    03   ITEM cancel ( TEXT="cancel", IMAGE="cancel" )
    04   SEPARATOR
    05   ITEM editcut   -- Gets decoration from action defaults
    06   ITEM editcopy  -- Gets decoration from action defaults
    07   ITEM editpaste -- Gets decoration from action defaults
    08   SEPARATOR
    09   ITEM append ( TEXT="Append", IMAGE="add" )
    10   ITEM update ( TEXT="Update", IMAGE="modify" )
    11   ITEM delete ( TEXT="Delete", IMAGE="del" )
    12   ITEM search ( TEXT="Search", IMAGE="find" )
    13 END
