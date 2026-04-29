[Back to Summary](TutIndex.html)

------------------------------------------------------------------------

# Tutorial Chapter 1: Overview

Summary:

- [Overview](#overview)
- [The BDL Language](#language)
- [The  BDL Tutorial](#tutorial)
- [The Example Database (custdemo)](#database)
- [The Sample data](#sampledata)

See also: [Introduction: BDL Concepts](IntroBDL.html)

------------------------------------------------------------------------

## [Overview]{#overview}

Especially well-suited for large-scale, database-intensive business
applications, Genero Business Development Language (**BDL)** is a
**reliable, easy-to-learn high-level programming language** that allows
application developers to:

- express business logic in a clear yet powerful syntax
- use SQL statements for database access to any of the supported
  databases
- [localize](Localization.html) your application to follow a specific
  language or cultural rules
- [define user interfaces](FormSpecFiles.html) in an abstract,
  platform-independent manner
- define [Presentation Styles](PresentationStyles.html) to customize and
  standardize the appearance of the interface
- manipulate the user interface at runtime, as a [tree of
  objects](DynamicUI.html) 

**The separation of business logic, user interface, and deployment
provides maximum flexibility**.

- The business logic is written in text files (.4gl source code modules)
  that interact with separate [form files](FormSpecFiles.html) defining
  the user interface.
- Actions defined in the business logic are tied to action views
  (buttons, menu items, toolbar icons) in the form definition files, and
  respond to user interaction statements in the source code.
- Compiling a form definition file translates it into XML, which is used
  to display the user interface to various Genero clients running on
  different platforms. 

You can **write once, deploy anywhere** - one production release
supports all major versions of Unix, Linux, Windows, and Mac OS X.

Compiling, linking, and deploying BDL applications, and additional
resources for developers, are discussed in [Introduction: BDL
Concepts](IntroBDL.html#Compiling).

------------------------------------------------------------------------

## [The BDL Language]{#language}

The Genero Business Development Language includes:

- [Program flow control](FlowControl.html)
- [Conditional logic](FlowControl.html)
- [SQL statement support](StaticSql.html)
- [Connection management](Connections.html)
- [Error handling](Exceptions.html)
- [Localized strings](LocalizedStrings.html)

[Dynamic SQL](DynamicSql.html) management allows you to execute any SQL
statement that is valid for your database version, in addition to those
that are included as part of the language. The statement can be hard
coded or created at runtime, with or without SQL parameters, returning
or not returning a result set.

High-level **BDL user interaction statements** substitute for the many
lines of code necessary to implement common business tasks, mediating
between the user and the user interface in order to:

- [Provide a selection of actions to the user](TutChap03.html) (MENU)
- [Allow the user to enter database search criteria on a
  form](TutChap04.html) (CONSTRUCT)
- [Display information from database tables](TutChap03.html) (DISPLAY,
  DISPLAY ARRAY)
- [Allow the user to modify the contents of database
  tables](TutChap05.html) (INPUT, INPUT ARRAY)

[Multiple dialogs](MultipleDialogs.html) allow a Genero program to
handle interactive statements isuch as the above in parallel.

In addition, [built-in classes](BuiltInClasses.html) and methods, and
[built-in functions](BuiltInFunctions.html) are provided to assist you
in your program development. 

------------------------------------------------------------------------

## [The BDL Tutorial]{#tutorial}

The chapters in this tutorial describe the basic functionality of Genero
BDL. Annotated code examples in each chapter guide you through the steps
to implement the features discussed above. In addition, complete source
code programs of the examples are available for download, contact you
support channel to get the links. See the [Tutorial
Summary](TutIndex.html) for a description of each chapter.

The example programs interact with an demo database, the **custdemo**
database, containing store and order information for a fictional retail
chain.

If you wish to test the example programs on your own system, see
[Testing the Programs](TutIndex.html#testing) for information about the
software and sample data that must be installed and configured.

------------------------------------------------------------------------

## [The Example Database (custdemo)]{#database}

The following SQL statements create the tables for the custdemo
database; these statements are in the file **custdemo.sql** in the
Tutorial subdirectory of the documentation.

    create table customer(
        store_num     integer not null,
        store_name    char(20) not null,
        addr          char(20),
        addr2         char(20),
        city          char(15),
        state         char(2),
        zipcode       char(5),
        contact_name  char(30),
        phone         char(18), 
        primary key (store_num)
    );
    create table orders(
        order_num     integer not null,
        order_date    date not null,
        store_num     integer not null,
        fac_code      char(3),
        ship_instr    char(10),
        promo         char(1) not null,    
        primary key (order_num)
    );
    create table factory(
        fac_code      char(3) not null,
        fac_name      char(15) not null,
        primary key (fac_code)
    );
    create table stock(
        stock_num     integer not null,
        fac_code      char(3) not null,
        description   char(15) not null,
        reg_price     decimal(8,2) not null,
        promo_price   decimal(8,2),
        price_updated date,
        unit          char(4) not null,
        primary key (stock_num)
    );
    create table items(
        order_num     integer not null,
        stock_num     integer not null,
        quantity      smallint not null,
        price         decimal(8,2) not null,
        primary key (order_num, stock_num)
    );
    create table state(
        state_code char(2) not null,
        state_name char(15) not null,
        primary key (state_code)
    );

------------------------------------------------------------------------

## [The Sample Data]{#sampledata}

The following sample data for the custdemo database is contained in the
file **loadcust.sql** in the Tutorial subdirectory of the documentation.

### Customer table

101\|Bandy\'s Hardware\|110 Main\| \|Chicago\|IL\|60068\|Bob
Bandy\|630-221-9055\|\
102\|The FIX-IT Shop\|65W Elm Street Sqr.\| \|Madison\|WI\|65454\|
\|630-34343434\|\
103\|Hill\'s Hobby Shop\|553 Central Parkway\| \|Eau
Claire\|WI\|54354\|Janice Hilstrom\|666-4564564\|\
104\|Illinois Hardware\|123 Main Street\| \|Peoria\|IL\|63434\|Ramon
Aguirra\|630-3434334\|\
105\|Tools and Stuff\|645W Center Street\| \|Dubuque\|IA\|54654\|Lavonne
Robinson\|630-4533456\|\
106\|TrueTest Hardware\|6123 N. Michigan Ave\|
\|Chicago\|IL\|60104\|Michael Mazukelli\|640-3453456\|\
202\|Fourth Ill Hardware\|6123 N. Michigan Ave\|
\|Chicago\|IL\|60104\|Michael Mazukelli\|640-3453456\|\
203\|2nd Hobby Shop\|553 Central Parkway\| \|Eau
Claire\|WI\|54354\|Janice Hilstrom\|666-4564564\|\
204\|2nd Hardware\|123 Main Street\| \|Peoria\|IL\|63434\|Ramon
Aguirra\|630-3434334\|\
205\|2nd Stuff\|645W Center Street\| \|Dubuque\|IA\|54654\|Lavonne
Robinson\|630-4533456\|\
206\|2ndTest Hardware\|6123 N. Michigan Ave\|
\|Chicago\|IL\|60104\|Michael Mazukelli\|640-3453456\|\
302\|Third FIX-IT Shop\|65W Elm Street Sqr.\| \|Madison\|WI\|65454\|
\|630-34343434\|\
303\|Third Hobby Shop\|553 Central Parkway\| \|Eau
Claire\|WI\|54354\|Janice Hilstrom\|666-4564564\|\
304\|Third IL Hardware\|123 Main Street\| \|Peoria\|IL\|63434\|Ramon
Aguirra\|630-3434334\|\
305\|Third and Stuff\|645W Center Street\| \|Dubuque\|IA\|54654\|Lavonne
Robinson\|630-4533456\|\
306\|Third Hardware\|6123 N. Michigan Ave\|
\|Chicago\|IL\|60104\|Michael Mazukelli\|640-3453456\|

### Orders table

1\|04/04/2003\|101\|ASC\|FEDEX\|N\|\
2\|06/06/2006\|102\|ASC\|FEDEX\|Y\|\
3\|06/10/2006\|103\|PHL\|FEDEX\|Y\|\
4\|06/10/2006\|104\|ASC\|FEDEX\|Y\|\
5\|07/06/2006\|101\|ASC\|FEDEX\|Y\|\
6\|07/16/2006\|105\|ASC\|FEDEX\|Y\|\
7\|08/04/2006\|104\|PHL\|FEDEX\|Y\|\
8\|08/16/2006\|101\|ASC\|FEDEX\|Y\|\
9\|08/23/2006\|101\|ASC\|FEDEX\|Y\|\
10\|09/06/2006\|106\|PHL\|FEDEX\|Y\|

### Items table

1\|456\|10\|5.55\|\
1\|310\|5\|12.85\|\
1\|744\|60\|250.95\|\
2\|456\|15\|5.55\|\
2\|310\|2\|12.85\|\
3\|323\|2\|0.95\|\
4\|744\|60\|250.95\|\
4\|456\|15\|5.55\|\
5\|456\|12\|5.55\|\
5\|310\|15\|12.85\|\
5\|744\|6\|250.95\|\
6\|456\|15\|5.55\|\
6\|310\|2\|12.85\|\
7\|323\|10\|0.95\|\
8\|456\|10\|5.55\|\
8\|310\|15\|12.85\|\
9\|744\|20\|250.95\|\
10\|323\|200\|0.95\|

### Stock table

456\|ASC\|lightbulbs\|5.55\|5.0\|01/16/2006\|ctn\|\
310\|ASC\|sink stoppers\|12.85\|11.57\|06/16/2006\|grss\|\
323\|PHL\|bolts\|0.95\|0.86\|01/16/2006\|20/b\|\
744\|ASC\|faucets\|250.95\|225.86\|01/16/2006\|6/bx\|

### Factory table

ASC\|Assoc. Std. Co.\|\
PHL\|Phelps Lighting\|

### State table

IL\|Illinois\|\
IA\|Iowa\|\
WI\|Wisconsin\|

------------------------------------------------------------------------
