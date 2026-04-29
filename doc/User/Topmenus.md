[Back to Contents](../index.html)

------------------------------------------------------------------------

# [Topmenus]{#PAGE_HEADER}

Summary:

- [Basics](#BASICS)
- [Syntax](#SYNTAX)
- [Usage](#USAGE)
  - [Defining TopMenus](#DEFINING)
  - [TopMenu Structure](#STRUCT)
  - [Defining a TopMenu in form file](#FORMSECTION)
  - [Loading a TopMenu from a file](#LOADFORM)
  - [Loading a default TopMenu from a file](#LOADDEFAULT)
  - [Creating a TopMenu dynamically](#DYNAMIC)
- [Examples](#EXAMPLES)
  - [Simple Topmenu in XML format](#EXAMPLE_1)
  - [Topmenu definition in a PER file](#EXAMPLE_2)

*See also:* [Action Defaults](ActionDefaults.html),
[Toolbars](Toolbars.html), [Form Specification
Files](FormSpecFiles.html)

------------------------------------------------------------------------

### [Basics]{#BASICS}

A [Topmenu]{#TopMenu} is a [view for actions](InteractionModel.html)
presented as a typical pull-down menu, having options that can trigger
events in an interactive instruction. This page describes how to use
Topmenus in programs; it is also possible to define Topmenus in forms
with the [TOPMENU section](FormSpecFiles.html#SECTION_TOPMENU).

------------------------------------------------------------------------

### [Syntax]{#SYNTAX}

`<TopMenu `[`[`]{.underline}` `*`topmenu-attribute`*`="`*`value"`*` `[`[...]`]{.underline}` `[`]`]{.underline}` >`\
`  `*`group`*\
`  `[`[...]`]{.underline}\
`</TopMenu>`

where *group* is:

`<TopMenuGroup `*`group-attribute`*`="`*`value"`*` `[`[...]`]{.underline}`>`\
`  `[`{`]{.underline}` <TopMenuSeparator `*`separator-attribute`*`="`*`value"`*` `[`[...]`]{.underline}` />`\
`  `[`|`]{.underline}` <TopMenuCommand `*`command-attribute`*`="`*`value"`*` `[`[...]`]{.underline}` />`\
`  `[`|`]{.underline}` `*`group`*\
`  `[`}`]{.underline}` `[`[...]`]{.underline}\
`</TopMenuGroup>`

#### Notes:

1.  The `TopMenu` node can only contain a list of `TopMenu``Group`
    items.
2.  *topmenu-attribute* defines a property of the `TopMenu`.
3.  A `TopMenu``Group` node can hold `TopMenu``Separator`,
    `TopMenu``Group` or `TopMenu``Command` children.
4.  *group-attribute* defines a property of a `TopMenuGroup`.
5.  A `TopMenu``Command` node defines a leaf of the TopMenu tree and can
    be selected to execute an action.
6.  *command-attribute* defines a property of a `TopMenuCommand`.
7.  A `TopMenuSeparator` node defines an horizontal line in a TopMenu
    group.
8.  *separator-attribute* defines a property of a `TopMenuSeparator`.

#### Warnings:

1.  The DOM tag names are case sensitive; `Topmenu` is different from
    `TopMenu`.
2.  When binding to an action, make sure that you are using the right
    value in the `name` attribute. As `ON ACTION` and `COMMAND` generate
    lowercase identifiers, it is recommended to use **lowercase**
    `names`.
3.  When binding to a key, make sure the `name` attribute value is in
    lowercase letters (\"`f5`\").
4.  Make sure that the image file is available to the Front End.

#### Tips:

1.  For common actions, it is recommended that you define the decoration
    of a Topmenu command with [Action Defaults](ActionDefaults.html).

------------------------------------------------------------------------

### **[Usage]{#USAGE}**

#### [Defining TopMenus]{#DEFINING}

A Topmenu defines a graphical pull-down menu that holds views for
actions controlled in BDL programs with `ON ACTION` clauses. See
[Interaction Model](InteractionModel.html) for more details about action
management.

You can define a Topmenu in form files with the [TOPMENU
section](FormSpecFiles.html#SECTION_TOPMENU), or you can load a Topmenu
at runtime into the current form by using the following methods:
[ui.Form.loadTopMenu()](ClassForm.html)

The Topmenu commands (pull-down menu options) are enabled according to
the [actions](InteractionModel.html) defined by the current interactive
instruction, which can be [MENU](Menus.html), [INPUT](RecordInput.html),
[INPUT ARRAY](InputArray.html), [DISPLAY ARRAY](DisplayArray.html) or
[CONSTRUCT](Construct.html). When a Topmenu option is selected, the
program executes the action trigger the Topmenu command is bound to.

A Topmenu command is bound to an *action node* of the current
interactive instruction if its `name` attribute corresponds to an
*action node* name (typically, the name of a ring menu option). In this
case, a Topmenu command selection has the same effect as raising the
action. For example, if the current interactive instruction is a ring
menu, this would have the same effect as selecting the ring menu option.

A Topmenu command is bound to a key trigger if the `name` attribute of
the command corresponds to a valid hot-key, [in lowercase
letters]{.underline}. In this case, selecting a Topmenu command has the
same effect as pressing the hot-key.

A Topmenu command is automatically disabled if the corresponding action
is not available (for example, when a ring menu option is hidden).

Topmenu elements can get a `style` attribute in order to use a specific
rendering/decoration following [Presentation
Style](PresentationStyles.html) definitions.

------------------------------------------------------------------------

#### [TopMenu structure]{#STRUCT}

A Topmenu is part of a form definition; the `TopMenu` node must be
created under the `Form` node.

The following table shows the list of *topmenu-attributes* supported for
the `TopMenu` node:

::: {align="center"}
  --------------- ---------- ------------------------------------------------------------------------------------------
  **Attribute**   **Type**   **Description**
  `name`          `STRING`   Identifies the TopMenu.
  `style`         `STRING`   Can be used to decorate the element with a [Presentation Style](PresentationStyles.html)
  `tag`           `STRING`   User-defined attribute to identify the node.
  --------------- ---------- ------------------------------------------------------------------------------------------
:::

The following table shows the list of *command-attributes* supported for
the `TopMenuCommand` node:

::: {align="center"}
  ----------------------- ----------------------- ----------------------------------------------------
  **Attribute**           **Type**                **Description**

  `name`                  `STRING`                Identifies the [action](InteractionModel.html)
                                                  corresponding to the Topmenu command.\
                                                  Can be prefixed with the [sub-dialog
                                                  identifier](MultipleDialogs.html#binding-actions).

  `style`                 `STRING`                Can be used to decorate the element with a
                                                  [Presentation Style](PresentationStyles.html)

  `tag`                   `STRING`                User-defined attribute to identify the node. 

  `text`                  `STRING`                The text to be displayed in the pull-down menu
                                                  option.

  `comment`               `STRING`                The message to be shown for this element.

  `hidden`                `INTEGER`               Indicates if the command is hidden.

  `image`                 `STRING`                The icon to be used in the pull-down menu option.

  `acceleratorName`       `STRING`                Defines the accelerator name to be display on the
                                                  left of the menu option text.\
                                                  Note this attribute is only used for decoration (you
                                                  must also define an [action default
                                                  accelerator](ActionDefaults.html)).
  ----------------------- ----------------------- ----------------------------------------------------
:::

In order to define the tree structure of the pull-down menu, the
`TopMenuGroup` node is provided to hold Topmenu commands and Topmenu
groups:


    TopMenu
      +- TopMenuGroup
         +- TopMenuCommand
         +- TopMenuCommand
         +- TopMenuCommand
      +- TopMenuGroup
         +- TopMenuGroup
            +- TopMenuCommand
            +- TopMenuCommand
         +- TopMenuGroup
            +- TopMenuCommand
            +- TopMenuCommand
            +- TopMenuCommand

The following table shows the list of *group-attributes* supported for
the `TopMenuGroup` node:

::: {align="center"}
  ----------------------- ----------------------- ---------------------------------
  **Attribute**           **Type**                **Description**

  `name`                  `STRING`                Identifies the TopMenu group.

  `style`                 `STRING`                Can be used to decorate the
                                                  element with a [Presentation
                                                  Style](PresentationStyles.html)

  `tag`                   `STRING`                User-defined attribute to
                                                  identify the node.

  `text`                  `STRING`                The text to be displayed in the
                                                  pull-down menu group.

  `comment`               `STRING`                The message to be shown for this
                                                  element.

  `hidden`                `INTEGER`               Indicates if the group is hidden.

  `image`                 `STRING`                The icon to be used in the
                                                  pull-down menu group.\
                                                  **Warning: Images cannot be
                                                  displayed for the first level of
                                                  TopMenuGroup elements. **
  ----------------------- ----------------------- ---------------------------------
:::

The following table shows the list of *separator-attributes* supported
for the `TopMenuSeparator` node:

::: {align="center"}
  --------------- ----------- ------------------------------------------------------------------------------------------
  **Attribute**   **Type**    **Description**
  `name`          `STRING`    Identifies the TopMenu separator.
  `style`         `STRING`    Can be used to decorate the element with a [Presentation Style](PresentationStyles.html)
  `tag`           `STRING`    User-defined attribute to identify the node 
  `hidden`        `INTEGER`   Indicates if the separator is hidden.
  --------------- ----------- ------------------------------------------------------------------------------------------
:::

------------------------------------------------------------------------

#### [Defining the Topmenu in a form file]{#FORMSECTION}

You typically define a Topmenu in the form specification file, with the
[TOPMENU section](FormSpecFiles.html#SECTION_TOPMENU); see below for an
[example](#EXAMPLES).

------------------------------------------------------------------------

#### [Loading a Topmenu from an XML file]{#LOADFORM}

To load a Topmenu definition file, use the utility method provided by
the [Form built-in class](ClassForm.html):


    01 CALL myform.loadTopMenu("standard")

This method accepts a filename [with]{.underline} or
[without]{.underline} the \"`4tm`\" extension. If you omit the file
extension (recommended), the runtime system adds the extension
automatically. If the file does not exist in the current directory, it
is searched in the directories defined in the
[DBPATH](EnvironmentVariables.html#EV_DBPATH)/[FGLRESOURCEPATH](EnvironmentVariables.html#EV_FGLRESOURCEPATH)
environment variable.

If a form contains a specific topmenu loaded by the
[ui.Form.loadTopmenu()](ClassForm.html) method or defined in the [Form
Specification File](FormSpecFiles.html#SECTION_TOOLBAR), it will be
replaced by the new topmenu loaded from this function.

------------------------------------------------------------------------

#### [Loading a default topmenu from an XML file]{#LOADDEFAULT}

To load a default topmenu from an XML definition file, use the utility
method provided by the [Interface built-in class](ClassInterface.html):


    01 CALL ui.Interface.loadTopMenu("standard")

This method accepts a filename [with]{.underline} or
[without]{.underline} the \"`4tm`\" extension. If you omit the file
extension (recommended), the runtime system adds the extension
automatically. If the file does not exist in the current directory, it
is searched in the directories defined in the
[DBPATH](EnvironmentVariables.html#EV_DBPATH)/[FGLRESOURCEPATH](EnvironmentVariables.html#EV_FGLRESOURCEPATH)
environment variable.

The default topmenu loaded by this method is also used for the MDI
container.

------------------------------------------------------------------------

#### [Creating the Topmenu dynamically]{#DYNAMIC}

This example shows how to create a Topmenu in all forms by using the
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
\"`TopMenu`\" tag name:


    01 DEFINE tm om.DomNode
    02 LET tm = f.createChild("TopMenu")

For each Topmenu group, create a sub-node with the \"`TopMenuGroup`\"
tag name and set the attributes to define the group:


    01 DEFINE tmg om.DomNode
    02 LET tmg = tm.createChild("TopMenuGroup")
    03 CALL tmg.setAttribute("text","Reports")

For each Topmenu option, create a sub-node in a group node with the
\"`TopMenuCommand`\" tag name and set the attributes to define the
option:


    01 DEFINE tmi om.DomNode
    02 LET tmi = tmg.createChild("TopMenuCommand")
    03 CALL tmi.setAttribute("name","report")
    04 CALL tmi.setAttribute("text","Order report")
    05 CALL tmi.setAttribute("comment","Orders entered today")
    06 CALL tmi.setAttribute("image","smiley")

If needed, you can create a \"`TopMenuSeparator`\" node inside a group,
to separate menu options:


    01 DEFINE tms om.DomNode
    02 LET tms = tmg.createChild("TopMenuSeparator")

------------------------------------------------------------------------

### [Examples]{#EXAMPLES}

#### [Example 1: Simple Topmenu in XML format]{#EXAMPLE_1}


    01 <TopMenu>
    02    <TopMenuGroup text="Form" style="mystyle">
    03       <TopMenuCommand name="help" text="Help" image="quest" />
    04       <TopMenuCommand name="quit" text="Quit" acceleratorName="alt-F4"/>
    05    </TopMenuGroup>
    06    <TopMenuGroup text="Edit" >
    07       <TopMenuCommand name="accept" text="Validate" image="ok" />
    08       <TopMenuCommand name="cancel" text="Cancel" image="cancel" />
    09       <TopMenuSeparator/>
    10       <TopMenuCommand name="editcut" text="Cut" />
    11       <TopMenuCommand name="editcopy" text="Copy" />
    12       <TopMenuCommand name="editpaste" text="Paste" />
    13    </TopMenuGroup>
    14    <TopMenuGroup text="Records" >
    15       <TopMenuCommand name="append" text="Add" image="add" />
    16       <TopMenuCommand name="delete" text="Remove" image="delete" />
    17       <TopMenuCommand name="update" text="Modify" image="change" />
    18       <TopMenuSeparator/>
    19       <TopMenuCommand name="search" text="Query" image="find" />
    20    </TopMenuGroup>
    21 </TopMenu>

#### [Example 2: Topmenu definition in a PER file]{#EXAMPLE_2}


    01 TOPMENU
    02   GROUP form (TEXT="Form", STYLE="mystyle" )
    03      COMMAND help (TEXT="Help", IMAGE="quest")
    04      COMMAND quit (TEXT="Quit", ACCELERATOR=ALT-F4)
    05   END
    06   GROUP edit (TEXT="Edit")
    07      COMMAND accept (TEXT="Validate", IMAGE="ok")
    08      COMMAND cancel (TEXT="Cancel", IMAGE="cancel")
    09      SEPARATOR
    10      COMMAND editcut   -- Gets decoration from action defaults
    11      COMMAND editcopy  -- Gets decoration from action defaults
    12      COMMAND editpaste -- Gets decoration from action defaults
    13   END
    14   GROUP records (TEXT="Records")
    15      COMMAND append (TEXT="Add", IMAGE="add")
    16      COMMAND delete (TEXT="Remove", IMAGE="del")
    17      COMMAND update (TEXT="Modify", IMAGE="change")
    18      SEPARATOR
    19      COMMAND search (TEXT="Search", IMAGE="find")
    20   END
    21 END
