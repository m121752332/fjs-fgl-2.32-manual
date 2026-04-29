[Back to Contents](../index.html)

------------------------------------------------------------------------

# [The SaxDocumentHandler class]{#PAGE_HEADER}

Summary:

- [Syntax](#SYNTAX)
- [Methods](#METHODS)
- [Usage](#USAGE)
  - [Creating a SaxDocumentHandler object](#createForName)
  - [Loading the document](#readXmlFile)
  - [Processing the documen](#Processing)t
- [Examples](#EXAMPLES)

*See also:* [Built-in Classes](BuiltInClasses.html), [XML
Utilities](XmlUtils.html), [XmlWriter](ClassXmlWriter.html)

------------------------------------------------------------------------

### [Syntax]{#SYNTAX}

The **SaxDocumentHandler** class provides an interface to write an
[XML](XmlUtils.html) filter with a loadable 4gl module, following the
[SAX](XmlUtils.html) standards.

**Warning: You must either write a BDL module dedicated to the
implementation of the filter methods, or create the SaxDocumentHandler
object with a [XmlWriter](ClassXmlWriter.html) creation method; see
[usage](#USAGE) for more details.**

#### Syntax:

`om.SaxDocumentHandler`

------------------------------------------------------------------------

### [Methods:]{#METHODS}

+-----------------------------------------------------------------------------------+-------------------------------------+
| **Class Methods**                                                                                                       |
+-----------------------------------------------------------------------------------+-------------------------------------+
| **Name**                                                                          | **Description**                     |
+-----------------------------------------------------------------------------------+-------------------------------------+
| [`createForName`](#createForName)`( module ``STRING`` )`\                         | Creates a SaxDocumentHandler object |
| `  ``RETURNING`` om.SaxDocumentHandler`                                           | using a BDL module.                 |
+-----------------------------------------------------------------------------------+-------------------------------------+
| **Object Methods**                                                                                                      |
+-----------------------------------------------------------------------------------+-------------------------------------+
| **Name**                                                                          | **Description**                     |
+-----------------------------------------------------------------------------------+-------------------------------------+
| [`readXmlFile`](#readXmlFile)`( file ``STRING ``)`                                | Reads an XML file and applies the   |
|                                                                                   | filter.                             |
+-----------------------------------------------------------------------------------+-------------------------------------+
| [`setIndent`](#setIndent)` ( indenting ``BOOLEAN ``)`                             | Enables output indentation if       |
|                                                                                   | `indenting` is TRUE. Indentation is |
|                                                                                   | enabled by default                  |
+-----------------------------------------------------------------------------------+-------------------------------------+
| [`startDocument`](#startDocument)`( )`                                            | Processes the beginning of the      |
|                                                                                   | document.                           |
+-----------------------------------------------------------------------------------+-------------------------------------+
| [`startElement`](#startElement)`( tag ``STRING``, atts SaxAttributes )`           | Processes the beginning of an       |
|                                                                                   | element having the tag name *tag*   |
|                                                                                   | and the attributes *atts*.          |
+-----------------------------------------------------------------------------------+-------------------------------------+
| [`characters`](#characters)`( text ``STRING`` )`                                  | Processes characters of a text      |
|                                                                                   | node.                               |
+-----------------------------------------------------------------------------------+-------------------------------------+
| [`skippedEntity`](#skippedEntity)`( text ``STRING`` )`                            | Processes an unresolved entity.     |
+-----------------------------------------------------------------------------------+-------------------------------------+
| [`endElement`](#endElement)`( tag ``STRING`` )`                                   | Processes the end of an element     |
|                                                                                   | having the tag name *tag*.          |
+-----------------------------------------------------------------------------------+-------------------------------------+
| [`endDocument`](#endDocument)`( )`                                                | Processes the end of the document.  |
+-----------------------------------------------------------------------------------+-------------------------------------+
| [`processingInstruction`](#processingInstruction)`( n ``STRING``, a ``STRING ``)` | Processes a processing instruction  |
|                                                                                   | with the name *n* and attributes    |
|                                                                                   | *a*.                                |
+-----------------------------------------------------------------------------------+-------------------------------------+

------------------------------------------------------------------------

### [Usage:]{#USAGE}

This class can be used in two different ways:

1.  To implement an XML SAX filter, using BDL functions defined in a
    module.
2.  To write an XML document to a file, process or socket output, using
    [XmlWriter](ClassXmlWriter.html) creation methods.

This page describes the first usage; see
[XmlWriter](ClassXmlWriter.html) for more details about the second
usage.

With the SaxDocumentHandler class, you can implement a SAX filter by
using a BDL module to write the methods handling the standard SAX
events. The SaxDocumentHandler class also provides methods to process
all SAX events by hand. This is useful if you want to chain SAX filters.

#### [Creating a SaxDocumentHandler object]{#createForName}

First, you create the SaxDocumentHandler object with the
`om.SaxDocumentHandler.createForName(`*`module`*`)` method, which takes
a BDL module as a parameter:

``` linenumber
01 DEFINE filter om.SaxDocumentHandler
02 LET filter = om.SaxDocumentHandler.createForName("module1")
```

When doing this, the runtime system loads the BDL module and attaches
its [functions](Functions.html) to the SaxDocumentHandler methods [by
name]{.underline}.

#### [Loading the document]{#readXmlFile}

To process a document, you typically load it from an XML file:

``` linenumber
01 CALL filter.readXmlFile("xmlsource")
```

#### [Processing the document]{#Processing}

The module must implement the following functions to match the SAX
filter events:

- [`startDocument()`]{#startDocument}: Called one time at the beginning
  of the document processing.
- [`processingInstruction(name,data)`]{#processingInstruction}: Called
  when a processing instruction is reached, identified by *name*, with
  *data* information.
- [`startElement(name,attr)`:]{#startElement} Called when an XML element
  is reached, identified by the tag *name*, having the *attr* attributes
  ([SaxAttributes](ClassSaxAttributes.html)).
- [`characters(chars)`:]{#characters} Called when a text node is
  reached, having the characters *chars*.
- [`skippedEntity(chars)`]{#skippedEntity}: Called when an unknown
  entity node is reached (like &xxx; for example). Entity name is stored
  in *chars*.
- [`endElement(name)`]{#endElement}: Called when the end of an XML
  element is reached, identified by the tag *name*.
- [`endDocument()`:]{#endDocument} Called one time at the beginning of
  the document processing.

In these functions, you are free to process the XML document as you
wish. You can use the [SaxAttributes](ClassSaxAttributes.html) methods
to get the attributes of an element, transform the values or ignore some
attributes, and write directly to a file or to the database, or even
chain directly with another SaxDocumentHandler. If you want to write to
an XML file, you typically use an [XmlWriter](ClassXmlWriter.html)
object. 

By default, the SaxDocumentHandler object outputs XML with indentation.
If you want to disable indentation, use the [`setIndent()`]{#setIndent}
method:

``` linenumber
01 CALL myhdlr.setIndent(FALSE)
```

------------------------------------------------------------------------

### [Examples]{#EXAMPLES}

#### Example 1: Extracting phone numbers from a directory.

This example shows how to write a SAX filter to extract phone numbers
from a directory file written in XML.

``` linenumber
01 MAIN
02   DEFINE f om.SaxDocumentHandler
03   LET f = om.SaxDocumentHandler.createForName("module1")
04   CALL f.readXmlFile("customers")
05 END MAIN
```

**Notes:**

1.  In Line `03`{.linenumber}, the input parameter specifies the name of
    a source file that has been compiled into a .42m file
    (\"module1.42m\" in our example).

The module \"module1.4gl\":

``` linenumber
01 FUNCTION startDocument()
02 END FUNCTION
03
04 FUNCTION processingInstruction(name,data)
05   DEFINE name,data STRING
06 END FUNCTION
07
08 FUNCTION startElement(name,attr)
09   DEFINE name STRING
10   DEFINE attr om.SaxAttributes
11   DEFINE i INTEGER
12   IF name="Customer" THEN
13      DISPLAY attr.getValue("lname")," ",
14             attr.getValue("fname"),":",
15             COLUMN 60, attr.getValue("phone")
16   END IF
17 END FUNCTION
18
19 FUNCTION endElement(name)
20   DEFINE name STRING
21 END FUNCTION
22
23 FUNCTION endDocument()
24 END FUNCTION
25
26 FUNCTION characters(chars)
27   DEFINE chars STRING
28 END FUNCTION
29
30 FUNCTION skippedEntity(chars)
31   DEFINE chars STRING
32 END FUNCTION
```

The XML file \"customers\":

    <Customers>
      <Customer customer_num="101" fname="Ludwig" lname="Pauli"
        company="All Sports Supplies" address1="213 Erstwild Court"
        address2="" city="Sunnyvale" state="CA" zipcode="94086"
        phone="408-789-8075" />
      <Customer customer_num="102" fname="Carole" lname="Sadler"
        company="Sports Spot" address1="785 Geary St"
        address2="" city="San Francisco" state="CA" zipcode="94117"
        phone="415-822-1289" />
      <Customer customer_num="103" fname="Philip" lname="Currie"
        company="Phil&apos;s Sports" address1="654 Poplar"
        address2="P. O. Box 3498" city="Palo Alto" state="CA"
        zipcode="94303" phone="415-328-4543" />
    </Customers>
