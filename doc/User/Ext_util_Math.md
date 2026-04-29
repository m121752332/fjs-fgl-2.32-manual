[Back to Contents](../index.html)

------------------------------------------------------------------------

# [Mathematical functions Class]{#PAGE_HEADER}

Summary:

- [Basics](#BASICS)
- [Syntax](#SYNTAX)
- [Methods](#METHODS)

*See also:* [Built-in Functions](BuiltInFunctions.html)

------------------------------------------------------------------------

### [Basics]{#BASICS}

The Math class provides mathematical functions.

This API is provided as a [Dynamic C Extension](CExtensions.html)
library; it is part of the standard package.

To use this extension, you must import the **util** package in your
program:

    IMPORT util

------------------------------------------------------------------------

### [Syntax]{#SYNTAX}

The **Math** class is a provides an interface for mathematical
functions.

#### Syntax:

`util.Math`

#### Notes:

1.  This class does not have to be instantiated; it provides class
    methods for the current program.

------------------------------------------------------------------------

### [Methods:]{#METHODS}

+------------------------------+---------------------------------------+
| **Class Methods**                                                    |
+------------------------------+---------------------------------------+
| **Name**                     | **Description**                       |
+------------------------------+---------------------------------------+
| [sqrt](#MATH_SQRT)           | This function computes the square     |
|                              | root of its argument.                 |
+------------------------------+---------------------------------------+
| [pow](#MATH_POW)             | This function computes the value of x |
|                              | raised to the power y.                |
+------------------------------+---------------------------------------+
| [exp](#MATH_EXP)             | This function computes the base- e    |
|                              | exponential of x.                     |
+------------------------------+---------------------------------------+
| [srand](#MATH_SRAND)         | This function intializes the          |
|                              | pseudo-random number generator.       |
+------------------------------+---------------------------------------+
| [rand](#MATH_RAND)           | This function returns a pseudo-random |
|                              | number.                               |
+------------------------------+---------------------------------------+
| [sin](#MATH_SIN)             | This function computes the sine of    |
|                              | their argument x, measured in         |
|                              | radians.                              |
+------------------------------+---------------------------------------+
| [cos](#MATH_COS)             | This function computes the cosine of  |
|                              | their argument x, measured in         |
|                              | radians.                              |
+------------------------------+---------------------------------------+
| [tan](#MATH_TAN)             | This function computes the tangent of |
|                              | their argument x, measured in         |
|                              | radians.                              |
+------------------------------+---------------------------------------+
| [asin](#MATH_ASIN)           | This function computes the arc sine   |
|                              | of their argument x, measured in      |
|                              | radians.                              |
+------------------------------+---------------------------------------+
| [acos](#MATH_ACOS)           | This function computes the arc cosine |
|                              | of their argument x, measured in      |
|                              | radians.                              |
+------------------------------+---------------------------------------+
| [atan](#MATH_ATAN)           | This function computes the arc        |
|                              | tangent of their argument x, measured |
|                              | in radians.                           |
+------------------------------+---------------------------------------+
| [log](#MATH_LOG)             | This function computes the natural    |
|                              | logarithm of the argument x.          |
+------------------------------+---------------------------------------+
| [toDegrees](#MATH_TODEGREES) | Converts an angle measured in radians |
|                              | to an equivalent angle measured in    |
|                              | degrees.                              |
+------------------------------+---------------------------------------+
| [toRadians](#MATH_TORADIANS) | Converts an angle measured in degrees |
|                              | to an equivalent angle measured in    |
|                              | radians.                              |
+------------------------------+---------------------------------------+
| [pi](#MATH_PI)               | This function returns the FLOAT value |
|                              | of PI.                                |
+------------------------------+---------------------------------------+

------------------------------------------------------------------------

### [util.Math.sqrt]{#MATH_SQRT}

#### Purpose:

Returns the square root of the argument provided.

#### Syntax:

`CALL util.Math.sqrt(FLOAT f) RETURNING `*`rv`*` FLOAT`

#### Notes:

1.  Returns NULL if the argument provided is invalid.

------------------------------------------------------------------------

### [util.Math.pow]{#MATH_POW}

#### Purpose:

This function computes the value of x raised to the power y.

#### Syntax:

`CALL util.Math.pow(FLOAT x, FLOAT y) RETURNING `*`rv`*` FLOAT`

#### Notes:

1.  Returns NULL if one of the argument provided is invalid.
2.  If x is negative, the caller should ensure that y is an integer
    value.

------------------------------------------------------------------------

### [util.Math.exp]{#MATH_EXP}

#### Purpose:

This function computes the base- e exponential of x.

#### Syntax:

`CALL util.Math.exp(FLOAT x) RETURNING `*`rv`*` FLOAT`

#### Notes:

1.  Returns NULL if the argument provided on error.

------------------------------------------------------------------------

### [util.Math.srand]{#MATH_SRAND}

#### Purpose:

This function initializes the pseudo-random numbers generator.

#### Syntax:

`CALL util.Math.srand()`

------------------------------------------------------------------------

### [util.Math.rand]{#MATH_RAND}

#### Purpose:

This function returns a pseudo-random number between 0 and x

#### Syntax:

`CALL util.Math.rand(x INTEGER) RETURNING `*`rv`*` INTEGER`

------------------------------------------------------------------------

### [util.Math.sin]{#MATH_SIN}

#### Purpose:

This function computes the sine of the argument x, measured in radians.

#### Syntax:

`CALL util.Math.sin(FLOAT f) RETURNING `*`rv`*` FLOAT`

#### Notes:

1.  Returns NULL if the argument provided is invalid.

------------------------------------------------------------------------

### [util.Math.cos]{#MATH_COS}

#### Purpose:

This function computes the cosine of the argument x, measured in
radians.

#### Syntax:

`CALL util.Math.cos(FLOAT f) RETURNING `*`rv`*` FLOAT`

#### Notes:

1.  Returns NULL if the argument provided is invalid.

------------------------------------------------------------------------

### [util.Math.tan]{#MATH_TAN}

#### Purpose:

This function computes the tangent of the argument x, measured in
radians.

#### Syntax:

`CALL util.Math.tan(FLOAT f) RETURNING `*`rv`*` FLOAT`

#### Notes:

1.  Returns NULL if the argument provided is invalid.

------------------------------------------------------------------------

### [util.Math.asin]{#MATH_ASIN}

#### Purpose:

This function computes the arc sine of the argument x, measured in
radians.

#### Syntax:

`CALL util.Math.asin(FLOAT f) RETURNING `*`rv`*` FLOAT`

#### Notes:

1.  Returns NULL if the argument provided is invalid.

------------------------------------------------------------------------

### [util.Math.acos]{#MATH_ACOS}

#### Purpose:

This function computes the arc cosine of the argument x, measured in
radians.

#### Syntax:

`CALL util.Math.acos(FLOAT f) RETURNING `*`rv`*` FLOAT`

#### Notes:

1.  Returns NULL if the argument provided is invalid.

------------------------------------------------------------------------

### [util.Math.atan]{#MATH_ATAN}

#### Purpose:

This function computes the arc tangent of the argument x, measured in
radians.

#### Syntax:

`CALL util.Math.atan(FLOAT f) RETURNING `*`rv`*` FLOAT`

#### Notes:

1.  Returns NULL if the argument provided is invalid.

------------------------------------------------------------------------

### [util.Math.log]{#MATH_LOG}

#### Purpose:

This function computes the natural logarithm of the argument x.

#### Syntax:

`CALL util.Math.log(FLOAT f) RETURNING `*`rv`*` FLOAT`

#### Notes:

1.  Returns NULL if the argument provided is invalid.

------------------------------------------------------------------------

### [util.Math.toDegrees]{#MATH_TODEGREES}

#### Purpose:

Converts an angle measured in radians to an approximately equivalent
angle measured in degrees.

#### Syntax:

`CALL util.Math.toDegrees(FLOAT f) RETURNING `*`rv`*` FLOAT`

------------------------------------------------------------------------

### [util.Math.toRadians]{#MATH_TORADIANS}

#### Purpose:

Converts an angle measured in degrees to an approximately equivalent
angle measured in radians.

#### Syntax:

`CALL util.Math.toRadians(FLOAT f) RETURNING `*`rv`*` FLOAT`

------------------------------------------------------------------------

### [util.Math.pi]{#MATH_PI}

#### Purpose:

This function returns the FLOAT value of PI.

#### Syntax:

`CALL util.Math.pi() RETURNING `*`rv`*` FLOAT`

------------------------------------------------------------------------
