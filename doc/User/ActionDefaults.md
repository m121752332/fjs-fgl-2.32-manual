[Back to Contents](../index.html)

------------------------------------------------------------------------

# [Action Defaults]{#PAGE_HEADER}

Summary:

- [Basics](#BASICS)
- [Syntax](#SYNTAX)
- [Usage](#USAGE)
  - [Action Default attributes](#ACTDEFATTRIBUTES)
  - [Global Action Defaults](#GLOBALACTDEFS)
  - [Form Action Defaults](#FORMACTDEFS)
  - [Defining keyboard accelerators](#ACTDEFACCEL)
  - [Default accelerators for predefined actions](#DEFACCPREDEFACTIONS)
  - [Controlling data validation when an action is
    fired](#ACTDEFVALIDATE)
  - [Text attribute shows default action view](#ACTDEFTEXT)
- [Examples](#EXAMPLES)

*See also:* [Dynamic User Interface](DynamicUI.html), [Predefined
Actions](InteractionModel.html#PREDEFACTIONS), [Action Defaults and
MENU](Menus.html#DEFAULT_ACTIONS).

------------------------------------------------------------------------

### [Basics]{#BASICS}

Action Defaults allow you to define default attributes for graphical
objects ([action views](InteractionModel.html)) associated with
[actions](InteractionModel.html).

For example, you can specify the default text, comment, and image to use
on graphical objects (buttons, toolbar items, and so on) bound to an
action across all forms in the application.

You can centralize common action defaults in a global action defaults
(.4ad) file. You can also define action defaults at the form level.

------------------------------------------------------------------------

### [Syntax]{#SYNTAX}

Action defaults are defined in the .4ad file with the following syntax:

`<ActionDefaultList>`\
`  <ActionDefault name="`*`action-name`*`" `[`[`]{.underline}` `*`attribute`*`=`*`value`*` `[`[...]`]{.underline}` `[`]`]{.underline}` />`\
`  [...]`\
`</ActionDefaultList>`

#### Notes:

1.  *action-name* identifies the action.
2.  *attribute* is the name of an attribute.
3.  *value* defines the value to be assigned to *attribute*.

------------------------------------------------------------------------

### [Usage]{#USAGE}

Action defaults are provided to centralize the decoration attributes and
accelerator keys for [action views](InteractionModel.html) (graphical
objects associated with actions). It is strongly recommended that you
centralize these decoration attributes to avoid specifying them in all
the source files that define the same action view.

Each attribute of an [action view element](FormSpecFiles.html) bound to
an [action handler in the program](InteractionModel.html) will
automatically be set to the value defined in the Action Defaults, if
there is no value explicitly specified in the element definition for
that attribute.

Note that in some situations, the action view can be bound to an action
by specifying a [sub-dialog and/or field name
prefix](InteractionModel.html#BINDING_ACTIONS). For those views, the
action defaults defined with the corresponding [action name]{.underline}
will be used to set the attributes with the default values. In other
words, the prefix will be ignored. For example, if an action view is
defined with the name \"*custlist.append*\", it will get the action
defaults defined for the \"*append*\" action.

**Warning: Action Defaults are applied only once, to newly created
elements. Dynamic changes are not re-applied to action views. For
example, if you first load a toolbar, then you load a global Action
Defaults file, the attributes of the toolbar items will not be updated
with the last loaded Action Defaults. If you dynamically create action
views (like TopMenu or ToolBar), the action defaults are not applied, so
you must set all decoration attributes by hand.**

Action Defaults can be defined globally for the whole program or at the
form level. Global Action Defaults are loaded from a default 4ad file or
by using the [ui.Interface.loadActionDefaults()](ClassInterface.html)
method. Form Action Defaults can be specified in the [form
file](FormSpecFiles.html#SECTION_ACTDEFS) or can be loaded with the
[ui.Form.loadActionDefaults()](ClassForm.html) method.

For example, in most cases a *print* action needs a text decoration
\"Print\", with a printer icon image and a CONTROL-P accelerator key.
Those attributes can be centralized in the Action Defaults. Some action
views of the *print* action may need specific attributes; for example,
if the current form handles customer addresses, the comment attribute of
a *print* button might be \"Print current customer information\". In
this case you can define Action Defaults at the form level, which have a
higher priority than the global Action Defaults. Additionally, if some
action views must have a different image in the same form, you can
specify the image attribute in the definition of each element to
overwrite the defaults. For example, the toolbar button bound to the
*print* action might have a small image, while the *print* button in the
form might have a large one.

The final attribute values used for graphical elements are set based on
the following priority:

1.  Attribute defined in the action view element definition itself.
2.  Attribute defined for the element action in the form Action
    Defaults.
3.  Attribute defined for the element action in the global Action
    Defaults.

The following code defines a
[BUTTON](FormSpecFiles.html#FF_ITEMTYPE_BUTTON) in the form
specification file:

``` linenumber
01 ATTRIBUTES
02  BUTTON b1: print, TEXT="Do Print";
03 END
```

if the form Action Defaults define:

`<ActionDefaultList>`\
`  <ActionDefault name="print" image="smiley" comment="Print orders" acceleratorName="control-p" />`\
`</ActionDefaultList>`

and the global Action Defaults define:

`<ActionDefaultList>`\
`  <ActionDefault name="print" text="Print" image="printer" />`\
`</ActionDefaultList>`

the button object will get the following final attribute values:

- `text = "Do Print"`
- `image = "smiley"`
- `comment = "Print orders"`

and the accelerator will be CONTROL-P.

#### [Action Default attributes]{#ACTDEFATTRIBUTES}

The following attributes can be defined with Action Defaults:

  ----------------------------------- ---------------------------------------------------------
  **Attribute**                       **Description**

  `name = `*`string`*                 This attribute identifies the action. See also
                                      [predefined action
                                      names](InteractionModel.html#PREDEFACTIONS).

  `text = `*`string`*                 The default label to be displayed in action views
                                      (typically, the text of buttons).

  `comment = `*`string`*              The default help text for this action (typically,
                                      displayed as bubble help).

  `image = `*`string`*                The default image file to be displayed in the action
                                      view.

  `acceleratorName = `*`string`*      The default accelerator key that can trigger the action,
                                      as defined in
                                      [Accelerators](InteractionModel.html#ACCELNAMES).

  `acceleratorName2 = `*`string`*     The second default accelerator key that can trigger the
                                      action, as defined in
                                      [Accelerators](InteractionModel.html#ACCELNAMES).

  `acceleratorName3 = `*`string`*     The third default accelerator key that can trigger the
                                      action, as defined in
                                      [Accelerators](InteractionModel.html#ACCELNAMES).

  `acceleratorName4 = `*`string`*     The fourth default accelerator key that can trigger the
                                      action, as defined in
                                      [Accelerators](InteractionModel.html#ACCELNAMES).

  `defaultView = `*`string`*          Indicates whether the front-end must show the default
                                      action view (buttons in control frame).\
                                      Values can be:\
                                      - `"no"` the default action view is never visible.\
                                      - `"yes"` the default action view is always visible, if
                                      the action is visible
                                      ([setActionHidden](ClassDialog.html#setActionHidden)).\
                                      - `"auto"` the default action view is visible if no other
                                      action view is explicitly defined and the action is
                                      visible
                                      ([setActionHidden](ClassDialog.html#setActionHidden)).\
                                      The default is `"auto"`.

  `contextMenu = `*`string`*          Indicates whether the front-end must render the action in
                                      the default context menu.\
                                      Values can be:\
                                      - `"no"` the context menu option is never visible.\
                                      - `"yes"` the context menu option is always visible, if
                                      the action is visible
                                      ([setActionHidden](ClassDialog.html#setActionHidden)).\
                                      - `"auto"` the context menu option is visible if no other
                                      action view is explicitly defined and the action is
                                      visible
                                      ([setActionHidden](ClassDialog.html#setActionHidden)).\
                                      The default is `"yes"`.

  `validate = `*`string`*             Defines the behavior of data validation when the action
                                      is fired.\
                                      Values can be:\
                                      - `"no"` no data validation is done (field text only
                                      available in input buffer).\
                                      By default, data validation is driven by the dialog mode
                                      (`UNBUFFERED` or default mode).
  ----------------------------------- ---------------------------------------------------------

#### [Global Action Defaults]{#GLOBALACTDEFS}

Global Action Defaults are defined in an XML file with the \"`4ad`\"
extension. By default, the runtime system searches for a file named
\"`default.4ad`\" in the current directory. If this file does not exist,
it searches in the directories defined in the
[DBPATH](EnvironmentVariables.html#EV_DBPATH)/[FGLRESOURCEPATH](EnvironmentVariables.html#EV_FGLRESOURCEPATH)
environment variable. If no file was found using the environment
variable(s), standard action default settings are loaded from the
\"`FGLDIR/lib/default.4ad`\" file.

**Warning: Global Action Defaults must be defined in a unique file; you
cannot combine several \"`4ad`\" files.**

You can override the default search by loading a specific Action
Defaults file with the
[ui.Interface.loadActionDefaults()](ClassInterface.html) method. This
method accepts a filename [with]{.underline} or [without]{.underline}
the \"`4ad`\" extension. If you omit the file extension (recommended),
the runtime system adds the extension automatically. If the file does
not exist in the current directory, the directories defined in the
[DBPATH](EnvironmentVariables.html#EV_DBPATH)/[FGLRESOURCEPATH](EnvironmentVariables.html#EV_FGLRESOURCEPATH)
environment variable are searched.

#### [Form Action Defaults]{#FORMACTDEFS}

Action Defaults can be defined at the form level. When action defaults
are defined in the form file, action views get the attributes defined
locally.

You can define form action defaults with the [ACTION
DEFAULTS](FormSpecFiles.html#SECTION_ACTDEFS) section in the form
specification file.  If you want to use common action defaults in
several forms, you can use the [preprocessor](Preprocessor.html) include
directive to integrate an external file.

You can also load Form Action Defaults dynamically with the
[ui.Form.loadActionDefaults()](ClassForm.html) method. This method
accepts a filename [with]{.underline} or [without]{.underline} the
\"`4ad`\" extension. If you omit the file extension (recommended), the
runtime system adds the extension automatically. If the file does not
exist in the current directory, the directories defined in the
[DBPATH](EnvironmentVariables.html#EV_DBPATH)/[FGLRESOURCEPATH](EnvironmentVariables.html#EV_FGLRESOURCEPATH)
environment variable are searched.

#### [Defining keyboard accelerators]{#ACTDEFACCEL}

When using the `ON ACTION` clause in a dialog instruction, action
defaults accelerators are applied in both
[GUI](FglTerms.html#GRAPHICAL_USER_INTERFACE) and
[TUI](FglTerms.html#TEXT_USER_INTERFACE) mode. For backward
compatibility, this is not done in TUI mode when using the `ON KEY`
clause.

The traditional `ON KEY` clause in a dialog like
[INPUT](RecordInput.html) implicitly defines the *acceleratorName*
attribute for the action, and the corresponding action default
accelerator will be ignored. For example, when you define an
`ON KEY(F10)` block, the first accelerator will be \"F10\", even if an
action default defines an accelerator \"F5\" for the action \"F10\".
However, you can set other accelerators with the *acceleratorName2, *
*acceleratorName3* and *acceleratorName4* attributes in action defaults.

**Warning: In [TUI](FglTerms.html#TEXT_USER_INTERFACE) mode, actions
created with ON KEY do not get accelerators of Action Defaults; Only
actions defined with ON ACTION will get accelerators of Action
Defaults.**

In menus, the behavior is a bit different, see [the COMMAND and COMMAND
KEY clause in MENU](Menus.html#COMMAND).

#### [Default accelerators for predefined actions]{#DEFACCPREDEFACTIONS}

If no accelerator is specified in action defaults for a [Predefined
Action](InteractionModel.html#PREDEFACTIONS), the runtime system sets
one or more default accelerators according to the user interface mode.
For example, the **accept** action will get the `Return` and `Enter`
keys in [GUI](FglTerms.html#GRAPHICAL_USER_INTERFACE) mode, but in
[TUI](FglTerms.html#TEXT_USER_INTERFACE) mode, the `Escape` key would be
used.

If you want to force an action to have no accelerator, you can use
\"`none`\" as accelerator name.

#### [Controlling data validation when an action is fired]{#ACTDEFVALIDATE}

The `validate` attribute defines the behavior of the dialog for data
validation when an action is fired. For more details, see [Interaction
Model](InteractionModel.html#VALIDATE).

#### [Text attribute shows default action view]{#ACTDEFTEXT}

When creating actions with `ON KEY` (or `COMMAND KEY` without a command
name in a [MENU](Menus.html)), the default action view (i.e. button in
action frame) is invisible. However, if you define a `text` attribute
for a function key or a control-x key, the default button is made
visible. Remember you can control the visibility of the default action
view with the `defaultView` Action Default attribute.

See also [Setting Key Labels](DynamicUI.html#SETTING_KEY_LABELS), a
feature supported for backward compatibility. 

------------------------------------------------------------------------

### [Examples]{#EXAMPLES}

#### Example 1: Loading a Action Defaults file:

Some Action Defaults in XML format (exit action has [Localized
Strings](LocalizedStrings.html)):

``` linenumber
01 <ActionDefaultList>
02    <ActionDefault name="print" text="Print" image="printer" comment="Print report" />
03    <ActionDefault name="modify" text="Update" comment="Update the record" />
04    <ActionDefault name="exit" text="Quit" image="byebye" comment="Exit the program" validate="no" >
05        <LStr text="common.exit.text" comment="common.exit.comment" />
06    </ActionDefault>
07 </ActionDefaultList>
```

The program loading the action defaults file:

``` linenumber
01 MAIN
02   CALL ui.Interface.loadActionDefaults("mydefaults")
03 END MAIN
```

#### Example 2: Actions defaults in a form file:

``` linenumber
01 ACTION DEFAULTS
02   ACTION accept ( COMMENT="Commit order record changes" )
03   ACTION cancel ( TEXT="Stop", IMAGE="stop", ACCELERATOR=SHIFT-F2, VALIDATE=NO )
04   ACTION print ( COMMENT="Print order information", ACCELERATOR=CONTROL-P, ACCELERATOR2=F5 )
05   ACTION zoom1 ( COMMENT="Open items list", CONTEXTMENU=NO )
06   ACTION zoom2 ( COMMENT="Open customers list" )
07 END
```
