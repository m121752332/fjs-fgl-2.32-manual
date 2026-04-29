[Back to Contents](../index.html)

------------------------------------------------------------------------

# [New Features of the Language]{#PAGE_HEADER}

- **Product line 2.3x**
  - [Version 2.32](#VERSION_2_32)
  - [Version 2.30](#VERSION_2_30)
- **Product line 2.2x**
  - [Version 2.21](#VERSION_2_21)
  - [Version 2.20](#VERSION_2_20)
- **Product line 2.1x**
  - [Version 2.11](#VERSION_2_11)
  - [Version 2.10](#VERSION_2_10)
- **Product line 2.0x**
  - [Version 2.02](#VERSION_2_02)
  - [Version 2.01](#VERSION_2_01)
  - [Version 2.00](#VERSION_2_00)
- **Product line 1.3x**
  - [Version 1.33](#VERSION_1_33)
  - [Version 1.32](#VERSION_1_32)
  - [Version 1.31](#VERSION_1_31)
  - [Version 1.30](#VERSION_1_30)
- **Product line 1.2x**
  - [Version 1.20](#VERSION_1_20)
- **Product line 1.1x**
  - [Version 1.10](#VERSION_1_10)

*See also:* [FAQ List](FAQList.html).

------------------------------------------------------------------------

## [Version 2.32]{#VERSION_2_32}

See also [Upgrade Notes](Mig0005.html).

In this Genero BDL version does not include new features. The
development team focused on stability and defects correction.

------------------------------------------------------------------------

## [Version 2.30]{#VERSION_2_30}

See also [Upgrade Notes](Mig0005.html).

- [Drag & Drop](#Drag_and_Drop)
- [The WEB Component](#Web_Component)
- [New database drivers](#New_DB_Drivers_2_22)
- [Support for MAC OS/X platform](#Mac_OS_X)
- [Command line tools display platform identifier with -V
  option](#version-info-platform)
- [Oracle BINARY_FLOAT / BINARY_DOUBLE](#Oracle_bin_float_double)
- [Multiple configuration file specification with
  FGLPROFILE](#multi-fglprofile)
- [Show a specific field of a form](#ensure-field-visible)
- [Style attribute for ERROR and MESSAGE
  instructions](#error-message-style)
- [Style attribute for ToolBar and TopMenu
  elements](#toolbar-topmenu-style)
- [RADIOGROUP items are filled with INCLUDE
  list](#radiogroup_include_to_items)
- [CSV (Comma Separated Values) format for
  LOAD/UNLOAD/Channel](#csv-channel-delimiter)
- [Identifying the last clicked canvas item](#ident-canvas-item)
- [Checking the touched flag of all fields used by the
  dialog](#all-fields-touched)
- [Getting the type of the current database driver](#fgl_db_driver_type)
- [Table column header alignment](#table-column-header-alignment)
- [FGLSQLDEBUG display shared object load
  error](#FGLSQLDEBUG-load-dll-error)
- [Schema extractor supports now SQLite](#fgldbsch-sqlite)
- [DIALOG.setFieldActive accepts now a list of
  fields](#DIALOG_setFieldActive_field_list)
- [New DIALOG methods to manipulate trees](#DIALOG_methods_tree)
- [New FGLPROFILE entry
  fglrun.arrayIgnoreRangeError](#fglrun.arrayIgnoreRangeError)
- [New FGLPROFILE entry
  fglrun.mapAnyErrorToError](#fglrun.mapAnyErrorToError)

### [Drag & Drop]{#Drag_and_Drop}

The major new feature of Genero BDL 2.30 is the ability to implement
[Drag & Drop](DragAndDrop.html) in DISPLAY ARRAY for tables or
treeviews.

### [The WEB Component]{#Web_Component}

A new form item type called
[WEBCOMPONENT](FormSpecFiles.html#FF_ITEMTYPE_WEBCOMPONENT) is provided
to integrate external Java-Script-based widgets in your forms.

### [New database drivers]{#New_DB_Drivers_2_22}

Genero 2.30 provides the following new database drivers:

- **dbmase0Fx** for [Sybase ASE 15.x](odiagase.html) (2.30.01)
- **dbmmys55x** for a [Mysql 5.5.x client](odiagmys.html) (2.30.01)
- **dbmpgs90x** for a [PostgreSQL 9.0.x client](odiagpgs.html) (2.30.02)

### [Support for Mac OS/X platform]{#Mac_OS_X}

Genero BDL is now available on Mac OS/X. You need at least Mac OS/X
version **10.5**.\
The Operating System code for Mac OS/X 10.5 64b is **m64x105**.

### [Command line tools display platform identifier with -V option]{#version-info-platform}

When using the -V option to display version information with FGL
command-line tools, you get now also the platform identifier:

    $ fglrun -V
    ...
    Target lnxlc23
    ...

The \"Target\" line helps to identify the operating system the binary
was compiled for. This information can be useful on systems where you
can mix 32b and 64b binaries. 

### [Oracle BINARY_FLOAT / BINARY_DOUBLE]{#Oracle_bin_float_double}

Informix SMALLFLOAT and FLOAT can now be stored in Oracle native
BINARY_FLOAT / BINARY_DOUBLE types.\
See [Oracle Adaptation Guide](odiagora.html#ODIORA021) for more details.

### [Multiple configuration file specification with FGLPROFILE]{#multi-fglprofile}

The [FGLPROFILE](FglProfile.html) environment variable now accepts
multiple file specification with an operating-system-specific path
separator:

    FGLPROFILE="/opt/app/etc/license.prf:/opt/app/etc/gui.prf:myprofile.prf"

### [Show a specific field of a form]{#ensure-field-visible}

A new method was added to the [ui.Form built-in
class](ClassForm.html#ensureFieldVisible), to make a specific form field
visible, showing the parent containers automatically.\
This method can also be used to bring a given folder page to the front,
even if the field is not active (i.e. not driven by a dialog).

### [STYLE attribute for ERROR and MESSAGE instructions]{#error-message-style}

The [ERROR](MessageDisplay.html#ERROR) and
[MESSAGE](MessageDisplay.html#MESSAGE) instructions get an additional
**STYLE** attribute, to reference a presentation style and define the
rendering with font, color, and position. 

### [STYLE attribute for TOOLBAR and TOPMENU elements]{#toolbar-topmenu-style}

You can now define a style for [TOOLBAR](Toolbars.html) and
[TOPMENU](Topmenus.html) elements. See Front-End documentation for more
details about possible decoration attributes.

### [RADIOGROUP items are filled with INCLUDE list]{#radiogroup_include_to_items}

As with COMBOBOX, the items of a
[RADIOGROUP](FormSpecFiles.html#FF_ITEMTYPE_RADIOGROUP) are now filled
with the values of the INCLUDE attribute, if specified.

### [CSV (Comma Separated Value) format for LOAD/UNLOAD/Channel]{#csv-channel-delimiter}

The [LOAD/UNLOAD](InOutSql.html) SQL instructions and the
[base.Channel](ClassChannel.html) class now support the \"CSV\"
delimiter specification to read/write files in Comma Separated Value
format.

### [Identifying the last clicked canvas item]{#ident-canvas-item}

Before version 2.30, the only way to identify what CANVAS item was
clicked was to bind a specific function key to the item, from F1 to
F255. You can now identify the last clicked item with the
[drawGetClickedItemId()](Canvas.html) function of fgldraw.4gl.

### [Checking the touched flag of all fields used by the dialog]{#all-fields-touched}

The [FIELD_TOUCHED()](Operators.html#OP_FIELD_TOUCHED) operator and
[ui.Dialog.getFieldTouched()](ClassDialog.html#getFieldTouched) method
accept now a simple star as parameter, in order to check all fields used
by the dialog.

### [Getting the type of the current database driver]{#fgl_db_driver_type}

In order to identify the target database type, you can use the
[fgl_db_driver_type()](BuiltInFunctions.html#BF_FGL_DB_DRIVER_TYPE)
built-in function. This function returns the 3-letter code of the
database driver (ifx, ora, ads, db2, \...). See also the
db_get_database_type() function in FGLDIR/src/fgldbutil.4gl, this
function maps the driver type to a database code.

### [Table column header alignment]{#table-column-header-alignment}

The [JUSTIFY](FSFAttributes.html#FA_JUSTIFY) attribute is now supported
for all form item types, in order to let you specify both the data
justification in the field/cell and the alignment of the table column
header. 

### [FGLSQLDEBUG displays shared object load error]{#FGLSQLDEBUG-load-dll-error}

In order to identify the reason why a database driver cannot be loaded,
when setting [FGLSQLDEBUG](EnvironmentVariables.html#EV_FGLSQLDEBUG) you
now get an additional debug message that contains the operating system
error message (dlerror())

### [Schema extractor supports now SQLite]{#fgldbsch-sqlite}

With 2.30 the [fgldbsch](Tools.html#TL_FGLDBSCH) tool can now extract
database schema from SQLiIte. However, pay attention to the data types
used in SQLite (V 3.6): This database supports some standard type names
in the SQL syntax but in reality the types used to store data are very
limited. For example, a DATE will be stored as an integer or string
(i.e. there is no native DATE type). See SQLite documentation for more
details.

The fgldbsch tool will extract the schema according to the original type
names used to create the table.

### [DIALOG.setFieldActive accepts now a list of fields]{#DIALOG_setFieldActive_field_list}

The [ui.Dialog.setFieldActive()](ClassDialog.html#setFieldActive) method
is now accepting a list of fields as parameter, with the
\"dot-asterisk\" notation, like the setFieldTouched() method:

       CALL DIALOG.setFieldActive("customner.*", FALSE)
       CALL DIALOG.setFieldActive("customner.cust_name", TRUE)

**Warning: If all fields of the dialog are disabled, the dialog stops.**

### [New DIALOG methods to manipulate trees]{#DIALOG_methods_tree}

This new feature is part of the fix for bug **#18224**.

When modifying a tree during the dialog execution (for example, when
implementing dynamic trees with ON EXPAND / ON COLLAPSE triggers), if
you use the [ui.Dialog.insertRow()](ClassDialog.html#insertRow),
[ui.Dialog.deleteRow()](ClassDialog.html#deleteRow) or
[ui.Dialog.deleteAllRows()](ClassDialog.html#deleteAllRows) methods to
modify the node list, the internal tree structure was corrupted. You
could safely modify directly the program array with [array
methods](Arrays.html), but multi-range selection flags and cell
attributes are not synchronized when doing this. Starting with
**2.30.02**, you can now use the
[ui.Dialog.insertNode()](ClassDialog.html#insertNode),
[ui.Dialog.appendNode()](ClassDialog.html#appendNode) and
[ui.Dialog.deleteNode()](ClassDialog.html#deleteNode) methods to
manipulate the node list and get secondary data information
synchronized.

### [New FGLPROFILE entry fglrun.arrayIgnoreRangeError]{#fglrun.arrayIgnoreRangeError}

Version **2.30.04** re-enables the **fglrun.arrayIgnoreRangeError**
[FGLPROFILE](FglProfile.html) entry which was supported by Four Js BDS.
This entry can be set to true to force the runtime system to return the
first element of an array when the array index is out of bounds. See
[Arrays](Arrays.html#arrayIgnoreRangeError) for more details.

### [New FGLPROFILE entry fglrun.mapAnyErrorToError]{#fglrun.mapAnyErrorToError}

The version **2.30.04** introduces the new **fglrun.mapAnyErrorToError**
[FGLPROFILE](FglProfile.html) entry. This configuration parameter can be
set to true to map the default action of the WHENEVER ANY ERROR
exceptions to the action defined for the WHENEVER ERROR exception tpye.
See [Exceptions](Exceptions.html#mapAnyErrorToError) for more details.

------------------------------------------------------------------------

## [Version 2.21]{#VERSION_2_21}

- [Modules](#Modules_2_21)
- [SPINEDIT gets VALUEMIN, VALUEMAX](#SPINEDIT_VALMINMAX)
- [New database drivers](#New_DB_Drivers_2_21)
- [New presentation styles](#New_Styles)
- [Numeric keypad decimal separator](#numkeypad_decimal_separator)
- [Automatic display of BYTE images](#auto_dispplay_byte)
- [Paged DISPLAY ARRAY supports undefined initial row
  count](#undef_paged_display_array)
- [Static SQL column definition supports DEFAULT
  clause](#sql_column_default)
- [PostgreSQL driver supports TEXT/BYTE](#pgs_text_byte)
- [Define the initial size of the MDI container](#mdi_container_size)
- [New INSERT syntax to avoid SERIAL column
  usage](#insert_without_serial)
- [Support for C1 Ming Guo date format modifier](#ming_guo_dbdate)
- [New SQL debug message when LOAD fails with error
  -846](#load-error-846)
- [ODBC Character type control with SNC driver](#snc-widechar)
- [New Presentation Style attribute for Windows:
  formScroll](#Style_formScroll)

### [Modules]{#Modules_2_21}

The major new feature of Genero BDL 2.21 is the support of the 42m
module specification with the IMPORT instruction.

Please refer to the following links for more details:

- [Importing modules](CompilingPrograms.html#IMPORT)
- [The IMPORT instruction](Programs.html#IMPORT)
- [FUNCTION definitions (with PRIVATE / PUBLIC
  modifiers)](Functions.html)
- [REPORT definitions (with PRIVATE / PUBLIC modifiers)](Reports.html)
- [Variable definitions (with PRIVATE / PUBLIC
  modifiers)](Variables.html)
- [User Types definitions (with PRIVATE / PUBLIC
  modifiers)](UserTypes.html)
- [Constant definitions (with PRIVATE / PUBLIC
  modifiers)](Constants.html)

### [SPINEDIT gets VALUEMIN, VALUEMAX]{#SPINEDIT_VALMINMAX}

The [SPINEDIT widget](FormSpecFiles.html#FF_ITEMTYPE_SPINEDIT) gets two
new attributes to define the range of possible values:
[VALUEMIN](FSFAttributes.html#FA_VALUEMIN),
[VALUEMAX](FSFAttributes.html#FA_VALUEMAX).

### [New database drivers]{#New_DB_Drivers_2_21}

The following database drivers are supported by Genero version 2.21:

- **dbmads381** for a [Genero db 3.81 client](odiagads.html)
- **dbmesmA0** for an [EasySoft 1.2.3 client](odiagmsv.html)
- **dbmpgs84x** for a [PostgreSQL 8.4.x client](odiagpgs.html)
- **dbmoraB2x** for [Oracle 11g release 2 (11.2)](odiagora.html)

#### [New Genero db 3.81 driver]{#generodb_3_81}

A new driver for Genero db 3.81 is available in version 2.21; the name
is **dbmads381**. This driver no longer scans SQL text for translation,
as most common Informix syntax is now supported in Genero db 3.81 when
using COMPATIBILITY_MODE=INFORMIX. Skipping the SQL text scanning will
improve the performance of your programs.

For more details, see the [ODI Adaptation Guide](odiagads.html).

This driver is also back-ported in 2.20 versions (starting with
2.20.07).

#### [New EasySoft driver to connect from Unix to SQL Server]{#easysoft_msv}

Version 2.21.00 introduces a new set of database drivers based on the
[EasySoft SQL Server ODBC client](http://www.easysoft.com). See the [ODI
Adaptation Guide](odiagmsv.html) for SQL Server for more details about
configuration settings.

This driver is also back-ported in 2.20 versions (starting with
2.20.08).

#### [New PostgreSQL 8.4 driver with INTERVAL support]{#postgresql_8_4}

Version 2.21.00 provides PostgreSQL 8.4 support with the new
**dbmpgs84x** driver. This driver converts Informix-style INTERVALs to
native PostgreSQL INTERVALs. See the [ODI Adaptation
Guide](odiagpgs.html#ODIPGS036) for more details.

This driver is also back-ported in 2.20 versions (starting with
2.20.07).

### [New presentation styles]{#New_Styles}

The following new style attributes were added in version 2.21:

- Window: [actionPanelButtonTextAlign,
  ringMenuButtonTextAlign](PresentationStyles.html#STYATT_WINDOW)
- Image: [alignment](PresentationStyles.html#STYATT_IMAGE)

### [Numeric keypad decimal separator]{#numkeypad_decimal_separator}

With Genero 2.21, the decimal separator key of the numeric keypad does
not follow the application settings for numeric data formatting defined
by [DBMONEY](EnvironmentVariables.html#EV_DBMONEY) or
[DBFORMAT](EnvironmentVariables.html#EV_DBFORMAT). The decimal separator
defined by one of these environment variables will be used when pressing
the dot key of the numeric keypad.

### [Automatic display of BYTE images]{#auto_dispplay_byte}

Image data contained in a [BYTE](DataTypes.html#DT_BYTE) variable can
now be displayed automatically by Genero when using a simple DISPLAY BY
NAME, DISPLAY TO or when the BYTE variable is used by a dialog
instruction. See the ImageList demo, for example, in
FGLDIR/demo/Widgets.

Note that the BYTE data must be located in a file (LOCATE IN FILE
\"path\") or temp file (LOCATE IN FILE)

For more details about image fields, see [IMAGE field
types](FormSpecFiles.html#FF_ITEMTYPE_IMAGE).

### [Paged DISPLAY ARRAY supports undefined initial row count]{#undef_paged_display_array}

Before 2.21, when using a Paged DISPLAY ARRAY, it was mandatory to
provide the total number of rows in the result set, which required a
SELECT COUNT(\*) before executing the dialog instruction. The dialog now
supports an undefined number of rows, with value -1 in the COUNT dialog
attribute.

For more details, see [Paged DISPLAY ARRAY](DisplayArray.html).

### [Static SQL column definition supports DEFAULT clause]{#sql_column_default}

Starting with 2.21 the syntax of the CREATE TABLE and ALTER TABLE Static
SQL statements allows the DEFAULT clause in column definitions.

    CREATE TABLE item ( num SERIAL, name VARCHAR(50) DEFAULT '<undefined>' NOT NULL )

### [PostgreSQL supports TEXT/BYTE]{#pgs_text_byte}

With 2.21 it is now possible to use [TEXT/BYTE data with
PostgreSQL](odiagpgs.html#ODIPGS030) with the **dbmpgs** drivers.

### [Define the initial size of the MDI container]{#mdi_container_size}

Genero BDL 2.21 provides a new
[ui.Interface](ClassInterface.html#setSize) method to let you define the
initial size of the MDI container window:

    CALL ui.Interface.setSize( "600px", "1000px" )

### [New INSERT syntax to avoid SERIAL column usage]{#insert_without_serial}

Version 2.21 supports a new Static SQL syntax for the INSERT statement,
which removes the record member defined as SERIAL, SERIAL8 or BIGSERIAL
in the schema file:

    SCHEMA mydb
    DEFINE record RECORD LIKE table.*
    ...
    INSERT INTO table VALUES record.*

For more details, see [Static SQL](StaticSql.html).

### [Support for C1 Ming Guo date format modifier]{#ming_guo_dbdate}

You can enable the digit-based Ming Guo date format by adding the C1
modifier at the end of the value set for the DBDATE environment
variable:

    $ DBDATE="Y3MD/C1"
    $ export DBDATE

Notes:

- When using C1, the possible values for the Yn specifier are Y4, Y3,
  Y2.
- The MDI() function is sensitive to the C1 modifier usage in DBDATE.
- The USING operator supports the c1 modifier as well.
- The C2 modifier to use Era names is not supported.
- Unlike Informix 4gl, when using negative years, the minus sign is
  placed over the left-most zero of the year.
- Front-ends may not support the Ming Guo calendar for widgets like
  DATEEDIT.

For more details, see [Ming Guo date
format](Localization.html#MING_GUO).

### [New SQL debug message when LOAD fails with error -846]{#load-error-846}

The [LOAD](InOutSql.html) statement can fail with [error
-846](FglErrors.html#-846) when the input file has a corrupted line
(missing or invalid field separator, invalid character set, UNIX/DOS
line terminators). Before 2.21.00, you had to check every line of the
input file to find the problem. With this new version you can now easily
find the invalid line by setting the
[FGLSQLDEBUG](EnvironmentVariables.html#EV_FGLSQLDEBUG) environment
variable. The runtime system will display such debug messages with the
line number:

    | DBI: LOAD: Corrupted data file, check line #12345.

### [ODBC Character type control with SNC driver]{#snc-widechar}

Starting with version **2.21.02**, you can instruct the SNC driver to
use simple char or wide-char character strings for ODBC, with the
following FGLPROFILE entry:

    dbi.database.<dbname>.snc.widechar = true/false

See [SQL Server ODI Adaptation Guide](odiagmsv.html#ODIMSV040) for more
details.

### [New Presentation Style attribute for Windows: formScroll]{#Style_formScroll}

The [formScroll](PresentationStyles.html#STYATT_WINDOW) Presentation
Style attribute can be set for Windows to control scrollbars display
when the Window is larger as the screen.

------------------------------------------------------------------------

## [Version 2.20]{#VERSION_2_20}

See also [Upgrade Notes](Mig0004.html).

- [The Java Interface](#Java_Interface_2_20)
- [Tree-view containers](#tree-view-tables)
- [The traditional user interface mode](#traditional_ui_mode)
- [Phantom fields](#phantom-fields)
- [Multi-row selection in lists](#MultiRowSelection)
- [New built-in data types](#new-data-types-2.20)
- [Built-in sort works in INPUT ARRAY](#built-in-sort-input-array)
- [New database drivers](#New_DB_Drivers_2_20)
- [New contextMenu action default
  attribute](#action-defaults-contextMenu)
- [Private functions](#private-functions)
- [Automatic source documentation generator](#autodoc)
- [MAN pages for Genero BDL commands](#fgl-man-pages)
- [New presentation styles](#New_Presentation_styles_2.20)
- [New front-end calls](#New_FE_Calls_2.20)
- [MySQL driver supports TEXT/BYTE](#MYSQL_2_20_TEXT_BYTE)
- [Writing a timestamp to 42m modules](#fglcomp_timestamp)
- [Disabling Front-End protocol
  compression](#disabling-fe-protocol-compression)
- [New environment variable for program resource
  files](#FGLRESOURCEPATH)
- [New built-in functions to handle text
  selection](#fgl_dialog_setselection)
- [New IMAGE attribute in form LAYOUT element](#layout_image)
- [INFIELD clause for ON ACTION interaction blocks](#on_action_infield)
- [New high-precision math functions for DECIMALs](#high-prec-math-2.20)
- [Database user authentication callback
  function](#database-userauth-callback)
- [Getting the current active dialog](#get-current-dialog)
- [SAX Document Handler specification in START
  REPORT](#START_REPORT_TO_XML_HANDLER)
- [Automatic Code Completion with VIM](#auto-completion-vim)
- [Report definition file generation](#report-definition-file)
- [Improved FGLSQLDEBUG output](#improved-FGLSQLDEBUG)

### [The Java Interface]{#Java_Interface_2_20}

The major new feature of Genero BDL 2.20 is the [Java
Interface](JavaBridge.html). This allows you to instantiate and use Java
classes from FGL.

### [Tree-view containers]{#tree-view-tables}

Genero BDL 2.20 introduces typical Tree-View widgets with the new TREE
container.\
See [Tree Views](TreeViews.html) for more details.

### [The traditional user interface mode]{#traditional_ui_mode}

To simplify migration from Informix 4GL or Four Js BDS, you can now run
applications in traditional mode to render windows as simple boxes, as
in the WTK front-end. For more details, see [Traditional GUI
mode](DynamicUI.html#TRADITIONAL_MODE). See also the new [I4GL migration
guide](MigI4GL.html) and [BDS migration guide](Mig0000.html)

### [Phantom fields]{#phantom-fields}

Genero BDL 2.20 introduces a new sort of form field with the PHANTOM
keyword. Phantom fields are used to define the screen-record or
screen-array, but are not used in the LAYOUT section of the form.
Phantom fields are especially useful when implementing a TREE
container.\
See [Phantom Fields](FormSpecFiles.html#FF_PHANTOM_FIELDS) for more
details.

### [Multi-row selection in lists]{#MultiRowSelection}

[DISPLAY ARRAY](DisplayArray.html) can now handle [multi-row
selection](MultipleDialogs.html#multi-row-selection).

### [New built-in data types]{#new-data-types-2.20}

Version 2.20 introduces three new built-in data types:

- [TINYINT](DataTypes.html#DT_TINYINT) (8 bit signed integer)
- [BIGINT](DataTypes.html#DT_BIGINT) (64 bit signed integer)
- [BOOLEAN](DataTypes.html#DT_BOOLEAN) (8 bit boolean TRUE/FALSE)

### [Built-in sort works in INPUT ARRAY]{#built-in-sort-input-array}

Before version 2.20, built-in sort was only available in DISPLAY ARRAY.
Now the rows can be sorted during an [INPUT ARRAY](InputArray.html).

### [New database drivers]{#New_DB_Drivers_2_20}

The following database drivers are supported by Genero version 2.20:

- **dbmmys60x** for a [MySQL 6.0.x client](odiagmys.html) (2.20.01)
- **dbmsqt3xx** for an [SQLite 3 library](odiagsqt.html) (2.20.01)

### [New contextMenu action default attribute]{#action-defaults-contextMenu}

A new [Action Defaults attribute](ActionDefaults.html) named
\"**contextMenu**\" has been added to allow you to specify whether the
menu option is visible in the default context menu. The default value is
\"yes\" - the option is visible whenever the action is visible.

### [Private functions]{#private-functions}

It is now possible to hide a function (or report) to the other modules
with the new [PRIVATE keyword](Functions.html).

### [Automatic source documentation generator]{#autodoc}

The [fglcomp](Tools.html#TL_FGLCOMP) compiler has been extended with a
new **\--build-doc** option for [generating 4gl source
documentation](AutoDoc.html).

### [MAN pages for Genero BDL commands]{#fgl-man-pages}

On UNIX platforms, you can now use man pages for Genero BDL tools like
fglcomp and fglform:

    $ man fglcomp

Note that on some platforms, you must set the **MANPATH** environment
variable to \$FGLDIR/man.

### [New Presentation styles]{#New_Presentation_styles_2.20}

[Presentation Styles](PresentationStyles.html) have been extended:

- [TEXTEDIT](FormSpecFiles.html#FF_ITEMTYPE_TEXTEDIT) fields can use the
  style attribute
  \"**[integratedSearch](PresentationStyles.html#STYATT_TEXTEDIT)**\" to
  enable a search facility.
- [FOLDER](FormSpecFiles.html#FF_CONTAINER_FOLDER) controls can now get
  a \"**[position](PresentationStyles.html#STYATT_FOLDER)**\" style
  attribute to define the position (top, left, right, bottom) of folder
  tabs.
- [BUTTON](FormSpecFiles.html#FF_ITEMTYPE_BUTTON) form items get a new
  \"**[buttonType](PresentationStyles.html#STYATT_BUTTON)**\" attribute
  to define the rendering of the button.
- [MENUs](Menus.html) created with the popup option can be placed with
  the \"[**position**](PresentationStyles.html#STYATT_MENU)\" attribute.
- [WINDOWs](WindowsAndForms.html) Menu and Action panel decoration can
  be customized using
  \"[**ringMenuDecoration**](PresentationStyles.html#STYATT_WINDOW)\"
  and
  \"[**actionPanelDecoration**](PresentationStyles.html#STYATT_WINDOW)\"
  attributes.\
  New \"**[tabbedContainer](PresentationStyles.html#STYATT_MDI)**\" and
  \"**[tabbedContainerCloseMethod](PresentationStyles.html#STYATT_WINDOW)**
  \" attributes can be used to turn on and customize \"[tabbed
  MDI](MDIWindows.html#tabbedMDI)\" feature.
- [TABLEs](FormSpecFiles.html#FF_CONTAINER_TABLE) can use the new
  \"**[tableType](PresentationStyles.html#STYATT_TABLE)**\" attribute to
  render data in different ways (picture flow).\
  The new
  \"**[resizeFillsEmptySpace](PresentationStyles.html#STYATT_TABLE)**\"
  attribute can be used to define how the last column is resized when
  the table is resized.
- All items with an [image attribute](FSFAttributes.html#FA_IMAGE) can
  use the new
  \"**[imageCache](PresentationStyles.html#STYATT_COMMON)**\" attribute
  to define if the picture can be cached locally.

### [New Front-End Calls]{#New_FE_Calls_2.20}

[Frond-End Functions](FrontEndFunctions.html) have been extended:

- New \"**getwindowid**\" function in the `standard` module to get the
  system window manager id of a window.
- The \"**feinfo**\" function in the `standard` module has been extended
  to query the workstation system version, number of screens, and screen
  resolution. 
- New \"**launchurl**\" function in the `standard` module to open a
  given url (http, mailto\...) with the default installed url handler
  (e.g. your default browser for http, default mailer for mailto\...).

### [MySQL Driver supports TEXT/BYTE]{#MYSQL_2_20_TEXT_BYTE}

It is now possible to use [TEXT/BYTE data with
MySQL](odiagmys.html#ODIMYS030) with the **dbmmys** drivers.

### [Adding a timestamp to 42m modules]{#fglcomp_timestamp}

[fglcomp](Tools.html#TL_FGLCOMP) has a new option (**fglcomp
\--timestamp**) to write the compilation timestamp to the generated 42m
p-code module. If present, the timestamp will be printed when using
**fglrun -b**. Use compilation timestamps only if really needed; every
new compiled .42m module will be different, even if the source code has
not changed.

### [Disabling Front-End protocol compression]{#disabling-fe-protocol-compression}

Front-End protocol compression can now be disabled with a new FGLPROFILE
entry. This is especially useful in fast networks to save processor
time. See [Front-End Protocol](FEProtocol.html#COMPRESSION) for more
details.

### [New environment variable for program resource files]{#FGLRESOURCEPATH}

To work around conflicts with the Informix database path specification
in DBPATH, you can now use the
[FGLRESOURCEPATH](EnvironmentVariables.html#EV_FGLRESOURCEPATH)
environment variable to specify search paths for program resource files
like forms.

### [New built-in functions to handle text selection]{#fgl_dialog_setselection}

New built-in functions are now available to control the part of the text
that is selected in the current field:

[FGL_DIALOG_GETSELECTIONEND()](BuiltInFunctions.html#BF_FGL_DIALOG_GETSELECTIONEND)\
[FGL_DIALOG_SETSELECTION()](BuiltInFunctions.html#BF_FGL_DIALOG_SETSELECTION)

### [New IMAGE attribute in form LAYOUT element]{#layout_image}

The [LAYOUT](FormSpecFiles.html#SECTION_LAYOUT) element of a form
definition can now use the IMAGE attribute to define the icon to be used
for the parent Window. This is especially useful in a [Container-based
application](MDIWindows.html), to distinguish child programs inside the
container.

### [INFIELD clause in ON ACTION interactive block]{#on_action_infield}

The ON ACTION interactive block has been extended with a new [INFIELD
*field-name* clause](InteractionModel.html#ON_ACTION_INFIELD), to
automatically enable/disable the action when entering/leaving the
specified field.

### [New high-precision math functions for DECIMALs]{#high-prec-math-2.20}

Following built-in functions have been added for precision math
computing with DECIMALs:

- [FGL_DECIMAL_TRUNCATE()](BuiltInFunctions.html#BF_FGL_DECIMAL_TRUNCATE)
- [FGL_DECIMAL_SQRT()](BuiltInFunctions.html#BF_FGL_DECIMAL_SQRT)
- [FGL_DECIMAL_EXP()](BuiltInFunctions.html#BF_FGL_DECIMAL_EXP)
- [FGL_DECIMAL_LOGN()](BuiltInFunctions.html#BF_FGL_DECIMAL_LOGN)
- [FGL_DECIMAL_POWER()](BuiltInFunctions.html#BF_FGL_DECIMAL_POWER)

### [Database user authentication callback function]{#database-userauth-callback}

When using the DATABASE instruction, you can now define an [FGLPROFILE
entry specifying a callback function](Connections.html#DBCUSERAUTH)
which returns a username and password to be used for the database
connection.

### [Getting the current active dialog]{#get-current-dialog}

A new class method is now available to get the current active dialog:
[ui.Dialog.getCurrent()](ClassDialog.html#getCurrent).

### [SAX Document Handler specification in START REPORT]{#START_REPORT_TO_XML_HANDLER}

The START REPORT instruction now supports a new clause to specify the
XML SAX Document Handler to process XML output with the [TO XML HANDLER
syntax](Reports.html#RPT_XML).

### [Automatic Code Completion with VIM]{#auto-completion-vim}

If you have vim 7 installed, you can now use [.per and .4gl code
completion](CodeEditing.html#VIM_AC) within your preferred editor. 

### [Report definition file generation]{#report-definition-file}

With fglcomp 2.20 you can use the \--build-rdd option to generate a data
definition file (.rdd)

### [Improved FGLSQLDEBUG output]{#improved-FGLSQLDEBUG}

When setting the [FGLSQLDEBUG environment
variable](EnvironmentVariables.html#EV_FGLSQLDEBUG), you get now the SQL
command header with SQL command name and 4GL source/line information
[before]{.underline} executing the underlying ODI driver code. If the
driver code crashes or stops the process with an assertion, you can
easily identify the last SQL instruction that was executed. Before
version 2.20, SQL debug output was printed [after]{.underline} the
execution of the ODI driver code. If the ODI driver encountered a
problem, you could not find what SQL instruction was the reason for the
crash.

------------------------------------------------------------------------

## [Version 2.11]{#VERSION_2_11}

- [New database drivers](#New_DB_Drivers_2_11)
- [Static SQL syntax extension](#Static_SQL_2_11)
  - [Derived tables and derived column list](#derived_tables)
  - [New transaction isolation levels of Informix 11](#ifx11_isolation)
  - [The CAST operator](#cast_operator)
- [New preprocessor option to remove line number
  information](#prepro-noli-option)
- [Connecting to Oracle as SYSDBA or
  SYSOPER](#sysdba-sysoper-connection)
- [New methods for ui.ComboBox](#ui.ComboBox-2.11)
- [Make current row visible after sort in
  lists](#currentRowVisibleAfterSort)
- [Reading pcode build information of older
  versions](#read-old-build-info)

### [New database drivers]{#New_DB_Drivers_2_11}

The following database drivers are supported by Genero version 2.11:

- **dbmpgs83x** for a [PostgreSQL 8.3.x client](odiagpgs.html) (2.11.02)
- **dbmftm90** for a [FreeTDS client](odiagmsv.html) connecting to SQL
  Server 2005 (2.11.02)
- **dbmsncA0** for a [SQL Server Native client](odiagmsv.html)
  connecting to SQL Server 2008 (2.11.02)
- **dbmoraB1** for an [Oracle 11g client](odiagora.html) (2.11.02)
- **dbmads380** for a [Genero db Server 3.80 client](odiagads.html)
  (2.11.05)
- **dbmmys51x** for a [MySQL 5.1.x client](odiagmys.html) (2.11.10)

### [Static SQL syntax extension]{#Static_SQL_2_11}

#### [Derived tables and derived column list]{#derived_tables}

Genero BDL static SQL syntax now supports derived tables and derived
column lists in the FROM clause, for example:

       SELECT * FROM (SELECT * FROM customers ORDER BY cust_num) AS t(c1,c2,c3,...)

See database server documentation for more details about this SQL
feature. Note that Informix 11 does not support the full ANSI SQL 92
specification for derived columns, while other databases like DB2 do.
For this reason, fglcomp allows the ANSI standard syntax.

#### [New transaction isolation levels of Informix 11]{#ifx11_isolation}

The SET ISOLATION statement now supports the new Informix 11 clauses for
the COMMITTED READ option:

       SET ISOLATION TO COMMITTED READ [LAST COMMITTED] [RETAIN UPDATE LOCKS]

When connecting to a non-Informix database, the LAST COMMITTED and
RETAIN UPDATE LOCKS are ignored; other databases do not support these
options, and have the same behavior as when these options are used with
Informix 11.

#### [The CAST operator]{#cast_operator}

The CAST operator can now be used in static SQL statements:

       CAST ( expression AS sql-data-type ) 

Note that only Informix data types are supported after the AS keyword.

### [New preprocessor option to remove line number information]{#prepro-noli-option}

You can now remove line number information with **-p noln** when
preprocessing sources to get a readable output:

       fglcomp -E -p noln mymodule.4gl

### [Connecting to Oracle as SYSDBA or SYSOPER]{#sysdba-sysoper-connection}

In order to execute database administration tasks, you can now connect
to Oracle as SYSDBA or SYSOPER with the [CONNECT
instruction](Connections.html#UA_ORA):

       CONNECT TO "dbname" USER "scott/SYSDBA" USING "tiger"

### [New methods for ui.ComboBox]{#ui.ComboBox-2.11}

The [ui.ComboBox](ClassComboBox.html) class has been extended with new
methods: getTextOf() and getIndexOf().

### [Make current row visible after sort in lists]{#currentRowVisibleAfterSort}

A new [FGLPROFILE](FglProfile.html) entry has been added to force the
current row to be shown automatically after a sort in a table:

       Dialog.currentRowVisibleAfterSort = 1

By default, the offset does not change and the current row may disappear
from the window. When this new parameter is used, the current row will
always be visible. For more details, see [Runtime
Configuration](Programs.html#RUNTIMECONFIG).

### [Reading pcode build information of older versions]{#read-old-build-info}

The **-b** option of [fglrun](Tools.html#TL_FGLRUN) has been extended to
recognize headers of pcode modules compiled with older versions of FGL.
For more details, see [Compiling
Programs](CompilingPrograms.html#BUILDINFO). Additionally,
[fglform](Tools.html#TL_FGLFORM) now writes build information in the 42f
files, to identify on the production site what Genero BDL version was
used to compile forms.

------------------------------------------------------------------------

## [Version 2.10]{#VERSION_2_10}

See also [Upgrade Notes](Mig0003.html).

- [Multiple Dialogs](#Multiple_Dialogs_2.10)
- [TRY/CATCH pseudo statement](#TRY_CATCH_pseudo_statement_2.10)
- [WHENEVER \... RAISE](#WHENEVER_RAISE_2.10)
- [SQL Server Native Client
  driver](#SQL_Server_Native_Client_driver_2.10)
- [Support for SPLITTER attribute](#Support_for_SPLITTER_attribute_2.10)
- [Double-click in tables](#Double_click_in_tables_2.10)
- [New X conversion code in fgldbsch](#New_X_conversion_code_2.10)
- [SQL Interruption in database drivers](#SQL_Interruption_2.10)
- [NULL pointer exceptions can be
  trapped](#NULL_pointer_exceptions_2.10)
- [Client socket interface in Channels](#Client_socket_interface_2.10)
- [Stack trace](#Stack_trace_2.10)
- [GUI connection timeout](#GUI_Connection_Timeout_2.10)
- [Assigning a value to a TEXT variable](#Assigning_value_to_TEXT_2.10)
- [New presentation styles](#New_Presentation_styles_2.10)
- [fglrun -s option now displays more
  information](#fglrun_dash_s_option_2.10)
- [fglrun -e option takes list of
  extensions](#fglrun_dash_e_option_2.10)
- [Detecting data changes immediately](#Detecting_data_changes_2.10)
- [Controlling data validation for
  actions](#Controlling_data_validation_2.10)
- [New MINWIDTH, MINHEIGHT attribute in
  forms](#New_MINWIDTH_MINHEIGHT_2.10)
- [Avoid automatic temporary row in INPUT
  ARRAY](#Avoid_automatic_temporary_row_2.10)
- [New DOM methods to serialize or parse
  strings](#New_DOM_methods_for_strings)
- [New I/O methods to read/write TEXT or BYTE from/to
  files](#New_IO_methods_for_TEXT_BYTE)

### [Multiple Dialogs]{#Multiple_Dialogs_2.10}

A new [DIALOG instruction](MultipleDialogs.html) handles different parts
of a form simultaneously.  See also [ui.Dialog class](ClassDialog.html).

### [TRY/CATCH pseudo statement]{#TRY_CATCH_pseudo_statement_2.10}

The [TRY/CATCH pseudo statement](Exceptions.html#TRYCATCH) can handle
exceptions raised by the runtime system.

### [WHENEVER \.... RAISE]{#WHENEVER_RAISE_2.10}

Instructs the DVM that an uncaught exception will be handled by the
caller of the function. See [Exceptions](Exceptions.html).

### [SQL Server Native Client driver]{#SQL_Server_Native_Client_driver_2.10}

Support for [SQL Server 2005 Native Client](odiagmsv.html#ODIMSV_PREP02)
is now provided.

### [Support for SPLITTER attribute]{#Support_for_SPLITTER_attribute_2.10}

HBox and VBox containers can now have a splitter.  See also [Layout
Tags](FormSpecFiles.html#FF_LAYOUT_TAG).

### [Double-click in tables]{#Double_click_in_tables_2.10}

With the new [DOUBLECLICK](FSFAttributes.html#FA_DOUBLECLICK) table
attribute, it is now possible to send a specific action when the user
double-clicks on a row.

### [New X conversion code in fgldbsch]{#New_X_conversion_code_2.10}

The [fgldbsch](Tools.html#TL_FGLDBSCH) tool now supports the X
conversion code to ignore table columns of a specific type. This is
useful for ROWID-like columns such as SQL Server\'s *uniqueidentifier*
columns.

### [SQL Interruption]{#SQL_Interruption_2.10} in database drivers

Before version **2.10**, [SQL
interruption](SqlProgramming.html#SQL_INTERRUPTION) was not supported
well for Oracle, SQL Server, DB2 and Genero db databases. SQL
interruption is now available with all databases providing an API to
cancel a long-running query.

For more details, see [SQL
Programming](SqlProgramming.html#SQL_INTERRUPTION).

### [NULL pointer exceptions]{#NULL_pointer_exceptions_2.10} can be trapped

Error **-8083** will be raised if you try to call an object method with
a variable that does not reference an object (that contains NULL):

    DEFINE x ui.Dialog
    -- x is NULL
    CALL x.setFieldActive("fieldname",FALSE)  -- raises -8083

In previous versions, this raised a fatal NULL pointer error. This
exception can now be trapped with  [WHENEVER
ERROR](Exceptions.html#WHENEVER).

### [Client socket interface]{#Client_socket_interface_2.10} in Channels

The Channel class now provides a method to establish a client socket
connection to a server, with the new
[openClientSocket()](ClassChannel.html#open-client-socket) method.

### [Stack trace]{#Stack_trace_2.10}

For debugging purpose, you can now get the stack trace of the program
with the [Application.getStackTrace()](ClassApplication.html#debugging)
method.

### [GUI Connection Timeout]{#GUI_Connection_Timeout_2.10}

It is now possible to define a timeout delay for front-end connections
with the following [FGLPROFILE](FglProfile.html) entry:

    gui.connection.timeout = seconds

See [Dynamic User Interface](DynamicUI.html#FECONN_TIMEOUT) for more
details.

### [Assigning a value to a TEXT variable]{#Assigning_value_to_TEXT_2.10} 

Before version **2.10**, it was only possible to assign a
[TEXT](DataTypes.html#DT_TEXT) to a TEXT variable. Now you can assign
[STRING](DataTypes.html#DT_STRING), [CHAR](DataTypes.html#DT_CHAR) and
[VARCHAR](DataTypes.html#DT_VARCHAR) values to a TEXT variable. For more
details about data type conversions, see the [Data Conversion
Table](DataConversions.html#CONVERSION_TABLE).

### [New Presentation styles]{#New_Presentation_styles_2.10}

[Presentation Styles](PresentationStyles.html) have been extended:

- The style attribute
  \"**[position](PresentationStyles.html#STYATT_WINDOW)**\" for
  [Windows](WindowsAndForms.html) can be set to \"**previous**\".
- [TEXTEDIT](FormSpecFiles.html#FF_ITEMTYPE_TEXTEDIT) now has the
  \"**[textSyntaxHighlight](PresentationStyles.html#STYATT_TEXTEDIT)**\"
  attribute (value can be \"**per**\", more to come\...).
- All widgets can now use the
  \"**[localAccelerators](PresentationStyles.html#STYATT_COMMON)**\"
  global style attribute to interpret standard navigation and editor
  keys (like Home/End) without firing an action that uses the same keys
  as accelerators.

### [fglrun -s option]{#fglrun_dash_s_option_2.10} now displays more information

The -s option of fglrun now reports more information about sizes. See
[Optimization](Optimization.html) for more details.

### [fglrun -e option]{#fglrun_dash_e_option_2.10} takes list of extensions

The fglrun -e option now supports a comma-separated list of extensions,
and -e can be specified multiple times:

    fglrun -e ext1,ext2,ext3 -e ext4,ext5 myprogram

See [C Extensions](CExtensions.html) for more details.

### [Detecting data changes]{#Detecting_data_changes_2.10} immediately

It is now possible to get an action event when the user modifies the
value of a field, with the [predefined dialogtouched
action](InteractionModel.html#DIRTY).

### [Controlling data validation]{#Controlling_data_validation_2.10} for actions

You can now use the validate=\"no\" action default attribute to [prevent
data validation](InteractionModel.html#VALIDATE) when executing an
action.

### [New MINWIDTH, MINHEIGHT]{#New_MINWIDTH_MINHEIGHT_2.10} attributes in forms

It is now possible to define a minimum width and height for forms with
the [MINWIDTH](FSFAttributes.html#FA_MINWIDTH),
[MINHEIGHT](FSFAttributes.html#FA_MINHEIGHT) attributes.

### [Avoid automatic temporary row]{#Avoid_automatic_temporary_row_2.10} in INPUT ARRAY

With the new [AUTO
APPEND](MultipleDialogs.html#input-array-attribute-auto-append)
attribute, you can now avoid the automatic creation of a [temporary
row](MultipleDialogs.html#temporary-rows) in INPUT ARRAY.

### [New DOM methods to serialize or parse strings]{#New_DOM_methods_for_strings}

The parse() and toString() methods are now available for a
[DomNode](ClassDomNode.html) object, and a
[DomDocument](ClassDomDocument.html) object can be created with
createFromString().

### [New I/O methods to read/write TEXT or BYTE from/to files]{#New_IO_methods_for_TEXT_BYTE}

The [TEXT](DataTypes.html#DT_TEXT) and [BYTE](DataTypes.html#DT_BYTE)
data types now support the methods readFile(fileName) and
writeFile(fileName). 

[Back to the top](#PAGE_HEADER)

------------------------------------------------------------------------

## [Version 2.02]{#VERSION_2_02}

- [New Static SQL Commands](#New_Static_SQL_Commands_2.02)
- [Global Variables in C
  Extensions](#Global_Variables_in_C_Extensions_2.02)
- [Localization of runtime system error
  messages](#Localization_of_runtime_system_error_messages_2.02)
- [Debugger enhancement](#Debugger_enhancement_2.02)
- [Tab index can be zero](#Tab_index_can_be_zero_2.02)
- [New FGLPROFILE entry for Oracle
  driver](#New_FGLPROFILE_entry_for_Oracle_driver_2.02)
- [New FGLPROFILE entry to define temporary table emulation
  type](#New_FGLPROFILE_entry_to_define_temporary_table_emulation_type_2.02)

### [New Static SQL Commands]{#New_Static_SQL_Commands_2.02}

Some common SQL statements have been added to the static SQL syntax,
such as TRUNCATE TABLE, RENAME INDEX, CREATE / ALTER / DROP / RENAME
SEQUENCE. See [Static SQL Commands](StaticSql.html).

### [Global Variables in C Extensions]{#Global_Variables_in_C_Extensions_2.02}

You can now share global variables between the Genero BDL source and the
C Extension, by using the -G option of fglcomp. See [Global variables in
C Extensions](CExtensions.html#SHARING_GLOBALS).

### [Localization of runtime system error messages]{#Localization_of_runtime_system_error_messages_2.02}

It is now possible to customize the runtime system error messages
according to the current locale. See
[Localization](Localization.html#RTMSG) for more details.

### [Debugger enhancement]{#Debugger_enhancement_2.02}

New debugger commands ([ptype](Debugger.html#CMD_PTYPE)).

You can now avoid switching into debug mode with SIGTRAP (Unix) or
CTRL-Break (Windows) with the new
[fglrun.ignoreDebuggerEvent](Debugger.html#SIGTRAP) FGLPROFILE entry.

### [Tab index can be zero]{#Tab_index_can_be_zero_2.02}

You can now specify a TABINDEX of zero to exclude the form item from the
tagging list. See [TABINDEX](FSFAttributes.html#FA_TABINDEX) for more
details.

### [New FGLPROFILE entry for Oracle driver]{#New_FGLPROFILE_entry_for_Oracle_driver_2.02}

It is now possible to specify the SELECT statement producing the unique
session identifier which is used for temporary table names.\
See [Database vendor specific
parameters](Connections.html#DS_ODI_DBVSPEC) for more details.

### [New FGLPROFILE entry to define temporary table emulation type]{#New_FGLPROFILE_entry_to_define_temporary_table_emulation_type_2.02}

To emulate Informix temporary tables, you can now set the
**temptables.emulation** parameter to use GLOBAL TEMPORARY TABLES
instead of permanent tables.\
See [temporary table emulation](odiagora.html#ODIORA017) for more
details.

[Back to the top](#PAGE_HEADER)

------------------------------------------------------------------------

## [Version 2.01]{#VERSION_2_01}

- [FESQLC compiler (V2)](#FESQLC_compiler_V2_2.01)
- [DB2 V9.x support](#DB2_V9.x_support_2.01)
- [PostgreSQL V 8.2.x support](#PostgreSQL_V_8.2.x_support_2.01)
- [Extension of the form layout tag
  syntax](#Extension_of_the_form_layout_tag_syntax_2.01)
- [Negative form of warning flags in
  fglcomp](#Negative_form_of_warning_flags_in_fglcomp_2.01)
- [Run supports ComSpec variables on
  Windows](#Run_supports_ComSpec_variable_on_Windows_2.01)

### [FESQLC compiler (V2)]{#FESQLC_compiler_V2_2.01}

ESQL/C Compiler.

**Warning: Since version 2.32, fesqlc is no longer part of Genero BDL
package and is shipped as a separate product.**

### [DB2 V9.x support]{#DB2_V9.x_support_2.01}

Support of DB2 V9.x. See [DB2 V9.x support](odiagdb2.html).

### [PostgreSQL V 8.2.x support]{#PostgreSQL_V_8.2.x_support_2.01}

Support of PostgreSQL 8.2.x. See [PostgreSQL V 8.2.x
support](odiagpgs.html).

### [Extension of the form layout tag syntax]{#Extension_of_the_form_layout_tag_syntax_2.01}

The [layout tag syntax](FormSpecFiles.html#FF_LAYOUT_TAG) in grids has
been extended to support an ending tag to get better control of form
layout.

### [Negative form of warning flags in fglcomp]{#Negative_form_of_warning_flags_in_fglcomp_2.01}

The fglcomp compiler now supports a negative form for [warning
arguments](Tools.html#FglCompWarningFlags).

### [Run supports ComSpec variable on Windows]{#Run_supports_ComSpec_variable_on_Windows_2.01}

When using the [RUN](Programs.html#RUN) command, the ComSpec environment
variable is now used under Windows platforms.

[Back to the top](#PAGE_HEADER)

------------------------------------------------------------------------

## [Version 2.00]{#VERSION_2_00}

See also [Upgrade Notes](Mig0002.html).

- [Dynamic Runner Architecture](#Dynamic_Runner_Architecture_2.00)
- [User defined types](#User_defined_types_2.00)
- [New Widgets](#New_Widgets_2.00)
- [Extended Schema Files](#Extended_Schema_Files_2.00)
- [File Management Functions](#File_Management_Functions_2.00)
- [Math Functions](#Math_Functions_2.00)
- [Stored procedure calls](#Stored_procedure_calls_2.00)
- [Informix-like C API library](#Informix-like_C_API_library_2.00)
- [Memory usage optimization](#Memory_usage_optimization_2.00)
- [The IMPORT instruction](#The_IMPORT_instruction_2.00)
- [WIDTH and HEIGHT attributes in
  Images](#WIDTH_and_HEIGHT_attributes_in_Images_2.00)
- [New debugger commands](#New_debugger_commands_2.00)
- [Improved Presentation Styles](#Improved_Presentation_Styles_2.00)
- [Compiler supports constraints in CREATE
  TABLE](#Compiler_supports_constraints_in_CREATE_TABLE_2.00)
- [Automatic front-end startup](#Automatic_front-end_startup_2.00)
- [New channel function to detect
  EOF](#New_channel_function_to_detect_EOF_2.00)
- [Responding to CTRL_LOGOFF_EVENT on
  Windows](#Responding_to_CTRL_LOGOFF_EVENT_on_Windows_2.00)
- [New compiler warning options](#New_compiler_warning_options_2.00)
- [Fourth accelerator definition](#Fourth_accelerator_definition_2.00)
- [Conditional TTY attributes for all
  widgets](#Conditional_TTY_attributes_for_all_widgets_2.00)
- [New FGL_SETENV() built-in
  function](#New_FGL_SETENV()_built-in_function_2.00)
- [Support for entities in XML reader and
  writer](#Support_for_entities_in_XML_reader_and_writer_2.00)
- [Schema extractor supports now Informix
  LVARCHAR](#Schema_extractor_supports_now_Informix_LVARCHAR)

### [Dynamic Runner Architecture]{#Dynamic_Runner_Architecture_2.00}

Runner now uses shared libraries; you no longer need to link a runner.
See [Dynamic Runner Architecture](Installation.html).

### [User defined types]{#User_defined_types_2.00}

You can now define your own data type with records or arrays. See [User
defined types](UserTypes.html).

### [New Widgets]{#New_Widgets_2.00}

New widgets have been added:
[SLIDER](FormSpecFiles.html#FF_ITEMTYPE_SLIDER),
[SPINEDIT](FormSpecFiles.html#FF_ITEMTYPE_SPINEDIT),
[TIMEEDIT](FormSpecFiles.html#FF_ITEMTYPE_TIMEEDIT).

### [Extended Schema Files]{#Extended_Schema_Files_2.00}

Database Schema files have been extended for Genero
([FIELD](FormSpecFiles.html#FF_ITEMTYPE_FIELD) item type). See [Extended
Schema Files](DatabaseSchema.html).

### [File Management Functions]{#File_Management_Functions_2.00}

File management function library provided as loadable extension. See
[File Management Functions](Ext_os_Path.html).

### [Math Functions]{#Math_Functions_2.00}

Mathematical function library provided as loadable extension. See [Math
Functions](Ext_util_Math.html).

### [Stored procedure calls]{#Stored_procedure_calls_2.00}

It is now possible to call stored procedures with output parameters. See
[Stored procedure calls](SqlProgramming.html#PROG_STOPROC).

### [Informix-like C API library]{#Informix-like_C_API_library_2.00}

C extension support has been extended with Informix-like C API
functions. See [Informix-like C API library](CExtensions.html#CAPI).

### [Memory usage optimization]{#Memory_usage_optimization_2.00}

The runtime system now shares several static elements among all
processes, reducing the memory usage. The shared elements are: Data type
definitions, string constants and debug information. For example, when a
program defines a string containing a long SQL statement, all Genero
processes will share the same string, which is allocated only once.

### [The IMPORT instruction]{#The_IMPORT_instruction_2.00}

To declare a C extension module, you must now use the
[IMPORT](Programs.html#IMPORT) instruction at the beginning of a module.

### [WIDTH and HEIGHT attributes in Images]{#WIDTH_and_HEIGHT_attributes_in_Images_2.00}

You can now specify the WIDTH and HEIGHT attributes for
[IMAGE](FormSpecFiles.html#FF_ITEMTYPE_IMAGE) form items, as a
replacement for PIXELWIDTH / PIXELHEIGHT.

### [New debugger commands]{#New_debugger_commands_2.00}

New commands have been added to the debugger
([call](Debugger.html#CMD_CALL), [ignore](Debugger.html#CMD_IGNORE)).

### [Improved Presentation Styles]{#Improved_Presentation_Styles_2.00}

You can now specify pseudo selectors such as *focus*, *active*,
*inactive*, *input*, *display* for fields and *odd* / *even* states for
table rows.

Some new style attributes were added:

- \'errorMessagePosition\' can be used for Windows to define how the
  ERROR message must be displayed;
- \'highlightTextColor\' for tables allows you to change the color of
  the selected line;
- \'border\' allows you to remove the border of some widgets like
  button, images;
- \'firstDayOfWeek\' can be used for DateEdit widget to specify the
  first day of the week in the calendar;
- The auto-selection behavior for ComboBoxes and RadioGroup can be
  changed using \'autoSelectionStart\'.

For more details, see [Presentation Styles](PresentationStyles.html).

### [Compiler supports constraints in CREATE TABLE]{#Compiler_supports_constraints_in_CREATE_TABLE_2.00}

It is now possible to specify primary key, foreign key and check
constraints in static CREATE TABLE statements:

      CREATE TABLE t1 (
         col1 INTEGER PRIMARY KEY,
         col2 CHAR(2),
         col3 DATE,
         FOREIGN KEY (col2) REFERENCES t2(col1)
      )

### [Automatic front-end startup]{#Automatic_front-end_startup_2.00}

In X11 or Windows TSE environments, you can now automatically start up
the front-end with FGLPROFILE entries. See [Dynamic User
Interface](DynamicUI.html#AUTOSTART) for more details.

### [New channel function to detect EOF]{#New_channel_function_to_detect_EOF_2.00}

The [Channel](ClassChannel.html) class now has an isEof() method to
detect end of file.

### [Responding to CTRL_LOGOFF_EVENT on Windows]{#Responding_to_CTRL_LOGOFF_EVENT_on_Windows_2.00}

It is now possible to ignore the
[CTRL_LOGOFF_EVENT](Programs.html#CTRL_LOGOFF_EVENT) events on Windows
platforms.

### [New compiler warning options]{#New_compiler_warning_options_2.00}

The fglcomp compiler has new warning flags: See
[fglcomp](Tools.html#FglCompWarningFlags) for more details.

### [Fourth accelerator definition]{#Fourth_accelerator_definition_2.00}

You can now define a fourth accelerator for an action in [actions
defaults](ActionDefaults.html) or in the [form
files](FormSpecFiles.html#SECTION_ACTDEFS).

### [Conditional TTY attributes for all widgets]{#Conditional_TTY_attributes_for_all_widgets_2.00}

It is now possible to specify TTY attributes (COLOR, REVERSE) and
conditional TTY attributes (COLOR WHERE) for all type of fields.\
See [Form Specification Files](FormSpecFiles.html) and [COLOR
WHERE](FSFAttributes.html#FA_COLOR_WHERE) attribute for more details.

### [New FGL_SETENV() built-in function]{#New_FGL_SETENV()_built-in_function_2.00}

A new built-in function has been added to set an environment variable:
[FGL_SETENV()](BuiltInFunctions.html#BF_FGL_SETENV).

### [Support for entities in XML reader and writer]{#Support_for_entities_in_XML_reader_and_writer_2.00}

The [XML reader and writer classes](XmlUtils.html) have been extended to
properly support markup language entities (like HTML\'s **\&nbsp;** ).

### [Schema extractor supports now Informix LVARCHAR]{#Schema_extractor_supports_now_Informix_LVARCHAR}

The [fgldbsch](Tools.html#TL_FGLDBSCH) tool can now extract database
tables with LVARCHAR columns. The LVARCHAR type is converted to
VARCHAR2(n\>255) in the .sch file.

[Back to the top](#PAGE_HEADER)

------------------------------------------------------------------------

## [Version 1.33]{#VERSION_1_33}

- [TypeInfo class](#TypeInfo_class_1.33)
- [Generic ODBC support](#Generic_ODBC_support_1.33)
- [MySQL 5 support](#MySQL_5_support_1.33)
- [Genero db 3.4 support](#Genero_DB_3.4_support_1.33)
- [PostgreSQL 8.1 support](#PostgreSQL_8.1_support_1.33)
- [SQL Server 2005 support](#SQL_Server_2005_support_1.33)
- [New license manager](#New_license_manager_1.33)
- [FESQLC compiler (V1)](#FESQLC_compiler_V1_1.33)
- [Binary mode in Channel class](#Binary_mode_in_Channel_class_1.33)
- [New header files for C
  extensions](#New_header_files_for_C_extensions_1.33)
- [Block fetch with SQL Server](#Block_fetch_with_SQL_Server_1.33)
- [Third accelerator definition](#Third_accelerator_definition_1.33)

### [TypeInfo class]{#TypeInfo_class_1.33}

A class to serialize program variables. See [TypeInfo
class](ClassTypeInfo.html).

### [Generic ODBC support]{#Generic_ODBC_support_1.33}

A generic ODBC database driver is now available (code is **odc**). See
[Generic ODBC support](Connections.html).

### [MySQL 5 support]{#MySQL_5_support_1.33}

MySQL version 5 is now supported. See [MySQL 5. support](odiagmys.html).

### [Genero db 3.4 support]{#Genero_DB_3.4_support_1.33}

Genero db version 3.4 is now supported. See [Genero db
support](odiagads.html).

### [PostgreSQL 8.1 support]{#PostgreSQL_8.1_support_1.33}

PostgreSQL version 8.1 is now supported. See [PostgreSQL 8.1
support](odiagpgs.html).

### [SQL Server 2005 support]{#SQL_Server_2005_support_1.33}

Microsoft SQL Server 2005 is now supported. See [SQL Server 2005
support](odiagmsv.html).

### [New license manager]{#New_license_manager_1.33}

New license manager supporting strict licensing. See [New license
manager](Installation.html).

### [FESQLC compiler (V1)]{#FESQLC_compiler_V1_1.33}

ESQL/C compiler.

### [Binary mode in Channel class]{#Binary_mode_in_Channel_class_1.33}

The [base.Channel](ClassChannel.html) class now supports a binary mode
with the \'b\' option, to control CR/LF translation when using DOS
files.

### [New header files for C extensions]{#New_header_files_for_C_extensions_1.33}

Distribution of Datetime.h, Interval.h, loc_t.h header files in
FGLDIR/include/f2c.

### [Block fetch with SQL Server]{#Block_fetch_with_SQL_Server_1.33}

You can now pre-fetch rows by block with SQL Server to get better
performance. Use the following FGLPROFILE entry to specify the maximum
number of rows the driver can pre-fetch:

    dbi.database.<dbname>.msv.prefetch.rows = <count>

See [\"Database vendor specific parameters\" in
Connections](Connections.html#DS_ODI_DBVSPEC) for more details.

### [Third accelerator definition]{#Third_accelerator_definition_1.33}

You can now define a third accelerator for an action in [actions
defaults](ActionDefaults.html) or in the [form
files](FormSpecFiles.html#SECTION_ACTDEFS).

[Back to the top](#PAGE_HEADER)

------------------------------------------------------------------------

## [Version 1.32]{#VERSION_1_32}

- [PostgreSQL 8.0 support](#PostgreSQL_8.0_support_1.32)
- [File transfer functions](#File_transfer_functions_1.32)
- [Debugger enhancement](#Debugger_enhancement_1.32)
- [Preprocessor is now integrated in
  compilers](#Preprocessor_is_now_integrated_in_compilers_1.32)

### [PostgreSQL 8.0 support]{#PostgreSQL_8.0_support_1.32}

PostgreSQL version 8.0 is now supported (8.0.2 and higher). See
[PostgreSQL 8.0 support](odiagpgs.html).

### [File transfer functions]{#File_transfer_functions_1.32}

Get/Put functions to transfer files from/to the front-end. See [File
transfer functions](BuiltInFunctions.html#BF_FGL_PUTFILE).

### [Debugger enhancement]{#Debugger_enhancement_1.32}

New debugger commands ([watch](Debugger.html#CMD_WATCH) with condition,
[whatis](Debugger.html#CMD_WHATIS)).

### [Preprocessor is now integrated in compilers]{#Preprocessor_is_now_integrated_in_compilers_1.32}

The [preprocessor](Preprocessor.html) is now part of the compilers and
is always enabled. Preprocessing directives start with an ampersand
character (**&**).

[Back to the top](#PAGE_HEADER)

------------------------------------------------------------------------

## [Version 1.31]{#VERSION_1_31}

- [Front-end Protocol Compression](#Front-end_Protocol_Compression_1.31)
- [MySQL 4.1.x support](#MySQL_4.1.x_support_1.31)
- [Oracle 10g support](#Oracle_10g_support_1.31)
- [Dynamic C extensions](#Dynamic_C_extensions_1.31)
- [New built-in functions](#New_built-in_functions_1.31)
- [Interruption handling](#Interruption_handling_1.31)
- [New Dialog method](#New_Dialog_method_1.31)
- [Front-end identification](#Front-end_identification_1.31)

### [Front-end Protocol Compression]{#Front-end_Protocol_Compression_1.31}

Faster user interface communication. See [Front-end Protocol
Compression](FEProtocol.html).

### [MySQL 4.1.x support]{#MySQL_4.1.x_support_1.31}

MySQL version 4.1.x is now supported, 3.23 is de-supported. See [MySQL
4.1.x support](odiagmys.html).

### [Oracle 10g support]{#Oracle_10g_support_1.31}

Oracle version 10g is now supported. See [Oracle 10g
support](odiagora.html).

### [Dynamic C extensions]{#Dynamic_C_extensions_1.31}

C extensions can be loaded dynamically, no need to re-link runner. See
[Dynamic C extensions](CExtensions.html).

### [New built-in functions]{#New_built-in_functions_1.31}

The [FGL_WIDTH](BuiltInFunctions.html#BF_FGL_WIDTH) built-in function
computes the number of print columns needed to represent a single or
multi-byte character.

### [Interruption handling]{#Interruption_handling_1.31}

Interruption handling with SSH port forwarding - only supported with GDC
1.31!

### [New Dialog method]{#New_Dialog_method_1.31}

New method [ui.Form.setFieldStyle()](ClassForm.html) to set a style for
a field.

### [Front-end identification]{#Front-end_identification_1.31}

Improved front-end identification when connecting to GUI client.

[Back to the top](#PAGE_HEADER)

------------------------------------------------------------------------

## [Version 1.30]{#VERSION_1_30}

See also [Upgrade Notes](Mig0001.html).

- [Preprocessor](#Preprocessor_1.30)
- [Layout Enhancements](#Layout_Enhancements_1.30)
- [Presentation Styles](#Presentation_Styles_1.30)
- [Localization Support](#Localization_Support_1.30)
- [Action defaults in forms](#Action_defaults_in_forms_1.30)
- [Dialog Control](#Dialog_Control_1.30)
- [Sybase ASA Support](#Sybase_ASA_Support_1.30)
- [PostgreSQL 7.4 support](#PostgreSQL_7.4_support_1.30)
- [Build information in 42m
  modules](#Build_information_in_42m_modules_1.30)
- [MySQL 3.23 support for Windows
  platforms](#MySQL_3.23_support_for_Windows_platforms_1.30)
- [Upshift / Downshift in
  Comboboxes](#Upshift_Downshift_in_Comboboxes_1.30)
- [Message compiler does not require output file any
  longer](#Message_compiler_does_not_require_output_file_any_longer_1.30)
- [Breakpoint in source code](#Breakpoint_in_source_code_1.30)
- [Row highlighting in tables](#Row_highlighting_in_tables_1.30)
- [Method
  base.Array.appendElement()](#Method_base.Array.appendElement_1.30)
- [Compiled Localized String file extension
  42s](#Compiled_Localized_String_file_extension_42s_1.30)
- [Assignment operator](#Assignment_Operator_1.30)
- [New fglcomp option for SQL](#New_fglcomp_option_for_SQL_1.30)
- [Compiler generates standard UPDATE
  syntax](#Compiler_generates_standard_UPDATE_syntax_1.30)
- [Defining color attributes for each table
  cell](#Defining_color_attributes_for_each_table_cell_1.30)
- [Form methods in ui.Window](#Form_methods_in_ui.Window_1.30)
- [Method
  base.StringBuffer.replace()](#Methods_base.Channel.readLine_and_writeLine_1.30)
- [Methods base.Channel.readLine() and
  base.Channel.writeline()](#Methods_base.Channel.readLine_and_writeLine_1.30)
- [Dynamic arrays used as data model in INPUT ARRAY / DISPLAY
  ARRAY](#Dynamic_arrays_used_as_data_model_in_INPUT_ARRAY_DISPLAY_ARRAY_1.30)
- [TITLE attribute for fields](#TITLE_attribute_for_fields_1.30)
- [FGLLDPATH used during link](#FGLLDPATH_used_during_link_1.30)
- [Method
  ui.Dialog.setDefaultUnbuffered()](#Method_ui.Dialog.setDefaultUnbuffered_1.30)
- [Action Defaults applied by DVM](#Action_Defaults_applied_by_DVM_1.30)
- [DATEEDIT supports DBDATE &
  FORMAT](#DATEEDIT_supports_DBDATE_FORMAT_1.30)
- [New predefined action \'close\'](#New_Action_Close_1.30)
- [Tabbing order in TABLEs during INPUT
  ARRAY](#Tabbing_order_in_TABLEs_during_INPUT_ARRAY_1.30)
- [ACCEPT xx instruction](#ACCEPT_xx_instruction_1.30)
- [ACCEPT / CANCEL dialog
  attribute](#ACCEPT_CANCEL_dialog_attribute_1.30)
- [INPUT ARRAY now has default \'append\'
  action](#INPUT_ARRAY_now_has_default_append_action_1.30)
- [Linker option -O removed](#Linker_option_-O_removed_1.30)
- [Method ui.Window.createForm()](#Method_ui.Window.createForm_1.30)
- [TopMenu attributes in .per](#TopMenu_attributes_in_PER_1.30)
- [Specifying real field size in
  forms](#Specifying_real_field_size_in_forms_1.30)
- [Version number in UI protocol](#Version_number_in_UI_protocol_1.30)
- [MENU node available in BEFORE
  MENU](#MENU_node_available_in_BEFORE_MENU_1.30)
- [New HBox tags](#New_HBox_tags_1.30)
- [Form layout extensions](#Form_layout_extensions_1.30)
- [New Table definition
  attributes](#New_Table_definition_attributes_1.30)
- [New ORIENTATION attribute for
  RADIOGROUPs](#New_ORIENTATION_attribute_for_RADIOGROUPs_1.30)
- [Reviewed fglrun.setenv environment variables handling in
  FGLPROFILE](#Reviewed_fglrun.setenv_environment_variables_handling_in_FGLPROFILE_1.30)
- [MENU COMMAND generates lowercase action
  name](#MENU_COMMAND_generates_lowercase_action_name_1.30)
- [Method
  ui.Interface.loadTopMenu()](#Method_ui.Interface.loadTopMenu_1.30)
- [ON CHANGE fired on click](#ON_CHANGE_fired_on_click_1.30)
- [New ui.Dialog built-in class](#New_ui.Dialog_built-in_class_1.30)
- [New ui.Form methods](#New_ui.Form_methods_1.30)
- [Array sub-script operator now returns the
  sub-array](#Array_sub-script_operator_now_returns_the_sub-array_1.30)
- [Dynamic arrays passed by reference to
  functions](#Dynamic_arrays_passed_by_reference_to_functions_1.30)
- [Control MDI children with
  ui.Interface](#Control_MDI_children_with_ui.Interface_1.30)
- [Cancel INSERT in AFTER INSERT](#CANCEL_INSERT_in_AFTER_INSERT_1.30)
- [Toolbar and Topenu now have the hidden
  attribute](#Toolbar_and_Topmenu_now_have_the_hidden_attribute_1.30)
- [NEXT FIELD CURRENT](#NEXT_FIELD_CURRENT_1.30)

### [Preprocessor]{#Preprocessor_1.30}

Integrated preprocessor allows use of #include and #define/#ifdef
macros. See [Preprocessor](Preprocessor.html).

### [Layout Enhancements]{#Layout_Enhancements_1.30}

New layout rules and form item attributes provide better control of form
design. See [Layout Enhancements](Mig0001.html).

### [Presentation Styles]{#Presentation_Styles_1.30}

Decoration attribute can be defined in a style file to set fonts and
colors. See [Presentation Styles](PresentationStyles.html).

### [Localization Support]{#Localization_Support_1.30}

Localization Support (multi-byte character sets). See [Localization
Support](Localization.html#DEFINITION).

### [Action defaults in forms]{#Action_defaults_in_forms_1.30}

Action defaults can be specified in forms. See [Action defaults in
forms](FormSpecFiles.html#SECTION_ACTDEFS).

### [Dialog Control]{#Dialog_Control_1.30}

Dialog built-in class to provide better control over interactive
instructions. See [Dialog Control](ClassDialog.html).

### [Sybase ASA Support]{#Sybase_ASA_Support_1.30}

New drivers to connect to Sybase Adaptive Server Anywhere V7 and V8. See
[Sybase ASA Support](odiagasa.html)

### [PostgreSQL 7.4 support]{#PostgreSQL_7.4_support_1.30}

Support for PostgreSQL 7.4 with parameterized queries. See [PostgreSQL
7.4 support](odiagpgs.html).

### [Build information in 42m modules]{#Build_information_in_42m_modules_1.30}

The [fglcomp](Tools.html#TL_FGLCOMP) compiler now adds build information
in 42m modules. Compiler version of a 42m module can be checked on site
by using the [fglrun](Tools.html#TL_FGLRUN) with the -b option:

    $ fglrun -b module.42m
    2004-05-17 10:42:05 1.30.2a-620.10 /devel/tests/module.4gl

### [MySQL 3.23 support for Windows platforms]{#MySQL_3.23_support_for_Windows_platforms_1.30}

A MySQL 3.23 driver is now provided for Windows platforms (was
previously only provided on Linux).

### [Upshift/Downshift in Comboboxes]{#Upshift_Downshift_in_Comboboxes_1.30}

[COMBOBOX](FormSpecFiles.html#FF_ITEMTYPE_COMBOBOX) fields now support
UPSHIFT and DOWNSHIFT attributes, to force character case when
[QUERYEDITABLE](FSFAttributes.html#FA_QUERYEDITABLE) is used.

### [Message compiler does not require output file any longer]{#Message_compiler_does_not_require_output_file_any_longer_1.30}

The [fglmkmsg](Tools.html#TL_FGLMKMSG) tool now has the same behavior as
other tools like fglcomp and fglform: If you give only the source file,
the message compiler uses the same file name for the compiled output
file, adding the **.iem** extension.

### [Breakpoint in source code]{#Breakpoint_in_source_code_1.30}

New [BREAKPOINT](Programs.html#BREAKPOINT) instruction to stop a program
at a given position when using the debugger. It is ignored when not
running in debug mode.

### [Row highlighting in tables]{#Row_highlighting_in_tables_1.30}

New TABLE presentation style attribute
[highlightCurrentRow](PresentationStyles.html#STYATT_TABLE), to indicate
if the current row must be highlighted in a specific mode. By default,
the current row is highlighted during a DISPLAY ARRAY.

### [Method base.Array.appendElement()]{#Method_base.Array.appendElement_1.30}

New method [base.Array.appendElement()](Arrays.html), to append an
element at the end of a dynamic array.

### [Compiled Localized String file extension = 42s]{#Compiled_Localized_String_file_extension_42s_1.30}

Compiled Localized String files now have the .42s extension. Previous
extension was .4ls.

### [Assignment Operator]{#Assignment_Operator_1.30}

New [assignment operator](Operators.html#OP_ASSIGN) := has been added to
the language. You can now assign variables in expressions:\
IF ( i := (j+1) ) == 2 THEN

### [New fglcomp option for SQL]{#New_fglcomp_option_for_SQL_1.30}

The [fglcomp](Tools.html#TL_FGLCOMP) compiler now has a new option to
detect non-standard SQL syntax:\
fglcomp -W stdsql module.4gl

### [Compiler generates standard UPDATE syntax]{#Compiler_generates_standard_UPDATE_syntax_1.30}

The [fglcomp](Tools.html#TL_FGLCOMP) compiler now converts static SQL
updates like:

    UPDATE tab SET (c1,c2)=(v1,c2) ...

to a standard syntax:

    UPDATE tab SET c1=v1, c2=v2 ...

See also [SQL Programming](SqlProgramming.html).

### [Defining color attributes for each table cell]{#Defining_color_attributes_for_each_table_cell_1.30}

The new method [ui.Dialog.SetCellAttributes()](ClassDialog.html) lets
you define colors for each cell of a table.

### [Form methods in ui.Window ]{#Form_methods_in_ui.Window_1.30}

The [ui.Window](ClassWindow.html) class provides new methods to create
or get a form object.

### [Method base.StringBuffer.replace()]{#Method_base.StringBuffer.replace_1.30}

New method [base.StringBuffer.replace()](ClassStringBuffer.html), to
replace a sub-string in a string:

    CALL s.replace("old","new",2)

Replaces two occurrences of \"old\" with \"new\"\...

### [Methods base.Channel.readLine() and base.Channel.writeLine()]{#Methods_base.Channel.readLine_and_writeLine_1.30}

New methods to read/write complete lines in [Channel built-in
class](ClassChannel.html): readLine() and writeLine().

### [Dynamic arrays used as data model in INPUT ARRAY / DISPLAY ARRAY]{#Dynamic_arrays_used_as_data_model_in_INPUT_ARRAY_DISPLAY_ARRAY_1.30}

When using a dynamic array in [INPUT ARRAY](InputArray.html) or [DISPLAY
ARRAY](DisplayArray.html), the number of rows is defined by the size of
the dynamic array. The SET_COUNT() or COUNT attributes are ignored.

### [TITLE attribute for fields]{#TITLE_attribute_for_fields_1.30}

The new form field attribute [TITLE](FSFAttributes.html#FA_TITLE) can be
used to specify a table column label with a localized string.

### [FGLLDPATH used during link]{#FGLLDPATH_used_during_link_1.30}

The FGLLDPATH variable is now used [during link](CompilingPrograms.html)

### [Method ui.Dialog.setDefaultUnbuffered()]{#Method_ui.Dialog.setDefaultUnbuffered_1.30}

New class method [ui.Dialog.setDefaultUnbuffered()](ClassDialog.html) to
set the default for the UNBUFFERED mode.

### [Action Defaults applied by DVM]{#Action_Defaults_applied_by_DVM_1.30}

Action Defaults now applied at element creation by the runtime system.
In previous versions this was done dynamically by the front-end. Now,
changing an action default node at runtime has no effect on existing
elements.

### [DATEEDIT supports DBDATE & FORMAT]{#DATEEDIT_supports_DBDATE_FORMAT_1.30}

The [DATEEDIT](FormSpecFiles.html#FF_ITEMTYPE_DATEEDIT) field type now
supports DBDATE/CENTURY settings and the FORMAT attribute.

### [New predefined action \'close\']{#New_Action_Close_1.30}

New default action \'close\' to control Window closing. You can now
write the following to control window closing:

      ON ACTION close

See [Windows and Forms](InteractionModel.html#XCROSS_CLOSE).

### [Tabbing order in TABLEs during INPUT ARRAY]{#Tabbing_order_in_TABLEs_during_INPUT_ARRAY_1.30}

[INPUT ARRAY](InputArray.html) using TABLE container now needs FIELD
ORDER FORM attribute to keep tabbing order consistent with visual order
of columns.

### [ACCEPT xx instruction]{#ACCEPT_xx_instruction_1.30}

New instructions [ACCEPT INPUT](RecordInput.html) / [ACCEPT
CONSTRUCT](Construct.html) / [ACCEPT DISPLAY](DisplayArray.html) to
validate a dialog by program.

    ON ACTION doit
       ACCEPT INPUT

### [ACCEPT / CANCEL dialog attribute]{#ACCEPT_CANCEL_dialog_attribute_1.30}

New dialog attribute ACCEPT / CANCEL to avoid creation of default
actions \'accept\' and \'cancel\'.\
See [Record Input](RecordInput.html#CONTROL_INSTRUCTIONS) control
instructions.

### [INPUT ARRAY now has default \'append\' action]{#INPUT_ARRAY_now_has_default_append_action_1.30}

New default action \'append\' in [INPUT
ARRAY](InputArray.html#DEFAULT_ACTIONS). Allows you to add a row at the
end of the list.

### [Linker option -O removed]{#Linker_option_-O_removed_1.30}

The [linker](Tools.html#TL_FGLLINK) option -O (optimize) is de-supported
(was ignored before). You now get a warning if you use this option.

### [Method ui.Window.createForm()]{#Method_ui.Window.createForm_1.30}

New method [ui.Window.createForm()](ClassForm.html) to create an empty
form object in order to build forms from scratch at runtime.

### [TopMenu attributes in .per]{#TopMenu_attributes_in_PER_1.30}

[TopMenu definition in forms](FormSpecFiles.html#SECTION_TOPMENU) now
allows attributes in parenthesis.

### [Specifying real field size in forms]{#Specifying_real_field_size_in_forms_1.30}

The form layout syntax now allows you to specify the [real
width](FormSpecFiles.html#FF_ITEM_TAG) of form items. By default,
BUTTONEDIT, COMBOBOX and DATEEDIT get a real width as follows:

      if nbchars>2 : width = nbchars - 2; otherwise width = nbchars

(Here nbchars is the number of characters used in the layout
definition.)

Now you can specify the real width by using a dash \'-\' in the tag:

     1234567
    [f01  - ]      width = 5, grid cells used = 7

This works also in hbox tags and screen arrays.

### [Version number in UI protocol]{#Version_number_in_UI_protocol_1.30}

User interface protocol is now controlled with a version number, to
check compatibility between the front end and runtime system.

### [MENU node available in BEFORE MENU]{#MENU_node_available_in_BEFORE_MENU_1.30}

Important remark: Before build 530 the MENU has attached the WINDOW when
returning from the BEFORE MENU actions. Since build 530 the WINDOW must
exist before the MENU statement. So now the MENU node is available in
the BEFORE MENU block, but a WINDOW opened or made CURRENT in the BEFORE
MENU block will NOT be used.

### [New HBox tags]{#New_HBox_tags_1.30}

Layout GRID now accepts [HBox tags](FormSpecFiles.html#FF_HBOX_TAG) to
group items horizontally.

### [Form layout extensions]{#Form_layout_extensions_1.30}

- Elements in [grids](FormSpecFiles.html#FF_CONTAINER_GRID) now have
  cell columns and lines plus width & height.
- Form [VERSION](FormSpecFiles.html#SECTION_LAYOUT) attribute to
  distinguish form revisions.
- Layout [SPACING](FormSpecFiles.html#SECTION_LAYOUT) attribute to
  define space between widgets.
- The [DEFAULT SAMPLE](FormSpecFiles.html#SECTION_INSTRUCTIONS)
  instruction.
- New form item attributes, like [SAMPLE](FSFAttributes.html#FA_SAMPLE),
  [JUSTIFY](FSFAttributes.html#FA_JUSTIFY),
  [SIZEPOLICY](FSFAttributes.html#FA_SIZEPOLICY) \...

### [New Table definition attributes]{#New_Table_definition_attributes_1.30}

- You can now specify [HIDDEN](FSFAttributes.html#FA_HIDDEN) = USER as
  \'hidden to the user by default\'.
- Table columns now have new attribute
  [UNMOVABLE](FormSpecFiles.html#FF_CONTAINER_TABLE) to avoid moving.
- WANTCOLUMNSANCHORED replaced by
  [UNMOVABLECOLUMNS](FormSpecFiles.html#FF_CONTAINER_TABLE).
- WANTCOLUMNSVISIBLE replaced by
  [UNHIDABLECOLUMNS](FormSpecFiles.html#FF_CONTAINER_TABLE).
- Tables now accept a [WIDTH](FormSpecFiles.html#FF_CONTAINER_TABLE) and
  [HEIGHT](FormSpecFiles.html#FF_CONTAINER_TABLE) attribute to specify a
  size.

### [New ORIENTATION attribute for RADIOGROUPs]{#New_ORIENTATION_attribute_for_RADIOGROUPs_1.30}

RADIOGROUP fields now support the attribute
[ORIENTATION](FormSpecFiles.html#FF_ITEMTYPE_RADIOGROUP) = { VERTICAL \|
HORIZONTAL }.

### [Reviewed fglrun.setenv environment variables handling in FGLPROFILE]{#Reviewed_fglrun.setenv_environment_variables_handling_in_FGLPROFILE_1.30}

Now, on Windows platforms only, the ix drivers automatically set
standard Informix environment variables with ifx_putenv(). Values are
taken from the console environment with getenv(). Additional variables
can be specified with:

    dbi.stdifx.environment.count = n
    dbi.stdifx.environment.xx = "variable"

### [MENU COMMAND generates lowercase action name]{#MENU_COMMAND_generates_lowercase_action_name_1.30}

The MENU COMMAND clause now generates action names in lowercase. This
means, when you define COMMAND \"Open\", it will bind to all actions
views defined with the name \'open\'.

### [Method ui.Interface.loadTopMenu()]{#Method_ui.Interface.loadTopMenu_1.30}

New [ui.Interface.loadTopMenu()](ClassInterface.html) method to load a
global [topmenu](Topmenus.html).

### [ON CHANGE fired on click]{#ON_CHANGE_fired_on_click_1.30}

The [ON CHANGE](RecordInput.html#CONTROL_BLOCKS) block is now fired when
the user clicks on a checkbox, radiogroup, or changes the item in a
combobox.

### [New ui.Dialog built-in class]{#New_ui.Dialog_built-in_class_1.30}

New [ui.Dialog](ClassDialog.html) built-in class available with the
[DIALOG](RecordInput.html#CONTROL_CLASS) keyword in all interactive
instructions. You can now activate/deactivate fields and actions during
a dialog:

    INPUT ...
         AFTER FIELD field1
         CALL DIALOG.setFieldActive("field2",rec.field1 IS NOT NULL)
         CALL DIALOG.setActionActive("check",rec.field1 IS NOT NULL)

### [New ui.Form methods]{#New_ui.Form_methods_1.30}

The [ui.Form](ClassForm.html) built-in class has new methods to handle
form elements. The hidden attribute is now also managed at the model
level, this allows you to hide form fields by name, instead of using the
decoration node.

    CALL myform.setElementHidden("formonly.field1",2)
    CALL myform.setFieldHidden("field1",2) -- prefix is optional

### [Array sub-script operator now returns the sub-array]{#Array_sub-script_operator_now_returns_the_sub-array_1.30}

The \[\] array sub-script operator now returns the sub-array:

    DEFINE a2 DYNAMIC ARRAY WITH DIMENSION 2 OF INTEGER
    LET a2[5,10] = 123
    DISPLAY a2.getLength() -- displays 5
    DISPLAY a2[5].getLength() -- displays 10

### [Dynamic arrays passed by reference to functions]{#Dynamic_arrays_passed_by_reference_to_functions_1.30}

Dynamic arrays are now passed by reference to functions. You can change
a dynamic array in a function when it is passed as an argument.

### [Control MDI children with ui.Interface]{#Control_MDI_children_with_ui.Interface_1.30}

New methods are provided in [ui.Interface](ClassInterface.html) to
control the MDI children.

### [CANCEL INSERT in AFTER INSERT]{#CANCEL_INSERT_in_AFTER_INSERT_1.30}

In INPUT ARRAY, [CANCEL INSERT](InputArray.html#CONTROL_INSTRUCTIONS)
now supported in AFTER INSERT, to remove the new added line when needed.

### [Toolbar and Topmenu now have the hidden attribute]{#Toolbar_and_Topmenu_now_have_the_hidden_attribute_1.30}

[Toolbar](Toolbars.html) and [Topmenu](Topmenus.html) elements now have
the hidden attribute so you can create them and hide the options the
user is not supposed to see.

**Warning:** Hiding a toolbar or topmenu option does not prevent the use
of the accelerator of the action. Use
[ui.Dialog.setActionActive()](ClassDialog.html)!

### [NEXT FIELD CURRENT]{#NEXT_FIELD_CURRENT_1.30}

New keyword for [NEXT FIELD](RecordInput.html#CONTROL_INSTRUCTIONS):
NEXT FIELD CURRENT. Gives control back to the dialog instruction without
moving to another field.

[Back to the top](#PAGE_HEADER)

------------------------------------------------------------------------

## [Version 1.20]{#VERSION_1_20}

- [Debugger](#Debugger_1.20)
- [Program Profiler](#Program_Profiler_1.20)
- [Localized Strings](#Localized_Strings_1.20)
- [Unbuffered Dialogs](#Unbuffered_Dialogs_1.20)
- [Paged Display Array](#Paged_Display_Array_1.20)
- [Action Defaults](#Action_Defaults_1.20)
- [Client-side settings saved for each
  program](#Client_side_settings_saved_for_each_programs_1.20)
- [APPEND ROW dialog attribute](#APPEND_ROW_dialog_attribute_1.20)
- [KEEP CURRENT ROW dialog
  attribute](#KEEP_CURRENT_ROW_dialog_attribute_1.20)
- [UNHIDABLE attribute for image and
  labels](#UNHIDABLE_attribute_for_image_and_labels_1.20)
- [TERMINATE REPORT / EXIT REPORT](#TERMINATE_REPORT_EXIT_REPORT_1.20)
- [TINYINT data type with SQL
  Server](#TINYINT_data_type_with_SQL_Server_1.20)
- [Toolbars can be defined in
  forms](#Toolbars_can_be_defined_in_forms_1.20)
- [Topmenus can be defined in
  forms](#Topmenus_can_be_defined_in_forms_1.20)
- [Build version number](#Build_version_number_1.20)
- [Get a help message text](#Get_a_help_message_text_1.20)
- [Set the current row](#Set_the_current_row_1.20)
- [Interruption handling](#Interruption_handling_1.20)
- [StatusBar definition with style
  attribute](#StatusBar_definition_with_style_attribute_1.20)
- [Field order form](#Field_order_form_1.20)
- [Runtime system re-written in C](#Runtime_system_re-written_in_C_1.20)
- [Passing arrays as function
  parameter](#Passing_arrays_as_function_parameter_1.20)
- [Compiler supports ANSI outer
  joins](#Compiler_supports_now_ANSI_outer_joins_1.20)
- [Methods for StringBuffer](#Methods_for_StringBuffer_1.20)
- [Default items created for
  COMBOBOX](#Default_items_created_for_COMBOBOX_1.20)
- [ON IDLE clause in dialogs](#ON_IDLE_clause_in_dialogs_1.20)
- [Order of INPUT ARRAY trigger
  execution](#Order_of_INPUT_ARRAY_trigger_execution_1.20)
- [New ui.ComboBox class](#New_ui.ComboBox_class_1.20)
- [Predefined actions in lists: nextrow /
  prevrow](#Predefined_actions_in_lists_nextrow_prevrow_1.20)
- [FOREACH infinite loop](#FOREACH_infinite_loop_1.20)
- [Record comparison](#Record_comparison_1.20)
- [ON CHANGE trigger](#ON_CHANGE_trigger_1.20)
- [Program icon](#Program_icon_1.20)
- [Form compilation warnings](#Form_compilation_warnings_1.20)
- [FORMAT attribute in LABELs](#FORMAT_attribute_in_LABELs_1.20)
- [SQLSTATE and SQLERRMESSAGE](#SQLSTATE_and_SQLERRMESSAGE_1.20)
- [Front End Function calls](#Front_End_Function_calls_1.20)
- [New ui.Form built-in class](#New_ui.Form_built_in_class_1.20)
- [TABINDEX for tabbing order](#TABINDEX_for_tabbing_order_1.20)
- [LSTR operator](#LSTR_operator_1.20)
- [SFMT operator](#SFMT_operator_1.20)
- [ON ROW CHANGE trigger](#ON_ROW_CHANGE_trigger_1.20)
- [New StringTokenizer class](#New_StringTokenizer_class_1.20)
- [Faster linker](#Faster_linker_1.20)
- [Global constants](#Global_constants_1.20)
- [ON ACTION in MENUs](#ON_ACTION_in_MENUs_1.20)
- [New Application class](#New_Application_class_1.20)
- [New Channel class](#New_Channel_class_1.20)
- [Predefined \'help\' action](#Predefined_help_action_1.20)

### [Debugger]{#Debugger_1.20}

Integrated debugger with gdb syntax to interface with graphical tools
like ddd. See [Debugger](Debugger.html).

### [Program Profiler]{#Program_Profiler_1.20}

The [Program Profiler](Profiler.html) can be used to generate statistics
of program execution, to find the bottlenecks in the source code.

### [Localized Strings]{#Localized_Strings_1.20}

Internationalizes your application in different languages with localized
strings.

Localized Strings are now supported. You can identify strings to be
localized, with the % notation:

     LAYOUT ( TEXT= %"custlist" )

See [Localized Strings](LocalizedStrings.html).

### [Unbuffered Dialogs]{#Unbuffered_Dialogs_1.20}

Interactive instructions support the UNBUFFERED mode, to synchronise
data model and view automatically.  Dialogs can now use the
[UNBUFFERED](RecordInput.html#PROG_STEPS) attribute, that simplifies
INPUT, DISPLAY ARRAY and INPUT ARRAY coding; input/display buffer is no
longer used. When you set a variable, the value is automatically
displayed to the field. See [Unbuffered Dialogs](RecordInput.html).

### [Paged Display Array]{#Paged_Display_Array_1.20}

DISPLAY ARRAY can now work in buffered mode, to avoid loading a big
array when you have a lot of rows to display. The [DISPLAY
ARRAY](DisplayArray.html) instruction now has a new ON FILL BUFFER block
that can be used with dynamic arrays to feed the dialog with data rows
on demand. See [Paged Display Array](DisplayArray.html).

### [Action Defaults]{#Action_Defaults_1.20}

Centralize default attributes for actions in [Action Defaults
files](ActionDefaults.html).

### [Client side settings saved for each program]{#Client_side_settings_saved_for_each_programs_1.20}

Client side settings are now saved in registry according to the \'name\'
attribute of UserInterface, which can be set with
[ui.Interface.setName()](ClassInterface.html) method. By default
UserInterface.name is not set to the name of the program.

### [APPEND ROW dialog attribute]{#APPEND_ROW_dialog_attribute_1.20}

New attribute APPEND ROW = TRUE/FALSE for [INPUT
ARRAY](InputArray.html#INSTRUCTION_CONFIG) instruction. Defines if the
user is allowed to add rows at the end of the list.

### [KEEP CURRENT ROW dialog attribute]{#KEEP_CURRENT_ROW_dialog_attribute_1.20}

New attribute KEEP CURRENT ROW = TRUE/FALSE for [DISPLAY
ARRAY](DisplayArray.html#INSTRUCTION_CONFIG) and [INPUT
ARRAY](InputArray.html#INSTRUCTION_CONFIG) instructions. Defines if the
current row must remain highlighted when leaving the dialog. The default
is FALSE.

### [UNHIDABLE attribute for image and labels]{#UNHIDABLE_attribute_for_image_and_labels_1.20}

Image and labels now support the
[UNHIDABLE](FSFAttributes.html#FA_UNHIDABLE) attribute for table
columns.

### [TERMINATE REPORT / EXIT REPORT]{#TERMINATE_REPORT_EXIT_REPORT_1.20}

New report instructions TERMINATE REPORT / EXIT REPORT. Use the EXIT
REPORT statement to terminate a report within a REPORT definition. Both
statements have the following effects:\
- Terminate the processing of the current report.\
- Delete any intermediate files or temporary tables that were created
while processing the report.

### [TINYINT data type with SQL Server]{#TINYINT_data_type_with_SQL_Server_1.20}

SQL Server driver now supports the TINYINT data type.

### [Toolbars can be defined in forms]{#Toolbars_can_be_defined_in_forms_1.20}

You can now define [Toolbars](Toolbars.html) in form specification
files.

### [Topmenus can be defined in forms]{#Topmenus_can_be_defined_in_forms_1.20}

You can now define [Topmenus](Topmenus.html) in form specification
files.

### [Build version number]{#Build_version_number_1.20}

The [FGL_GETVERSION()](BuiltInFunctions.html#BF_FGL_GETVERSION) function
returns the internal version number of the runtime system.

### [Get a help message text]{#Get_a_help_message_text_1.20}

The [FGL_GETHELP()](BuiltInFunctions.html#BF_FGL_GETHELP) function
returns the message text for a give help number.

### [Set the current row]{#Set_the_current_row_1.20}

The [FGL_SET_ARR_CURR()](BuiltInFunctions.html#BF_FGL_SET_ARR_CURR)
function changes the current row in [DISPLAY ARRAY](DisplayArray.html)
or [INPUT ARRAY](InputArray.html).

### [Interruption handling]{#Interruption_handling_1.20}

Users can now send an [interruption](InteractionModel.html#INTERRUPTION)
request from the client to the program, to stop long running queries,
reports and other BDL procedures, by testing the int_flag variable. The
client is using an OOB signal.

### [StatusBar definition with style attribute]{#StatusBar_definition_with_style_attribute_1.20}

There is now a new window style attribute for statusbar layout
specification. You can now set [statusBarType](PresentationStyles.html)
attribute in the 4st style file for Windows, in order to control the
display of status bars.

### [Field order form]{#Field_order_form_1.20}

New [OPTIONS](Programs.html#PROGRAM_OPTIONS) clause FIELD ORDER FORM
provided to use the [TABINDEX](FSFAttributes.html#FA_TABINDEX) attribute
to define the field tabbing order. FIELD ORDER FORM can also be used at
the dialog level as dialog attribute.

### [Runtime system re-written in C]{#Runtime_system_re-written_in_C_1.20}

Runtime system has been re-written in pure C language, g++ 3.2 and
corresponding gnu libs (libstdc++, libsupc++, \...) are no longer
needed; a runner can be linked with a native cc compiler. See
[Installation and Setup](Installation.html).

### [Passing arrays as function parameter]{#Passing_arrays_as_function_parameter_1.20}

[Arrays](Arrays.html) can be passed as parameters, all elements are
expanded.

### [Compiler supports now ANSI outer joins]{#Compiler_supports_now_ANSI_outer_joins_1.20}

You can now write static SQL statements using ANSI outer joins:

       SELECT .. FROM a LEFT OUTER JOIN b ON a.key=b.key

### [Methods for StringBuffer]{#Methods_for_StringBuffer_1.20}

New methods for [StringBuffer class](ClassStringBuffer.html):
base.StringBuffer.replaceAt() and base.StringBuffer.insertAt().

### [Default items created for COMBOBOX]{#Default_items_created_for_COMBOBOX_1.20}

For [COMBOBOX](FormSpecFiles.html#FF_ITEMTYPE_COMBOBOX) form items, a
default ITEMS list is created by fglform when an INCLUDE list is used.

### [ON IDLE clause in dialogs]{#ON_IDLE_clause_in_dialogs_1.20}

The [ON IDLE](RecordInput.html#INTERACTION_BLOCKS) clause can be used to
execute a block of instructions after a timeout.

### [Order of INPUT ARRAY trigger execution]{#Order_of_INPUT_ARRAY_trigger_execution_1.20}

New logical order of execution for [INPUT
ARRAY](InputArray.html#CTRLBLOCK_EXECUTION) triggers:

1.  BEFORE INPUT
2.  BEFORE ROW
3.  BEFORE INSERT
4.  BEFORE FIELD

### [New ui.ComboBox class]{#New_ui.ComboBox_class_1.20}

New [ui.ComboBox](ClassComboBox.html) class has been added, to configure
COMBOBOX fields at runtime.

### [Predefined actions in lists: nextrow / prevrow]{#Predefined_actions_in_lists_nextrow_prevrow_1.20}

[DISPLAY ARRAY](DisplayArray.html#DEFAULT_ACTIONS) and [INPUT
ARRAY](InputArray.html#DEFAULT_ACTIONS) instructions now automatically
use two predefined actions nextrow and prevrow, which allow binding
action views for navigation.

### [FOREACH infinite loop]{#FOREACH_infinite_loop_1.20}

FOREACH that raises an error no longer loops infinitely.

### [Record comparison]{#Record_comparison_1.20}

Operators equal (= or ==) and not equal (\<\> or !=) now can be used
with records. All members will be compared. If two members are NULL the
result of this member comparison results in TRUE.

### [ON CHANGE trigger]{#ON_CHANGE_trigger_1.20}

ON CHANGE field trigger in [INPUT](RecordInput.html#CONTROL_BLOCKS) and
[INPUT ARRAY](InputArray.html#CONTROL_BLOCKS). Same as AFTER FIELD, but
only fired if the value has changed.

### [Program icon]{#Program_icon_1.20}

New image attribute in UserInterface node, for the program icon. Can be
set with [ui.Interface.setImage()](ClassInterface.html).

### [Form compilation warnings]{#Form_compilation_warnings_1.20}

New option -W for [fglform](Tools.html#TL_FGLFORM) to show warnings.

### [FORMAT attribute in LABELs]{#FORMAT_attribute_in_LABELs_1.20}

[LABELs](FormSpecFiles.html#FF_ITEMTYPE_LABEL) can now have a FORMAT
attribute.

### [SQLSTATE and SQLERRMESSAGE]{#SQLSTATE_and_SQLERRMESSAGE_1.20}

New [SQLSTATE and SQLERRMESSAGE](Connections.html#ERRORINFO) operators,
to give SQL execution information.

### [Front End Function calls]{#Front_End_Function_calls_1.20}

You can now call predefined functions in the front-end, by using the
[ui.Interface.frontCall()](ClassInterface.html)method.\
See also [Front End Functions](FrontEndFunctions.html).

### [New ui.Form built-in class]{#New_ui.Form_built_in_class_1.20}

New [ui.Form](ClassForm.html) built-in class to handle forms.

### [TABINDEX for tabbing order]{#TABINDEX_for_tabbing_order_1.20}

New [TABINDEX](FSFAttributes.html#FA_TABINDEX) field attribute to define
the tabbing order in forms.

### [LSTR operator]{#LSTR_operator_1.20}

New LSTR operator to get a localized string by name:

      DISPLAY LSTR("custno_comment")

### [SFMT operator]{#SFMT_operator_1.20}

New SFMT operator to format strings with parameters:

      DISPLAY SFMT("Could not find %1 in %2.",filename,dirname)

### [ON ROW CHANGE trigger]{#ON_ROW_CHANGE_trigger_1.20}

New ON ROW CHANGE clause in [INPUT
ARRAY](InputArray.html#CONTROL_BLOCKS). This trigger will be executed if
at least one value in the row has been modified. The ON ROW CHANGE code
is be executed just before the AFTER ROW clause.

### [New StringTokenizer class]{#New_StringTokenizer_class_1.20}

The [StringTokenizer](ClassStringTokenizer.html) class can be used to
parse strings for tokens.

### [Faster linker]{#Faster_linker_1.20}

Linker is now faster when having program modules with a huge number of
functions.

### [Global constants]{#Global_constants_1.20}

[CONSTANTs](Constants.html) can now be defined as GLOBALs.

### [ON ACTION in MENUs]{#ON_ACTION_in_MENUs_1.20}

[MENU](Menus.html) instruction now supports ON ACTION clause, to write
abstract menus as simple action handlers.

### [New Application class]{#New_Application_class_1.20}

The [base.Application](ClassApplication.html) class provides an
interface to the program properties.

### [New Channel class]{#New_Channel_class_1.20}

New definition of the interface for Channels, now based on objects:

     DEFINE c base.Channel
     LET c = base.Channel.create()
     CALL c.openFile("data.txt","r")

### [Predefined \'help\' action]{#Predefined_help_action_1.20}

New \'help\' [predefined action](InteractionModel.html#PREDEFACTIONS),
to start help viewer for HELP clauses in dialog instructions.

     INPUT BY NAME .... HELP 12423 -- Creates action 'help'

[Back to the top](#PAGE_HEADER)

------------------------------------------------------------------------

## [Version 1.10]{#VERSION_1_10}

- [Dynamic User Interface](#Dynamic_User_Interface_1.10)
- [Interactive Instruction
  Extensions](#Interactive_Instruction_Extensions_1.10)
- [Built-in Classes](#Built_in_Classes_1.10)
- [Constant Definitions](#Constant_Definitions_1.10)
- [Extended Form Files](#Extended_Form_Files_1.10)
- [Dynamic Arrays](#Dynamic_Arrays_1.10)
- [XML utilities](#XML_utilities_1.10)
- [STRING data type](#STRING_data_type_1.10)
- [Defining MDI containers](#Defining_MDI_containers_1.10)
- [SCHEMA instruction](#SCHEMA_instruction_1.10)

### [Dynamic User Interface]{#Dynamic_User_Interface_1.10}

The [Dynamic User Interface](DynamicUI.html) is the major new concept in
Genero. It is the basement for the new graphical user interface. See
[Dynamic User Interface](DynamicUI.html).

### [Interactive Instruction Extensions]{#Interactive_Instruction_Extensions_1.10}

Classical interactive instructions such as [INPUT](RecordInput.html),
[INPUT ARRAY](InputArray.html), [DISPLAY ARRAY](DisplayArray.html),
[CONSTRUCT](Construct.html) have been extended with new control blocks
and control instructions. See [Interactive Instruction
Extensions](RecordInput.html).

### [Built-in Classes]{#Built_in_Classes_1.10}

The language supports now [built-in classes](BuiltInClasses.html), a new
object-oriented way to program in BDL. See [Built-in
Classes](BuiltInClasses.html).

### [Constant Definitions]{#Constant_Definitions_1.10}

It is now possible to define [constants](Constants.html), as in other
languages. See [Constant Definitions](Constants.html).

### [Extended Form Files]{#Extended_Form_Files_1.10}

You can now define complex layouts with the [extended PER
files](FormSpecFiles.html). See [Extended Form
Files](FormSpecFiles.html).

### [Dynamic Arrays]{#Dynamic_Arrays_1.10}

The language now supports [dynamic arrays](Arrays.html) with automatic
memory allocation. DISPLAY ARRAY can now work in buffered mode, to avoid
to load a big array when you have a lot of rows to display. See [Dynamic
Arrays](Arrays.html).

### [XML utilities]{#XML_utilities_1.10}

A set of [XML Utilities](XmlUtils.html) are provided in the runtime
library as built-in classes.

### [STRING data type]{#STRING_data_type_1.10}

A new [STRING](DataTypes.html#DT_STRING) data type is now available, to
simplify utility function coding.

### [Defining MDI containers]{#Defining_MDI_containers_1.10}

Defining [Window Containers (MDI)](ClassInterface.html) is a simple way
to group programs.

### [SCHEMA instruction]{#SCHEMA_instruction_1.10}

The new [SCHEMA](Programs.html#DB_SCHEMA) instruction allows you to
specific a database schema without having an implicit connection when
the program executes.

[Back to the top](#PAGE_HEADER)

------------------------------------------------------------------------
