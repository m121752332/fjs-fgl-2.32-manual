[Back to Contents](../index.html)

------------------------------------------------------------------------

# [The DomDocument class]{#PAGE_HEADER}

Summary:

- [Syntax](#SYNTAX)
- [Methods](#METHODS)
- [Usage](#USAGE)
  - [Create a new DomDocument object](#Create_a_DomDocument)
  - [Create a new DomNode object](#Create_a_DomNode)
  - [Return the root node of the DomDocument](#getDocumentElement)
  - [Return a specific node of the DomDocument](#getElementbyID)
  - [Remove a DomNode object](#removeElement)
- [Examples](#EXAMPLES)

*See also:* [Built-in Classes](BuiltInClasses.html), [XML
Utilities](XmlUtils.html)

------------------------------------------------------------------------

### [Syntax]{#SYNTAX}

#### Purpose:

The **DomDocument** class provides methods to manipulate a data tree,
following the [DOM](XmlUtils.html) standards.

#### Syntax:

`om.DomDocument`

------------------------------------------------------------------------

### [Methods:]{#METHODS}

+-----------------------------------------------------------------+-------------------------------------+
| **Class Methods**                                                                                     |
+-----------------------------------------------------------------+-------------------------------------+
| **Name**                                                        | **Description**                     |
+-----------------------------------------------------------------+-------------------------------------+
| [`create`](#create)`( tag ``STRING`` )`\                        | Creates a new, empty DomDocument    |
| `  ``RETURNING`` om.DomDocument`                                | object, where *tag* identifies the  |
|                                                                 | tag name of the root element.       |
+-----------------------------------------------------------------+-------------------------------------+
| [`createFromXmlFile`](#createFromXmlFile)`( file ``STRING`` )`\ | Creates a new DomDocument object    |
| `  ``RETURNING`` om.DomDocument`                                | using an XML file specified by the  |
|                                                                 | parameter *file*. Returns NULL if   |
|                                                                 | an error occurs.                    |
+-----------------------------------------------------------------+-------------------------------------+
| [`createFromString`](#createFromString)`( source ``STRING`` )`\ | Creates a new DomDocument object by |
| `  ``RETURNING`` om.DomDocument`                                | parsing the XML string passed as    |
|                                                                 | parameter. Returns NULL if an error |
|                                                                 | occurs.                             |
+-----------------------------------------------------------------+-------------------------------------+
| **Object Methods**                                                                                    |
+-----------------------------------------------------------------+-------------------------------------+
| **Name**                                                        | **Description**                     |
+-----------------------------------------------------------------+-------------------------------------+
| [`copy`](#copy)`( src om.DomNode, deep ``INTEGER`` )`\          | Clones a DomNode (with child nodes  |
| `  ``RETURNING`` om.DomNode`                                    | if *deep* is                        |
|                                                                 | [TRUE](Programs.html#PC_TRUE)).     |
+-----------------------------------------------------------------+-------------------------------------+
| [`createChars`](#createChars)`( text ``STRING`` )`\             | Creates a DomNode as a text node.   |
| `  ``RETURNING`` om.DomNode`                                    |                                     |
+-----------------------------------------------------------------+-------------------------------------+
| [`createEntity`](#createEntity)`( text ``STRING`` )`\           | Creates a DomNode as an entity      |
| `  ``RETURNING`` om.DomNode`                                    | node.                               |
+-----------------------------------------------------------------+-------------------------------------+
| [`createElement`](#createElement)`( tag ``STRING`` )`\          | Creates a new empty DomNode object  |
| `  ``RETURNING`` om.DomNode`                                    | with a tag name specified by        |
|                                                                 | *tag*.                              |
+-----------------------------------------------------------------+-------------------------------------+
| [`getDocumentElement`](#getDocumentElement)`( )`\               | Returns the root node of the DOM    |
| `  ``RETURNING`` om.DomNode`                                    | document.                           |
+-----------------------------------------------------------------+-------------------------------------+
| [`getElementById`](#getElementbyID)`( id ``INTEGER`` )`\        | Gets an element using its id, the   |
| `  ``RETURNING`` om.DomNode`                                    | internal integer identifier         |
|                                                                 | automatically assigned to each      |
|                                                                 | DomNode object.                     |
+-----------------------------------------------------------------+-------------------------------------+
| [`removeElement`](#removeElement)`( e om.DomNode )`             | Removes a DomNode object and any    |
|                                                                 | descendent DomNodes from the        |
|                                                                 | document.                           |
+-----------------------------------------------------------------+-------------------------------------+

------------------------------------------------------------------------

### [Usage:]{#USAGE}

A DomDocument object holds a [DOM](XmlUtils.html) tree of
[DomNode](ClassDomNode.html) objects.

A unique root [DomNode](ClassDomNode.html) object is owned by a
DomDocument object.

#### [Create a new DomDocument object]{#Create_a_DomDocument}

To create an instance of the DomDocument class, you must first declare a
[variable](Variables.html) with the type om.DomDocument.

Then, use the method [`om.DomDocument.create()`]{#create} to instantiate
a new, empty DomDocument object.

To create a document from an existing XML file, use the method
[`om.DomDocument.createFromXmlFile()`]{#createFromXmlFile}. You can also
use the [`om.DomDocument.createFromString()`]{#createFromString} method
to create a document from a string in memory.

#### [Create a new DomNode object]{#Create_a_DomNode}

New nodes can be created with the [`createElement()`]{#createElement}
method.

New text nodes can be created with the [`createChars()`]{#createChars}
method.

New entity nodes can be created with the
[`createEntity()`]{#createEntity} method.

Clone a DomNode object using the [`copy()`]{#copy} method.

Once a new DomNode object is created, you can for example inserted it in
the DOM tree with the `insertBefore()` method of a DomNode object

#### [Return the root node of the DomDocument]{#getDocumentElement}

You can get the root node with the `getDocumentElement()` method. Once
you have the root element, you can recursively manipulate child nodes
with the [DomNode](ClassDomNode.html) class methods

#### [Return a specific node of the DomDocument]{#getElementbyID}

You can get a specific node of the DomDocument by using its internal
identifier with the `getElementById()` method.

#### [Remove a DomNode object]{#removeElement}

Use the `removeElement()` method to remove an Element from a
DomDocument.

------------------------------------------------------------------------

### [Examples]{#EXAMPLES}

#### Example 1:

``` linenumber
01 MAIN
02   DEFINE d om.DomDocument
03   DEFINE r om.DomNode
04   LET d = om.DomDocument.create("MyDocument")
05   LET r = d.getDocumentElement()
06 END MAIN
```
