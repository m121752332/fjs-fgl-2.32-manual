[Back to Contents](../index.html)

------------------------------------------------------------------------

# [The StringBuffer class]{#PAGE_HEADER}

Summary:

- [Syntax](#SYNTAX)
- [Methods](#METHODS)
- [Usage](#USAGE)
  - [StringBuffer Objects vs. STRING variables](#Difference_from_STRING)
  - [Create a StringBuffer object](#create)
  - [Append a string](#append)
  - [Clear the string buffer](#clear)
  - [Compare strings](#Compare_strings)
  - [Return the character at a specified position](#getCharAt)
  - [Return the position of a substring](#getIndexOf)
  - [Return the length of a string](#getLength)
  - [Return the substring at the specified position](#subString)
  - [Convert case of the string](#Convert_case)
  - [Trim the string](#Trim_the_string)
  - [Replace part of the current string with another string](#replaceAt)
  - [Replace one string with another](#replace)
  - [Insert a string](#insertAt)
  - [Convert buffer to a STRING value](#toString)
- [Examples](#EXAMPLES)

See also: [Built-in classes](BuiltInClasses.html)

------------------------------------------------------------------------

### [Syntax]{#SYNTAX}

The **StringBuffer** class is a [built-in class](BuiltInClasses.html)
designed to manipulate character strings. The StringBuffer class is
optimized for string operations.

#### Syntax:

`base.StringBuffer`

------------------------------------------------------------------------

### [Methods:]{#METHODS}

+----------------------------------------------------------------------------------------+-------------------------------------+
| **Class Methods**                                                                                                            |
+----------------------------------------------------------------------------------------+-------------------------------------+
| **Name**                                                                               | **Description**                     |
+----------------------------------------------------------------------------------------+-------------------------------------+
| [`create`](#create)`( )`\                                                              | Creates a new empty StringBuffer    |
| `  ``RETURNING ``base.StringBuffer`                                                    | object.                             |
+----------------------------------------------------------------------------------------+-------------------------------------+
| **Object Methods**                                                                                                           |
+----------------------------------------------------------------------------------------+-------------------------------------+
| **Name**                                                                               | **Description**                     |
+----------------------------------------------------------------------------------------+-------------------------------------+
| [`append`](#append)`( str ``STRING`` ) `                                               | Appends a string to the string      |
|                                                                                        | buffer.                             |
+----------------------------------------------------------------------------------------+-------------------------------------+
| [`clear`](#clear)`( )`                                                                 | Clears the string buffer.           |
+----------------------------------------------------------------------------------------+-------------------------------------+
| [`equals`](#equals)`( src ``STRING`` )`\                                               | Returns                             |
| `  ``RETURNING INTEGER`                                                                | [TRUE](Programs.html#PC_TRUE) if    |
|                                                                                        | the string passed as parameter      |
|                                                                                        | matches the current string. If one  |
|                                                                                        | of the strings is                   |
|                                                                                        | [NULL](Programs.html#PC_NULL) the   |
|                                                                                        | method returns                      |
|                                                                                        | [FALSE](Programs.html#PC_FALSE).    |
+----------------------------------------------------------------------------------------+-------------------------------------+
| [`equalsIgnoreCase`](#equalsIgnoreCase)`( src ``STRING`` )`\                           | Returns                             |
| `  ``RETURNING INTEGER`                                                                | [TRUE](Programs.html#PC_NULL) if    |
|                                                                                        | the string passed as parameter      |
|                                                                                        | matches the current string,         |
|                                                                                        | [ignoring character                 |
|                                                                                        | case]{.underline}. If one of the    |
|                                                                                        | strings is                          |
|                                                                                        | [NULL](Programs.html#PC_NULL) the   |
|                                                                                        | method returns                      |
|                                                                                        | [FALSE](Programs.html#PC_FALSE).    |
+----------------------------------------------------------------------------------------+-------------------------------------+
| [`getCharAt(`](#getCharAt)` pos ``INTEGER`` )`\                                        | Returns the character at the byte   |
| `  ``RETURNING STRING`                                                                 | position *pos* (starts at 1).       |
|                                                                                        | Returns                             |
|                                                                                        | [NULL](Programs.html#PC_NULL) if    |
|                                                                                        | the position does not match a valid |
|                                                                                        | character-byte position in the      |
|                                                                                        | current string.                     |
+----------------------------------------------------------------------------------------+-------------------------------------+
| [`getIndexOf`](#getIndexOf)`( str ``STRING``, spos ``INTEGER`` )`\                     | Returns the position of the         |
| `  ``RETURNING INTEGER`                                                                | sub-string *str* in the current     |
|                                                                                        | string, starting from byte position |
|                                                                                        | *spos*. Returns zero if the         |
|                                                                                        | sub-string was not found.           |
+----------------------------------------------------------------------------------------+-------------------------------------+
| [`getLength`](#getLength)`( )`\                                                        | Returns the number of               |
| `  ``RETURNING INTEGER`                                                                | [bytes]{.underline} of the current  |
|                                                                                        | string, including trailing spaces.  |
+----------------------------------------------------------------------------------------+-------------------------------------+
| [`subString`](#subString)`( spos ``INTEGER``, epos ``INTEGER`` )`\                     | Returns the sub-string starting at  |
| `  ``RETURNING STRING`                                                                 | the byte position *spos* and ending |
|                                                                                        | at *epos*. Returns                  |
|                                                                                        | [NULL](Programs.html#PC_NULL) if    |
|                                                                                        | the positions do not delimit a      |
|                                                                                        | valid sub-string in the current     |
|                                                                                        | string. First character-byte starts |
|                                                                                        | at 1.                               |
+----------------------------------------------------------------------------------------+-------------------------------------+
| [`toLowerCase`](#toLowerCase)`( ) `                                                    | Converts the current string to      |
|                                                                                        | lowercase.                          |
+----------------------------------------------------------------------------------------+-------------------------------------+
| [`toUpperCase`](#toUpperCase)`( ) `                                                    | Converts the current string to      |
|                                                                                        | uppercase.                          |
+----------------------------------------------------------------------------------------+-------------------------------------+
| [`trim`](#trim)`( ) `                                                                  | Removes white space characters from |
|                                                                                        | the beginning and end of the        |
|                                                                                        | current string.                     |
+----------------------------------------------------------------------------------------+-------------------------------------+
| [`trimLeft`](#trimLeft)`( ) `                                                          | Removes white space characters from |
|                                                                                        | the beginning of the current        |
|                                                                                        | string.                             |
+----------------------------------------------------------------------------------------+-------------------------------------+
| [`trimRight`](#trimRight)`( ) `                                                        | Removes white space characters from |
|                                                                                        | the end of the current string.      |
+----------------------------------------------------------------------------------------+-------------------------------------+
| [`replaceAt`](#replaceAt)`( pos ``INTEGER``, len ``INTEGER``, str ``STRING ``) `       | Replaces a part of the current      |
|                                                                                        | string by another string, starting  |
|                                                                                        | from byte position *pos* for *len*  |
|                                                                                        | bytes.  First character-byte        |
|                                                                                        | position is 1.                      |
+----------------------------------------------------------------------------------------+-------------------------------------+
| [`replace`](#replace)`( oldString ``STRING``, newString ``STRING``, occ ``INTEGER ``)` | Replaces in the current string the  |
|                                                                                        | [STRING](DataTypes.html#DT_STRING)  |
|                                                                                        | *oldString* by the                  |
|                                                                                        | [STRING](DataTypes.html#DT_STRING)  |
|                                                                                        | *newString*, *occ* time(s) (all     |
|                                                                                        | occurrences, if *occ* set to 0).    |
+----------------------------------------------------------------------------------------+-------------------------------------+
| [`insertAt`](#insertAt)`( pos ``INTEGER``, str ``STRING`` )`                           | Inserts a string before the byte    |
|                                                                                        | position *pos*. First               |
|                                                                                        | character-byte position is 1.       |
+----------------------------------------------------------------------------------------+-------------------------------------+
| [`toString`](#toString)`( ) ``RETURNING STRING`                                        | Creates a                           |
|                                                                                        | [STRING](DataTypes.html#DT_STRING)  |
|                                                                                        | value from the current buffer.      |
+----------------------------------------------------------------------------------------+-------------------------------------+

------------------------------------------------------------------------

### [Usage:]{#USAGE}

#### [StringBuffer objects vs. STRING variables]{#Difference_from_STRING}

Use the StringBuffer class instead of [STRING](DataTypes.html#DT_STRING)
variables to implement heavy string manipulations. When you use a
StringBuffer object, you work directly on the internal string buffer. In
contrast, when you use the` STRING` data type, the runtime system always
creates a new buffer when you modify a string. This does not impact the
performance of programs with a user interface or even batch programs
doing SQL, but it can be an issue when you want to rapidly process large
character strings. For example, if you need to process 500Kb of text
(such as when you are performing a global search-and-replace of specific
words), you get much better performance with a StringBuffer object than
you would using a basic `STRING` variable. 

When you pass a StringBuffer object as a function parameter, the
function receives a variable that references the StringBuffer object.
Passing the StringBuffer object by reference is much more efficient than
using a `STRING` that is passed by value (i.e., data is copied on the
stack), since the function manipulates the original string, not a copy
of the string. 

**Warning: The StringBuffer methods are all based on
byte-length-semantics. In a multi-byte environment, the getLength()
method returns the number of bytes, which can be different from the
number of characters.**

A StringBuffer object has different uses than a `STRING` variable, as
illustrated in the methods listed below:

#### [Create a StringBuffer object]{#create}

Use the  `base.StringBuffer.create()` class method to create a new
StringBuffer object. 

``` linenumber
01 DEFINE buf base.StringBuffer
02 LET buf = base.StringBuffer.create()
```

#### [Append a string]{#append}

The ` append()` method appends a string to the internal string buffer.
This differs from the `append()` method of a `STRING` variable, which
uses a new buffer to hold the new string. The following example adds a
string to the end of the existing string buffer. Since this is a newly
created StringBuffer object, the length of its string buffer is
zero. After appending the string \"abc\" in the example below, the
length of the string buffer is 3. See the [getLength](#getLength)
method.

``` linenumber
01 LET buf = base.StringBuffer.create()
02 CALL buf.append("abc")
```

#### [Clear the string buffer]{#clear}

Use the `clear() ` method  to clear the string buffer. When the buffer
is cleared, the buffer length is zero:

``` linenumber
01 CALL buf.clear()
```

#### [Compare strings]{#Compare_strings}

Use the [`equals()`]{#equals} method to determine whether the value of a
StringBuffer object is identical to a specified string, including case. 
Since the parameter for the method must be a string, you can use the
[toString()](#toString) method to convert a StringBuffer object in order
to compare it. This method returns [TRUE](Programs.html#PC_TRUE) if the
strings are identical, otherwise it returns
[FALSE](Programs.html#PC_FALSE).

``` linenumber
01 DEFINE buf, buf2 base.StringBuffer,
02        mystring STRING    
03 LET buf = base.StringBuffer.create()
04 CALL buf.append("there")
05 IF buf.equals("there") THEN
06   DISPLAY "buf matches there"
07 END IF
08
09 --comparing to a STRING variable 
10 LET mystring = "there"
11 IF buf.equals(mystring) THEN
12    DISPLAY "buf matches mystring"
13 END IF
14
15 --comparing to another StringBuffer object
16 LET buf2 = base.StringBuffer.create()
17 CALL buf2.append("there")
18 IF buf.equals(buf2.toString()) THEN
19   DISPLAY "buf matches buf2"
20 END IF
```

The output of the example is:

buf matches there\
buf matches mystring\
buf matches buf2

**To ignore case** in the comparison of the value of a StringBuffer
object and a string, use the [`equalsIgnoreCase()`]{#equalsIgnoreCase}
method. The parameter for the function must be a string. This method
returns [TRUE](Programs.html#PC_TRUE) if the strings are identical,
otherwise it returns [FALSE](Programs.html#PC_FALSE).

``` linenumber
01 DEFINE buf3 base.StringBuffer
02 LET buf3 = base.StringBuffer.create()
03 CALL buf3.append("there")
04 IF buf3.equalsIgnoreCase("There") THEN
05   DISPLAY "buf matches There ignoring case"
06 END IF
```

The output of the example is:

buf matches There ignoring case

#### [Return the character at a specified position]{#getCharAt}

The `getCharAt( )` method returns the character that is in the string
buffer at the position that you specify. The first position is 1.
[NULL](Programs.html#PC_NULL) is returned if the position does not
exist. The following example returns the character in the third position
in the string buffer:

``` linenumber
01 DEFINE buf base.StringBuffer
03 LET buf = base.StringBuffer.create()
04 CALL buf.append("abcdef")
05 DISPLAY buf.getCharAt(3)
```

The output of this code is the character at position 3 in the string:

c

**Warning: The StringBuffer methods are all based on
byte-length-semantics. In a multi-byte environment, the getCharAt()
method takes a byte position as parameter, not a character position. If
you pass an invalid multi-byte position, the method returns a blank.**

#### [Return the position of a substring]{#getIndexOf}

You can return the position of a substring in the string buffer, using
the `getIndexOf()` method. Specify the substring and an integer
specifying the position at which the search should begin.  Use 1 if you
want to start at the beginning of the string buffer. This method returns
zero if the substring does not exist.

``` linenumber
01 DEFINE pos INTEGER
02 CALL buf.append("abcdefg")
03 LET pos = buf.getIndexof("def",1)
04 DISPLAY "position of def", pos
```

The output of this example is an integer representing the position of
the substring.

position of def    4

**Warning: The StringBuffer methods are all based on
byte-length-semantics. In a multi-byte environment, the getIndexOf()
method returns the byte position, not the character position.**

The next example iterates through the whole string to display the
position of multiple occurrences of the same sub-string:

``` linenumber
01 MAIN
02     DEFINE b base.StringBuffer
03     DEFINE pos INT
04     DEFINE s STRING
05     LET b = base.StringBuffer.create()
06     CALL b.append("---abc-----abc--abc----")
07     LET pos = 1
08     LET s = "abc"
09     WHILE TRUE
10         LET pos = b.getIndexOf(s,pos)
11         IF pos == 0 THEN EXIT WHILE END IF
12         DISPLAY "Pos: ", pos
13         LET pos = pos + LENGTH(s)
14     END WHILE
15 END MAIN
```

#### [Return the length of a string]{#getLength}

Use the `getLength() `method to return the number of bytes in the
current string buffer, including trailing spaces. In a multi-byte
environment, this can be different than the number of characters. The
length of an empty string buffer is 0.

``` linenumber
01 DEFINE len INTEGER
02 CALL buf.append("abcdefg")
03 LET len = buf.getLength()
04 DISPLAY "length ", len
05 -- append three spaces to the end of the string
06 CALL buf.append("   ") 
07 DISPLAY "new length ", len
```

The output of this example is:

length is     7\
new length     10

**Warning: The StringBuffer methods are all based on
byte-length-semantics. In a multi-byte environment, the getLength()
method returns the number of bytes, not the number of characters.**

#### [Return the substring at the specified position]{#subString}

The `subString()` method returns the substring that you specify with
integers indicating the beginning and ending position within the string
buffer.  NULL is returned if the positions are not valid.

``` linenumber
01 DEFINE partstring STRING
02 CALL buf.append("abcdefg")
03 LET partstring = buf.subString(2,5)
04 DISPLAY partstring
```

The output of the example is the substring beginning at position 2 and
ending with position 5:

bcde

**Warning: The StringBuffer methods are all based on
byte-length-semantics. In a multi-byte environment, the subString()
method takes byte positions as parameter, not character positions. If
you pass invalid multi-byte positions, the method returns blanks.**

#### [Convert case of  the string]{#Convert_case}

These methods convert the case of the current string in the internal
string buffer. The examples use the [toString](#toString) method to
display the contents of the string buffer.

The [`toLowerCase()`]{#toLowerCase} method converts the current string
to **lowercase**.

``` linenumber
01 CALL buf.append("Test")
02 CALL buf.toLowerCase()
03 DISPLAY buf.toString()
```

The output of the example is:

test

The [`toUpperCase()`]{#toUpperCase} method converts the current string
to **uppercase**.

``` linenumber
01 CALL buf.append("Test")
02 CALL buf.toUpperCase()
03 DISPLAY buf.toString()
```

The output is:

TEST

#### [Trim the string]{#Trim_the_string}

These methods remove white space from the current string in the internal
string buffer. The examples use the [toString](#toString) method to
display the current string.

The

[trim()]{#trim} method removes white space from the beginning and end of
the current string.

``` linenumber
01 CALL buf.append("   A likely story   ")
02 CALL buf.trim()
03 DISPLAY buf.toString()
```

The output has no beginning or trailing spaces:

A likely story

The [`trimLeft()`]{#trimLeft} method removes white space from the
beginning of the current string.

``` linenumber
01 CALL buf.append("   A likely story   ")
02 CALL buf.trimleft()
03 DISPLAY buf.toString()
```

The output has no beginning spaces:

A likely story

The [`trimRight()`]{#trimRight} method removes white space from the end
of the current string.

``` linenumber
01 CALL buf.append("   A likely story   ")
02 CALL buf.trimright()
03 DISPLAY buf.toString()
```

The output has no trailing spaces:

    A likely story

#### [Replace part of a string with another string]{#replaceAt}

The `replaceAt()` method replaces part of the current string in the
internal string buffer with another string. The parameters are integers
indicating the position at which the replacement should start and the
number of bytes to be replaced,  and the replacement string. The first
position in the string is 1.

``` linenumber
01 CALL buf.append("abcdefg")
02 CALL buf.replaceAt(4, 3, "12345")
03 DISPLAY buf.toString()
```

The output of the example shows that the replacement began at position
four, replacing three of the bytes in the current string buffer with the
new string.

abc12345g

**Warning: The StringBuffer methods are all based on
byte-length-semantics. In a multi-byte environment, the replaceAt()
method takes byte positions as parameter, not character positions. If
you pass invalid multi-byte positions, the method does not change the
original string.**

#### [Replace one string with another]{#replace}

The `replace()`  method replaces a string within the current string
buffer with a different string. Specify the original string, replacement
string, and the number of occurrences that should be replaced, using 0
to replace all occurrences.

``` linenumber
01 CALL buf.append("abcabcabcde")
02 CALL buf.replace("ab", "xxx", 2)
03 DISPLAY buf.toString()
```

The output of this example shows that the string \"ab\" was replaced
with \"xxx\" two times.

xxxcxxxcabcde

**Note**: To completely replace the contents of the string buffer,
whatever they might be,  with a new string, first [clear](#clear) the
buffer; then, [append](#append) the new string.

#### [Insert a string]{#insertAt}

The `insertAt()` method inserts a string before the specified position
in the string buffer.

``` linenumber
01 CALL buf.append("abcabcabcde")
02 CALL buf.insertAt(4, "xxxxx")
03 DISPLAY buf.toString()
```

The output of the example shows that the new string was inserted at
position 4.

abcxxxxxabcabcde

**Warning: The StringBuffer methods are all based on
byte-length-semantics. In a multi-byte environment, the insertAt()
method takes a byte position as first parameter, not a character
position. If you pass an invalid multi-byte position, the resulting
string might be invalid in the current code set.**

#### [Convert buffer to a STRING value]{#toString}

The `toString()` method creates a STRING value from the current string
buffer. This method is frequently used to display the contents of the
string buffer, or to store the contents as a STRING data type.

``` linenumber
01 DEFINE mystring STRING
02 CALL buf.append("abcdefg")
03 LET mystring = buf.toString()
04 DISPLAY mystring
```

The output of the example is:

abcdefg

------------------------------------------------------------------------

### [Examples]{#EXAMPLES}

#### [Example 1]{#EXAMPLE1}: Adding strings to a StringBuffer

``` linenumber
01 MAIN
02   DEFINE buf base.StringBuffer
03   LET buf = base.StringBuffer.create()
04   CALL buf.append("abc")
05   DISPLAY buf.toString()
06   CALL buf.append("def")
07   DISPLAY buf.toString()
08   CALL buf.append(123456)
09   DISPLAY buf.toString()
10 END MAIN
```

Output:

abc\
abcdef\
abcdef123456

#### [Example 2]{#EXAMPLE2}: Modifying a StringBuffer with a function

In the following example, **buf**, which is a reference to a
StringBuffer object, is passed to the function **modify** (StringBuffer
objects are passed *by reference*.) In this function, the StringBuffer
object, now having a pointer of **sb**, has the string \"more\" appended
to its internal string buffer.  Whether you use the reference **sb**, or
the reference **buf**, you are referring to the same StringBuffer
object:

``` linenumber
01 MAIN
02   DEFINE buf base.StringBuffer
03   LET buf = base.StringBuffer.create()
04   CALL modify(buf)
05   DISPLAY "buf is ", buf.toString()
06 END MAIN
07
08 FUNCTION modify(sb)
09   DEFINE sb base.StringBuffer
10   CALL sb.append("more")
11   DISPLAY "sb is ", sb.toString()
12 END FUNCTION
```

Output:

sb is more\
buf is more\
 
