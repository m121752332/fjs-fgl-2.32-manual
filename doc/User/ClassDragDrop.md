[Back to Contents](../index.html)

------------------------------------------------------------------------

# [The DragDrop class]{#PAGE_HEADER}

Summary:

- [Syntax](#SYNTAX)
- [Methods](#METHODS)
- [Usage](#USAGE)
  - [Defining the possible Drag & Drop
    operations](#addPossibleOperation)
  - [Getting the index of the target row where the object was
    dropped](#getLocationRow)
  - [Getting the index of the parent node where the object was
    dropped](#getLocationParent)
  - [Identifying the type of operation on drop](#getOperation)
  - [Defining the type of Drag & Drop operation](#setOperation)
  - [Defining the appearance of the target during Drag &
    Drop](#setFeedback)
  - [Selecting the MIME type](#selectMimeType)
  - [Getting the selected MIME type before getting
    data](#getSelectedMimeType)
  - [Getting Drag & Drop data from the buffer](#getBuffer)
  - [Defining the MIME type of the dragged object](#setMimeType)
  - [Setting the text data of the dragged object](#setBuffer)
  - [Performing built-in row drop in trees](#dropInternal)

*See also:* [Built-in Classes](BuiltInClasses.html), [Drag &
Drop](DragAndDrop.html).

------------------------------------------------------------------------

### [Syntax]{#SYNTAX}

The **DragDrop** class is used to control the events related to Drag &
Drop.

#### Syntax:

`ui.DragDrop`

------------------------------------------------------------------------

### [Methods:]{#METHODS}

+------------------------------------------------------------------------+----------------------------------+
| **Object Methods**                                                                                        |
+------------------------------------------------------------------------+----------------------------------+
| **Name**                                                               | **Description**                  |
+------------------------------------------------------------------------+----------------------------------+
| [`addPossibleOperation`](#addPossibleOperation)`( optype ``STRING`` )` | Adds a Drag & Drop operation     |
|                                                                        | that is allowed.                 |
+------------------------------------------------------------------------+----------------------------------+
| [`dropInternal`](#dropInternal)`()`                                    | Performs built-in drop when the  |
|                                                                        | target is the source list or     |
|                                                                        | tree.                            |
+------------------------------------------------------------------------+----------------------------------+
| [`getBuffer`](#getBuffer)`() ``RETURNING STRING`                       | Returns Drag & Drop data as      |
|                                                                        | selected by the hasMimeType()    |
|                                                                        | method.                          |
+------------------------------------------------------------------------+----------------------------------+
| [`getLocationParent`](#getLocationParent)`( ) ``RETURNING INTEGER`     | Returns the parent node index of |
|                                                                        | the child node the mouse is      |
|                                                                        | pointing to during Drag & Drop.  |
+------------------------------------------------------------------------+----------------------------------+
| [`getLocationRow`](#getLocationRow)`( ) ``RETURNING INTEGER`           | Returns the index of the row the |
|                                                                        | mouse is pointing to during Drag |
|                                                                        | & Drop.                          |
+------------------------------------------------------------------------+----------------------------------+
| [`getOperation`](#getOperation)`() ``RETURNING STRING`                 | Returns the current type of Drag |
|                                                                        | & Drop operation or NULL if      |
|                                                                        | denied.                          |
+------------------------------------------------------------------------+----------------------------------+
| [`getSelectedMimeType`](#getSelectedMimeType)`() ``RETURNING STRING`   | Returns the previously selected  |
|                                                                        | MIME type.                       |
+------------------------------------------------------------------------+----------------------------------+
| [`selectMimeType`](#selectMimeType)`( mimetype ``STRING ``) `          | Selects the given MIME type if   |
|                                                                        | such a record is available in    |
|                                                                        | the Drag & Drop buffer.          |
+------------------------------------------------------------------------+----------------------------------+
| [`setFeedback`](#setFeedback)`( feedback ``STRING ``) `                | Defines the appearance of the    |
|                                                                        | target during Drag & Drop.       |
+------------------------------------------------------------------------+----------------------------------+
| [`setMimeType`](#setMimeType)`( mimetype ``STRING ``) `                | Defines the MIME type of the     |
|                                                                        | dragged object.                  |
+------------------------------------------------------------------------+----------------------------------+
| [`setBuffer`](#setBuffer)`( data ``STRING ``) `                        | Copies the text data of the      |
|                                                                        | dragged object into the Drag &   |
|                                                                        | Drop buffer.                     |
+------------------------------------------------------------------------+----------------------------------+
| [`setOperation`](#setOperation)`( optype ``STRING`` )`                 | Defines the type of Drag & Drop  |
|                                                                        | operation or denies Drag & Drop. |
+------------------------------------------------------------------------+----------------------------------+

------------------------------------------------------------------------

### [Usage:]{#USAGE}

When [implementing Drag & Drop in a dialog](DragAndDrop.html), the
`ON DRAG*` / `ON DROP `dialog control blocks take a **ui.DragDrop**
variable as a parameter to let you configure and control the Drag & Drop
procedure. The ui.DragDrop variable must be declared in the scope of the
dialog implementing Drag & Drop.

In the next example, the code defines a ui.DragDrop variable named dnd,
and implements an `ON DRAG_ENTER` block taking dnd as the argument:

    01 DEFINE dnd ui.DragDrop
    02 ...
    03 DISPLAY ARRAY arr TO sr.* ...
    04 ...
    05     ON DRAG_ENTER(dnd)
    06       IF ok_to_drop THEN
    07         CALL dnd.setOperation("move")
    08       ELSE
    09         CALL dnd.setOperation(NULL)
    10       END IF
    11 ...
    12 END DISPLAY

#### [Adding a possible operation]{#addPossibleOperation}

Drag & Drop actions can be of different kinds; you can do a copy of the
dragged object, or move the dragged object from the source to the
destination. The default Drag & Drop operation is defined by a call to
[setOperation()](#setOperation) in `ON DRAG_START`, you can then use the
`addPossibleOperation()` method to define additional operations that are
allowed.

See [setOperation()](#setOperation) for possible values.

#### [Getting the index of the target row where the object was dropped]{#getLocationRow}

The `getLocationRow()` method returns the index of the row in the drop
target list pointed to by the mouse cursor. This method is typically
used in the `ON DROP` block to get the index of the target row to be
modified or replaced by the dragged object. The method can also be used
in `ON DRAG_OVER` to deny the drop according to the current target row
returned by `getLocationRow()`.

#### [Getting the index of the parent node where the object was dropped]{#getLocationParent}

When using a [TreeView](TreeViews.html), a node can be dropped as a
[sibling]{.underline} or as a [child]{.underline} node to another node.
In order to distinguish between the cases, you must use the
`getLocationParent()` method, which returns the index of the parent node
of the drop target node returned by [getLocationRow()](#getLocationRow).
If both methods return the same row index, you must append the dropped
row as a child of the target node. Otherwise, `getLocationParent()`
identifies the parent node where the dropped row has to be added as a
child, and `getLocationRow()` is the index of a sibling node. In the
last case the dropped node must be inserted before the node identified
by `getLocationRow()`. These methods are typically used in the `ON DROP`
block, but can also be used in `ON DRAG_OVER` to deny the drop according
to the indexes returned; for example, the program might only allow the
drop of objects as new children for a given parent node.

#### [Identifying the type of operation on drop]{#getOperation}

The `getOperation()` method returns the type of the current Drag & Drop
operation (i.e. copy, move, none). According to the value returned by
this method, the program can make the appropriate changes in the data
model. For example, after a row has been dropped into another list, the
source list can remove the original row if the operation was a \"move\",
but keeps the original row if the operation was a \"copy\". The
`getOperation()` method is typically called in the `ON DRAG_FINISHED`
block.

#### [Defining the type of Drag & Drop operation]{#setOperation}

Use the `setOperation()` method to define/force the type of Drag & Drop
operation or to deny/cancel the Drag & Drop process.

  ------------------------------ ------------------------------------------------------
  **setOperation() parameter**   **Description**
  `NULL`                         To deny/cancel the Drag & Drop process.
  `copy`                         To allow Drag & Drop as a copy of the source object.
  `move`                         To allow Drag & Drop as a move of the source object.
  ------------------------------ ------------------------------------------------------

The `setOperation()` method can be called in different Drag & Drop
triggers. The most common usage is to deny Drag & Drop by passing
[NULL](Programs.html#PC_NULL) in the `ON DRAG_ENTER` and/or
`ON DRAG_OVER` blocks because the dragged object does not correspond to
the type of objects the target can receive. It is also typically used in
`ON DRAG_START` to force a specific type of Drag & Drop operation (copy
or move), or to deny drag start if the context does not allow a Drag &
Drop action. When called in the ` ON DRAG_ENTER` block, the method
forces a specific Drag & Drop operation.

See also [addPossibleOperation()](#addPossibleOperation).

#### [Defining the appearance of the target during Drag & Drop]{#setFeedback}

The `setFeedback()` method defines the appearance the target object must
have during the Drag & Drop action. For example, in a table or treeview,
when the mouse is flying over rows in the drop target, a different
visual indicator will appear according to the value that was passed to
`setFeedback()`.

Possible values for the `setFeedback()` method are:

  ----------------------------- ----------------------------------------------------------------------------------------------------
  **setFeedback() parameter**   **Description**
  `all`                         Dragged object will be dropped somewhere on the target widget, the exact location does not matter.
  `insert`                      In lists, dragged object will be inserted in between existing rows.
  `select`                      In lists, dragged object will replace the current row under the mouse.
  ----------------------------- ----------------------------------------------------------------------------------------------------

#### [Selecting the MIME type before getting the data]{#selectMimeType}

Call the `selectMimeType()` method to check that data is available in a
format identified by the MIME type passed as parameter. If this type of
data is available in the buffer, the method returns
[TRUE](Programs.html#PC_TRUE) and you can later get the data with
`getBuffer()`.

The `selectMimeType()` method is typically used in `ON DRAG_ENTER`,
`ON DRAG_OVER` to deny the Drag & Drop operation if none of the
supported MIME types is available in the buffer.

#### [Getting the previously selected MIME type]{#getSelectedMimeType}

Before retrieving data from the Drag & Drop buffer with
[getBuffer()](#getBuffer), you must first call the
`getSelectedMimeType()` method to identify the data format that was
previously selected by a [selectMimeType()](#selectMimeType) call.

The `getSelectedMimeType()` method is typically called in `ON DROP` to
identity the format of the dropped object.

#### [Getting Drag & Drop data from the buffer]{#getBuffer}

Once the MIME type of the dropped object was identified with
[getSelectedMimeType()](#getSelectedMimeType), you can call the
`getBuffer()` method to get text data from the Drag & Drop buffer.

Drag & Drop data is only available at `ON DROP` time, thus the
`getBuffer()` method must be called in `ON DROP` only.

#### [Defining the MIME type of the dragged object]{#setMimeType}

Objects dragged from a BDL application to an external application need
to be identified with a MIME type and the program must provide the data.
The MIME type can be specified with the `setMimeType()` method. 

The `setMimeType()` method is typically used in an `ON DRAG_START` block
in conjunction with [setBuffer()](#setBuffer).

By default the source target will use the text/plain MIME type and copy
the data of the selected rows into the Drag & Drop buffer.

#### [Setting the text data of the dragged object]{#setBuffer}

In order to provide the text data of objects dragged from a BDL
application to an external application, you must use the `setBuffer()`
method. 

The `setBuffer()` method is typically used in an `ON DRAG_START` block
in conjunction with [setMimeType()](#setMimeType).

By default, the dialog will serialize the data of the selected rows as a
tab-separated list of values (text/plain MIME type is the default).

#### [Performing built-in row drop in trees]{#dropInternal}

In order to simplify Drag & Drop programming in the same list, the
`ui.DragDrop` class provides the `dropInternal()` utility method, to be
called in the `ON DROP` block. This method will perform all the row
changes in the array and move row selection as well as cell attributes.

When implementing Drag & Drop on a [tree-view](TreeViews.html), dropping
an element on the tree requires complex code in order to handle
parent-child relationships. Nodes can be inserted under a parent between
two children, appended at the end of the children list, and at different
levels in the tree hierarchy. However, the dropInternal() method can
also be used when the decoration is a regular table.

**Warning: The call to dropInternal() will silently be ignored, if the
drag source is not the drop target, or if the method is called in a
different context as `ON DROP`.**

For more details about dropping elements in tree-views, see the usage of
[ON DROP](DragAndDrop.html#on-drop) in the Drag & Drop page.
