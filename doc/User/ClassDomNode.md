[Back to Contents](../index.html)

------------------------------------------------------------------------

# [The DomNode class]{#PAGE_HEADER}

Summary:

- [Syntax](#SYNTAX)
- [Methods](#METHODS)
- [Usage](#USAGE)
  - [Node creation/removal](#Node_creation_removal)
  - [In/Out utilities](#In_Out_utilities)
  - [Node Identification](#Node_Identification)
  - [Attributes management](#Attributes_management)
  - [Tree navigation](#Tree_navigation)
- [Examples](#EXAMPLES)

*See also:* [Built-in Classes](BuiltInClasses.html), [XML
Utilities](XmlUtils.html), [NodeList](ClassNodeList.html)

------------------------------------------------------------------------

### [Syntax]{#SYNTAX}

The **DomNode** class provides methods to manipulate a node of a data
tree, following the [DOM](XmlUtils.html) standards.

#### Syntax:

`om.DomNode`

#### Notes:

1.  A DomNode object is a node (or element) of a
    [DomDocument](ClassDomDocument.html).

------------------------------------------------------------------------

### [Methods:]{#METHODS}

+-----------------------------------------------------------------------------------+-------------------------------------+
| **Object Methods**                                                                                                      |
+-----------------------------------------------------------------------------------+-------------------------------------+
| **Name**                                                                          | **Description**                     |
+-----------------------------------------------------------------------------------+-------------------------------------+
| **Node creation**                                                                                                       |
+-----------------------------------------------------------------------------------+-------------------------------------+
| [`appendChild`](#appendChild)`( src om.DomNode )`                                 | Adds an existing DomNode at the end |
|                                                                                   | of the list of children in this     |
|                                                                                   | node.                               |
+-----------------------------------------------------------------------------------+-------------------------------------+
| [`createChild`](#createChild)`( tag ``STRING`` )`\                                | Creates a DomNode and adds it to    |
| `  ``RETURNING`` om.DomNode`                                                      | the children list of this node.     |
+-----------------------------------------------------------------------------------+-------------------------------------+
| [`insertBefore`](#insertBefore)`( new om.DomNode, exn om.DomNode )`               | Inserts an existing DomNode just    |
|                                                                                   | before the node referenced by       |
|                                                                                   | *exn*.                              |
+-----------------------------------------------------------------------------------+-------------------------------------+
| [`removeChild`](#removeChild)`( node om.DomNode )`                                | Removes the child node referenced   |
|                                                                                   | by *node* and removes any of its    |
|                                                                                   | descendents.                        |
+-----------------------------------------------------------------------------------+-------------------------------------+
| [`replaceChild`](#replaceChild)`( new om.DomNode, old om.DomNode )`               | Replaces the child node referenced  |
|                                                                                   | by *old* by the node *new*.         |
+-----------------------------------------------------------------------------------+-------------------------------------+
| **In/Out Utilities**                                                                                                    |
+-----------------------------------------------------------------------------------+-------------------------------------+
| [`loadXml`](#loadXml)`( file ``STRING`` )`\                                       | Creates a new DomNode object by     |
| `  ``RETURNING`` om.DomNode`                                                      | loading an XML file and attaches it |
|                                                                                   | to this node as a child. The new    |
|                                                                                   | created node object is returned     |
|                                                                                   | from the function.                  |
+-----------------------------------------------------------------------------------+-------------------------------------+
| [`parse`](#parse)`( source ``STRING`` ) `                                         | Parses a source string in XML       |
|                                                                                   | format and creates a new DomNode    |
|                                                                                   | from it.                            |
+-----------------------------------------------------------------------------------+-------------------------------------+
| [`toString`](#toString)`( ) ``RETURNING STRING`                                   | Serializes the DomNode to a string  |
|                                                                                   | in XML format.                      |
+-----------------------------------------------------------------------------------+-------------------------------------+
| [`writeXml`](#writeXml)`( file ``STRING`` )`                                      | Writes an XML file with the current |
|                                                                                   | node.                               |
+-----------------------------------------------------------------------------------+-------------------------------------+
| [`write`](#write)`( shd ``om.SaxDocumentHandler`` )`                              | Outputs an xml-tree to a sax        |
|                                                                                   | document handler.                   |
+-----------------------------------------------------------------------------------+-------------------------------------+
| **Node identification**                                                                                                 |
+-----------------------------------------------------------------------------------+-------------------------------------+
| [`getId`](#getId)`( )`\                                                           | Returns the internal integer        |
| `  ``RETURNING INTEGER`                                                           | identifier automatically assigned   |
|                                                                                   | to an Abstract User Interface       |
|                                                                                   | DomNode. Returns -1 for nodes that  |
|                                                                                   | are not part of the [Abstract User  |
|                                                                                   | Interface tree](DynamicUI.html).    |
+-----------------------------------------------------------------------------------+-------------------------------------+
| [`getTagName`](#getTagName)`( )`\                                                 | Returns the tag name of the node.   |
| `  ``RETURNING STRING`                                                            |                                     |
+-----------------------------------------------------------------------------------+-------------------------------------+
| **Attributes management**                                                                                               |
+-----------------------------------------------------------------------------------+-------------------------------------+
| [`setAttribute`](#setAttribute)`( att ``STRING, ``val ``STRING`` ) `              | Sets the attribute *att* with value |
|                                                                                   | *val*.                              |
+-----------------------------------------------------------------------------------+-------------------------------------+
| [`getAttribute`](#getAttribute)`( att ``STRING`` )`\                              | Returns the value of the attribute  |
| `  ``RETURNING STRING`                                                            | having the name *att*.              |
+-----------------------------------------------------------------------------------+-------------------------------------+
| [`getAttributeInteger`](#getAttributeInteger)`(att ``STRING, ``def ``INTEGER``)`\ | Returns the value of the attribute  |
| `  ``RETURNING INTEGER`                                                           | having the name *att* as an integer |
|                                                                                   | value. Returns *def* if the         |
|                                                                                   | attribute is not defined.           |
+-----------------------------------------------------------------------------------+-------------------------------------+
| [`getAttributeString`](#getAttributeString)`(att ``STRING, ``def ``STRING``)`\    | Returns the value of the attribute  |
| `  ``RETURNING INTEGER`                                                           | having the name *att* as a string   |
|                                                                                   | value. Returns *def* if the         |
|                                                                                   | attribute is not defined.           |
+-----------------------------------------------------------------------------------+-------------------------------------+
| [`getAttributeName`](#getAttributeName)`( pos ``INTEGER`` )`\                     | Returns the name of the attribute   |
| `  ``RETURNING STRING`                                                            | at the position *pos* (1 = first).  |
+-----------------------------------------------------------------------------------+-------------------------------------+
| [`getAttributesCount`](#getAttributesCount)`()`\                                  | Returns the number of attributes of |
| `  ``RETURNING INTEGER`                                                           | this DomNode.                       |
+-----------------------------------------------------------------------------------+-------------------------------------+
| [`getAttributeValue`](#getAttributeValue)`( pos ``INTEGER`` )`\                   | Returns the value of the attribute  |
| `  ``RETURNING STRING`                                                            | at the position *pos* (1 = first).  |
+-----------------------------------------------------------------------------------+-------------------------------------+
| [`removeAttribute`](#removeAttribute)`( att ``STRING`` ) `                        | Deletes the attribute identified by |
|                                                                                   | *att*.                              |
+-----------------------------------------------------------------------------------+-------------------------------------+
| **Tree navigation**                                                                                                     |
+-----------------------------------------------------------------------------------+-------------------------------------+
| [`getChildCount`](#getChildCount)`( )`\                                           | Returns the number of children.     |
| `  ``RETURNING INTEGER`                                                           |                                     |
+-----------------------------------------------------------------------------------+-------------------------------------+
| [`getChildByIndex`](#getChildByIndex)`( pos ``INTEGER`` )`\                       | Returns the child node at index     |
| `  ``RETURNING`` om.DomNode`                                                      | *pos* (1 = first).                  |
+-----------------------------------------------------------------------------------+-------------------------------------+
| [`getFirstChild`](#getFirstChild)`( )`\                                           | Returns the first child node.       |
| `  ``RETURNING`` om.DomNode`                                                      |                                     |
+-----------------------------------------------------------------------------------+-------------------------------------+
| [`getLastChild`](#getLastChild)`( )`\                                             | Returns the last DomNode in the     |
| `  ``RETURNING ``om.DomNode`                                                      | list of children.                   |
+-----------------------------------------------------------------------------------+-------------------------------------+
| [`getNext`](#getNext)`( )`\                                                       | Returns the next sibling DomNode of |
| `  ``RETURNING ``om.DomNode`                                                      | this node.                          |
+-----------------------------------------------------------------------------------+-------------------------------------+
| [`getParent`](#getParent)`( )`\                                                   | Returns the parent DomNode of this  |
| `  ``RETURNING ``om.DomNode`                                                      | node.                               |
+-----------------------------------------------------------------------------------+-------------------------------------+
| [`getPrevious`](#getPrevious)`( )`\                                               | Returns the previous sibling        |
| `  ``RETURNING ``om.DomNode`                                                      | DomNode of this node.               |
+-----------------------------------------------------------------------------------+-------------------------------------+
| [`selectByTagName`](#selectByTagName)`( name ``STRING`` )`\                       | Creates a list of nodes by          |
| `  ``RETURNING ``om.NodeList`                                                     | recursively searching nodes by tag  |
|                                                                                   | name.                               |
+-----------------------------------------------------------------------------------+-------------------------------------+
| [`selectByPath`](#selectByPath)`( path ``STRING`` )`\                             | Creates a list of nodes by          |
| `  ``RETURNING ``om.NodeList`                                                     | recursively searching nodes         |
|                                                                                   | matching an XPath-like pattern.     |
+-----------------------------------------------------------------------------------+-------------------------------------+

------------------------------------------------------------------------

### [Usage:]{#USAGE}

#### [Node creation/removal]{#Node_creation_removal}

To create an instance of the DomNode class from scratch, you must
instantiate the object using one of the methods provided in the DomNode
class:

[`createChild()`]{#createChild} creates a child node and adds it to the
children list.

[`appendChild()`]{#appendChild} adds an existing node to the end of the
children list. The appended node must have been created with a document
method such as
[DomDocument.createElement()](ClassDomDocument.html#createElement).

[`insertBefore()`]{#insertBefore} inserts an existing node before the
node specified as second parameter. The inserted node must have been
created with a document method such as
[DomDocument.createElement()](ClassDomDocument.html#createElement).

[`replaceChild()`]{#replaceChild} replaces the specified child node with
a different child node. The replacing node must have been created with a
document method such as
[DomDocument.createElement()](ClassDomDocument.html#createElement). The
replaced node will be dropped from the document.

Other methods to create DomNode objects are available from the
[DomDocument](ClassDomDocument.html) class. For example, to create a
*text node*, use the `createChars()` method of a DomDocument object; to
create an *entity node*, use the `createEntity()` method of a
DomDocument object.

[`removeChild()`]{#removeChild}  removes the specified child node.

#### [In/Out utilities]{#In_Out_utilities}

The DomNode class provides the [`writeXml`]{#writeXml}`()` method to
save the [DOM](XmlUtils.html) tree into a file in [XML](XmlUtils.html)
format.

The method [`write`]{#write}`()` outputs an xml-tree to a sax document
handler.

The method [`loadXml()`]{#loadXml} creates a new DomNode object by
loading an XML file and attaches it to this node as a child.

Use the [`toString()`]{#toString} method to generate a string in
[XML](XmlUtils.html) format from the DomNode. To scan an XML source
string and create a DomNode from, use the [`parse()`]{#parse} method.

#### [Attributes management]{#Attributes_management}

A DomNode object can have attributes with values, except if it is a
*text node*. In this case, you can only get/set the text of the node,
since text nodes cannot have attributes. The DomNode class provides a
complete set of methods to modify attribute values:

[`getAttribute`]{#getAttribute}`()` returns the value of the attribute
having the specified name.

[`setAttribute`]{#setAttribute}`()` sets the value of the specified
attribute.

[`getAttributeInteger`]{#getAttributeInteger}`()` returns the value of
the specified attribute as an integer value.

[`getAttributeString`]{#getAttributeString}`()` returns the value of the
specified attribute as a string value.

[`getAttributeName`]{#getAttributeName}`()` returns the name of the
attribute at the specified position.

[`getAttributesCount`]{#getAttributesCount}`()`returns the number of
attributes of this DomNode.

[`getAttributeValue`]{#getAttributeValue}`()` returns the value of the
attribute at the specified position.

[`removeAttribute`]{#removeAttribute}`()` deletes the specified
attribute.

#### [Node Identification]{#Node_Identification}

To get the tag name of the [DOM](XmlUtils.html) node, use the
[`getTagName`]{#getTagName}`()` method.

The method [`getId`]{#getId}`()` returns the internal integer identifier
automatically assigned to an DomNode.

#### [Tree navigation]{#Tree_navigation}

A DomNode object can have zero or more DomNode children that can have,
in turn, other children. The DomNode class provides a complete set of
methods to manipulate *DomNode* child objects.

[`getChildCount`]{#getChildCount}`()` returns the number of children.

[`getChildByIndex`]{#getChildByIndex}`()` returns the child node at the
specified index position.

[`getFirstChild`]{#getFirstChild}`()` returns the first child node.

[`getLastChild`]{#getLastChild}`()` returns the last DomNode in the list
of children.

[`getNext`]{#getNext}`()` returns the next sibling DomNode of this node.

[`getParent`]{#getParent}`() `returns the parent DomNode of this node.

[`getPrevious`]{#getPrevious}`() `returns the previous sibling DomNode
of this node.

The [`selectByTagName`]{#selectByTagName}`()` and
[`selectByPath`]{#selectByPath}`()` methods allow you to search for
children nodes according to a tag name (i.e. a type of node) or by using
an XPath-like search criteria. See the [NodeList](ClassNodeList.html)
class for more details.

#### Warnings:

1.  Tag and attribute names are case sensitive; \"Wheel\" is not the
    same as \"wheel\".
2.  Text nodes cannot have attributes, but they have plain text.
3.  In text nodes, the characters can be accessed with the `@chars`
    attribute name.
4.  In XML representation, a text node is the text itself. Do not
    confuse it with the parent node. For example,
    `<Item id="32">Red shoes</Item>` represents 2 nodes: The parent
    \'Item\' node and a text node with string \'Red shoes\'.

#### Tips:

1.  If you need to identify an element, use a common attribute like
    \"name\".
2.  If you need to label an element, use a common attribute like
    \"text\".

------------------------------------------------------------------------

### [Examples]{#EXAMPLES}

#### Example 1:

To create a [DOM](XmlUtils.html) tree with the following structure
(represented in XML format):

    <Vehicles>
       <Car name="Corolla" color="Blue" weight="1546">Nice car!&nbsp;Yes, very nice!
       </Car>
       <Bus name="Maxibus" color="Yellow" weight="5278">
          <Wheel width="315" diameter="925" />
          <Wheel width="315" diameter="925" />
          <Wheel width="315" diameter="925" />
          <Wheel width="315" diameter="925" />
       </Bus>
    </Vehicles>

You write the following:

``` linenumber
01 MAIN
02   DEFINE d om.DomDocument
03   DEFINE r, n, t, w om.DomNode
04   DEFINE i INTEGER
05
06   LET d = om.DomDocument.create("Vehicles")
07   LET r = d.getDocumentElement()
08
09   LET n = r.createChild("Car")
10   CALL n.setAttribute("name","Corolla")
11   CALL n.setAttribute("color","Blue")
12   CALL n.setAttribute("weight","1546")
13
14   LET t = d.createChars("Nice car!")
15   CALL n.appendChild(t)
16   LET t = d.createEntity("nbsp")
17   CALL n.appendChild(t)
18   LET t = d.createChars("Yes, very nice!")
19   CALL n.appendChild(t)
20
21   LET n = r.createChild("Bus")
22   CALL n.setAttribute("name","Maxibus")
23   CALL n.setAttribute("color","yellow")
24   CALL n.setAttribute("weight","5278")
25   FOR i=1 TO 4
26     LET w = n.createChild("Wheel")
27     CALL w.setAttribute("width","315")
28     CALL w.setAttribute("diameter","925")
29   END FOR
30
31   CALL r.writeXml("Vehicles.xml")
32
33 END MAIN
```

#### Example 2:

The following example displays a [DOM](XmlUtils.html) tree content
recursively:

``` linenumber
01 FUNCTION displayDomNode(n,e)
02   DEFINE n om.DomNode
03   DEFINE e, i, s INTEGER
04
05   LET s = e*2
06   DISPLAY s SPACES || "Tag: " || n.getTagName()
07
08   DISPLAY s SPACES || "Attributes:"
09   FOR i=1 TO n.getAttributesCount()
10      DISPLAY s SPACES || "  " || n.getAttributeName(i) || "=[" || n.getAttributeValue(i) ||"]"
11   END FOR
12   LET n = n.getFirstChild()
13
14   DISPLAY s SPACES || "Child Nodes:"
15   WHILE n IS NOT NULL
16     CALL displayDomNode(n,e+1)
17     LET n = n.getNext()
18   END WHILE
19
20 END FUNCTION
```

#### Example 3:

The following example outputs a Dom tree without indentation.

``` linenumber
01 MAIN
02   DEFINE d om.DomDocument
03   DEFINE r, n, t, w om.DomNode
04   DEFINE dh om.SaxDocumentHandler
05 
06   DEFINE i INTEGER
07 
08   LET dh = om.XmlWriter.createPipeWriter("cat")
09   CALL dh.setIndent(FALSE)
10
11   LET d = om.DomDocument.create("Vehicles")
12   LET r = d.getDocumentElement()
13
14   LET n = r.createChild("Car")
15   CALL n.setAttribute("name","Corolla")
16   CALL n.setAttribute("color","Blue")
17   CALL n.setAttribute("weight","1546")
18
19   LET t = d.createChars("Nice car!")
20   CALL n.appendChild(t)
21
22   LET n = r.createChild("Bus")
23   CALL n.setAttribute("name","Maxibus")
24   CALL n.setAttribute("color","yellow")
25   CALL n.setAttribute("weight","5278")
26   FOR i=1 TO 4
27     LET w = n.createChild("Wheel")
28     CALL w.setAttribute("width","315")
29     CALL w.setAttribute("diameter","925")
30   END FOR
31
32   CALL r.write(dh)
33
34 END MAIN
```
