[Back to Contents](../index.html)

------------------------------------------------------------------------

# [The Dialog class]{#PAGE_HEADER}

Summary:

- [Syntax](#SYNTAX)
- [Methods](#METHODS)
- [Usage](#USAGE)
  - [The DIALOG object instance](#DIALOG-instance)
  - [Terminating the dialog](#accept)
  - [Passing the dialog object to a function](#function-param)
  - [Getting the current dialog object](#getCurrent)
  - [Getting the total number of rows in a list](#getArrayLength)
  - [Setting the total number of rows of a list](#setArrayLength)
  - [Registering the next field to jump to](#nextField)
  - [Getting the current row of a list](#getCurrentRow)
  - [Setting the current row in a list](#setCurrentRow)
  - [Getting the current item having focus](#getCurrentItem)
  - [Getting the input buffer of a field](#getFieldBuffer)
  - [Getting the touched flag of a field](#getFieldTouched)
  - [Setting the touched flag of a field](#setFieldTouched)
  - [Current form used by the dialog](#getForm)
  - [Identifying actions with dialog class methods](#ident_actions)
  - [Enabling/disabling Actions](#setActionActive)
  - [Identifying fields with dialog class methods](#ident_fields)
  - [Enabling/disabling Fields](#setFieldActive)
  - [Inserting a new row in a list](#insertRow)
  - [Inserting a new node in a tree](#insertNode)
  - [Appending a new row in a list](#appendRow)
  - [Appending a new node in a tree](#appendNode)
  - [Deleting a row from a list](#deleteRow)
  - [Deleting a node from a tree](#deleteNode)
  - [Deleting all rows from a list](#deleteAllRows)
  - [Checking form level validation rules](#validate)
  - [Handling default action view visibility](#setActionHidden)
  - [Setting the UNBUFFERED mode](#setDefaultUnbuffered)
  - [Setting TTY attributes for cells in
    lists](#setting%20TTY%20Attributes)
  - [Defining the row selection mode](#setSelectionMode)
  - [Querying row selection](#isRowSelected)
  - [Setting row selection](#setSelectionRange)
  - [Serialize data of the selected rows](#selectionToString)
- [Examples](#EXAMPLES)
  - [Disable fields dynamically](#EXAMPLE_1)
  - [Get form and hide fields](#EXAMPLE_2)
  - [Pass a dialog object to a function](#EXAMPLE_3)
  - [Set display attributes to cells](#EXAMPLE_4)

See also: [Built-in classes](BuiltInClasses.html), [Interaction
Model](InteractionModel.html), [Multiple Dialogs](MultipleDialogs.html),
[Windows and Forms](WindowsAndForms.html)

------------------------------------------------------------------------

The **Dialog** class is a [built-in class](BuiltInClasses.html) that
provides an interface to an interactive instruction such as
[INPUT](RecordInput.html).

## [Syntax]{#SYNTAX}:

`ui.Dialog`\
 

------------------------------------------------------------------------

## [Methods:]{#METHODS}

+--------------------------------------------------------------------------------------------------------------------------+-------------------------------------+
| **Class Methods**                                                                                                                                              |
+--------------------------------------------------------------------------------------------------------------------------+-------------------------------------+
| **Name**                                                                                                                 | **Description**                     |
+--------------------------------------------------------------------------------------------------------------------------+-------------------------------------+
| [`getCurrent`](#getCurrent)`( )`                                                                                         | Returns the current dialog object.  |
|                                                                                                                          | NULL if no current active dialog.   |
+--------------------------------------------------------------------------------------------------------------------------+-------------------------------------+
| [`setDefaultUnbuffered`](#setDefaultUnbuffered)`( v ``INTEGER`` )`                                                       | Sets the default of the             |
|                                                                                                                          | `UNBUFFERED` attribute for the next |
|                                                                                                                          | dialogs.                            |
+--------------------------------------------------------------------------------------------------------------------------+-------------------------------------+
| **Object Methods**                                                                                                                                             |
+--------------------------------------------------------------------------------------------------------------------------+-------------------------------------+
| **Name**                                                                                                                 | **Description**                     |
+--------------------------------------------------------------------------------------------------------------------------+-------------------------------------+
| [`accept`](#accept)`( )`                                                                                                 | Validates all dialog fields.        |
+--------------------------------------------------------------------------------------------------------------------------+-------------------------------------+
| [`appendRow`](#appendRow)`( arrname ``STRING`` )`                                                                        | Append a row at the end of the      |
|                                                                                                                          | list.                               |
+--------------------------------------------------------------------------------------------------------------------------+-------------------------------------+
| [`appendNode`](#appendNode)`( arrname ``STRING``, pos ``INTEGER`` )`\                                                    | Append a new tree node at the end   |
| `  ``RETURNING INTEGER`                                                                                                  | of the list.                        |
+--------------------------------------------------------------------------------------------------------------------------+-------------------------------------+
| [`deleteRow`](#deleteRow)`( arrname ``STRING``, pos ``INTEGER`` )`                                                       | Deletes row at position *pos*.      |
+--------------------------------------------------------------------------------------------------------------------------+-------------------------------------+
| [`deleteNode`](#deleteNode)`( arrname ``STRING``, pos ``INTEGER`` )`                                                     | Deletes a tree node at position     |
|                                                                                                                          | *pos*.                              |
+--------------------------------------------------------------------------------------------------------------------------+-------------------------------------+
| [`deleteAllRows`](#deleteAllRows)`( arrname ``STRING ``)`                                                                | Delete all rows of the list.        |
+--------------------------------------------------------------------------------------------------------------------------+-------------------------------------+
| [`getArrayLength`](#getArrayLength)`( arrname ``STRING`` )`\                                                             | Returns the total number of rows in |
| `  ``RETURNING INTEGER`                                                                                                  | a list.                             |
+--------------------------------------------------------------------------------------------------------------------------+-------------------------------------+
| [`getCurrentItem`](#getCurrentItem)`( ) ``RETURNING STRING`                                                              | Returns the current item having the |
|                                                                                                                          | focus. This can be a field, list or |
|                                                                                                                          | action.                             |
+--------------------------------------------------------------------------------------------------------------------------+-------------------------------------+
| [`getCurrentRow`](#getCurrentRow)`( arrname ``STRING`` )`\                                                               | Returns the current row of a list.  |
| `  ``RETURNING INTEGER`                                                                                                  |                                     |
+--------------------------------------------------------------------------------------------------------------------------+-------------------------------------+
| [`getFieldBuffer`](#getFieldBuffer)`( fieldname ``STRING`` )`\                                                           | Returns the current input buffer of |
| `  ``RETURNING STRING`                                                                                                   | the field identified by             |
|                                                                                                                          | *fieldname*.                        |
+--------------------------------------------------------------------------------------------------------------------------+-------------------------------------+
| [`getFieldTouched`](#getFieldTouched)`( fieldlist ``STRING`` )`\                                                         | Returns TRUE if the TOUCHED flag of |
| `  ``RETURNING STRING`                                                                                                   | one of the the specified fields is  |
|                                                                                                                          | set.                                |
+--------------------------------------------------------------------------------------------------------------------------+-------------------------------------+
| [`getForm`](#getForm)`()`\                                                                                               | Returns the current form used by    |
| `  ``RETURNING ``ui.Form`                                                                                                | this dialog.                        |
+--------------------------------------------------------------------------------------------------------------------------+-------------------------------------+
| [`insertRow`](#insertRow)`( arrname ``STRING``, pos ``INTEGER`` )`                                                       | Inserts a row before position       |
|                                                                                                                          | *pos*.                              |
+--------------------------------------------------------------------------------------------------------------------------+-------------------------------------+
| [`insertNode`](#insertNode)`( arrname ``STRING``, pos ``INTEGER`` )`                                                     | Inserts a new tree node before      |
|                                                                                                                          | position *pos*.                     |
+--------------------------------------------------------------------------------------------------------------------------+-------------------------------------+
| [`isRowSelected`](#isRowSelected)`( arrname ``STRING``, pos ``INTEGER`` )`                                               | Returns TRUE if the row at *pos* is |
|                                                                                                                          | selected.                           |
+--------------------------------------------------------------------------------------------------------------------------+-------------------------------------+
| [`nextField`](#nextField)`( fieldname ``STRING ``)`                                                                      | Registers the name of the next      |
|                                                                                                                          | field that must get the focus when  |
|                                                                                                                          | control returns to the dialog.      |
+--------------------------------------------------------------------------------------------------------------------------+-------------------------------------+
| [`selectionToString`](#selectionToString)`( arrname ``STRING`` )`                                                        | Builds a tab-separated value list   |
|                                                                                                                          | from the selected rows.             |
+--------------------------------------------------------------------------------------------------------------------------+-------------------------------------+
| [`setArrayLength`](#setArrayLength)`( arrname ``STRING``, v ``INTEGER`` )`                                               | Sets the total number of rows in a  |
|                                                                                                                          | list for paged mode.                |
+--------------------------------------------------------------------------------------------------------------------------+-------------------------------------+
| [`setActionActive`](#setActionActive)`( actname ``STRING``, v ``INTEGER`` )`                                             | Enables or disables the action      |
|                                                                                                                          | identified by *actname*.            |
+--------------------------------------------------------------------------------------------------------------------------+-------------------------------------+
| [`setActionHidden`](#setActionHidden)`( actname ``STRING``, v ``INTEGER`` )`                                             | Hides or shows the default action   |
|                                                                                                                          | view identified by *actname*.       |
+--------------------------------------------------------------------------------------------------------------------------+-------------------------------------+
| [`setCurrentRow`](#setCurrentRow)`( arrname ``STRING``, row`` INTEGER``)`                                                | Change the current row in a list.   |
+--------------------------------------------------------------------------------------------------------------------------+-------------------------------------+
| [`setFieldActive`](#setFieldActive)`( fieldlist ``STRING``, v ``INTEGER`` )`                                             | Enables or disables one or several  |
|                                                                                                                          | fields identified by *fieldlist*.   |
+--------------------------------------------------------------------------------------------------------------------------+-------------------------------------+
| [`setFieldTouched`](#setFieldTouched)`( fieldlist ``STRING``, v ``INTEGER`` )`                                           | Sets the TOUCHED flag of one or     |
|                                                                                                                          | several fields identified by        |
|                                                                                                                          | *fieldlist*.                        |
+--------------------------------------------------------------------------------------------------------------------------+-------------------------------------+
| [`setCellAttributes`](#setCellAttributes)`( attarr ``ARRAY OF RECORD`` )`                                                | Defines decoration attributes for   |
|                                                                                                                          | each cell (singular dialogs only).  |
+--------------------------------------------------------------------------------------------------------------------------+-------------------------------------+
| [`setArrayAttributes`](#setArrayAttributes)`( arrname ``STRING``, attarr ``ARRAY OF RECORD`` )`                          | Defines decoration attributes for   |
|                                                                                                                          | each cell (multiple dialogs).       |
+--------------------------------------------------------------------------------------------------------------------------+-------------------------------------+
| [`setSelectionMode`](#setSelectionMode)`( arrname ``STRING``, mode ``INTEGER`` )`                                        | Defines the row selection mode.     |
|                                                                                                                          | Possible values are:\               |
|                                                                                                                          |  0 = single row selection,\         |
|                                                                                                                          |  1 = multi-row selection.           |
+--------------------------------------------------------------------------------------------------------------------------+-------------------------------------+
| [`setSelectionRange`](#setSelectionRange)`( arrname ``STRING``, start ``INTEGER``, end ``INTEGER``, value ``INTEGER`` )` | Sets the selection flags for a      |
|                                                                                                                          | range of rows.                      |
+--------------------------------------------------------------------------------------------------------------------------+-------------------------------------+
| [`validate`](#validate)`( fieldlist ``STRING`` )`                                                                        | Check form-level validation rules   |
|                                                                                                                          | for the list of fields.\            |
|                                                                                                                          | Returns error number if problem.    |
+--------------------------------------------------------------------------------------------------------------------------+-------------------------------------+

------------------------------------------------------------------------

## [Usage:]{#USAGE}

### [The DIALOG object instance]{#DIALOG-instance}

This class provides an interface to the interactive instructions
[INPUT](RecordInput.html), [INPUT ARRAY](InputArray.html), [DISPLAY
ARRAY](DisplayArray.html), [CONSTRUCT](Construct.html), and
[MENU](Menus.html).

The `DIALOG` keyword is a pre-defined object variable. To get an
instance of this class, use `DIALOG` inside the interactive instruction
block:

``` linenumber
01 INPUT BY NAME custid, custname
02   ON ACTION disable
03     CALL DIALOG.setFieldActive("custid",0)
04 END INPUT
```

### [Passing the dialog object to a function]{#function-param}

The dialog object is only valid during the execution of the interactive
instruction. Using the `DIALOG` keyword outside a dialog instruction
block results in a compilation error. However, you can pass the object
to a function, in order to write common dialog configuration code:

``` linenumber
01 INPUT BY NAME custid, custname
02   BEFORE INPUT
03     CALL setupDialog(DIALOG)
04 END INPUT
05 
06 FUNCTION setupDialog(d)
07   DEFINE d ui.Dialog
08   IF user_group = "admin" THEN
09      CALL d.setActionActive("delete",1)
10      CALL d.setActionActive("convert",1)
11   ELSE
12      CALL d.setActionActive("delete",0)
13      CALL d.setActionActive("convert",0)
14   END IF
15 END FUNCTION
```

### [Getting the current dialog object]{#getCurrent}

If needed, you can get the current active dialog object with the
`ui.Dialog.getCurrent()` class method:

``` linenumber
01 FUNCTION field_disable(name)
02   DEFINE name STRING
03   DEFINE d ui.Dialog
04   LET d = ui.Dialog.getCurrent()
05   IF d IS NOT NULL THEN
06      CALL d.setFieldActive(name, FALSE)
07   END IF
08 END FUNCTION
```

The method returns [NULL](Programs.html#PC_NULL) if there is no current
active dialog.

### [Terminating the dialog]{#accept}

You can use the `accept()` method to validate field input and terminate
the dialog. This method is equivalent to the `ACCEPT INPUT` /
`ACCEPT DISPLAY` / `ACCEPT DIALOG` instructions. The method is provided
as a 3GL alternative to the `ACCEPT` control instructions, if you need
for example to terminate the dialog in a function, outside the context
of a dialog block, where control instructions cannot be used.

See [ACCEPT DIALOG](MultipleDialogs.html#ACCEPT_DIALOG) for more
details.

### [Getting the total number of rows in a list]{#getArrayLength}

The `getArrayLength("`*`screen-array`*`")` method can be used to
retrieve the total number of rows of an `INPUT ARRAY` or `DISPLAY ARRAY`
list. You must pass the name of the screen array to identify the list:

``` linenumber
01  DIALOG
02       DISPLAY ARRAY custlist TO sa_custlist.*
03         BEFORE ROW
04          MESSAGE "Row count: " || DIALOG.getArrayLength("sa_custlist")
05          ...
06       END DISPLAY
07       INPUT ARRAY ordlist TO sa_ordlist.*
08         BEFORE ROW
09          MESSAGE "Row count: " || DIALOG.getArrayLength("sa_ordlist")
10          ...
11       END INPUT
12          ...
```

### [Setting the total number of rows in a list]{#setArrayLength}

The `setArrayLength("`*`screen-array`*`", `*`length`*`)` method is used
to specify the total number of rows of an `INPUT ARRAY` or
`DISPLAY ARRAY` list when using the [paged
mode](MultipleDialogs.html#paged-mode). You must pass the name of the
screen array to identify the list, followed by an integer expression
defining the number of rows. When using a [dynamic array](Arrays.html)
without `ON FILL BUFFER` you don\'t need to specify the total number of
rows to the `DIALOG` instruction: It is defined by the number of
elements in the array. However, when using the [paged
mode](MultipleDialogs.html#paged-mode) in a `DISPLAY ARRAY`, the total
number of rows does not correspond to the elements in the program array,
because the program array holds only a page of the whole list. In any
other cases, a call to this method is just ignored.

### [Registering the next field to jump to]{#nextField}

The `nextField(`*`field-specification`*`)` method can be used register
the name of the next field that must get the focus when control goes
back to the dialog. This method is similar to the [NEXT FIELD
instruction](MultipleDialogs.html#NEXT_FIELD), except that it does not
implicitly break the program flow. If you want to get the same behavior
as `NEXT FIELD`, the method call must be followed by a
`CONTINUE DIALOG / INPUT / CONSTRUCT` instruction. 

Since this method takes an expression as parameter, you can write
generic code, when the name of the target field is not known at compile
time. In the next example, the `check_value()` function returns a field
name where the value does not satisfy the validation rules:

``` linenumber
01    DEFINE fn STRING
02    ...
03    ON ACTION save
04          IF ( fn := check_values() ) IS NOT NULL THEN
05              CALL DIALOG.nextField(fn)
06              CONTINUE DIALOG
07          END IF
08          CALL save_data()
09          ...
```

The first parameter identifies the form field, see [Identifying fields
in dialog methods](#ident_fields) for more details.

### [Getting the current row of a list]{#getCurrentRow}

The `getCurrentRow("`*`screen-array`*`")` method can be used to retrieve
the current row of an `INPUT ARRAY` or `DISPLAY ARRAY` list. You must
pass the name of the screen array to identify the list:

``` linenumber
01  DIALOG
02       DISPLAY ARRAY custlist TO sa_custlist.*
03         BEFORE ROW
04          MESSAGE "Current row: " || DIALOG.getCurrentRow("sa_custlist")
05          ...
06       END DISPLAY
07       INPUT ARRAY ordlist TO sa_ordlist.*
08         BEFORE ROW
09          MESSAGE "Current row: " || DIALOG.getCurrentRow("sa_ordlist")
10          ...
11       END INPUT
12          ...
```

### [Setting the current row in a list]{#setCurrentRow}

If you want to change the current row in an `INPUT ARRAY` or
`DISPLAY ARRAY` list, you can use the
`setCurrentRow("`*`screen-array`*`", `*`index`*`)` method. You must pass
the name of the screen array to identify the list, and the new row
number:

``` linenumber
01  DEFINE x INTEGER
02  DIALOG
03       DISPLAY ARRAY custlist TO sa_custlist.*
04          ...
05       END DISPLAY
06       ON ACTION goto_x
07          CALL DIALOG.setCurrentRow("sa_custlist", x)
08          ...
```

Note that moving to a different row with `setCurrentRow()` will not
trigger [control blocks](MultipleDialogs.html#CONTROL_BLOCKS) such as
`AFTER ROW`. This method will not set the focus either; You need to use
`NEXT FIELD` to set the focus to a list (this works with `DISPLAY ARRAY`
as well as with `INPUT ARRAY`).

If [multi-row selection](#setSelectionMode) is enabled, all selection
flags of rows are cleared, and the new current row gets automatically
selected.

### [Getting the current item having focus]{#getCurrentItem}

The `getCurrentItem()` method returns the name of the current form item
having the focus:

- If the focus is on an action view (typically, a
  [BUTTON](FormSpecFiles.html#FF_ITEMTYPE_BUTTON) in the form layout),
  `getCurrentItem()` returns the name of the corresponding action. Note
  that if several action views a bound to the same action handler with a
  unique name, there is no way to distinguish which action view has the
  focus.
- If the focus is in a simple field controlled by an
  [INPUT](MultipleDialogs.html#sub-dialog-INPUT) or
  [CONSTRUCT](MultipleDialogs.html#sub-dialog-CONSTRUCT) sub-dialogs,
  `getCurrentItem()` returns the *\[tab-name.\]field-name* of that
  current field. The *tab-name.* prefix is added if a `FROM` clause is
  used with an explicit list of fields. No prefix is added if
  `FROM screen-record.*` is used or if `BY NAME` clause is used.
- If the focus is in a list controlled by a [DISPLAY
  ARRAY](MultipleDialogs.html#sub-dialog-DISPLAY-ARRAY) sub-dialog,
  `getCurrentItem()` returns the *screen-array* name identifying the
  list.
- If the focus is in a field of a list controlled by an [INPUT
  ARRAY](MultipleDialogs.html#sub-dialog-INPUT-ARRAY) sub-dialog,
  `getCurrentItem()` returns *screen-array.field-name*, identifying both
  the list and the current field. Note however that in some context, the
  current field is undefined. For example when entering the
  `INPUT ARRAY` sub-dialog, `getCurrentItem()` will return the
  *screen-array* only when in the `BEFORE INPUT` control block.

### [Getting the input buffer of a field]{#getFieldBuffer}

The `getFieldBuffer("`*`field-specification`*`")` method returns the
current input buffer of the specified field. The input buffer is used by
the dialog to synchronize form fields and program variables. In some
situations, especially when using the [BUFFERED
mode](MultipleDialogs.html#buff-unbuff-modes) or in a
[CONSTRUCT](Construct.html), you may want to access that input buffer.

The *field-specification* is a string containing the field qualifier,
with an optional prefix (\"`[table.]column`\").

``` linenumber
01    LET buff = DIALOG.getFieldBuffer("customer.cust_name")
```

The input buffer can be set with:

- A [DISPLAY TO](RecordDisplay.html#DISPLAY_TO) or [DISPLAY BY
  NAME](RecordDisplay.html#DISPLAY_BY_NAME) instruction
- The
  [fgl_dialog_setbuffer()](BuiltInFunctions.html#BF_FGL_DIALOG_SETBUFFER)
  function (only for the current field)

See [Identifying fields in dialog methods](#ident_fields) for more
details about field name specification.

### [Getting the TOUCHED flag of a field]{#getFieldTouched}

The `getFieldTouched("`*`field-list`*`")` method returns TRUE if the
[TOUCHED flag](MultipleDialogs.html#touched-flag) of the specified field
is set.

The *field-list* is a string containing the field qualifier, with an
optional prefix (\"`[table.]column`\"), a table prefix followed by a dot
and an asterisk (\"`table.*`\"), or a simple asterisk (\"`*`\"). See
[Identifying fields in dialog methods](#ident_fields) for more details
about the *field -list* specification.

The next code example checks if a specific field has been touched:

``` linenumber
01    AFTER FIELD cust_name
02       IF DIALOG.getFieldTouched("customer.cust_address") THEN
03          ...
```

If the parameter is a screen record following by dot-asterisk, the
method checks the touched flags of all the fields that belong to the
screen record:

``` linenumber
01    ON ACTION quit
02       IF DIALOG.getFieldTouched("customer.*") THEN
03          ...
```

When passing a simple asterisk (\*) to the method, the runtime system
will check all fields used by the dialog:

``` linenumber
01    ON ACTION quit
02       IF DIALOG.getFieldTouched("*") THEN
03          ...
```

See [Identifying fields in dialog methods](#ident_fields) for more
details about field name specification.

### [Setting the TOUCHED flag of a field]{#setFieldTouched}

The `setFieldTouched("`*`field-list`*`")` method can be used to change
the [TOUCHED flag](MultipleDialogs.html#touched-flag) of the specified
field(s).

The *field-list* is a string containing the field qualifier, with an
optional prefix (\"`[table.]column`\"), or a table prefix followed by a
dot and an asterisk (\"`table.*`\"). See [Identifying fields in dialog
methods](#ident_fields) for more details about the *field -list*
specification.

You typically use this method to set the touched flag when assigning a
variable, to emulate a user input. Remember when using the
[UNBUFFERED](MultipleDialogs.html#buff-unbuff-modes) mode, you don\'t
need to [DISPLAY](RecordDisplay.html#DISPLAY_BY_NAME) the value to the
fields. The `setFieldTouched()` method is provided as a 3GL replacement
for the [DISPLAY](RecordDisplay.html#DISPLAY_BY_NAME) instructions to
set the touched flags.

``` linenumber
01    ON ACTION zoom_city
02       LET p_cust.cust_city = zoom_city()
02       CALL DIALOG.setFieldTouched("customer.cust_city", TRUE)
03          ...
```

If the parameter is a screen record following by dot-asterisk, the
method checks the touched flags of all the fields that belong to the
screen record. You typically use this to reset the touched flags of a
group of fields, after modifications have been saved to the database, to
get back to the initial state of the dialog:

``` linenumber
01    ON ACTION save
02       CALL save_cust_record()
03       CALL DIALOG.setFieldTouched("customer.*", FALSE)
04          ...
```

Note that the touched flags are reset to false when using an INPUT ARRAY
list, every time you leave the modified row.

### [Current form used by the dialog]{#getForm}

The `getForm()` method returns a [ui.Form](ClassForm.html) object as a
handle to the current form used by the dialog. Use this form object to
modify elements of the current form. For example, you can hide some
parts of the form with the [ui.Form.setElementHidden()](ClassForm.html)
method. The runtime system is able to detect hidden fields and exclude
them from the input list. See [Example 2](#EXAMPLE_2).

### [Identifying actions in dialog methods]{#ident_actions}

In methods like [setActionActive()](#setActionActive), the first
parameter identifies the action object to be modified. This parameter
can be full-qualified or partly-qualified. If you don\'t specify a
full-qualified name, the action object will be identified according to
the focus context.

The action name specification can be any of the following:

- *action-name*
- *dialog-name.action-name*
- *dialog-name.field-name.action-name*
- *field-name.action-name* (singular dialogs only)

Here *action-name* identifies the name of the action specified in
`ON ACTION `*`action-name`* or `COMMAND "`*`action-name`*`"` handlers,
while *dialog-name* identifies the [singular
dialog](RecordInput.html#SYNTAX) or
[sub-dialog](MultipleDialogs.html#sub-dialogs) and *field-name* defines
the field bound to the action
[INFIELD](InteractionModel.html#ON_ACTION_INFIELD) clause of
`ON ACTION`.

**Warning: The action name must be passed in lowercase letters.**

The runtime system will raise the error
**[-8089](FglErrors.html#-8089)** if the action specified by
*\[dialog-name.\]\[field-name.\]action-name* can not be found within the
current dialog.

In the [DIALOG instruction](MultipleDialogs.html), actions can be
prefixed with the [sub-dialog
identifier](MultipleDialogs.html#binding-actions). However, if methods
like `setActionActive()` are called in the context of the sub-dialog,
the prefix can be omitted. When using a field-specific action defined
with the [INFIELD](InteractionModel.html#ON_ACTION_INFIELD) clause of
`ON ACTION`, you can identify the action with the full-qualified name
*dialog-name.field-name.action-name*. Like sub-dialog actions, if you
specify only *action-name*, the runtime system will search for the
action object according to the focus context.

When using a singular dialog like [INPUT](RecordInput.html), you can
identify field-specific actions by *field-name.action-name* if the
dialog was defined without a `NAME` attribute.

For more details, see [Binding action views to action
handlers](InteractionModel.html#BINDING_ACTIONS).

### [Enabling/Disabling Actions]{#setActionActive}

Dialog actions can be enabled and disabled with the
`setActionActive("`*`action-specification`*`", `*`boolean`*`)` dialog
method:

``` linenumber
01    BEFORE DIALOG
02       CALL DIALOG.setActionActive("zoom", FALSE)
```

The first parameter identifies the action object of the dialog, see
[Identifying actions in dialog methods](#ident_actions) for more
details.

In [GUI](FglTerms.html#GRAPHICAL_USER_INTERFACE) applications,
push-buttons triggering actions should normally be disabled if the
current context / situation makes the corresponding action invalid or
unusable. For example, a \"print\" button should be disabled if there is
nothing to print. The ` setActionActive()` method is typically used to
enable/disable actions according to the context.

The second parameter of the method must be a boolean expression that
evaluates to 0 (`FALSE`) or 1 (`TRUE`).

To simplify action activation, you can write a common \"setup\" function
which centralizes all rules to enable/disable actions. This function can
then be called from any place in the `DIALOG` instruction, passing the
DIALOG object as parameter. See [Example 3](#EXAMPLE_3).

You can also use the [INFIELD](InteractionModel.html#ON_ACTION_INFIELD)
clause of `ON ACTION` to automatically disable an action if the focus
leaves the specified field.

### [Handling default action view visibility]{#setActionHidden}

The [Default View](InteractionModel.html#DEFAULT_ACTION_VIEWS) (and
[Context Menu](ActionDefaults.html#ACTDEFATTRIBUTES) option) of an
action can made visible or invisible with the
`setActionHidden("`*`action`*`", `*`value`*`)` dialog method:

``` linenumber
01    ON ACTION hide
02       CALL DIALOG.setActionHidden( "confirm", 1 )
```

The first parameter identifies the action object of the dialog, see
[Identifying actions in dialog methods](#ident_actions) for more
details.

Values of the second parameter can be 1 or 0.

### [Identifying fields in dialog methods]{#ident_fields}

In methods like [setFieldActive()](#setFieldActive), the first parameter
identifies the form field (or, for some methods, a list of fields) to be
modified. The form field names can be full-qualified or
partly-qualified. 

**Warning: In such methods, fields are identified by the form field name
specification, not the program variable name used by the dialog.
Remember form fields are bound to program variables with the binding
clause of dialog instruction
(`INPUT `*`variable-list`*` FROM `*`field-list`*,
`INPUT BY NAME `*`variable-list`*,
`CONSTRUCT BY NAME `*`sql`*` ON `*`column-list`*,
`CONSTRUCT `*`sql`*` ON `*`column-list`*` FROM `*`field-list`*,
`INPUT ARRAY `*`array-name`*` FROM `*`screen-array.*`*).**

The field name specification can be any of the following:

- *field-name*
- *table-name.field-name*
- *screen-record-name.field-name*
- FORMONLY*.field-name*

Here are some examples:

- `"cust_name"`,
- `"customer.cust_name"`,
- `"cust_screen_record.cust_name"`,
- `"item_screen_array.item_label"`,
- `"formonly.total"`,
- `"customer.*"` (only some methods accept the \"dot asterisk\"
  notation)

When no field name prefix is used, the first form field matching that
field name will be used. If the field specification is invalid (i.e. no
field in the current dialog matches the field specification), the method
will throw the error **[-1373](FglErrors.html#-1373)**.

**Warning: When using a prefix in the field name specification, it must
match the [field prefix]{.underline} assigned by the dialog according to
the field binding method used at the beginning of the interactive
statement: When no screen-record has been explicitly specified in the
field binding clause (for example, when using
`INPUT BY NAME `*`variable-list`*), the [field prefix]{.underline} must
be the database table name (or `FORMONLY`) used in the form file, or any
valid screen-record using that field. But when the `FROM` clause of the
dialog specifies an explicit screen-record (for example, in
`INPUT `*`variable-list`*` FROM `*`screen-record.* / field-list-with-screen-record-prefix`*
or `INPUT ARRAY `*`array-name`*` FROM `*`screen-array.*`*) the [field
prefix]{.underline} must be the screen-record name used in the `FROM`
clause.**

Some methods like [validate()](#validate),
[setFieldActive()](#setFieldActive),
[setFieldTouched()](#setFieldTouched),
[getFieldTouched()](#getFieldTouched) can take a list of fields as
parameter, by using the \"dot-asterisk \" notation (screen-record.\*).
This way you can check, query or change a complete list of fields in one
method call:

``` linenumber
01    ON ACTION save
02       CALL save_cust_record()
03       CALL DIALOG.setFieldTouched("customer.*", FALSE)
04          ...
```

### [Enabling/Disabling Fields]{#setFieldActive}

Form fields used by the dialog can be enabled/disabled with the
`setFieldActive("`*`field-list`*`", `*`boolean`*`)` method. When a field
is disabled, it is still visible, but the user cannot edit the value.

``` linenumber
01    ON CHANGE cust_name
02       CALL DIALOG.setFieldActive( "customer.cust_addr", (rec.cust_name IS NOT NULL) )
```

The *field-list* is a string containing the field qualifier, with an
optional prefix (\"`[table.]column`\"), or a table prefix followed by a
dot and an asterisk (\"`table.*`\"). See [Identifying fields in dialog
methods](#ident_fields) for more details about the *field -list*
specification.

Note that you should not disable all fields of a dialog, otherwise the
dialog execution stops (at least one field must get the focus during a
dialog execution).

See also [Example 1](#EXAMPLE_1).

### [Inserting a new row in a list]{#insertRow}

The `insertRow("`*`screen-array`*`", `*`index`*`)` method is just a
basic row creation function, to insert a row in the list at a given
position. It does not set the current row or raise any `BEFORE ROW` /
`BEFORE INSERT` / `AFTER INSERT` / `AFTER ROW` control blocks. It is
quite similar to inserting a new element in the program array, except
the internal registers are automatically updated (like the total number
of rows returned by [getArrayLength()](#getArrayLength)). If the list
was decorated with [cell attributes](#setArrayAttributes), the program
array defining the attributes will also be synchronized. If [multi-row
selection](#setSelectionMode) is enabled, selection flags of existing
rows are kept. Selection information is synchronized (i.e. flags are
shifted down) for all rows after the new inserted row.

**Warning: This method should not be called in control blocks such as
`BEFORE ROW`, `AFTER ROW`, `BEFORE INSERT`, `AFTER INSERT`,
`BEFORE DELETE`, `AFTER DELETE`, but it can safely be used in an
`ON ACTION` block.**

After the method is called, a new row is created in the program array,
so you can assign values to the variables before the control goes back
to the user. The `getArrayLength()` method will return the new row
count.

Note that the method does not set the current row and does not give the
focus to the list; you need to call `setCurrentRow()` and execute [NEXT
FIELD](MultipleDialogs.html#NEXT_FIELD) if you want to give the focus.

**Warning: The insertRow() method must not be used when controlling a
treeview. You must usethe [insertNode()](#insertNode) method instead.**

The method takes two parameters:

1.  The name of the screen array identifying the list.
2.  The index where the row has to be inserted (starts at 1).

If the index is greater as the number of rows, a new row will be
appended at the end or the list. This will be equivalent to call the
`appendRow()` method.

**Warning: If the list is empty, getCurrentRow() will return zero. So
you must test this and use 1 instead to reference the first row
otherwise you can get -1326 errors when using the program array.**

Following code example shows a user-define action to insert ten rows in
the list at the current position:

``` linenumber
01    ON ACTION insert_some_rows
02       LET r = DIALOG.getCurrentRow("sa")
03       IF r == 0 THEN LET r = 1 END IF
04       FOR i = 10 TO 1 STEP -1
05          CALL DIALOG.insertRow("sa", r)
06          LET p_items[r].item_quantity = 1.00
07       END FOR
```

### [Inserting a new node in a tree]{#insertNode}

The `insertNode("`*`screen-array`*`", `*`index`*`)` method is similar to
[insertRow()](#insertRow), except that it has to be used when the dialog
controls a [treeview](TreeViews.html).

This method must be used when modifying the array of a treeview during
the execution of the dialog, for example when implementing a [dynamic
tree](TreeViews.html#DYNAMIC_FILLING) with `ON EXPAND` / `ON COLLAPSE`
triggers. Before the execution of the dialog, you can fill the program
array directly. This includes the context of `BEFORE DISPLAY` or
`BEFORE DIALOG` control blocks.

The method takes two parameters:

1.  The name of the screen array identifying the tree.
2.  The index of the next sibling node in the program array (starts at
    1).

When adding rows for a treeview, the id of the parent node and new node
matters because that information is used to build the internal tree
structure. When calling `insertNode()`, you pass the index of the next
sibling node. In the program array, the parent-id member of the new node
will automatically be initialized with the value of the parent-id of the
next sibling node, then the internal tree structure is re-built.

### [Appending a new row in a list]{#appendRow}

The `appendRow("`*`screen-array`*`")` method is just a basic row
creation function to append a row to the end of the list. It does not
set the current row or raise any `BEFORE ROW` / `BEFORE INSERT` /
`AFTER INSERT` / `AFTER ROW` control blocks. It is quite similar to
appending a new element to the program array, except the internal
registers are automatically updated (like the total number of rows
returned by [getArrayLength()](#getArrayLength)). If the list was
decorated with [cell attributes](#setArrayAttributes), the program array
defining the attributes will also be synchronized. If [multi-row
selection](#setSelectionMode) is enabled, selection flags of existing
rows are kept. New row is inserted at the end of the list with selection
flag set to zero.

**Warning: This method should not be called in control blocks such as
`BEFORE ROW`, `AFTER ROW`, `BEFORE INSERT`, `AFTER INSERT`,
`BEFORE DELETE`, `AFTER DELETE`, but it can safely be used in an
`ON ACTION` block.**

After the method is called, a new row is created in the program array,
so you can assign values to the variables before the control goes back
to the user. The `getArrayLength()` method will return the new row
count.

Note that the method does not set the current row and does not give the
focus to the list; you need to call `setCurrentRow()` and execute [NEXT
FIELD](MultipleDialogs.html#NEXT_FIELD) if you want to give the focus.

The `appendRow()` method does not create a [temporary
row](MultipleDialogs.html#temporary-rows) as the implicit append action
of `INPUT ARRAY`; The row is considered as permanent once it is added.

The method takes only one parameter:

1.  The name of the screen array identifying the list.

Following code example implements a user-defined to append ten rows at
the end of the list:

``` linenumber
01    ON ACTION append_some_rows
02       FOR i = 1 TO 10
03          CALL DIALOG.appendRow("sa")
04          LET r = DIALOG.getArrayLength("sa")
05          LET p_items[r].item_quantity = 1.00
06       END FOR
```

### [Appending a new node in a tree]{#appendNode}

The `appendNode("`*`screen-array`*`", `*`index`*`)` method has to be
used to add a new node under a given parent, when the dialog controls a
[treeview](TreeViews.html).

This method must be used when modifying the array of a treeview during
the execution of the dialog, for example when implementing a [dynamic
tree](TreeViews.html#DYNAMIC_FILLING) with `ON EXPAND` / `ON COLLAPSE`
triggers. Before the execution of the dialog, you can fill the program
array directly. This includes the context of `BEFORE DISPLAY` or
`BEFORE DIALOG` control blocks.

The method takes two parameters:

1.  The name of the screen array identifying the tree.
2.  The index of the parent node in the program array (starts at 1).

When adding rows for a treeview, the id of the parent node and new node
matters because that information is used to build the internal tree
structure. When calling `appendNode()`, you pass the index of the parent
node under which the new node will be appended. In the program array,
the parent-id member of the new node will automatically be initialized
with the value of the id of the parent node identifier by the *index*
passed as parameter, then the internal tree structure is re-built.

If the parent index is zero, a new root node will be appended.

The methods returns the index of the new inserted node.

In the program array, the parent-id member of the new node will
automatically be initialized with the value of the id member of the
parent node identified by the index.

### [Deleting a row from a list]{#deleteRow}

The `deleteRow("`*`screen-array`*`", `*`index`*`)` method is just a
basic row deletion function. It does not reset the current row or raise
any `BEFORE DELETE` / `AFTER DELETE` / `AFTER ROW` / `BEFORE ROW`
control blocks (except in some particular situation as described below).
It is quite similar to deleting an element to the program array, except
that internal registers are automatically updated (like the total number
of rows returned by [getArrayLength()](#getArrayLength)). If the list
was decorated with [cell attributes](#setArrayAttributes), the program
array defining the attributes will also be synchronized. If [multi-row
selection](#setSelectionMode) is enabled, selection information is
synchronized (i.e. selection flags are shifted up) for all rows after
the deleted row.

**Warning: This method should not be called in control blocks such as
`BEFORE ROW`, `AFTER ROW`, `BEFORE INSERT`, `AFTER INSERT`,
`BEFORE DELETE`, `AFTER DELETE`, but it can safely be used in an
`ON ACTION` block.**

After the method is called, the row does no more exist in the program
array, and the `getArrayLength()` method will return the new row count.

If the `deleteRow()` method is called during an `INPUT ARRAY`, and after
the call no more rows are in the list, the dialog will automatically
append a new [temporary row](MultipleDialogs.html#temporary-rows) if the
focus is in the list, to let the user enter new data. **When using AUTO
APPEND = FALSE attribute, no temporary row will be created and the
current row register will be automatically changed to make sure that it
will not be greater as the total number of rows.**

If `deleteRow()` method is called during an `INPUT ARRAY` or
`DISPLAY ARRAY` that [has the focus]{.underline}, control blocks such as
`BEFORE ROW` / `BEFORE FIELD` will be executed if you delete [the
current row]{.underline}. This is required to reset the internal state
of the dialog.

The method takes two parameters:

1.  The name of the screen array identifying the list.
2.  The index of the row to be deleted (starts at 1).

If you pass zero as row index, the method does nothing (if no rows are
in the list, `getCurrentRow()` returns zero).

Following code example implements a user-defined action to remove the
rows that have a specific property:

``` linenumber
01    ON ACTION delete_invalid_rows
02       FOR r = 1 TO DIALOG.getArrayLength("sa")
03          IF NOT s_orders[t].is_valid THEN
04            CALL DIALOG.deleteRow("sa",r)
05            LET r = r - 1
06          END IF
07       END FOR
```

### [Deleting a node from a tree]{#deleteNode}

The `deleteNode("`*`screen-array`*`", `*`index`*`)` method is similar to
[deleteRow()](#deleteRow), except that it has to be used when the dialog
controls a [treeview](TreeViews.html).

This method must be used when modifying the array of a treeview during
the execution of the dialog, for example when implementing a [dynamic
tree](TreeViews.html#DYNAMIC_FILLING) with `ON EXPAND` / `ON COLLAPSE`
triggers. Before the execution of the dialog, you can fill the program
array directly. This includes the context of `BEFORE DISPLAY` or
`BEFORE DIALOG` control blocks.

The method takes two parameters:

1.  The name of the screen array identifying the tree.
2.  The index of the node in the program array that has to be deleted
    (starts at 1).

The main difference with [deleteRow()](#deleteRow) is that
`deleteNode()` will remove recursively all child nodes before removing
the node identified by index. 

If the index is zero, all root nodes will be deleted from the tree.

### [Deleting all rows of a list]{#deleteAllRows}

The `deleteAllRows("`*`screen-array`*`")` method removes all the rows of
a list driven by a `DISPLAY ARRAY` or `INPUT ARRAY`. This is equivalent
to a `deleteRow()` call, but instead of deleting one particular row, it
removes all rows of the specified list.

**Warning: This method should not be called in control blocks such as
`BEFORE ROW`, `AFTER ROW`, `BEFORE INSERT`, `AFTER INSERT`,
`BEFORE DELETE`, `AFTER DELETE`, but it can safely be used in an
`ON ACTION` block.**

After the method is called, all rows are deleted from the program array,
and the `getArrayLength()` method will return zero.

The method takes the name of the screen-array as parameter.

If the `deleteAllRows()` method is called during an `INPUT ARRAY`, the
dialog will automatically append a new [temporary
row](MultipleDialogs.html#temporary-rows) if the focus is in the list,
to let the user enter new data. **When using AUTO APPEND = FALSE
attribute, no temporary row will be created and the current row register
will be automatically changed to make sure that it will not be greater
as the total number of rows.**

If `deleteAllRows()` method is called during an `INPUT ARRAY` or
`DISPLAY ARRAY` that [has the focus]{.underline}, the `BEFORE ROW`
control block will be executed if you delete the current row. This is
required to reset the internal state of the dialog.

If the list was decorated with [cell attributes](#setArrayAttributes),
the program array defining the attributes will be cleared. If [multi-row
selection](#setSelectionMode) is enabled, selection flags are cleared.

### [Checking form level validation rules]{#validate}

In order to execute [NOT NULL](FSFAttributes.html#FA_NOT_NULL),
[REQUIRED](FSFAttributes.html#FA_REQUIRED) and
[INCLUDE](FSFAttributes.html#FA_INCLUDE) validation rules defined in the
[form specification files](FormSpecFiles.html), you can call the
`validate("`*`field-list`*`")` method by passing a list of fields or
screen records as parameter. The method returns zero if success and the
input error code of the first field which does not satisfy the
validation rules.

Note that the current field is always checked, even if it is not part of
the validation field list. This is mandatory, otherwise the current
field may be left with invalid data.

If an error occurs, the `validate()` method automatically displays the
corresponding error message, and registers the [next field](#nextField)
to jump to when the interactive instruction gets the control back.

**Warning: The validate() method does not stop code execution if an
error is detected. You must execute a** `CONTINUE DIALOG` **or**
`CONTINUE INPUT` **instruction to cancel the code execution.**

A typical usage is for a \"save\" action: 

``` linenumber
01    ON ACTION save
02       IF DIALOG.validate("cust.*") < 0 THEN
03         CONTINUE DIALOG
04       END IF
05       CALL customer_save()
```

See [Identifying fields in dialog methods](#ident_fields) for more
details about the *field -list* specification.

### [Setting the UNBUFFERED mode]{#setDefaultUnbuffered}

By default dialogs are not sensitive to variable changes. To make a
dialog sensitive, use the `UNBUFFERED` attribute in the dialog
instruction definition. However, you can define the default for all
subsequent dialogs by using the `setDefaultUnbuffered()` class method:

``` linenumber
01 CALL ui.Dialog.setDefaultUnbuffered(TRUE)
```

### [Setting TTY attributes for cells in lists]{#setting TTY Attributes}

#### [Multiple Dialogs]{#setArrayAttributes}

In an [INPUT ARRAY](InputArray.html) or [DISPLAY
ARRAY](DisplayArray.html) instruction, the
`setArrayAttributes("`*`screen-array`*`", `*`program-array`*`)` method
can be used to specify display attributes for each cell. You must define
an array with the same number of record elements as the data array used
by the `INPUT ARRAY` or `DISPLAY ARRAY`. Each element must have the same
name as in the data array, and must be defined with a character data
type (you typically use [STRING](DataTypes.html#DT_STRING)).

Fill the display attributes array with color and video attributes. These
must be specified in lowercase characters and separated by a blank (ex:
\"`red reverse`\").

Possible values for cell attributes are a combination of the following:

- The TTY attribute `reverse`
- The TTY attribute `blink`
- The TTY attribute `underline`
- One of the TTY colors
  `white, yellow, magenta, red, cyan, green, blue, black`

Then, pass the array to the dialog with the `setArrayAttributes()`
method, in a  `BEFORE INPUT` or `BEFORE DISPLAY` block. Display
attributes can be changed dynamically during the dialog:

``` linenumber
01    ON ACTION set_attributes
02       CALL DIALOG.setArrayAttributes( "sr", attarr )
```

Note that like data values, if you change the cell attributes during the
dialog, these are not displayed automatically unless the
[UNBUFFERED](MultipleDialogs.html#buff-unbuff-modes) mode is used.

``` linenumber
01    ON ACTION modify_cell_attribute
02       LET attarr[index].col8 = "red reverse"
```

If you set `NULL` to a , the default TTY attributes will be reset:

``` linenumber
01    ON ACTION clean_cell_attribute
02       LET attarr[index].col8 = NULL
```

The cell attributes array can be detached from the dialog by passing
`NULL` as second parameter to the `setArrayAttributes()` method. When
doing this, the default TTY attributes will be reset (those defined by
the window or dialog `ATTRIBUTE` clause):

``` linenumber
01    ON ACTION remove_attributes
02       CALL DIALOG.setArrayAttributes( "sr", NULL )
```

For a complete example, see [Example 4](#EXAMPLE_4).

#### [Singular Dialogs]{#setCellAttributes}

An equivalent method called `setCellAttributes(`*`program-array`*`)`,
takes only the program array as argument. The `setCellAttributes()`
method is designed for singular dialogs, where only one screen array is
used.

### [Defining the row selection mode]{#setSelectionMode}

The `DISPLAY ARRAY` dialogs supports multi-row selection. This option is
disabled by default and can be enabled with the
`setSelectionMode("`*`screen-array`*`", `*`mode`*`)` method:

``` linenumber
01    ON ACTION mrs_on
02       CALL DIALOG.setSelectionMode( "sr", 1 )
```

Possible values of the second parameter are 0 (single row selection) or
1 (multi-range selection); other values are reserved for future use.

Multi-row selection can be enabled and disabled during the dialog
execution. If multi-row selection is switched off, selected rows get
de-selected.

For more details about multi-row selection, see [Multiple Dialogs
page](MultipleDialogs.html#multi-row-selection).

### [Querying row selection]{#isRowSelected}

If multi-row selection is enabled with
[setSelectionMode()](#setSelectionMode), you can check whether a row is
selected with the `isRowSelected("`*`screen-array`*`", `*`index`*`)`
method:

``` linenumber
01    ON ACTION check_current_row_selected
02       IF DIALOG.isRowSelected( "sr", DIALOG.getCurrentRow("sr") ) THEN
03         MESSAGE "Current row is selected."
04       END IF
```

If multi-row selection is off, the method returns
[TRUE](Programs.html#PC_TRUE) for the current row and
[FALSE](Programs.html#PC_FALSE) for other rows.

### [Setting row selection]{#setSelectionRange}

If multi-row selection is enabled with
[setSelectionMode()](#setSelectionMode), you can set the selection flags
for a range of rows with the
`setSelectionRange("`*`screen-array`*`", `*`start-index`*`, `*`end-index`*`, `*`value`*`)`
method. 

``` linenumber
01    ON ACTION select_all
02       CALL DIALOG.setSelectionRange( "sr", 1, -1, 1)
```

The start and end index must be in the range of possible row indexes
(from 1 to `DIALOG.getArrayLength("`*`screen-array`*`")`).

If you specify an end index of -1, it will set the flags from start
index to the end of the list.

### [Serialize data of the selected rows]{#selectionToString}

The `selectionToString("`*`screen-array`*`")` method can be used to get
a tab-separated value list of the [selected rows](#setSelectionMode).
When multi-row selection is disabled, the method serializes the current
row. You typically use this method in conjunction with Drag & Drop to
fill the buffer, by using a text/plain MIME type, to export data to
external applications.

``` linenumber
01    ON ACTION serialize
02       LET buff = DIALOG.selectionToString( "sr" )
```

Numeric and date data will be formatted according to current locale
settings ([DBMONEY](EnvironmentVariables.html#EV_DBMONEY),
[DBDATE](EnvironmentVariables.html#EV_DBDATE)).

The visual presentation of data is respected: The dialog will copy the
rows in the sort order specified by the user, moved columns will appear
in the same positions as in the table and hidden columns will be
ignored. Note that phantom columns are not copied.

Items in the tab-separated record will be surrounded by double-quotes if
the value contains special characters such as a new-line, a
double-quote, or controls characters with ASCII code \< 0x20.
Double-quotes in the value will be doubled.

------------------------------------------------------------------------

### [Examples]{#EXAMPLES}

#### [Example 1: Disable fields dynamically.]{#EXAMPLE_1}

``` linenumber
01 FUNCTION input_customer()
02    DEFINE custid INTEGER
03    DEFINE custname CHAR(10)
04    INPUT BY NAME custid, custname
05      ON ACTION enable
06        CALL DIALOG.setFieldActive("custid",1)
07      ON ACTION disable
08        CALL DIALOG.setFieldActive("custid",0)
09    END INPUT
10 END FUNCTION
```

#### [Example 2: Get the form and hide fields.]{#EXAMPLE_2}

``` linenumber
01 FUNCTION input_customer()
02    DEFINE f ui.Form
03    DEFINE custid INTEGER
04    DEFINE custname CHAR(10)
05    INPUT BY NAME custid, custname
06      BEFORE INPUT
08        LET f = DIALOG.getForm()
09        CALL f.setElementHidden("customer.custid",1)
10    END INPUT
11 END FUNCTION
```

#### [Example 3: Pass a dialog object to a function.]{#EXAMPLE_3}

``` linenumber
01 FUNCTION input_customer()
02    DEFINE custid INTEGER
03    DEFINE custname CHAR(10)
04    INPUT BY NAME custid, custname
05      BEFORE INPUT
06        CALL setup_dialog(DIALOG)
07    END INPUT
08 END FUNCTION
09 
10 FUNCTION setup_dialog(d)
11    DEFINE d ui.Dialog
12    CALL d.setActionActive("print",user.can_print)
13    CALL d.setActionActive("query",user.can_query)
14 END FUNCTION
```

#### [Example 4: Set display attributes for cells.]{#EXAMPLE_4}

``` linenumber
01 FUNCTION display_customer()
02    DEFINE i INTEGER
03    DEFINE arr DYNAMIC ARRAY OF RECORD
04                  key INTEGER,
05                  name CHAR(10)
06               END RECORD
07    DEFINE att DYNAMIC ARRAY OF RECORD
08                  key STRING,
09                  name STRING
10               END RECORD
11
12    FOR i=1 TO 10
13       CALL arr.appendElement()
14       LET arr[i].key = i
15       LET arr[i].name = "name " || i
16       CALL att.appendElement()
17       IF i MOD 2 = 0 THEN
18          LET att[i].key = "red"
19          LET att[i].name = "blue reverse"
20       ELSE
21          LET att[i].key = "green"
22          LET att[i].name = "magenta reverse"
23       END IF
24    END FOR
25
26    DIALOG ATTRIBUTES(UNBUFFERED)
27      DISPLAY ARRAY arr TO sr.*
28      ON ACTION att_attach
29        CALL DIALOG.setArrayAttributes("sr", att)
30      ON ACTION att_detach
31        CALL DIALOG.setArrayAttributes("sr", NULL)
32      ON ACTION att_modify_cell
33        LET att[2].key = "red reverse"
34      ON ACTION att_clear_cell
35        LET att[2].key = NULL
36    END DIALOG
37
38 END FUNCTION
```
