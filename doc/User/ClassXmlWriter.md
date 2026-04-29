[Back to Contents](../index.html)

------------------------------------------------------------------------

# [The XmlWriter class]{#PAGE_HEADER}

Summary:

- [Syntax](#SYNTAX)
- [Methods](#METHODS)
- [Usage](#USAGE)
  - [Create a SaxDocumentHandler object writing to a
    file](#createFileWriter)
  - [Create a SaxDocumentHandler object writing to a
    pipe](#createPipeWriter)
  - [Create a SaxDocumentHandler object writing to a
    socket](#createSocketWriter)
- [Examples](#EXAMPLES)

*See also:* [Built-in Classes](BuiltInClasses.html), [XML
Utilities](XmlUtils.html),
[SaxDocumentHandler](ClassSaxDocumentHandler.html)

------------------------------------------------------------------------

### [Syntax]{#SYNTAX}

The **XmlWriter** class allows you to write [XML](XmlUtils.html)
documents to different types of output, following the
[SAX](XmlUtils.html) standards.

#### Syntax:

`om.XmlWriter`

------------------------------------------------------------------------

### [Methods:]{#METHODS}

+------------------------------------------------------------------------------------+-------------------------------------+
| **Class Methods**                                                                                                        |
+------------------------------------------------------------------------------------+-------------------------------------+
| **Name**                                                                           | **Description**                     |
+------------------------------------------------------------------------------------+-------------------------------------+
| [`createFileWriter(`](#createFileWriter)` file ``STRING`` )`\                      | Creates a SaxDocumentHandler object |
| `  ``RETURNING`` om.SaxDocumentHandler`                                            | writing to a file.                  |
+------------------------------------------------------------------------------------+-------------------------------------+
| [`createPipeWriter`](#createPipeWriter)`( exec ``STRING`` )`\                      | Creates a SaxDocumentHandler object |
| `  ``RETURNING`` om.SaxDocumentHandler`                                            | writing to a pipe created for a     |
|                                                                                    | process.                            |
+------------------------------------------------------------------------------------+-------------------------------------+
| [`createSocketWriter`](#createSocketWriter)`( host ``STRING``, port ``STRING`` )`\ | Creates a SaxDocumentHandler object |
| `  ``RETURNING`` om.SaxDocumentHandler`                                            | writing to a socket.                |
+------------------------------------------------------------------------------------+-------------------------------------+

------------------------------------------------------------------------

### [Usage:]{#USAGE}

This class is only used to create a SaxDocumentHandler object, by using
one of the class methods described in the above table.

First, define a [variable](Variables.html) of type
*om.SaxDocumentHander* and create the object with one of the \"create\"
methods, according to the output destination:

- The method
  [`om.XmlWriter.createFileWriter(`*`filename`*`)`]{#createFileWriter}
  creates an object writing to the file identified by *filename*.
- The method
  [`om.XmlWriter.createPipeWriter(`*`progname`*`)`]{#createPipeWriter}
  creates an object writing to a pipe opened by a sub-process identified
  by *progname*.
- The method
  [`om.XmlWriter.createSocketWriter(`*`hostname`*`,`*`portnum`*`)`]{#createSocketWriter}
  creates an object writing to the TCP socket identified by the host
  *hostname* and the TCP port *portnum*.

To handle element attributes, define a [variable](Variables.html) of
type [om.SaxAttributes](ClassSaxAttributes.html).

Create the SaxAttributes object with `om.SaxAttributes.create()` class
method. See the [class definition](ClassSaxAttributes.html) for more
details about attributes definition.

#### Use SaxDocumentHandler methods

Use the method `startDocument()` to start writing to the output. From
this point, the order of method calls defines the structure of the XML
document.

To write an element, fill the [SaxAttributes](ClassSaxAttributes.html)
object with attributes. Then, initiate the element output with the
method `startElement(name,attset)`, where *name* is the tag name of the
element and *attset* is the [SaxAttributes](ClassSaxAttributes.html)
object defining element attributes. After this call, you can write text
nodes with the `characters()` method. You can write an entity node with
the `entity()` method. Finish element output with a call to the
`endElement()` method. Repeat these steps as many times as you have
elements to write.

Instead of using the `startElement()` method, you can generate
processing instruction elements with
`processingInstruction(name,attset)`, where name is the *name* of the
application. The resulting XML output is in the form:
`<?name attribute="value1" ... ?>`

Finally, you must finish the document output with a `endDocument()`
call.

------------------------------------------------------------------------

### [Examples]{#EXAMPLES}

#### Example 1:

The following code writes an HTML page to a file using the XmlWriter
class:

``` linenumber
01 MAIN
02   DEFINE w om.SaxDocumentHandler
03   DEFINE a,n om.SaxAttributes
04 
05   LET w = om.XmlWriter.createFileWriter("sample.html")
06   LET a = om.SaxAttributes.create()
07   LET n = om.SaxAttributes.create()
08 
09   CALL n.clear()
10 
11   CALL w.startDocument()
12 
13     CALL w.startElement("HTML",n)
14 
15       CALL w.startElement("HEAD",n)
16 
17         CALL w.startElement("TITLE",n)
18         CALL w.characters("HTML page generated with XmlWriter")
19         CALL w.endElement("TITLE")
20 
21         CALL a.clear()
22         CALL a.addAttribute("type","text/css")
23         CALL w.startElement("STYLE",a)
24         CALL w.characters("\nBODY { background-color:#c0c0c0; }\n")  
25         CALL w.endElement("STYLE")
26 
27       CALL w.endElement("HEAD")
28 
29       CALL w.startElement("BODY",n)
30 
31         CALL addHLine(w)
32         CALL addTitle(w,"What is XML?",1,"55ff55")
33         CALL addParagraph(w,"XML = eXtensible Markup Language ...")
34 
35         CALL addHLine(w)
36         CALL addTitle(w,"What is SAX?",1,"55ff55")
37         CALL addParagraph(w,"SAX = Simple Api for XML ...")
38 
39       CALL w.endElement("BODY")
40 
41     CALL w.endElement("HTML")
42 
43   CALL w.endDocument()
44 
45 END MAIN
46 
47 FUNCTION addHLine(w)
48   DEFINE w om.SaxDocumentHandler
49   DEFINE a om.SaxAttributes
50   LET a = om.SaxAttributes.create()
51   CALL a.clear()
52   CALL a.addAttribute("width","100%")
53   CALL w.startElement("HR",a)
54   CALL w.endElement("HR")
55 END FUNCTION
56 
57 FUNCTION addTitle(w,t,x,c)
58   DEFINE w om.SaxDocumentHandler
59   DEFINE t VARCHAR(100)
60   DEFINE x INTEGER
61   DEFINE c VARCHAR(20)
62   DEFINE a om.SaxAttributes
63   DEFINE n varchar(10)
64   LET a = om.SaxAttributes.create()
65   LET n = "h" || x
66   CALL a.clear()
67   CALL w.startElement(n,a)
68   IF c IS NOT NULL THEN
69     CALL a.addAttribute("color",c)
70   END IF
71   CALL w.startElement("FONT",a)
72   CALL w.characters(t)
73   CALL w.endElement("FONT")
74   CALL w.endElement(n)
75 END FUNCTION
76 
77 FUNCTION addParagraph(w,t)
78   DEFINE w om.SaxDocumentHandler
79   DEFINE t VARCHAR(2000)
80   DEFINE a om.SaxAttributes
81   LET a = om.SaxAttributes.create()
82   CALL a.clear()
83   CALL w.startElement("P",a)
84   CALL w.characters("Text is:")
84   CALL w.skippedEntity("nbsp")         # Add a non breaking space : &nbsp;
84   CALL w.characters("is")
84   CALL w.characters(t)
85   CALL w.endElement("P")
86 END FUNCTION
```
