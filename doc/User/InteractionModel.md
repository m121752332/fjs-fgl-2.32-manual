[Back to Contents](../index.html)

------------------------------------------------------------------------

# [The Interaction Model]{#PAGE_HEADER}

Summary:

- [The Model-View-Controller Paradigm](#IM_CONCEPT)
- [Controlling User Actions](#CTRLGACTIONS)
  - [Action handling basics](#ACTION_HANLDING_BASICS)
  - [Default Action Views](#DEFAULT_ACTION_VIEWS)
  - [Decorating Action Views](#DECORATING_ACTION_VIEWS)
  - [Enabling and Disabling Actions](#ENA_DIS_ACTIONS)
  - [Binding Action views to Action Handlers](#BINDING_ACTIONS)
    - [Action binding basics](#BINDING_BASICS)
    - [Sub-dialog prefix in the DIALOG instruction](#SUBDIALOG_PREFIX)
    - [Field-specific enabled actions](#ON_ACTION_INFIELD)
    - [Resolving multi-level action name
      conflicts](#RESOLVING_ACTION_CONFLICTS)
    - [Action view binding combinations](#ACTION_BINDING_COMBINATIONS)
  - [Default Context Menu](#DEFAULT_CONTEXT_MENU)
  - [Avoiding field data validation in UNBUFFERED
    mode](#ACTION_VALIDATE)
- [Predefined Actions](#PREDEFACTIONS)
  - [Definition](#PA_DEFINITION)
  - [Automatic and Local actions with same name](#PA_AUTOLOCAL)
  - [Overwriting predefined actions with ON ACTION](#PA_OVERWRITE)
  - [Predefined actions enabled according to context](#PA_AUTO_ACTIVATE)
  - [Lists of predefined actions](#PA_LIST)
- [Keyboard Accelerator Names](#ACCELNAMES)
  - [Accelerator keys](#ACCEL_KEYS)
  - [List of key names](#ACCEL_KEY_LIST)
  - [Accelerator key modifiers](#ACCEL_KEY_MOD)
- [Interruption Handling](#INTERRUPTION)
- [Detecting data changes immediately](#DIRTY)
- [Controlling data validation when an action is fired](#VALIDATE)
- [Windows closed by the user](#XCROSS_CLOSE)
  - [The close action in DIALOG](#close_in_dialog)
  - [The close action in singular dialogs](#close_in_singular)
  - [The close action in MENU](#close_in_menu)
  - [Close action example](#close_example)

*See also:* [Dynamic User Interface](DynamicUI.html), [Form
Files](FormSpecFiles.html), [Windows and Forms](WindowsAndForms.html).

------------------------------------------------------------------------

## [The Model-View-Controller Paradigm]{#IM_CONCEPT}

The Dynamic User Interface architecture is based on the
Model-View-Controller (MVC) paradigm. The *Model* defines the object to
be displayed (typically the application data that is stored in program
variables). The *View* defines the decoration of the Model (how the
Model must be displayed to the screen, this is typically the form). The
*Controller* is the program code that implements the processing that
manages the Model. Multiple *Views* can be associated to a *Model* and a
*Controller*.

With BDL, you define the Views in the [Abstract User
Interface](DynamicUI.html#ABSTRACTUI) tree or through built-in classes
designed for this (such as [Window](ClassWindow.html) or
[Form](ClassForm.html)). You store Models in the [program
variables](Variables.html), and you implement the Controllers with
interactive instructions, such as [DIALOG](MultipleDialogs.html) or 
[INPUT](RecordInput.html).

Normally the Controllers should not provide any decoration information,
as that is the purpose of Views. Because of the history of the language,
however, some interactive instructions such as [MENU](Menus.html) define
both the Controller and some presentation information such as menu
title, command labels, and comments. In this case, the runtime system
automatically creates the View with that information; you can still
associate other Views to the same controller.

------------------------------------------------------------------------

## [Controlling User Actions]{#CTRLGACTIONS}

### [Action Handling Basics]{#ACTION_HANLDING_BASICS}

In the user interface of the application, you can have interactive
elements (such as buttons) that can trigger an event transmitted to the
[Runtime System](FglTerms.html#RUNTIME_SYSTEM) for interpretation. To
manage such events, the *Action Views* can produce *Action Events* that
will execute the code of the corresponding *Action Handler* in the
current interactive instruction of the program.

### [Default Views for Actions]{#DEFAULT_ACTION_VIEWS}

If no explicit action view is defined, such as a toolbar button, or a
topmenu item or a simple button in the form layout, the front end
creates a default action view for each `MENU COMMAND` or `ON ACTION`
clause used in the current interactive instruction. Typically, the
default action views appear as buttons in the action frame.

Note that when creating actions with `ON KEY` (or `COMMAND KEY` without
a command name in a [MENU](Menus.html)), the default action view gets
invisible. However, if you define a `text` attribute in the [Action
Defaults](ActionDefaults.html#ACTDEFTEXT), the default button is made
visible.

You can control the default action view visibility by using the
[DEFAULTVIEW Action Default
attribute](FSFAttributes.html#FA_DEFAULTVIEW) or the `defaultView`
attribute in the [4ad files](ActionDefaults.html).

If one or more action views are defined explicitly for a given action,
the front end considers that the default view is no longer needed, and
hides the corresponding button. Typically, if you define in the form a
[BUTTONEDIT](FormSpecFiles.html#FF_ITEMTYPE_BUTTONEDIT) field or a
[BUTTON](FormSpecFiles.html#FF_ITEMTYPE_BUTTON) that triggers an action,
you do not need an additional button in the action frame.

The presentation of the default action views can be controlled
with [Window Styles](WindowsAndForms.html#WINDOW_STYLES).

### [Decorating Action Views]{#DECORATING_ACTION_VIEWS}

A default decoration for action views can be centralized in an external
file. This is strongly recommended, to separate the decoration of the
action view from action usage (the action handler) as much as possible.
See [Action Defaults](ActionDefaults.html) for more details.

Details about Action Defaults appliance will be discussed later in this
section.

### [Enabling and Disabling Actions]{#ENA_DIS_ACTIONS}

During an interactive instruction, you can enable or disable an action
with the `setActionActive()` method of the
[ui.Dialog](ClassDialog.html#setActionActive) built-in class. This
method takes the name of the action (in lowercase letters) and a boolean
expression (`0` or `FALSE`, `1` or `TRUE`) as arguments.

``` linenumber
01 ...
02    BEFORE INPUT
03       CALL DIALOG.setActionActive("zoom",FALSE)
04 ...
```

Details about action activation and de-activation will be discussed in
other parts of this section.

### [Binding Action Views to Action Handlers]{#BINDING_ACTIONS}

#### [Action binding basics]{#BINDING_BASICS}

Remember that *Action Views* can produce *Action Events* that will
execute the code of the corresponding *Action Handler* in the current
interactive instruction of the program.

Action Views (like buttons) are bound to an action by the \'name\'
attribute. For example, a Toolbar button with the name \'cancel\' is
bound to the Action Handler using the name \'cancel\'. Action Handlers
are defined in interactive instructions with an `ON ACTION` clause or
` COMMAND` / `ON KEY` clauses:

``` linenumber
01 INPUT ARRAY custarr WITHOUT DEFAULTS FROM sr_cust.*
02   ON ACTION printrec
03     CALL PrintRecord(custarr[arr_curr()].*) 
04   ON ACTION showhelp
05     CALL ShowHelp()
06 END INPUT
```

For backward compatibility, the `COMMAND` / `ON KEY` clauses are still
supported. However, it is strongly recommended that you use `ON ACTION`
clauses instead, as the `ON ACTION` clauses identify user actions with
an abstract name.

In `ON ACTION `*`action-name`*, the name of the action must be a valid
[identifier](LanguageFeatures.html#LF_IDENTS), preferably written in
lowercase letters (see warning below).

**Warning: In the [Abstract User Interface](DynamicUI.html#ABSTRACTUI)
tree (where the action views are defined), action names are
case-sensitive (as they are standard DOM attribute values).  In BDL,
however, identifiers are not case-sensitive. To avoid any confusion, the
[compiler](Tools.html#TL_FGLCOMP) automatically converts action
identifiers to lowercase.**

#### [Sub-dialog prefix in the DIALOG instruction]{#SUBDIALOG_PREFIX}

You can use the [DIALOG](MultipleDialogs.html) instruction. Within the
`DIALOG` instruction, we distinguish *dialog actions* from *sub-dialog
actions.* When the `ON ACTION` handler is defined as a dialog action,
the action name is a simple identifier as in singular interactive
instructions. When the `ON ACTION` handler is defined inside a
[sub-dialog](MultipleDialogs.html#sub-dialogs) or if the action is an
implicit action such as [*insert* in INPUT
ARRAY](MultipleDialogs.html#insert-delete-rows), the action name gets
the name of the sub-dialog as the prefix to identify the sub-dialog
action with a unique name :

``` linenumber
01 DIALOG
02    INPUT BY NAME ... ATTRIBUTES (NAME = "cust")
03       ON ACTION check                   -- sub-dialog action "cust.check"
04       ...
05    END INPUT
06    DISPLAY ARRAY arr_orders TO sr_ord.*
07       ...
08       ON ACTION check                   -- sub-dialog action "sr_ord.check"
09       ...
10    END DISPLAY
11    BEFORE DIALOG
12       ...
13    ON ACTION close                      -- dialog action "close"
14       ...
15 END DIALOG
```

For `INPUT` and `CONSTRUCT` sub-dialogs, the [sub-dialog
identifier](MultipleDialogs.html#identifying-sub-dialogs) can be
specified with the `NAME` attribute. The `INPUT ARRAY` and
`DISPLAY ARRAY` sub-dialogs are implicitly identified with the
screen-record name defined in the form.

By using the sub-dialog identifier, you can bind action views to
specific sub-dialog actions. Action views bound to sub-dialog actions
with qualified sub-dialog action names will always be active, even if
the focus is not in the sub-dialog of the action. You typically use
fully-qualified sub-dialog actions names for
[buttons](FormSpecFiles.html#FF_ITEMTYPE_BUTTON) in the form body or in
[TopMenu](Topmenus.html) options. However, it does not make much sense
to use this technique for [ToolBar](Toolbars.html) buttons.

If you specify a simple action name (without the sub-dialog prefix), the
action view will be attached to any sub-dialog action with the matching
name. This is especially useful for common actions such as the implicit
*insert* / *append* / *delete* actions created by `INPUT ARRAY`, when
the dialog handles multiple editable lists. You can bind
[ToolBar](Toolbars.html) buttons to these actions without the sub-dialog
prefix; the buttons will apply to the current list that has the focus.
The action views bound to sub-dialog actions without the sub-dialog
qualifier will automatically be enabled or disabled when entering or
leaving the group of fields controlled by the sub-dialog (i.e. typical
navigation buttons in the toolbar will be disabled if the focus is not
in a list).

If a sub-dialog action is fired when the focus is not in the sub-dialog
of the action, the focus will automatically be given to the first field
of the sub-dialog, before executing the user code defined in the
`ON ACTION` clause. This will trigger the same validation rules and
control blocks as if the user had selected the first field of the
sub-dialog by hand.

When using [DIALOG.setActionActive()](ClassDialog.html#setActionActive)
(or any method that takes an action name as parameter), you can specify
the action name with or without a sub-dialog identifier. If you qualify
the action with the sub-dialog identifier, the sub-dialog action is
clearly identified. If you don\'t specify a sub-dialog prefix, the
action will be identified based on the focus context - when the focus is
in the sub-dialog of the action, non-qualified action names identify the
local sub-dialog action; otherwise, they identify a dialog action if one
exists with the same name. Disabling an action by the program with
`setActionActive()`, will take precedence over the built-in activation
rules (i.e. if the action is disabled by the program, the action will
not be activated when entering the sub-dialog).

For action views bound to sub-dialog actions with qualifiers, the
[Action Defaults](ActionDefaults.html) defined with the corresponding
[action name]{.underline} will be used to set the attributes with the
default values. In other words, the prefix will be ignored. For example,
if an action view is defined with the name \"*custlist.append*\", it
will get the action defaults defined for the \"*append*\" action.

#### [Field-specific enabled actions]{#ON_ACTION_INFIELD}

The `ON ACTION` interaction block has been extended with the
`INFIELD `*`field-name`* clause:

``` linenumber
01 INPUT ARRAY custarr WITHOUT DEFAULTS FROM sr_cust.*
02   ON ACTION zoom INFIELD cust_city
03     LET custarr[arr_curr()].cust_city = zoom_city() 
04   ON ACTION zoom INFIELD cust_state
05     LET custarr[arr_curr()].cust_state = zoom_state() 
06 END INPUT
```

If an action is defined with the `INFIELD `*`field-name`* clause, the
action object name is implicitly prefixed with the field name. You can
then bind action views by using this prefix to identify the action.
Without the field name prefix, the action view is enabled and disabled
automatically according to the current field. If you bind the action
view with the fully-qualified name including the field name prefix, the
action view will always be active.

**TO BE VALIDATED (BUG #16465)** Note that the *`field-name`* element of
the `INFIELD `*`field-name`* syntax can actually be a *`field-spec`*
syntax, with an optional table or screen record prefix as in
`BEFORE FIELD` control blocks. If such as prefix is used, the
field-action will be identified by *table-prefix.field-name*:

        table-prefix . field-name . action-name

Actions defined in sub-dialogs of the [DIALOG](MultipleDialogs.html)
instruction get the name of the sub-dialog as prefix. If
`ON ACTION `*`action-name`*` INFIELD `*`field-name`* is used in a
sub-dialog, the action object name is prefixed with the name of the
sub-dialog, followed by the name of the field. The fully-qualified
action name will be:

        sub-dialog-name . field-name . action-name

**TO BE VALIDATED (BUG #16465)** If the `INFIELD` clause in a sub-dialog
uses a table prefix for the field, the full-qualified action name will
be:

        sub-dialog-name . table-prefix . field-name . action-name

When the field-specific action is fired (for example by a button of the
toolbar bound with the fully-qualified action name) and if the field
does not have the focus, the runtime system first selects that field
before executing the code of the `ON ACTION INFIELD` block. The field
selection forces data validation and `AFTER FIELD` of the current field,
followed by `BEFORE FIELD` of the target field associated to the action.

Note that it\'s still possible to enable/disable field-specific action
objects by the program using the
[DIALOG.setActionActive()](ClassDialog.html#setActionActive) method.
When specifying a fully-qualified action name with the field name
prefix, that field-specific action will be enabled or disabled. When
disabled by the `setActionActive()` method, the corresponding action
views will always be disabled, even if the field has the focus. If you
do not specify a fully-qualified name in the method call, and if several
actions are defined with the same action name in different sub-dialogs
and/or using the `INFIELD` clause, the method will identify the action
according to the current focus context. For example, if you define
`ON ACTION zoom INFIELD cust_city` and
`ON ACTION zoom INFIELD cust_addr`, when the focus is in `cust_city`, a
call to `DIALOG.setActionActive("zoom", FALSE)` will disable the action
specific to the `cust_city` field.

Fields can be enabled or disabled dynamically with the
[DIALOG.setFieldActive()](ClassDialog.html#setFieldActive) method. If an
`ON ACTION INFIELD` is declared on a field and if you enable/disable the
field dynamically, then the field-specific action (and corresponding
action views in the form) will be enabled or disabled accordingly.

#### [Resolving multi-level action name conflicts]{#RESOLVING_ACTION_CONFLICTS}

We have seen in the above sections that actions can be defined at three
levels in the context of a [DIALOG](MultipleDialogs.html) instruction
(this would be only two levels in singular dialogs like
[INPUT](RecordInput.html)):

1.  Dialog level
2.  Sub-dialog level (`DIALOG` instruction only)
3.  Field level

In some case, you may want to use the same action name for different
levels. For example, in a order input form, a typical \"print\" action
could be defined as a global dialog action, to print the complete order
data including order lines. Another \"print\" action could be defined
for the sub-dialog handling order lines, to print a report with detailed
information of the current order line only.

As long as you bind action views with full qualified names, the
`ON ACTION` handler is clearly identified. However, when you do not bind
with the complete prefix of a sub-dialog or field action, the runtime
system searches for the best ` ON ACTION` handler to be executed,
according to the current focus context.

Take for example a [DIALOG](MultipleDialogs.html) instruction defining
three `ON ACTION print` handlers at the dialog, sub-dialog and field
level:

``` linenumber
01 DIALOG
02    INPUT BY NAME ... ATTRIBUTES (NAME = "cust")
03       ...
04       ON ACTION print INFIELD cust_name   -- field-level action (1)
05         ...
06       ON ACTION print                   -- sub-dialog-level action (2)
07         ...
08    END INPUT
09    ...
10    ON ACTION print                      -- dialog-level action (3)
11      ...
12 END DIALOG
```

The action views of the form will behave as follows:

- Action views bound with the name \"**print**\" will always be active,
  and fire the ` ON ACTION print` handler corresponding to the current
  focus context:
  - \(1\) is fired if the focus is in the `cust_name` field.
  - \(2\) is fired if the focus is in the `cust` sub-dialog, but not in
    `cust_name` field.
  - \(3\) is fired if the focus is in another sub-dialog as `cust`
    sub-dialog.
- Action views bound with the name \"**cust.print**\" will always be
  active, even if the focus is not the `cust` sub-dialog, and fire the
  ` ON ACTION print` handler according to the current focus context:
  - \(1\) is fired if the focus is in the `cust_name` field.
  - \(2\) is fired if the focus is in the `cust` sub-dialog, but not in
    `cust_name` field.
- Action views bound with the name \"**cust.cust_name.print**\" will
  always be active, and fire the ` ON ACTION print INFIELD cust_name`
  handler after giving the focus to the `cust_name` field.

**Warning: If the first field of a sub-dialog defines an
`ON ACTION INFIELD` with the same action name as a sub-dialog action,
and the focus is not in that sub-dialog when the user selects an action
view bound with the name *sub-dialog-name.action-name*, the runtime
system gives the focus to the first field of the sub-dialog. This field
becomes the current field, and the runtime system executes the
field-specific action handler instead of the sub-dialog action
handler.**

#### [Action view binding combinations]{#ACTION_BINDING_COMBINATIONS}

With multi-level action definitions (i.e. dialog-level,
sub-dialog-level, field-level), action binding rules generate many
combinations, resulting in different visual effects and behaviors. The
examples in the following table are provided to help you understand how
this feature works:

+---------------------------------------+--------------------------------------+--------------------+:------------------:+
| **Program ON ACTION block**           | **Explicit action view in form**     | **Visual result    | **Case#**          |
|                                       |                                      | and behavior**     |                    |
+---------------------------------------+--------------------------------------+--------------------+--------------------+
| **Singular dialog (INPUT, INPUT ARRAY, CONSTRUCT, DISPLAY ARRAY)**                                                     |
+---------------------------------------+--------------------------------------+--------------------+--------------------+
| `INPUT ...`\                          | *`none`*                             | Default action     | 1A                 |
| `  ...`\                              |                                      | view displays in   |                    |
| `  ON ACTION search`\                 |                                      | control panel,     |                    |
| `  ...`                               |                                      | always active.     |                    |
|                                       +--------------------------------------+--------------------+--------------------+
|                                       | `BUTTON b1 : search, ...`            | No default action  | 1B                 |
|                                       |                                      | view, button is    |                    |
|                                       |                                      | always active.     |                    |
|                                       +--------------------------------------+--------------------+--------------------+
|                                       | `TOOLBAR`\                           | No default action  | 1C                 |
|                                       | `  ITEM search ( ... )`              | view, toolbar      |                    |
|                                       |                                      | button is always   |                    |
|                                       |                                      | active.            |                    |
|                                       +--------------------------------------+--------------------+--------------------+
|                                       | `TOPMENU`\                           | No default action  | 1D                 |
|                                       | `  COMMAND search ( ... )`           | view, topmenu      |                    |
|                                       |                                      | command is always  |                    |
|                                       |                                      | active.            |                    |
|                                       +--------------------------------------+--------------------+--------------------+
|                                       | `BUTTONEDIT f01 = ...,`\             | No default action  | 1E                 |
|                                       | `    ACTION = search, ...`           | view, field button |                    |
|                                       |                                      | is always active.  |                    |
+---------------------------------------+--------------------------------------+--------------------+--------------------+
| **DIALOG block with global dialog action**                                                                             |
+---------------------------------------+--------------------------------------+--------------------+--------------------+
| `DIALOG ...`\                         | *`none`*                             | Default action     | 2A                 |
| `  ...`\                              |                                      | view displays in   |                    |
| `  ON ACTION search`\                 |                                      | control panel,     |                    |
| `  ...`                               |                                      | always active.     |                    |
|                                       +--------------------------------------+--------------------+--------------------+
|                                       | `BUTTON b1 : search, ...`            | No default action  | 2B                 |
|                                       |                                      | view, button is    |                    |
|                                       |                                      | always active.     |                    |
|                                       +--------------------------------------+--------------------+--------------------+
|                                       | `TOOLBAR`\                           | No default action  | 2C                 |
|                                       | `  ITEM search ( ... )`              | view, toolbar      |                    |
|                                       |                                      | button is always   |                    |
|                                       |                                      | active.            |                    |
|                                       +--------------------------------------+--------------------+--------------------+
|                                       | `TOPMENU`\                           | No default action  | 2D                 |
|                                       | `  COMMAND search ( ... )`           | view, topmenu      |                    |
|                                       |                                      | command is always  |                    |
|                                       |                                      | active.            |                    |
|                                       +--------------------------------------+--------------------+--------------------+
|                                       | `BUTTONEDIT f01 = ...,`\             | No default action  | 2E                 |
|                                       | `    ACTION = search, ...`           | view, field button |                    |
|                                       |                                      | is always active.  |                    |
+---------------------------------------+--------------------------------------+--------------------+--------------------+
| **DIALOG block with sub-dialog action**                                                                                |
+---------------------------------------+--------------------------------------+--------------------+--------------------+
| `DIALOG ...`\                         | *`none`*                             | Default action     | 3A                 |
| `  INPUT ... ATTRIBUTE(NAME="cust")`\ |                                      | view displays and  |                    |
| `    ...`\                            |                                      | is active in       |                    |
| `    ON ACTION search`\               |                                      | control panel when |                    |
| `    ...`                             |                                      | focus is in one of |                    |
|                                       |                                      | the fields of      |                    |
|                                       |                                      | `cust` group.      |                    |
|                                       +--------------------------------------+--------------------+--------------------+
|                                       | `BUTTON b1 : search, ...`            | No default action  | 3B                 |
|                                       |                                      | view, button is    |                    |
|                                       |                                      | active when focus  |                    |
|                                       |                                      | is in one of the   |                    |
|                                       |                                      | fields of `cust`   |                    |
|                                       |                                      | group.             |                    |
|                                       +--------------------------------------+--------------------+--------------------+
|                                       | `BUTTON b1 : cust.search, ...`       | No default action  | 3C                 |
|                                       |                                      | view, button is    |                    |
|                                       |                                      | always active.     |                    |
|                                       |                                      | When user clicks   |                    |
|                                       |                                      | on button, focus   |                    |
|                                       |                                      | automatically goes |                    |
|                                       |                                      | to first field of  |                    |
|                                       |                                      | `cust` group.      |                    |
|                                       +--------------------------------------+--------------------+--------------------+
|                                       | `TOOLBAR`\                           | No default action  | 3D                 |
|                                       | `  ITEM search ( ... )`              | view, toolbar      |                    |
|                                       |                                      | button is active   |                    |
|                                       |                                      | when focus is in   |                    |
|                                       |                                      | one of the fields  |                    |
|                                       |                                      | of `cust` group.   |                    |
|                                       +--------------------------------------+--------------------+--------------------+
|                                       | `TOOLBAR`\                           | No default action  | 3E                 |
|                                       | `  ITEM cust.search ( ... )`         | view, toolbar      |                    |
|                                       |                                      | button is always   |                    |
|                                       |                                      | active. When user  |                    |
|                                       |                                      | clicks on button,  |                    |
|                                       |                                      | focus              |                    |
|                                       |                                      | automatically goes |                    |
|                                       |                                      | to first field of  |                    |
|                                       |                                      | `cust` group.      |                    |
|                                       +--------------------------------------+--------------------+--------------------+
|                                       | `TOPMENU`\                           | No default action  | 3F                 |
|                                       | `  COMMAND search ( ... )`           | view, topmenu      |                    |
|                                       |                                      | command is active  |                    |
|                                       |                                      | when focus is in   |                    |
|                                       |                                      | one of the fields  |                    |
|                                       |                                      | of `cust` group.   |                    |
|                                       +--------------------------------------+--------------------+--------------------+
|                                       | `TOPMENU`\                           | No default action  | 3G                 |
|                                       | `  COMMAND cust.search ( ... )`      | view, topmenu      |                    |
|                                       |                                      | command is always  |                    |
|                                       |                                      | active. When user  |                    |
|                                       |                                      | selects command,   |                    |
|                                       |                                      | focus              |                    |
|                                       |                                      | automatically goes |                    |
|                                       |                                      | to first field of  |                    |
|                                       |                                      | `cust` group.      |                    |
|                                       +--------------------------------------+--------------------+--------------------+
|                                       | `BUTTONEDIT f01 = ...,`\             | No default action  | 3H                 |
|                                       | `    ACTION = search, ...`           | view, field button |                    |
|                                       |                                      | is active when     |                    |
|                                       |                                      | focus is in one of |                    |
|                                       |                                      | the fields of      |                    |
|                                       |                                      | `cust` group.      |                    |
|                                       +--------------------------------------+--------------------+--------------------+
|                                       | `BUTTONEDIT f01 = ...,`\             | No default action  | 3I                 |
|                                       | `    ACTION = cust.search, ...`      | view, field button |                    |
|                                       |                                      | is always active.  |                    |
|                                       |                                      | When user clicks   |                    |
|                                       |                                      | on button, focus   |                    |
|                                       |                                      | automatically goes |                    |
|                                       |                                      | to the field.      |                    |
+---------------------------------------+--------------------------------------+--------------------+--------------------+
| **DIALOG block with field specific sub-dialog action**                                                                 |
+---------------------------------------+--------------------------------------+--------------------+--------------------+
| `DIALOG ...`\                         | *`none`*                             | Default action     | 4A                 |
| `  INPUT ... ATTRIBUTE(NAME="cust")`\ |                                      | view displays and  |                    |
| `    ...`\                            |                                      | is active in       |                    |
| `    ON ACTION search INFIELD city `\ |                                      | control panel when |                    |
| `    ...`                             |                                      | focus is in the    |                    |
|                                       |                                      | field `city` only. |                    |
|                                       +--------------------------------------+--------------------+--------------------+
|                                       | `BUTTON b1 : search, ...`            | No default action  | 4B                 |
|                                       |                                      | view, button is    |                    |
|                                       |                                      | active when focus  |                    |
|                                       |                                      | is in the field    |                    |
|                                       |                                      | `city` only.       |                    |
|                                       +--------------------------------------+--------------------+--------------------+
|                                       | `BUTTON b1 : cust.search, ...`       | No default action  | 4C                 |
|                                       |                                      | view, button is    |                    |
|                                       |                                      | active when focus  |                    |
|                                       |                                      | is in the field    |                    |
|                                       |                                      | `city` only.\      |                    |
|                                       |                                      | The action view    |                    |
|                                       |                                      | binds to the field |                    |
|                                       |                                      | action.            |                    |
|                                       +--------------------------------------+--------------------+--------------------+
|                                       | `BUTTON b1 : cust.city.search, ...`  | No default action  | 4D                 |
|                                       |                                      | view, button is    |                    |
|                                       |                                      | always active.     |                    |
|                                       |                                      | When user clicks   |                    |
|                                       |                                      | on button, focus   |                    |
|                                       |                                      | automatically goes |                    |
|                                       |                                      | to `city` field.   |                    |
|                                       +--------------------------------------+--------------------+--------------------+
|                                       | `TOOLBAR`\                           | No default action  | 4E                 |
|                                       | `  ITEM search ( ... )`              | view, toolbar      |                    |
|                                       |                                      | button is active   |                    |
|                                       |                                      | when focus is in   |                    |
|                                       |                                      | the field `city`   |                    |
|                                       |                                      | only.              |                    |
|                                       +--------------------------------------+--------------------+--------------------+
|                                       | `TOOLBAR`\                           | No default action  | 4F                 |
|                                       | `  ITEM cust.search ( ... )`         | view, button is    |                    |
|                                       |                                      | active when focus  |                    |
|                                       |                                      | is in the field    |                    |
|                                       |                                      | `city` only.\      |                    |
|                                       |                                      | The action view    |                    |
|                                       |                                      | binds to the field |                    |
|                                       |                                      | action.            |                    |
|                                       +--------------------------------------+--------------------+--------------------+
|                                       | `TOOLBAR`\                           | No default action  | 4G                 |
|                                       | `  ITEM cust.city.search ( ... )`    | view, button is    |                    |
|                                       |                                      | always active.     |                    |
|                                       |                                      | When user clicks   |                    |
|                                       |                                      | on toolbar button, |                    |
|                                       |                                      | focus              |                    |
|                                       |                                      | automatically goes |                    |
|                                       |                                      | to `city` field.   |                    |
|                                       +--------------------------------------+--------------------+--------------------+
|                                       | `TOPMENU`\                           | No default action  | 4H                 |
|                                       | `  COMMAND search ( ... )`           | view, command is   |                    |
|                                       |                                      | active when focus  |                    |
|                                       |                                      | is in the field    |                    |
|                                       |                                      | `city` only.       |                    |
|                                       +--------------------------------------+--------------------+--------------------+
|                                       | `TOPMENU`\                           | No default action  | 4I                 |
|                                       | `  COMMAND cust.search ( ... )`      | view, command is   |                    |
|                                       |                                      | active when focus  |                    |
|                                       |                                      | is in the field    |                    |
|                                       |                                      | `city` only.\      |                    |
|                                       |                                      | The action view    |                    |
|                                       |                                      | binds to the field |                    |
|                                       |                                      | action.            |                    |
|                                       +--------------------------------------+--------------------+--------------------+
|                                       | `TOPMENU`\                           | No default action  | 4J                 |
|                                       | `  COMMAND cust.city.search ( ... )` | view, command is   |                    |
|                                       |                                      | always active.     |                    |
|                                       |                                      | When user selects  |                    |
|                                       |                                      | topmenu command,   |                    |
|                                       |                                      | focus              |                    |
|                                       |                                      | automatically goes |                    |
|                                       |                                      | to `city` field.   |                    |
|                                       +--------------------------------------+--------------------+--------------------+
|                                       | `BUTTONEDIT f01 = ...,`\             | No default action  | 4K                 |
|                                       | `    ACTION = search, ...`           | view, field button |                    |
|                                       |                                      | is active when     |                    |
|                                       |                                      | focus is in the    |                    |
|                                       |                                      | field `city` only. |                    |
|                                       +--------------------------------------+--------------------+--------------------+
|                                       | `BUTTONEDIT f01 = ...,`\             | No default action  | 4L                 |
|                                       | `    ACTION = cust.search, ...`      | view, field button |                    |
|                                       |                                      | is active when     |                    |
|                                       |                                      | focus is in the    |                    |
|                                       |                                      | field `city` only. |                    |
|                                       +--------------------------------------+--------------------+--------------------+
|                                       | `BUTTONEDIT f01 = ...,`\             | No default action  | 4M                 |
|                                       | `    ACTION = cust.city.search, ...` | view, field button |                    |
|                                       |                                      | is always active.  |                    |
+---------------------------------------+--------------------------------------+--------------------+--------------------+

### [Default Context Menu]{#DEFAULT_CONTEXT_MENU}

Some front-ends display a default context menu, showing all possible
(active) actions in the current context. You can define the action to be
represented in this context menu by using the [CONTEXTMENU Action
Default attribute](FSFAttributes.html#FA_CONTEXTMENU).

### [Avoiding field data validation in UNBUFFERED mode]{#ACTION_VALIDATE}

When you use the [UNBUFFERED
mode](MultipleDialogs.html#buff-unbuff-modes), the current field value
is validated before `ON ACTION` is fired. If you want to disabled this
validation (typically, for a user-defined *cancel* or *quit* action),
you can set the [validate](ActionDefaults.html#ACTDEFVALIDATE) Action
Default attribute to zero. This is especially needed in
[DIALOG](MultipleDialogs.html) instructions; in singular dialogs like
[INPUT](RecordInput.html), predefined actions like *cancel* do not
validate the current field value when `UNBUFFERED` mode is used. 

------------------------------------------------------------------------

## [Predefined Actions]{#PREDEFACTIONS}

### [Definition]{#PA_DEFINITION}

The BDL language predefines some action names for common operations of
interactive instructions. These actions are called [Predefined
Actions]{.underline}, and get a default handler implemented in the
dialog internals. For example, the *accept* action is a predefined
action that validates the current dialog.

There are three types of predefined actions:

- **Automatic actions:** actions that are automatically created and
  handled by the program dialog.
- **Special actions:** actions with a special usage, that can be fired
  asynchronously or automatically by the front-end.
- **Local actions:** actions that are handled on the front end only.

Note also that dialogs can handle `ON IDLE` events, but such timeout
events are not considered as actions.

Default decoration attributes and keyboard shortcuts are defined in the
[FGLDIR/lib/default.4ad](ActionDefaults.html) global action defaults
file for predefined actions.

### [Automatic and Local actions with same name]{#PA_AUTOLOCAL}

Some predefined actions exist as both [automatic actions]{.underline}
and as [local actions]{.underline}. The automatic actions are created
according to the dialog context. If an automatic action has to be
defined and if a local action exists with the same name, the automatic
action takes precedence over the local action. For example, if the
dialog context requires a *editcopy* runtime action, the local
*editcopy* action will not be handled by the front-end. 

### [Overwriting predefined actions with ON ACTION]{#PA_OVERWRITE}

If you define your own `ON ACTION` handler with the name of a predefined
action, the default action processing is bypassed and the program code
is executed instead.

The next code example defines an `ON ACTION` clause with the *accept*
predefined action name:

``` linenumber
01 INPUT BY NAME customer.*
02  ON ACTION accept
03     ...
04 END INPUT
```

In this case, the default behavior of the automatic *accept* action is
not performed; the user code is executed instead.

[Local actions](#PA_DEFINITION) can be overwritten in the same manner,
however, this is not recommended (use your own action names).

### [Predefined actions enabled according to context]{#PA_AUTO_ACTIVATE}

Some predefined actions (such as *insert*, *append* and *delete* in
[INPUT ARRAY](InputArray.html)) are enabled and disabled automatically
by the dialog according to the context (for example, when a static array
is full, the *insert* and *append* actions get disabled).

Even when overwriting such actions with your own action handler, the
runtime system will continue to enable and disabled the actions
automatically. 

### [Binding action views to predefined actions]{#PA_BINDING}

As for user-defined actions, if you design forms with action views using
predefined action names, they will automatically attach themselves to
the actions of the interactive instructions. It is also possible to
define default images, texts, comments and accelerator keys in the
[Action Defaults](ActionDefaults.html) resource file for the predefined
actions.

### [List of predefined actions]{#PA_LIST}

  --------------------- ------------------------------------------------------------------------------------------------------ --------------------------------- -------------
  **Action Name**       **Description**                                                                                        **ON ACTION block is required**   **Context**
  **Runtime Actions**   **Automatically created by the runtime system**                                                                                           
  `accept`              Validates the current interactive instruction (singular dialogs only)                                  can overwrite                     \(1\)
  `cancel`              Cancels the current interactive instruction (singular dialogs only)                                    can overwrite                     \(1\)
  `close`               Triggers a cancel key in the current interactive instruction (by default)                              can overwrite                     \(7\)
  `insert`              Inserts a new row before current row                                                                   can overwrite                     \(2\)
  `append`              Appends a new row at the end of the list                                                               can overwrite                     \(2\)
  `delete`              Deletes the current row                                                                                can overwrite                     \(2\)
  `nextrow`             Moves to the next row (only if list using one flat screen record)                                      can overwrite                     \(8\)
  `prevrow`             Moves to the previous row (only if list using one flat screen record)                                  can overwrite                     \(8\)
  `firstrow`            Moves to the first row (only if list using one flat screen record)                                     can overwrite                     \(8\)
  `lastrow`             Moves to the last row (only if list using one flat screen record)                                      can overwrite                     \(8\)
  `help`                Shows the help topic defined by the `HELP` clause                                                      can overwrite                     \(1\)
  `editcopy`            Copy selected rows (or current row if MRS is off) to the clipboard                                     can overwrite                     \(9\)
  **Special Actions**   **Special behavior**                                                                                                                      
  `interrupt`           Sends an interruption request to the program when processing                                           no                                \(5\)
  `dialogtouched`       Sent by the front end each time the user modifies the value of a field                                 yes                               \(7\)
  **Local Actions**     **Handled by the front end**                                                                                                              
  `editcopy`            Copies the current selected text to the clipboard                                                      can overwrite                     \(7\)
  `editcut`             Copies the current selected text to the clipboard and removes the text from the current input widget   can overwrite                     \(7\)
  `editpaste`           Pastes the clipboard content to the current input widget                                               can overwrite                     \(7\)
  `nextfield`           Moves to the next field in the form                                                                    can overwrite                     \(3\)
  `prevfield`           Moves to the previous field in the form                                                                can overwrite                     \(3\)
  `nextrow`             Moves to the next row in the list                                                                      can overwrite                     \(4\)
  `prevrow`             Moves to the previous row in the list                                                                  can overwrite                     \(4\)
  `firstrow`            Moves to the first row in the list                                                                     can overwrite                     \(4\)
  `lastrow`             Moves to the last row in the list                                                                      can overwrite                     \(4\)
  `nextpage`            Moves to the next page in the list                                                                     can overwrite                     \(4\)
  `prevpage`            Moves to the previous page in the list                                                                 can overwrite                     \(4\)
  `nexttab`             Moves to the next page in the folder                                                                   can overwrite                     \(6\)
  `prevtab`             Moves to the previous page in the folder                                                               can overwrite                     \(6\)
  --------------------- ------------------------------------------------------------------------------------------------------ --------------------------------- -------------

Contexts description (last column in above table):

1.  [CONSTRUCT](Construct.html), [INPUT](RecordInput.html),
    [PROMPT](Prompt.html), [INPUT ARRAY](InputArray.html) and [DISPLAY
    ARRAY](DisplayArray.html).
2.  [INPUT ARRAY](InputArray.html) only.
3.  [CONSTRUCT](Construct.html), [INPUT](RecordInput.html) and [INPUT
    ARRAY](InputArray.html).
4.  [INPUT ARRAY](InputArray.html) and [DISPLAY
    ARRAY](DisplayArray.html).
5.  Only possible when no interactive instruction is active.
6.  Possible in any kind of interactive instruction ([MENU](Menus.html)
    included).
7.  [DIALOG](MultipleDialogs.html), [CONSTRUCT](Construct.html),
    [INPUT](RecordInput.html), [PROMPT](Prompt.html), [INPUT
    ARRAY](InputArray.html) and [DISPLAY ARRAY](DisplayArray.html).
8.  [INPUT ARRAY](InputArray.html) and [DISPLAY
    ARRAY](DisplayArray.html) on flat screen-record.
9.  [DISPLAY ARRAY](DisplayArray.html) only.

------------------------------------------------------------------------

## [Keyboard Accelerator Names]{#ACCELNAMES}

### [Accelerator keys]{#ACCEL_KEYS}

Some parts of the user interface can define accelerators keys. With
[Action Defaults](ActionDefaults.html), you can define up to four
accelerator keys for the same action, by setting the *acceleratorName*,
*acceleratorName2*, *acceleratorName3* and *acceleratorName4*
attributes.

If no accelerators are defined in the Action Defaults, the runtime
system sets default accelerators for [predefined
actions](#PREDEFACTIONS), according to the user interface mode. For
example, the *accept* action will get the `Return` and `Enter` keys in
[GUI](FglTerms.html#GRAPHICAL_USER_INTERFACE) mode; the `Escape` key
would be used in [TUI](FglTerms.html#TEXT_USER_INTERFACE) mode.

If you want to force an action to have no accelerator, specify
\"`none`\" as the accelerator name.

If one of the user-defined actions uses an accelerator that would
normally be used for a predefined action, the runtime system does not
set that accelerator for the predefined action. For example (in GUI
mode), if you define an `ON ACTION quit` with an action default using
the accelerator \"`Escape`\", the *cancel* predefined action will not
get the \"`Escape`\" default accelerator. User settings take precedence
over defaults.

Note that text edition and navigation accelerators such as `Home` and
`End` are usually local to the widget. According to the context, such
accelerators might be eaten by the widget and will not fire the action
bound to the corresponding accelerator defined in the Action Defaults.
For example, even if the Action Defaults for *firstrow* action defines
the `Home` accelerator, when using an [INPUT ARRAY](InputArray.html),
the Home keystroke will jump to the beginning of the edit field, not the
first row of the list. 

[The following table lists all the keyboard accelerator
names:]{#ACCEL_KEY_LIST}

  ---------------------- -------------------------------------------------------------------------------------------------
  **Accelerator Name**   **Description**
  `none`                 Special name indicating the runtime system must not set any default accelerator for the action.
  `0-9`                  Decimal digits from 0 to 9
  `A-Z`                  Letters from A to Z
  `F1-F35`               The functions keys
  `BackSpace`            The BACKSPACE key (do not confuse with DELETE key)
  `Delete`               The DELETE key (navigation keyboard group)
  `Down`                 The DOWN key (arrow keyboard group)
  `End`                  The END key (navigation keyboard group)
  `Enter`                The ENTER key (numeric keypad, see [Note](#NOTE))
  `Escape`               The ESCAPE key
  `Home`                 The HOME key (navigation keyboard group)
  `Insert`               The INSERT key (navigation keyboard group)
  `Left`                 The LEFT key (arrow keyboard group)
  `Minus`                The MINUS sign key (-)
  `Next`                 The NEXT PAGE key (navigation keyboard group)
  `Prior`                The PRIOR PAGE key (navigation keyboard group)
  `Return`               The RETURN key (alphanumeric keypad, see [Note](#NOTE))
  `Right`                The RIGHT key (arrow keyboard group)
  `Space`                The SPACE-BAR key
  `Tab`                  The TABULATION Key
  `Up`                   The UP key (arrow keyboard group)
  ---------------------- -------------------------------------------------------------------------------------------------

#### [Note:]{#NOTE}

The \"`Enter`\" key represents the ENTER key available on the numeric
keypad of standard keyboards, while \"`Return`\" represents the RETURN
key of the alphanumeric keyboard. By default, the validation action is
configured to accept both \"`Enter`\" and \"`Return`\" keys. See the
[Action Defaults](ActionDefaults.html) file.

### [Accelerator key modifiers]{#ACCEL_KEY_MOD}

All of the key names listed in the previous table can be combined with
CONTROL / SHIFT / ALT modifiers, by adding \"`Control-`\", \"`Shift-`\",
or \"`Alt-`\" to the name of the accelerator.

For example:

    Control-P
    Shift-Alt-F12
    Control-Shift-Alt-Z

------------------------------------------------------------------------

## [Interruption Handling]{#INTERRUPTION}

### Why do we need interruption handling?

When the BDL program executes an interactive instruction, the front end
can send action events based on user actions. When the program performs
a long process like a loop, a report, or a database query, the front end
has no control.  You might want to permit the user to stop a
long-running process.

### How to program the detection of user interruptions

To detect user interruptions, you define an action view with the name
\'interrupt\'. When the runtime system takes control to process program
code, the front end automatically enables the local \'interrupt\' action
to let the user send an asynchronous interruption request to the
program.

**Warning: The front end can not handle interruption requests properly
if the display generates a lot of network traffic. In this case, the
front end has to process a lot of user interface modifications and has
no time to detect a mouse click on the \'interrupt\' action view. A
typical example is a program doing a loop from 1 to 10000, just
displaying the value of the counter to a field and doing a refresh. This
would generate hundreds of AUI tree modifications in a short period of
time. In such a case, we recommended that you calculate a modulo and
display steps 10 by 10 or 100 by 100.**

### Interruption handling example:

Form file \"f1.per\":

``` linenumber
01 LAYOUT
02  GRID
03  {
04   Step: [pb                    ]
05         [sb                    ]
06  }
07  END
08 END
09 ATTRIBUTES
10 PROGRESSBAR pb = FORMONLY.progress, VALUEMIN=0, VALUEMAX=100;
11 BUTTON sb : interrupt, TEXT="Stop";
12 END
```

Program:

``` linenumber
01 MAIN
02  DEFINE i,j INTEGER
03  DEFER INTERRUPT
04  OPEN FORM f1 FROM "f1"
05  DISPLAY FORM f1
06  LET int_flag=FALSE
07  FOR i=1 TO 100
08    DISPLAY i TO progress 
09    CALL ui.Interface.refresh()
10    FOR j=1 TO 1000 -- Loop to emulate processing
11      DISPLAY j
12      IF int_flag THEN EXIT FOR END IF
13    END FOR
14    IF int_flag THEN EXIT FOR END IF
15  END FOR
16 END MAIN
```

------------------------------------------------------------------------

## [Detecting data changes immediately]{#DIRTY}

You can use a special predefined action to detect user changes
immediately and execute code in the program to set up your interactive
instruction. This special action has the name \"*dialogtouched*\" and
must be declared with an `ON ACTION` clause to be enabled:

``` linenumber
01  DIALOG
02    ...
03    ON ACTION dialogtouched
04       LET changing = TRUE
05       CALL DIALOG.setActionActive("dialogtouched", FALSE)
06    ...
07  END DIALOG
```

The *dialogtouched* action works for any field controlled by the current
interactive instruction, and with any type of [form
field](FormSpecFiles.html#FF_FORM_FIELD): Every time the user modifies
the value of a field (without leaving the field), the
`ON ACTION dialogtouched` block will be executed; This can be triggered
by typing characters in a text editor field, clicking a checkbox /
radiogroup, or modifying a slider.

You may only want to detect the beginning of a record modification, to
enable a \"save\" action for example. To prevent further *dialogtouched*
action events, just disable that action with a
[setActionActive()](ClassDialog.html#setActionActive) call. If the
*dialogtouched* action is enabled, the `ON ACTION` block will be fired
each time the user modifies the value in the current field.

**Warning: Note that you must disable / enable the *dialogtouched*
action in accordance with the status of the dialog: If this action is
enabled, the `ON ACTION` block will be fired each time the user types
characters (or modifies the value with copy/paste) in the current field;
This can generate a lot of network traffic.**

The current field may contain some text that does not represent a valid
value of the underlying field data type. For example, a form field bound
to a [DATE](DataTypes.html#DT_DATE) variable may contain only a part of
a valid date string, such as `[12/24/    ]`. For this reason, the target
variable cannot hold the current text displayed on the screen when the
`ON ACTION dialogtouched` code is executed, even when using the
`UNBUFFERED` mode.

To avoid data validation on action code execution, the *dialogtouched*
action is defined with `validate="no"` in the default [Action
Defaults](ActionDefaults.html) file. This is mandatory when using the
`UNBUFFERED` mode; otherwise the runtime would try to copy the input
buffer into the program variable when a *dialogtouched* action is fired.
Since the text of the current field will in most cases contain only a
part of a valid data value, that would always result in a conversion
error.

------------------------------------------------------------------------

## [Controlling data validation when an action is fired]{#VALIDATE}

When using the `UNBUFFERED` mode of interactive instructions such as
[INPUT](RecordInput.html) or [DIALOG](MultipleDialogs.html), if the user
triggers an action, the current field data is checked and loaded in the
target variable bound to the form field. For example, if the user types
a wrong date (or only a part of a date) in a field using a
[DATE](DataTypes.html#DT_DATE) variable and then clicks on a button to
fire an action, the runtime system will throw an error and will not
execute the `ON ACTION` block corresponding to the button.

If you want to prevent data validation for some actions, you can use the
`validate` Action Default attribute. This attribute instructs the
runtime not  to copy the input buffer text into the program variable
(requiring input buffer text to match the target data type).

The `validate` Action Default attribute can be set in the global action
default file, or at the form level, in a line of the [ACTION
DEFAULTS](FormSpecFiles.html#SECTION_ACTDEFS) section.

------------------------------------------------------------------------

## [Windows closed by the user]{#XCROSS_CLOSE}

In graphical applications, windows can be closed by the user, for
example by pressing `ALT+F4` or by clicking the cross button in the
upper-left corner of the window. A [Predefined Action](#PREDEFACTIONS)
is dedicated to this specific event, named *close*. When the user closes
a graphical window, the program gets a *close* action.

### [The close action in DIALOG]{#close_in_dialog}

When executing a [DIALOG](MultipleDialogs.html) instruction, the *close*
action executes the `ON ACTION close` block, if defined. Otherwise, the
*close* action is mapped to the *cancel* action if an `ON ACTION cancel`
handler is defined. If neither `ON ACTION close`, nor `ON ACTION cancel`
are defined, nothing will happen if the user tries to close the window
with the X cross button or an `ALT+F4` keystroke. The
[int_flag](Programs.html#PV_INT_FLAG) register will not be set in the
context of `DIALOG`.

### [The close action in singular dialogs]{#close_in_singular}

When executing an [INPUT](RecordInput.html), [INPUT
ARRAY](InputArray.html), [CONSTRUCT](Construct.html), [DISPLAY
ARRAY](DisplayArray.html) or [PROMPT](Prompt.html), if an
`ON ACTION close` handler is defined, the handler code will be executed.
Otherwise, the *close* action acts the same as the *cancel* [predefined
action](#PREDEFACTIONS). So by default when the user clicks the X cross
button, the interactive instruction stops
and [int_flag](Programs.html#PV_INT_FLAG) is set to 1. If there is an
explicit `ON ACTION cancel` block defined, int_flag is set to 1 and the
user code below `ON ACTION cancel` will be executed. Note that if the
`CANCEL=FALSE` option is set, no *cancel* and no *close* action will be
created, and you must write an `ON ACTION close` handler to proceed with
the *close* action. In this case, the int_flag register will not be set
when the *close* action is fired.

### [The close action in MENU]{#close_in_menu}

When executing a [MENU](Menus.html) instruction, if an `ON ACTION close`
handler is defined, the handler code will be executed. If no specific
*close* action handler is defined, the code of the
`COMMAND KEY(INTERRUPT)` or `ON ACTION cancel` will be executed, if
defined. if neither `COMMAND KEY(INTERRUPT)` nor `ON ACTION cancel` are
defined, nothing happens and the program stays in the `MENU`
instruction. Regarding the *close* action, the value of
[int_flag](Programs.html#PV_INT_FLAG) is undefined in a `MENU`
instruction.

### [Close action example]{#close_example}

You typically implement a *close* action handler to open a confirmation
dialog box as in following example:

``` linenumber
01 INPUT BY NAME cust_rec.*
02    ...
03    ON ACTION close
04      IF msg_box_yn("Are you sure you want to close this window?") == "y" THEN
05        EXIT INPUT
06      END IF
07    ...
08 END INPUT
```
