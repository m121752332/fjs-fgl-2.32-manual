[Back to Contents](../index.html)

------------------------------------------------------------------------

# [Drag & Drop]{#PAGE_HEADER}

Summary:

- [Basics](#BASICS)
- [Usage](#USAGE)
  - [Default Drag and Drop operation](#DEFAULT_OPERATION)
  - [Control Block Execution Order](#CTRLBLOCK_EXECUTION)
  - [Detecting the beginning of a Drag & Drop operation with ON
    DRAG_START](#on-drag_start)
  - [Being notified of the end of a Drag & Drop operation with ON
    DRAG_FINISHED](#on-drag_finished)
  - [Detecting a potential drop on target dialog with ON
    DRAG_ENTER](#on-drag_enter)
  - [Being notified when the cursor moves over the drop target with ON
    DRAG_OVER](#on-drag_over)
  - [Detecting a Drag & Drop operation change](#operation-change)
  - [Detecting the drop on target event with ON DROP](#on-drop)
  - [Setting the visual feedback for the drop operation](#set-feedback)
  - [Handling data from/to external applications with different MIME
    types](#mime-types)
- [Examples](#EXAMPLES)
  - [Example 1](#EXAMPLE_1)

*See also:* [Arrays](Arrays.html), [Records](Records.html), [Result
Sets](ResultSets.html), [Programs](Programs.html),
[Windows](WindowsAndForms.html), [Forms](FormSpecFiles.html), [Display
Array](DisplayArray.html), [TreeViews](TreeViews.html), [DragDrop
class](ClassDragDrop.html).

------------------------------------------------------------------------

### [Basics]{#BASICS}

Before reading this, you should be familiar with form [TABLE
containers](FormSpecFiles.html#FF_ITEMTYPE_TABLE) and [TREE
containers](FormSpecFiles.html#FF_ITEMTYPE_TREE), and you must know how
to program a singular [DISPLAY ARRAY](DisplayArray.html) or a
`DISPLAY ARRAY` sub-dialog within a [DIALOG
instruction](MultipleDialogs.html).

Genero BDL supports Drag & Drop in regular lists and tree-views
controlled by a `DISPLAY ARRAY`. Drag & Drop is not supported in other
dialog contexts like singular `INPUT` or `INPUT ARRAY`.

With Drag & Drop, end users can:

- Move draggable objects between lists and tree-views in the same Genero
  form/program.
- Move draggable objects between lists and tree-views in different
  Genero forms/programs.
- Move draggable objects between other desktop applications and lists/
  tree-views in Genero programs.

------------------------------------------------------------------------

### [Usage]{#USAGE}

To enable Drag and/or Drop in a `DISPLAY ARRAY`, you must implement
specific interaction blocks to handle the new events related to this
feature. These specific blocks will be triggered when Drag and Drop
events arrive from the front-end.

The following new interaction blocks are available:

- [ON DRAG_START](#on-drag_start)
- [ON DRAG_FINISHED](#on-drag_finished)
- [ON DRAG_ENTER](#on-drag_enter)
- [ON DRAG_OVER](#on-drag_over)
- [ON DROP](#on-drop)

Each of the above interaction blocks takes a
[ui.DragDrop](ClassDragDrop.html) object as a parameter. A reference
variable to that object must be declared before the dialog. In the
interaction block, the ui.DragDrop object can be used to configure the
Drag / Drop action to take. For example, a \"drag enter\" event can be
refused for some reason.

The `ON DRAG_START` and `ON DRAG_FINISHED` triggers apply to the source
of the Drag & Drop operation, the dialog where the object was dragged.
The other triggers provide notification to the drop target dialog, used
to inform the program when the different drop events occur and to let
the target accept or reject the drop action.

Here is a short example to illustrate the usage of a Drag & Drop
interaction block with the ui.DragDrop control object:

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

------------------------------------------------------------------------

#### [Default Drag & Drop operation]{#DEFAULT_OPERATION}

By default, all [DISPLAY ARRAY](DisplayArray.html) dialogs implement a
default Drag operation that copies all selected rows to the drag & drop
buffer as a tab-separated list of values, as if you would implement:

``` linenumber
01 DEFINE dnd ui.DragDrop
02 ...
03 DISPLAY ARRAY arr TO sr.* ...
04 ...
05     ON DRAG_START(dnd)
06       CALL dnd.setOperation("copy")
07         CALL dnd.setMimeType("text/plain")
08         CALL dnd.setBuffer(DIALOG.selectionToString("sr"))
09 ...
10 END DISPLAY
```

------------------------------------------------------------------------

#### [Control Block Execution Order]{#CTRLBLOCK_EXECUTION}

The following table shows the order in which the runtime system executes
the control blocks related to Drag & Drop events:

+-----------------------------------+-----------------------------------+
| **Context / User action**         | **Control Block execution order** |
+-----------------------------------+-----------------------------------+
| The user starts to drag an object | 1.  `ON DRAG_START `(in source    |
| from the source dialog.           |     dialog)                       |
+-----------------------------------+-----------------------------------+
| The mouse cursor enters the drop  | 1.  `ON DRAG_ENTER `(in target    |
| target dialog.                    |     dialog)                       |
+-----------------------------------+-----------------------------------+
| After entering the target dialog, | 1.  `ON DRAG_OVER `(in target     |
| the mouse cursor moves from row   |     dialog)                       |
| to row, or user chooses to change |                                   |
| the drop operation (move or       |                                   |
| copy).                            |                                   |
+-----------------------------------+-----------------------------------+
| The user releases the mouse       | 1.  `ON DROP `(in target dialog)  |
| button over the target dialog.    | 2.  `ON DRAG_FINISHED `(in source |
|                                   |     dialog)                       |
+-----------------------------------+-----------------------------------+

------------------------------------------------------------------------

#### [Detecting the beginning of a Drag & Drop operation with ON DRAG_START]{#on-drag_start}

The `ON DRAG_START` block is executed when the end user has begun the
drag operation. If this dialog trigger has not been defined, dragging is
denied for this dialog.

In the `ON DRAG_START` block, the program typically specifies the type
of Drag & Drop operation by calling
[ui.DragDrop.setOperation()](ClassDragDrop.html#setOperation) with
\"move\" or \"copy\". This call will define the default and unique drag
operation. If needed, the program can allow another type of drag
operation with
[ui.DragDrop.addPossibleOperation()](ClassDragDrop.html#addPossibleOperation).
The end user can then choose to move or copy the dragged object, if the
Drag & Drop target allows it.

If the dragged object can be dropped outside the BDL program, you
typically [set the MIME type](#mime-types) and drag/drop data with
[ui.DragDrop.setMimeType()](ClassDragDrop.html#setMimeType) and
[ui.DragDrop.setBuffer()](ClassDragDrop.html#setBuffer) methods.

Example:

``` linenumber
01 DEFINE dnd ui.DragDrop
02    ...
03 DISPLAY ARRAY arr TO sr.* ...
04    ...
05    ON DRAG_START (dnd)
06       CALL dnd.setOperation("move") -- Move is the default operation
07       CALL dnd.addPossibleOperation("copy") -- User can toggle to copy if needed
08       CALL dnd.setMimeType("text/plain")
09       CALL dnd.setBuffer(arr[arr_curr()].cust_name)
10       ...
11 END DISPLAY
```

------------------------------------------------------------------------

#### [Being notified of the end of a Drag & Drop operation with ON DRAG_FINISHED]{#on-drag_finished}

Execution of the `ON DRAG_FINISHED` block notifies the dialog where the
drag started that the drop operation has been completed or terminated.

Call [ui.DragDrop.getOperation()](ClassDragDrop.html#getOperation) to
get the final type of operation of the drop. On successful completion,
the method returns \"move\" or \"copy\"; otherwise the function returns
[NULL](Programs.html#PC_NULL). If ` NULL` is returned, the
`ON DRAG_FINISHED` trigger can be ignored.

In cases of successful moves to a target out of the current
` DISPLAY ARRAY`, the application must remove the transferred data from
the source model. For example, if a row was moved from dialog A to B,
dialog A will get an `ON DRAG_FINISHED` execution after the row was
dropped into B, and should remove the row from the list A.

The ` ON DRAG_FINISHED` interaction block is optional.

Example:

``` linenumber
01 DEFINE dnd ui.DragDrop
02    ...
03 DISPLAY ARRAY arr TO sr.* ...
04    ...
05    ON DRAG_START (dnd)
06       LET last_dragged_row = arr_curr()
07       ...
08    ON DRAG_FINISHED (dnd)
09       IF dnd.getOperation() == "move" THEN
10          CALL DIALOG.deleteRow(last_dragged_row)
11       END IF
12       ...
13 END DISPLAY
```

------------------------------------------------------------------------

#### [Detecting a potential drop on target dialog with ON DRAG_ENTER]{#on-drag_enter}

When [ON DROP](#on-drop) is defined, the ` ON DRAG_ENTER` block will be
executed when the mouse cursor enters the visual boundaries of the drop
target dialog.\
\
Entering the target dialog is accepted by default if no ` ON DRAG_ENTER`
block is defined. However, when `ON DROP` is defined, you should also
define `ON DRAG_ENTER` to deny the drop of objects with an unsupported
MIME type that come from other applications.

The program can decide to deny or allow a specific drop operation with a
call to [ui.DragDrop.setOperation()](ClassDragDrop.html#setOperation);
passing a [NULL](Programs.html#PC_NULL) to the method will deny drop.

To check what MIME type is available in the Drag & Drop buffer, the
program uses the
[ui.DragDrop.selectMimeType()](ClassDragDrop.html#selectMimeType)
method. This method takes the MIME type as a parameter and returns
[TRUE](Programs.html#PC_TRUE) if the passed MIME type is used. You can
call this method several times to check the availability of different
MIME types.

You may also define the visual effect when flying over the target list
with [ui.DragDrop.setFeedback()](ClassDragDrop.html#setFeedback).

Example:

``` linenumber
01 DEFINE dnd ui.DragDrop
02    ...
03 DISPLAY ARRAY arr TO sr.* ...
04    ...
05    ON DRAG_ENTER (dnd)
06       IF dnd.selectMimeType("text/plain") THEN
07          CALL dnd.setOperation("copy")
08          CALL dnd.setFeedback("all")
09       ELSE
10          CALL dnd.setOperation(NULL)
11       END IF
12    ON DROP (dnd)
13       ...
14 END DISPLAY
```

Once the mouse has entered the target area, subsequent mouse cursor
moves can be detected with the [ON DRAG_OVER](#on-drag_over) trigger.

------------------------------------------------------------------------

#### [Being notified when the cursor moves over the drop target with ON DRAG_OVER]{#on-drag_over}

When [ON DROP](#on-drop) is defined, the ` ON DRAG_OVER` block will be
executed after [ON DRAG_ENTER](#on-drag_enter), when the mouse cursor is
moving over the drop target, or when the Drag & Drop operation has
changed (toggling copy/move).

`ON DRAG_OVER` will be called only once per row, even if the mouse
cursor moves over the row.

In this block, the method
[ui.DragDrop.getLocationRow()](ClassDragDrop.html#getLocationRow)
returns the index of the row in the target array, and can be used to
allow or deny the drop. When using a [TreeView](TreeViews.html), you
must also check the index returned by the
[ui.DragDrop.getLocationParent()](ClassDragDrop.html#getLocationParent)
method to detect if the object was dropped as a [sibling]{.underline} or
as a [child]{.underline} node, and allow/deny the drop operation
accordingly.

The program can change the drop operation at any execution of the
`ON DRAG_OVER` block. You can deny or allow a specific drop operation
with a call to
[ui.DragDrop.setOperation()](ClassDragDrop.html#setOperation); passing a
[NULL](Programs.html#PC_NULL) to the method will deny the drop.

The current operation
([ui.DragDrop.getOperation()](ClassDragDrop.html#getOperation)) is the
value set in previous `ON DRAG_ENTER` or `ON DRAG_OVER` events, or the
operation selected by the end user, if it can toggle between copy and
move. Thus, `ON DRAG_OVER` can occur even if the mouse position has not
changed.

If dropping has been denied with `ui.DragDrop.setOperation(NULL)` in the
previous `ON DRAG_OVER` event, the program can reset the operation to
allow a drop with a call to
[ui.DragDrop.setOperation(\"move\"\|\"copy\")](ClassDragDrop.html#setOperation).

`ON DRAG_OVER` will not be called if drop has been disabled in
` ON DRAG_ENTER` with ` ui.DragDrop.setOperation(NULL)`

`ON DRAG_OVER` is optional, and must only be defined if the operation or
the acceptance of the drag object depends on the target row of the drop
target.

Example:

``` linenumber
01 DEFINE dnd ui.DragDrop
02    ...
03 DISPLAY ARRAY arr TO sr.* ...
04    ...
05    ON DRAG_ENTER (dnd)
06       ...
07    ON DRAG_OVER (dnd)
08       IF arr[dnd.getLocationRow()].acceptsCopy THEN
09          CALL dnd.setOperation("copy")
10       ELSE
11          CALL dnd.setOperation(NULL)
12       END IF
13    ON DROP (dnd)
14       ...
15 END DISPLAY
```

------------------------------------------------------------------------

#### [Detecting a Drag & Drop operation change]{#operation-change}

During a Drag & Drop process, the end user (or the target application)
can decide to modify the type of the operation, to indicate whether the
dragged object has to be copied or moved from the source to the target.
For example, when using the Windows file explorer, by default files are
moved when doing a Drag & Drop on the same disk. To make a copy of a
file, you must press the CONTROL key while doing the Drag & Drop with
the mouse.

In the drop target dialog, you can detect such operation changes in the
`ON DRAG_OVER` trigger and query the ui.DragDrop object for the current
operation with
[ui.DragDrop.getOperation()](ClassDragDrop.html#getOperation). In the
drag source dialog, you typically check
[ui.DragDrop.getOperation()](ClassDragDrop.html#getOperation) in the
`ON DRAG_FINISHED` trigger to know what sort of operation occurred, to
keep (\"copy\" operation) or delete (\"move\" operation) the original
dragged object.

The next example tests the current operation in the drop target list and
displays a message accordingly:

``` linenumber
01 DEFINE dnd ui.DragDrop
02    ...
03 DISPLAY ARRAY arr TO sr.* ...
04    ...
05    ON DRAG_ENTER (dnd)
06       ...
07    ON DRAG_OVER (dnd)
08       CASE dnd.getOperation()
09       WHEN "move"
10          MESSAGE "The object will be moved to row ", dnd.getLocationRow()
11       WHEN "copy"
12          MESSAGE "The object will be copied to row ", dnd.getLocationRow()
13       END CASE
14       ...
15    ON DROP (dnd)
16       ...
17 END DISPLAY
```

------------------------------------------------------------------------

#### [Detecting the drop on target event with ON DROP]{#on-drop}

In order to enable drop actions on a list, you must at least define the
` ON DROP` block; otherwise, the list will not accept drop actions.

The `ON DROP` block is executed after the end user has released the
mouse button to drop the dragged object. `ON DROP` will not occur, if
drop has been denied in the previous `ON DRAG_OVER` event or in
`ON DRAG_ENTER` with a call to
[ui.DragDrop.setOperation(NULL)](ClassDragDrop.html#setOperation).

The program might also check the MIME type of the dragged object with
[ui.DragDrop.getSelectedMimeType()](ClassDragDrop.html#getSelectedMimeType),
and then call the
[ui.DragDrop.getBuffer()](ClassDragDrop.html#getBuffer) method to
retrieve Drag & Drop data from external applications.

Ideally the drop operation should be accepted (no additional call to
[ui.DragDrop.setOperation()](ClassDragDrop.html#setOperation)).

In this block, the method
[ui.DragDrop.getLocationRow()](ClassDragDrop.html#getLocationRow)
returns the index of the row in the target array, and can be used to
execute the code to get the drop data / object into the row that has
been chosen by the user.

Example:

``` linenumber
01 DEFINE dnd ui.DragDrop
02    ...
03 DISPLAY ARRAY arr TO sr.* ...
04    ...
05    ON DROP (dnd)
06       LET arr[dnd.getLocationRow()].capacity == dnd.getBuffer() 
07       ...
08 END DISPLAY
```

If the Drag & Drop operations are local to the same list or tree-view
controller, you can use the
[ui.DragDrop.dropInternal()](ClassDragDrop.html#dropInternal) method to
simplify the code: This method implements the typical move of the
dragged rows or tree-view node. This is especially useful in case of a
[TreeView](TreeViews.html), but is also the preferred way to move rows
around in simple tables.

Here is an `ON DROP` code example using the `dropInternal()` method:

``` linenumber
01 DEFINE dnd ui.DragDrop
02    ...
03 DISPLAY ARRAY arr_tree TO sr_tree.* ...
04    ...
05    ON DROP (dnd)
06       CALL dnd.dropInternal()
07       ...
08 END DISPLAY
```

If you want to implement by hand the code to drop a node in a
[TreeView](TreeViews.html), you must check the index returned by the
[ui.DragDrop.getLocationParent()](ClassDragDrop.html#getLocationParent)
method to detect if the object was dropped as a [sibling]{.underline} or
as a [child]{.underline} node, and execute the code corresponding to the
drop operation: If the drop target row index returned by
`getLocationRow()` is a child of the parent row index returned by
`getLocationParent()`, the new row must be inserted before
`getLocationRow()`; otherwise the new row must be added as a child of
the parent node identified by `getLocationParent()`.

------------------------------------------------------------------------

#### [Setting the visual feedback for the drop operation]{#set-feedback}

When using a table or treeview as drop target, you can control the
visual effect when the mouse flies over the rows, according to the type
of Drag & Drop you want to achieve. 

Basically, a dragged object can be:

1.  Inserted in between two rows (visual effect must show where the
    object will be inserted)
2.  Copied/merged to the current row (visual effect must show the row
    under the mouse)
3.  Dropped somewhere on the target widget (the exact location inside
    the widget does not matter)

The visual effect can be defined with the
[ui.DragDrop.setFeedback()](ClassDragDrop.html#setFeedback) method,
typically called in the [ON DRAG_ENTER block](#on-drag_enter).

The values to pass to the setFeedback() method to get the desired visual
effects described above are respectively:

1.  insert (default)
2.  select
3.  all

Example:

``` linenumber
01 DEFINE dnd ui.DragDrop
02    ...
03 DISPLAY ARRAY arr TO sr.* ...
04    ...
05    ON DRAG_ENTER (dnd)
06       IF canDrop() THEN
07           CALL dnd.setOperation(NULL)
08       ELSE
09           CALL dnd.setFeedback("select")
10       END IF
11       ...
12 END DISPLAY
```

------------------------------------------------------------------------

#### [Handling data from/to external applications with different MIME types]{#mime-types}

If a Drag & Drop is intended to work only in the same BDL application,
you can pass Drag & Drop data with variables in the context of the
current program. For example, in a program using two tables where the
user can Drag & Drop elements between the two lists, you can easily
identify the selected rows and update the program arrays accordingly.
When Drag & Drop is limited to the current application, you should avoid
drop outside the current application, as described later in this
section. 

When a Drag & Drop operation comes from (or goes to) external
applications (i.e. not from the same BDL program), data can be of
various types/formats (plain text, formatted text, documents, images,
sounds, videos). In order to handle the Drag & Drop data, you must
identify the type of data held in the Drag & Drop buffer. The type of
data in the buffer is identified by the **MIME** type. MIME stands for
**M**ultiple **I**nternet **M**ail **E**xtensions. It is an internet
standard specification widely used. MIME type identifiers were first
introduced to identify the content of e-mail attachments.

**Warning: Genero BDL can only handle text data in Drag & Drop; binary
data is not supported. However, you can pass files by using [file
transfer](BuiltInFunctions.html#BF_FGL_GETFILE), and identify the file
with a URI (text-uri-list MIME type). See the demos in
FGLDIR/demo/DragAndDrop for examples.**

Example of MIME types:

- text/plain
- text/uri-list
- text/x-vcard

You can also define your own MIME type, as long as it does not conflict
with existing standard MIME types. For example:

- text/my-remote-file
- text/my-customer-record

Note that if you do not specify a MIME type when the drag starts, the
type defaults to **text/plain**, and the dialog will by default copy the
data from selected rows into the Drag & Drop buffer. To prevent Drag &
Drop to external applications, you must pass an application-specific
MIME type to the
[ui.DragDrop.setMimeType()](ClassDragDrop.html#setMimeType) method, to
be sure that other applications do not recognize the MIME type and will
deny the drop.

##### Preparing the dragged object for external targets

If the BDL program implements Drag & Drop of objects that can be dropped
to external programs, you must specify the MIME type of the object and
copy the data to the Drag & Drop buffer, so that the external
application can identify the data format and receive it.

In the `ON DRAG_START` block, you must call the
[ui.DragDrop.setMimeType()](ClassDragDrop.html#setMimeType) method to
define the MIME type of the object, and copy the text data into the
buffer with the [ui.DragDrop.setBuffer()](ClassDragDrop.html#setBuffer)
method.

The next example shows a `DISPLAY ARRAY` dialog preparing the Drag &
Drop buffer to export VCard data from a dragged row:

``` linenumber
01 DEFINE dnd ui.DragDrop
02 ...
03 DISPLAY ARRAY arr TO sr.* ...
04 ...
05     ON DRAG_START(dnd)
06       -- Define the MIME type and copy text data to DnD buffer
07       CALL dnd.setMimeType("text/x-vcard")
08       CALL dnd.setBuffer( buildVCardData( arr[arr_curr()].cid ) )
09       CALL dnd.setOperation("copy")
10 ...
11 END DISPLAY
```

##### Receiving the dragged object from external sources

This describes how to handle the drop action when the target dialog
receives an object dragged from an external source, by identifying the
MIME type of the object.

In the `ON DRAG_ENTER` block, you must call the
[ui.DragDrop.selectMimeType()](ClassDragDrop.html#selectMimeType) method
to check that data is available in a format identified by the MIME type,
passed as a parameter. If the type of data is available in the buffer,
the method returns [TRUE](Programs.html#PC_TRUE). Later, when the
dragged object is dropped (`ON DROP`),  you can get the previously
selected MIME type with
[ui.DragDrop.getSelectedMimeType()](ClassDragDrop.html#getSelectedMimeType)
before calling [ui.DragDrop.getBuffer()](ClassDragDrop.html#getBuffer)
to retrieve the actual data.

The next example shows the usage of those methods: In `ON DRAG_ENTER`,
the program checks available MIME types, and denies the drop operation
if the buffer does not hold any of the MIME types that can be treated by
the program. In `ON DROP`, the program calls `getSelectMimeType()` to
check what MIME type was selected, retrieves the data with
`getBuffer()`, then inserts a new row and puts the data in dedicated
fields according to the MIME type:

``` linenumber
01 DEFINE dnd ui.DragDrop
02 ...
03 DISPLAY ARRAY arr TO sr.* ...
04 ...
05     ON DRAG_ENTER(dnd)
06       -- Set operation to NULL if unexpected MIME type found
07       CASE
08       WHEN dnd.selectMimeType("text/plain")
09       WHEN dnd.selectMimeType("text/uri-list")
10       OTHERWISE
11         CALL dnd.setOperation(NULL)
12       END CASE
13 ...
14     ON DROP(dnd)
15       -- Select MIME type and get data from buffer
17       LET row = dnd.getLocationRow()
18       CALL DIALOG.insertRow("sr", row)
20       IF dnd.getSelectMimeType() == "text/plain" THEN
21         LET arr[row].text_data = dnd.getBuffer()
23       END IF
24 ...
25 END DISPLAY
```

------------------------------------------------------------------------

### [Examples]{#EXAMPLES}

*See demo directory for more drag & drop examples!*

#### [Example 1: Two lists side-by-side with drag & drop]{#EXAMPLE_1}

``` linenumber
01 MAIN
02     DEFINE drag_index, drop_index, i INT
03     DEFINE drag_source, drag_value SRING
04     DEFINE arr_left, arr_right DYNAMIC ARRAY OF STRING
05     DEFINE dnd ui.DragDrop
06     CONSTANT S_LEFT="sr_left"
07     CONSTANT S_RIGHT="sr_right"
08
09     OPEN FORM f FROM "dnd"
10     DISPLAY FORM f
11
12     FOR i = 1 TO 10
13        LET arr_left[i] = "left " || i
14         LET arr_right[i] = "right" || i
15     END FOR
16
17     INITIALIZE drag_index TO NULL
18
19     DIALOG ATTRIBUTE(UNBUFFERED)
20
21         DISPLAY ARRAY arr_left TO sr_left.*
22         ON DRAG_START(dnd)
23             LET drag_source = S_LEFT
24             LET drag_index = arr_curr()
25             LET drag_value = arr_left[drag_index]
26         ON DRAG_FINISHED(dnd)
27             INITIALIZE drag_source TO NULL
28
29         ON DRAG_ENTER(dnd)
30             IF drag_source IS NULL THEN
31                 CALL dnd.setOperation(NULL)
32             END IF
33         ON DROP(dnd)
34             IF drag_source == S_LEFT THEN
35                 CALL dnd.dropInternal()
36             ELSE
37                 LET drop_index = dnd.getLocationRow()
38                 CALL DIALOG.insertRow(S_LEFT, drop_index)
39                 CALL DIALOG.setCurrentRow(S_LEFT, drop_index)
40                 LET arr_left[drop_index] = drag_value
41                 CALL DIALOG.deleteRow(S_RIGHT, drag_index)
42             END IF
43         END DISPLAY
44
45         DISPLAY ARRAY arr_right TO sr_right.*
46         ON DRAG_START(dnd)
47             LET drag_source = S_RIGHT
48             LET drag_index = arr_curr()
49             LET drag_value = arr_right[drag_index]
50         ON DRAG_FINISHED(dnd)
51             INITIALIZE drag_source TO NULL
52
53         ON DRAG_ENTER(dnd)
54             IF drag_source IS NULL THEN
55                 CALL dnd.setOperation(NULL)
56             END IF
57         ON DROP(dnd)
58             IF drag_source == S_RIGHT THEN
59                 CALL dnd.dropInternal()
60             ELSE
61                 LET drop_index = dnd.getLocationRow()
62                 CALL DIALOG.insertRow(S_RIGHT, drop_index)
63                 CALL DIALOG.setCurrentRow(S_RIGHT, drop_index)
64                 LET arr_right[drop_index] = drag_value
65                 CALL DIALOG.deleteRow(S_LEFT, drag_index)
66             END IF
67         END DISPLAY
68
69     ON ACTION cancel
70         EXIT DIALOG
71
72     END DIALOG
73 END MAIN
```
