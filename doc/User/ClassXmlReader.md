[Back to Contents](../index.html)

------------------------------------------------------------------------

# [The XmlReader class]{#PAGE_HEADER}

Summary:

- [Syntax](#SYNTAX)
- [Methods](#METHODS)
- [Usage](#USAGE)
  - [Creating an XMLReader object](#createFileReader)
  - [Processing Events](#Events)
- [Examples](#EXAMPLES)

*See also:* [Built-in Classes](BuiltInClasses.html), [XML
Utilities](XmlUtils.html)

------------------------------------------------------------------------

### [Syntax]{#SYNTAX}

The **XmlReader** class provides methods to read and process a file
written in [XML](XmlUtils.html) format, following the
[SAX](XmlUtils.html) standards.

#### Syntax:

`om.XmlReader`

------------------------------------------------------------------------

### [Methods:]{#METHODS}

+---------------------------------------------------------------+-------------------------------------+
| **Class Methods**                                                                                   |
+---------------------------------------------------------------+-------------------------------------+
| **Name**                                                      | **Description**                     |
+---------------------------------------------------------------+-------------------------------------+
| [`createFileReader`](#createFileReader)`( file ``STRING`` )`\ | Creates an XmlReader reading from a |
| `  ``RETURNING`` om.XmlReader`                                | file.                               |
+---------------------------------------------------------------+-------------------------------------+
| **Object Methods**                                                                                  |
+---------------------------------------------------------------+-------------------------------------+
| **Name**                                                      | **Description**                     |
+---------------------------------------------------------------+-------------------------------------+
| [`getAttributes`](#getAttributes)`( )`\                       | Returns the attribute list of the   |
| `  ``RETURNING`` om.SaxAttributes`                            | current element.                    |
+---------------------------------------------------------------+-------------------------------------+
| [`getCharacters`](#getCharacters)`( )`\                       | Returns the string value of the     |
| `  ``RETURNING STRING`                                        | current text element.               |
+---------------------------------------------------------------+-------------------------------------+
| [`skippedEntity`](#skippedEntity)`( )`\                       | Returns the name of the entity.     |
| `  ``RETURNING STRING`                                        |                                     |
+---------------------------------------------------------------+-------------------------------------+
| [`getTagName`](#getTagName)`( )`\                             | Returns the tag name of the current |
| `  ``RETURNING STRING`                                        | element.                            |
+---------------------------------------------------------------+-------------------------------------+
| [`read(`](#read)` )`\                                         | Reads the next XML fragment and     |
| `  ``RETURNING STRING`                                        | returns the name of the SAX event   |
|                                                               | that occurs. This can be one of     |
|                                                               | `StartDocument`, `StartElement`,    |
|                                                               | `Characters`, `EndElement`,         |
|                                                               | `EndDocument`.                      |
+---------------------------------------------------------------+-------------------------------------+

------------------------------------------------------------------------

### [Usage:]{#USAGE}

The processing of the [XML](XmlUtils.html) file is streamed-data based;
the file is loaded and processed sequentially with events. To process
element attributes, an XmlReader object must cooperate with a
[SaxAttributes](ClassSaxAttributes.html) object. The XmlReader class can
only read from a file. To write to a file, you must use the
[XmlWriter](ClassXmlWriter.html) class.

#### [Creating an XMLReader object]{#createFileReader}

First, you must declare a [variable](Variables.html) of type
*om.XmlReader*, and use the
`om.XmlReader.createFileReader(`*`filename`*`)` method to create the
object; where *filename* is a [string
expression](Expressions.html#EX_STRING) defining the name of the file to
be read.

As with the standard [SAX](XmlUtils.html) API, the [XML](XmlUtils.html)
file is parsed on the basis of events. Once the XmlReader object is
created with the `om.XmlReader.createFileReader()` method, you can
successively call the `read()` method to get named events indicating how
to parse the XML file.

#### [Processing Events]{#Events}

The following events can be returned by the [`read()`]{#read} method:

::: {align="center"}
  ----------------------- ----------------------- ---------------------------------------------------
  **Event name**          **Description**         **Action**

  `StartDocument`         Beginning of the        Prepare processing (allocate resources)
                          document                

  `StartElement`          Beginning of a node     Get current element\'s tagname or attributes\
                                                  `XmlReader.`[`getTagName`]{#getTagName}`()`\
                                                  `XmlReader.`[`getAttributes`]{#getAttributes}`()`

  `Characters`            Value of the current    Get current element\'s value\
                          element                 `XmlReader.`[`getCharacters`]{#getCharacters}`()`

  `SkippedEntity`         Name of the entity      Get current element\'s value\
                                                  `XmlReader.`[`skippedEntity`]{#skippedEntity}`()`

  `EndElement`            Ending of a node        Get current element\'s tagname\
                                                  `XmlReader.getTagName()`

  `EndDocument`           Ending of the document  Finish processing (release  resources)
  ----------------------- ----------------------- ---------------------------------------------------
:::

To process element attributes, you must declare a
[variable](Variables.html) of type
[SaxAttributes](ClassSaxAttributes.html). This object represents a set
of attributes of an element. You get an object of this class with the
`getAttributes()` method. Once created from the XmlReader, the
[SaxAttributes](ClassSaxAttributes.html) object is automatically updated
based on the element currently processed by the XmlReader.

------------------------------------------------------------------------

### [Examples]{#EXAMPLES}

#### Example:

``` linenumber
01 MAIN
02    DEFINE i, l INTEGER
03    DEFINE r om.XmlReader
04    DEFINE e String
05    DEFINE a om.SaxAttributes
06    LET r = om.XmlReader.createFileReader("myfile.xml")
07    LET a = r.getAttributes()
08    LET l = 0
09    LET e = r.read()
10    WHILE e IS NOT NULL
11      CASE e
12        WHEN "StartDocument"
13          DISPLAY "StartDocument:"
14        WHEN "StartElement"
15          LET l=l+1
16          DISPLAY l SPACES, "StartElement:", r.getTagName()
17          FOR i=1 to a.getLength()
18            DISPLAY l SPACES,"  ",
19              a.getName(i)," = ",
20              a.getValueByIndex(i)
21          END FOR
22        WHEN "Characters"
23          DISPLAY l SPACES, "  Characters:'",r.getCharacters(),"'"
24        WHEN "EndElement"
25          DISPLAY l SPACES, "EndElement:", r.getTagName()
26          LET l=l-1
27        WHEN "EndDocument"
28          DISPLAY "EndDocument:"
29        OTHERWISE
30          DISPLAY "Invalid event: ",e
31      END CASE
32      LET e=r.read()
33    END WHILE
34 END MAIN
```
