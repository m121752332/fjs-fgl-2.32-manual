[Back to Contents](../index.html)

------------------------------------------------------------------------

# [The TypeInfo class]{#PAGE_HEADER}

Summary:

- [Syntax](#SYNTAX)
- [Methods](#METHODS)
- [Usage](#USAGE)
  - [Creating a TypeInfo object](#create)

See also: [Built-in classes](BuiltInClasses.html)

------------------------------------------------------------------------

### [Syntax]{#SYNTAX}

The **TypeInfo** class is a [built-in class](BuiltInClasses.html)
provided to serialize [program variables](Variables.html).

#### Syntax:

`base.TypeInfo`

#### Notes:

1.  This class does not have to be instantiated.

------------------------------------------------------------------------

### [Methods]{#METHODS}

+------------------------------------------+-------------------------------------+
| **Class Methods**                                                              |
+------------------------------------------+-------------------------------------+
| **Name**                                 | **Description**                     |
+------------------------------------------+-------------------------------------+
| [`create`](#create)`( `*`variable`*` )`\ | Creates a DOM node from a program   |
| `   ``RETURNING` `om.DomNode`            | variable                            |
+------------------------------------------+-------------------------------------+

------------------------------------------------------------------------

### [Usage]{#USAGE}

Use the TypeInfo class to serialize program variables in an XML format.
For example, you can fetch rows from a database table in an array,
specify the array as the input into the `base.TypeInfo.create()` method,
write the resulting [DomNode](ClassDomNode.html) to a file using the
`node.writeXml()` method, and give the resulting file to any application
that is able to read XML for input.

#### [Creating a TypeInfo object]{#create}

The `create()` method of this class builds a
[DomNode](ClassDomNode.html) object from any kind of structured program
variable, thus serializing the variable:

``` linenumber
01 MAIN
02   DEFINE n om.DomNode
03   DEFINE r RECORD
04       key INTEGER,
05       lastname CHAR(20),
06       birthdate DATE
07   END RECORD
08   LET r.key = 234
09   LET r.lastname = "Johnson"
10   LET r.birthdate = MDY(12,24,1962)
11   LET n = base.TypeInfo.create( r )
12   CALL n.writeXml( "r.xml" )
13 END MAIN
```

The generated node contains variable values and data type information.
The above example creates the following file:

    <?xml version="1.0"? encoding="ISO-8859-1">
    <Record>
      <Field type="INTEGER" value="234" name="key"/>
      <Field type="CHAR(20)" value="Johnson" name="lastname"/>
      <Field type="DATE" value="12/24/1962" name="birthdate"/>
    </Record>

Note that data is formatted according to current environment settings
([DBDATE](EnvironmentVariables.html#EV_DBDATE),
[DBFORMAT](EnvironmentVariables.html#EV_DBFORMAT),
[DBMONEY](EnvironmentVariables.html#EV_DBMONEY)).
