[Back to Contents](../index.html)

------------------------------------------------------------------------

# [Built-in Classes]{#PAGE_HEADER}

Summary:

- [Purpose](#PURPOSE)
- [Syntax](#SYNTAX)
- [Usage](#USAGE)
  - [base Package classes](#base)
  - [ui Package classes](#ui)
  - [om Package classes](#om)
  - [utils Package classes](#util)
  - [os Package classes](#os)
  - [Class and Object Methods](#Methods)
  - [Working with Objects](#Objects)

*See also:* [Variables](Variables.html), [Functions](Functions.html).

------------------------------------------------------------------------

### [Purpose]{#PURPOSE}

Built-in classes, grouped into packages, are predefined object templates
that are provided by the [runtime
system](FglTerms.html#RUNTIME_SYSTEM).  Each class contains methods that
interact with a specific program object, allowing you to change the
appearance or behavior of the object. The classes provide the benefits
of OOP programming in 4GL. 

------------------------------------------------------------------------

### [Syntax]{#SYNTAX}

#### Syntax 1: Defining an object

`DEFINE `*`obj`*` `*`package.classname`*` `

#### Syntax 2: Using a class method

`CALL `*`package.classname.method`*`( `*`parameter`*` `[`[,...]`]{.underline}` ) `[`[`]{.underline}`RETURNING ...`[`]`]{.underline}

`LET `*`variable`*` = `*`package.classname.method`*`( `*`parameter`*` `[`[,...]`]{.underline}` )`

#### Syntax 3: Using an object method

`CALL `*`obj.method`*`( `*`parameter`*` `[`[,...]`]{.underline}` ) `[`[`]{.underline}`RETURNING ...`[`]`]{.underline}

`LET `*`variable`*` = `*`obj.method`*`( `*`parameter`*` `[`[,...]`]{.underline}` )`

#### Notes:

1.  *obj* is the name of the variable holding a reference to the object.
2.  *package* is the name of the package the class comes from.
3.  *classname* is the name of the built-in class.
4.  *method* is the name of the method.
5.  *parameter* is a parameter for the method.

------------------------------------------------------------------------

### [Usage]{#USAGE}

#### [Package: base]{#base}

  ---------------------------------------------- ---------------------------------------------------------------
  **Classes**                                    **Purpose**
  [Application](ClassApplication.html)           Provides an interface to the application internals
  [Channel](ClassChannel.html)                   Provides basic read/write functionality (files/communication)
  [StringBuffer](ClassStringBuffer.html)         Allows manipulation of character strings
  [StringTokenizer](ClassStringTokenizer.html)   Allows parsing of strings to extract tokens
  [TypeInfo](ClassTypeInfo.html)                 Provides serialization of program variables
  ---------------------------------------------- ---------------------------------------------------------------

#### [Package: ui]{#ui}

  ---------------------------------- --------------------------------------------------------
  **Classes**                        **Purpose**
  [Interface](ClassInterface.html)   Provided to manipulate the user interface
  [Window](ClassWindow.html)         Provides an interface to the Window objects
  [Form](ClassForm.html)             Provides an interface to the forms used by the program
  [Dialog](ClassDialog.html)         Provides an interface to the interactive instructions
  [ComboBox](ClassComboBox.html)     Provides an interface to the ComboBox formfield view
  ---------------------------------- --------------------------------------------------------

#### [Package: om]{#om}

  ---------------------------------------------------- ----------------------------------------------------------------------
  **Classes**                                          **Purpose**
  [DomDocument](ClassDomDocument.html)                 Provides methods to manipulate a DOM data tree
  [DomNode](ClassDomNode.html)                         Provides methods to manipulate a node of a DOM data tree
  [NodeList](ClassNodeList.html)                       Holds a list of selected DomNode objects
  [SaxAttributes](ClassSaxAttributes.html)             Provides methods to manipulate XML element attributes
  [SaxDocumentHandler](ClassSaxDocumentHandler.html)   Provides methods to write an XML filter
  [XmlReader](ClassXmlReader.html)                     Provides methods to read and process a file written in XML  format
  [XmlWriter](ClassXmlWriter.html)                     Provides methods to write XML documents to different types of output
  ---------------------------------------------------- ----------------------------------------------------------------------

#### [Package: util]{#util}

  ---------------------------- --------------------------------------------------
  **Classes**                  **Purpose**
  [Math](Ext_util_Math.html)   Provides an interface for mathematical functions
  ---------------------------- --------------------------------------------------

The *util* package is a Dynamic C Extension library; part of the
standard package. To use the Math class, you must [import
the library](Ext_util_Math.html#BASICS) in your program:

#### [Package: os]{#os}

  -------------------------- ------------------------------------------------------------------------------------------------------
  **Classes**                **Purpose**
  [Path](Ext_os_Path.html)   Provides functions to manipulate files and directories on the machine where the BDL program executes
  -------------------------- ------------------------------------------------------------------------------------------------------

The *os* package is a Dynamic C Extension library; part of the standard
package. To use the Path class, you must [import
the library](Ext_os_Path.html#BASICS) in your program:

### [Methods]{#Methods}

There are two types of methods: *Class Methods* and *Object Methods*.
Methods can be invoked like global [functions](Functions.html), by
passing parameters and/or returning values.

***Class Methods* ** - you call these methods using the ***class
identifier*** (package name + class name) as the prefix, with a period
as the separator.


    01 CALL ui.Interface.refresh()

The method `refresh()` is a Class Method of the **Interface** class,
which is part of the **ui** package.

***Object Methods*** - To use these methods, the object must exist.
After an object has been created, you can call the Object Methods in the
class by using the **object variable** as a prefix, with a period as the
separator:

``` linenumber
01 LET b = n.getDocumentElement()
```

The method `getDocumentElement()` is an Object Method of the class to
which the *n* object belongs. 

### [Working with Objects]{#Objects}

To handle an object in your program, you

- define an object [variable](Variables.html) using the class
  identifier*.*
- instantiate the object (create it) before using it. You usually
  instantiate objects with a Class Method*.*
- once the object exists, you can call the Object methods of the
  class.  

<!-- -->


    O1 DEFINE n om.DomDocument, b DomNode
    02 LET n = om.DomDocument.create("Stock")
    03 LET b = n.getDocumentElement()

The object *n* is instantiated using the `create()` Class Method of the
DomDocument class. The object *b* is instantiated using  the
`getDocumentElement()` Object method of the DomDocument class. This
method returns the DomNode object that is the root node of the
DomDocument object *n*.

The object variable only contains the reference to the object. For
example, when passed to a function, only the reference to the object is
copied onto the stack.

You do not have to destroy objects. This is done automatically by the
runtime system for you, based on a reference counter.

``` linenumber
01 MAIN
02    DEFINE d om.DomDocument
03    LET d = om.DomDocument.create("Stock")  -- Reference counter = 1
05 END MAIN  -- d is removed, reference counter = 0 => object is destroyed.
```

You can pass object variables to functions or return them from
functions. Objects are passed ***by reference*** to functions. In the
following example, the function creates the object and returns its
reference on the stack:

``` linenumber
01 FUNCTION createStockDomDocument( )
02    DEFINE d om.DomDocument
03    LET d = om.DomDocument.create("Stock")  -- Reference counter = 1
04    RETURN d
05 END FUNCTION  -- Reference counter is still 1 because d is on the stack
```

Another part of the program can get the result of that function and pass
it as a parameter to another function.

#### Example:

``` linenumber
01 MAIN
02    DEFINE x om.DomDocument
03    LET x = createStockDomDocument( )
04    CALL writeStockDomDocument( x )
05 END MAIN
06
07 FUNCTION createStockDomDocument( )
08    DEFINE d om.DomDocument
09    LET d = om.DomDocument.create("Stock")  
10    RETURN d
11 END FUNCTION
12
13 FUNCTION writeStockDomDocument( d )
14    DEFINE d om.DomDocument
15    DEFINE r om.DomNode
16    LET r = d.getDocumentElement()
17    CALL r.writeXml("Stock.xml")
18 END FUNCTION
```

     
