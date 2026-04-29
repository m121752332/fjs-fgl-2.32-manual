[Back to Contents](../index.html)

------------------------------------------------------------------------

# [Form Specification File Attributes]{#PAGE_HEADER}

Summary:

- [Attributes Summary](#ATTRIBLIST)

*See also:* [Form Specification Files](FormSpecFiles.html).

------------------------------------------------------------------------

## [Attributes Summary]{#ATTRIBLIST}

+--------------------------------------------------+---------------------------------------------+
| **Attribute**                                    | **Description**                             |
+--------------------------------------------------+---------------------------------------------+
| [ACCELERATOR](#FA_ACCELERATOR)                   | First accelerator key for an action default |
+--------------------------------------------------+---------------------------------------------+
| [ACCELERATOR2](#FA_ACCELERATOR2)                 | Second accelerator key for an action        |
|                                                  | default                                     |
+--------------------------------------------------+---------------------------------------------+
| [ACCELERATOR3](#FA_ACCELERATOR3)                 | Third accelerator key for an action default |
+--------------------------------------------------+---------------------------------------------+
| [ACCELERATOR4](#FA_ACCELERATOR4)                 | Fourth accelerator key for an action        |
|                                                  | default                                     |
+--------------------------------------------------+---------------------------------------------+
| [ACTION](#FA_ACTION)                             | Action name to be sent to the program when  |
|                                                  | the item is activated                       |
+--------------------------------------------------+---------------------------------------------+
| [AUTOSCALE](#FA_AUTOSCALE)                       | Forces the item\'s contents to be scaled    |
|                                                  | according to the available space            |
+--------------------------------------------------+---------------------------------------------+
| [AUTONEXT](#FA_AUTONEXT)                         | Automatically gives the focus to the next   |
|                                                  | field when all data is entered              |
+--------------------------------------------------+---------------------------------------------+
| [BUTTONTEXTHIDDEN](#FA_BUTTONTEXTHIDDEN)         | Indicates that the button labels of the     |
|                                                  | element must be hidden                      |
+--------------------------------------------------+---------------------------------------------+
| [CENTURY](#FA_CENTURY)                           | Specifies expansion of 2-digit years in     |
|                                                  | DATE and DATETIME fields                    |
+--------------------------------------------------+---------------------------------------------+
| [COLOR](#FA_COLOR)                               | Specifies the foreground color of the text  |
|                                                  | displayed by a form item                    |
+--------------------------------------------------+---------------------------------------------+
| [COLOR WHERE](#FA_COLOR_WHERE)                   | Defines a Boolean condition based on field  |
|                                                  | values to set the color attribute           |
|                                                  | dynamically                                 |
+--------------------------------------------------+---------------------------------------------+
| [CONTEXTMENU](#FA_CONTEXTMENU)                   | Defines if the context menu option must be  |
|                                                  | displayed for an action                     |
+--------------------------------------------------+---------------------------------------------+
| [COMMENT](#FA_COMMENT)                           | Specifies a message to display on the       |
|                                                  | Comment line                                |
+--------------------------------------------------+---------------------------------------------+
| [COMPONENTTYPE](#FA_COMPONENTTYPE)               | Defines the type of the Web Component       |
+--------------------------------------------------+---------------------------------------------+
| [DEFAULT](#FA_DEFAULT)                           | Assigns a default value to a field during   |
|                                                  | data entry                                  |
+--------------------------------------------------+---------------------------------------------+
| [DEFAULTVIEW](#FA_DEFAULTVIEW)                   | Defines if the default view must be         |
|                                                  | displayed for an action                     |
+--------------------------------------------------+---------------------------------------------+
| [DISPLAY LIKE](#FA_DISPLAY_LIKE)                 | Assigns attributes from the [database       |
|                                                  | schema](DatabaseSchema.html) files          |
+--------------------------------------------------+---------------------------------------------+
| [DOUBLECLICK](#FA_DOUBLECLICK)                   | Defines the action to be sent when user     |
|                                                  | double-clicks on the item                   |
+--------------------------------------------------+---------------------------------------------+
| [DOWNSHIFT](#FA_DOWNSHIFT)                       | Converts to lowercase any uppercase         |
|                                                  | character data                              |
+--------------------------------------------------+---------------------------------------------+
| [EXPANDEDCOLUMN](#FA_EXPANDEDCOLUMN)             | Indicates the form field that specifies     |
|                                                  | whether a tree node is expanded (opened)    |
+--------------------------------------------------+---------------------------------------------+
| [HEIGHT](#FA_HEIGHT)                             | Explicitly defines the height of a form     |
|                                                  | element                                     |
+--------------------------------------------------+---------------------------------------------+
| [HIDDEN](#FA_HIDDEN)                             | Makes an element invisible                  |
+--------------------------------------------------+---------------------------------------------+
| [FONTPITCH](#FA_FONTPITCH)                       | Defines the character font type as fixed or |
|                                                  | variable                                    |
+--------------------------------------------------+---------------------------------------------+
| [FORMAT](#FA_FORMAT)                             | Formats                                     |
|                                                  | [DECIMAL](DataTypes.html#DT_DECIMAL),       |
|                                                  | [MONEY](DataTypes.html#DT_MONEY),           |
|                                                  | [SMALLFLOAT](DataTypes.html#DT_SMALLFLOAT), |
|                                                  | [FLOAT](DataTypes.html#DT_FLOAT), or        |
|                                                  | [DATE](DataTypes.html#DT_DATE) field        |
|                                                  | formatting                                  |
+--------------------------------------------------+---------------------------------------------+
| [GRIDCHILDRENINPARENT](#FA_GRIDCHILDRENINPARENT) | Aligns children to the parent container     |
+--------------------------------------------------+---------------------------------------------+
| [IDCOLUMN](#FA_IDCOLUMN)                         | Specifies the form field containing the     |
|                                                  | identifier of a tree node                   |
+--------------------------------------------------+---------------------------------------------+
| [IMAGE](#FA_IMAGE)                               | Defines the URL of the image resource       |
|                                                  | associated to the form item                 |
+--------------------------------------------------+---------------------------------------------+
| [IMAGECOLUMN](#FA_IMAGECOLUMN)                   | Defines the field that holds the image for  |
|                                                  | this field                                  |
+--------------------------------------------------+---------------------------------------------+
| [IMAGECOLLAPSED](#FA_IMAGECOLLAPSED)             | Specifies the icon to be used when a tree   |
|                                                  | node is collapsed                           |
+--------------------------------------------------+---------------------------------------------+
| [IMAGEEXPANDED](#FA_IMAGEEXPANDED)               | Specifies the icon to be used when a tree   |
|                                                  | node is expanded                            |
+--------------------------------------------------+---------------------------------------------+
| [IMAGELEAF](#FA_IMAGELEAF)                       | Specifies the icon to be used for leaf      |
|                                                  | nodes in a tree                             |
+--------------------------------------------------+---------------------------------------------+
| [INCLUDE](#FA_INCLUDE)                           | Lists a set of acceptable values during     |
|                                                  | data entry                                  |
+--------------------------------------------------+---------------------------------------------+
| [INITIALIZER](#FA_INITIALIZER)                   | Specifies an initialization function for    |
|                                                  | the ComboBox item                           |
+--------------------------------------------------+---------------------------------------------+
| [INVISIBLE](#FA_INVISIBLE)                       | Does not echo characters on the screen      |
|                                                  | during data entry                           |
+--------------------------------------------------+---------------------------------------------+
| [ISNODECOLUMN](#FA_ISNODECOLUMN)                 | Specifies the form field that indicates a   |
|                                                  | tree node has children                      |
+--------------------------------------------------+---------------------------------------------+
| [ITEMS](#FA_ITEMS)                               | Defines a list of values to be used by the  |
|                                                  | form item                                   |
+--------------------------------------------------+---------------------------------------------+
| [JUSTIFY](#FA_JUSTIFY)                           | Specifies the justification of the content  |
|                                                  | of a field                                  |
+--------------------------------------------------+---------------------------------------------+
| [MINHEIGHT](#FA_MINHEIGHT)                       | Defines a minimum height for the form item  |
+--------------------------------------------------+---------------------------------------------+
| [MINWIDTH](#FA_MINWIDTH)                         | Defines a minimum width for the form item   |
+--------------------------------------------------+---------------------------------------------+
| [NOT NULL](#FA_NOT_NULL)                         | Indicates that the field does not accept    |
|                                                  | NULL values                                 |
+--------------------------------------------------+---------------------------------------------+
| [NOENTRY](#FA_NOENTRY)                           | Prevents the user from entering data in the |
|                                                  | field                                       |
+--------------------------------------------------+---------------------------------------------+
| [ORIENTATION](#FA_ORIENTATION)                   | Defines the orientation of an element as    |
|                                                  | vertical or horizontal                      |
+--------------------------------------------------+---------------------------------------------+
| [PARENTIDCOLUMN](#FA_PARENTIDCOLUMN)             | Specifies the form field containing the     |
|                                                  | identifier of a tree node\'s parent         |
+--------------------------------------------------+---------------------------------------------+
| [PICTURE](#FA_PICTURE)                           | Imposes a data-entry format on CHAR or      |
|                                                  | VARCHAR fields                              |
+--------------------------------------------------+---------------------------------------------+
| [PROGRAM](#FA_PROGRAM)                           | Invokes an external program to display TEXT |
|                                                  | or BYTE values                              |
+--------------------------------------------------+---------------------------------------------+
| [PROPERTIES](#FA_PROPERTIES)                     | Defines a free list of widget-specific      |
|                                                  | properties                                  |
+--------------------------------------------------+---------------------------------------------+
| [QUERYEDITABLE](#FA_QUERYEDITABLE)               | Allows a combobox field to be editable      |
|                                                  | during a CONSTRUCT                          |
+--------------------------------------------------+---------------------------------------------+
| [REQUIRED](#FA_REQUIRED)                         | Requires the user to supply a value during  |
|                                                  | input instructions                          |
+--------------------------------------------------+---------------------------------------------+
| [REVERSE](#FA_REVERSE)                           | Causes values in the field to be displayed  |
|                                                  | in reverse video                            |
+--------------------------------------------------+---------------------------------------------+
| [SAMPLE](#FA_SAMPLE)                             | Provides the text to be used as a sample to |
|                                                  | compute the width                           |
+--------------------------------------------------+---------------------------------------------+
| [SCROLL](#FA_SCROLL)                             | Allows scrolling within the field           |
+--------------------------------------------------+---------------------------------------------+
| [SCROLLBARS](#FA_SCROLLBARS)                     | Defines vertical and/or horizontal          |
|                                                  | scrollbars for the form item                |
+--------------------------------------------------+---------------------------------------------+
| [SIZEPOLICY](#FA_SIZEPOLICY)                     | Indicates sizing hint to display form       |
|                                                  | elements.                                   |
+--------------------------------------------------+---------------------------------------------+
| [SPACING](#FA_SPACING)                           | Indicates spacing hint to display form      |
|                                                  | elements                                    |
+--------------------------------------------------+---------------------------------------------+
| [SPLITTER](#FA_SPLITTER)                         | Indicates that the container must use a     |
|                                                  | splitter                                    |
+--------------------------------------------------+---------------------------------------------+
| [STEP](#FA_STEP)                                 | Defines how much the value increases or     |
|                                                  | decreases with a single click               |
+--------------------------------------------------+---------------------------------------------+
| [STRETCH](#FA_STRETCH)                           | Defines how the widget must resize          |
|                                                  | according to the parent container           |
+--------------------------------------------------+---------------------------------------------+
| [STYLE](#FA_STYLE)                               | Defines a presentation style for the form   |
|                                                  | element                                     |
+--------------------------------------------------+---------------------------------------------+
| [TAG](#FA_TAG)                                   | Defines a string identifier for the form    |
|                                                  | item                                        |
+--------------------------------------------------+---------------------------------------------+
| [TABINDEX](#FA_TABINDEX)                         | Defines the tab order for the form item     |
+--------------------------------------------------+---------------------------------------------+
| [TEXT](#FA_TEXT)                                 | Defines the label to be associated with the |
|                                                  | form item                                   |
+--------------------------------------------------+---------------------------------------------+
| [TITLE](#FA_TITLE)                               | Defines the title to be associated with the |
|                                                  | form item                                   |
+--------------------------------------------------+---------------------------------------------+
| [UPSHIFT](#FA_UPSHIFT)                           | Converts to uppercase any lowercase         |
|                                                  | character data                              |
+--------------------------------------------------+---------------------------------------------+
| [UNHIDABLE](#FA_UNHIDABLE)                       | Indicates that the column cannot be hidden  |
+--------------------------------------------------+---------------------------------------------+
| [UNHIDABLECOLUMNS](#FA_UNHIDABLECOLUMNS)         | The table does not allow columns to be      |
|                                                  | hidden                                      |
+--------------------------------------------------+---------------------------------------------+
| [UNMOVABLE](#FA_UNMOVABLE)                       | Indicates that the column cannot be moved   |
+--------------------------------------------------+---------------------------------------------+
| [UNMOVABLECOLUMNS](#FA_UNMOVABLECOLUMNS)         | Prevents the user from changing the order   |
|                                                  | of the columns                              |
+--------------------------------------------------+---------------------------------------------+
| [UNSIZABLE](#FA_UNSIZABLE)                       | Indicates that the column cannot be resized |
+--------------------------------------------------+---------------------------------------------+
| [UNSIZABLECOLUMNS](#FA_UNSIZABLECOLUMNS)         | The table does not allow columns to be      |
|                                                  | resized                                     |
+--------------------------------------------------+---------------------------------------------+
| [UNSORTABLE](#FA_UNSORTABLE)                     | Indicates that the column cannot be used    |
|                                                  | for sorting                                 |
+--------------------------------------------------+---------------------------------------------+
| [UNSORTABLECOLUMNS](#FA_UNSORTABLECOLUMNS)       | The table does not allow rows to be sorted  |
+--------------------------------------------------+---------------------------------------------+
| [VALIDATE](#FA_VALIDATE)                         | Defines the data validation mode for a      |
|                                                  | given action                                |
+--------------------------------------------------+---------------------------------------------+
| [VALIDATE LIKE](#FA_VALIDATE_LIKE)               | Validates data entry with definitions from  |
|                                                  | the [database schema](DatabaseSchema.html)  |
|                                                  | files                                       |
+--------------------------------------------------+---------------------------------------------+
| [VALUEMIN](#FA_VALUEMIN)                         | Defines the lower limit for widgets (such   |
|                                                  | as progressbars)                            |
+--------------------------------------------------+---------------------------------------------+
| [VALUEMAX](#FA_VALUEMAX)                         | Defines the upper limit for widgets (such   |
|                                                  | as progressbars)                            |
+--------------------------------------------------+---------------------------------------------+
| [VALUECHECKED](#FA_VALUECHECKED)                 | Defines the value to be associated with a   |
|                                                  | checked checkbox                            |
+--------------------------------------------------+---------------------------------------------+
| [VALUEUNCHECKED](#FA_VALUEUNCHECKED)             | Defines the value to be associated with an  |
|                                                  | unchecked checkbox                          |
+--------------------------------------------------+---------------------------------------------+
| [VERIFY](#FA_VERIFY)                             | Requires that data be entered twice when    |
|                                                  | the database is modified                    |
+--------------------------------------------------+---------------------------------------------+
| [VERSION](#FA_VERSION)                           | Defines a user version string for an        |
|                                                  | element                                     |
+--------------------------------------------------+---------------------------------------------+
| [WANTTABS](#FA_WANTTABS)                         | Forces the field to consume TAB keys        |
+--------------------------------------------------+---------------------------------------------+
| [WANTNORETURNS](#FA_WANTNORETURNS)               | Forces the field to reject RETURN keys      |
+--------------------------------------------------+---------------------------------------------+
| [WANTFIXEDPAGESIZE](#FA_WANTFIXEDPAGESIZE)       | Forces the table to have a fixed height     |
|                                                  | when the parent window is resized           |
+--------------------------------------------------+---------------------------------------------+
| [WIDTH](#FA_WIDTH)                               | Explicitly defines the width of a form      |
|                                                  | element                                     |
+--------------------------------------------------+---------------------------------------------+
| [WINDOWSTYLE](#FA_WINDOWSTYLE)                   | Specifies the style to be used by the       |
|                                                  | parent window                               |
+--------------------------------------------------+---------------------------------------------+
| [WORDWRAP](#FA_WORDWRAP)                         | Invokes a multiple-line editor in           |
|                                                  | multiple-segment fields                     |
+--------------------------------------------------+---------------------------------------------+
| Attributes supported for backward compatibility with Four Js BDS                               |
+--------------------------------------------------+---------------------------------------------+
| [*CLASS*](#FA_CLASS)                             | Specifies the behavior of a field defined   |
|                                                  | with the WIDGET attribute                   |
+--------------------------------------------------+---------------------------------------------+
| [*CONFIG*](#FA_CONFIG)                           | Specifies the parameters for the definition |
|                                                  | of a widget (only used with WIDGET          |
|                                                  | attribute)                                  |
+--------------------------------------------------+---------------------------------------------+
| [*KEY*](#FA_KEY)                                 | Defines the label of a key when the field   |
|                                                  | gets the focus                              |
+--------------------------------------------------+---------------------------------------------+
| [*OPTIONS*](#FA_OPTIONS)                         | Specifies widget definition options         |
+--------------------------------------------------+---------------------------------------------+
| [*WIDGET*](#FA_WIDGET)                           | Defines the type of widget to be used for   |
|                                                  | presentation                                |
+--------------------------------------------------+---------------------------------------------+

------------------------------------------------------------------------

### [ACCELERATOR Attribute]{#FA_ACCELERATOR}

#### Purpose:

The `ACCELERATOR` attribute defines the [primary]{.underline}
accelerator key of an [action default
item](FormSpecFiles.html#SECTION_ACTDEFS).

#### Syntax:

`ACCELERATOR = `[`[`]{.underline}`CONTROL-`[`][`]{.underline}`SHIFT-`[`][`]{.underline}`ALT-`[`]`]{.underline}*`key`*

#### Notes:

1.  *key* defines the accelerator key as described in
    [Accelerators](InteractionModel.html#ACCELNAMES)

------------------------------------------------------------------------

### [ACCELERATOR2 Attribute]{#FA_ACCELERATOR2}

#### Purpose:

The `ACCELERATOR2` attribute defines the [secondary]{.underline}
accelerator key of an [action default
item](FormSpecFiles.html#SECTION_ACTDEFS).

#### Syntax:

`ACCELERATOR2 = `[`[`]{.underline}`CONTROL-`[`][`]{.underline}`SHIFT-`[`][`]{.underline}`ALT-`[`]`]{.underline}*`key`*

#### Notes:

1.  *key* defines the accelerator key as described in
    [Accelerators](InteractionModel.html#ACCELNAMES)

------------------------------------------------------------------------

### [ACCELERATOR3 Attribute]{#FA_ACCELERATOR3}

#### Purpose:

The `ACCELERATOR3` attribute defines the [third]{.underline} accelerator
key of an [action default item](FormSpecFiles.html#SECTION_ACTDEFS).

#### Syntax:

`ACCELERATOR3 = `[`[`]{.underline}`CONTROL-`[`][`]{.underline}`SHIFT-`[`][`]{.underline}`ALT-`[`]`]{.underline}*`key`*

#### Notes:

1.  *key* defines the accelerator key as described in
    [Accelerators](InteractionModel.html#ACCELNAMES)

------------------------------------------------------------------------

### [ACCELERATOR4 Attribute]{#FA_ACCELERATOR4}

#### Purpose:

The `ACCELERATOR4` attribute defines the [fourth]{.underline}
accelerator key of an [action default
item](FormSpecFiles.html#SECTION_ACTDEFS).

#### Syntax:

`ACCELERATOR4 = `[`[`]{.underline}`CONTROL-`[`][`]{.underline}`SHIFT-`[`][`]{.underline}`ALT-`[`]`]{.underline}*`key`*

#### Notes:

1.  *key* defines the accelerator key as described in
    [Accelerators](InteractionModel.html#ACCELNAMES)

------------------------------------------------------------------------

### [ACTION Attribute]{#FA_ACTION}

#### Purpose:

The `ACTION` attribute defines the name of the action to be sent to the
program when the user activates the form item.

#### Syntax:

`ACTION = `*`action-name`*

#### Notes:

1.  *action-name* is an identifier that defines the name of the action
    to be sent.

#### Example:

``` linenumber
01 BUTTONEDIT f001 = customer.state, ACTION = print;
```

------------------------------------------------------------------------

### [AUTOSCALE Attribute]{#FA_AUTOSCALE}

#### Purpose:

The ` AUTOSCALE` attribute causes the form element contents to
automatically scale to the size given to the item.

#### Syntax:

`AUTOSCALE`

#### Usage:

For [images](FormSpecFiles.html#FF_ITEMTYPE_IMAGE), this attribute
forces the image to be stretched to fit in the area reserved for the
image.

------------------------------------------------------------------------

### [AUTONEXT Attribute]{#FA_AUTONEXT}

#### Purpose:

The ` AUTONEXT` attribute causes the cursor to automatically advance
during input to the next field when the current field is full.

#### Syntax:

`AUTONEXT`

#### Usage:

If data values entered in the field do not meet the requirements of
other field attributes like ` INCLUDE` or `PICTURE`, the cursor does
*not* automatically move to the next field but remains in the current
field, and an error message displays.

`AUTONEXT` is particularly useful with character fields in which the
input data is of a standard length, such as numeric postal codes or the
abbreviations in the **state** table. It is also useful if a character
field has a length of 1 because only one keystroke is required to enter
data and move to the next field.

------------------------------------------------------------------------

### [CENTURY Attribute]{#FA_CENTURY}

#### Purpose:

The ` CENTURY` attribute specifies how to expand abbreviated one- and
two-digit *year* specifications in a DATE and DATETIME field. Expansion
is based on this setting (and on the year value from the system clock at
runtime).

#### Syntax:

`CENTURY = `[`{`]{.underline}` "R" `[`|`]{.underline}` "C" `[`|`]{.underline}` "F" `[`|`]{.underline}` "P" `[`}`]{.underline}

#### Usage:

The ` CENTURY` attribute can specify any of four algorithms to expand
abbreviated years into four-digit year values that end with the same
digits (or digit) that the user has entered.

`CENTURY` supports the same settings as the
[DBCENTURY](EnvironmentVariables.html#EV_DBCENTURY) environment
variable, but with a scope that is restricted to a single field.

If the ` CENTURY` and
[DBCENTURY](EnvironmentVariables.html#EV_DBCENTURY) settings are
different, ` CENTURY` takes precedence.

Unlike [DBCENTURY](EnvironmentVariables.html#EV_DBCENTURY), the
` CENTURY` attribute is not case sensitive. However, we recommend that
you use uppercase letters in the attribute.

------------------------------------------------------------------------

### [CLASS Attribute]{#FA_CLASS}

#### Purpose:

The ` CLASS` attribute is used to define the behavior of a field.

#### Syntax:

`CLASS = "`*`identifier`*`"`

#### Notes:

1.  *identifier* is a predefined keyword defining the class of the
    field.

#### Supported field classes:

::: {align="center"}
  ----------------------------------- -----------------------------------
  **Class**                           **Description**

  `KEY`                               Field is used to trigger a
                                      keystroke instead of being a normal
                                      input field.\
                                      Only supported with special
                                      [widgets](#FA_WIDGET) such as
                                      buttons, checkboxes and
                                      radiobuttons.

  `PASSWORD`                          Field input is masked by replacing
                                      normal character echo by stars
                                      \"\*\".
  ----------------------------------- -----------------------------------
:::

**Warning: This attributes is supported for backward compatibility with
Four Js BDS.**

------------------------------------------------------------------------

### [COLOR Attribute]{#FA_COLOR}

#### Purpose:

The ` COLOR` attribute defines the foreground color of the text
displayed by a form element.

#### Syntax:

`COLOR = `*`color-name`*` `

#### Notes:

1.  *color-name* can be: `BLACK`, `BLUE`, `CYAN`, `GREEN`, `MAGENTA`,
    `RED`, `WHITE`, and `YELLOW`.

#### Usage:

The `COLOR` attribute defines the logical color of a value displayed in
a field.

For backward compatibility, *color-name* can be combined with an
intensity keyword: `REVERSE`, `LEFT`, `BLINK`, and `UNDERLINE`.

#### Example:

``` linenumber
01 EDIT f001 = customer.name, COLOR = RED;
```

------------------------------------------------------------------------

### [COLOR WHERE Attribute]{#FA_COLOR_WHERE}

#### Purpose:

The ` COLOR WHERE` attribute defines a condition to set the foreground
color dynamically.

#### Syntax:

`COLOR = `*`color-name`*` `[`[...]`]{.underline}` WHERE `*`boolexpr`*` `

#### Notes:

1.  *color-name* can be: `BLACK`, `BLUE`, `CYAN`, `GREEN`, `MAGENTA`,
    `RED`, `WHITE`, and `YELLOW`.
2.  *color-name* can also be an intensity keyword: `REVERSE`, `LEFT`,
    `BLINK`, and `UNDERLINE`.
3.  *boolexpr* defines a [Boolean
    expression](FormSpecFiles.html#BOOLEXPR) with a restricted syntax.

#### Usage:

The `COLOR WHERE` attribute defines the logical color of the text of a
field when the value satisfies the conditional expression.

The condition in `COLOR WHERE` can only reference the field for which
the attribute is set. The Boolean expression is automatically evaluated
at runtime to check when the color attribute must be set.

The `COLOR WHERE` attribute may not be supported in all situations; it
is not supported in [TABLE](FormSpecFiles.html#FF_CONTAINER_TABLE)
columns.

#### Example:

``` linenumber
01 EDIT f001 = item.price, COLOR = RED WHERE f001>100;
```

------------------------------------------------------------------------

### [CONFIG Attribute]{#FA_CONFIG}

#### Purpose:

The ` CONFIG` attribute is used with the [WIDGET](#FA_WIDGET) attribute
to define the behavior and decoration of the field.

#### Syntax:

`CONFIG = "`*`parameter`*` `[`[...]`]{.underline}`"`

#### Notes:

1.  The ` CONFIG` attribute can only be used with the
    [WIDGET](#FA_WIDGET) attribute. It is ignored if ` WIDGET` is not
    used.
2.  *parameter* is the value of a configuration parameter.
3.  Configuration parameters are separated by blanks.
4.  If a configuration parameter holds blank characters, you must use
    `{}` curly braces to delimit the parameter value.
5.  See the [WIDGET](#FA_WIDGET) attribute for more details about
    configuration.

**Warning: This attributes is supported for backward compatibility with
Four Js BDS.**

------------------------------------------------------------------------

### [CONTEXTMENU Attribute]{#FA_CONTEXTMENU}

#### Purpose:

Defines whether a context menu option must be displayed for an action.

#### Syntax:

`CONTEXTMENU = `[`[`]{.underline}` AUTO `[`|`]{.underline}` YES `[`|`]{.underline}` NO `[`]`]{.underline}

#### Usage:

`CONTEXTMENU` is an Action Default attribute defining whether the
context menu option must be displayed for an action.

1.  `NO `indicates that no context menu option must be displayed for
    this action.
2.  `YES`  indicates that a context menu option must always be displayed
    for this action, if the action is visible
    ([setActionHidden](ClassDialog.html#setActionHidden)).
3.  `AUTO` means that the context menu option is displayed if no
    explicit action view is used for that action and the action is
    visible ([setActionHidden](ClassDialog.html#setActionHidden)).

The default is `YES`.

Note that this attribute applies to the actions defined by the current
dialog in the current window.

------------------------------------------------------------------------

### [COMMENT Attribute]{#FA_COMMENT}

#### Purpose:

The `COMMENT` attribute defines text that can be shown when the element
becomes current.

#### Syntax:

`COMMENT = `[`[`]{.underline}`%`[`]`]{.underline}`"`*`string`*`"`

#### Notes:

1.  *string* is the text to be displayed.
2.  *string* can be a [localized string](LocalizedStrings.html).

#### Usage:

The most common use of the `COMMENT` attribute is to give information or
instructions to the user. This is particularly appropriate when the
field accepts only a limited set of values.

The screen location where the message is displayed depends on external
configuration. It can be displayed in the COMMENT LINE, or in the
STATUSBAR when using a graphical user interface.

Note that if the [OPEN WINDOW](WindowsAndForms.html#OPEN_WINDOW)
statement specifies ` COMMENT LINE OFF`, any output to the comment area
is hidden even if the window displays a form that includes fields that
include the ` COMMENT` attribute.

#### Example:

``` linenumber
01 EDIT f001 = customer.name, COMMENT = "The customer name";
```

------------------------------------------------------------------------

### [COMPONENTTYPE Attribute]{#FA_COMPONENTTYPE}

#### Purpose:

The `COMPONENTTYPE` attribute defines a name identifying the external
widget.

#### Syntax:

`COMPONENTTYPE = "`*`name`*`"`

#### Notes:

1.  *name* defines the type of the widget to be used.

#### Usage:

The `COMPONENTTYPE` attribute is used to define the type of a
[WEBCOMPONENT](FormSpecFiles.html#FF_ITEMTYPE_WEBCOMPONENT) form item.

The value of this attribute will be mapped to a specific widget
definition on the front-end side. See front-end specific documentation
related to Web Components.

#### Example:

``` linenumber
01 WEBCOMPONENT f001 = FORMONLY.mycal, COMPONENTTYPE="Calendar";
```

------------------------------------------------------------------------

### [DEFAULT Attribute]{#FA_DEFAULT}

#### Purpose:

The ` DEFAULT` attribute assigns a default value to a field during data
entry.

#### Syntax:

`DEFAULT = `*`value`*

#### Notes:

1.  *value* can be any [literal expression](Literals.html) supported by
    the form compiler.
2.  *value* can be ` TODAY` to specify the current system date as
    default.
3.  *value* can be ` CURRENT` to specify the current system datetime as
    default.

#### Usage:

The effect of the `DEFAULT` attribute depends on the
` WITHOUT DEFAULTS `configuration option of the dialog using the form:

With the [INPUT](RecordInput.html#WITHOUT_DEFAULTS_option) statement,
form default values have are ignored when using the ` WITHOUT DEFAULTS`
option. With this option, the runtime system displays the values in the
program variables to the screen. Otherwise, the form default values will
be displayed when the dialog starts.

With the [INPUT ARRAY](InputArray.html#WITHOUT_DEFAULTS_option)
statement, the form default values are always used for new rows inserted
by the user. With `INPUT ARRAY`, the ` WITHOUT DEFAULTS` option
indicates if the existing program array elements have to be used.

Note that defaults values can also be specified in the [Database Schema
file](DatabaseSchema.html#VAL_FILE), for form fields defined with
database column reference.

If the field is [FORMONLY](FormSpecFiles.html#FF_FORMONLY_FIELD), you
must also specify a data type when you assign the ` DEFAULT` attribute
to a field.

If both the ` DEFAULT` attribute and the [REQUIRED](#FA_REQUIRED)
attribute are assigned to the same field, the ` REQUIRED` attribute is
ignored.

If you do not use the ` WITHOUT NULL INPUT` option in the
[DATABASE](FormSpecFiles.html#SECTION_SCHEMA) section, all fields
default to null values unless you have specified a `DEFAULT` attribute.

#### Warnings:

1.  [DATETIME](Literals.html#LT_DATETIME) and
    [INTERVAL](Literals.html#LT_INTERVAL) literals are not supported.

#### Example:

``` linenumber
01 EDIT f001 = order.orderdate, DEFAULT = TODAY;
```

------------------------------------------------------------------------

### [DEFAULTVIEW Attribute]{#FA_DEFAULTVIEW}

#### Purpose:

Defines if a default view (i.e. button) must be displayed for a given
action.

#### Syntax:

`DEFAULTVIEW = `[`[`]{.underline}` AUTO `[`|`]{.underline}` YES `[`|`]{.underline}` NO `[`]`]{.underline}

#### Usage:

` DEFAULTVIEW` is an Action Default attribute defining whether the
default action view (i.e. a button) must be displayed for an action.

- `NO `indicates that no default action view must be displayed for this
  action.
- `YES`  indicates that a default action view must always be displayed
  for this action, if the action is visible
  ([setActionHidden](ClassDialog.html#setActionHidden)).
- `AUTO` means that a default action view is displayed if no explicit
  action view is used for that action and the action is visible
  ([setActionHidden](ClassDialog.html#setActionHidden)).

The default is `AUTO`.

Note that this attribute applies to the actions defined by the current
dialog in the current window.

------------------------------------------------------------------------

### [DISPLAY LIKE Attribute]{#FA_DISPLAY_LIKE}

#### Purpose:

The ` DISPLAY LIKE` attribute takes column attributes defined in the
[database schema files](DatabaseSchema.html) and applies them to a
field.

#### Syntax:

`DISPLAY LIKE `[`[`]{.underline}*`table`*`.`[`]`]{.underline}*`column`*

#### Notes:

1.  *table* is the optional table name to qualify the column.
2.  *column* is the name of the column to be used to retrieve display
    attributes.

#### Usage:

Specifying this attribute is equivalent to listing all the attributes
that are assigned to *table.column* in the [database schema
file](DatabaseSchema.html) generated from the **syscolatt** table.

Display attributes are automatically taken from the schema file if the
field is linked to *table.column* in the field name specification.

Note that the ` DISPLAY LIKE` clause is evaluated at compile time, not
at runtime. If the [database schema file](DatabaseSchema.html) changes,
you might need to recompile a program that uses the ` LIKE` clause. Even
if all of the fields in the form are `FORMONLY`, this attribute requires
the form compiler to access the database schema file that contains the
description of *tabl*e.

#### Example:

``` linenumber
01 EDIT f001 = FORMONLY.fullname, DISPLAY LIKE customer.custname;
```

------------------------------------------------------------------------

### [HIDDEN Attribute]{#FA_HIDDEN}

#### Purpose:

The ` HIDDEN` attribute indicates that the element should not be
displayed.

#### Syntax:

`HIDDEN `[`[`]{.underline}` = USER `[`]`]{.underline}

#### Notes:

1.  `HIDDEN` sets the underlying item attribute to 1.
2.  `HIDDEN=USER` sets the underlying item attribute to 2.

#### Warnings:

1.  When you set a hidden attribute for a form field, the model node
    gets the hidden attribute, not the view node.
2.  Form fields hidden with the USER option (value 2) might be shown
    anyway if the field is needed by a dialog for input.

#### Usage:

By default, all elements are visible. You can use the `HIDDEN` attribute
to hide an element, such as a form field or a groupbox. The runtime
system handles hidden form fields. If you write an
[INPUT](RecordInput.html) statement using a hidden field, the field is
ignored (as if it was declared as [NOENTRY](#FA_NOENTRY)). Programs may
change the visibility of form fields dynamically with the
[ui.Form](ClassForm.html) built-in class.

When you use the `HIDDEN` keyword only, the underlying item attribute is
set to 1. The value 1 indicates that the element is hidden to the user
without the possibility of showing the element, for example with the
context menu of [table](FormSpecFiles.html#FF_CONTAINER_TABLE) headers.
In this hidden mode, the [UNHIDABLE](#FA_UNHIDABLE) attribute is ignored
by the front end.

When you use `HIDDEN=USER`, the underlying item attribute is set to 2.
The value 2 indicates that the element is hidden by default, but the
user can show/hide the element as needed. For example, the user can
change a hidden column back to visible. Form elements like table columns
that are hidden by the user might be automatically re-shown (hidden=0)
by the front-end if the program dialog gives the focus to that field for
input. In such case the program dialog takes precedence over the hidden
attribute.

#### Example:

``` linenumber
01 EDIT f001 = FORMONLY.field1, HIDDEN;
02 EDIT col1 = FORMONLY.column1, HIDDEN=USER;
```

------------------------------------------------------------------------

### [HEIGHT Attribute]{#FA_HEIGHT}

#### Purpose:

The `HEIGHT` attribute defines an explicit height for a form element.

#### Syntax:

`HEIGHT = `*`integer`*` `[`[`]{.underline}`CHARACTERS`[`|`]{.underline}`LINES`[`|`]{.underline}`POINTS`[`|`]{.underline}`PIXELS`[`]`]{.underline}

#### Notes:

1.  *integer* defines the height of the element.

#### Usage:

By default, the size of an element is defined in characters and
automatically computed by the form compiler according to the size of the
form element in the layout.

For items like images, the default height is defined by the number of
lines of the [item tag](FormSpecFiles.html#FF_ITEM_TAG) (as a vertical
character height). You can overwrite this default by specifying the
`HEIGHT` attribute. You typically give a number of pixels. 

For tables, the default height is defined by the number of lines used in
the table layout. You can overwrite this default by specifying the
`HEIGHT` attribute.

If you don\'t specify any unit, the size unit defaults to `CHARACTERS`,
which defines the number of grid cells.

See also: [WIDTH](#FA_WIDTH).

#### Example:

``` linenumber
01 IMAGE img1 : image1, WIDTH = 200 PIXELS, HEIGHT = 120 PIXELS;
```

------------------------------------------------------------------------

### [BUTTONTEXTHIDDEN Attribute]{#FA_BUTTONTEXTHIDDEN}

#### Purpose:

The `BUTTONTEXTHIDDEN` attribute indicates that the labels of the
buttons of this element should not be displayed.

#### Syntax:

`BUTTONTEXTHIDDEN`

#### Usage:

Use in a [TOOLBAR](FormSpecFiles.html#SECTION_TOOLBAR) definition to
hide the labels of buttons.

------------------------------------------------------------------------

### [DOUBLECLICK Attribute]{#FA_DOUBLECLICK}

#### Purpose:

The `DOUBLECLICK` attribute defines the action to be sent when the user
double-clicks on a TABLE row.

#### Syntax:

`DOUBLECLICK = `*`action-name`*

#### Notes:

1.  *action-name* defines the name of the action to be fired on
    double-click.

#### Usage:

This attribute is typically used in a
[TABLE](FormSpecFiles.html#FF_ITEMTYPE_TABLE) container, to define the
action to be sent when the user double-clicks on a row. By default, if
the TABLE is driven by a [DISPLAY ARRAY](DisplayArray.html), a
double-click fires the *accept* action. When using an [INPUT
ARRAY](InputArray.html), double-click selects the whole text if the
current widget is editable. If `DOUBLECLICK` is defined when using an
`INPUT ARRAY`, the action can only be sent when the user double-clicks
on a non-editable widget like a
[LABEL](FormSpecFiles.html#FF_ITEMTYPE_LABEL).

------------------------------------------------------------------------

### [DOWNSHIFT Attribute]{#FA_DOWNSHIFT}

#### Purpose:

The `DOWNSHIFT` attribute forces character input to lowercase letters.

#### Syntax:

`DOWNSHIFT`

#### Usage:

Assign the ` DOWNSHIFT` attribute to a character field when you want the
runtime system to convert uppercase letters entered by the user to
lowercase letters, both on the screen and in the corresponding program
variable.

Because uppercase and lowercase letters have different values, storing
character strings in one or the other format can simplify sorting and
querying a database.

Characters entered by the user are converted in
[INPUT](RecordInput.html), [INPUT ARRAY](InputArray.html) and
[CONSTRUCT](Construct.html) instructions.

The results of conversions between uppercase and lowercase letters are
based on the locale settings (LANG). When using single byte runners, the
conversion of ASCII characters \>127 is controlled by the LC_CTYPE
environment variable.

See also: [UPSHIFT](#FA_UPSHIFT).

------------------------------------------------------------------------

### [FORMAT Attribute]{#FA_FORMAT}

#### Purpose:

You can use the ` FORMAT` attribute with numeric and date time fields to
control the format of output displays.

#### Syntax:

`FORMAT = "`*`format-string`*`"`

#### Notes:

1.  *format-string* is a string of characters that specifies a data
    display format.
2.  You must enclose *format-string* within quotation marks ( \" ).
3.  Use the [PICTURE](#FA_PICTURE) attribute to format data entered in
    the field by the user.
4.  If *format-string* is smaller than the field width, you get a
    compile-time warning, but the form is usable.
5.  When this attribute is not used, [environment
    variable](EnvironmentVariables.html) settings define the default
    format.

#### Warnings:

1.  To follow abstract user interface programming and support
    internationalization, it is not recommended that you use this
    attribute.

#### Usage:

The `FORMAT` attribute can be used to define a specific display format
for numeric and date fields. For [MONEY](DataTypes.html#DT_MONEY)
fields, a global format can be specified with the
[DBMONEY](EnvironmentVariables.html#EV_DBMONEY) or
[DBFORMAT](EnvironmentVariables.html#EV_DBFORMAT) environment variables.
For [DATE](DataTypes.html#DT_DATE) fields, the global format is defined
by the [DBDATE](EnvironmentVariables.html#EV_DBDATE) environment
variable.

Use the [PICTURE](#FA_PICTURE) attribute to format data entered in the
field by the user.

If *format-string* is smaller than the field width, you get a
compile-time warning, but the form is usable.

When this attribute is not used, [environment
variable](EnvironmentVariables.html) settings define the default format.

#### Numeric formats:

For [DECIMAL](DataTypes.html#DT_DECIMAL),
[MONEY](DataTypes.html#DT_MONEY),
[SMALLFLOAT](DataTypes.html#DT_SMALLFLOAT), and
[FLOAT](DataTypes.html#DT_FLOAT) data types, *format-string* consists of
a set of place holders that represent digits, currency symbols,
thousands and decimal separators. For example, `"###.##@"` defines three
places to the left of the decimal point and exactly two to the right,
plus a currency symbol at the end of the string.

When used with numeric values, the *format-string* must use normalized
place holders described in the table below. The place holders will be
replaced by the elements defined in the
[DBMONEY](EnvironmentVariables.html#EV_DBMONEY) or
[DBFORMAT](EnvironmentVariables.html#EV_DBFORMAT) environment variables.
Field input cannot be supported if the format is not defined with
normalized place holders.

If the numeric value is too large to fit in the number of characters
defined by the format, an overflow text is displayed (\*\*\*\*).

If the actual number displayed requires fewer characters than
*format-string* specifies, numbers are right-aligned and padded on the
left with blanks.

If necessary to satisfy the *format-string* specification, the number
values are rounded before display.

::: {align="left"}
  --------------- --------------------------------------------------------------------------------------------------------------------------------------------------------------
  **Character**   **Description**
  `*`             Fills with asterisks any position that would otherwise be blank.
  `&`             Fills with zeros any position that would otherwise be blank.
  `#`             This does not change any blank positions in the display.
  `<`             Causes left alignment.
  `-`             Displays a minus sign for negative numbers.
  `+`             Displays a plus sign for positive numbers.
  `(`             Displayed as left parentheses for negative numbers (accounting parentheses).
  `)`             Displayed as right parentheses for negative numbers (accounting parentheses).
  `,` (comma)     Placeholder for thousand separator defined in [DBFORMAT](EnvironmentVariables.html#EV_DBFORMAT).
  `.` (period)    Placeholder for decimal separator defined in [DBMONEY](EnvironmentVariables.html#EV_DBMONEY) or [DBFORMAT](EnvironmentVariables.html#EV_DBFORMAT).
  `$`             Placeholder for the *front* currency symbol defined in [DBMONEY](EnvironmentVariables.html#EV_DBMONEY) or [DBFORMAT](EnvironmentVariables.html#EV_DBFORMAT).
  `@`             Placeholder for the *back* currency symbol defined in [DBMONEY](EnvironmentVariables.html#EV_DBMONEY) or [DBFORMAT](EnvironmentVariables.html#EV_DBFORMAT).
  --------------- --------------------------------------------------------------------------------------------------------------------------------------------------------------
:::

The following table illustrates the results of different combinations of
[DBFORMAT](EnvironmentVariables.html#EV_DBFORMAT) setting and format
string on the same value.

  ----------- ---------------------- -------------- --------------
  **Value**   **FORMAT attribute**   **DBFORMAT**   **Result**
  `1234.56`   `$#,###.##`            `$:,:.:`       `$1,234.56`
  `1234.56`   `$#,###.##`            `:.:,:DM`      `1.234,56`
  `1234.56`   `#,###.##@`            `$:,:.:`       `1,234.56`
  `1234.56`   `#,###.##@`            `:.:,:DM`      `1.234,56DM`
  ----------- ---------------------- -------------- --------------

When the user enters numeric or currency values in fields, the runtime
system behaves as follows:

- If a symbol is entered that was defined as a decimal separator in
  [DBFORMAT](EnvironmentVariables.html#EV_DBFORMAT), it is interpreted
  as the decimal separator.
- For [MONEY](DataTypes.html#DT_MONEY) fields, it disregards any *front*
  (leading) or *back* (trailing) currency symbol and any thousands
  separators that the user enters.
- For [DECIMAL](DataTypes.html#DT_DECIMAL) fields, the user must enter
  values without currency symbols.

#### Date formats:

For [DATE](DataTypes.html#DT_DATE) data types, the runtime system
recognizes these symbols as special in *format-string*:

::: {align="left"}
  --------------- -------------------------------------------------------------------------------------------
  **Character**   **Description**
  `dd`            Day of the month as a 2-digit integer.
  `ddd`           Three-letter English-language abbreviation of the day of the week, for example, Mon, Tue.
  `mm`            Month as a 2-digit integer.
  `mmm`           Three-letter English-language abbreviation of the month, for example, Jan, Feb.
  `yy`            Year, as a 2-digits integer representing the 2 trailing digits.
  `yyyy`          Year as a 4-digit number.
  --------------- -------------------------------------------------------------------------------------------
:::

The form compiler interprets any other characters as literals and
displays them wherever you place them within *format-string*.

Below some *format-string* examples and their corresponding display
formats for a DATE field:

  -------------- ------------------------ ------------------------
  **Value**      **FORMAT attribute**     **Result**
  `1999-09-23`   *none*                   `09/23/1999`
  `1999-09-23`   `mm/dd/yy`               `09/23/99`
  `1999-09-23`   `mmm dd, yyyy`           `Sep 23, 1999`
  `1999-09-23`   `yymmdd`                 `990923`
  `1999-09-23`   `dd-mm-yy`               `23-09-99`
  `1999-09-23`   `(ddd.) mmm. dd, yyyy`   `(Thu.) Sep. 23, 1999`
  -------------- ------------------------ ------------------------

#### Example:

``` linenumber
01 EDIT f001 = order.thedate, FORMAT = "mm/dd/yyyy";
```

------------------------------------------------------------------------

### [FONTPITCH Attribute]{#FA_FONTPITCH}

#### Purpose:

This attribute defines the character font type as fixed or variable when
the default font is used.

#### Syntax:

`FONTPITCH = `[`{`]{.underline}`FIXED`[`|`]{.underline}`VARIABLE`[`}`]{.underline}

#### Usage:

By default, most front ends use variable width character fonts, but in
some cases you might need to use a fixed font.

When using `FIXED`, you force the characters to have a fixed size.

When using `VARIABLE`, you allow the characters to have a variable size.

It is recommended that you use a [STYLE](#FA_STYLE) defining a fixed
font instead of this attribute.

------------------------------------------------------------------------

### [GRIDCHILDRENINPARENT Attribute]{#FA_GRIDCHILDRENINPARENT}

#### Purpose:

This attribute is used for a container to align its children to the
parent container.

#### Syntax:

`GRIDCHILDRENINPARENT`

#### Usage:

By default, child elements of a container are aligned locally inside the
container layout cells. With this attribute, you can force children to
be aligned according to the layout cells of the parent container of the
container to which you assign this attribute.

This is useful, for example, when you want to align fields across groups
defined with [Layout Tags](FormSpecFiles.html#FF_LAYOUT_TAG) inside a
[GRID](FormSpecFiles.html#FF_CONTAINER_GRID):

``` linenumber
01 LAYOUT
02   GRID
03   {
04    <G g1                             >
05     Field1 [f1                      ]
06     Field2 [f2                      ]
07     Field3 [f3                      ]
08 
09    <G g2                             >
10     F4     [f4                  ]
11     F5     [f5                  ]
12 
13   }
14   END
15 END
16 ATTRIBUTES
17 GROUP g1 : GRIDCHILDRENINPARENT;
18 GROUP g2 : GRIDCHILDRENINPARENT;
19 EDIT f1 = FORMONLY.field1;
20 EDIT f2 = FORMONLY.field2;
21 EDIT f3 = FORMONLY.field3;
22 EDIT f4 = FORMONLY.field4;
23 EDIT f5 = FORMONLY.field5;
24 END
```

------------------------------------------------------------------------

### [INCLUDE Attribute]{#FA_INCLUDE}

#### Purpose:

Defines a list of possible values.

#### Syntax:

`INCLUDE = ( `[`{`]{.underline}` NULL `[`|`]{.underline}` `*`literal`*` `[`[`]{.underline}` TO `*`literal`*` `[`]`]{.underline}` `[`}`]{.underline}` `[`[`]{.underline}`,`[`...]`]{.underline}` )`

#### Notes:

1.  *literal* can be any [literal expression](Literals.html) supported
    by the form compiler.

#### Usage:

The ` INCLUDE` attribute specifies acceptable values for a field and
causes the runtime system to check the data before accepting an input
value.

If the field is [FORMONLY](FormSpecFiles.html#FF_FORMONLY_FIELD), you
must also specify a data type when you assign the ` INCLUDE` attribute
to a field.

[DATETIME](Literals.html#LT_DATETIME) and
[INTERVAL](Literals.html#LT_INTERVAL) literals are not supported.

#### Example:

``` linenumber
01 EDIT f001 = compute.rate, INCLUDE = ( 1 TO 100, 200, NULL);
02 EDIT f002 = customer.state, INCLUDE = ( "AL" TO "GA", "IA" TO "WY" );
```

------------------------------------------------------------------------

### [INVISIBLE Attribute]{#FA_INVISIBLE}

#### Purpose:

The `INVISIBLE` attribute prevents user-entered data from being echoed
on the screen during an interactive statement.

#### Syntax:

`INVISIBLE`

#### Usage:

Characters that the user enters in a field with the `INVISIBLE`
attribute are not displayed during data entry. Depending on the front
end type, the typed characters are displayed using the blank, star,
underscore or dot characters.

Note that the `INVISIBLE` attribute does *not* prevent display
instructions like [DISPLAY](RecordDisplay.html#DISPLAY_TO), [DISPLAY
ARRAY](DisplayArray.html) from explicitly displaying data in the field.

------------------------------------------------------------------------

### [IMAGE Attribute]{#FA_IMAGE}

#### Purpose:

The `IMAGE` attribute defines the image resource to be displayed in the
form item.

#### Syntax:

`IMAGE = "`*`resource`*`"`

#### Notes:

1.  *resource* defines the picture resource (see below for possible
    sources and formats).

#### Usage:

This attribute is used to define the image resource to be displayed form
items such a [button](FormSpecFiles.html#FF_ITEMTYPE_BUTTON),
[buttonedit](FormSpecFiles.html#FF_ITEMTYPE_BUTTON) or a [static image
item](FormSpecFiles.html#FF_STATIC_IMAGE).

The *resource* string can be one of the following:

1.  A simple file name (with or without extension), using a relative or
    an absolute path.
2.  A path to an image on a server in the URL (Uniform Resource Locator)
    form.

It is recommended that you use simple image file names without the file
extension, and define the
[FGLIMAGEPATH](EnvironmentVariables.html#EV_FGLIMAGEPATH) environment
variable to centralize image files on the application server in a
directory created specifically for images. For portability reasons, use
.png or .svg image file formats only.

##### Supported image formats

Here is the list of image file formats supported by the different
front-ends:

  -------------------------------- -------------------------------------------
  **Suffix (case insensitive) **   **Front-ends supporting the file format**
  `.BMP`                           GDC, GWC
  `.GIF`                           GDC, GWC
  `.ICO`                           GDC, GWC
  `.JPG`                           GDC, GWC
  `.PNG`                           GDC, GWC
  `.SVG`                           GDC, GWC
  `.TIFF`                          GDC, GWC
  -------------------------------- -------------------------------------------

According to the front-end type, some image file formats or image data
formats might not be supported.

##### Using file names or paths

If the image specification is a simple string without an URL or URI
prefix, it is identified as a file path. The file is first sought in the
picture directory on the client workstation. According to the front-end
type, this local directory can actually be on a remote machine where the
GAS middleware component is located. If the file is not found, the
front-end automatically sends an image request to the runtime system, in
order to search for an image on the server where the programs are
executed. The runtime system searches for server-side images by using
the [FGLIMAGEPATH](EnvironmentVariables.html#EV_FGLIMAGEPATH)
environment variable. If
[FGLIMAGEPATH](EnvironmentVariables.html#EV_FGLIMAGEPATH) is not set,
the image files are searched in the current working directory.

**Warning: By default, if
[FGLIMAGEPATH](EnvironmentVariables.html#EV_FGLIMAGEPATH) is not set,
the image files are searched in the current working directory. Image
file names can use absolute or relative paths and the whole application
server file system can be searched (according to the permissions of the
operating system user running the fglrun process). This can be a
security hole because fake front-ends could ask for critical server
files that are not images.\
When setting [FGLIMAGEPATH](EnvironmentVariables.html#EV_FGLIMAGEPATH),
the runtime system will only transfer files found in the directories
listed in that environment variable. You can still use absolute or
relative paths in the image file names, but the files must be located
below one of the directories listed in FGLIMAGEPATH. For maximum
security, put the image files in directories that contain only image
files, and keep critical data or program file in separate directories.\
Note however that images displayed by program to [image
fields](FormSpecFiles.html#FF_IMAGE_FIELD) do not follow the
FGLIMAGEPATH security restriction. Image field do not use the `IMAGE`
attribute: For fields, the image is specified in the field value.**

##### Using an image server with URL names

If the image specification starts with a URL prefix, the front-end will
try to download the image from the location specified by the URL.

Currently supported URLs are:

  -------------------------------------- ------------------------------
  **Image resource location (URL)**      **Description**
  `http://`*`location-specification`*    HTTP server
  `https://`*`location-specification`*   HTTPS server (HTTP over SSL)
  `ftp://`*`location-specification`*     FTP server
  -------------------------------------- ------------------------------

#### Example:

``` linenumber
01 BUTTONEDIT f001 = FORMONLY.field01, IMAGE = "zoom";
02 BUTTON b01 : open_file, IMAGE = "buttons/fileopen";
03 BUTTON b02 : accept, IMAGE = "http://myserver/images/accept.png";
```

------------------------------------------------------------------------

### [KEY Attribute]{#FA_KEY}

#### Purpose:

The `KEY` attribute is used to define the labels of keys when the field
is made current.

#### Syntax:

`KEY `*`keyname`*` = `[`[`]{.underline}`%`[`]`]{.underline}`"`*`label`*`"`

#### Notes:

1.  *keyname* is the name of a key ( like `F10`, `"Control-z"` ).
2.  Note that the *keyname* has to be specified in quotes if you want to
    use Control / Shift / Alt key modifiers.
3.  *label* is the text to be displayed in the button corresponding to
    the key.

**Warning: This attributes is supported for backward compatibility with
Four Js BDS.**

See also the [KEYS](FormSpecFiles.html#SECTION_KEYS) section to define
key labels for the whole form.

#### Example:

``` linenumber
01 EDIT f001 = customer.city, KEY F10 = "City list";
02 EDIT f002 = customer.state, KEY "Control-z" = "Open Zoom";
```

------------------------------------------------------------------------

### [MINHEIGHT Attribute]{#FA_MINHEIGHT}

#### Purpose:

The `MINHEIGHT` attribute defines the minimum height of a form.

#### Syntax:

`MINHEIGHT = `*`integer`*` `

#### Notes:

1.  *integer* defines the minimum height of the element, as a number of
    [grid cells](Layout.html).

#### Usage:

The `MINHEIGHT` attribute is used to define a minimum height of the
form/window. It must be specified in the attributes of the
[LAYOUT](FormSpecFiles.html#SECTION_LAYOUT) section.

The unit defaults to a number of [grid cells](Layout.html). This is the
equivalent of the `CHARACTERS` in the [HEIGHT](#FA_HEIGHT) attribute
specification.

See also: [MINWIDTH](#FA_MINWIDTH).

#### Example:

``` linenumber
01 LAYOUT ( MINWIDTH=60, MINHEIGHT=50 )
02 GRID
03 ...
```

------------------------------------------------------------------------

### [MINWIDTH Attribute]{#FA_MINWIDTH}

#### Purpose:

The `MINWIDTH` attribute defines the minimum width of a form.

#### Syntax:

`MINWIDTH = `*`integer`*` `

#### Notes:

1.  *integer* defines the minimum width of the element, as a number of
    [grid cells](Layout.html).

#### Usage:

The `MINWIDTH` attribute is used to define a minimum width of the
form/window. It must be specified in the attributes of the
[LAYOUT](FormSpecFiles.html#SECTION_LAYOUT) section.

The unit defaults to a number of [grid cells](Layout.html). This is the
equivalent of the `CHARACTERS` in the [WIDTH](#FA_WIDTH) attribute
specification.

See also: [MINHEIGHT](#FA_MINHEIGHT).

#### Example:

``` linenumber
01 LAYOUT ( MINWIDTH=60, MINHEIGHT=50 )
02 GRID
03 ...
```

------------------------------------------------------------------------

### [NOT NULL Attribute]{#FA_NOT_NULL}

#### Purpose:

The ` NOT NULL` attribute sets that the field does not accept NULL
values.

#### Syntax:

`NOT NULL`

#### Usage:

This attribute requires that the field contains a value. If the field
contains a default value, the `NOT NULL` attribute satisfied. To insist
on data entry from the user, use `NOT NULL` in the field definition, or
make sure the corresponding column is defined as NOT NULL in the
[database schema file](DatabaseSchema.html).

The `NOT NULL` keywords can also be used in the type definition of
[FORMONLY fields](FormSpecFiles.html#FF_FORMONLY_FIELD).

#### Example:

``` linenumber
01 EDIT f001 = customer.city, NOT NULL;
```

------------------------------------------------------------------------

### [NOENTRY Attribute]{#FA_NOENTRY}

#### Purpose:

The ` NOENTRY` attribute prevents data entry in the field during an
[INPUT](RecordInput.html) or [INPUT ARRAY](InputArray.html) statement.

#### Syntax:

`NOENTRY`

#### Usage:

Use the ` NOENTRY` attribute to bypass field input during an
[INPUT](RecordInput.html) or [INPUT ARRAY](InputArray.html) statement.
When using a WITHOUT DEFAULTS dialog option, the content of the
corresponding program variable is displayed in the field. A `NOENTRY`
field is like a disabled field, it cannot get the focus.

Note that the ` NOENTRY` attribute does *not* prevent data entry into a
field during a [CONSTRUCT](Construct.html) statement.

#### Example:

``` linenumber
01 EDIT f001 = order.totamount, NOENTRY;
```

------------------------------------------------------------------------

### [ORIENTATION Attribute]{#FA_ORIENTATION}

#### Purpose:

The `ORIENTATION` attribute defines whether an element displays
vertically or horizontally.

#### Syntax:

`ORIENTATION = `[`{`]{.underline}` VERTICAL `[`|`]{.underline}` HORIZONTAL `[`}`]{.underline}

#### Usage:

The `ORIENTATION` attribute is typically used in the definition of a
[RADIOGROUP](FormSpecFiles.html#FF_ITEMTYPE_RADIOGROUP) form item, to
specify how radio items have to be displayed.

#### Example:

``` linenumber
01 RADIOGROUP f001 = customer.status, ORIENTATION=HORIZONTAL;
```

------------------------------------------------------------------------

### [PICTURE Attribute]{#FA_PICTURE}

#### Purpose:

The ` PICTURE` attribute specifies a character pattern for data entry in
a text field, and prevents entry of values that conflict with the
specified pattern.

#### Syntax:

`PICTURE = "`*`format-string`*`"`

#### Notes:

1.  *format-string* defines the data input pattern of the field.

#### Usage:

*format-string* can be any combination of characters, where the
characters \"A\", \"#\" and \"X\" have a special meaning.

- The character \"A\" specifies **any letter** (alpha-numeric) character
  at a given position.
- The character \"#\" specifies **any digit** character at a given
  position.
- The character \"X\" specifies **any character** at a given position.

Any character different from \"A\", \"X\" and \"#\" is treated as a
literal. Such characters automatically appear in the field and do not
have to be entered by the user.

The ` PICTURE` attribute does not require data entry into the entire
field. It only requires that whatever characters are entered conform to
*format-string*.

When ` PICTURE` specifies input formats for
[DATETIME](DataTypes.html#DT_DATETIME) or
[INTERVAL](DataTypes.html#DT_INTERVAL) fields, the form compiler does
not check the syntax of *format-string*, but your form will work if the
syntax is correct. Any error in *format-string*, however, such as an
incorrect field separator, produces a runtime error.

The typical usage for the `PICTURE` attribute is for (fixed-length)
[CHAR](DataTypes.html#DT_CHAR) fields. It is not recommended to use
`PICTURE` for other data types, especially numeric or date/time fields:
The current value of the field must always match (i.e. be formatted
according to) `PICTURE`.

#### Example:

``` linenumber
01 EDIT f001 = carinfo.ident, PICTURE = "AA####-AA(X)";
```

------------------------------------------------------------------------

### [PROGRAM Attribute]{#FA_PROGRAM} **TUI Only!**

#### Purpose:

The ` PROGRAM` attribute can specify an external application program to
work with screen fields of data type [TEXT](DataTypes.html#DT_TEXT) or
[BYTE](DataTypes.html#DT_BYTE).

#### Syntax:

`PROGRAM = "`*`editor`*`"`

#### Notes:

1.  *editor* is the name of the program that must be used to edit the
    special field data.

#### Usage:

You can assign the ` PROGRAM` attribute to a
[TEXT](DataTypes.html#DT_TEXT) or [BYTE](DataTypes.html#DT_BYTE) field
to call an external program to work with the BYTE or TEXT values.

Users can invoke the external program by pressing the exclamation point
( ! ) key while the screen cursor is in the field.

The external program then takes over control of the screen. When the
user exits from the external program, the form is redisplayed with any
display attributes besides ` PROGRAM` in effect.

When no ` PROGRAM` attribute is used, the
[DBEDIT](EnvironmentVariables.html#EV_DBEDIT) environment variable
defines the default editor.

**Warning: This attribute works in
[TUI](FglTerms.html#TEXT_USER_INTERFACE) mode only.**

------------------------------------------------------------------------

### [PROPERTIES Attribute]{#FA_PROPERTIES}

#### Purpose:

The `PROPERTIES` attribute is used to define a list of widget-specific
characteristics.

#### Syntax:

`PROPERTIES = ( `[`{`]{.underline}` `*[`single-property`](#single-property)*` `[`|`]{.underline}` `*[`array-property`](#array-property)*` `[`|`]{.underline}` `*[`map-property`](#map-property)*` `[`}`]{.underline}` `[`[,...]`]{.underline}` )`

where [single-property]{#single-property} is:

*`identifier`*` = `*[`property-value`](#property-value)*

and [array-property]{#array-property} is:

*`identifier`*` = ( `*[`property-value`](#property-value)*` `[`[,...]`]{.underline}` )`

and [map-property]{#map-property} is:

*`identifier`*` = ( `*`item-identifier`*` = `*[`property-value`](#property-value)*` `[`[,...]`]{.underline}` )`

and *[property-value]{#property-value}* is:

[`{`]{.underline}` `*`numeric-value`*` `[`|`]{.underline}` "`*`string-value`*`" `[`}`]{.underline}

#### Notes:

1.  *numeric-value* is an integer or decimal literal.
2.  *string-value* is a string literal delimited by single or double
    quotes.

#### Usage:

The `PROPERTIES` attribute is typically used to define the
widget-specific attributes of a
[WEBCOMPONENT](FormSpecFiles.html#FF_ITEMTYPE_WEBCOMPONENT) form item.

Note that property names names and values are not checked, to let you
freely set any characteristic of an external widget.\
You must verify that the front-end side implementation supports the
specified properties.

#### Example:

``` linenumber
01 WEBCOMPONENT f01 = FORMONLY.mycalendar,
02    COMPONENTTYPE = calendar,
03    PROPERTIES = ( type = "gregorian",
04                week_start = 2,
05                days_off = ( 1, 7 ),
06                dates_off = ( "????-11-25", "????-06-20" ),
07                day_titles = ( t1 = "Sunday",
08                               t2 = "Monday",
09                               t3 = "Tuesday",
10                               t4 = "Wednesday",
11                               t5 = "Thursday",
12                               t6 = "Friday",
13                               t7 = "Saterday" )
14    ;
```

------------------------------------------------------------------------

### [QUERYEDITABLE Attribute]{#FA_QUERYEDITABLE}

#### Purpose:

The `QUERYEDITABLE` attribute makes a combobox field editable during a
[CONSTRUCT](Construct.html) statement.

#### Syntax:

`QUERYEDITABLE`

#### Usage:

The `QUERYEDITABLE` attribute is effective only during a
[CONSTRUCT](Construct.html) statement..

This attribute is useful when the display values match the real values
in the [ITEMS](#FA_ITEMS) attribute.

------------------------------------------------------------------------

### [REQUIRED Attribute]{#FA_REQUIRED}

#### Purpose:

The ` REQUIRED` attribute forces the user to modify the content of a
field during an [INPUT](RecordInput.html) or [INPUT
ARRAY](InputArray.html) statement.

#### Syntax:

`REQUIRED`

#### Usage:

This attribute forces the user to modify the content of the field during
the dialog execution. If the user subsequently erases the entry during
the same input, the runtime system considers the ` REQUIRED` attribute
satisfied.

The ` REQUIRED` attribute is effective only when the field name appears
in the list of screen fields of an [INPUT](RecordInput.html) or [INPUT
ARRAY](InputArray.html) statement.

If both the `REQUIRED` and ` DEFAULT` attributes are assigned to the
same field, the runtime system assumes that the default value satisfies
the ` REQUIRED` attribute.

If the dialog instruction uses the `WITHOUT DEFAULTS` clause, the
current value of the variable linked to the `REQUIRED` field is
considered as a default value; the runtime system assumes that the field
satisfies the ` REQUIRED` attribute, even if the variable value is
[NULL](Programs.html#PC_NULL).

To insist on a non-null entry, use the [NOT NULL](#FA_NOT_NULL)
attribute instead. The `NOT NULL` attribute can be specified in the
field definition or in the  corresponding column in the [database schema
file](DatabaseSchema.html).

------------------------------------------------------------------------

### [REVERSE Attribute]{#FA_REVERSE}

#### Purpose:

On character terminals, the ` REVERSE` attribute displays any value in
the field in reverse video (dark characters in a bright field).

#### Syntax:

`REVERSE`

#### Notes:

1.  With character based terminals, the REVERSE video escape sequences
    must be defined in the TERMINFO or TERMCAP databases.

------------------------------------------------------------------------

### [SAMPLE Attribute]{#FA_SAMPLE}

#### Purpose:

The `SAMPLE` attribute defines the text to be used to compute the width
of a form field.

#### Syntax:

`SAMPLE = "`*`text`*`"`

#### Notes:

1.  *text* is the sample string that will be used to compute the width
    of the field.

#### Usage:

By default, form fields are rendered by the client with a size
determined by the current font and the number of characters used in the
layout grid. The field width is computed so that the largest value can
fit in the widget.

Sometimes the default computed width is too wide for the typical values
displayed in the field. For example, numeric fields usually need less
space as alphanumeric fields. If the values are always smaller, you can
use the `SAMPLE` attribute to provide a hint for the front end to
compute the best width for that form field.

By default the physical width of the fields is:

- if the width is smaller than 6 chars, the pixel width of the character
  \'M\', multiplied by the number of characters the field is designed
  for,
- if the width is bigger than 6 chars, the pixel width of 6 characters
  \'M\' plus the pixel width of the character \'0\' , multiplied by the
  number of characters the field is designed for minus 6.

The default sample looks like \"MMMMMM0000\"\...

You can define a default sample for all fields used in the form, by
specifying a `DEFAULT SAMPLE` option in the
[INSTRUCTIONS](FormSpecFiles.html#SECTION_INSTRUCTIONS) section.

See also: [DEFAULT SAMPLE](FormSpecFiles.html#SECTION_INSTRUCTIONS).

#### Example:

``` linenumber
01 EDIT cid = customer.custid, SAMPLE="0000";
02 EDIT ccode = customer.ucode, SAMPLE="MMMMMM";
03 DATEEDIT be01 = customer.created, SAMPLE="00-00-0000";
```

------------------------------------------------------------------------

### [SCROLL Attribute]{#FA_SCROLL}

#### Purpose:

The `SCROLL` attribute can be used to enable horizontal scrolling in a
character field.

#### Syntax:

`SCROLL`

#### Usage:

By default, the maximum data input length is defined by the width of the
[item-tag](FormSpecFiles.html#FF_ITEM_TAG) of the field. For example, if
you define an CHAR field in the form with a length of 3 characters,
users can only enter a maximum of 3 characters, even if the program
variable used for input is a CHAR(20).

If you want to let the user input more characters than the width of the
[item-tag](FormSpecFiles.html#FF_ITEM_TAG) of the field, use the
`SCROLL` attribute.

Note that the `SCROLL` attribute applies only to fields with character
data input.

See also: [Field Input Length](FormSpecFiles.html#FF_FIELD_MAXLENGTH).

------------------------------------------------------------------------

### [STRETCH Attribute]{#FA_STRETCH}

#### Purpose:

The `STRETCH` attribute specifies how a widget must resize when the
parent container is resized.

#### Syntax:

`STRETCH = `[`{`]{.underline}` NONE `[`|`]{.underline}` X `[`|`]{.underline}` Y `[`|`]{.underline}` BOTH `[`}`]{.underline}

#### Usage:

This attribute is typically used with form items that can be resized
like [IMAGE](FormSpecFiles.html#FF_ITEMTYPE_IMAGE) or
[TEXTEDIT](FormSpecFiles.html#FF_ITEMTYPE_TEXTEDIT) fields. By default
such form items have a fixed width and height, but in some cases you may
want to force the widget to resize vertically, horizontally, or in both
directions.

#### Example:

``` linenumber
01 IMAGE i01 = FORMONLY.image01, STRETCH=BOTH;
```

------------------------------------------------------------------------

### [STEP Attribute]{#FA_STEP}

#### Purpose:

The `STEP` attribute specifies how a value is increased or decreased in
one step (by a mouse click or key up/down).

#### Syntax:

`STEP = `*`integer`*

#### Usage:

This attribute is typically used with form items allowing the user to
change the current integer value by a mouse click like
[SLIDER](FormSpecFiles.html#FF_ITEMTYPE_SLIDER),
[SPINEDIT](FormSpecFiles.html#FF_ITEMTYPE_SPINEDIT).

#### Example:

``` linenumber
01 SLIDER s01 = FORMONLY.slider, STEP=10;
```

------------------------------------------------------------------------

### [TEXT Attribute]{#FA_TEXT}

#### Purpose:

The `TEXT` attribute defines the label associated with a form item, such
as the text of a checkbox item.

#### Syntax:

`TEXT = `[`[`]{.underline}`%`[`]`]{.underline}`"`*`string`*`"`

#### Notes:

1.  *string* defines the label to be associated with the form item.
2.  *string* can be a [localized string](LocalizedStrings.html).

#### Example:

``` linenumber
01 CHECKBOX cb01 = FORMONLY.checkbox01, TEXT="OK", VALUECHECKED='y', VALUEUNCHECKED='n';
```

------------------------------------------------------------------------

### [TITLE Attribute]{#FA_TITLE}

#### Purpose:

The `TITLE` attribute defines the title of a form item. Use may be
restricted to form fields that make up the columns of a table container;
see the documentation for the relevant form item.

#### Syntax:

`TITLE = `[`[`]{.underline}`%`[`]`]{.underline}`"`*`string`*`"`

#### Notes:

1.  *string* defines the title to be associated with the form item.
2.  *string* can be a [localized string](LocalizedStrings.html).

#### Example:

``` linenumber
01 EDIT col1 = FORMONLY.column1, TITLE="Num";
```

------------------------------------------------------------------------

### [VALUEMIN Attribute]{#FA_VALUEMIN}

#### Purpose:

The `VALUEMIN` attribute defines a lower limit of values displayed in
widgets (such as progress bars).

#### Syntax:

`VALUEMIN = `*`integer`*

#### Notes:

1.  *integer* is a integer [literal](Literals.html).

#### Usage:

This attribute is typically used in
[PROGRESSBAR](FormSpecFiles.html#FF_ITEMTYPE_PROGRESSBAR),
[SPINEDIT](FormSpecFiles.html#FF_ITEMTYPE_SPINEDIT) and
[SLIDER](FormSpecFiles.html#FF_ITEMTYPE_SLIDER) fields, to define the
lower limit.

See [form item type](FormSpecFiles.html) definition for default value.

Note that this attribute is not used by the runtime system to validate
the field, you must use the [INCLUDE](#FA_INCLUDE) attribute to control
value boundaries.

------------------------------------------------------------------------

### [VALUEMAX Attribute]{#FA_VALUEMAX}

#### Purpose:

The `VALUEMAX` attribute defines a upper limit of values displayed in
widgets (such as progress bars).

#### Syntax:

`VALUEMAX = `*`integer`*

#### Notes:

1.  *integer* is an integer [literal](Literals.html).

#### Usage:

This attribute is typically used in
[PROGRESSBAR](FormSpecFiles.html#FF_ITEMTYPE_PROGRESSBAR),
[SPINEDIT](FormSpecFiles.html#FF_ITEMTYPE_SPINEDIT) and
[SLIDER](FormSpecFiles.html#FF_ITEMTYPE_SLIDER) fields, to define the
upper limit.

See [form item type](FormSpecFiles.html) definition for default value.

Note that this attribute is not used by the runtime system to validate
the field, you must use the [INCLUDE](#FA_INCLUDE) attribute to control
value boundaries.

------------------------------------------------------------------------

### [VALUECHECKED Attribute]{#FA_VALUECHECKED}

#### Purpose:

The `VALUECHECKED` attribute defines the value associated with a
checkbox item when it is checked.

#### Syntax:

`VALUECHECKED = `*`value`*` `

#### Notes:

1.  *value* is a numeric or string [literal](Literals.html), or one of
    the following keywords: `NULL`, `TRUE`, `FALSE`.

#### Usage:

This attribute is used in conjunction with the `VALUEUNCHECKED`
attribute to define the values corresponding to the states of a
`CHECKBOX`.

Note that this attribute is not used by the runtime system to validate
the field, you must use the [INCLUDE](#FA_INCLUDE) attribute to control
value boundaries.

See [CHECKBOX definition](FormSpecFiles.html#FF_ITEMTYPE_CHECKBOX) for
more details.

#### Example:

``` linenumber
01 CHECKBOX cb01 = FORMONLY.checkbox01, TEXT="OK", VALUECHECKED=TRUE, VALUEUNCHECKED=FALSE;
```

------------------------------------------------------------------------

### [VALUEUNCHECKED Attribute]{#FA_VALUEUNCHECKED}

#### Purpose:

The `VALUEUNCHECKED` attribute defines the value associated with a
checkbox item when it is [not]{.underline} checked.

#### Syntax:

`VALUEUNCHECKED = `*`value`*` `

#### Notes:

1.  *value* is a numeric or string [literal](Literals.html), or one of
    the following keywords: `NULL`, `TRUE`, `FALSE`.

#### Usage:

This attribute is used in conjunction with the `VALUECHECKED` attribute
to define the values corresponding to the states of a `CHECKBOX`.

Note that this attribute is not used by the runtime system to validate
the field, you must use the [INCLUDE](#FA_INCLUDE) attribute to control
value boundaries.

See [CHECKBOX definition](FormSpecFiles.html#FF_ITEMTYPE_CHECKBOX) for
more details.

#### Example:

``` linenumber
01 CHECKBOX cb01 = FORMONLY.checkbox01, TEXT="OK", VALUECHECKED="Y", VALUEUNCHECKED="N";
```

------------------------------------------------------------------------

### [UNSORTABLE Attribute]{#FA_UNSORTABLE}

#### Purpose:

Indicates that the element cannot be selected by the user for sorting.

#### Syntax:

`UNSORTABLE`

#### Usage:

By default, a [TABLE](FormSpecFiles.html#FF_CONTAINER_TABLE) container
allows the user to sort the columns by a left-click on the column
header. Use this attribute to prevent a sort on a specific column.

Makes sense only for a field that is used for the definition of a column
in a [TABLE](FormSpecFiles.html#FF_CONTAINER_TABLE) container.

#### Example:

``` linenumber
01 EDIT c01 = item.comment, UNSORTABLE;
```

------------------------------------------------------------------------

### [UNSORTABLECOLUMNS Attribute]{#FA_UNSORTABLECOLUMNS}

#### Purpose:

Indicates that the columns of the table cannot be selected by the user
for sorting.

#### Syntax:

`UNSORTABLECOLUMNS`

#### Usage

Same effect as [UNSORTABLE](#FA_UNSORTABLE), but at the
[TABLE](FormSpecFiles.html#FF_CONTAINER_TABLE) level, so that none of
the table columns can be used for sort.

#### Example:

``` linenumber
01 TABLE t1 ( UNSORTABLECOLUMNS )
```

------------------------------------------------------------------------

### [UNSIZABLE Attribute]{#FA_UNSIZABLE}

#### Purpose:

Indicates that the element cannot be resized by the user.

#### Syntax:

`UNSIZABLE`

#### Usage:

By default, a [TABLE](FormSpecFiles.html#FF_CONTAINER_TABLE) container
allows the user to resize the columns by a drag-click on the column
header. Use this attribute to prevent a resize on a specific column.

Makes sense only for a field that is used for the definition of a column
in a [TABLE](FormSpecFiles.html#FF_CONTAINER_TABLE) container.

#### Example:

``` linenumber
01 EDIT c01 = item.comment, UNSIZABLE;
```

------------------------------------------------------------------------

### [UNSIZABLECOLUMNS Attribute]{#FA_UNSIZABLECOLUMNS}

#### Purpose:

Indicates that the columns of the table cannot be resized by the user.

#### Syntax:

`UNSIZABLECOLUMNS`

#### Usage

Same effect as [UNSIZABLE](#FA_UNSIZABLE), but at the
[TABLE](FormSpecFiles.html#FF_CONTAINER_TABLE) level, to make all
columns not resizable.

#### Example:

``` linenumber
01 TABLE t1 ( UNSIZABLECOLUMNS )
```

------------------------------------------------------------------------

### [UNHIDABLE Attribute]{#FA_UNHIDABLE}

#### Purpose:

Indicates that the element cannot be hidden or shown by the user with
the context menu.

#### Syntax:

`UNHIDABLE`

#### Usage:

By default, a [TABLE](FormSpecFiles.html#FF_CONTAINER_TABLE) container
allows the user to hide the columns by a right-click on the column
header. Use this attribute to prevent the user from hiding a specific
column.

Makes sense only for a field that is used for the definition of a column
in a [TABLE](FormSpecFiles.html#FF_CONTAINER_TABLE) container.

#### Example:

``` linenumber
01 EDIT c01 = item.comment, UNHIDABLE;
```

------------------------------------------------------------------------

### [UNHIDABLECOLUMNS Attribute]{#FA_UNHIDABLECOLUMNS}

#### Purpose:

Indicates that the columns of the table cannot be hidden or shown by the
user with the context menu.

#### Syntax:

`UNHIDABLECOLUMNS`

#### Usage

Same effect as [UNHIDABLE](#FA_UNHIDABLE), but at the
[TABLE](FormSpecFiles.html#FF_CONTAINER_TABLE) level, to make all
columns not hidable.

#### Example:

``` linenumber
01 TABLE t1 ( UNHIDABLECOLUMNS )
```

------------------------------------------------------------------------

### [UNMOVABLE Attribute]{#FA_UNMOVABLE}

#### Purpose:

The `UNMOVABLE` attribute prevents the user from moving a defined column
of a table.

#### Syntax:

`UNMOVABLE`

#### Usage:

By default, a [TABLE](FormSpecFiles.html#FF_CONTAINER_TABLE) container
allows the user to move the columns by dragging and dropping the column
header. Use this attribute to prevent the user from changing the order
of a specific column. Typically, `UNMOVABLE` is used on at least two
columns to prevent the user from changing the order of the input on
these columns.

------------------------------------------------------------------------

### [UNMOVABLECOLUMNS Attribute]{#FA_UNMOVABLECOLUMNS}

#### Purpose:

The `UNMOVABLECOLUMNS ` attribute prevents the user from moving columns
of a table.

#### Syntax:

`UNMOVABLECOLUMNS `

#### Usage:

By default, a [TABLE](FormSpecFiles.html#FF_CONTAINER_TABLE) container
allows the user to move the columns by dragging and dropping the column
header. Use this attribute to prevent the user from changing the order
of columns.

------------------------------------------------------------------------

### [UPSHIFT Attribute]{#FA_UPSHIFT}

#### Purpose:

The `UPSHIFT` attribute forces character input to uppercase letters.

#### Syntax:

`UPSHIFT`

#### Usage:

Assign the `UPSHIFT` attribute to a character field when you want the
runtime system to convert lowercase letters entered by the user to
uppercase letters, both on the screen and in the corresponding program
variable.

Because uppercase and lowercase letters have different values, storing
character strings in one or the other format can simplify sorting and
querying a database.

Characters entered by the user are converted in
[INPUT](RecordInput.html), [INPUT ARRAY](InputArray.html) and
[CONSTRUCT](Construct.html) instructions.

The results of conversions between uppercase and lowercase letters are
based on the locale settings (LANG). With single byte runners the
conversion of ASCII characters \>127 is controlled by the [locale
settings](Localization.html) (the LC_CTYPE environment variable).

#### Example:

``` linenumber
01 EDIT f001 = FORMONLY.thetitle, UPSHIFT;
```

See also: [DOWNSHIFT](#FA_DOWNSHIFT).

------------------------------------------------------------------------

### [VALIDATE Attribute]{#FA_VALIDATE}

#### Purpose:

`VALIDATE` is an Action Defaults attribute defining the data validation
level for a given action.

#### Syntax:

`VALIDATE = NO`

#### Usage:

The action default attribute `VALIDATE = NO `indicates that no data
validation must occur for this action. However, current input buffer
contains the text modified by the user before triggering the action.

------------------------------------------------------------------------

### [VALIDATE LIKE Attribute]{#FA_VALIDATE_LIKE}

#### Purpose:

The `VALIDATE LIKE` attribute instructs the form compiler to set the
field attributes that are defined in the .val database schema file for
the specified column.

#### Syntax:

`VALIDATE LIKE `[`[`]{.underline}*`table`*`.`[`]`]{.underline}*`column`*

#### Notes:

1.  *table* is the optional table name to qualify the column.
2.  *column* is the name of the column used to search for validation
    rules.

#### Usage:

Specifying the `VALIDATE LIKE` attribute is equivalent to writing in the
field definition all the attributes that are assigned to *table.column*
in the [.val database schema file](DatabaseSchema.html#VAL_FILE)
generated from the **syscolval** table.

Note that .val attributes are taken automatically from the schema file
if the field is linked to *table.column* in the field name
specification. The `VALIDATE LIKE` attribute is usually specified for
`FORMONLY` fields.

#### Warnings:

1.  The `VALIDATE LIKE` attribute is evaluated at compile time, not at
    runtime. If the database schema file changes, you should recompile
    all your forms.
2.  Even if all of the fields in the form are `FORMONLY`, the
    `VALIDATE LIKE` attribute requires the form compiler to access the
    database schema file that contains the description of *tabl*e.

#### Example:

``` linenumber
01 EDIT f001 = FORMONLY.fullname, VALIDATE LIKE customer.custname;
```

------------------------------------------------------------------------

### [INITIALIZER Attribute]{#FA_INITIALIZER}

#### Purpose:

The `INITIALIZER` attribute allows you to specify an initialization
function that will be automatically called by the runtime system to set
up the form item.

#### Syntax:

`INITIALIZER = `*`function`*

#### Notes:

1.  *function* is an identifier defining the program function to be
    called.

#### Usage:

The initialization function must exist in the program using the form
file and must be defined with a [ui.ComboBox](ClassComboBox.html)
parameter.

#### Warnings:

1.  The initialization function name is converted to lowercase by
    [fglform](Tools.html#TL_FGLFORM). Always use lowercase letters to
    avoid mistakes.

------------------------------------------------------------------------

### [ITEMS Attribute]{#FA_ITEMS}

#### Purpose:

The `ITEMS` attribute defines a list of possible values that can be used
by the form item.

#### Syntax:

`ITEMS = `[`{`]{.underline}` `*`single-value-list`*` `[`|`]{.underline}` `*`double-value-list`*` `[`}`]{.underline}` `

where *single-value-list* is:

`( `*`value`*` `[`[`]{.underline}`,`[`...]`]{.underline}` )`

where *double-value-list* is:

`( ( `*`value`*`, `*`label-value`*` ) `[`[`]{.underline}`,`[`...]`]{.underline}` )`

#### Notes:

1.  *single-value-list* is a comma-separated list of single values.
2.  *double-value-list* is a comma-separated list of (a, b) values pairs
    within parentheses.
3.  *value* is a numeric or string [literal](Literals.html), or one of
    the following keywords: `NULL`, `TRUE`, `FALSE`.
4.  *label-value* is a numeric literal, a string literal, or a
    [localized string](LocalizedStrings.html).

#### Warnings:

1.  It is only possible to use [localized
    strings](LocalizedStrings.html)  for item labels (i.e. not for key
    values).

#### Usage:

The list must be delimited by parentheses, and each element of the list
can be a simple [literal value](Literals.html) or a pair of literal
values delimited by parentheses.

Note that this attribute is not used by the runtime system to validate
the field, you must use the [INCLUDE](#FA_INCLUDE) attribute to force
the possible values.

The following example defines a list of simple values:

    ITEMS = ("Paris", "London", "New York")

The next example defines a list of pairs:

    ITEMS = ((1,"Paris"),(2,"London"),(3,"New York"))

This attribute can be used, for example, to define the list of a
`COMBOBOX` form item:

``` linenumber
01 COMBOBOX cb01 = FORMONLY.combobox01, ITEMS = ((1,"Paris"),(2,"London"),(3,"New York"));
```

In this case, the first value of a pair (1,2,3) defines the data values
of the form field and the second value of a pair (\"Paris\", \"London\",
\"New York\") defines the value to be displayed in the selection list.

When used in a `RADIOGROUP` form item, this attribute defines the list
of radio buttons:

``` linenumber
01 RADIOGROUP rg01 = FORMONLY.radiogroup01, ITEMS = ((1,"Paris"),(2,"London"),(3,"New York"));
```

In this case, the first value of a pair (1,2,3) defines the data values
of the form field and the second value of a pair (\"Paris\", \"London\",
\"New York\") defines the value to be displayed as the radio button
label.

[Localization]{.underline}

You can specify item labels with [Localized
Strings](LocalizedStrings.html), but this is only possible when you
specify a key and a label:

    ITEMS = ((1,%"item1"),(2,%"item2"),(3,%"item3"))

[Using NULL items]{.underline}

It is allowed to define a `NULL` value for an item (note that an empty
string is equivalent to `NULL`):

    ITEMS = ((NULL,"Enter bug status"),(1,"Open"),(2,"Resolved"))

In this case, the behavior of the field depends from the item type used.
For more details, see field type specific notes for
[COMBOBOX](FormSpecFiles.html#FF_ITEMTYPE_COMBOBOX) and
[RADIOGROUP](FormSpecFiles.html#FF_ITEMTYPE_RADIOGROUP).

------------------------------------------------------------------------

### [JUSTIFY Attribute]{#FA_JUSTIFY}

#### Purpose:

The `JUSTIFY` attribute defines the justification of the content of a
field and the alignment of table column headers.

#### Syntax:

`JUSTIFY = `[`{`]{.underline}` LEFT `[`|`]{.underline}` CENTER `[`|`]{.underline}` RIGHT `[`}`]{.underline}

#### Usage:

With the `JUSTIFY` attribute, you specify the justification of the
content of a field as `LEFT`, `CENTER` or `RIGHT` when the field is in
display state. This attribute is ignored for input (i.e. when the field
has the focus); only the default data justification rule applies when a
field is in input state. The default data justification depends on the
dialog type, the field [data type](DataTypes.html) and the
[FORMAT](#FA_FORMAT) attribute. For example, a numeric field value is
right aligned, while a string field is left aligned. The type of dialog
also defines the default justification: In a
[CONSTRUCT](Construct.html), all input fields are left aligned, for
search criteria input.

Note that the `JUSTIFY` attribute can be used with all form item types:
Additionally to the field content/data alignment, `JUSTIFY` defines the
alignment of table column headers indirectly (i.e. table column header
follows the alignment of field data). However, column header alignment
in tables may not be enabled by default; Check the front-end
[headerAlignment](PresentationStyles.html#STYATT_TABLE) Presentation
Style attribute.

You can specify the text alignment of [static
labels](FormSpecFiles.html#FF_ITEMTYPE_LABEL) with the `JUSTIFY`
attribute. 

#### Example:

``` linenumber
01 LABEL t01 : TEXT="Hello!", JUSTIFY=RIGHT;
02 EDIT f01 = order.value, JUSTIFY=CENTER;
```

------------------------------------------------------------------------

### [SCROLLBARS Attribute]{#FA_SCROLLBARS}

#### Purpose:

The `SCROLLBARS` attribute can be used to specify scrollbars for a form
item.

#### Syntax:

`SCROLLBARS = `[`{`]{.underline}` NONE `[`|`]{.underline}` VERTICAL `[`|`]{.underline}` HORIZONTAL `[`|`]{.underline}` BOTH `[`}`]{.underline}

#### Usage:

This attribute defines scrollbars for the form item, such as a
[TEXTEDIT](FormSpecFiles.html#FF_ITEMTYPE_TEXTEDIT).

#### Example:

``` linenumber
01 TEXTEDIT f001 = customer.fname, SCROLLBARS=BOTH;
```

------------------------------------------------------------------------

### [SIZEPOLICY]{#FA_SIZEPOLICY} Attribute

#### Purpose:

The `SIZEPOLICY` attribute is a sizing directive to display form
elements.

#### Syntax:

`SIZEPOLICY = `[`{`]{.underline}` INITIAL `[`|`]{.underline}` FIXED `[`|`]{.underline}` DYNAMIC `[`}`]{.underline}

#### Usage:

This attribute defines the initial size of some form elements in grids.
The default value of `SIZEPOLICY` is `INITIAL`. When the `SIZEPOLICY` is
`FIXED`, the form elements size is exactly the one defined in the Form
Specification File. The width of the element is computed from the
defined width and the font used. For some elements such as
[COMBOBOX](FormSpecFiles.html#FF_ITEMTYPE_COMBOBOX) or
[RADIOGROUP](FormSpecFiles.html#FF_ITEMTYPE_RADIOGROUP), you may want
the size of the widget to fit exactly to its content: When `SIZEPOLICY`
is `DYNAMIC`, the width of the element grows and shrinks according to
the width of the wider [item](#FA_ITEMS). When a form element is created
from a database (for instance populating a
[COMBOBOX](FormSpecFiles.html#FF_ITEMTYPE_COMBOBOX) item list), the
width of each element is not known when designing the form. When
`SIZEPOLICY` is `INITIAL`, the width is computed to display the element
correctly the first time it appears on the screen. Once it is displayed,
its width is frozen. This behavior is also very useful when using
Internationalization.

When `SIZEPOLICY` is `INITIAL`, the behavior differs depending on the
form element type:

- [Buttons](FormSpecFiles.html#FF_ITEMTYPE_BUTTON): The width defined in
  the form is a minimum width. If the text is bigger, the size grows. 
- [ComboBoxes](FormSpecFiles.html#FF_ITEMTYPE_COMBOBOX): The width
  defined in the form is a minimum width. If one of the items in the
  value list is bigger, the size grows in order for the combobox to
  display the largest item fully .
- [Labels](FormSpecFiles.html#FF_ITEMTYPE_LABEL),
  [Checkboxes](FormSpecFiles.html#FF_ITEMTYPE_CHECKBOX) and [Radio
  Groups](FormSpecFiles.html#FF_ITEMTYPE_RADIOGROUP): The width defined
  in the form is ignored. The fields are sized according to their text.
- [Images](FormSpecFiles.html#FF_ITEMTYPE_IMAGE) and
  [TextEdits](FormSpecFiles.html#FF_ITEMTYPE_TEXTEDIT) can use the
  [STRETCH](#FA_STRETCH) attribute, so that the size of the widget can
  be dependant from the parent container, overriding the
  [SIZEPOLICY]{style="color: #008000; font-family: Courier New"}
  attribute.
- Other items (mostly [Edits](FormSpecFiles.html#FF_ITEMTYPE_EDIT), or
  widget without items like
  [ProgressBar](FormSpecFiles.html#FF_ITEMTYPE_PROGRESSBAR)) are not
  sensitive to this attribute

The following table shows the effect of the `SIZEPOLICY` attribute
according to the type of form item; `INITIAL` corresponds to the first
content, while `DYNAMIC` corresponds to the content at anytime:

  ----------------------------------------------------------- --------------------- ---------------- ---------------------
  **Item Type**                                               `INITIAL`             `FIXED`          `DYNAMIC`
  [EDIT](FormSpecFiles.html#FF_ITEMTYPE_EDIT)                 fixed                 fixed            no effect
  [BUTTONEDIT](FormSpecFiles.html#FF_ITEMTYPE_BUTTONEDIT)     fixed                 fixed            no effect
  [TEXTEDIT](FormSpecFiles.html#FF_ITEMTYPE_TEXTEDIT)         fixed                 fixed            no effect
  [DATEEDIT](FormSpecFiles.html#FF_ITEMTYPE_DATEEDIT)         can shrink            fixed            no effect
  [COMBOBOX](FormSpecFiles.html#FF_ITEMTYPE_COMBOBOX)         can grow              fixed            can grow
  [BUTTON](FormSpecFiles.html#FF_ITEMTYPE_BUTTON)             can grow              fixed            can shrink and grow
  [LABEL](FormSpecFiles.html#FF_ITEMTYPE_LABEL)               can shrink and grow   fixed            can shrink and grow
  [RADIOGROUP](FormSpecFiles.html#FF_ITEMTYPE_RADIOGROUP)     can shrink and grow   fixed            can shrink and grow
  [CHECKBOX](FormSpecFiles.html#FF_ITEMTYPE_CHECKBOX)         can shrink and grow   fixed            can shrink and grow
  [IMAGE](FormSpecFiles.html#FF_ITEMTYPE_IMAGE)               can shrink and grow   fixed            can shrink and grow
  [PROGRESSBAR](FormSpecFiles.html#FF_ITEMTYPE_PROGRESSBAR)   fixed                 fixed            no effect
  [SLIDER](FormSpecFiles.html#FF_ITEMTYPE_SLIDER)             fixed                 fixed            no effect
  [SPINEDIT](FormSpecFiles.html#FF_ITEMTYPE_SPINEDIT)         fixed                 fixed            no effect
  [TIMEEDIT](FormSpecFiles.html#FF_ITEMTYPE_TIMEEDIT)         fixed                 fixed            no effect
  [CANVAS](FormSpecFiles.html#FF_ITEMTYPE_CANVAS)             Non applicable        Non applicable   Non applicable
  ----------------------------------------------------------- --------------------- ---------------- ---------------------

Note that the `SIZEPOLICY` attribute is ignored for the widgets used in
[TABLE](FormSpecFiles.html#FF_CONTAINER_TABLE) columns, because in
tables, the size policy is implicitly defined by the cell as fixed (i.e.
the size of the column in the form layout).

#### Example:

``` linenumber
01 COMBOBOX f001 = customer.city, ITEMS=((1,"Paris"),(2,"Madrid"),(3,"London")), SIZEPOLICY=DYNAMIC;
```

------------------------------------------------------------------------

### [SPACING Attribute]{#FA_SPACING}

#### Purpose:

The `SPACING` attribute is a spacing directive to display form elements.

#### Syntax:

`SPACING = `[`{`]{.underline}` NORMAL `[`|`]{.underline}` COMPACT `[`}`]{.underline}

#### Usage:

This attribute defines the global distance between two neighboring form
elements. In ` NORMAL` mode, the front end displays form elements
consistent with the desktop spacing, which is, for example, 6 and 10
pixels on Microsoft Windows platforms. Some overcrowded forms may need
to be displayed with less space between elements, to let them fit to the
screen. In this case you can use the `COMPACT` mode.

By default, forms are displayed with `COMPACT` spacing.

#### Example:

``` linenumber
01 LAYOUT ( SPACING=NORMAL )
```

------------------------------------------------------------------------

### [SPLITTER Attribute]{#FA_SPLITTER}

#### Purpose:

The `SPLITTER` attribute forces the container to use a splitter widget
between each child element.

#### Syntax:

`SPLITTER`

#### Usage:

This attribute indicates that the container (typically, a
[VBOX](FormSpecFiles.html#FF_CONTAINER_VBOX) or
[HBOX](FormSpecFiles.html#FF_CONTAINER_HBOX)) must have a splitter
between each child element held by the container. If a container is
defined with a splitter and if the children are stretchable (like
[TABLE](FormSpecFiles.html#FF_ITEMTYPE_TABLE) or
[TEXTEDIT](FormSpecFiles.html#FF_ITEMTYPE_TEXTEDIT)), users can resize
the child elements inside the container.

#### Example:

``` linenumber
01 VBOX ( SPLITTER )
```

------------------------------------------------------------------------

### [STYLE Attribute]{#FA_STYLE}

#### Purpose:

The `STYLE` attribute specifies a [presentation
style](PresentationStyles.html) for a form element.

#### Syntax:

`STYLE = "`*`string`*`" `

#### Notes:

1.  *string* is a user-defined style.

#### Usage:

This attribute specifies a presentation style to be applied to a form
element. The presentation style can define decoration attributes such as
a background color, a font type, and so on.

------------------------------------------------------------------------

### [TAG Attribute]{#FA_TAG}

#### Purpose:

The `TAG` attribute can be used to identify the form item with a
specific string.

#### Syntax:

`TAG = "`*`tag-string`*`" `

#### Notes:

1.  *tag-string* is free text.

#### Usage:

This attribute is used to identify form items with a specific string. It
can be queried in the program to perform specific processing.

You are free to use this attribute as you need. For example, you can
define a numeric identifier for each field in the form in order to show
context help, or group fields for specific input verification.

If you need to handle multiple data, you can format the text, for
example, by using a pipe separator.

#### Example:

``` linenumber
01 EDIT f001 = customer.fname, TAG = "name";
02 EDIT f002 = customer.lname, TAG = "name|optional";
```

------------------------------------------------------------------------

### [TABINDEX Attribute]{#FA_TABINDEX}

#### Purpose:

The `TABINDEX` attribute defines the tab order for a form item.

#### Syntax:

`TABINDEX = `*`integer`*` `

#### Notes:

1.  *integer* defines the order of the item in the tab sequence.
2.  If *integer* is zero, the item will be excluded from the tagging
    list. 

#### Usage:

This attribute can be used to define the order in which the form items
are selected as the user \"tabs\" from field to field when the program
is using the [form field order option](Programs.html#PROGRAM_OPTIONS).

It can also be used to define which field must get the focus when a
[folder page](FormSpecFiles.html#FF_CONTAINER_PAGE) is selected.

By default, form items get a tab index according to the order in which
they appear in the [LAYOUT](FormSpecFiles.html#SECTION_LAYOUT) section.

**Tip:** `TABINDEX` can be set to zero in order to exclude the item from
the tabbing list. The item can still get the focus with the mouse.

#### Example:

``` linenumber
01 EDIT f001 = customer.fname, TABINDEX = 1;
02 EDIT f002 = customer.lname, TABINDEX = 2;
03 EDIT f003 = customer.comment, TABINDEX = 0; -- Exclude from tabbing list
```

------------------------------------------------------------------------

### [VERIFY Attribute]{#FA_VERIFY}

#### Purpose:

The ` VERIFY` attribute requires users to enter data in the field twice
to reduce the probability of erroneous data entry.

#### Syntax:

`VERIFY`

#### Usage:

This attribute supplies an additional step in data entry to ensure the
integrity of your data. After the user enters a value into a ` VERIFY`
field and presses RETURN, the runtime system erases the field and
requests reentry of the value. The user must enter exactly the same data
each time, character for character: 15000 is not exactly the same as
15000.00.

Note that the ` VERIFY` attribute takes effect in
[INPUT](RecordInput.html) or [INPUT ARRAY](InputArray.html) instructions
only, it has no effect on [CONSTRUCT](Construct.html) statements.

------------------------------------------------------------------------

### [VERSION Attribute]{#FA_VERSION}

#### Purpose:

The `VERSION` attribute is used to specify a user version string for an
element.

#### Syntax:

`VERSION = { "`*`string`*`" | TIMESTAMP } `

#### Notes:

1.  *string* is a user-defined version string.

#### Warnings:

1.  Use the `TIMESTAMP` only during development.

#### Usage:

This attribute specifies a version string to distinguish different
versions of a form element. You can specify an explicit version string
or use the `TIMESTAMP` keyword to force the form compiler to write a
timestamp string into the **42f** file.

Typical usage is to specify a version of the form to indicate if the
form content has changed. This attribute is used by the front-end to
distinguish different form versions and to avoid reloading window/form
settings into a new version of a form.

#### Example:

``` linenumber
01 LAYOUT ( TEXT="Orders", VERSION = "1.23" )
```

------------------------------------------------------------------------

### [OPTIONS Attribute]{#FA_OPTIONS}

#### Purpose:

The `OPTION` attribute specifies widget options for the field.

#### Syntax:

`OPTIONS = "`*`option`*` `[`[...]`]{.underline}`"`

#### Notes:

1.  *option* can be one of: `-nolist` (to indicate that the column
    should appear as an independent field).

**Warning: This attributes is supported for backward compatibility with
Four Js BDS.**

------------------------------------------------------------------------

### [WANTTABS Attribute]{#FA_WANTTABS}

#### Purpose:

The `WANTTABS` attribute forces a text field to insert TAB characters in
the text when the user presses the TAB key.

#### Syntax:

`WANTTABS`

#### Usage:

By default, text fields  like
[TEXTEDIT](FormSpecFiles.html#FF_ITEMTYPE_TEXTEDIT) do not insert a TAB
character in the text when the user presses the TAB key, since the TAB
key is used to move to the next field. You can force the field to
consume TAB keys with this attribute.  

------------------------------------------------------------------------

### [WANTNORETURNS Attribute]{#FA_WANTNORETURNS}

#### Purpose:

The `WANTNORETURNS` attribute forces a text field to reject NewLine
characters when the user presses the RETURN key.

#### Syntax:

`WANTNORETURNS`

#### Usage:

By default, text fields like
[TEXTEDIT](FormSpecFiles.html#FF_ITEMTYPE_TEXTEDIT) insert a NewLine
(ASCII 10) character in the text when the user presses the RETURN key.
As the RETURN key is used to validate the dialog, you can force the
field to reject RETURN keys with this attribute.

------------------------------------------------------------------------

### [WANTFIXEDPAGESIZE Attribute]{#FA_WANTFIXEDPAGESIZE}

#### Purpose:

The `WANTFIXEDPAGESIZE` attribute gives a fixed height to a TABLE
container.

#### Syntax:

`WANTFIXEDPAGESIZE`

#### Usage:

By default, the height of a
[TABLE](FormSpecFiles.html#FF_CONTAINER_TABLE) container is resizable.
Use this attribute to freeze the number of rows to the number of screen
lines defined by the form file.

------------------------------------------------------------------------

### [WIDTH Attribute]{#FA_WIDTH}

#### Purpose:

The `WIDTH` attribute defines an explicit width of a form element.

#### Syntax:

`WIDTH = `*`integer`*` `[`[`]{.underline}`CHARACTERS`[`|`]{.underline}`COLUMNS`[`|`]{.underline}`POINTS`[`|`]{.underline}`PIXELS`[`]`]{.underline}

#### Notes:

1.  *integer* defines the width of the element.

#### Usage:

By default, the size of an element is defined in characters and
automatically computed by the form compiler according to the size of the
form element in the layout.

For items like images, the default width is defined by the number of
horizontal characters used in the [item
tag](FormSpecFiles.html#FF_ITEM_TAG). You can overwrite this default by
specifying the `WIDTH` attribute. You typically give a number of
pixels. 

For tables, the default width is defined by the columns used in the
table layout. You can overwrite this default by specifying the `WIDTH`
attribute. You typically give a number of columns. This allows you to
use tables with a large number of columns, but a small initial width.

If you don\'t specify any unit, the size unit defaults to `CHARACTERS`,
which defines the number of grid cells.

See also: [HEIGHT](#FA_HEIGHT).

#### Example:

``` linenumber
01 TABLE t1 ( WIDTH = 5 COLUMNS )
```

------------------------------------------------------------------------

### [WIDGET Attribute]{#FA_WIDGET}

#### Purpose:

The ` WIDGET` attribute specifies the type of graphical widget to be
used for the field.

#### Syntax:

`WIDGET = "`*`identifier`*`"`

#### Notes:

1.  *identifier* defines the type of widget, it can be one of the
    keywords listed in the table below.
2.  The ` WIDGET` attribute is used with [CONFIG](#FA_CONFIG) to
    parameter the field widget.

#### Warnings:

1.  This attribute is supported for backward compatibility with Four Js
    BDS.
    - Instead of `WIDGET="IMAGE"`, you should now use a [IMAGE form
      item](FormSpecFiles.html#FF_ITEMTYPE_IMAGE).
    - Instead of `WIDGET="CANVAS"`, you should now use a [CANVAS form
      item](FormSpecFiles.html#FF_ITEMTYPE_CANVAS).
    - Instead of `WIDGET="CHECK"`, you should now use a [CHECKBOX form
      item](FormSpecFiles.html#FF_ITEMTYPE_CHECKBOX).
    - Instead of `WIDGET="COMBO"`, you should now use a [COMBOBOX form
      item](FormSpecFiles.html#FF_ITEMTYPE_COMBOBOX).
    - Instead of `WIDGET="BMP"`, you should now use a [BUTTON form
      item](FormSpecFiles.html#FF_ITEMTYPE_BUTTON).
    - Instead of `WIDGET="FIELD_BMP"`, you should now use a [BUTTONEDIT
      form item](FormSpecFiles.html#FF_ITEMTYPE_BUTTONEDIT).
    - Instead of `WIDGET="RADIO"`, you should now use a [RADIOGROUP form
      item](FormSpecFiles.html#FF_ITEMTYPE_RADIOGROUP).
2.  The *identifier* widget type is case sensitive, only uppercase
    letters are recognized. 
3.  When you use the ` WIDGET` attribute, the form cannot be properly
    displayed on character based terminals, it should only be displayed
    on graphical front ends.

#### Supported widgets:

::: {align="center"}
+-----------------------+-----------------------------------------------+-----------------------------------------------------------------------+
| **Symbol   **         | **Effect**                                    | **Other attributes**                                                  |
+-----------------------+-----------------------------------------------+-----------------------------------------------------------------------+
| `Canvas`              | The field is used as a drawing area.\         | None.                                                                 |
|                       | Field must be declared as [FORMONLY           |                                                                       |
|                       | field](FormSpecFiles.html#FF_FORMONLY_FIELD). |                                                                       |
+-----------------------+-----------------------------------------------+-----------------------------------------------------------------------+
| `BUTTON`              | The field is presented as a button widget     | [CONFIG](#FA_CONFIG): The unique parameter defines the key to be sent |
|                       | with a label.                                 | when the user clicks on the button. Button text is defined in         |
|                       |                                               | configuration files or from the program with a [DISPLAY               |
|                       |                                               | TO](RecordInput.html) instruction.\                                   |
|                       |                                               | For example:\                                                         |
|                       |                                               | ` CONFIG = "Control-z"`                                               |
+-----------------------+-----------------------------------------------+-----------------------------------------------------------------------+
| `BMP`                 | The field is presented as a button with an    | [CONFIG](#FA_CONFIG): First parameter defines the image file to be    |
|                       | image.                                        | displayed, second parameter defines the key to be sent when the user  |
|                       |                                               | clicks on the button.\                                                |
|                       |                                               | For example:\                                                         |
|                       |                                               | ` CONFIG = "smiley.bmp F11"`\                                         |
|                       |                                               | **Important warning:** Image files are not centralized on the machine |
|                       |                                               | where the program is executed; image files must be present on the     |
|                       |                                               | Workstation. See front end specific documentation for more details.   |
+-----------------------+-----------------------------------------------+-----------------------------------------------------------------------+
| `CHECK`               | The field is presented as a checkbox widget.  | [CONFIG](#FA_CONFIG): First and second parameters define the values   |
|                       |                                               | corresponding respectively to the state \"Checked\" / \"Unchecked\"   |
|                       | It can be used with the [CLASS](#FA_CLASS)    | of the check box, while the third parameter defines the label of the  |
|                       | attribute to change the behavior of the       | checkbox.\                                                            |
|                       | widget.                                       | For example:\                                                         |
|                       |                                               | ` CONFIG = "Y N Confirmation"`\                                       |
|                       |                                               | If the text part must include spaces, add {} curly braces around the  |
|                       |                                               | text:\                                                                |
|                       |                                               | ` CONFIG = "Y N {Order validated}"`\                                  |
|                       |                                               | If the [CLASS](#FA_CLASS) attribute is used with the `"KEY"` value,   |
|                       |                                               | the first and second parameters defines the keys to be sent           |
|                       |                                               | respectively when the checkbox is \"Checked\" / \"Unchecked\", and    |
|                       |                                               | the third parameter defines the label of the checkbox as with normal  |
|                       |                                               | checkbox usage.\                                                      |
|                       |                                               | For example:\                                                         |
|                       |                                               | ` CLASS="KEY",CONFIG="F11 F12 Confirmation"`                          |
+-----------------------+-----------------------------------------------+-----------------------------------------------------------------------+
| `COMBO`               | The field is presented as a combobox widget.  | [INCLUDE](#FA_INCLUDE): This attribute defines the list of acceptable |
|                       |                                               | values that will be displayed in the combobox list.\                  |
|                       | It can be used with the [CLASS](#FA_CLASS)    | For example:\                                                         |
|                       | attribute to change the behavior of the       | ` INCLUDE = ("Paris", "London", "Madrid")`\                           |
|                       | widget.                                       | **Important warning:** The INCLUDE attribute cannot hold value range  |
|                       |                                               | definitions, because all items must be explicitly listed to be added  |
|                       |                                               | to the combobox list.\                                                |
|                       |                                               | The following example is not supported:\                              |
|                       |                                               | ` INCLUDE = ( 1 TO 10 )`                                              |
+-----------------------+-----------------------------------------------+-----------------------------------------------------------------------+
| `FIELD_BMP`           | The field is presented as a normal editbox,   | [CONFIG](#FA_CONFIG): The first parameter defines the image file to   |
|                       | plus a button on the right.                   | be displayed in the button; the second parameter defines the key to   |
|                       |                                               | be sent when the user clicks on the button.\                          |
|                       |                                               | For example:\                                                         |
|                       |                                               | ` CONFIG = "combo.bmp Control-z"`                                     |
+-----------------------+-----------------------------------------------+-----------------------------------------------------------------------+
| `LABEL`               | The field is presented as a simple label, a   | None.                                                                 |
|                       | read-only text.                               |                                                                       |
+-----------------------+-----------------------------------------------+-----------------------------------------------------------------------+
| `RADIO`               | The field is presented as a radiogroup        | [CONFIG](#FA_CONFIG): Parameter pairs define respectively the value   |
|                       | widget.                                       | and the label corresponding to one radio button.\                     |
|                       |                                               | For example:\                                                         |
|                       |                                               | ` CONFIG = "AA First BB Second CC Third"`\                            |
|                       |                                               | If the radio texts must include spaces, add {} curly braces around    |
|                       |                                               | the texts:\                                                           |
|                       |                                               | ` CONFIG = "AA {First option} BB {Second option} CC {Third option}"`\ |
|                       |                                               | If the [CLASS](#FA_CLASS) attribute is used with the value `"KEY"`,   |
|                       |                                               | the first element of each pairs represents the key to be sent when    |
|                       |                                               | the user selects a radio button.\                                     |
|                       |                                               | For example:\                                                         |
|                       |                                               | ` CLASS="KEY",`\                                                      |
|                       |                                               | ` CONFIG="F11 First F12 Second F13 Third"`                            |
+-----------------------+-----------------------------------------------+-----------------------------------------------------------------------+
:::

#### Controlling old style widgets activation:

The following list of widgets can be enabled or disabled from programs
with a [DISPLAY TO](RecordInput.html) instruction:

- Text buttons (`WIDGET="BUTTON"`) 
- Image buttons (`WIDGET="BMP"`)
- Checkboxes of class \"KEY\" (`WIDGET="CHECK", CLASS="KEY"`)
- Radio buttons of class \"KEY\" (`WIDGET="RADIO", CLASS="KEY"`)

If you display an exclamation mark in such fields, the button is
enabled, but if you display a star (\*), it is disabled:

``` linenumber
01 DISPLAY "*" TO button1 # disables the button
02 DISPLAY "!" TO button1 # enables the button
```

#### Changing the text of WIDGET=\"BMP\" fields:

The text of button fields (`WIDGET="BUTTON"`) can be changed from
programs with the [DISPLAY TO](RecordInput.html) instruction:

``` linenumber
01 DISPLAY "Click me" TO button1 # Sets text and enables the button
```

#### Changing the image of WIDGET=\"BMP\" fields:

The image of button fields (`WIDGET="BMP"`) can be changed from programs
with the [DISPLAY TO](RecordInput.html) instruction:

``` linenumber
01 DISPLAY "smiley.bmp" TO button1 # Sets image and enables the button
```

**Warning: Image files are not centralized on the machine where the
program is executed; image files must be present on the Workstation. See
front end specific documentation for more details. **

#### Changing the text of WIDGET=\"LABEL\" fields:

The text of label fields (`WIDGET="LABEL"`) can be changed from programs
with the [DISPLAY TO](RecordInput.html) instruction:

``` linenumber
01 DISPLAY "Firstname" TO l_firstname # Sets text of the label field
```

#### Using WIDGET=\"Canvas\" fields:

The fields declared with the `WIDGET="Canvas"` attribute can be used by
the program as drawing areas. Canvas fields must be defined in the
[LAYOUT](FormSpecFiles.html#SECTION_LAYOUT) section. A set of [drawing
functions](Canvas.html) are provided to fill Canvas fields with
graphical elements.

------------------------------------------------------------------------

### [WINDOWSTYLE Attribute]{#FA_WINDOWSTYLE}

#### Purpose:

The `WINDOWSTYLE` attribute defines the style to be used by the parent
window of a form.

#### Syntax:

`WINDOWSTYLE = "`*`string`*`"`

#### Notes:

1.  *string* is a user defined style.

#### Usage:

The `WINDOWSTYLE` attribute can be used to specify the style of the
parent window that will hold the form. This attribute is specific to the
[LAYOUT](FormSpecFiles.html#SECTION_LAYOUT) element. Do not confuse with
the `STYLE` attribute, which is used to specify decoration style of the
form elements.

When a form is loaded by the [OPEN
WINDOW](WindowsAndForms.html#OPEN_WINDOW) or [DISPLAY
FORM](WindowsAndForms.html#DISPLAY_FORM) instructions, the runtime
system automatically assigns the `WINDOWSTYLE` to the \'style\'
attribute of the parent window element.

See also: [STYLE](#FA_STYLE), [Windows and Forms](WindowsAndForms.html).

#### Example:

``` linenumber
01 LAYOUT ( STYLE="BigFont", WINDOWSTYLE="dialog" )
```

------------------------------------------------------------------------

### [WORDWRAP Attribute]{#FA_WORDWRAP}

#### Purpose:

The ` WORDWRAP` attribute enables a multiple-line editor in
[TUI](FglTerms.html#TEXT_USER_INTERFACE) mode.

#### Syntax:

`WORDWRAP `[`[`]{.underline}` `[`{`]{.underline}` COMPRESS `[`|`]{.underline}` NONCOMPRESS `[`}`]{.underline}` `[`]`]{.underline}

#### Usage:

[In]{.underline} [TUI](FglTerms.html#TEXT_USER_INTERFACE)
[mode:]{.underline}

- During input and display, the runtime system treats all segments that
  have that field tag as segments of a single field.
- The multi-line editor can *wrap* long character strings to the next
  line of a multiple-segment field for data entry, data editing, and
  data display.
- The ` COMPRESS` option prevents blanks produced by the editor from
  being included in the program variable. ` COMPRESS` is applied by
  default and can cause truncation to occur if the sum of intentional
  characters exceeds the field or column size. Because of editing blanks
  in the ` WORDWRAP` field, the stored value might not correspond
  exactly to its multiple-line display.
- Specifying ` NONCOMPRESS` after the ` WORDWRAP` keyword causes any
  editor blanks to be saved when the string value is saved in a database
  column, in a variable, or in a file.

[In]{.underline} [GUI](FglTerms.html#GRAPHICAL_USER_INTERFACE)
[mode:]{.underline}

- The `WORDWRAP` attribute is ignored, because text input and display is
  managed by the text editor widget.
- The text data is NOT automatically modified by the editor by adding
  blanks to put words on the next line.

#### Warnings:

1.  This attribute is provided for backward compatibility with
    character-based forms; you should use a
    [TEXTEDIT](FormSpecFiles.html#SECTION_ATTRIBUTES) form item instead
    in graphical forms.
2.  Using ` WORDWRAP` fields with character-based terminals results in
    quite different behavior than with graphical front ends. With
    character-based terminals, the text input and display is modified by
    the multi-line editor. This editor can automatically modify the text
    data by adding blanks to put words to the next line, in order to
    make the text fit into the form field. In
    [GUI](FglTerms.html#GRAPHICAL_USER_INTERFACE) mode, the text input
    and display is managed by a multi-line edit control.

The maximum number of bytes a user can enter is the width of the
form-field multiplied by the height of the form-field. Blank characters
may be intentional blanks or fill blanks. Intentional blanks are
initially stored in the target variable where entered by the user. Fill
blanks are inserted at the end of a line by the editor when a new-line
or a  word-alignment forces a line-break. It is not possible to set the
cursor at a fill blank. Intentional blanks are always displayed (even on
the beginning of a line; the word-wrapping method used in reports with
PRINT WORDWRAP works differently).

When entering characters with Japanese locales, special characters are
prohibited from being the first or the last character on a line. If the
last character is prohibited from ending a line, this character is
wrapped down to the next line. If the first character is prohibited from
beginning a line, the preceding character will also wrap down to the
next line. This method is called kinsoku. The test for prohibited
characters will be done only once for the first and the last character
on each line.

Word-wrapping is disabled on the last row of a WORDWRAP field. The last
word on the last row may by truncated. The WORDWRAP COMPRESS attribute
instructs the editor to remove fill blanks before assigning the
field-buffer to the target variable. The WORDWRAP NONCOMPRESS attribute
instructs the editor to store fill blanks to the target variable. The
WORDWRAP and WORDWRAP NONCOMPRESS attributes are equivalent.

------------------------------------------------------------------------

### [EXPANDEDCOLUMN  Attribute]{#FA_EXPANDEDCOLUMN}

#### Purpose:

The ` EXPANDEDCOLUMN` attribute specifies the form field that indicates
whether a tree node is expanded. This attribute is optional.

#### Syntax:

    EXPANDEDCOLUMN=column-name

#### Notes:

1.  *column-name* is the name of the form field holding the flag
    indicating whether a tree node is expanded (opened.)

#### Usage:

**Warning: You must specify form field column names, not item tag
identifiers.**

This attribute is used in the definition of a [TREE
container](FormSpecFiles.html#FF_CONTAINER_TREE), see the [Tree Views
page](TreeViews.html) for more details.

------------------------------------------------------------------------

### [IDCOLUMN]{#FA_IDCOLUMN} Attribute

#### Purpose:

The ` IDCOLUMN` attribute specifies the form field that contains the
identifier of a tree node.  This attribute is mandatory.

#### Syntax:

    IDCOLUMN=column-name

#### Notes:

1.  *column-name* is the name of the form field containing the
    identifler of a node in a tree view.

#### Usage:

**Warning: You must specify form field column names, not item tag
identifiers.**

This attribute is used in the definition of a [TREE
container](FormSpecFiles.html#FF_CONTAINER_TREE), see the [Tree Views
page](TreeViews.html) for more details.

------------------------------------------------------------------------

### [IMAGECOLUMN]{#FA_IMAGECOLUMN} Attribute

#### Purpose:

The ` IMAGECOLUMN` attribute defines the form field containing the image
of a field.

#### Syntax:

    IMAGECOLUMN=column-name

#### Notes:

1.  *column-name* is the name of the form field that contains the image
    that Genero is instructed to set for a tree node.

#### Usage:

**Warning: You must specify form field column names, not item tag
identifiers.**

This attribute is used in the definition of a [TREE
container](FormSpecFiles.html#FF_CONTAINER_TREE), see the [Tree Views
page](TreeViews.html) for more details.

The images defined by the [IMAGECOLLAPSED](#FA_IMAGECOLLAPSED),
[IMAGEEXPANDED](#FA_IMAGEEXPANDED) and [IMAGELEAF](#FA_IMAGELEAF)
attributes take precedence over the images defined by the `IMAGECOLUMN`
cell.

------------------------------------------------------------------------

### [IMAGECOLLAPSED]{#FA_IMAGECOLLAPSED} Attribute

#### Purpose:

The ` IMAGECOLLAPSED` attribute sets the global icon to be used when a
tree node is collapsed. This attribute is optional.

#### Syntax:

    IMAGECOLLAPSED="image-name"

#### Notes:

1.  *image-name* is the name of the icon that Genero is instructed to
    set when a tree node is collapsed (closed).

#### Usage:

This attribute defines the icon to be used for nodes that are collapsed.
It overwrites the program array image defined by
[IMAGECOLUMN](#FA_IMAGECOLUMN), if both are used.

This attribute is used in the definition of a [TREE
container](FormSpecFiles.html#FF_CONTAINER_TREE), see the [Tree Views
page](TreeViews.html) for more details.

------------------------------------------------------------------------

### [IMAGEEXPANDED]{#FA_IMAGEEXPANDED} Attribute

#### Purpose:

The ` IMAGEEXPANDED` attribute sets the global icon to be used when a
tree node is expanded. This attribute is optional.

#### Syntax:

    IMAGEEXPANDED="image-name"

#### Notes:

1.  *image-name* is the name of the icon that Genero is instructed to
    set when a tree node is expanded (opened).

#### Usage:

This attribute defines the icon to be used for nodes that are expanded.
It overwrites the program array image defined by
[IMAGECOLUMN](#FA_IMAGECOLUMN), if both are used.

This attribute is used in the definition of a [TREE
container](FormSpecFiles.html#FF_CONTAINER_TREE), see the [Tree Views
page](TreeViews.html) for more details.

------------------------------------------------------------------------

### [IMAGELEAF]{#FA_IMAGELEAF} Attribute

#### Purpose:

The ` IMAGELEAF` attribute defines the global icon for leaf nodes of a
TREE container. This attribute is optional.

#### Syntax:

    IMAGELEAF="image-name"

#### Notes:

1.  *image-name* is the name of the icon that Genero is instructed to
    set for leaf nodes.

#### Usage:

This attribute defines the icon to be used for all leaf nodes of the
tree. It overwrites the program array image defined by
[IMAGECOLUMN](#FA_IMAGECOLUMN), if both are used.

This attribute is used in the definition of a [TREE
container](FormSpecFiles.html#FF_CONTAINER_TREE), see the [Tree Views
page](TreeViews.html) for more details.

------------------------------------------------------------------------

### [ISNODECOLUMN]{#FA_ISNODECOLUMN} Attribute

#### Purpose:

The ` ISNODECOLUMN` attribute specifies the form field that indicates
whether a tree node has children. This attribute is optional.

#### Syntax:

    ISNODECOLUMN=column-name

#### Notes:

1.  *column-name* is the name of the form field indicating whether a
    tree node has children.

#### Usage:

Even if the program node does not contain child nodes for this tree
node, this attribute may be used, to implement dynamic filling of tree
views.

**Warning: You must specify form field column names, not item tag
identifiers.**

This attribute is used in the definition of a [TREE
container](FormSpecFiles.html#FF_CONTAINER_TREE), see the [Tree Views
page](TreeViews.html) for more details.

------------------------------------------------------------------------

### [PARENTIDCOLUMN]{#FA_PARENTIDCOLUMN}  Attribute

#### Purpose:

The ` PARENTIDCOLUMN` attribute specifies the form field that contains
the identifier of the parent node of a tree node.  This attribute is
mandatory.

#### Syntax:

    PARENTIDCOLUMN=column-name

#### Notes:

1.  *column-name* is the name of the form field containing the
    identifler of the tree node that is the parent of the current node
    in a tree view.

#### Usage:

**Warning: You must specify form field column names, not item tag
identifiers.**

This attribute is used in the definition of a [TREE
container](FormSpecFiles.html#FF_CONTAINER_TREE), see the [Tree Views
page](TreeViews.html) for more details.
