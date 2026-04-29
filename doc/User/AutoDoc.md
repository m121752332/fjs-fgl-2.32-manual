[Back to Contents](../index.html)

------------------------------------------------------------------------

# [Automatic source documentation generator]{#PAGE_HEADER}

Summary:

- [Basics](#BASICS)
- [Prerequisites](#PREREQUISITES)
- [Syntax](#SYNTAX)
- [Documentation structure](#DOCSTRUCT)
- [Adding comments to sources](#COMMENTS)
  - [Commenting a Function](#COMMENTING_FUNCTION)
  - [Commenting a Module](#COMMENTING_MODULE)
  - [Commenting a Package](#COMMENTING_PACKAGE)
  - [Commenting a Project](#COMMENTING_PROJECT)
- [Running the doc generator](#DOCGEN)

------------------------------------------------------------------------

### [Basics]{#BASICS}

Documenting sources is an important task in software development, to
share the code among applications and achieve better reusability. Source
documentation must be concise, clear, and complete. However, documenting
sources can be boring and subject to mistakes if large repetitive
documentation sections have to be written by hand.

Robust source documentation can be produced automatically with the
[fglcomp](Tools.html#TL_FGLCOMP) compiler. The compiler can generate
source documentation from the **.4gl** files of your project with
minimum effort. The resulting source documentation is generated in
simple HTML format and can be published on a web server.

Source documentation is generated with the **\--build-doc** option of
[fglcomp](Tools.html#TL_FGLCOMP). You can generate default documentation
from the existing sources. For a better description of the code, you can
add special **#+** comments in your sources to describe code elements
such as functions, function parameters, and return values.

------------------------------------------------------------------------

### [Prerequisites]{#PREREQUISITES}

To generate the HTML pages, fglcomp first generates **.xa** files which
must be converted to **.html** files. The conversion from **.xa** to
**.html** is done with an XSLT processor using the **.xsl** style sheets
files provided in FGLDIR/lib/fgldoc/

You must have an XSLT processor installed on the machine where the
documentation is generated.

- On Unix, fglcomp runs the FGLDIR/lib/fgldoc/**Transform.sh** script to
  convert .xa files to .html files.\
  Therefore you need the **xsltproc** command line XSLT processor (from
  the libxml package).
- On Windows, fglcomp runs the FGLDIR\\lib\\fgldoc\\**Transform.wsf**
  script to convert .xa files to .html files.\
  To run that .wsf script, you must have **cscript.exe** installed with
  the **Microsoft.XMLDOM** class (this is the case on recent Windows
  versions).

If necessary, the style sheets provided in FGLDIR/lib/fgldoc can be
adapted to transform the **.xa** files to **.html** files.

------------------------------------------------------------------------

### [Syntax]{#SYNTAX}

To extract documentation from a 4gl source:

`fglcomp --build-doc `*`filename`*`.4gl`

------------------------------------------------------------------------

### [Documentation structure]{#DOCSTRUCT}

The source documentation structure is based on the well-known Java-doc
technique. The generated documentation reflects the structure of your
sources; in order to have nicely structured source documentation, you
must have a nicely structured source tree.

The Genero BDL source documentation elements are structured as follows
(elements in red must be created by hand, while the green color
indicates generated files):

- Top/root directory (the root of your project)
  - **overview.4gl** (description of the project)
  - **overview-summary.html**
  - **overview-frame.html**
  - **allclasses-frame.html**
  - **index-all.html**
  - **index.html**
  - **fgldoc.css**
  - sub-directory1 (package)
    - sub-directory11 (package)
      - \...
    - sub-directory12 (package)
      - sub-directory121 (package)
        - **package-info.4gl** (description of the package/directory)
        - **package-summary.html**
        - **package-frame.html**
        - source1211.4gl (module)
        - **source1211.html**
        - source1212.4gl (module)
          - **#+ Module 1212 comment** (description of the module)
          - **#+ Function 12121 comment** (description of the function)
          - function12121
          - **#+ Function 12121 comment**
          - function12122
          - \...
        - **source1212.html**
        - source1213.4gl (module)
        - **source1213.html**
        - \...
  - sub-directory2 (package)
    - \...
  - sub-directory3 (package)
    - \...

You must create a file named **overview.4gl** in the top directory of
the project. This file contains the overall description of the project.
In that directory, the documentation generator creates the files
**overview-summary.html**, **overview-frame.html**,
**allclasses-frame.html**, **index-all.html**, **index.html** and
**fgldoc.css**.

The generator can scan sub-directories to build the documentation for a
whole project; each source directory defines a *package*. For each
directory (i.e. *package*), the generator creates a
**package-summary.html** and a **package-frame.html** file. If a file
with the name **package-info.4gl** exists, it will be scanned to
complete the **package-summary.html** file with the package description.

The generator creates a *filename*.html file for each 4gl source module,
seen as a *class* in the documentation.

------------------------------------------------------------------------

### [Adding comments to sources]{#COMMENTS}

#### [Commenting a Function]{#COMMENTING_FUNCTION}

To comment a function, add some lines starting with **#+**, before the
function body. The comment body is composed of paragraphs separated by a
blank line. The first paragraph of the comment is a short description of
the function. This description will be placed in the function summary
table. The next paragraph is long text describing the function in
detail. Other paragraphs must start with a **tag** to identify the type
of the paragraph; a tag starts with the @ \"at\" sign.

Supported @ tags:

  ----------------------------------- -----------------------------------
  **Tag**                             **Description**

  `@code`                             Indicates that the next lines show
                                      a code example using the function.

  `@param `*`name description`*       Defines a function parameter
                                      identified by *name*, explained by
                                      a *description*.\
                                      **Warning:** *name* must match the
                                      parameter name in the function
                                      declaration.

  `@return `*`description`*           Describes the values returned by
                                      the function.\
                                      You can add more than one \@return
                                      line to the function comment.
  ----------------------------------- -----------------------------------

##### Example:

``` linenumber
01 #+ Compute the amount of the orders for a given customer
02 #+
03 #+ This function calculates the total amount of all orders for the
04 #+ customer identified by the cust_id number passed as parameter.
05 #+
06 #+ @code
07 #+ DEFINE total DECIMAL(10,2)
08 #+ CALL total = ordersTotal(r_customer.cust_id)
09 #+
10 #+ @param cid Customer identifier
11 #+
12 #+ @return The total amount as DECIMAL(10,2)
13 #+
14 FUNCTION ordersTotal(cid)
15    DEFINE cid INTEGER
16    DEFINE ordtot DECIMAL(10,2)
17    SELECT SUM(ord_amount) INTO ordtot
18         FROM orders WHERE orders.cust_id = cid
19    RETURN ordtot
20 END FUNCTION
```

#### [Commenting a Module]{#COMMENTING_MODULE}

To comment a 4gl module, you can add **#+** lines at the beginning of
the source, before module element declarations such as module variable
definitions. 

##### Example:

``` linenumber
01 #+ This module implements customer information handling
02 #+
03 #+ This code uses the 'customer' and 'custdetail' database tables.
04 #+ Customer input, query and list handling functions are defined here. 
05 #+
06 DEFINE r_cust RECORD
07    cust_id INTEGER,
08    cust_name VARCHAR(50),
09    cust_address VARCHAR(200)
10 END RECORD
```

#### [Commenting a Package]{#COMMENTING_PACKAGE}

To describe a complete directory (i.e. package), you must create a
**package-info.4gl** file in the directory and add a **#+** comment in
the file. The comment will be added to the **package-summary.html**
file.

#### [Commenting a Project]{#COMMENTING_PROJECT}

In the top directory of your sources, you must create a **overview.4gl**
file with a **#+** comment describing the project. This file is
mandatory in order to generate the tree of html pages for an entire
project, as it is used as the starting point by fglcomp. See \"[Running
the documentation generator](#DOCGEN)\" for more details.

------------------------------------------------------------------------

### [Running the documentation generator]{#DOCGEN}

To produce the source documentation, follow these steps:

1.  Go to the TOP directory of your sources.
2.  Create a file named **overview.4gl**, with a **#+** comment
    describing your project.
3.  Go to the subdirectories and create files named **package-info.4gl**
    with a **#+** comment describing the package.
4.  Edit the 4gl modules to add **#+** comments to functions that must
    be documented.
5.  Go back to the TOP directory.
6.  Run **fglcomp \--build-doc overview.4gl**.
7.  To test the result, load the generated **index.html** file in your
    preferred browser.
