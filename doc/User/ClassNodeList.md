[Back to Contents](../index.html)

------------------------------------------------------------------------

# [The NodeList class]{#PAGE_HEADER}

Summary:

- [Syntax](#SYNTAX)
- [Methods](#METHODS)
- [Usage](#Usage)
- [Examples](#EXAMPLES)

*See also:* [Built-in Classes](BuiltInClasses.html), [XML
Utilities](XmlUtils.html)

------------------------------------------------------------------------

### [Syntax]{#SYNTAX}

The **NodeList** class holds a list of [DomNode](ClassDomNode.html)
objects created from a selection method.

#### Syntax:

`om.NodeList`

#### Notes:

1.  A *NodeList* object is created from a
    [DomNode.selectByTagName()](ClassDomNode.html) or
    [DomNode.selectByPath()](ClassDomNode.html) method.

------------------------------------------------------------------------

### [Methods:]{#METHODS}

+-----------------------------------------+-------------------------------------+
| **Object Methods**                                                            |
+-----------------------------------------+-------------------------------------+
| **Name**                                | **Description**                     |
+-----------------------------------------+-------------------------------------+
| [`item`](#item)`( index ``INTEGER`` )`\ | Returns the DomNode object at the   |
| `  ``RETURNING`` om.DomNode`            | given position (first is 1).        |
|                                         | Returns NULL if the item does not   |
|                                         | exist.                              |
+-----------------------------------------+-------------------------------------+
| [`getLength`](#getLength)`( )`\         | Returns the number of items in the  |
| `  ``RETURNING INTEGER`                 | list.                               |
+-----------------------------------------+-------------------------------------+

------------------------------------------------------------------------

### [Usage]{#Usage}

A NodeList object contains a list of the child objects of the DomNode
from which it was created, selected by Tag Name or Path.  Use the
DomNode methods to create the NodeList, as shown in the examples below.

**Warning: The XPath syntax of the
[`selectByTagName`]{#selectByTagName}`()` and
[`selectByPath`]{#selectByPath}`()` methods of
[om.DomNode](ClassDomNode.html) class is limited to:**

`     `[`{`]{.underline}` / `[`|`]{.underline}` // `[`}`]{.underline}` `*`TagName`*` `[`[`]{.underline}` [@`*`AttributeName`*`="`*`Value`*`"] `[`]`]{.underline}` `[`[...]`]{.underline}

Once the NodeList object is created, the following Object methods are
available:

[`item()`]{#item} - This method returns the DomNode that is at the
specified position in the list.

[`getLength()`]{#getLength} - This method returns the total number of
DomNodes in the list.

### [Examples]{#EXAMPLES}

#### Example 1: Search for child nodes by tag name:

``` linenumber
01 MAIN
02   DEFINE nl om.NodeList
03   DEFINE r, n om.DomNode
04   DEFINE i INTEGER
05
06   LET r = ui.Interface.getRootNode()
07   LET nl = r.selectByTagName("Form")
08
09   FOR i=1 to nl.getLength()
10     LET n = nl.item(i)
11     DISPLAY n.getAttribute("name")
12   END FOR
13
14 END MAIN
```

#### Example 2: Search for child nodes by XPath:

``` linenumber
01 MAIN
02   DEFINE nl om.NodeList
03   DEFINE r, n om.DomNode
04   DEFINE i INTEGER
05
06   LET r = ui.Interface.getRootNode()
07   LET nl = r.selectByPath("//Window[@name=\"screen\"]")
08
09   FOR i=1 to nl.getLength()
10     LET n = nl.item(i)
11     DISPLAY n.getAttribute("name")
12   END FOR
13
14 END MAIN
```
