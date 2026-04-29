[Back to Contents](../index.html)

------------------------------------------------------------------------

# [XML Utilities]{#PAGE_HEADER}

This pages introduces DOM and SAX standards and describes the XML
utility API provided by Genero BDL.

Summary:

- [The DOM and SAX standards](#DOM_SAX)
- [List of built-in XML classes](#XML_CLASSES)
- [Using DOM and SAX classes](#USING_CLASSES)
- [Limitations of XML classes](#LIMITATIONS)
- [Exception handling with XML classes](#EXCEPTIONS)
- [Controlling the user interface with XML classes](#USER_INTERFACE)

*See also:* [Built-in Classes](BuiltInClasses.html).

------------------------------------------------------------------------

## [DOM and SAX standards]{#DOM_SAX}

The [DOM](http://www.w3.org/DOM/) (**D**ocument **O**bject **M**odel) is
a programming interface specification being developed by the World Wide
Web Consortium ([W3C](http://www.w3.org){.inline}), that lets a
programmer create and modify [HTML](http://www.w3.org/MarkUp/){.inline}
pages and [XML](http://www.w3.org/XML/) documents as full-fledged
program objects. DOM is a full-fledged object-oriented, complex but
complete API, providing methods to manipulate the full XML document as a
whole. DOM is designed for small XML trees manipulation.

The [SAX](http://sax.sourceforge.net/) (**S**imple **A**PI for **X**ML)
is a programming interface for XML, simpler as DOM. SAX is event-driven,
streamed-data based, and designed for large trees. 

------------------------------------------------------------------------

## [List of built-in XML classes]{#XML_CLASSES}

Genero BDL implements a set of built-in classes to do basic XML
manipulation. Here is an overview of the supported XML classes:

- [DomDocument class](ClassDomDocument.html), to handle XML document
  objects,
- [DomNode class](ClassDomNode.html), to handle XML nodes and node
  attributes,
- [NodeList class](ClassNodeList.html), to handle the result of an XML
  search,
- [SaxAttributes class](ClassSaxAttributes.html), to handle SAX
  attributes,
- [XmlReader class](ClassXmlReader.html), to process an XML stream with
  a SAX driver,
- [XmlWriter class](ClassXmlWriter.html), to write to an XML stream with
  a SAX driver,
- [SaxDocumentHandler class](ClassSaxDocumentHandler.html), to implement
  a SAX driver with a 4gl module.

------------------------------------------------------------------------

## [Using  the DOM and SAX classes]{#USING_CLASSES}

Genero BDL distinguishes DOM APIs and SAX APIs as follows:

The DOM API is composed of:

- The [DomDocument](ClassDomDocument.html) class, that defines the
  interface to a DOM document. Instances of this class can be used to
  identify and manipulate an XML tree. *DomNode* object manipulation
  methods are provided by this class.
- The [DomNode](ClassDomNode.html) class, that defines the interface to
  an DOM node. Instances of this class can be used to identify and
  manipulate a branch of an XML tree. Child nodes and node attributes
  management methods are provided by this class.

The SAX API is composed of:

- The [SaxAttributes](ClassSaxAttributes.html) class represents a set of
  element attributes. It is used with an
  [XmlReader](ClassXmlReader.html) or an
  [XmlWriter](ClassXmlWriter.html) object.
- The [XmlReader](ClassXmlReader.html) class, that is defined to read
  XML. The XML document processing is based on SAX events.
- The [XmlWriter](ClassXmlWriter.html) class, that is defined to write
  XML. The XML document processing is based on SAX events.
- The [SaxDocumentHandler](ClassSaxDocumentHandler.html) class, which
  provides an interface to implement a SAX driver using
  [functions](Functions.html) defined in a 4gl module loaded
  dynamically.

------------------------------------------------------------------------

## [Limitations of XML classes]{#LIMITATIONS}

The built-in XML classes are provided for convenience, to help you
manipulate XML content easily without loading a complete external XML
library such as Java XML classes or a C-based XML libraries. The
features of these built-in classes are limited to basic XML usage. For
example, there is not DTD / XML Schema validation done. In other words,
you can create the same attribute twice or set an invalid attribute
value. Therefore, you must pay attention to follow properly the
definition of the XML document when using these classes.

------------------------------------------------------------------------

## [Exception handling with XML classes]{#EXCEPTIONS}

Errors can occur while using XML classes. For example, calling methods
of a [SAX handler](ClassSaxDocumentHandler.html) in an invalid order
raises the runtime error -8004. By default the program stops. XML errors
can be trapped with the `WHENEVER ERROR` or `TRY/CATCH` [exception
handlers](Exceptions.html) of Genero, as shown in the example below. If
an error occurs during a method call of an XML class, the runtime system
sets the [STATUS variable](Programs.html#PV_STATUS).

Trapping XML classes errors:

``` linenumber
01 MAIN
02    DEFINE w om.SaxDocumentHandler
03    LET w = om.SaxDocumentHandler.createFileWriter("sample.xml")
04    TRY
05       CALL w.endDocument()
06    CATCH
07       DISPLAY "ERROR: ", STATUS
08    END TRY
09 END
```

Example of runtime errors that can be raised by XML classes:
[-8001](FglErrors.html#-8001), [-8002](FglErrors.html#-8002),
[-8003](FglErrors.html#-8003), [-8004](FglErrors.html#-8004)\...

------------------------------------------------------------------------

## [Controlling the user interface with XML classes]{#USER_INTERFACE}

The runtime system represents the user interface of a program with a DOM
tree. User interface elements can be manipulated with the built-in
classes described in this section. However, you must pay attention when
modifying directly the AUI tree: Invalid nodes or attributes creation
can lead to unpredictable results.

For more details about the user interface manipulation, see the [Dynamic
User Interface](DynamicUI.html).
