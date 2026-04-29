[Back to Contents](../index.html)

------------------------------------------------------------------------

# Genero BDL Tutorial Summary

If you are a developer new to **Genero** and the **Business Development
Language**, this tutorial is designed for you, to explain concepts and
provide code examples for some of the common business-related tasks. The
only prerequisite knowledge is familiarity with relational databases and
SQL.

The chapters contain a series of programs that range in complexity from
simply displaying a database row to more advanced topics, such as
handling arrays and master/detail relationships. Each chapter has a
general discussion of the features and programming techniques used in
the example programs, with annotated code samples. The examples in later
chapters build on concepts and functions explained in earlier chapters.
These programs have the BDL keywords in uppercase letters; this is a
convention only. For ease in reading, the BDL keywords are colored
green. The line numbers in the programs are for reference only; they are
not a part of the BDL code.

If you wish to run the example programs or try out the programming
techniques described in this tutorial, See [Testing the Example
Programs](#testing) for the requirements.

For an overview of Genero BDL,  see [Introduction: BDL
Concepts](IntroBDL.html). 

------------------------------------------------------------------------

# Tutorial Chapters

  ---------------------------------------------------------------- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  **Chapter**                                                      **Description**
  [1 - Overview](TutChap01.html)                                   This chapter provides an overview of the Tutorial and a description of the database schema  and sample data used for the example programs. 
  [2 - Using BDL](TutChap02.html)                                  This chapter illustrates the structure of a BDL program and some of the BDL statements that perform some common tasks - display a text message to the screen, connect to a database and retrieve data, define variables, and pass variables between functions.
  [3 - Displaying Data(Windows/Forms)](TutChap03.html)             This chapter illustrates opening a window that contains a form to display information to the user. An SQL statement is used to retrieve the data from a database table. A form specification file is defined to display the values retrieved.  The actions that are available to the user are defined in the source code, tied to buttons that display on the form. 
  [4 - Searching the Database(Query by Example)](TutChap04.html)   The program in this chapter allows the user to search a database by entering criteria in a form. The search criteria is used to build an SQL SELECT statement to retrieve the desired database rows. A cursor is defined in the program, to allow the user to scroll back and forth between the rows of the result set.  Testing the success of the SQL statements and handling errors is illustrated.
  [5 - Enhancing the Form](TutChap05.html)                         Program forms can be displayed in a variety of ways. This chapter illustrates adding a Toolbar or a Topmenu (pulldown menu) by modifying the form specification file, changing the window\'s appearance, and disabling/enabling actions. The example programs in this chapter use some of the action defaults defined by Genero BDL to standardize the presentation of common actions to the user.
  [6 - Modifying Data (Insert/Update/Delete)](TutChap06.html)      This program allows the user to insert/update/delete rows in the customer database table.  Embedded SQL statements (UPDATE/INSERT/DELETE) are used to update the table, based on the values stored in the program record.  SQL transactions, concurrency, and consistency are discussed. A dialog window is displayed to prompt the user to verify the deletion of a row.
  [7 - Displaying an Array of Data](TutChap07.html)                Unlike the previous programs, the example in this chapter displays multiple customer records at once.  The program defines a program array to hold the records, and displays the records in a form containing a table and a screen array.  The example program is then modified to dynamically fill the array as needed.  This program illustrates a library function - the example is written so it can be used in multiple programs, maximizing code re-use.
  [8 - Modifying an Array](TutChap08.html)                         The program in this chapter allows the user to view and change a list of records displayed on a form. As each record in the program array is added, updated, or deleted,  the program logic makes corresponding changes in the rows of the corresponding database table. 
  [9 - Creating Reports](TutChap09.html)                           This program generates a simple report of the data in the customer database table. The two parts of a report, the report driver logic and the report definition are illustrated.  A technique to allow a user to interrupt a long-running report is shown.
  [10 -Using Localization](TutChap10.html)                         Localization support and localized strings allow you to internationalize your application using different languages, and to customize it for specific industry markets in your user population. This chapter illustrates the use of localized strings in your programs.
  [11 - Managing Master/Detail Forms](TutChap11.html)              The form used by the program in this chapter contains fields from both the **orders** and **items** tables in the **custdemo** database, illustrating a master-detail relationship.  Since there are multiple items associated with a single order, the rows from the items table are  displayed in a table on the form.  This chapter focuses on the master/detail form and the unique features of the corresponding program.
  [12 - Changing the User Interface Dynamically](TutChap12.html)   This chapter focuses on using the classes and methods in the **ui** package of built-in classes to modify the user interface at runtime. Among the techniques illustrated are hiding or disabling form items; changing the text, style or image associated with a form item; loading a ComboBox from a database table; and adding Toolbars and Topmenus dynamically.
  [13 - Master/Detail using Multiple Dialogs](TutChap13.html)      This chapter shows how to implement **order** and **items** input in a unique dialog statement. In chapter 11 the order input is detached from the items input. The code example in chapter 13 makes both order and item input fields active at the same time, which is more natural in GUI applications.
  ---------------------------------------------------------------- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------

## [Testing the Example Programs]{#testing}

Before you can create the **custdemo** database and test the example
programs, the following requirements must be met:

- You must have access to one of the supported relational database
  systems, and it must be up and running.
- Genero BDL must be installed, and the [appropriate
  environment](Installation.html) must be set to allow you to use it.
- The front-end client specific to your system (Genero Desktop Client,
  for example) must be installed.
- A text-editor to view and edit the program files must be available.

The example database is designed to be as generic as possible, so it can
be implemented on various relational database systems.

The source code of example programs are provided in the **Tutorial**
directory of the HTML documentation.

To set up the environment in order to run the example programs:

1.  Using your database system software, create an empty database named
    **custdemo** with logging enabled.
2.  Make a copy on your system of the **Tutorial** directory provided in
    the documentation.
3.  From your copy of the Tutorial files:

> - execute the SQL statements in the file
>   **[custdemo.sql](../Tutorial/custdemo.sql)** to create tables in the
>   **custdemo** database.
> - Execute the SQL statements in the file
>   **[loadcust.sql](../Tutorial/loadcust.sql)** to insert rows into the
>   tables of the **custdemo** database.

4.  Configure [FGLPROFILE](FglProfile.html) with **dbi.\*** entries to
    connect to the database. See [Connections](Connections.html) for
    more details.
5.  Set the [FGLDBPATH](EnvironmentVariables.html#EV_FGLDBPATH)
    environment variable to \"**..**\", in order to let compilers access
    the **custdemo.sch** database schema file from example
    sub-directories.

------------------------------------------------------------------------
