[Back to Contents](../index.html)

------------------------------------------------------------------------

# [Displaying Messages]{#PAGE_HEADER}

Summary:

- [Displaying Text in Line Mode](#DISPLAY) (`DISPLAY`)
- [Displaying Error Messages](#ERROR) (`ERROR`)
- [Displaying Application Messages](#MESSAGE) (`MESSAGE`)

------------------------------------------------------------------------

### [DISPLAY]{#DISPLAY}

#### Purpose:

The `DISPLAY` instruction displays text in line mode to the standard
output channel.

#### Syntax:

`DISPLAY `*`expression`*` `[`[,...]`]{.underline}` `

#### Notes:

1.  *expression* is any [expression](Expressions.html) supported by the
    language.

#### Usage:

You can use this instruction to display information to the standard
output channel.

The values contained in [variables](Variables.html) are formatted based
on the [data type](DataTypes.html) and [environment
settings](EnvironmentVariables.html).

#### Example:

``` linenumber
01 MAIN
02   DISPLAY "Today's date is: ", TODAY
03 END MAIN
```

------------------------------------------------------------------------

### [ERROR]{#ERROR}

#### Purpose:

The `ERROR` instruction displays an error message to the user.

#### Syntax:

`ERROR `*`expression`*` `[`[,...]`]{.underline}` `[`[`]{.underline}` ATTRIBUTE ( `*`display-attribute`*` `[`[,...]`]{.underline}` ) `[`]`]{.underline}

#### Notes:

1.  *expression* is any [expression](Expressions.html) supported by the
    language.
2.  *display-attribute* is an attribute to display the error text. See
    below.

#### Usage:

The `ERROR` instruction displays an error message to the user.

In [TUI](FglTerms.html#TEXT_USER_INTERFACE) mode, the error text is
displayed in the [Error Line]{.underline} of the current
[window](WindowsAndForms.html). In
[GUI](FglTerms.html#GRAPHICAL_USER_INTERFACE) mode, the text is
displayed in a specific area, depending on the front end configuration.

Possible attributes that can be used as *display-attribute*:

::: {align="center"}
  --------------------------------------------------------- --------------------------------------------
  **Attribute**                                             **Description**
  `STYLE = `*`string`*                                      The name of a Presentation Style.
  `BLACK, BLUE, CYAN, GREEN, MAGENTA, RED, WHITE, YELLOW`   The color of the displayed text.
  `BOLD, DIM, INVISIBLE, NORMAL`                            The font attribute of the displayed text.
  `REVERSE, BLINK` (**TUI Only!**)`, UNDERLINE`             The video attribute of the displayed text.
  --------------------------------------------------------- --------------------------------------------
:::

When you specify the `STYLE` attribute, you can reference a style
defined in the [Presentation Styles](PresentationStyles.html) file. This
allows you to display errors or messages with more sophisticated visual
effects as the regular TTY attributes. Advanced automatic rendering can
be obtained with [Message specific style
attributes](PresentationStyles.html#STYATT_MESSAGE). Note that if you
want to apply automatically a style to all program warnings displayed
with the `ERROR` instruction, you can use the **:error** pseudo selector
in the style definition.

#### Example:

``` linenumber
01 MAIN
02    WHENEVER ERROR CONTINUE
03    DATABASE stock
04    WHENEVER ERROR STOP
05    IF sqlca.sqlcode THEN
06       ERROR "Connection failed (" || sqlca.sqlcode || ")"
07    END IF
08 END MAIN
```

------------------------------------------------------------------------

### [MESSAGE]{#MESSAGE}

#### Purpose:

The `MESSAGE` instruction displays a message to the user.

#### Syntax:

`MESSAGE `*`message`*` `[`[,...]`]{.underline}` `[`[`]{.underline}` ATTRIBUTE ( `*`display-attribute`*` `[`[,...]`]{.underline}` ) `[`]`]{.underline}

#### Notes:

1.  *expression* is any [expression](Expressions.html) supported by the
    language.
2.  *display-attribute* is an attribute to display the error text. See
    below.

#### Usage:

The `MESSAGE` instruction displays a message to the user.

In [TUI](FglTerms.html#TEXT_USER_INTERFACE) mode, the text is displayed
in the [Comment Line]{.underline} of the current
[window](WindowsAndForms.html). In
[GUI](FglTerms.html#GRAPHICAL_USER_INTERFACE) mode, the text is
displayed in a specific area, depending on the front end configuration.

Possible attributes that can be used as *display-attribute*:

::: {align="center"}
  --------------------------------------------------------- --------------------------------------------
  **Attribute**                                             **Description**
  `STYLE = `*`string`*                                      The name of a Presentation Style.
  `BLACK, BLUE, CYAN, GREEN, MAGENTA, RED, WHITE, YELLOW`   The color of the displayed text.
  `BOLD, DIM, INVISIBLE, NORMAL`                            The font attribute of the displayed text.
  `REVERSE, BLINK` (**TUI Only!**)`, UNDERLINE`             The video attribute of the displayed text.
  --------------------------------------------------------- --------------------------------------------
:::

When you specify the `STYLE` attribute, you can reference a style
defined in the [Presentation Styles](PresentationStyles.html) file. This
allows you to display errors or messages with more sophisticated visual
effects as the regular TTY attributes. Advanced automatic rendering can
be obtained with [Message specific style
attributes](PresentationStyles.html#STYATT_MESSAGE). Note that if you
want to apply automatically a style to all program messages displayed
with the `MESSAGE` instruction, you can use the **:message** pseudo
selector in the style definition.

#### Example:

``` linenumber
01 MAIN
02    WHENEVER ERROR CONTINUE
03    DATABASE stock
04    WHENEVER ERROR STOP
05    IF sqlca.sqlcode THEN
06       ERROR "Connection failed (" || sqlca.sqlcode || ")"
07    ELSE
08       MESSAGE "Connected to database." ATTRIBUTE (STYLE="info3")
09    END IF
10 END MAIN
```
