[Back to Contents](../index.html)

------------------------------------------------------------------------

# [The SaxAttributes class]{#PAGE_HEADER}

Summary:

- [Syntax](#SYNTAX)
- [Methods](#METHODS)
- [Usage](#USAGE)
  - [Creating a SaxAttributes object](#Creating)
  - [Returning the value of an Attribute](#Returning_the_value)
  - [Returning the number of Attributes](#getLength)
  - [Returning the name of an Attribute](#getName)
  - [Adding Attributes](#addAttribute)
  - [Removing Attributes](#Removing_attributes)
  - [Replacing the Attributes list](#setAttributes)
- [Examples](#EXAMPLES)

*See also:* [Built-in Classes](BuiltInClasses.html), [XML
Utilities](XmlUtils.html)

------------------------------------------------------------------------

### [Syntax]{#SYNTAX}

The **SaxAttributes** class provides methods to manipulate
[XML](XmlUtils.html) element attributes for a SAX driver.

#### Syntax:

`om.SaxAttributes`

------------------------------------------------------------------------

### [Methods:]{#METHODS}

+-----------------------------------------------------------------+-------------------------------------+
| **Class Methods**                                                                                     |
+-----------------------------------------------------------------+-------------------------------------+
| **Name**                                                        | **Description**                     |
+-----------------------------------------------------------------+-------------------------------------+
| [`copy`](#copy)`( src SaxAttributes )`\                         | Clones an existing SaxAttributes    |
| `  ``RETURNING`` om.SaxAttributes`                              | object.                             |
+-----------------------------------------------------------------+-------------------------------------+
| [`create`](#create)`( )`\                                       | Creates a new, empty SaxAttributes  |
| `  ``RETURNING`` om.SaxAttributes`                              | object.                             |
+-----------------------------------------------------------------+-------------------------------------+
| **Object Methods**                                                                                    |
+-----------------------------------------------------------------+-------------------------------------+
| **Name**                                                        | **Description**                     |
+-----------------------------------------------------------------+-------------------------------------+
| [`addAttribute`](#addAttribute)`( n ``STRING``, v ``STRING`` )` | Adds an attribute to the end of the |
|                                                                 | list.                               |
+-----------------------------------------------------------------+-------------------------------------+
| [`clear`](#clear)`( )`                                          | Clears the attribute list.          |
+-----------------------------------------------------------------+-------------------------------------+
| [`getLength(`](#getLength)` )`\                                 | Returns the number of attributes in |
| `  ``RETURNING INTEGER`                                         | the list.                           |
+-----------------------------------------------------------------+-------------------------------------+
| [`getName`](#getName)`( pos ``INTEGER`` )`\                     | Returns the name of the attribute   |
| `  ``RETURNING STRING`                                          | at position *pos*.                  |
+-----------------------------------------------------------------+-------------------------------------+
| [`getValue(`](#getValue)` att ``STRING`` )`\                    | Returns the value of the attribute  |
| `  ``RETURNING STRING`                                          | identified by the name *att*.       |
+-----------------------------------------------------------------+-------------------------------------+
| [`getValuebyIndex`](#getValueByIndex)`( pos ``INTEGER`` )`\     | Returns the value of the attribute  |
| `  ``RETURNING STRING`                                          | at position *pos*.                  |
+-----------------------------------------------------------------+-------------------------------------+
| [`removeAttribute`](#removeAttribute)`( pos ``INTEGER`` )`\     | Removes the attribute at position   |
| `  ``RETURNING INTEGER`                                         | *pos*.                              |
+-----------------------------------------------------------------+-------------------------------------+
| [`setAttributes`](#setAttributes)`( atts om.SaxAttributes )`    | Clears the current attribute list   |
|                                                                 | and adds all attributes of *atts*.  |
+-----------------------------------------------------------------+-------------------------------------+

------------------------------------------------------------------------

### [Usage:]{#USAGE}

This class provides basic methods to manipulate attributes when
processing a SAX filter. The SaxAttributes object is a list containing
the attributes of the element.

#### [Creating a SaxAttributes object]{#Creating}

To process element attributes, a SaxAttributes object can be used in
cooperation with an [XmlReader](ClassXmlReader.html) object. You get an
instance of SaxAttributes with the `getAttributes()` method. 

The following SaxAttributes Class methods are also provided:

The [`om.SaxAttributes.create()`]{#create} ` `method creates a new,
empty SaxAttributes object. 

The [`om.SaxAttributes.copy()`]{#copy} ` `method clones an existing
SaxAttributes object. 

#### [Returning the value of an attribute]{#Returning_the_value}

The [`getValue()`]{#getValue} method returns the value of the attribute
specified by name.

The [`getValueByIndex()`]{#getValueByIndex} method returns the value of
the attribute at the specified position. 

#### [Returning the number of attributes]{#getLength}

The `getLength()` method returns the number of attributes in the list.

#### [Returning the name of an attribute]{#getName}

The `getName()` method returns the name of the attribute at the
specified position in the list.

#### [Adding attributes]{#addAttribute}

The `addAttribute()` method adds a new attribute to the end of the
attributes list. 

#### [Removing attributes]{#Removing_attributes}

The [`clear()`]{#clear} method clears the attributes list.

The [`removeAttribute()`]{#removeAttribute} method removes the
attributes at the given position in the list.

#### [Replacing the attributes list]{#setAttributes}

The `setAttributes()` method clears the current list and adds all the
attributes of the specified SaxAttributes object.

------------------------------------------------------------------------

### [Examples]{#EXAMPLES}

#### Example 1:

``` linenumber
01 FUNCTION displayAttributes( a )
02    DEFINE a om.SaxAttributes
03    DEFINE i INTEGER
04    FOR i=1 to a.getLength()
05       DISPLAY a.getName(i) || "=[" || a.getValueByIndex(i) || "]"
06    END FOR
07 END FUNCTION
```
