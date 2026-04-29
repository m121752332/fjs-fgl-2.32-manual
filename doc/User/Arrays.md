[Back to Contents](../index.html)

------------------------------------------------------------------------

# [Arrays]{#PAGE_HEADER}

Summary:

- [Syntax](#SYNTAX)
  - [Syntax 1: Static arrays](#ARRAY)
  - [Syntax 2: Dynamic arrays](#DYNAMIC_ARRAY)
  - [Syntax 3: Java arrays](#JAVA_ARRAY)
- [Runtime Configuration for Arrays](#CONFIG)
  - [Controlling of out of bounds index error](#arrayIgnoreRangeError)
- [Usage](#USAGE)
- [Examples](#EXAMPLES)

*See also:* [Variables](Variables.html), [Records](Records.html), [Data
Types](DataTypes.html).

------------------------------------------------------------------------

### [Syntax]{#SYNTAX}

#### Purpose:

Arrays can store a one-, two- or three-dimensional array of elements.

#### Syntax 1: [Static array definition]{#ARRAY}

`DEFINE `*`variable`*` ARRAY [ `*`size`*` `[`[`]{.underline}`,`*`size`*` `[`[`]{.underline}`,`*`size`*[`]`]{.underline}` `[`]`]{.underline}` ] OF `*`datatype`*

#### Syntax 2: [Dynamic array definition]{#DYNAMIC_ARRAY}

`DEFINE `*`variable`*` DYNAMIC ARRAY `[`[`]{.underline}` WITH DIMENSION `*`rank`*` `[`]`]{.underline}` OF `*`datatype`*

#### Syntax 2: [Java array definition]{#JAVA_ARRAY}

`DEFINE `*`variable`*` ARRAY `[`[`]{.underline}` `[`]`]{.underline}` OF `*`datatype`*

#### Notes:

1.  *variable* defines the name of the array.
2.  *size* can be an [integer literal](Literals.html#LT_INTEGER) or an
    [integer constant](Constants.html). The upper limit is **65535**. 
3.  *rank* can be an [integer literal](Literals.html#LT_INTEGER) of 1,
    2, or 3. Default is 1.
4.  *datatype* can be any [data type](DataTypes.html) or a [record
    definition](Records.html).

#### [Methods of Static and Dynamic arrays:]{#FGL_ARRAY_METHODS}

+-------------------------------------+-------------------------------------+
| **Object Methods**                                                        |
+-------------------------------------+-------------------------------------+
| **Name**                            | **Description**                     |
+-------------------------------------+-------------------------------------+
| `appendElement( )`                  | Adds a new element at the end of a  |
|                                     | dynamic array. This method has no   |
|                                     | effect on a static array.           |
+-------------------------------------+-------------------------------------+
| `clear( )`                          | Removes all elements in a dynamic   |
|                                     | array. Sets all elements to NULL in |
|                                     | a static array.                     |
+-------------------------------------+-------------------------------------+
| `deleteElement( `` INTEGER`` )`     | Removes an element at the given     |
|                                     | position. In a static or dynamic    |
|                                     | array, the elements after the given |
|                                     | position are moved up. In a dynamic |
|                                     | array, the number of elements is    |
|                                     | decremented by 1.                   |
+-------------------------------------+-------------------------------------+
| `getLength( )`\                     | Returns the length of a             |
| `  ``RETURNING INTEGER`             | one-dimensional array.              |
+-------------------------------------+-------------------------------------+
| `insertElement( `` INTEGER`` )`     | Inserts a new element at the given  |
|                                     | position. In a static or dynamic    |
|                                     | array, the elements after the given |
|                                     | position are moved down. In a       |
|                                     | dynamic array, the number of        |
|                                     | elements is incremented by 1.       |
+-------------------------------------+-------------------------------------+

#### [Methods of Java arrays:]{#JAVA_ARRAY_METHODS}

The Java Array type is an interface to a real Java array type, with the
java array features. Java arrays must be instantiated before usage and
have a fixed length.

+-------------------------------------+-------------------------------------+
| **Class Methods**                                                         |
+-------------------------------------+-------------------------------------+
| **Name**                            | **Description**                     |
+-------------------------------------+-------------------------------------+
| `create(int `*`size`*`)`            | Creates a new instance of a Java    |
|                                     | array with the given size.          |
+-------------------------------------+-------------------------------------+
| **Object Methods**                                                        |
+-------------------------------------+-------------------------------------+
| **Name**                            | **Description**                     |
+-------------------------------------+-------------------------------------+
| `getLength( )`\                     | Returns the length of a             |
| `  ``RETURNING INTEGER`             | one-dimensional array.              |
+-------------------------------------+-------------------------------------+

------------------------------------------------------------------------

### [Runtime Configuration for Arrays]{#CONFIG}

#### [Controlling of out of bounds index error]{#arrayIgnoreRangeError}

By default, when an array index is out of range,
[fglrun](Tools.html#TL_FGLRUN) raises [error
-1326](FglErrors.html#-1326). Note that this is only the case for static
arrays: When using a dynamic array, new elements are allocated if the
index is greater as the actual array size.

Raising an index out of bounds error is natural for static arrays.
However, in some situations, legacy 4gl code must execute without error
and evaluate expressions using indexes that are greater as the size of
the array, especially with Boolean expressions in IF statements as in
following example:

``` linenumber
01 IF index <= max_index OR arr[index] == some_value THEN
02    ...
03 END IF
```

In the above example, since the 4GL language requires to evaluate all
parts of a Boolean expression, the runtime system must get the value of
the *arr\[index\]* element. This code was executing with Informix 4gl,
but with the default Genero behavior, it will abort with error -1326 if
the index is greater as the array size (i.e. *max_index*).

You can use an [FGLPROFILE](FglProfile.html) entry to control the
behavior of the runtime system when an array index is out of bounds for
a static array:

    `fglrun.arrayIgnoreRangeError = true`

When the above FGLPROFILE entry is set to true, the runtime system will
return the [first element of the array]{.underline} if the index is \<=0
or greater than the size of the array and continue with the normal
program flow.

Unless legacy code is relying on this behavior, you better leave the
default to get array out of bounds errors when the index is invalid.

------------------------------------------------------------------------

### [Usage]{#USAGE}

Arrays can store a one-, two- or three-dimensional array of variables,
all of the same type. These can be any of the supported [data
types](DataTypes.html) or a [record](Records.html) definition, but it
cannot be another array (`ARRAY .. OF ARRAY`).

The first syntax
(`ARRAY[`*`i`*[`[`]{.underline}`,`*`j`*[`[`]{.underline}`,`*`k`*[`]]`]{.underline}`]`)
defines traditional static arrays, which are defined with an explicit
size for all dimensions. Static arrays have a size limit. The biggest
static arrays size you can define is **65535**.

**Warning: Because of backward compatibility with Informix 4gl, all
elements of static arrays are initialized, even if the array is not
used. Therefore, it is not recommended that you define huge static
arrays, as they can use a lot of memory.**

The second syntax (`DYNAMIC ARRAY`) defines arrays with a variable size.
Dynamic arrays have no theoretical size limit. The elements of dynamic
arrays are allocated automatically by the runtime system, according to
the indexes used.

``` linenumber
01 MAIN
02   DEFINE a1 ARRAY[100] OF INTEGER -- This is a static array
03   DEFINE a2 DYNAMIC ARRAY OF INTEGER -- This is a dynamic array
04   LET a1[50] = 12456
05   LET a2[5000] = 12456  -- Automatic allocation for element 5000
06   LET a1[5000] = 12456  -- Runtime error!
07 END MAIN
```

**Warning: A dynamic array element is allocated before it is used. For
example, when you assign array element with the `LET` instruction, if
the element does not exist, it is created automatically. This is also
true when using a dynamic array in a `FOREACH` loop.**

The elements of an array variable can be of any data type except an
array definition, but an element can be a record that contains an array
member.

``` linenumber
01 MAIN
02   DEFINE arr ARRAY[50] OF RECORD
03            key INTEGER, 
04            name CHAR(10), 
05            address VARCHAR(200), 
06            contacts ARRAY[50] OF VARCHAR(20) 
07       END RECORD
08   LET arr[1].key = 12456
09   LET arr[1].name = "Scott"
10   LET arr[1].contacts[1] = "Bryan COX"
11   LET arr[1].contacts[2] = "Courtney FLOW"
12 END MAIN
```

A single array element can be referenced by specifying its coordinates
in each dimension of the array.

**Warning: For Informix 4gl compatibility, the compiler allows the .\*
notation to assign a dynamic array with a record structure to another
dynamic array with the same structure, but the behavior is not clearly
specified. Unlike simple records, the array is actually copied [by
reference]{.underline}. We strongly discourage to use the .\* notation
with dynamic arrays.**

The *dynamic arrays* can be used as function parameter (or returning
element) and will be passed [by reference]{.underline} (i.e. the dynamic
array can be modified inside the called function, and the caller will
see the modifications). You can pass a *static array* as an argument of
a function, but this is not recommended as all array members will be
copied on the stack. Note also that a *static array* cannot be returned
from a function.

In the `DEFINE` section of a [REPORT](Reports.html) statement, formal
arguments cannot be declared as arrays, nor as [record
variables](Records.html) that contain array members.

If you reference an array element in an r-value, with an index outside
the allocated dimensions, you get a **-1326** runtime error:

``` linenumber
01 MAIN
02   DEFINE a DYNAMIC ARRAY OF INTEGER
03   LET a[50] = 12456
04   DISPLAY a[100]  -- Runtime error
05 END MAIN
```

Arrays can be queried with the `getLength()` method, to get the number
of allocated elements:

``` linenumber
01 MAIN
02   DEFINE a DYNAMIC ARRAY OF INTEGER
03   LET a[5000] = 12456
04   DISPLAY a.getLength()
05 END MAIN
```

You can insert a new element at a given position with the
`insertElement()` method. The new element will be initialized to NULL.
All subsequent elements are moved down by an offset of +1. Dynamic
arrays will grow by 1, while static arrays will lose the last element:

``` linenumber
01 MAIN
02   DEFINE a DYNAMIC ARRAY OF INTEGER
03   LET a[10] = 11
04   CALL a.insertElement(10)
05   LET a[10] = 10
06   DISPLAY a.getLength() -- shows 11
07   DISPLAY a[10]  -- shows 10
08   DISPLAY a[11]  -- shows 11
09 END MAIN
```

You can append a new element at the end of a dynamic array with the
`appendElement()` method. The new element will be initialized to NULL.
Dynamic arrays will grow by 1, while static arrays will not be affected
by this method:

``` linenumber
01 MAIN
02   DEFINE a DYNAMIC ARRAY OF INTEGER
03   LET a[10] = 10
04   CALL a.appendElement()
05   LET a[a.getLength()] = a.getLength()
06   DISPLAY a.getLength() -- shows 11
07   DISPLAY a[10]  -- shows 10
08   DISPLAY a[11]  -- shows 11
09 END MAIN
```

The `deleteElement()` method can be used to remove elements from a
static or dynamic array. Subsequent elements are moved up by an offset
of -1. Dynamic arrays will shrink by 1, while static arrays will have
NULLs in the last element.

``` linenumber
01 MAIN
02   DEFINE a DYNAMIC ARRAY OF INTEGER
03   LET a[10] = 9
04   CALL a.deleteElement(5)
06   DISPLAY a.getLength() -- shows 9
07   DISPLAY a[9]  -- shows 9
08 END MAIN
```

You can clear an array with the `clear()` method. When used on a static
array, this method sets all elements to NULL. When used on a dynamic
array, it removes all elements:

``` linenumber
01 MAIN
02   DEFINE a DYNAMIC ARRAY OF INTEGER
03   LET a[10] = 11
04   DISPLAY a.getLength() -- shows 10
05   CALL a.clear()
06   DISPLAY a.getLength() -- shows 0
07 END MAIN
```

When used as a [function](Functions.html) parameter, static arrays are
passed [by value]{.underline}, while dynamic arrays are passed [by
reference]{.underline}:

``` linenumber
01 MAIN
02   DEFINE a DYNAMIC ARRAY OF INTEGER
03   CALL fill(a)
04   DISPLAY a.getLength() -- shows 2
05 END MAIN
06 FUNCTION fill(x)
07   DEFINE x DYNAMIC ARRAY OF INTEGER
08   CALL x.appendElement()
09   CALL x.appendElement()
10 END FUNCTION
```

Array methods can be used on two- and three-dimensional arrays with the
brackets notation:

``` linenumber
01 MAIN
02   DEFINE a2 DYNAMIC ARRAY WITH DIMENSION 2 OF INTEGER
03   DEFINE a3 DYNAMIC ARRAY WITH DIMENSION 3 OF INTEGER
04   LET a2[50,100]  = 12456
05   LET a2[51,1000] = 12456
06   DISPLAY a2.getLength()         -- shows 51
07   DISPLAY a2[50].getLength()     -- shows 100
08   DISPLAY a2[51].getLength()     -- shows 1000
09   LET a3[50,100,100]  = 12456
10   LET a3[51,101,1000] = 12456
11   DISPLAY a3.getLength()         -- shows 51
12   DISPLAY a3[50].getLength()     -- shows 100
13   DISPLAY a3[51].getLength()     -- shows 101
14   DISPLAY a3[50,100].getLength() -- shows 100
15   DISPLAY a3[51,101].getLength() -- shows 1000
16   CALL a3[50].insertElement(10)  -- inserts at 50,10
17   CALL a3[50,10].insertElement(1)-- inserts at 50,10,1
18 END MAIN
```

------------------------------------------------------------------------

### [Examples]{#EXAMPLES}

#### Example 1: Using static and dynamic arrays.

``` linenumber
01 MAIN
02   DEFINE a1 DYNAMIC ARRAY OF INTEGER
03   DEFINE a2 DYNAMIC ARRAY WITH DIMENSION 2 OF INTEGER
04   DEFINE a3 ARRAY[10,20] OF RECORD
05               id INTEGER,
06               name VARCHAR(100),
07               birth DATE
08            END RECORD
09   LET a1[5000] = 12456
10   LET a2[5000,300] = 12456
11   LET a3[5,1].id = a1[50]
12   LET a3[5,1].name = 'Scott'
13   LET a3[5,1].birth = TODAY
14 END MAIN
```

#### Example 2: Here is the recommended way to fetch rows into a dynamic array.

``` linenumber
01 SCHEMA stores
02 MAIN
03   DEFINE a DYNAMIC ARRAY OF RECORD LIKE customer.*
04   DEFINE r RECORD LIKE customer.*
05   DATABASE stores
06   DECLARE c CURSOR FOR SELECT * FROM customer
07   FOREACH c INTO r.*
08     CALL a.appendElement()
09     LET a[a.getLength()].* = r.*
10   END FOREACH
11   DISPLAY "Rows found: ", a.getLength()
12 END MAIN
```
