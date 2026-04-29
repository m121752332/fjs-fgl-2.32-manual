[Back to Contents](../index.html)

------------------------------------------------------------------------

# [General Terms used in this documentation]{#PAGE_HEADER}

This documentation uses several terms that must be clarified for a good
understanding. Here is a short description for all these terms:

**[Product]{#PRODUCT}**
:   The *Product* defines all software components that compose the
    information system managing a given domain. Usually, the domains
    covered by programs written in BDL are business oriented.

**[End User]{#END_USER}**
:   The *End User* is the person that uses the Product; that person
    works on hardware called the [Workstation](#WORKSTATION).

**[Programs]{#PROGRAM}**
:   The *Programs* are the software components that are developed and
    distributed by the supplier of the [Product](#PRODUCT). *Programs*
    typically implement business rules and processing, usually called
    Business Logic. *Programs* are executed by the [Runtime
    System](#RUNTIME_SYSTEM) on the Application Server machine. These
    components are typically p-code modules, forms and additional files.

**[Developer]{#DEVELOPER}**
:   The *Developer* is the person in charge of the conception and
    implementation of the [Product](#PRODUCT) components.

**[Application Data]{#APPLICATION_DATA}**
:   *Application Data* defines the data manipulated by the
    [Product](#PRODUCT). It is typically managed by one or more
    [Database Systems](#DATABASE_SYSTEM). The *Application Data* has a
    volatile state when loaded in the [Runtime System](#RUNTIME_SYSTEM),
    and it has a static state when stored in the Database System.

**[Database]{#DATABASE}**
:   The *Database* is a logical entity regrouping the [Application
    Data](#APPLICATION_DATA). It is managed by the [Database
    System](#DATABASE_SYSTEM).

**[Database System]{#DATABASE_SYSTEM}**
:   The *Database System* is the software that manages data storage and
    searching; it is usually installed on the Database Server machine
    and is supported by a tier software vendor. It is the software
    managing the Data in the Three-Tier C/S model.

**[Development Database]{#DEVELOPMENT_DATABASE}**
:   The *Development Database* is the [Database](#DATABASE) used in the
    application development environment.

**[Production Database]{#PRODUCTION_DATABASE}**
:   The *Production Database* is the [Database](#DATABASE) used on
    production sites.

**[Front End]{#FRONT_END}**

The *Front End* is the software that manages the display of the [User
Interface](#USER_INTERFACE) on the [Workstation](#WORKSTATION) machine.
This component is historically called \"The Client\", in a thin
Client/Server context. It is the software managing the Presentation in
the Three-Tier C/S model.

**[Runtime System]{#RUNTIME_SYSTEM}**

The *Runtime System* is the software that manages the execution of the
[Programs](#PROGRAM), where the Business Logic is processed. It is
typically implemented by the *Dynamic Virtual Machine* (DVM) and
historically called \"The Runner\". It is the software managing the
Processing in the Three-Tier C/S model.

**[User Interface]{#USER_INTERFACE}**

The *User Interface* defines the parts of the Programs that interact
with the end user, including interactive elements like windows, screens,
input fields, buttons and menus. It is displayed on the
[Workstation](#WORKSTATION). This can typically be implemented by
different kinds of [Front Ends](#FRONT_END), based on ASCII terminals,
graphical platforms (MS Windows, X11) or even through web protocols like
HTML over HTTP.

**[Graphical User Interface]{#GRAPHICAL_USER_INTERFACE}**

The *Graphical User Interface* (GUI) mode identifies the user interface
displayed on a remote machine via a [Front End](#FRONT_END). Genero GUI
mode is active when the [FGLGUI](EnvironmentVariables.html#EV_FGLGUI)
environment variable is set to 1 (or when not set, GUI is the the
default). 

**[Text User Interface]{#TEXT_USER_INTERFACE}**

The *Text User Interface* (TUI) mode identifies the user interface
displayed on ASCII terminals (TTY on UNIX or Console Window on MS
Windows). Genero TUI mode is active when the
[FGLGUI](EnvironmentVariables.html#EV_FGLGUI) environment variable is
set to 0.

**[Workstation]{#WORKSTATION}**

The *Workstation* identifies the hardware used by the [End
User](#END_USER) to interact with the [Product](#PRODUCT). It can be an
ASCII Terminal, a PC, a diskless station or even a cellular phone, as
long as a [Front End](#FRONT_END) is available on that hardware.
