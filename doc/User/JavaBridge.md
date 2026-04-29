[Back to Contents](../index.html)

------------------------------------------------------------------------

# [The Java Interface]{#PAGE_HEADER}

Summary:

- [Purpose of the Java Interface](#PURPOSE)
- [Prerequisites and installation](#PREREQ)
- [Getting started with the Java Interface](#GETTING_STARTED)
  - [Import a Java class](#IMPORT_JAVA)
  - [Define an object reference variable](#DEFINE_OBJECT_VARIABLE)
  - [Instantiate a Java class](#INSTANTIATE_CLASS)
  - [Calling a method of a class](#CALL_CLASS_METHOD)
  - [Calling a method of an object](#CALL_OBJECT_METHOD)
- [Advanced programming](#ADVANCED_PROGRAMMING)
  - [Using JVM options](#JNI_OPTIONS)
  - [Case sensitivity with Java](#CASE_SENSITIVITY)
  - [Method overloading in Java](#METHOD_OVERLOADING)
  - [Passing Java objects in BDL](#JAVA_OBJECTS)
  - [Using the method return as an object](#METHOD_RETURN_AS_OBJECT)
  - [Ignorable return of Java methods](#IGNORABLE_RETURN_VALUE)
  - [Static fields of Java classes](#STATIC_FIELDS)
  - [Mapping BDL and Java types](#MAPPING_TYPES)
  - [Using the BDL DATE type](#FGL_DATE)
  - [Using the BDL DATETIME type](#FGL_DATETIME)
  - [Using the BDL INTERVAL type](#FGL_INTERVAL)
  - [Using the BDL DECIMAL type](#FGL_DECIMAL)
  - [Using the BDL BYTE type](#FGL_BYTE)
  - [Using the BDL TEXT type](#FGL_TEXT)
  - [Identifying Genero BDL types](#FGL_TYPE)
  - [Using BDL records](#FGL_RECORD)
  - [Formatting Genero BDL data](#FGL_FORMAT)
  - [Character set mapping](#CHARACTER_SETS)
  - [Java Arrays](#JAVA_ARRAYS)
  - [The CAST operator](#CAST_OPERATOR)
  - [The INSTANCEOF operator](#INSTANCEOF_OPERATOR)
  - [Exception handling](#EXCEPTION_HANDLING)
- [Examples](#EXAMPLES)
  - [Example 1: Using the regex package](#EXAMPLE_1)
  - [Example 2: Using the Apache POI framework](#EXAMPLE_2)

*See also:* [Variables](Variables.html), [Records](Records.html), [Data
Types](DataTypes.html), [User Types](UserTypes.html),
[Operators](Operators.html).

------------------------------------------------------------------------

### [Purpose of the Java Interface]{#PURPOSE}

Starting with Genero BDL **2.20**, you can use the **Java Interface** to
import Java classes which can be instantiated in the BDL program. With
the Java Interface, Genero BDL opens the doors to the free huge Java
libraries, as well as commercial libraries for specific purposes. The
methods of Java objects can be called with Java objects referenced in
the BDL program, as well as with native BDL typed values like
[INTEGER](DataTypes.html#DT_INTEGER),
[DECIMAL](DataTypes.html#DT_DECIMAL), [CHAR](DataTypes.html#DT_CHAR).

#### [What is not possible with the Java Interface?]{#JB_IMPOSSIBLE}

- To use generic classes of Java like *java.util.Vector\<E\>*
- To share database connections between Java and Genero BDL
- To use Java Graphical Objects in Genero BDL forms

------------------------------------------------------------------------

### [Prerequisites and installation]{#PREREQ}

#### Object-Oriented Programming

Before starting with the Java Interface, if you are not familiar with
Java and Object Oriented Programming, we strongly recommend that you
learn more about this language from the different tutorials and courses
you can find on the internet.

#### Software requirements

In order to use the Java Interface you need the following software,
installed and properly configured:

- a Java Development Kit on development sites
- a Java Runtime Environment on production sites

**Warning: The minimum required JRE version is Java 6.10.**

#### Short step-by-step procedure to set up Java:

1.  Download the latest JDK from your preferred Java provider.\
    On production sites, you only need a Java Runtime Environment (JRE).
2.  Install the package on your platform by following the vendor
    installation notes.
3.  Set the PATH environment variable to the directory containing the
    Java compiler (javac), and to the Java Virtual Machine (java).
4.  Configure your environment to let the dynamic linker find the
    libjvm.so shared library on UNIX or the JVM.DLL on Windows.\
    For example, on a Linux/Intel you add  \$JRE_HOME/lib/i386/server to
    LD_LIBRARY_PATH.
5.  Set the CLASSPATH or pass the
    `--java-option=-Djava.class.path=<pathlist>` [option to
    fglrun](#JNI_OPTIONS) with the directories of the Java packages you
    want to use.\
    **Warning: You must add FGLDIR/lib/fgl.jar to the class path in
    order to compile Java code with BDL specific classes like
    [com.fourjs.fgl.lang.FglDecimal](#FGL_DECIMAL) or
    [com.fourjs.fgl.lang.FglRecord](#FGL_RECORD).**
6.  Try your JDK by compiling a small java sample and executing it.

#### Platform-specific configuration

On some platforms like HP-UX, you must pay attention to additional
configuration settings in order to use the Java Interface. For more
details, see [Operating System Specific
Notes](Installation.html#INST_OS_SPECNOTES) in the installation guide.

------------------------------------------------------------------------

### [Getting started with the Java Interface]{#GETTING_STARTED}

------------------------------------------------------------------------

#### [Import a Java class]{#IMPORT_JAVA}

In order to use a Java class in the Genero BDL code, you must first
import the class with the [IMPORT JAVA](Programs.html#IMPORT)
instruction: 

``` linenumber
01 IMPORT JAVA java.util.regex.Pattern
```

------------------------------------------------------------------------

#### [Define an object reference variable]{#DEFINE_OBJECT_VARIABLE}

Before creating a Java object in Genero BDL, you must declare a [program
variable](Variables.html) to reference the object. The type of the
variable must be the name of the Java class, and can be fully qualified
if needed:

``` linenumber
01 DEFINE p1 Pattern
02 DEFINE p2 java.util.regex.Pattern
```

------------------------------------------------------------------------

#### [Instantiate a Java class]{#INSTANTIATE_CLASS}

In Java, you can use the *new* operator to create a new object. The
*new* operator does not exist in Genero BDL; you must use
*\<ClassName\>.create()* instead. Assign the return value of the
*create()* method to a program variable declared with the Java class
name:

``` linenumber
01 DEFINE sb StringBuffer
02 LET sb = StringBuffer.create()
```

If the Java class constructor uses parameters, you must pass the
parameters to the *create()* method:

``` linenumber
01 LET sb1 = StringBuffer.create("abcdef")   -- Uses StringBuffer(String str) constructor
02 LET sb2 = StringBuffer.create(2048)       -- Uses StringBuffer(int capacity) constructor
```

Note that you cannot use a full-qualifier class name when invoking the
*create()* method:

``` linenumber
01 LET sb = java.lang.StringBuffer.create("abcdef")   -- Raises compiler error!
```

------------------------------------------------------------------------

#### [Calling a method of a class]{#CALL_CLASS_METHOD}

You can call a class method (static method in Java) without
instantiating an object of the class. Static method invocation must be
prefixed with the class name. In the next example, the *compile()* class
method of *Pattern* class returns a new instance of a *Pattern* object: 

``` linenumber
01 DEFINE p Pattern
02 LET p = Pattern.compile("[,\\s]+")
```

Note that if you define a variable with the same name as a Java class,
you must fully qualify the class when calling static methods, as shown
in the following example:

``` linenumber
01 DEFINE Pattern Pattern
02 DEFINE Matcher Matcher
03 LET Pattern = java.util.regex.Pattern.compile("[a-z]+") -- static method, needs full qualifier
04 LET Matcher = Pattern.matcher("abcdef") -- regular instance method, Pattern resolves to variable
```

Remember also that BDL variables are case-insensitive (Pattern =
pattern).

------------------------------------------------------------------------

#### [Calling a method of an object]{#CALL_OBJECT_METHOD}

Once the class has been instantiated as an object, and the object
reference has been assigned to a variable, you can call a method of the
Java object by using the variable as the prefix:

``` linenumber
01 DEFINE m Matcher
02 ...
03 LET m = p.matcher("aaabbb")
04 DISPLAY m.matches()
```

In the above code example, the method in line #3 returns a new object of
the class *java.util.regex.Matcher* and the method in line #4 returns a
*boolean*.

------------------------------------------------------------------------

### [Advanced programming]{#ADVANCED_PROGRAMMING}

------------------------------------------------------------------------

#### [Using JVM options]{#JNI_OPTIONS}

When using the Java interface, you can instruct fglrun or fglcomp to
pass Java VM specific options during JNI initialization, by using the
` --java-option` command line argument.

In the next example, fglrun will pass `-verbose:gc` to the Java Virtual
Machine:

` $ fglrun --java-option=-verbose:gc myprog.42r`

You may want to pass the Java class path as command line option to
fglrun with `-Djava.class.path` option as in the next example:

` $ fglrun --java-option=-Djava.class.path=$FGLDIR/lib/fgl.jar:$MYCLASSPATH myprog.42r`

**Warning: Concerning class path specification, the `java` runtime or
`javac` compiler provide the `-cp` or `-classpath` options but when
loading the JVM library from fglrun or fglcomp, only `-Djava.class.path`
option is supported by the JNI interface.**

See also the [fglrun tool options](Tools.html#TL_FGLRUN).

------------------------------------------------------------------------

#### [Case sensitivity with Java]{#CASE_SENSITIVITY}

Unlike Genero BDL, the Java language is [case-sensitive]{.underline}.
Therefore, when you write the name of a Java package, class or method in
a **.4gl** source, it must match the exact name as if you were writing a
Java program. The Genero [fglcomp](Tools.html#TL_FGLCOMP) compiler takes
care of this, and writes case-sensitive class and method names in the
**.42m** pcode modules.

``` linenumber
01 IMPORT JAVA java.util.regex.Pattern
02 MAIN
03   DEFINE p java.util.regex.PATTERN   -- Note the case error
04 END MAIN
```

If you compile the above code example, fglcomp will raise error
[-6622](FglErrors.html#-6622) at line 3, complaining that the
\"java/util/PATTERN\" name cannot be found.

------------------------------------------------------------------------

#### [Method overloading in Java]{#METHOD_OVERLOADING}

The Java language allows [method overloading]{.underline}; the parameter
count and the parameter data types of a method are part of the method
identification. Thus, the same method name can be used to implement
different versions of the Java method, taking different parameters:

``` linenumber
01 DEFINE int2 SMALLINT, int4 INTEGER, flt FLOAT
02 CALL myobj.display(int2)       -- invokes method display(short) of the Java class
03 CALL myobj.display(int4)       -- invokes method display(int) of the Java class
04 CALL myobj.display(flt)        -- invokes method display(double) of the Java class
05 CALL myobj.display(int2,int4)  -- invokes method display(short,int) of the Java class
```

------------------------------------------------------------------------

#### [Passing Java objects in BDL]{#JAVA_OBJECTS}

As described in the \"[Getting started with Java
Interface](#GETTING_STARTED)\" section, Java objects must be
instantiated and referenced by a program variable. The object reference
is stored in the variable and can be passed as a parameter or returned
from a BDL function. Like [built-in class](BuiltInClasses.html) objects,
the Java objects are passed by reference. This means that the called
function does not get a clone of the object, but rather a handle to the
original object. The function can then manipulate and modify the
original object provided by the caller:

``` linenumber
01 IMPORT JAVA java.lang.StringBuffer
02 
03 MAIN
04   DEFINE x java.lang.StringBuffer
05   LET x = StringBuffer.create()
06   CALL change(x)
07   DISPLAY x.toString()
08 END MAIN
09 
10 FUNCTION change(sb)
11   DEFINE sb java.lang.StringBuffer
12   CALL sb.append("abc")
13 END FUNCTION
```

Similarly, Java object references can be returned from BDL functions:

``` linenumber
01 IMPORT JAVA java.lang.StringBuffer
02 
03 MAIN
04   DEFINE x java.lang.StringBuffer
05   LET x = build()
06   DISPLAY x.toString()
07 END MAIN
08 
09 FUNCTION build()
10   DEFINE sb java.lang.StringBuffer
11   LET sb = StringBuffer.create()   -- Creates a new object.
12   CALL sb.append("abc")
13   RETURN sb  -- Returns the reference to the object, not a copy/clone.
14 END FUNCTION
```

Like [built-in class](BuiltInClasses.html) objects, Java objects do not
need to be explicitly destroyed; as long as an object is referenced by a
variable, on the stack or in an expression, it will remain. When the
last reference to an object is removed, the object is destroyed
automatically. The next example shows how a unique object can be
referenced twice, using two variables:

``` linenumber
01 FUNCTION test()
02   DEFINE sb1, sb2 java.lang.StringBuffer   -- Declare 2 variables to reference a StringBuffer object
03   LET sb1 = StringBuffer.create()  -- Create object and assign reference to variable
04   LET sb2 = sb1    -- Same object is now referenced by 2 variables
05   CALL sb1.append("abc")  -- Object is modified through first variable
06   CALL sb2.append("def")  -- Object is modified through second variable
07   DISPLAY sb1.toString()   -- Shows content of StringBuffer object
08   DISPLAY sb2.toString()   -- Same output as previous line 
09   LET sb1 = NULL  -- Object is only referenced by second variable
10 END FUNCTION        -- sb2 removed from stack, object is no longer referenced and is destroyed.
```

------------------------------------------------------------------------

#### [Using the method return as an object]{#METHOD_RETURN_AS_OBJECT}

If a Java method returns an object, you can use the method call directly
as an object reference to call another method:

``` linenumber
01 IMPORT JAVA java.util.regex.Pattern
02 MAIN
03   DEFINE p Pattern
04   LET p = Pattern.compile("a*b")
05   IF p.matcher("aaaab").matches() THEN
06     DISPLAY "It matches..."
07   END IF
08 END MAIN
```

In line #5, the *matcher()* method of object *p* is invoked and returns
an object of type *java.util.regex.Matcher*. The object reference
returned by the *matcher()* method can be directly used to invoke a
method of the *Matcher* object (i.e. *matches()*), which returns a
*boolean*.

------------------------------------------------------------------------

#### [Ignorable return of Java methods]{#IGNORABLE_RETURN_VALUE}

Unlike Genero BDL, Java allows you to ignore the return value of a
method (as in C/C++):

`StringBuffer sb = new StringBuffer;`\
`sb.append("abc");  -- returns a new StringBuffer object but is ignored`

Genero BDL allows you to call a Java method and ignore the return value:

``` linenumber
01 IMPORT JAVA java.util.lang.StringBuffer
02 MAIN
03   DEFINE sb StringBuffer
04   LET sb = StringBuffer.create()
05   LET sb = sb.append("abc")
06   CALL sb.append("def")  -- typical usage
07 END MAIN
```

------------------------------------------------------------------------

#### [Static fields of Java classes]{#STATIC_FIELDS}

Java classes can have object and class (*static*) fields. Java *static*
class fields can be declared as *final* (read-only). It is not possible
to change the object or class fields in BDL even if the field is not
declared as *static final*; you can however read from it:

``` linenumber
01 IMPORT JAVA java.lang.Integer
02 MAIN
03   DISPLAY Integer.MAX_VALUE
04 END MAIN
```

------------------------------------------------------------------------

#### [Mapping BDL and Java types]{#MAPPING_TYPES}

Java and Genero BDL do not have the same built-in data types. Unlike
Genero BDL, Java is a strongly typed language: You cannot call a method
with a *String* if it was defined to get an *int* parameter. To call a
Java method, [Genero BDL typed values](DataTypes.html) need to be
converted to/from Java native types such as *byte*, *int*, *short*,
*char* or data objects such as *java.lang.String*. If possible, the
fglrun runtime system will do this conversion implicitly.

The [fglcomp](Tools.html#TL_FGLCOMP) compiler will raise the error
**-6606**, if the BDL data type does not match the Java (primitive)
type, using Widening Primitive Conversions. For example, passing a
DECIMAL when a Java *double* (BDL FLOAT) is expected will fail, but
passing a SMALLFLOAT (Java *float*) when a Java *double* is expected
will compile and run.

Genero has advanced proprietary data types such as
[DECIMAL](DataTypes.html#DT_DECIMAL), which do not have an equivalent
primitive type or class in Java. For such BDL types, you need to use a
specific Java class provided in the FGLDIR/lib/fgl.jar package, like
[com.fourjs.fgl.lang.FglDecimal](#FGL_DECIMAL). You can then manipulate
the BDL specific value in the Java code. For more details about these
specific types, see [\"Using the BDL DECIMAL type\"](#FGL_DECIMAL), and
similar sections.

Genero also implements structured types with [RECORDs](Records.html),
converted to [com.fourjs.fgl.lang.FglRecord](#FGL_RECORD) objects for
Java.

The [BDL static and dynamic arrays](Arrays.html) cannot be used to call
Java methods. You must use [Java Arrays](#JAVA_ARRAYS) instead.

Note that in some cases you need to explicitly cast with the new CAST()
operator. See the [section about CAST() operator](#CAST_OPERATOR) for
more details.

The following table shows the implicit conversions done by the Genero
runtime system when a Java method is called, or when a Java method
returns a value or object reference:

::: {align="center"}
+--------------------------------------------+--------------------------------------------------+
| **[Genero Data Type]{#FGL_TO_JAVA_TYPES}** | **Java Primitive Type, Standard Class or BDL     |
|                                            | Java Class**                                     |
+--------------------------------------------+--------------------------------------------------+
| [CHAR](DataTypes.html#DT_CHAR)             | java.lang.String                                 |
+--------------------------------------------+--------------------------------------------------+
| [VARCHAR](DataTypes.html#DT_VARCHAR)       | java.lang.String                                 |
+--------------------------------------------+--------------------------------------------------+
| [STRING](DataTypes.html#DT_STRING)         | java.lang.String                                 |
+--------------------------------------------+--------------------------------------------------+
| [DATE](DataTypes.html#DT_DATE)             | [com.fourjs.fgl.lang.FglDate](#FGL_DATE)         |
+--------------------------------------------+--------------------------------------------------+
| [DATETIME](DataTypes.html#DT_DATETIME)     | [com.fourjs.fgl.lang.FglDateTime](#FGL_DATETIME) |
+--------------------------------------------+--------------------------------------------------+
| [INTERVAL](DataTypes.html#DT_INTERVAL)     | [com.fourjs.fgl.lang.FglInterval](#FGL_INTERVAL) |
+--------------------------------------------+--------------------------------------------------+
| [BIGINT](DataTypes.html#DT_BIGINT)         | long (64-bit signed integer)                     |
+--------------------------------------------+--------------------------------------------------+
| [INTEGER](DataTypes.html#DT_INTEGER)       | int (32-bit signed integer)                      |
+--------------------------------------------+--------------------------------------------------+
| [SMALLINT](DataTypes.html#DT_SMALLINT)     | short (16-bit signed integer)                    |
+--------------------------------------------+--------------------------------------------------+
| [TINYINT](DataTypes.html#DT_TINYINT)       | tinyint (8-bit signed integer)                   |
+--------------------------------------------+--------------------------------------------------+
| [FLOAT](DataTypes.html#DT_FLOAT)           | double (64-bit signed floating point number)     |
+--------------------------------------------+--------------------------------------------------+
| [SMALLFLOAT](DataTypes.html#DT_SMALLFLOAT) | float (32-bit signed floating point number)      |
+--------------------------------------------+--------------------------------------------------+
| [DECIMAL](DataTypes.html#DT_DECIMAL)       | [com.fourjs.fgl.lang.FglDecimal](#FGL_DECIMAL)   |
+--------------------------------------------+--------------------------------------------------+
| [MONEY](DataTypes.html#DT_MONEY)           | [com.fourjs.fgl.lang.FglDecimal](#FGL_DECIMAL)   |
+--------------------------------------------+--------------------------------------------------+
| [BYTE](DataTypes.html#DT_BYTE)             | [com.fourjs.fgl.lang.FglByte](#FGL_BYTE)         |
+--------------------------------------------+--------------------------------------------------+
| [TEXT](DataTypes.html#DT_TEXT)             | [com.fourjs.fgl.lang.FglText](#FGL_TEXT)         |
+--------------------------------------------+--------------------------------------------------+
| [RECORD](Records.html)                     | [com.fourjs.fgl.lang.FglRecord](#FGL_RECORD)     |
+--------------------------------------------+--------------------------------------------------+
| [Java Array](#JAVA_ARRAYS)                 | Native Java Array                                |
+--------------------------------------------+--------------------------------------------------+
| **Unsupported conversions**                                                                   |
+--------------------------------------------+--------------------------------------------------+
| [Static Array](Arrays.html)                | N/A                                              |
+--------------------------------------------+--------------------------------------------------+
| [Dynamic Array](Arrays.html)               | N/A                                              |
+--------------------------------------------+--------------------------------------------------+
| [Built-in Class                            | N/A                                              |
| Object](BuiltInClasses.html)               |                                                  |
+--------------------------------------------+--------------------------------------------------+
:::

------------------------------------------------------------------------

#### [Using the BDL DATE type]{#FGL_DATE}

The [DATE](DataTypes.html#DT_DATE) data type is a time type specific to
Genero BDL. When calling a Java method with a BDL expression evaluating
a DATE, the runtime system converts the BDL value to an instance of the
**com.fourjs.fgl.lang.FglDate** class implemented in
**FGLDIR/lib/fgl.jar**. You can then manipulate the DATE from within the
Java code.

**Warning: You must add FGLDIR/lib/fgl.jar to the class path in order to
compile Java code with com.fourjs.fgl.lang.FglDate class.**

The com.fourjs.fgl.lang.FglDate class implements following: 

  ------------------------------------ -----------------------------------
  **Method**                           **Description**

  ` String toString()`                 Converts the DATE value to a String
                                       object representing the date in ISO
                                       format:\
                                        YYYY-MM-DD

  ` static void valueOf(String val)`   Creates a new FglDate object from a
                                       String object representing a date
                                       in ISO format.
  ------------------------------------ -----------------------------------

In the Java code, you can convert the com.fourjs.fgl.lang.FglDate to a
*java.util.Calendar* object as in the following example:

`public static void useDate(FglDate d) throws ParseException {`\
`    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");`\
`    Calendar cal = Calendar.getInstance();`\
`    cal.setTime( sdf.parse(d.toString()) );`\
`    ...`\
`}`

If you need to create an com.fourjs.fgl.lang.FglDate object in BDL, you
can use the valueOf() class method as in the following example:

``` linenumber
01 IMPORT JAVA com.fourjs.fgl.lang.FglDate
02 MAIN
03   DEFINE d com.fourjs.fgl.lang.FglDate
04   LET d = FglDate.valueOf("2008-12-23")
05   DISPLAY d.toString()
06 END MAIN
```

------------------------------------------------------------------------

#### [Using the BDL DATETIME type]{#FGL_DATETIME}

The [DATETIME](DataTypes.html#DT_DATETIME) data type is a time type
specific to Genero BDL. When calling a Java method with a BDL expression
evaluating a DATETIME, the runtime system converts the BDL value to an
instance of the **com.fourjs.fgl.lang.FglDateTime** class implemented in
**FGLDIR/lib/fgl.jar**. You can then manipulate the DATETIME from within
the Java code.

**Warning: You must add FGLDIR/lib/fgl.jar to the class path in order to
compile Java code with com.fourjs.fgl.lang.FglDateTime class.**

The com.fourjs.fgl.lang.FglDateTime class implements following:

  ------------------------------------- -----------------------------------
  **Field**                             **Description**

  `final static int YEAR`               Time qualifier for year

  `final static int MONTH`              Time qualifier for month

  `final static int DAY`                Time qualifier for day

  `final static int HOUR`               Time qualifier for hour

  `final static int MINUTE`             Time qualifier for minute

  `final static int SECOND`             Time qualifier for second

  `final static int FRACTION`           Time qualifier for fraction (start
                                        qualifier)

  `final static int FRACTION1`          Time qualifier for fraction(1) 
                                        (end qualifier)

  `final static int FRACTION2`          Time qualifier for fraction(2) 
                                        (end qualifier)

  `final static int FRACTION3`          Time qualifier for fraction(3) 
                                        (end qualifier)

  `final static int FRACTION4`          Time qualifier for fraction(4) 
                                        (end qualifier)

  `final static int FRACTION5`          Time qualifier for fraction(5) 
                                        (end qualifier)

  **Method**                            **Description**

  `String toString()`                   Converts the DATETIME value to a
                                        String object representing a
                                        datetime in ISO format.

  ` static void valueOf(String val)`    Creates a new FglDateTime object
                                        from a String object representing a
                                        datetime value in ISO format:\
                                          YYYY-MM-DD hh:mm:ss.fff

  ` static void valueOf(String val,`\   Creates a new FglDateTime object
  `  int startUnit, int endUnit)`       from a String object representing a
                                        datetime value in ISO format, using
                                        the qualifiers passed as parameter.

  ` static int encodeTypeQualifier(`\   Returns the encoded type qualifier
  `  int startUnit, int endUnit)`       for a datetime with to datetime
                                        qualifiers passed:\
                                          encoded qualifier = (length \*
                                        256) + (startUnit \* 16) + endUnit\
                                        Where *length* defines the total
                                        number of significant digits in
                                        this time data.\
                                        For example, with DATETIME YEAR TO
                                        MINUTE:\
                                          startUnit = YEAR\
                                          length = 12 (YYYYMMDDhhmm)\
                                          endUnit = MINUTE
  ------------------------------------- -----------------------------------

In the Java code, you can convert the com.fourjs.fgl.lang.FglDateTime to
a *java.util.Calendar* object as in the following example:

` public static void useDatetime(FglDateTime dt) throws ParseException {`\
`    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");`\
`    Calendar cal = Calendar.getInstance();`\
`    cal.setTime( sdf.parse(dt.toString()) );`\
`    ...`\
`}`

If you need to create an com.fourjs.fgl.lang.FglDateTime object in BDL,
you can use the valueOf() class method as in the following example:

``` linenumber
01 IMPORT JAVA com.fourjs.fgl.lang.FglDateTime
02 MAIN
03   DEFINE dt com.fourjs.fgl.lang.FglDateTime
04   LET dt = FglDateTime.valueOf("2008-12-23 11:22:33.123")
05   LET dt = FglDateTime.valueOf("11:22:33.123", FglDateTime.HOUR, FglDateTime.FRACTION3)
06   DISPLAY dt.toString()
07 END MAIN
```

**Warning: The valueOf() method expects a string representing a complete
datetime specification, from year to milliseconds, equivalent to a
[DATETIME YEAR TO FRACTION(3)](DataTypes.html#DT_DATETIME) data type.**

------------------------------------------------------------------------

#### [Using the BDL INTERVAL type]{#FGL_INTERVAL}

The [INTERVAL](DataTypes.html#DT_INTERVAL) data type is a time type
specific to Genero BDL. When calling a Java method with a BDL expression
evaluating an INTERVAL, the runtime system converts the BDL value to an
instance of the **com.fourjs.fgl.lang.FglInterval** class implemented in
**FGLDIR/lib/fgl.jar**. You can then manipulate the INTERVAL from within
the Java code.

**Warning: You must add FGLDIR/lib/fgl.jar to the class path in order to
compile Java code with com.fourjs.fgl.lang.FglInterval class.**

The com.fourjs.fgl.lang.FglInterval class implements following:

  ------------------------------------- -----------------------------------
  **Field**                             **Description**

  `final static int YEAR`               Time qualifier for year

  `final static int MONTH`              Time qualifier for month

  `final static int DAY`                Time qualifier for day

  `final static int HOUR`               Time qualifier for hour

  `final static int MINUTE`             Time qualifier for minute

  `final static int SECOND`             Time qualifier for second

  `final static int FRACTION`           Time qualifier for fraction (start
                                        qualifier)

  `final static int FRACTION1`          Time qualifier for fraction(1) 
                                        (end qualifier)

  `final static int FRACTION2`          Time qualifier for fraction(2) 
                                        (end qualifier)

  `final static int FRACTION3`          Time qualifier for fraction(3) 
                                        (end qualifier)

  `final static int FRACTION4`          Time qualifier for fraction(4) 
                                        (end qualifier)

  `final static int FRACTION5`          Time qualifier for fraction(5) 
                                        (end qualifier)

  **Method**                            **Description**

  `String toString()`                   Converts the INTERVAL value to a
                                        String object representing an
                                        interval in ISO format.

  ` static void valueOf(String val)`    Creates a new FglInterval object
                                        from a String object representing
                                        an interval value in ISO format:\
                                          DD hh:mm:ss.fff

  ` static void valueOf(String val,`\   Creates a new FglDateTime object
  `  int startUnit, int endUnit)`       from a String object representing
                                        an interval value in ISO format,
                                        using the qualifiers and precision
                                        passed as parameter.

  ` static int encodeTypeQualifier(`\   Returns the encoded type qualifier
  `  int startUnit, int length,`\       for an interval with to interval
  `  int endUnit))`                     qualifiers and length passed:\
                                          encoded qualifier = (length \*
                                        256) + (startUnit \* 16) + endUnit\
                                        Where *length* defines the total
                                        number of significant digits in
                                        this time data.\
                                        For example, with INTERVAL DAY(5)
                                        TO FRACTION3:\
                                          startUnit = DAY\
                                          length = 13 (DDDDhhmmssfff)\
                                          endUnit = FRACTION3
  ------------------------------------- -----------------------------------

In the Java code, you can pass a com.fourjs.fgl.lang.FglInterval object
as in the following example: 

` public static void useInterval(FglInterval inv) throws ParseException {`\
`    String s = inv.toString();`\
`    ...`\
`}`

If you need to create an com.fourjs.fgl.lang.FglInterval object in BDL,
you can use the valueOf() class method as in the following example:

``` linenumber
01 IMPORT JAVA com.fourjs.fgl.lang.FglInterval
02 MAIN
03   DEFINE inv com.fourjs.fgl.lang.FglInterval
04   LET inv = FglInterval.valueOf("-510 12:33:45.123")
05   DISPLAY inv.toString()
06 END MAIN 
```

------------------------------------------------------------------------

#### [Using the BDL DECIMAL type]{#FGL_DECIMAL}

The [DECIMAL](DataTypes.html#DT_DECIMAL) data type is a precision math
decimal type specific to Genero BDL. [MONEY](DataTypes.html#DT_MONEY) is
equivalent to [DECIMAL](DataTypes.html#DT_DECIMAL), from an internal
storage point of view. When calling a Java method with a BDL expression
evaluating a DECIMAL, the runtime system converts the BDL value to an
instance of the **com.fourjs.fgl.lang.FglDecimal** class implemented in
**FGLDIR/lib/fgl.jar**. You can then manipulate the DECIMAL from within
the Java code.

**Warning: You must add FGLDIR/lib/fgl.jar to the class path in order to
compile Java code with com.fourjs.fgl.lang.FglDecimal class.**

The com.fourjs.fgl.lang.FglDecimal class implements following:

  ------------------------------------ -----------------------------------
  **Method**                           **Description**

  `String toString()`                  Converts the DECIMAL value to a
                                       String object.

  `static void valueOf(String val)`    Creates a new FglDecimal object
                                       from a String object representing a
                                       decimal value.

  ` static void valueOf(int val)`      Creates a new FglDecimal object
                                       from an *int* value.

  `static int encodeTypeQualifier(`\   Returns the encoded type qualifier
  `  int precision, int scale)`        for this decimal according to
                                       precision and scale.\
                                       encoded qualifier = (precision \*
                                       256) + scale\
                                       Use 255 as scale for floating point
                                       decimal.
  ------------------------------------ -----------------------------------

In the Java code, you can convert the com.fourjs.fgl.lang.FglDecimal to
a *java.lang.BigDecimal* as in following example: 

` public static FglDecimal divide(FglDecimal d1, FglDecimal d2){`\
`    BigDecimal bd1 = new BigDecimal(d1.toString());`\
`    BigDecimal bd2 = new BigDecimal(d2.toString());`\
`    BigDecimal res = bd1.divide(bd2, BigDecimal.ROUND_FLOOR);`\
`    return FglDecimal.valueOf(res.toString());`\
`}`

If you need to create an com.fourjs.fgl.lang.FglDecimal object in BDL,
you can use the valueOf() class method as in the following example:

``` linenumber
01 IMPORT JAVA com.fourjs.fgl.lang.FglDecimal
02 MAIN
03   DEFINE jdec com.fourjs.fgl.lang.FglDecimal
04   LET jdec = FglDecimal.valueOf("123.45")
05   DISPLAY jdec.toString()
06 END MAIN
```

------------------------------------------------------------------------

#### [Using the BDL BYTE type]{#FGL_BYTE}

The [BYTE](DataTypes.html#DT_BYTE) data type is a Binary Large Object
(blob) handle data type specific to Genero BDL. When calling a Java
method with a BDL expression evaluating a BYTE, the runtime system
converts the BDL LOB handle to an instance of the
**com.fourjs.fgl.lang.FglByte** class implemented in
**FGLDIR/lib/fgl.jar**. You can then manipulate the LOB from within the
Java code.

**Warning: You must add FGLDIR/lib/fgl.jar to the class path in order to
compile Java code with com.fourjs.fgl.lang.FglByte class.**

The com.fourjs.fgl.lang.FglByte class implements following:

  ------------------------------------ -----------------------------------------------------------------------------------------------
  **Method**                           **Description**
  ` String toString()`                 Returns the HEX string representing the binary data.
  ` static void valueOf(String val)`   Creates a new FglByte object from a String object representing the binary data in HEX format.
  ------------------------------------ -----------------------------------------------------------------------------------------------

In the Java code, you can pass a com.fourjs.fgl.lang.FglByte object as
in the following example: 

` public static void useByte(FglByte b) throws ParseException {`\
`    String s = b.toString();`\
`    ...`\
`}`

If you need to create an com.fourjs.fgl.lang.FglByte object in BDL, you
can use the valueOf() class method as in the following example:

``` linenumber
01 IMPORT JAVA com.fourjs.fgl.lang.FglByte
02 MAIN
03   DEFINE jbyte com.fourjs.fgl.lang.FglByte
04   LET jbyte = FglByte.valueOf("0FA5617BDE")
05   DISPLAY jbyte.toString()
06 END MAIN
```

------------------------------------------------------------------------

#### [Using the BDL TEXT type]{#FGL_TEXT}

The [TEXT](DataTypes.html#DT_TEXT) data type is a Text Large Object
(tlob) handle data type specific to Genero BDL. When calling a Java
method with a BDL expression evaluating a TEXT, the runtime system
converts the BDL LOB handle to an instance of the
**com.fourjs.fgl.lang.FglText** class implemented in
**FGLDIR/lib/fgl.jar**. You can then manipulate the LOB from within the
Java code.

**Warning: You must add FGLDIR/lib/fgl.jar to the class path in order to
compile Java code with com.fourjs.fgl.lang.FglText class.**

The com.fourjs.fgl.lang.FglText class implements following:

  ------------------------------------ --------------------------------------------------
  **Method**                           **Description**
  ` String toString()`                 Converts the large text data to a simple String.
  ` static void valueOf(String val)`   Creates a new FglText object from a String.
  ------------------------------------ --------------------------------------------------

In the Java code, you can pass a com.fourjs.fgl.lang.FglText object as
in the following example: 

` public static void useByte(FglText t) throws ParseException {`\
`    String s = t.toString();`\
`    ...`\
`}`

If you need to create an com.fourjs.fgl.lang.FglText object in BDL, you
can use the valueOf() class method as in the following example:

``` linenumber
01 IMPORT JAVA com.fourjs.fgl.lang.FglText
02 MAIN
03   DEFINE jtext com.fourjs.fgl.lang.FglText
04   LET jtext = FglText.valueOf("abcdef..........")
05   DISPLAY jtext.toString()
06 END MAIN
```

------------------------------------------------------------------------

#### [Identifying Genero BDL data types]{#FGL_TYPE}

Native Java types and BDL data types are different. To identify BDL
types in java code, you can use the **com.fourjs.fgl.lang.FglTypes**
class implemented in **FGLDIR/lib/fgl.jar**. You can for example
identify the data type of a member of an [FglRecord
object](#FGL_RECORD).

**Warning: You must add FGLDIR/lib/fgl.jar to the class path in order to
compile Java code with com.fourjs.fgl.lang.FglType class.**

The com.fourjs.fgl.lang.FglTypes class implements following:

  ------------------------------- -------------------------------------------------------------------------
  **Field**                       **Description**
  `final static int BYTE`         Identifies the BDL [BYTE](DataTypes.html#DT_BYTE) data type
  `final static int CHAR`         Identifies the BDL [CHAR](DataTypes.html#DT_CHAR) data type
  `final static int DATE`         Identifies the BDL [DATE](DataTypes.html#DT_DATE) data type
  `final static int DATETIME`     Identifies the BDL [DATETIME](DataTypes.html#DT_DATETIME) data type
  `final static int DECIMAL`      Identifies the BDL [DECIMAL](DataTypes.html#DT_DECIMAL) data type
  `final static int FLOAT`        Identifies the BDL [FLOAT](DataTypes.html#DT_FLOAT) data type
  `final static int INT`          Identifies the BDL [INT](DataTypes.html#DT_INTEGER) data type
  `final static int SMALLFLOAT`   Identifies the BDL [SMALLFLOAT](DataTypes.html#DT_SMALLFLOAT) data type
  `final static int SMALLINT`     Identifies the BDL [SMALLINT](DataTypes.html#DT_SMALLINT) data type
  `final static int VARCHAR`      Identifies the BDL [VARCHAR](DataTypes.html#DT_VARCHAR) data type
  `final static int STRING`       Identifies the BDL [STRING](DataTypes.html#DT_STRING) data type
  `final static int RECORD`       Identifies a BDL [RECORD](Records.html) structure
  `final static int ARRAY`        Identifies a BDL [ARRAY](Arrays.html) object
  ------------------------------- -------------------------------------------------------------------------

------------------------------------------------------------------------

#### [Using BDL records]{#FGL_RECORD}

BDL supports structured types with the [RECORD](Records.html)
definitions. When passing a RECORD to a Java method, the runtime system
converts the RECORD to an instance of the
**com.fourjs.fgl.lang.FglRecord** class implemented in
**FGLDIR/lib/fgl.jar**. You can then manipulate the RECORD from within
the Java code.

**Warning: You must add FGLDIR/lib/fgl.jar to the class path in order to
compile Java code with com.fourjs.fgl.lang.FglRecord class.**

When assigning a [RECORD](Records.html) to a
com.fourjs.fgl.lang.FglRecord, *widening conversion* applies implicitly.
But when assigning a com.fourjs.fgl.lang.FglRecord to a RECORD,
*narrowing conversion* applies and you must explicitly
[CAST](#CAST_OPERATOR) the original object reference to the type of the
RECORD.

The com.fourjs.fgl.lang.FglRecord class implements the following: 

  ---------------------------------- -----------------------------------------------------------------------------------------
  **Method**                         **Description**
  ` int getFieldCount()`             Returns the number of record members.
  ` String getFieldName(int p)`      Returns the name of the record member at position *p*.
  `FglTypes getType(int p)`          Returns the [FglTypes](#FGL_TYPE) of the record member at position *p*.
  ` String getTypeName(int p)`       Returns the string representation of the BDL type of the record member at position *p*.
  `int getTypeQualifier(int p)`      Returns the encoded type qualifier of the record member at position *p*.
  `int getInt(int p)`                Returns the int value of the record member at position *p*.
  `int getFloat(int p)`              Returns the float value of the record member at position *p*.
  `double getDouble(int p)`          Returns the double value of the record member at position *p*.
  `String getString(int p)`          Returns the String representation of the value of the record member at position *p*.
  `FglDecimal getDecimal(int p)`     Returns the [FglDecimal](#FGL_DECIMAL) value of the record member at position *p*.
  `FglDate getDate(int p)`           Returns the [FglDate](#FGL_DATE) value of the record member at position *p*.
  `FglDateTime getDateTime(int p)`   Returns the [FglDataTime](#FGL_DATETIME) value of the record member at position *p*.
  `FglInterval getInterval(int p)`   Returns the [FglInterval](#FGL_INTERVAL) value of the record member at position *p*.
  `FglByte getByteBlob(int p)`       Returns the [FglByte](#FGL_BYTE) value of the record member at position *p*.
  `FglText getTextBlob(int p)`       Returns the [FglText](#FGL_TEXT) value of the record member at position *p*.
  ---------------------------------- -----------------------------------------------------------------------------------------

In the Java code, use the query methods of the
com.fourjs.fgl.lang.FglRecord to identify the members of the RECORD: 

` public static void showMemberTypes(FglRecord rec){`\
`    int i;`\
`    int n = rec.getFieldCount();`\
`    for (i = 1; i <= n; i++)`\
`        System.out.println( String.valueOf(i) + ":" + rec.getFieldName(i) + " / " + rec.getTypeName(i) );`\
`}`

------------------------------------------------------------------------

#### [Formatting Genero BDL data]{#FGL_FORMAT}

To format Genero BDL data types, you can use the
**com.fourjs.fgl.lang.FglFormat** class implemented in
**FGLDIR/lib/fgl.jar**.

**Warning: You must add FGLDIR/lib/fgl.jar to the class path in order to
compile Java code with com.fourjs.fgl.lang.FglFormat class.**

The com.fourjs.fgl.lang.FglFormat class provides an interface to the
data formatting functions of the Genero BDL runtime system. This class
is actually an equivalent of the [USING
operator](Operators.html#OP_USING) in the BDL language.

The com.fourjs.fgl.lang.FglFormat class implements the following: 

  -------------------------------------------------- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  **Method**                                         **Description**
  `static String format(int v, String fmt)`          Formats the INT value provided as Java int, according to fmt. Here fmt must specify a numeric format with `[$@*#&<()+-]` characters. See [USING](Operators.html#FORMAT_NUMBERS) for more details.
  `static String format(double v, String fmt)`       Formats the FLOAT value provided as Java double, according to fmt. Here fmt must specify a numeric format with `[ $ @*#&<()+-. ,]` characters. See [USING](Operators.html#FORMAT_NUMBERS) for more details.
  `static String format(FglDate v, String fmt)`      Formats the DATE value provided as [FglDate](#FGL_DATE), according to fmt. Here fmt must specify a date format with `[mdy]` characters. See [USING](Operators.html#FORMAT_DATES) for more details.
  `static String format(FglDecimal v, String fmt)`   Formats the DECIMAL value provided as [FglDecimal](#FGL_DECIMAL), according to fmt. Here fmt must specify a numeric format with `[ $ @*# $<()+-. ,]` characters. See [USING](Operators.html#FORMAT_NUMBERS) for more details.
  -------------------------------------------------- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Example of Java code using the com.fourjs.fgl.lang.FglFormat class: 

` public static void formatDecimal(FglDecimal dec){`\
`    System.out.println( FglFormat.format(dec, "$#####&.&&" );`\
`}`

------------------------------------------------------------------------

#### [Character set mapping]{#CHARACTER_SETS}

A Genero BDL application uses a locale and character set defined by the
[LANG/LC_ALL environment variables](Localization.html), while Java uses
its own charset for the *char* type (16- bit UNICODE). When passing
character strings to/from Java methods or when assigning BDL strings to
*java.lang.String*, the runtime system takes charge of character set
conversion. 

------------------------------------------------------------------------

#### [Java Arrays]{#JAVA_ARRAYS}

Java Arrays and traditional [BDL static or dynamic arrays](Arrays.html)
are different. In order to interface with Java Arrays, the BDL language
has been extended with a new kind of arrays, called [\"Java
Arrays\"](Arrays.html#JAVA_ARRAY). Java Arrays have to be created with a
given length. Like native Java arrays, the length cannot be changed
after the array is created. The Java Arrays are passed to Java methods
by reference, so the elements of the array can be manipulated in Java.
On the other hand, Java Arrays can be created in Java code and returned
to BDL. To create a Java Array in BDL you must define a
[TYPE](UserTypes.html) in order to call the
[create()](Arrays.html#JAVA_ARRAY_METHODS) type method.

The example below shows how to create a Java Array in BDL, to
instantiate a Java Array of [INTEGER](DataTypes.html#DT_INTEGER)
elements:

``` linenumber
01 MAIN
02   TYPE int_array_type ARRAY [] OF INTEGER
03   DEFINE ja int_array_type
04   LET ja = int_array_type.create(100)
05   LET ja[10] = 123
06   DISPLAY ja[10], ja[20]
07   DISPLAY ja.getLength()
08 END MAIN
```

If you want to create a Java Array of structured BDL
[RECORD](Records.html) elements, you must use the
[com.fourjs.fgl.lang.FglRecord](#FGL_RECORD) class:

``` linenumber
01 IMPORT JAVA com.fourjs.fgl.lang.FglRecord
02 MAIN
03   TYPE record_array_type ARRAY [] OF com.fourjs.fgl.lang.FglRecord
04   DEFINE ra record_array_type
05   TYPE r_t RECORD
06        id INTEGER,
07        name VARCHAR(100)
08       END RECORD
09   DEFINE r r_t
10   LET ra = record_array_type.create(100)
11   LET r.id = 123
12   LET r.name = "McFly"
13   LET ra[10] = r
14   INITIALIZE r TO NULL
15   LET r = CAST (ra[10] AS r_t)
16   DISPLAY r.*
17 END MAIN
```

You can also create Java Arrays of Java classes. The next example
introspects the *java.lang.String* class by using Java Array of
*java.lang.reflect.Method* to query the list of methods from the
*java.lang.Class* object:

``` linenumber
01 IMPORT JAVA java.lang.Class
02 IMPORT JAVA java.lang.reflect.Method
03 MAIN
04   DEFINE c java.lang.Class
05   DEFINE ma ARRAY [] OF java.lang.reflect.Method
06   DEFINE i INTEGER
07   LET c = Class.forName("java.lang.String")
08   LET ma = c.getMethods()
09   FOR i = 1 TO ma.getLength()
10      DISPLAY ma[i].toString()
11   END FOR
12 END MAIN
```

You can also create Java arrays in Java, to be returned from a Java
method and assigned to a Java Array variable in BDL:

` public static int [] createIntegerArray(int size) {`\
`    return new int[size];`\
`}`

------------------------------------------------------------------------

#### [The CAST operator]{#CAST_OPERATOR}

Important consideration has to be taken when assigning object references
to different target types or classes. A *Widening Reference Conversion*
occurs when an object reference is converted to a superclass that can
accommodate any possible reference of the original type or class. A
*Narrowing Reference Conversion* occurs when an object reference of a
superclass is converted to a subtype or subclass of the original object
reference. For example, in a vehicle class hierarchy with *Vehicle* and
*Car* classes, *Car* is a subclass that inherits from the *Vehicle*
superclass. When assigning a *Car* object reference to a *Vehicle*
variable, *Widening Reference Conversion* takes place. When assigning a
*Vehicle* object reference to a *Car* variable, *Narrowing Reference
Conversion* occurs.

In Genero BDL, as in Java, *widening conversion* does not require casts
and will not produce compilation or runtime errors, but *narrowing
conversion* needs the [CAST operator](Operators.html#OP_CAST) to convert
to the target type or class:

`CAST( `*`object_reference`*` AS `*`type_or_class`*` )`

The next example creates a *java.lang.StringBuffer* object, and assigns
the reference to a *java.lang.Object* variable (implying *Widening
Reference Conversion*); then the *Object* reference is assigned back to
the *StringBuffer* variable (implying *Narrowing Reference Conversion*
and CAST operator usage):

``` linenumber
01 IMPORT JAVA java.lang.Object
02 IMPORT JAVA java.lang.StringBuffer
03 MAIN
04   DEFINE o java.lang.Object
05   DEFINE sb java.lang.StringBuffer
06   LET sb = StringBuffer.create()
07   LET o = sb                          -- Widening Reference Conversion
08   LET sb = CAST( o AS StringBuffer )  -- Narrowing Reference Conversion needs CAST()
09 END MAIN
```

------------------------------------------------------------------------

#### [The INSTANCEOF operator]{#INSTANCEOF_OPERATOR}

When manipulating an object reference with a variable defined with a
superclass of the real class used to instantiate the object, you
sometimes need to identify the real class of the object. This is
possible with the [INSTANCEOF operator](Operators.html#OP_INSTANCEOF).
This operator checks whether the left operand is an instance of the type
or class specified by the right operand:

*`object_reference`*` INSTANCEOF `*`type_or_class`*

The example below creates a *java.lang.StringBuffer* object, assigns the
reference to a *java.lang.Object* variable, and tests whether the class
type of the object reference is a *StringBuffer*:

``` linenumber
01 IMPORT JAVA java.lang.Object
02 IMPORT JAVA java.lang.StringBuffer
03 MAIN
04   DEFINE o java.lang.Object
05   LET o = StringBuffer.create()
06   DISPLAY o INSTANCEOF StringBuffer    -- Shows 1 (TRUE)
07 END MAIN
```

------------------------------------------------------------------------

#### [Exception Handling]{#EXCEPTION_HANDLING}

BDL code can catch Java exceptions with the Genero BDL [TRY/CATCH
block](Exceptions.html#TRYCATCH).

``` linenumber
01 IMPORT JAVA java.lang.StringBuffer
02 MAIN
03   DEFINE sb java.lang.StringBuffer
04   LET sb = StringBuffer.create("abcdef")
05   TRY
06      CALL sb.deleteCharAt(50)   -- Throws StringIndexOutOfBoundsException
07   CATCH
08      DISPLAY "An exception was raised..."
09   END TRY
10 END MAIN
```

------------------------------------------------------------------------

### [Examples]{#EXAMPLES}

You will find more examples in the FGLDIR/demo/JavaInterface directory.

#### [Example 1:]{#EXAMPLE_1} Using the regex package.

``` linenumber
01 IMPORT JAVA java.util.regex.Pattern
02 IMPORT JAVA java.util.regex.Matcher
03 MAIN
04   DEFINE p Pattern
05   DEFINE m Matcher
06   LET p = Pattern.compile("[a-z]+,[a-z]+")
07   DISPLAY p.pattern()
08   LET m = p.matcher("aaa,bbb")
09   IF m.matches() THEN
10     DISPLAY "The string matches the pattern..."
11   ELSE
12     DISPLAY "The string does not match the pattern..."
13   END IF
14 END MAIN
```

#### [Example 2:]{#EXAMPLE_2} Using the Apache POI framework.

This little example shows how to create an XLS file, using the [Apache
POI framework](http://poi.apache.org). Note that you must download and
install the Apache POI JAR file and make the CLASSPATH environment
variable point to the POI JAR in order to compile and run this example.
After execution, you should find a file named \"itemlist.xls\" in the
current directory, which can be loaded with Microsoft Excel or Open
Office Calc:

``` linenumber
01 IMPORT JAVA java.io.FileOutputStream
02 IMPORT JAVA org.apache.poi.hssf.usermodel.HSSFWorkbook
03 IMPORT JAVA org.apache.poi.hssf.usermodel.HSSFSheet
04 IMPORT JAVA org.apache.poi.hssf.usermodel.HSSFRow
05 IMPORT JAVA org.apache.poi.hssf.usermodel.HSSFCell
06 IMPORT JAVA org.apache.poi.hssf.usermodel.HSSFCellStyle
07 IMPORT JAVA org.apache.poi.hssf.usermodel.HSSFFont
08 IMPORT JAVA org.apache.poi.ss.usermodel.IndexedColors
09
10 MAIN
11     DEFINE fo FileOutputStream
12     DEFINE workbook HSSFWorkbook
13     DEFINE sheet HSSFSheet
14     DEFINE row HSSFRow
15     DEFINE cell HSSFCell
16     DEFINE style HSSFCellStyle
17     DEFINE headerFont HSSFFont
18     DEFINE i, id INTEGER, s STRING
19
20     LET workbook = HSSFWorkbook.create()
21
22     LET style = workbook.createCellStyle()
23     CALL style.setAlignment(HSSFCellStyle.ALIGN_CENTER)
24     CALL style.setFillForegroundColor(IndexedColors.LIGHT_CORNFLOWER_BLUE.getIndex());
25     CALL style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
26     LET headerFont = workbook.createFont()
27     CALL headerFont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD)
28     CALL style.setFont(headerFont);
29
30     LET sheet = workbook.createSheet()
31
32     LET row = sheet.createRow(0)
33     LET cell = row.createCell(0)
34     CALL cell.setCellValue("Item Id")
35     CALL cell.setCellStyle(style)
36     LET cell = row.createCell(1)
37     CALL cell.setCellValue("Name")
38     CALL cell.setCellStyle(style)
39
40     FOR i=1 TO 10
41         LET row = sheet.createRow(i)
42         LET cell = row.createCell(0)
43         CALL cell.setCellType(HSSFCell.CELL_TYPE_NUMERIC)
44         LET id = 100 + i
45         CALL cell.setCellValue(id)
46         LET cell = row.createCell(1)
47         LET s = SFMT("Item #%1",i)
48         CALL cell.setCellValue(s)
49     END FOR
50
51     LET fo = FileOutputStream.create("itemlist.xls");
52     CALL workbook.write(fo);
53     CALL fo.close();
54
55 END MAIN
```
