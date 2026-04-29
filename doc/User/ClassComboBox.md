[Back to Contents](../index.html)

------------------------------------------------------------------------

# [The ComboBox class]{#PAGE_HEADER}

Summary:

- [Syntax](#SYNTAX)
- [Methods](#METHODS)
- [Usage](#USAGE)
  - [Defining the default initializer for
    ComboBoxes](#setDefaultInitializer)
  - [Searching for a ComboBox in the current form](#forName)
  - [Clearing the item list of a ComboBox](#clear)
  - [Adding an element to the ComboBox item list](#addItem)
  - [Getting the name of the form field table prefix](#getTableName)
  - [Getting the name of the form field](#getColumnName)
  - [Getting the ComboBox tag value](#getTag)
  - [Getting the number of items in a ComboBox](#getItemCount)
  - [Getting an item name by position](#getItemName)
  - [Getting an item position by name](#getIndexOf)
  - [Getting an item text by position](#getItemText)
  - [Getting an item text by item name](#getTextOf)
  - [Removing an item from the ComboBox](#removeItem)
- [Examples](#EXAMPLES)

*See also:* [Built-in Classes](BuiltInClasses.html), [Form Specification
File](FormSpecFiles.html)

------------------------------------------------------------------------

### [Syntax]{#SYNTAX}

The **ComboBox** class provides an interface to the
[COMBOBOX](FormSpecFiles.html#FF_ITEMTYPE_COMBOBOX) form field view in
the [Abstract User Interface tree](DynamicUI.html).

#### Syntax:

`ui.ComboBox`

------------------------------------------------------------------------

### [Methods:]{#METHODS}

+----------------------------------------------------------------------------+--------------------------------------------------+
| **Class Methods**                                                                                                             |
+----------------------------------------------------------------------------+--------------------------------------------------+
| **Name**                                                                   | **Description**                                  |
+----------------------------------------------------------------------------+--------------------------------------------------+
| [`forName`](#forName)`( fieldname ``STRING`` )`\                           | Returns the combobox object identified by        |
| `  ``RETURNING`` ui.ComboBox`                                              | *fieldname* in the [current                      |
|                                                                            | form](WindowsAndForms.html).                     |
+----------------------------------------------------------------------------+--------------------------------------------------+
| [`setDefaultInitializer`](#setDefaultInitializer)`( funcname ``STRING`` )` | Defines the default initialization function for  |
|                                                                            | all COMBOBOX form fields. See also the           |
|                                                                            | [INITIALIZER](FSFAttributes.html#FA_INITIALIZER) |
|                                                                            | attribute in form specification files.           |
+----------------------------------------------------------------------------+--------------------------------------------------+
| **Object Methods**                                                                                                            |
+----------------------------------------------------------------------------+--------------------------------------------------+
| **Name**                                                                   | **Description**                                  |
+----------------------------------------------------------------------------+--------------------------------------------------+
| [`clear`](#clear)`( )`                                                     | Clears the list of combobox items.               |
+----------------------------------------------------------------------------+--------------------------------------------------+
| [`addItem`](#addItem)`( name ``STRING``, text ``STRING`` )`                | Adds an item to the combobox item list.          |
+----------------------------------------------------------------------------+--------------------------------------------------+
| [`getColumnName`](#getColumnName)`()`\                                     | Returns the name of the column name of the form  |
| `  ``RETURNING STRING`                                                     | field associated with this combobox.             |
+----------------------------------------------------------------------------+--------------------------------------------------+
| [`getIndexOf`](#getIndexOf)`( name ``STRING ``)`\                          | Returns the position of a given item by name.    |
| `  ``RETURNING INTEGER`                                                    |                                                  |
+----------------------------------------------------------------------------+--------------------------------------------------+
| [`getItemCount`](#getItemCount)`()`\                                       | Returns the current number of items defined in   |
| `  ``RETURNING INTEGER`                                                    | the combobox .                                   |
+----------------------------------------------------------------------------+--------------------------------------------------+
| [`getItemName`](#getItemName)`( index ``INTEGER ``)`\                      | Returns the name of an item at a given position. |
| `  ``RETURNING STRING`                                                     | First is 1.                                      |
+----------------------------------------------------------------------------+--------------------------------------------------+
| [`getItemText`](#getItemText)`( index ``INTEGER ``)`\                      | Returns the text of an item at a given position. |
| `  ``RETURNING STRING`                                                     | First is 1.                                      |
+----------------------------------------------------------------------------+--------------------------------------------------+
| [`getTableName`](#getTableName)`()`\                                       | Returns the name of the table, alias or FORMONLY |
| `  ``RETURNING STRING`                                                     | of the form field associated to this combobox.   |
+----------------------------------------------------------------------------+--------------------------------------------------+
| [`getTag`](#getTag)`()`\                                                   | Returns the user-defined tag of this object.     |
| `  ``RETURNING STRING`                                                     |                                                  |
+----------------------------------------------------------------------------+--------------------------------------------------+
| [`getTextOf`](#getTextOf)`( name ``STRING ``)`\                            | Returns the text for a given item name.          |
| `  ``RETURNING STRING`                                                     |                                                  |
+----------------------------------------------------------------------------+--------------------------------------------------+
| [`removeItem`](#removeItem)`( name ``STRING`` )`                           | Removes the item identified by *name*.           |
+----------------------------------------------------------------------------+--------------------------------------------------+

------------------------------------------------------------------------

### [Usage:]{#USAGE}

When you declare a [COMBOBOX](FormSpecFiles.html#FF_ITEMTYPE_COMBOBOX)
form field in the [form specification file](FormSpecFiles.html), you
declare both a form field and a view for that model. The ComboBox class
is an interface to the view of a COMBOBOX form field.

#### [Defining the default initializer for ComboBoxes]{#setDefaultInitializer}

Use the `ui.ComboBox.setDefaultInitializer()` class method to define the
default initialization function that will be called each time a ComboBox
object is created. That function is called with the ComboBox object as
the parameter:

``` linenumber
01 CALL ui.ComboBox.setDefaultInitializer("initcombobox")
02 
03 FUNCTION initcombobox(cb)
04   DEFINE cb ui.ComboBox
05   CALL cb.clear()
06   CALL cb.addItem(1,"Paris")
07   CALL cb.addItem(2,"London")
08   CALL cb.addItem(3,"Madrid")
09 END FUNCTION 
```

**Warning: You must give the initialization function name in lower-case
letters to the `setDefaultInitializer()` method. The BDL syntax allows
case-insensitive function names, but the runtime system must reference
functions in lower-case letters internally. **

You can also define a specific initialization function in the form
specification file, by using the
[INITIALIZER](FSFAttributes.html#FA_INITIALIZER) attribute (as shown in
the second example below).

#### [Searching for a ComboBox in the current form]{#forName}

The `ui.ComboBox.forName()` class method searches for a COMBOBOX object
by form field name in the [current form](WindowsAndForms.html).
Typically, after loading a form with [OPEN WINDOW WITH
FORM](WindowsAndForms.html#OPEN_WINDOW), you use the class method to
retrieve a COMBOBOX view object into a variable defined as a
`ui.ComboBox`:

``` linenumber
01 DEFINE cb ui.ComboBox
02 LET cb = ui.ComboBox.forName("formonly.airport")
```

It is recommended that you verify if that function has returned an
object, because the form field may not exist:

``` linenumber
01 IF cb IS NULL THEN
02   ERROR "Form field not found in current form"
03   EXIT PROGRAM
04 END IF
```

Once instantiated, the ComboBox object can be used; for example, to set
up the items of the drop down list:

``` linenumber
01 CALL cb.clear()
02 CALL cb.addItem(1,"Paris")
03 CALL cb.addItem(2,"London")
04 CALL cb.addItem(3,"Madrid")
```

#### [Clearing the item list of a ComboBox]{#clear}

The `clear()` method clears the item list. If the item list is empty,
the ComboBox drop-down button will show an empty list on the client
side.

#### [Adding an element to the ComboBox item list]{#addItem}

The `addItem()` method adds an item to the end of the list. It takes two
parameters: the first is the real form field value, and the second is
the value to be displayed in the drop down list. If the second parameter
is [NULL](Programs.html#PC_NULL), the runtime system automatically uses
the first parameter as the display value.

**Warning: Trailing spaces should be avoided when populating the first
parameter because values get truncated when field validation occurs, and
the resulting value (without trailing spaces) will no longer match the
ComboBox item name. Additionally, trailing spaces in the second
parameter may cause the ComboBox to be much wider than expected. In
order to avoid such problems, use VARCHAR or STRING variables, or use
the CLIPPED operator with CHAR variables.**

#### [Getting the name of the form field table prefix]{#getTableName}

The `getTableName()` method returns the name of the form field table
prefix. Not that this prefix can be NULL if not defined at the form
field level.

#### [Getting the name of the form field]{#getColumnName}

The `getColumnName()` method returns the name of the form field table
prefix. Not that this prefix can be NULL if not defined at the form
field level.

You can use the `getTableName()` and `getColumnName()` methods to get
the table and column name of the form field associated with the
ComboBox:

``` linenumber
01 DISPLAY cb.getTableName()||"."||cb.getColumnName()
```

#### [Getting the ComboBox tag value]{#getTag}

The `getTag()` method returns the value of the
[TAG](FSFAttributes.html#FA_TAG) attribute if defined in the form file.

#### [Getting an item position by name]{#getIndexOf}

The `getIndexOf()` method takes an item name as parameter and returns
the position of the item in the list. Returns 0 if the item name does
not exist.

With this method you can check if an item exists:

``` linenumber
01 IF cb.getIndexOf("SFO") == 0 THEN
02   CALL cb.addItem("SFO", "San Francisco International Airport, CA" )
03 END IF
```

#### [Getting the number of items in a ComboBox]{#getItemCount}

You can get the current number of items defined in a ComboBox with the
`getItemCount()` method. If no items are defined, the method returns
zero.

#### [Getting an item name by position]{#getItemName}

The `getItemName()` method takes an item position as parameter and
returns the identifier of that item. First item starts at position 1.

#### [Getting an item text by position]{#getItemText}

The `getItemText()` method takes an item position as parameter and
returns the value of that item. First item starts at position 1.

#### [Getting an item text by name]{#getTextOf}

The `getTextOf()` method takes an item name as parameter and returns the
value of that item. Returns NULL if the item name does not exist.

#### [Removing an item by name]{#removeItem}

Use the `removeItem()` method to delete an item from the ComboBox. Item
name must be passed as parameter. 

------------------------------------------------------------------------

### [Examples]{#EXAMPLES}

#### Example 1: Get a COMBOBOX form field view and fill the item list:

Form Specification File:

``` linenumber
01 DATABASE FORMONLY
02 LAYOUT
03 GRID
04 {
05   Airport:  [cb01                 ]
06 }
07 END
08 END
09 ATTRIBUTES
10 COMBOBOX cb01 = FORMONLY.airport TYPE CHAR;
11 END
```

Program File:

``` linenumber
01 MAIN
02   DEFINE cb ui.ComboBox
03   DEFINE airport CHAR(3)
04
05   OPEN FORM f1 FROM "combobox"
06   DISPLAY FORM f1
07   LET cb = ui.ComboBox.forName("formonly.airport")
08   IF cb IS NULL THEN
09      ERROR "Form field not found in current form"
10      EXIT PROGRAM
11   END IF
12   CALL cb.clear()
13   CALL cb.addItem("CDG", "Paris-Charles de Gaulle, France")
14   CALL cb.addItem("LCY", "London-City Airport, UK")
15   CALL cb.addItem("LHR", "London-Heathrow, UK")
16   CALL cb.addItem("FRA", "Frankfurt Airport, Germany")
17   IF cb.getIndexOf("SFO") == 0 THEN
18      CALL cb.addItem("SFO", "San Francisco International Airport, CA" )
19   END IF
20
21   INPUT BY NAME airport
22
23 END MAIN
```

#### Example 2: Using the INITIALIZER attribute in the form file:

Form Specification File:

``` linenumber
01 DATABASE FORMONLY
02 LAYOUT
03 GRID
04 {
05   Airport:  [cb01                 ]
06 }
07 END
08 END
09 ATTRIBUTES
10 COMBOBOX cb01 = FORMONLY.airport TYPE CHAR, INITIALIZER=initcombobox;
11 END
```

Initialization function:

``` linenumber
01 FUNCTION initcombobox(cb)
02   DEFINE cb ui.ComboBox
03   CALL cb.clear()
04   CALL cb.addItem("CDG", "Paris-Charles de Gaulle, France")
05   CALL cb.addItem("LCY", "London-City Airport, UK")
06   CALL cb.addItem("LHR", "London-Heathrow, UK")
07   CALL cb.addItem("FRA", "Frankfurt Airport, Germany")
08   CALL cb.addItem("SFO", "San Francisco International Airport, CA" )
09 END FUNCTION
```
