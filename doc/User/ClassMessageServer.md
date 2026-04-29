[Back to Contents](../index.html)

------------------------------------------------------------------------

# [The MessageServer class]{#PAGE_HEADER}

**Warning: This feature is experimental and subject to change.**

Summary:

- [Syntax](#SYNTAX)
- [Methods](#METHODS)
- [Usage](#USAGE)
- [Examples](#EXAMPLES)

*See also:* [Built-in Classes](BuiltInClasses.html), [Form Specification
File](FormSpecFiles.html)

------------------------------------------------------------------------

### [Syntax]{#SYNTAX}

The **MessageServer** class allows a program to send a key action over
the network to other programs using this service. The action
transmission is [not]{.underline} guaranteed.

#### Syntax:

`base.MessageServer`

------------------------------------------------------------------------

### [Methods:]{#METHODS}

+-----------------------------------------+----------------------------------+
| **Class Methods**                                                          |
+-----------------------------------------+----------------------------------+
| **Name**                                | **Description**                  |
+-----------------------------------------+----------------------------------+
| [`connect`](#connect)`()`               | Connects to the group of         |
|                                         | programs to be notified by a     |
|                                         | message.                         |
+-----------------------------------------+----------------------------------+
| [`send`](#send)`( keyname ``STRING`` )` | Sends a key event to the group   |
|                                         | of programs connected together.  |
+-----------------------------------------+----------------------------------+

------------------------------------------------------------------------

### [Usage:]{#USAGE}

The MessageServer class can be used to join a group of programs to be
notified by simple messages (i.e. key events). The programs can run on
different machines connected together in a network.

**Warning: The MessageServer uses network API capabilities with Sockets
and the UDP protocol. While this is obvious, make sure the computers are
configured with a network. Note that the UDP protocol does not guarantee
the transmission of datagrams. Therefore, messages sent with the
MessageServer can arrive out of order, duplicated, or go missing without
notice.**

The UPD port used is **6600**, the IP address group is **224.0.1.1**,
and this cannot be changed.

#### [Connecting to the group]{#connect}

First the program must call the `base.MessageServer.connect()` class
method to join the group of programs that can be notified by a message.

#### [Sending a message]{#send}

Once connected to the message server group, a program can call the
`base.MessageServer.send()` class method to notify other programs
registered to the group.

``` linenumber
01 CALL base.MesageServer.connect()
02 CALL base.MessageServer.send("f1")
```

All programs registered to the message server group (including the
program which has sent the message) will be notified. The messages can
be treated by the current dialog with a simple ` ON KEY()` interaction
block.

------------------------------------------------------------------------

### [Examples]{#EXAMPLES}

#### Example 1: Simple MessageServer usage

``` linenumber
01 MAIN
02   CALL base.MessageServer.connect()
03   MENU "test"
04       COMMAND "send F1" CALL base.MessageServer.send("f1")
05       ON KEY (F1) DISPLAY "Key F1 received..."
06       COMMAND "quit" EXIT MENU
07   END MENU
08 END MAIN
```
