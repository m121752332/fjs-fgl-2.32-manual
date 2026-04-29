[Back to Contents](../index.html)

------------------------------------------------------------------------

# [MDI Windows]{#PAGE_HEADER}

Summary:

- [Purpose](#PURPOSE)
- [Usage](#USAGE)
  - [Configuring the parent container](#parent-container)
  - [Configuring child programs](#child-programs)
  - [Tabbed MDI](#tabbedMDI)

See also [Interface built-in class](ClassInterface.html).

------------------------------------------------------------------------

### [Purpose]{#PURPOSE}

By default, BDL program windows are displayed independently in separate
windows on the front-end window manager. This mode is well known as SDI,
Single Document Interface. The user interface can be configured to group
program windows in a parent container (also known as MDI, Multiple
Document Interface). 

In BDL, Multiple Document Interface is called  **WCI**: *Window
Container Interface*.

The Window Container Interface (WCI) can be used to group several
programs together in a parent window. The parent program is the
container for the other programs, defined as children of the container.
The container program can have its own windows, but this makes sense
only for temporary modal windows (with style=\"dialog\").

------------------------------------------------------------------------

### [Usage]{#USAGE}

WCI configuration is done dynamically at the beginning of programs, by
using the [ui.Interface](ClassInterface.html) built-in class.

#### [Configuring the parent container]{#parent-container}

The WCI container program is a separate BDL program of a special type,
dedicated to contain other program windows. On the front-end, container
programs automatically display a parent window that will hold all child
program windows that will attach to the container.

The WCI container program must indicate that its type is special
([setType()](ClassInterface.html#setType) method), and must identify
itself ([setName()](ClassInterface.html#setName) method):

``` linenumber
01 MAIN
02   CALL ui.Interface.setName("parent1")
03   CALL ui.Interface.setType("container")
04   CALL ui.Interface.setText("SoftStore Manager")
05   CALL ui.Interface.setSize("600px","1000px")
06   CALL ui.Interface.loadStartMenu("mystartmenu")
07   MENU "Main"
08     COMMAND "Help" CALL help()
09     COMMAND "About" CALL aboutbox()
10     COMMAND "Exit" EXIT MENU
11   END MENU
12 END MAIN
```

You can define the initial size of the parent container window with the
[setSize(height,width)](ClassInterface.html#setSize) method.

#### [Configuring child programs]{#child-programs}

WCI children programs must attach to a parent container by giving the
name of the container program:

``` linenumber
01 MAIN
02  CALL ui.Interface.setName("custapp")
03  CALL ui.Interface.setType("child")
04  CALL ui.Interface.setText("Customers")
05  CALL ui.Interface.setContainer("parent1")
06     ...
07 END MAIN
```

Multiple container programs can be used to group programs by application
modules.

When the program is identified as a container (`type="container"`), a
global window is automatically displayed as an container window. The
default [Toolbar](Toolbars.html) and the default
[Topmenu](Topmenus.html) are displayed and a
[Startmenu](StartMenus.html) can be used. Other windows created by this
kind of program can be displayed, inside the container
(`windowType="normal"`) or as dialog windows (`windowType="modal"`).
[Window styles](WindowsAndForms.html#WINDOW_STYLES) can be applied to
the parent window by using the default style specification
(`name="Window.main"`).

The client shows a system error and the programs stops when:

- A child program is started, but the parent container is not
- A container program is started twice

When the parent container program is stopped, other applications are
automatically stopped by the front-end. This will result in a runtime
error **[-6313](FglErrors.html#-6313)** on the application server side.
To avoid this, you should control that there are no more running child
programs before terminating the parent container program. The WCI
container program can query for the existence of children with the
[getChildCount()](ClassInterface.html#getChildCount) and
[getChildInstances()](ClassInterface.html#getChildInstances) methods:

``` linenumber
01 MAIN
02   CALL ui.Interface.setName("parent1")
03   CALL ui.Interface.setType("container")
04   CALL ui.Interface.setText("SoftStore Manager")
05   CALL ui.Interface.setSize("600px","1000px")
06   CALL ui.Interface.loadStartMenu("mystartmenu")
07   MENU "Main"
08     COMMAND "Help" CALL help()
09     COMMAND "About" CALL aboutbox()
10     COMMAND "Exit"
11       IF ui.Interface.getChildCount()>0 THEN
12          ERROR "You must first exit the child programs."
13       ELSE
14          EXIT MENU
15       END IF
16   END MENU
17 END MAIN
```

\

#### [Tabbed MDI]{#tabbedMDI}

MDI container can also be displayed as \"Tabbed MDI\" when the style
attribute \"[tabbedContainer](PresentationStyles.html#STYATT_WINDOW)\"
is set to `yes`.\
In Tabbed MDI, the style attribute
\"[tabbedContainerCloseMethod](PresentationStyles.html#STYATT_WINDOW)\"
defines how to close the current page.

Values can be:

- `"container"` (default), the container has a close button on the top
  right corner, which closes the current tab.
- `"page"`, each page has its own close button.
- `"both"`, each page and the container have a close button.
- `"none"`, no close button is shown.

The close button is enabled depending on the window style attribute.
