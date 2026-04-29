[Back to Contents](../index.html)

------------------------------------------------------------------------

# [StartMenus]{#PAGE_HEADER}

Summary:

- [Basics](#BASICS)
- [Syntax](#SYNTAX)
- [Usage](#USAGE)
  - [Defining StartMenus](#DEFINING)
  - [StartMenu Structure](#STRUCT)
  - [Loading a StartMenu from an XML file](#LOAD)
  - [Creating a StartMenu dynamically](#DYNAMIC)
- [Examples](#EXAMPLES)
  - [Simple StartMenu in XML format](#EXAMPLE_1)
  - [Program creating a StartMenu dynamically](#EXAMPLE_2)

*See also:* [Toolbars](Toolbars.html), [Topmenus](Topmenus.html)

------------------------------------------------------------------------

### [Basics]{#BASICS}

The [StartMenu]{#StartMenu} defines a tree of commands that start
programs on the application server where the runtime system executes.

------------------------------------------------------------------------

### [Syntax]{#SYNTAX}

`<StartMenu `[`[`]{.underline}` `*`startmenu-attribute`*`="`*`value"`*` `[`[...]`]{.underline}` `[`]`]{.underline}` >`\
`  `*`group`*\
`  `[`[...]`]{.underline}\
`</``StartMenu>`

where *group* is:

`<StartMenuGroup `*`group-attribute`*`="`*`value"`*` `[`[...]`]{.underline}`>`\
`  `[`{`]{.underline}` <StartMenuSeparator/>`\
`  `[`|`]{.underline}` <StartMenuCommand `*`command-attribute`*`="`*`value"`*` `[`[...]`]{.underline}` />`\
`  `[`|`]{.underline}` `*`group`*\
`  `[`}`]{.underline}` `[`[...]`]{.underline}\
`</StartMenuGroup>`

#### Notes:

1.  The `StartMenu` node can only hold `StartMenuGroup` children.
2.  *startmenu-attribute* defines a property of the `StartMenu`. See
    below for more details.
3.  A `StartMenuGroup` node can hold `StartMenuSeparator`,
    `StartMenuGroup`, or `StartMenuCommand` children.
4.  *command-attribute* defines a property of a `StartMenuCommand`. See
    below for more details.
5.  A `StartMenuCommand` node defines a leaf of the `StartMenu` tree
    that can be selected to start a program.
6.  *group-attribute* defines a property of a `StartMenuGroup`. See
    below for more details.

#### Warnings:

1.  The DOM tag names are case sensitive; `Startmenu` is different from
    `StartMenu`.

------------------------------------------------------------------------

### **[Usage]{#USAGE}**

#### [Defining StartMenus]{#DEFINING}

It is recommended that you create a specific BDL program dedicated to
running the Start Menu. This program must create (or load) a Start Menu,
and then perform an interactive instruction to enter the interaction
loop.

The StartMenu must be defined in the [Abstract User
Interface](DynamicUI.html#ABSTRACTUI) tree using the [DOM
API](XmlUtils.html), under the \"`UserInterface`\" root node.

The StartMenu is unique for a program and cannot be redefined.

When a StartMenu command is selected by the user, the runtime system
automatically starts a child process with the command specified in the
command attribute.

------------------------------------------------------------------------

#### [StartMenu Structure]{#STRUCT}

The following table shows the attributes of the `StartMenu` node:

::: {align="center"}
  --------------- ---------- --------------------------------------------
  **Attribute**   **Type**   **Description**
  `name`          `STRING`   Identifies the StartMenu, can be omitted.
  `text`          `STRING`   Defines the text to be displayed as title.
  --------------- ---------- --------------------------------------------
:::

The following table shows the attributes of the `StartMenuGroup` node:

::: {align="center"}
  --------------- ----------- -----------------------------------------------------------------------
  **Attribute**   **Type**    **Description**
  `disabled`      `INTEGER`   Indicates if the group must be disabled (grayed, cannot be selected).
  `hidden`        `INTEGER`   Indicates if the group is hidden or visible.
  `image`         `STRING`    Defines the icon to be used for this group.
  `name`          `STRING`    Identifies the start menu group, can be omitted.
  `text`          `STRING`    Defines the text to be displayed for this group.
  --------------- ----------- -----------------------------------------------------------------------
:::

The following table shows the attributes of the `StartMenuCommand` node:

::: {align="center"}
  --------------- ----------- -------------------------------------------------------------------------------------
  **Attribute**   **Type**    **Description**
  `disabled`      `INTEGER`   Indicates if the item must be disabled (grayed, cannot be selected).
  `comment`       `STRING`    Specifies the comment to be shown for this command.
  `exec`          `STRING`    Defines the command to be executed when the user selects this command.
  `hidden`        `INTEGER`   Indicates if the command is hidden or visible.
  `image`         `STRING`    Defines the icon to be used for this command.
  `name`          `STRING`    Identifies the StartMenu item, can be omitted.
  `text`          `STRING`    Defines the text to be displayed for this command.
  `waiting`       `INTEGER`   Defines if the command must be started without waiting (0, default) or waiting (1).
  --------------- ----------- -------------------------------------------------------------------------------------
:::

The following table shows the attributes of the `StartMenuSeparator`
node:

::: {align="center"}
  --------------- ---------- -----------------------------------------------------
  **Attribute**   **Type**   **Description**
  `name`          `STRING`   Identifies the StartMenu separator, can be omitted.
  --------------- ---------- -----------------------------------------------------
:::

------------------------------------------------------------------------

#### [Loading a StartMenu from an XML file]{#LOAD}

To load a StartMenu definition file, use the utility method provided by
the [Interface built-in class](ClassInterface.html):


    01 CALL ui.Interface.loadStartMenu("standard")

This method accepts a filename [with]{.underline} or
[without]{.underline} the \"`4sm`\" extension. If you omit the file
extension (recommended), the runtime system adds the extension
automatically. If the file does not exist in the current directory, it
is searched in the directories defined in the
[DBPATH](EnvironmentVariables.html#EV_DBPATH)/[FGLRESOURCEPATH](EnvironmentVariables.html#EV_FGLRESOURCEPATH)
environment variable.

------------------------------------------------------------------------

#### [Creating the StartMenu dynamically]{#DYNAMIC}

You can create a StartMenu dynamically with the [DomNode
class](ClassDomNode.html):

First, get the [AUI](DynamicUI.html#ABSTRACTUI) root node:


    01 DEFINE aui om.DomNode
    02 LET aui = ui.Interface.getRootNode()

Next, create a node with the \"`StartMenu`\" tag name:


    01 DEFINE sm om.DomNode
    02 LET sm = aui.createChild("StartMenu")

Next, create a \"`StartMenuGroup`\" node to group a couple of command
nodes:


    01 DEFINE smg om.DomNode
    02 LET smg = sm.createChild("StartMenuGroup")
    03 CALL smg.setAttribute("text","Programs")

Then, create \"`StartMenuCommand`\" nodes for each program and, if
needed, add \"`StartMenuSeparator`\" nodes to separate entries:


    01 DEFINE smc, sms om.DomNode
    02 LET smc = smg.createChild("StartMenuCommand")
    03 CALL smc.setAttribute("text","Orders")
    04 CALL smc.setAttribute("exec","fglrun orders.42r")
    05 LET smc = smg.createChild("StartMenuCommand")
    06 CALL smc.setAttribute("text","Customers")
    07 CALL smc.setAttribute("exec","fglrun customers.42r")
    08 LET sms = smg.createChild("StartMenuSeparator")
    09 LET smc = smg.createChild("StartMenuCommand")
    10 CALL smc.setAttribute("text","Items")
    11 CALL smc.setAttribute("exec","fglrun items.42r")

------------------------------------------------------------------------

### [Examples]{#EXAMPLES}

#### [Example 1: Simple StartMenu in XML format]{#EXAMPLE_1}


    01 <StartMenu>
    02    <StartMenuGroup text="Ordering" >
    03       <StartMenuCommand text="Orders" exec="fglrun orders.42r" disabled="1" />
    04       <StartMenuCommand text="Customers" exec="fglrun custs.42r" image="smiley" />
    05       <StartMenuCommand text="Items" exec="fglrun items.42r" waiting="1" />
    06    <StartMenuCommand text="Reports" exec="fglrun reports.42r" comment="Run reports" />
    07    </StartMenuGroup>
    08    <StartMenuGroup text="Configuration" >
    09       <StartMenuCommand text="Database" exec="fglrun dbseconf.42r" />
    10       <StartMenuCommand text="Users" exec="fglrun userconf.42r" />
    11       <StartMenuCommand text="Printers" exec="fglrun prntconf.42r" />
    12    </StartMenuGroup>
    13 </StartMenu>

#### [Example 2: Program creating the StartMenu dynamically]{#EXAMPLE_2}


    01 MAIN
    02   DEFINE aui om.DomNode
    03   DEFINE sm  om.DomNode
    04   DEFINE smg om.DomNode
    05   DEFINE smc om.DomNode
    06 
    07   LET aui = ui.Interface.getRootNode()
    08 
    09   LET sm = aui.createChild("StartMenu")
    10 
    11   LET smg = createStartMenuGroup(sm,"Ordering")
    13   LET smc = createStartMenuCommand(smg,"Orders","fglrun orders.42r",NULL)
    14   LET smc = createStartMenuCommand(smg,"Customers","fglrun custs.42r",NULL)
    15   LET smc = createStartMenuCommand(smg,"Items","fglrun items.42r",NULL)
    16   LET smc = createStartMenuCommand(smg,"Reports","fglrun reports.42r",NULL)
    17   LET smg = createStartMenuGroup(sm,"Configuration")
    18   LET smc = createStartMenuCommand(smg,"Database","fglrun dbseconf.42r",NULL)
    19   LET smc = createStartMenuCommand(smg,"Users","fglrun userconf.42r",NULL)
    20   LET smc = createStartMenuCommand(smg,"Printers","fglrun prntconf.42r",NULL)
    21 
    22   MENU "Example"
    23     COMMAND "Quit"
    24       EXIT PROGRAM
    25   END MENU
    26 
    27 END MAIN
    28 
    29 FUNCTION createStartMenuGroup(p,t)
    30   DEFINE p om.DomNode
    31   DEFINE t STRING
    32   DEFINE s om.DomNode
    33   LET s = p.createChild("StartMenuGroup")
    34   CALL s.setAttribute("text",t)
    35   RETURN s
    36 END FUNCTION
    37 
    38 FUNCTION createStartMenuCommand(p,t,c,i)
    39   DEFINE p om.DomNode
    40   DEFINE t,c,i STRING
    41   DEFINE s om.DomNode
    42   LET s = p.createChild("StartMenuCommand")
    43   CALL s.setAttribute("text",t)
    44   CALL s.setAttribute("exec",c)
    45   CALL s.setAttribute("image",i)
    46   RETURN s
    47 END FUNCTION
