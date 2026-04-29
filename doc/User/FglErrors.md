[Back to Contents](../index.html)

------------------------------------------------------------------------

# [Error Messages]{#PAGE_HEADER}

This page describes Genero system error messages. If needed, you can
customize or translate these system messages to your own language. See
[Localization, Runtime System Messages](Localization.html#RTMSG) for
more details.

+:---------------------------------:+-------------------------------------------------+
| **Number**                        | **Description**                                 |
+-----------------------------------+-------------------------------------------------+
| [-201]{#-201}                     | **A syntax error has occurred.**\               |
|                                   | *Description:* This general error message       |
|                                   | indicates mistakes in the form of an SQL        |
|                                   | statement.\                                     |
|                                   | *Solution:* Look for missing or extra           |
|                                   | punctuation; keywords misspelled, misused, or   |
|                                   | out of sequence, or a reserved word used as an  |
|                                   | identifier.                                     |
+-----------------------------------+-------------------------------------------------+
| [-235]{#-235}                     | **Character column size is too big.**\          |
|                                   | *Description:* The SQL statement specifies a    |
|                                   | width for a character data type that is greater |
|                                   | than 65,534 bytes.\                             |
|                                   | *Solution:* If you need a column of this size,  |
|                                   | use the TEXT data type, which allows unlimited  |
|                                   | lengths. Otherwise, inspect the statement for   |
|                                   | typographical errors.                           |
+-----------------------------------+-------------------------------------------------+
| [-307]{#-307}                     | **Illegal subscript.**\                         |
|                                   | *Description:* The substring values (two        |
|                                   | numbers in square brackets) of a character      |
|                                   | variable are incorrect. The first is less than  |
|                                   | zero or greater than the length of the column,  |
|                                   | or the second is less than the first.\          |
|                                   | *Solution:* Review all uses of square brackets  |
|                                   | in the statement to find the error. Possibly    |
|                                   | the size of a column has been altered and makes |
|                                   | a substring fail that used to work.             |
+-----------------------------------+-------------------------------------------------+
| [-363]{#-363}                     | **CURSOR not on SELECT statement.**\            |
|                                   | *Description:* The cursor named in this         |
|                                   | statement (probably an OPEN) has been           |
|                                   | associated with a prepared statement that is    |
|                                   | not a SELECT statement.\                        |
|                                   | *Solution:* Review the program logic,           |
|                                   | especially the DECLARE for the cursor, the      |
|                                   | statement id specified in it, and the PREPARE   |
|                                   | that set up that statement. If you intended to  |
|                                   | use a cursor with an INSERT statement, you can  |
|                                   | only do that when the INSERT statement is       |
|                                   | written as part of the DECLARE statement. If    |
|                                   | you intended to execute an SQL statement, do    |
|                                   | that directly with the EXECUTE statement, not   |
|                                   | indirectly through a cursor.                    |
+-----------------------------------+-------------------------------------------------+
| [-450]{#-450}                     | **Illegal ESQL locator, or uninitialized blob   |
|                                   | variable in 4gl.**\                             |
|                                   | *Description:* An SQL statement is using a TEXT |
|                                   | or BYTE variable that was not initialized with  |
|                                   | LOCATE IN FILE or MEMORY.\                      |
|                                   | *Solution:* LOCATE the TEXT or BYTE variable    |
|                                   | before using it in SQL statements.              |
+-----------------------------------+-------------------------------------------------+
| [-513]{#-513}                     | **Statement not available with this database    |
|                                   | server.\**                                      |
|                                   | *Description:* The SQL statement used by the    |
|                                   | program is not valid for the target database    |
|                                   | server.\                                        |
|                                   | *Solution:* Review the code, the SQL            |
|                                   | instruction cannot be used.                     |
+-----------------------------------+-------------------------------------------------+
| [-805]{#-805}                     | **Cannot open file for load.**\                 |
|                                   | *Description:* The input file that is specified |
|                                   | in this LOAD statement could not be opened.\    |
|                                   | *Solution:* Check the statement. Possibly a     |
|                                   | more complete pathname is needed, the file does |
|                                   | not exist, or your account does not have read   |
|                                   | permission for the file or a directory in which |
|                                   | it resides.                                     |
+-----------------------------------+-------------------------------------------------+
| [-806]{#-806}                     | **Cannot open file for unload.**\               |
|                                   | *Description:* The output file that is          |
|                                   | specified in this UNLOAD statement could not be |
|                                   | opened.\                                        |
|                                   | *Solution:* Check the statement. Possibly a     |
|                                   | more complete pathname is needed; the file      |
|                                   | exists, but your account does not have write    |
|                                   | permission for it; or the disk is full.         |
+-----------------------------------+-------------------------------------------------+
| [-809]{#-809}                     | **SQL Syntax error has occurred.**\             |
|                                   | *Description:* The INSERT statement in this     |
|                                   | LOAD/UNLOAD statement has invalid syntax.\      |
|                                   | *Solution:* Review it for punctuation and use   |
|                                   | of keywords.                                    |
+-----------------------------------+-------------------------------------------------+
| [-846]{#-846}                     | **Number of values in load file is not equal to |
|                                   | number of columns.**\                           |
|                                   | *Description:* The LOAD processor counts the    |
|                                   | delimiters in the first line of the file to     |
|                                   | determine the number of values in the load      |
|                                   | file. One delimiter must exist for each column  |
|                                   | in the table, or for each column in the list of |
|                                   | columns if one is specified.\                   |
|                                   | *Solution:* Check that you specified the file   |
|                                   | that you intended and that it uses the correct  |
|                                   | delimiter character. An empty line in the text  |
|                                   | can also cause this error.  If the LOAD         |
|                                   | statement does not specify a delimiter, verify  |
|                                   | that the default delimiter matches the          |
|                                   | delimiter that is used in the file. If you are  |
|                                   | in doubt about the default delimiter, specify   |
|                                   | the delimiter in the LOAD statement.            |
+-----------------------------------+-------------------------------------------------+
| [-1102]{#-1102}                   | **Field name not found in form.**\              |
|                                   | *Description:* A field name listed in an INPUT, |
|                                   | INPUT ARRAY, CONSTRUCT, SCROLL or DISPLAY       |
|                                   | statement does not appear in the form           |
|                                   | specification of the screen form that is        |
|                                   | currently displayed.\                           |
|                                   | *Solution:* Review the program logic to ensure  |
|                                   | that the intended window is current, the        |
|                                   | intended form is displayed in it, and all the   |
|                                   | field names in the statement are spelled        |
|                                   | correctly.                                      |
+-----------------------------------+-------------------------------------------------+
| [-1107]{#-1107}                   | **Field subscript out of bounds.**\             |
|                                   | *Description:* The subscript of a screen array  |
|                                   | in an INPUT, DISPLAY, or CONSTRUCT statement is |
|                                   | either less than 1 or greater than the number   |
|                                   | of fields in the array.\                        |
|                                   | *Solution:* Review the program source in        |
|                                   | conjunction with the form specification to see  |
|                                   | where the error lies.                           |
+-----------------------------------+-------------------------------------------------+
| [-1108]{#-1108}                   | **Record name not in form.**\                   |
|                                   | *Description:* The screen record that is named  |
|                                   | in an INPUT ARRAY or DISPLAY ARRAY statement    |
|                                   | does not appear in the screen form that is now  |
|                                   | displayed.\                                     |
|                                   | *Solution:* Review the program source in        |
|                                   | conjunction with the form specification to see  |
|                                   | if the screen record names match.               |
+-----------------------------------+-------------------------------------------------+
| [-1109]{#-1109}                   | **List and record field counts differ.**\       |
|                                   | *Description:* The number of program variables  |
|                                   | does not agree with the number of screen fields |
|                                   | in a CONSTRUCT, INPUT, INPUT ARRAY, DISPLAY, or |
|                                   | DISPLAY ARRAY statement.\                       |
|                                   | *Solution:* Review the statement in conjunction |
|                                   | with the form specification to see where the    |
|                                   | error lies. Common problems include a change in |
|                                   | the definition of a screen record that is not   |
|                                   | reflected in every statement that uses the      |
|                                   | record, and a change in a program record that   |
|                                   | is not reflected in the form design.            |
+-----------------------------------+-------------------------------------------------+
| [-1110]{#-1110}                   | **Form file not found.**\                       |
|                                   | *Description:* The form file that is specified  |
|                                   | in an OPEN FORM statement was not found.\       |
|                                   | *Solution:* Inspect the \"form-file\" parameter |
|                                   | of the statement. It should not include the     |
|                                   | file suffix .frm. However, if the form is not   |
|                                   | in the current directory, it should include a   |
|                                   | complete path to the file.                      |
+-----------------------------------+-------------------------------------------------+
| [-1112]{#-1112}                   | **A form is incompatible with the current BDL   |
|                                   | version. Rebuild your form.**\                  |
|                                   | *Description:* The form file that is specified  |
|                                   | in an OPEN FORM statement is not acceptable.    |
|                                   | Possibly it was corrupted in some way, or it    |
|                                   | was compiled with a version of the Form         |
|                                   | Compiler that is not compatible with the        |
|                                   | version of the BDL compiler that compiled this  |
|                                   | program.\                                       |
|                                   | *Solution:* Use a current version of the Form   |
|                                   | Compiler to recompile the form specification.   |
+-----------------------------------+-------------------------------------------------+
| [-1114]{#-1114}                   | **No form has been displayed.**\                |
|                                   | *Description:* The current statement requires   |
|                                   | the use of a screen form. For example,          |
|                                   | DISPLAY\...TO or an INPUT statement must use    |
|                                   | the fields of a form. However, the DISPLAY FORM |
|                                   | statement has not been executed since the       |
|                                   | current window was opened.\                     |
|                                   | *Solution:* Review the program logic to ensure  |
|                                   | that it opens and displays a form before it     |
|                                   | tries to use a form.                            |
+-----------------------------------+-------------------------------------------------+
| [-1119]{#-1119}                   | **NEXT FIELD name not found in form.**\         |
|                                   | *Description:* This statement (INPUT or INPUT   |
|                                   | ARRAY) contains a NEXT FIELD clause that names  |
|                                   | a field that is not defined in the form.\       |
|                                   | *Solution:* Review the form and program logic.  |
|                                   | Perhaps the form has been changed, but the      |
|                                   | program has not.                                |
+-----------------------------------+-------------------------------------------------+
| [-1129]{#-1129}                   | **Field (*name*) in BEFORE/AFTER clause not     |
|                                   | found in form.**\                               |
|                                   | *Description:* This statement includes a BEFORE |
|                                   | FIELD clause or an AFTER FIELD clause that      |
|                                   | names a field that is not defined in the form   |
|                                   | that is currently displayed.\                   |
|                                   | *Solution:* Review the program to ensure that   |
|                                   | the intended form was displayed, and review     |
|                                   | this statement against the form specification   |
|                                   | to ensure that existing fields are named.       |
+-----------------------------------+-------------------------------------------------+
| [-1133]{#-1133}                   | **The NEXT OPTION name is not in the menu.**\   |
|                                   | *Description:* This MENU statement contains a   |
|                                   | NEXT OPTION clause that names a menu-option     |
|                                   | that is not defined in the statement.\          |
|                                   | *Solution:* The string that follows NEXT OPTION |
|                                   | must be identical to one that follows a COMMAND |
|                                   | clause in the same MENU statement. Review the   |
|                                   | statement to ensure that these clauses agree    |
|                                   | with each other.                                |
+-----------------------------------+-------------------------------------------------+
| [-1140]{#-1140}                   | **NEXT OPTION is a hidden option.**\            |
|                                   | *Description:* The option that is named in this |
|                                   | NEXT OPTION statement has previously been       |
|                                   | hidden with the HIDE OPTION statement. Because  |
|                                   | it is not visible to the user, it cannot be     |
|                                   | highlighted as the next choice.\                |
|                                   | *Solution:* Use the SHOW OPTION statement to    |
|                                   | unhide the menu option.                         |
+-----------------------------------+-------------------------------------------------+
| [-1141]{#-1141}                   | **Cannot close window with active INPUT,        |
|                                   | DISPLAY ARRAY, or MENU statement.**\            |
|                                   | *Description:* This CLOSE WINDOW statement      |
|                                   | cannot be executed because an input operation   |
|                                   | is still active in that window. The CLOSE       |
|                                   | WINDOW statement must have been contained in,   |
|                                   | or called from within, the input statement      |
|                                   | itself.\                                        |
|                                   | *Solution:* Review the program logic, and       |
|                                   | revise it so that the statement completes       |
|                                   | before the window is closed.                    |
+-----------------------------------+-------------------------------------------------+
| [-1143]{#-1143}                   | **Window is already open.**\                    |
|                                   | *Description:* This OPEN WINDOW statement names |
|                                   | a window that is already open.\                 |
|                                   | *Solution:* Review the program logic, and see   |
|                                   | whether it should contain a CLOSE WINDOW        |
|                                   | statement, or whether it should simply use a    |
|                                   | CURRENT WINDOW statement to bring the open      |
|                                   | window to the top.                              |
+-----------------------------------+-------------------------------------------------+
| [-1146]{#-1146}                   | **PROMPT message is too long to fit in the      |
|                                   | window.**\                                      |
|                                   | *Description:* Although BDL truncates the       |
|                                   | output of MESSAGE and COMMENT to fit the window |
|                                   | dimensions, it does not do so for PROMPT and    |
|                                   | the user\'s response.\                          |
|                                   | *Solution:* Reduce the length of the prompt     |
|                                   | string, or make the window larger. You could    |
|                                   | display most of the prompting text with DISPLAY |
|                                   | and then prompt with a single space or colon.   |
+-----------------------------------+-------------------------------------------------+
| [-1150]{#-1150}                   | **Window is too small to display this menu.**\  |
|                                   | *Description:*  The window must be at least two |
|                                   | rows tall, and it must be wide enough to        |
|                                   | display the menu title, the longest option      |
|                                   | name, two sets of three-dot ellipses, and six   |
|                                   | spaces. Revise the program to make the window   |
|                                   | larger or to give the menu a shorter name and   |
|                                   | shorter options.\                               |
|                                   | *Solution:* Review the OPEN WINDOW statement    |
|                                   | for the current window in conjunction with this |
|                                   | MENU statement.                                 |
+-----------------------------------+-------------------------------------------------+
| [-1168]{#-1168}                   | **Command does not appear in the menu.**\       |
|                                   | *Description:* The SHOW OPTION, HIDE OPTION, or |
|                                   | NEXT OPTION statement cannot refer to an option |
|                                   | (command) that does not exist.\                 |
|                                   | *Solution:* Check the spelling of the name of   |
|                                   | the option.                                     |
+-----------------------------------+-------------------------------------------------+
| [-1170]{#-1170}                   | **The type of your terminal is unknown to the   |
|                                   | system.**\                                      |
|                                   | *Description:* Check the setting of your TERM   |
|                                   | environment variable and the setting of your    |
|                                   | TERMCAP or TERMINFO environment variable.\      |
|                                   | *Solution:* Check with your system              |
|                                   | administrator if you need help with this        |
|                                   | action.                                         |
+-----------------------------------+-------------------------------------------------+
| [-1202]{#-1202}                   | **An attempt was made to divide by zero.\**     |
|                                   | *Description:* Zero cannot be a divisor.\       |
|                                   | *Solution:* Check that the divisor is not zero. |
|                                   | In some cases, this error arises because the    |
|                                   | divisor is a character value that does not      |
|                                   | convert properly to numeric.                    |
+-----------------------------------+-------------------------------------------------+
| [-1204]{#-1204}                   | **Invalid year in date.**\                      |
|                                   | *Description:* The year in a DATE value or      |
|                                   | literal is invalid. For example, the number     |
|                                   | 0000 is not acceptable as the year.\            |
|                                   | *Solution:* Check the value of year.            |
+-----------------------------------+-------------------------------------------------+
| [-1205]{#-1205}                   | **Invalid month in date.**\                     |
|                                   | *Description:* The month in a DATE value or     |
|                                   | literal must be a one- or two-digit number from |
|                                   | 1 to 12.\                                       |
|                                   | *Solution:* Check the value of month.           |
+-----------------------------------+-------------------------------------------------+
| [-1206]{#-1206}                   | **Invalid day in date.**\                       |
|                                   | *Description:* The day number in a DATE value   |
|                                   | or literal must a one- or two-digit number from |
|                                   | 1 to 28 (or 29 in a leap year), 30, or 31,      |
|                                   | depending on the month that accompanies it.\    |
|                                   | *Solution:* Check the value of day.             |
+-----------------------------------+-------------------------------------------------+
| [-1210]{#-1210}                   | **Date could not be converted to month/day/year |
|                                   | format.**\                                      |
|                                   | *Description:* The DATE type is compatible with |
|                                   | the INTEGER type, but not all integer values    |
|                                   | are valid dates. The range of valid integer     |
|                                   | values for dates is from -693,594 to            |
|                                   | +2,958,464. Numbers that are outside this range |
|                                   | have no representation as dates.\               |
|                                   | *Solution:* Check the value of the number used  |
|                                   | to assign the date variable.                    |
+-----------------------------------+-------------------------------------------------+
| [-1212]{#-1212}                   | **Date conversion format must contain a month,  |
|                                   | day, and year component.**\                     |
|                                   | *Description:* When a date value is converted   |
|                                   | between internal binary format and display or   |
|                                   | entry format, a pattern directs the conversion. |
|                                   | When conversion is done automatically, the      |
|                                   | pattern comes from the environment variable     |
|                                   | DBDATE. When it is done with an explicit call   |
|                                   | to the rfmtdate(), rdefmtdate(), or USING       |
|                                   | functions, a pattern string is passed as a      |
|                                   | parameter. In any case, the pattern string (the |
|                                   | format of the message) must include letters     |
|                                   | that show the location of the three parts of    |
|                                   | the date: 2 or 3 letters d; 2 or 3 letters m;   |
|                                   | and either 2 or 4 letters y.\                   |
|                                   | *Solution:*  Check the pattern string and the   |
|                                   | value of DBDATE.                                |
+-----------------------------------+-------------------------------------------------+
| [-1213]{#-1213}                   | **A character to numeric conversion process     |
|                                   | failed.**\                                      |
|                                   | *Description:* A character value is being       |
|                                   | converted to numeric form for storage in a      |
|                                   | numeric column or variable. However, the        |
|                                   | character string cannot be interpreted as a     |
|                                   | number.\                                        |
|                                   | *Solution:* Check the character string. It must |
|                                   | not contain characters other than white space,  |
|                                   | digits, a sign, a decimal, or the letter e.     |
|                                   | Verify the parts are in the right order. If you |
|                                   | are using NLS, the decimal character or         |
|                                   | thousands separator might be wrong for your     |
|                                   | locale.                                         |
+-----------------------------------+-------------------------------------------------+
| [-1214]{#-1214}                   | **Value too large to fit in a SMALLINT.**\      |
|                                   | *Description:* The SMALLINT data type can       |
|                                   | accept numbers with a value range from -32,767  |
|                                   | to +32,767.\                                    |
|                                   | *Solution:* To store numbers that are outside   |
|                                   | this range, redefine the column or variable to  |
|                                   | use INTEGER or DECIMAL type.                    |
+-----------------------------------+-------------------------------------------------+
| [-1215]{#-1215}                   | **Value too large to fit in an INTEGER.**\      |
|                                   | *Description:* The INTEGER data type can accept |
|                                   | numbers with a value range from -2,147,483,647  |
|                                   | to +2,147,483,647.\                             |
|                                   | *Solution:* Check the other data types          |
|                                   | available, such as DECIMAL.                     |
+-----------------------------------+-------------------------------------------------+
| [-1218]{#-1218}                   | **String to date conversion error.**\           |
|                                   | *Description:* The data value does not properly |
|                                   | represent a date: either it has non-digits      |
|                                   | where digits are expected, an unexpected        |
|                                   | delimiter, or numbers that are too large or are |
|                                   | inconsistent.\                                  |
|                                   | *Solution:* Check the value being converted.    |
+-----------------------------------+-------------------------------------------------+
| [-1226]{#-1226}                   | **Decimal or money value exceeds maximum        |
|                                   | precision.**\                                   |
|                                   | *Description:* The data value has more digits   |
|                                   | to the left of the decimal point than the       |
|                                   | declaration of the variable allows.\            |
|                                   | *Solution:* Revise the program to define the    |
|                                   | variable with an appropriate precision.         |
+-----------------------------------+-------------------------------------------------+
| [-1260]{#-1260}                   | **It is not possible to convert between the     |
|                                   | specified types.**\                             |
|                                   | *Description:* Data conversion does not make    |
|                                   | sense, or is not supported.\                    |
|                                   | *Solution:* Possibly you referenced the wrong   |
|                                   | variable or column. Check that you have         |
|                                   | specified the data types that you intended and  |
|                                   | that literal representations of data values are |
|                                   | correctly formatted.                            |
+-----------------------------------+-------------------------------------------------+
| [-1261]{#-1261}                   | **Too many digits in the first field of         |
|                                   | datetime or interval.**\                        |
|                                   | *Description:* The first field of a DATETIME    |
|                                   | literal must contain 1 or 2 digits (if it is    |
|                                   | not a YEAR) or else 2 or 4 digits (if it is a   |
|                                   | YEAR). The first field of an INTERVAL literal   |
|                                   | represents a count of units and can have up to  |
|                                   | 9 digits, depending on the precision that is    |
|                                   | specified in its qualifier.\                    |
|                                   | *Solution:* Review the DATETIME and INTERVAL    |
|                                   | literals in this statement, and correct them.   |
+-----------------------------------+-------------------------------------------------+
| [-1262]{#-1262}                   | **Non-numeric character in datetime or          |
|                                   | interval.**\                                    |
|                                   | *Description:* A DATETIME or INTERVAL literal   |
|                                   | can contain only decimal digits and the allowed |
|                                   | delimiters: the hyphen between year, month, and |
|                                   | day numbers; the space between day and hour;    |
|                                   | the colon between hour, minute, and second; and |
|                                   | the decimal point between second and fraction.  |
|                                   | Any other characters, or these characters in    |
|                                   | the wrong order, produce an error.\             |
|                                   | *Solution:* Check the value of the literal.     |
+-----------------------------------+-------------------------------------------------+
| [-1263]{#-1263}                   | **A field in a datetime or interval is out of   |
|                                   | range.**\                                       |
|                                   | *Description:* At least one of the fields in a  |
|                                   | datetime or interval is incorrect.\             |
|                                   | *Solution:* Inspect the DATE, DATETIME, and     |
|                                   | INTERVAL literals in this statement. In a DATE  |
|                                   | or DATETIME literal, the year might be zero,    |
|                                   | the month might be other than 1 to 12, or the   |
|                                   | day might be other than 1 to 31 or              |
|                                   | inappropriate for the month. Also in a DATETIME |
|                                   | literal, the hour might be other than 0 to 23,  |
|                                   | the minute or second might be other than 0 to   |
|                                   | 59, or the fraction might have too many digits  |
|                                   | for the specified precision.                    |
+-----------------------------------+-------------------------------------------------+
| [-1264]{#-1264}                   | **Extra characters at the end of a datetime or  |
|                                   | interval.**\                                    |
|                                   | *Description:* Only spaces can follow a         |
|                                   | DATETIME or INTERVAL literal.\                  |
|                                   | *Solution:* Inspect this statement for missing  |
|                                   | or incorrect punctuation.                       |
+-----------------------------------+-------------------------------------------------+
| [-1265]{#-1265}                   | **Overflow occurred on a datetime or interval   |
|                                   | operation.**\                                   |
|                                   | *Description:* An arithmetic operation          |
|                                   | involving a DATETIME and/or INTERVAL produced a |
|                                   | result that cannot fit in the target variable.\ |
|                                   | *Solution:* Check if the data type can hold the |
|                                   | result of the operation. For example, extend    |
|                                   | the INTERVAL precision by using YEAR(9) or      |
|                                   | DAY(9).                                         |
+-----------------------------------+-------------------------------------------------+
| [-1266]{#-1266}                   | **Intervals or datetimes are incompatible for   |
|                                   | the operation.**\                               |
|                                   | *Description:* An arithmetic operation mixes    |
|                                   | DATETIME and/or INTERVAL values that do not     |
|                                   | match.\                                         |
|                                   | *Solution:* Check the data types of the         |
|                                   | variable used in the operation.                 |
+-----------------------------------+-------------------------------------------------+
| [-1267]{#-1267}                   | **The result of a datetime computation is out   |
|                                   | of range.**\                                    |
|                                   | *Description:*  In this statement, a DATETIME   |
|                                   | computation produced a value that cannot be     |
|                                   | stored. This situation can occur, for example,  |
|                                   | if a large interval is added to a DATETIME      |
|                                   | value. This error can also occur if the         |
|                                   | resultant date does not exist, such as Feb 29,  |
|                                   | 1999.\                                          |
|                                   | *Solution:* Review the expressions in the       |
|                                   | statement and see if you can change the         |
|                                   | sequence of operations to avoid the overflow.   |
+-----------------------------------+-------------------------------------------------+
| [-1268]{#-1268}                   | **Invalid datetime or interval qualifier.**\    |
|                                   | *Description:* This statement contains a        |
|                                   | DATETIME or INTERVAL qualifier that is not      |
|                                   | acceptable. These qualifiers can contain only   |
|                                   | the words YEAR, MONTH, DAY, HOUR, MINUTE,       |
|                                   | SECOND, FRACTION, and TO. A number from 1 to 5  |
|                                   | in parentheses can follow FRACTION.\            |
|                                   | *Solution:* Inspect the statement for missing   |
|                                   | punctuation and misspelled words. A common      |
|                                   | error is adding an s, as in MINUTES.            |
+-----------------------------------+-------------------------------------------------+
| [-1284]{#-1284}                   | **Value will not fit in a BIGINT or INT8.**\    |
|                                   | *Description:* The BIGINT data type can accept  |
|                                   | numbers with a value range from                 |
|                                   | -9223372036854775807 to +9223372036854775807.\  |
|                                   | *Solution:* To store numbers that are outside   |
|                                   | this range, redefine the column or variable to  |
|                                   | use the DECIMAL type.                           |
+-----------------------------------+-------------------------------------------------+
| [-1301]{#-1301}                   | **This value is not among the valid             |
|                                   | possibilities.**\                               |
|                                   | *Description:* A list or range of acceptable    |
|                                   | values has been established for this column in  |
|                                   | the form-specification file.\                   |
|                                   | *Solution:* You must enter a value within the   |
|                                   | acceptable range.                               |
+-----------------------------------+-------------------------------------------------+
| [-1302]{#-1302}                   | **The two entries were not the same \-- please  |
|                                   | try again.**\                                   |
|                                   | *Description:* To guard against typographical   |
|                                   | errors, this field has been designated VERIFY   |
|                                   | in the form-specification file. You must enter  |
|                                   | the value in this field twice, identically.\    |
|                                   | *Solution:* Carefully reenter the data.         |
|                                   | Alternatively, you can cancel the form entry    |
|                                   | with the Interrupt key.                         |
+-----------------------------------+-------------------------------------------------+
| [-1303]{#-1303}                   | **You cannot use this editing feature because a |
|                                   | picture exists.**\                              |
|                                   | *Description:*  This field is defined in the    |
|                                   | form-specification file with a PICTURE          |
|                                   | attribute to specify its format.\               |
|                                   | *Solution:* You cannot use certain editing keys |
|                                   | (for example, CTRL-A, CTRL-D, and CTRL-X) while |
|                                   | you are editing such a field. Use only          |
|                                   | printable characters and backspace to enter the |
|                                   | value.                                          |
+-----------------------------------+-------------------------------------------------+
| [-1304]{#-1304}                   | **Error in field.**\                            |
|                                   | *Description:* You entered a value in this      |
|                                   | field that cannot be stored in the program      |
|                                   | variable that is meant to receive it.\          |
|                                   | *Solution:* Possibly you entered a decimal      |
|                                   | number when the application provided only an    |
|                                   | integer variable, or you entered a character    |
|                                   | string that is longer than the application      |
|                                   | expected.                                       |
+-----------------------------------+-------------------------------------------------+
| [-1305]{#-1305}                   | **This field requires an entered value.**\      |
|                                   | *Description:* The cursor is in a form field    |
|                                   | that has been designated REQUIRED.\             |
|                                   | *Solution:* You must enter some value before    |
|                                   | the cursor can move to another field. To enter  |
|                                   | a null value, type any printable character and  |
|                                   | then backspace. Alternatively, you can cancel   |
|                                   | the form entry with the Interrupt key.          |
+-----------------------------------+-------------------------------------------------+
| [-1306]{#-1306}                   | **Please type again for verification.**\        |
|                                   | *Description:* The cursor is in a form field    |
|                                   | that has been designated VERIFY. This procedure |
|                                   | helps to ensure that no typographical errors    |
|                                   | occur during data entry.\                       |
|                                   | *Solution:* You must enter the value twice,     |
|                                   | identically, before the cursor can move to      |
|                                   | another field. Alternatively, you can cancel    |
|                                   | the form entry with the Interrupt key.          |
+-----------------------------------+-------------------------------------------------+
| [-1307]{#-1307}                   | **Cannot insert another row - the input array   |
|                                   | is full.**\                                     |
|                                   | *Description:* You are entering data into an    |
|                                   | array of records that is represented in the     |
|                                   | program by a static array of program variables. |
|                                   | That array is now full; no place is available   |
|                                   | to store another record.\                       |
|                                   | *Solution:* Press the ACCEPT key to process the |
|                                   | records that you have entered.                  |
+-----------------------------------+-------------------------------------------------+
| [-1309]{#-1309}                   | **There are no more rows in the direction you   |
|                                   | are going.**\                                   |
|                                   | *Description.* You are attempting to scroll an  |
|                                   | array of records farther than it can go, either |
|                                   | scrolling up at the top or scrolling down at    |
|                                   | the bottom of the array. Further attempts will  |
|                                   | have the same result.                           |
+-----------------------------------+-------------------------------------------------+
| [-1312]{#-1312}                   | **FORMS statement error number %d.***\          |
|                                   | Description.* An error occurred in the form at  |
|                                   | runtime. *\                                     |
|                                   | Solution*. Edit your source file: go to the     |
|                                   | specified line, correct the error, and          |
|                                   | recompile the file.                             |
+-----------------------------------+-------------------------------------------------+
| [-1313]{#-1313}                   | **SQL statement error number %d.\**             |
|                                   | *Description:* The current SQL statement        |
|                                   | returned this error code number.                |
+-----------------------------------+-------------------------------------------------+
| [-1314]{#-1314}                   | **Program stopped at \'*file-name*\', line      |
|                                   | number *line-number*.\**                        |
|                                   | *Description:* At runtime an error occurred in  |
|                                   | the specified file at the specified line. No    |
|                                   | .err file is generated.\                        |
|                                   | *Solution:* Edit your source file, go to the    |
|                                   | specified line, correct the error, and          |
|                                   | recompile the file.                             |
+-----------------------------------+-------------------------------------------------+
| [-1318]{#-1318}                   | **A parameter count mismatch has occurred       |
|                                   | between the calling function and the called     |
|                                   | function.\**                                    |
|                                   | *Description:* Either too many or too few       |
|                                   | parameters were given in the call to the        |
|                                   | function.\                                      |
|                                   | *Solution.* The call is probably in a different |
|                                   | source module from the called functions.        |
|                                   | Inspect the definition of the function, and     |
|                                   | check all places where it is called to ensure   |
|                                   | that they use the number of parameters that it  |
|                                   | declares.                                       |
+-----------------------------------+-------------------------------------------------+
| [-1320]{#-1320}                   | **A function has not returned the correct       |
|                                   | number of values expected.\**                   |
|                                   | *Description:* A function that returns several  |
|                                   | variables has not returned the correct number   |
|                                   | of parameters.\                                 |
|                                   | *Solution:* Check your source code and          |
|                                   | recompile.                                      |
+-----------------------------------+-------------------------------------------------+
| [-1321]{#-1321}                   | **A validation error has occurred as a result   |
|                                   | of the VALIDATE command.**\                     |
|                                   | *Description:* The VALIDATE LIKE statement      |
|                                   | tests the current value of variables against    |
|                                   | rules that are stored in the syscolval table.   |
|                                   | It has detected a mismatch.\                    |
|                                   | *Solution:* Ordinarily, the program would use   |
|                                   | the WHENEVER statement to trap this error and   |
|                                   | display or correct the erroneous values.        |
|                                   | Inspect the VALIDATE statement to see which     |
|                                   | variables were being tested and find out why    |
|                                   | they were wrong.                                |
+-----------------------------------+-------------------------------------------------+
| [-1322]{#-1322}                   | **A report output file cannot be opened.**\     |
|                                   | *Description:* The file that the REPORT TO      |
|                                   | statement specifies cannot be opened.\          |
|                                   | *Solution:* Check that your account has         |
|                                   | permission to write such a file, that the disk  |
|                                   | is not full, and that you have not exceeded     |
|                                   | some limit on the number of open files.         |
+-----------------------------------+-------------------------------------------------+
| [-1323]{#-1323}                   | **A report output pipe cannot be opened.**\     |
|                                   | *Description:* The pipe that the REPORT TO PIPE |
|                                   | statement specifies could not be started.\      |
|                                   | *Solution:* Check that all programs that are    |
|                                   | named in it exist and are accessible from your  |
|                                   | execution path. Also look for operating-system  |
|                                   | messages that might give more specific errors.  |
+-----------------------------------+-------------------------------------------------+
| [-1324]{#-1324}                   | **A report output file cannot be written to.\** |
|                                   | *Description:* The file that the REPORT TO      |
|                                   | statement specifies was opened, but an error    |
|                                   | occurred while writing to it.\                  |
|                                   | *Solution:* Possibly the disk is full. Look for |
|                                   | operating- system messages that might give more |
|                                   | information.                                    |
+-----------------------------------+-------------------------------------------------+
| [-1326]{#-1326}                   | **An array variable has been referenced outside |
|                                   | of its specified dimensions.**\                 |
|                                   | *Description:* The subscript expression for an  |
|                                   | array has produced a number that is either less |
|                                   | than one or greater than the number of elements |
|                                   | in the array.\                                  |
|                                   | *Solution:* Review the program logic that leads |
|                                   | up to this statement to determine how the error |
|                                   | was made.                                       |
+-----------------------------------+-------------------------------------------------+
| [-1327]{#-1327}                   | **An insert statement could not be prepared for |
|                                   | inserting rows into a temporary table used for  |
|                                   | a report.**\                                    |
|                                   | *Description:* Within the report function, BDL  |
|                                   | generated an SQL statement to save rows into a  |
|                                   | temporary table. The dynamic preparation of the |
|                                   | statement (see the reference material on the    |
|                                   | PREPARE statement) produced an error.\          |
|                                   | *Solution:* Probably the database tables are    |
|                                   | not defined now, at execution time, as they     |
|                                   | were when the program was compiled. Either the  |
|                                   | database has been changed, or the program has   |
|                                   | selected a different database than the one that |
|                                   | was current during compilation. Possibly the    |
|                                   | database administrator has revoked SELECT       |
|                                   | privilege from you for one or more of the       |
|                                   | tables that the report uses. Look for other     |
|                                   | error messages that might give more details.    |
+-----------------------------------+-------------------------------------------------+
| [-1328]{#-1328}                   | **A temporary table needed for a report could   |
|                                   | not be created in the selected database.\**     |
|                                   | *Description:* Within the report definition,    |
|                                   | BDL generated an SQL statement to save rows     |
|                                   | into a temporary table, but the temporary table |
|                                   | could not be created.\                          |
|                                   | *Solution:* You must have permission to create  |
|                                   | tables in the selected database, and there must |
|                                   | be sufficient disk space left in the database.  |
|                                   | You may already have a table in your current    |
|                                   | database with the same name as the temporary    |
|                                   | table that the report definition is attempting  |
|                                   | to create as a sorting table; the sorting table |
|                                   | is named \"t\_*reportname*\". Another possible  |
|                                   | cause with some database servers is that you    |
|                                   | have exceeded an operating-system limit on open |
|                                   | files.                                          |
+-----------------------------------+-------------------------------------------------+
| [-1329]{#-1329}                   | **A database index could not be created for a   |
|                                   | temporary database table needed for a           |
|                                   | report.\**                                      |
|                                   | *Description:* Within the report definition,    |
|                                   | BDL generated SQL statements to save rows into  |
|                                   | a temporary table. However, an index could not  |
|                                   | be created on the temporary table.\             |
|                                   | *Solution:* Probably an index with the same     |
|                                   | name already exists in the database. (The       |
|                                   | sorting index is named \"i_reportname\"; for    |
|                                   | example, \"i_order_rpt\".) Possibly no disk     |
|                                   | space is available in the file system or        |
|                                   | dbspace. Another possibility with some database |
|                                   | servers is that you have exceeded an            |
|                                   | operating-system limit on open files.           |
+-----------------------------------+-------------------------------------------------+
| [-1330]{#-1330}                   | **A row could not be inserted into a temporary  |
|                                   | report table.\**                                |
|                                   | *Description:* Within the report definition,    |
|                                   | BDL generated SQL statements that would save    |
|                                   | rows into a temporary table. However, an error  |
|                                   | occurred while rows were being inserted.\       |
|                                   | *Solution:* Probably no disk space is left in   |
|                                   | the database. Look for other error messages     |
|                                   | that might give more details.                   |
+-----------------------------------+-------------------------------------------------+
| [-1331]{#-1331}                   | **A row could not be fetched from a temporary   |
|                                   | report table.\**                                |
|                                   | *Description:* Within the report definition,    |
|                                   | BDL generated SQL statements to select rows     |
|                                   | from a temporary table. The table was built     |
|                                   | successfully but now an error occurred while    |
|                                   | rows were being retrieved from it.\             |
|                                   | *Solution:* Almost the only possible cause is a |
|                                   | hardware failure or an error in the database    |
|                                   | server. Check for operating-system messages     |
|                                   | that might give more details.                   |
+-----------------------------------+-------------------------------------------------+
| [-1332]{#-1332}                   | **A character variable has referenced           |
|                                   | subscripts that are out of range.\**            |
|                                   | *Description:* In the current statement, a      |
|                                   | variable that is used in taking a substring of  |
|                                   | a character value contains a number less than   |
|                                   | one or a number greater than the size of the    |
|                                   | variable, or the first substring expression is  |
|                                   | larger than the second.\                        |
|                                   | *Solution:* Review the program logic that leads |
|                                   | up to this statement to find the cause of the   |
|                                   | error.                                          |
+-----------------------------------+-------------------------------------------------+
| [-1335]{#-1335}                   | **A report is accepting output or being         |
|                                   | finished before it has been started.\**         |
|                                   | *Description:* The program executed an OUTPUT   |
|                                   | TO REPORT or FINISH REPORT statement before it  |
|                                   | executed a START REPORT.\                       |
|                                   | *Solution:* Review the program logic that leads |
|                                   | up to this statement to find the cause of the   |
|                                   | error.                                          |
+-----------------------------------+-------------------------------------------------+
| [-1337]{#-1337}                   | **The variable *variable-name* has been         |
|                                   | redefined with a different type or length,      |
|                                   | definition in *module1*.4gl, redefinition in    |
|                                   | *module2*.4gl.\**                               |
|                                   | *Description:* The variable that is shown is    |
|                                   | defined in the GLOBALS section of two or more   |
|                                   | modules, but it is defined differently in some  |
|                                   | modules than in others.\                        |
|                                   | *Solutions.* Possibly modules were compiled at  |
|                                   | different times, with some change to the common |
|                                   | GLOBALS file between. Possibly the variable is  |
|                                   | declared as a module variable in some module    |
|                                   | that does not include the GLOBALS file.         |
+-----------------------------------+-------------------------------------------------+
| [-1338]{#-1338}                   | **The function \'*function-name*\' has not been |
|                                   | defined in any module in the program.\**        |
|                                   | *Description:* The named function is called     |
|                                   | from at least one module of the program, but it |
|                                   | is defined in none.\                            |
|                                   | *Solution.* Verify that the module containing   |
|                                   | the function is a part of the program, and that |
|                                   | the function name is correctly spelled.         |
+-----------------------------------+-------------------------------------------------+
| [-1340]{#-1340}                   | **The error log has not been started.\**        |
|                                   | *Description:* The program called the           |
|                                   | errorlog() function without first calling the   |
|                                   | startlog() function.\                           |
|                                   | *Solution:* Review the program logic to find    |
|                                   | out the cause of this error.                    |
+-----------------------------------+-------------------------------------------------+
| [-1353]{#-1353}                   | **Use \'!\' to edit TEXT and BYTE fields.\**    |
|                                   | *This is a normal message text used outside an  |
|                                   | error context.*                                 |
+-----------------------------------+-------------------------------------------------+
| [-1355]{#-1355}                   | **Cannot build temporary file.\**               |
|                                   | *Description:* A TEXT or BYTE variable has been |
|                                   | located in a temporary file using the LOCATE    |
|                                   | statement. The current statement assigns a      |
|                                   | value into that variable, so BDL attempted to   |
|                                   | create the temporary file, but an error         |
|                                   | occurred.\                                      |
|                                   | *Solution:* Possibly no disk space is           |
|                                   | available, or your account does not have        |
|                                   | permission to create a temporary file.  Look    |
|                                   | for operating-system error messages that might  |
|                                   | give more information.                          |
+-----------------------------------+-------------------------------------------------+
| [-1359]{#-1359}                   | **Read error on blob file \'*file-name*\'.\**   |
|                                   | *Description:* The operating system signaled an |
|                                   | error during output to a temporary file in      |
|                                   | which a TEXT or BYTE variable was being saved.\ |
|                                   | *Solution:* Possibly the disk is full, or a     |
|                                   | hardware failure occurred. For more             |
|                                   | information, look for operating-system          |
|                                   | messages.                                       |
+-----------------------------------+-------------------------------------------------+
| [-1360]{#-1360}                   | **No PROGRAM= clause for this field.\**         |
|                                   | *Description.*  No external program has been    |
|                                   | designated for this field using the PROGRAM     |
|                                   | attribute in the form-specification file (For   |
|                                   | Text User Interface mode on ASCII terminals     |
|                                   | only)                                           |
+-----------------------------------+-------------------------------------------------+
| [-1373]{#-1373}                   | **The field \'*field-name*\' is not in the list |
|                                   | of fields in the CONSTRUCT/INPUT statement.\**  |
|                                   | *Description:* The built-in function            |
|                                   | get_fldbuf() or field_touched() has been called |
|                                   | with the field name shown. However, input from  |
|                                   | that field was not requested in this CONSTRUCT  |
|                                   | or INPUT statement. As a result, the function   |
|                                   | cannot return any useful value.\                |
|                                   | *Solution:* Review all uses of these functions, |
|                                   | and compare them to the list of fields at the   |
|                                   | beginning of the statement.                     |
+-----------------------------------+-------------------------------------------------+
| [-1374]{#-1374}                   | **SQL character truncation or transaction       |
|                                   | warning.\**                                     |
|                                   | *Description:* The program set WHENEVER WARNING |
|                                   | STOP, and a warning condition arose. If the     |
|                                   | statement involved is a DATABASE statement, the |
|                                   | condition is that the database that was just    |
|                                   | opened uses a transaction log. On any other     |
|                                   | statement, the condition is that a character    |
|                                   | value from the database had to be truncated to  |
|                                   | fit in its destination.                         |
+-----------------------------------+-------------------------------------------------+
| [-1375]{#-1375}                   | **SQL NULL value in aggregate or mode ANSI      |
|                                   | database warning.\**                            |
|                                   | *Description:* The program set WHENEVER WARNING |
|                                   | STOP, and a warning condition arose. If the     |
|                                   | statement that is involved is a DATABASE        |
|                                   | statement, the condition is that the database   |
|                                   | that was just opened is ANSI compliant. On any  |
|                                   | other statement, the condition is that a null   |
|                                   | value has been used in the computation of an    |
|                                   | aggregate value.                                |
+-----------------------------------+-------------------------------------------------+
| [-1376]{#-1376}                   | **SQL, database server, or program variable     |
|                                   | mismatch warning.\**                            |
|                                   | *Description:* The program set WHENEVER WARNING |
|                                   | STOP, and a warning condition arose. If the     |
|                                   | statement that is involved is a DATABASE or     |
|                                   | CREATE DATABASE statement, the condition is     |
|                                   | that the database server opened the database.   |
|                                   | On any other statement, the condition is that a |
|                                   | SELECT statement returned more values than      |
|                                   | there were program variables to contain them.   |
+-----------------------------------+-------------------------------------------------+
| [-1377]{#-1377}                   | **SQL float-to-decimal conversion warning.\**   |
|                                   | *Description:* The program set WHENEVER WARNING |
|                                   | STOP, and a warning condition arose. The        |
|                                   | condition is that in the database that was just |
|                                   | opened, the database server will use the        |
|                                   | DECIMAL data type for FLOAT values.             |
+-----------------------------------+-------------------------------------------------+
| [-1378]{#-1378}                   | **SQL non-ANSI extension warning.\**            |
|                                   | *Description.* A database operation was         |
|                                   | performed that is not part of ANSI SQL,         |
|                                   | although the current database is ANSI           |
|                                   | compliant. This message is informational only.  |
+-----------------------------------+-------------------------------------------------+
| [-1396]{#-1396}                   | **A report PRINT FILE source file cannot be     |
|                                   | opened for reading.\**                          |
|                                   | *Description:* The file that is named in a      |
|                                   | PRINT FILE statement cannot be opened.\         |
|                                   | *Solution:* Review the file name. If it is not  |
|                                   | in the current directory, you must specify the  |
|                                   | full path. If the file exists, make sure your   |
|                                   | account has permissions to read it.             |
+-----------------------------------+-------------------------------------------------+
| [-2017]{#-2017}                   | **The character data value does not convert     |
|                                   | correctly to the field type.\**                 |
|                                   | *Description:* You have entered a character     |
|                                   | value (a quoted string) into a field that has a |
|                                   | different data type (for example INTEGER).      |
|                                   | However, the characters that you entered cannot |
|                                   | be converted to the type of the field.\         |
|                                   | *Solution:* Re-enter the data.                  |
+-----------------------------------+-------------------------------------------------+
| [-2024]{#-2024}                   | **There is already a record \'*record-name*\'   |
|                                   | specified.\**                                   |
|                                   | *Description:* A screen record is automatically |
|                                   | defined for each table that is used in the      |
|                                   | ATTRIBUTES section to define a field. If you    |
|                                   | define a record with the name of a table, it is |
|                                   | seen as a duplicate.\                           |
|                                   | *Solution:* Check that the record-name of every |
|                                   | screen record and screen array is unique in the |
|                                   | form specification.                             |
+-----------------------------------+-------------------------------------------------+
| [-2028]{#-2028}                   | **The symbol \'*name*\' does not represent a    |
|                                   | table prefix used in this form.\**              |
|                                   | *Description:* In a SCREEN RECORD statement,    |
|                                   | each component must be introduced by the name   |
|                                   | of the table as defined in the TABLES section   |
|                                   | or by the word FORMONLY.\                       |
|                                   | *Solution:* Review the spelling of the          |
|                                   | indicated name against the TABLES section, and  |
|                                   | check the punctuation of the rest of the        |
|                                   | statement.                                      |
+-----------------------------------+-------------------------------------------------+
| [-2029]{#-2029}                   | **Screen record array \'*record-name*\' has     |
|                                   | different component sizes.\**                   |
|                                   | *Description:* The screen record array name has |
|                                   | component sizes which either differ from the    |
|                                   | specified dimension of the array or differ      |
|                                   | among themselves. This error message appears    |
|                                   | when one or more of the columns appear a        |
|                                   | different number of times.\                     |
|                                   | *Solution.* The dimension of the screen array   |
|                                   | is written in square brackets that follow its   |
|                                   | name. Verify that the dimensions of the screen  |
|                                   | array match the screen fields.                  |
+-----------------------------------+-------------------------------------------------+
| [-2039]{#-2039}                   | **The attributes AUTONEXT, DEFAULT, INCLUDE,    |
|                                   | VERIFY, RIGHT and ZEROFILL are not supported    |
|                                   | for BLOB fields.\**                             |
|                                   | *Description:* Columns of the data type         |
|                                   | specified cannot be used in the ways that these |
|                                   | attributes imply.\                              |
|                                   | *Solution:* Check that the table and column     |
|                                   | names are as you intended, and verify the       |
|                                   | current definition of the table in the database |
|                                   | that the DATABASE statement names.              |
+-----------------------------------+-------------------------------------------------+
| [-2041]{#-2041}                   | **The form \'*form-name*\' cannot be opened.\** |
|                                   | *Description:* The form filename cannot be      |
|                                   | opened. This is probably because it does not    |
|                                   | exist, or the user does not have read           |
|                                   | permission.\                                    |
|                                   | *Solution:* Check the spelling of filename.     |
|                                   | Check that the form file exists in your current |
|                                   | directory. If it is in another directory, check |
|                                   | that the correct pathname has been provided. On |
|                                   | a UNIX system, if these things are correct,     |
|                                   | verify that your account has read permission on |
|                                   | the file.                                       |
+-----------------------------------+-------------------------------------------------+
| [-2045]{#-2045}                   | **The conditional attributes of a field cannot  |
|                                   | depend on the values of other fields.\**        |
|                                   | *Description:* The Boolean expression in a      |
|                                   | WHERE clause of a COLOR attribute can use only  |
|                                   | the name of that field and constants.\          |
|                                   | *Solution:* Revise this attribute, and          |
|                                   | recompile the form.                             |
+-----------------------------------+-------------------------------------------------+
| [-2100]{#-2100}                   | **Field \'*field-name*\' has validation string  |
|                                   | error, String = *string*.\**                    |
|                                   | *Description:* One of the formatting or         |
|                                   | validation strings that is stored in the        |
|                                   | syscolval or syscolatt tables is improperly     |
|                                   | coded. The string is shown as is the field to   |
|                                   | which it applies.\                              |
|                                   | *Solution:* Update the string in the tables.    |
+-----------------------------------+-------------------------------------------------+
| [-2810]{#-2810}                   | **The name \'*database-name*\' is not an        |
|                                   | existing database name.\**                      |
|                                   | *Description:* This name, which was found in    |
|                                   | the DATABASE statement at the start of the form |
|                                   | specification, is not a database that can be    |
|                                   | found.\                                         |
|                                   | *Solution:* Check the spelling of the database  |
|                                   | name and the database entries in the fglprofile |
|                                   | file.                                           |
+-----------------------------------+-------------------------------------------------+
| [-2820]{#-2820}                   | **The label name between brackets is            |
|                                   | incorrectly given or the label is missing.\**   |
|                                   | *Description:* In the layout section of a form  |
|                                   | specification, the brackets should contain a    |
|                                   | simple name. Instead, they contain spaces or an |
|                                   | invalid name.\                                  |
|                                   | *Solution:* Check the layout section of the     |
|                                   | form for invalid form item labels.              |
+-----------------------------------+-------------------------------------------------+
| [-2830]{#-2830}                   | **A left square bracket has been found on this  |
|                                   | line, with no right square bracket to match     |
|                                   | it.\**                                          |
|                                   | *Description:* Every left square bracket field  |
|                                   | delimiter must have a right square bracket      |
|                                   | delimiter on the same line.\                    |
|                                   | *Solution:* Review the form definition file to  |
|                                   | make sure all fields are properly marked.       |
+-----------------------------------+-------------------------------------------------+
| [-2840]{#-2840}                   | **The field label \'*label-name*\' was not      |
|                                   | defined in the form.\**                         |
|                                   | *Description:* The indicated name appears at    |
|                                   | the left of this ATTRIBUTES statement, but it   |
|                                   | does not appear within brackets in the SCREEN   |
|                                   | section.\                                       |
|                                   | *Solution:* Review the field tags that have     |
|                                   | been defined to see why this one was omitted.   |
+-----------------------------------+-------------------------------------------------+
| [-2843]{#-2843}                   | **The column \'*column-name*\' does not appear  |
|                                   | in the form specification.\**                   |
|                                   | *Description:* A name in this ATTRIBUTES        |
|                                   | statement should have been defined previously   |
|                                   | in the form specification.\                     |
|                                   | *Solution:* Check that all names in the         |
|                                   | statement are spelled correctly and defined     |
|                                   | properly.                                       |
+-----------------------------------+-------------------------------------------------+
| [-2846]{#-2846}                   | **The field \'*field-name*\' is not a member of |
|                                   | the table \'*table-name*\'.\**                  |
|                                   | *Description:* Something in this statement      |
|                                   | suggests that the name shown is part of this    |
|                                   | table, but that is not true in the current      |
|                                   | database.\                                      |
|                                   | *Solution:* Review the spelling of the two      |
|                                   | names. If they are as you intended, check that  |
|                                   | the correct database is in use and that the     |
|                                   | table has not been altered.                     |
+-----------------------------------+-------------------------------------------------+
| [-2859]{#-2859}                   | **The column \'*column-name*\' is a member of   |
|                                   | more then one table \-- you must specify the    |
|                                   | table name.\**                                  |
|                                   | *Description:* Two or more tables that are      |
|                                   | named in the TABLES section have columns with   |
|                                   | the name shown.\                                |
|                                   | *Solution:* You must make clear which table you |
|                                   | mean. To do this, write the table name as a     |
|                                   | prefix of the column name, as table.column,     |
|                                   | wherever this name is used in the form          |
|                                   | specification.                                  |
+-----------------------------------+-------------------------------------------------+
| [-2860]{#-2860}                   | **There is a column/value type mismatch for     |
|                                   | \'*column-name*\'.\**                           |
|                                   | *Description:* This statement assigns a value   |
|                                   | to the field with the DEFAULT clause or uses    |
|                                   | its value with the INCLUDE clause, but it does  |
|                                   | so with data that does not agree with the data  |
|                                   | type of the field.\                             |
|                                   | *Solution:* Review the data type of the field   |
|                                   | (which comes from the column with which it is   |
|                                   | associated), and make sure that only compatible |
|                                   | values are assigned.                            |
+-----------------------------------+-------------------------------------------------+
| [-2862]{#-2862}                   | **The table \'*table-name*\' cannot be found in |
|                                   | the database.\**                                |
|                                   | *Description:* The indicated table does not     |
|                                   | exist in the database that is named in the      |
|                                   | form.\                                          |
|                                   | *Solution:* Check the spelling of the table     |
|                                   | name and database name. If they are as you      |
|                                   | intended, either you are not using the version  |
|                                   | of the database that you expected, or the       |
|                                   | database has been changed.                      |
+-----------------------------------+-------------------------------------------------+
| [-2863]{#-2863}                   | **The column \'*column-name*\' does not exist   |
|                                   | among the specified tables.\**                  |
|                                   | *Description:* The tables that are specified in |
|                                   | the TABLES section of the form exist, but       |
|                                   | column-name, which is named in the ATTRIBUTES   |
|                                   | section, does not.\                             |
|                                   | *Solution:* Check its spelling against the      |
|                                   | actual table. Possibly the table was altered,   |
|                                   | or the column was renamed.                      |
+-----------------------------------+-------------------------------------------------+
| [-2864]{#-2864}                   | **The table \'*table-name*\' is not among the   |
|                                   | specified tables.\**                            |
|                                   | *Description:* The indicated table is used in   |
|                                   | this statement but is not defined in the TABLES |
|                                   | section of the form specification.\             |
|                                   | *Solution:* Check its spelling; if it is as you |
|                                   | intended, add the table in the TABLES section.  |
+-----------------------------------+-------------------------------------------------+
| [-2865]{#-2865}                   | **The column \'*column-name*\' does not exist   |
|                                   | in the table \'*table-name*\'.\**               |
|                                   | *Description:* Something in this statement      |
|                                   | implies that the column shown is part of the    |
|                                   | indicated table (most likely the statement      |
|                                   | refers to table-name.column). However, it is    |
|                                   | not defined in that table.\                     |
|                                   | *Solution:* Check the spelling of both names.   |
|                                   | If they are as you intended, then check the     |
|                                   | contents of the database; possibly the table    |
|                                   | has been altered or the column renamed.         |
+-----------------------------------+-------------------------------------------------+
| [-2892]{#-2892}                   | **The column \'*column-name*\' appears more     |
|                                   | then once. If you wish a column to be           |
|                                   | duplicated in a form, use the same display      |
|                                   | field label.\**                                 |
|                                   | *Description:*  The same column name is listed  |
|                                   | in the ATTRIBUTES section more than once.\      |
|                                   | *Solution:* The expected way to display the     |
|                                   | same column in two or more places is to put two |
|                                   | or more fields in the screen layout, each with  |
|                                   | the same tag-name. Then put a single statement  |
|                                   | in the ATTRIBUTES section to associate that     |
|                                   | tag-name with the column name. The current      |
|                                   | column value will be duplicated in all fields.  |
|                                   | If you intended to display different columns    |
|                                   | that happen to have the same column-names,      |
|                                   | prefix each column with its table-name.         |
+-----------------------------------+-------------------------------------------------+
| [-2893]{#-2893}                   | **The display field label \'*label-name*\'      |
|                                   | appears more than once in this form, but the    |
|                                   | lengths are different.\**                       |
|                                   | *Description:* You can put multiple copies of a |
|                                   | field in the screen layout (all will display    |
|                                   | the same column), but all copies must be the    |
|                                   | same length.\                                   |
|                                   | *Solution:* Review the form definition to make  |
|                                   | sure that, if you intended to have multiple     |
|                                   | copies of one field, all copies are the same.   |
+-----------------------------------+-------------------------------------------------+
| [-2975]{#-2975}                   | **The display field label \'*label-name*\' has  |
|                                   | not been used.\**                               |
|                                   | *Description:* A field tag has been declared in |
|                                   | the screen section of the form- specification   |
|                                   | file but is not defined in the attributes       |
|                                   | section.\                                       |
|                                   | *Solution.* Check your form-specification       |
|                                   | file.                                           |
+-----------------------------------+-------------------------------------------------+
| [-2992]{#-2992}                   | **The display label \'*label-name*\' has        |
|                                   | already been used.\**                           |
|                                   | *Description:* The forms compiler indicates     |
|                                   | that name has been defined twice. These names   |
|                                   | must be defined uniquely in the form            |
|                                   | specification.\                                 |
|                                   | *Solution:* Review all uses of the name to see  |
|                                   | if one of them is incorrect.                    |
+-----------------------------------+-------------------------------------------------+
| [-2997]{#-2997}                   | **See error number %d.\**                       |
|                                   | *Description:* The database server returned an  |
|                                   | error that is shown.\                           |
|                                   | *Solution:* Look up the shown error in the      |
|                                   | database server documentation.                  |
+-----------------------------------+-------------------------------------------------+
| [-4303]{#-4303}                   | **A blob variable or cursor name expected.**\   |
|                                   | *Description:* The argument to the FREE         |
|                                   | statement must be the name of a cursor or       |
|                                   | prepared statement or, in 4GL, the name of a    |
|                                   | variable with the BYTE or TEXT data type.\      |
|                                   | *Solution:*  Check the name used after the FREE |
|                                   | keyword.                                        |
+-----------------------------------+-------------------------------------------------+
| [-4307]{#-4307}                   | **The number of variables and/or constants in   |
|                                   | the display list does not match the number of   |
|                                   | form fields in the display destination.**\      |
|                                   | *Description:* There must be exactly as many    |
|                                   | items in the list of values to display as there |
|                                   | are fields listed following the TO keyword in   |
|                                   | this statement.\                                |
|                                   | *Solution:*  Review the statement.              |
+-----------------------------------+-------------------------------------------------+
| [-4308]{#-4308}                   | **The number of input variables does not match  |
|                                   | the number of form fields in the screen input   |
|                                   | list.**\                                        |
|                                   | *Description:* Your INPUT statement must        |
|                                   | specify the same number of variables as it does |
|                                   | fields.\                                        |
|                                   | *Solution:* When checking this, keep in mind    |
|                                   | that when you refer to a record using an        |
|                                   | asterisk or THRU, it is the same as listing     |
|                                   | each record component individually.             |
+-----------------------------------+-------------------------------------------------+
| [-4309]{#-4309}                   | **Printing cannot be done within a loop or CASE |
|                                   | statement contained in report headers or        |
|                                   | trailers.**\                                    |
|                                   | *Description:* BDL needs to know how many lines |
|                                   | of space will be devoted to page headers and    |
|                                   | trailers; otherwise, it does not know how many  |
|                                   | detail rows to allow on a page. Since it cannot |
|                                   | predict how many times a loop will be executed, |
|                                   | or which branch of a CASE will be execute, it   |
|                                   | forbids the use of PRINT in these contexts      |
|                                   | within FIRST PAGE HEADER, PAGE HEADER, and PAGE |
|                                   | TRAILER sections.\                              |
|                                   | *Solution:*  Re-arrange the code to place the   |
|                                   | PRINT statement where it will always be         |
|                                   | executed.                                       |
+-----------------------------------+-------------------------------------------------+
| [-4319]{#-4319}                   | **The symbol \'*name*\' has been defined more   |
|                                   | than once.**\                                   |
|                                   | *Description:* The variable that is shown has   |
|                                   | appeared in at least one other DEFINE statement |
|                                   | before this one.\                               |
|                                   | *Solution:* Review your code. If this DEFINE is |
|                                   | within a function or the MAIN section, the      |
|                                   | prior one is also. If this DEFINE is outside    |
|                                   | any function, the prior one is also outside any |
|                                   | function; however, it might be within the file  |
|                                   | included by the GLOBALS statement.              |
+-----------------------------------+-------------------------------------------------+
| [-4320]{#-4320}                   | **The symbol \'*name*\' is not the name of a    |
|                                   | table in the specified database.\**             |
|                                   | *Description:* The named table does not appear  |
|                                   | in the database.\                               |
|                                   | *Solution:* Review the statement. The table     |
|                                   | name may be spelled wrong in the program, or    |
|                                   | the table might have been dropped or renamed    |
|                                   | since the last time the program was compiled.   |
+-----------------------------------+-------------------------------------------------+
| [-4322]{#-4322}                   | **The symbol \'*name*\' is not the name of a    |
|                                   | column in the specified database.\**            |
|                                   | *Description:* The preceding statement suggests |
|                                   | that the named column is part of a certain      |
|                                   | table in the specified database. The table      |
|                                   | exists, but the column does not appear in it.\  |
|                                   | *Solution:* Check the spelling of the column    |
|                                   | name. If it is spelled as you intended, then    |
|                                   | either the table has been altered, or the       |
|                                   | column renamed, or you are not accessing the    |
|                                   | database you expected.                          |
+-----------------------------------+-------------------------------------------------+
| [-4323]{#-4323}                   | **The variable \'*variable-name*\' is too       |
|                                   | complex a type to be used in an assignment      |
|                                   | statement.\**                                   |
|                                   | *Description:* The named variable is a complex  |
|                                   | variable like a record or an array, which       |
|                                   | cannot be used in a LET statement.\             |
|                                   | *Solution:* You must assign groups of           |
|                                   | components to groups of components using        |
|                                   | asterisk notation.                              |
+-----------------------------------+-------------------------------------------------+
| [-4324]{#-4324}                   | **The variable \'*variable-name*\' is not a     |
|                                   | character type, and cannot be used to contain   |
|                                   | the result of concatenation.\**                 |
|                                   | *Description:* This statement attempts to       |
|                                   | concatenate two or more character strings       |
|                                   | (using the comma as the concatenation operator) |
|                                   | and assign the result to the named variable.    |
|                                   | Unfortunately, it is not a character variable,  |
|                                   | and automatic conversion from characters cannot |
|                                   | be performed in this case.\                     |
|                                   | *Solution:* Assign the concatenated string to a |
|                                   | character variable; then, if you want to treat  |
|                                   | the result as numeric, assign the string as a   |
|                                   | whole to a numeric variable.                    |
+-----------------------------------+-------------------------------------------------+
| [-4325]{#-4325}                   | **The source and destination records in this    |
|                                   | record assignment statement are not compatible  |
|                                   | in types and/or length.\**                      |
|                                   | *Description:* This statement uses asterisk     |
|                                   | notation to assign all components of one record |
|                                   | to the corresponding components of another.     |
|                                   | However, the components do not correspond. Note |
|                                   | that BDL matches record components strictly by  |
|                                   | position, the first to the first, second to     |
|                                   | second, and so on; it does not match them by    |
|                                   | name.\                                          |
|                                   | *Solution:* If the source and destination       |
|                                   | records do not have the same number and type of |
|                                   | components, you will have to write a simple     |
|                                   | assignment statement for each component.        |
+-----------------------------------+-------------------------------------------------+
| [-4333]{#-4333}                   | **The function \'*function-name*\' has already  |
|                                   | been called with a different number of          |
|                                   | parameters.\**                                  |
|                                   | *Description:* Earlier in the program, there is |
|                                   | a call to this same function or event with a    |
|                                   | different number of parameters in the parameter |
|                                   | list. At least one of these calls must be in    |
|                                   | error.\                                         |
|                                   | *Solution:* Examine the FUNCTION statement for  |
|                                   | the named function to find out the correct      |
|                                   | number of parameters. Then examine all calls to |
|                                   | it, and make sure that they are written         |
|                                   | correctly.                                      |
+-----------------------------------+-------------------------------------------------+
| [-4334]{#-4334}                   | **The variable \'*variable-name*\' in its       |
|                                   | current form is too complex to be used in this  |
|                                   | statement.\**                                   |
|                                   | *Description:* The variable has too many        |
|                                   | component parts. Only simple variables (those   |
|                                   | that have a single component) can be used in    |
|                                   | this statement.\                                |
|                                   | *Solution:* If variable-name is an array, you   |
|                                   | must provide a subscript to select just one     |
|                                   | element. If it is a record, you must choose     |
|                                   | just one of its components. (However, if this   |
|                                   | statement permits a list of variables, as in    |
|                                   | the INITIALIZE statement, you can use asterisk  |
|                                   | or THRU notation to convert a record name into  |
|                                   | a list of components)                           |
+-----------------------------------+-------------------------------------------------+
| [-4335]{#-4335}                   | **The symbol \'*field-name*\' is not an element |
|                                   | of the record \'*record-name*\'.\**             |
|                                   | *Description:* The field name used in a         |
|                                   | *record.field* expression is not identified as  |
|                                   | a member of the record variable.\               |
|                                   | *Solution:* Find the definition of the record   |
|                                   | (it may be in the GLOBALS file), verify the     |
|                                   | names of its fields, and correct the spelling   |
|                                   | of *field-name*.                                |
+-----------------------------------+-------------------------------------------------+
| [-4336]{#-4336}                   | **The parameter \'*param-name*\' has not been   |
|                                   | defined within the function or report.\**       |
|                                   | *Description:* The name variable-name appears   |
|                                   | in the parameter list of the FUNCTION statement |
|                                   | for this function. However, it does not appear  |
|                                   | in a DEFINE statement within the function. All  |
|                                   | parameters must be defined in their function    |
|                                   | before use.\                                    |
|                                   | *Solution:* Review your code. Possibly you      |
|                                   | wrote a DEFINE statement but did not spell      |
|                                   | variable-name the same way in both places.      |
+-----------------------------------+-------------------------------------------------+
| [-4338]{#-4338}                   | **The symbol \'*name*\' has already been        |
|                                   | defined once as a parameter.\**                 |
|                                   | *Description:* The name that is shown appears   |
|                                   | in the parameter list of the FUNCTION statement |
|                                   | and in at least two DEFINE statements within    |
|                                   | the function body.\                             |
|                                   | *Solution:* Review your code. Only one          |
|                                   | appearance in a DEFINE statement is permitted.  |
+-----------------------------------+-------------------------------------------------+
| [-4340]{#-4340}                   | **The variable \'*variable-name*\' is too       |
|                                   | complex a type to be used in an expression.\**  |
|                                   | *Description:* In an expression, only simple    |
|                                   | variables (those that have a single component)  |
|                                   | can be used.\                                   |
|                                   | *Solution:* If the variable indicated is an     |
|                                   | array, you must provide a subscript to select   |
|                                   | just one element. If it is a record or object,  |
|                                   | you must choose just one of its components.     |
+-----------------------------------+-------------------------------------------------+
| [-4341]{#-4341}                   | **Aggregate functions are only allowed in       |
|                                   | reports and SELECT statements.**\               |
|                                   | *Description:* Aggregate functions such as SUM, |
|                                   | AVG, and MAX can only appear in SQL statements  |
|                                   | and within certain statements that you use in   |
|                                   | the context of a report body. They are not      |
|                                   | supported in ordinary expressions in program    |
|                                   | statements.\                                    |
|                                   | *Solution*: Review the code and check that the  |
|                                   | aggregate functions are in an SQL statement or  |
|                                   | in the correct blocks of the REPORT routine.    |
+-----------------------------------+-------------------------------------------------+
| [-4343]{#-4343}                   | **Subscripting cannot be applied to the         |
|                                   | variable \'*variable-name*\'.\**                |
|                                   | *Description:* You tried to use a \[x,y\]       |
|                                   | subscript expression with a variable that is    |
|                                   | neither a character data type or an array       |
|                                   | type.\                                          |
|                                   | *Solution:* Check the variable data type and    |
|                                   | make sure it can be used with a subscript       |
|                                   | expression.                                     |
+-----------------------------------+-------------------------------------------------+
| [-4347]{#-4347}                   | **The variable \'*variable-name*\' is not a     |
|                                   | record. It cannot reference record elements.\** |
|                                   | *Description:* In this statement variable-name  |
|                                   | appears followed by a dot, followed by another  |
|                                   | name. This is the way you would refer to a      |
|                                   | component of a record variable; however,        |
|                                   | variable-name is not defined as a record.\      |
|                                   | *Solution:* Either you have written the name of |
|                                   | the wrong variable, or else variable-name is    |
|                                   | not defined the way you intended.               |
+-----------------------------------+-------------------------------------------------+
| [-4361]{#-4361}                   | **Group aggregates can occur only in AFTER      |
|                                   | GROUP clauses.\**                               |
|                                   | *Description.* The aggregate functions that     |
|                                   | apply to a group of rows (GROUP                 |
|                                   | COUNT/PERCENT/SUM/AVG/MIN/MAX) can only be used |
|                                   | at the point in the report when a complete      |
|                                   | group has been processed, namely, in the AFTER  |
|                                   | GROUP control block.\                           |
|                                   | *Solution:* Make sure that the AFTER GROUP      |
|                                   | block exists and was recognized. If you need    |
|                                   | the value of a group aggregate at another time  |
|                                   | (for instance, in a PAGE TRAILER control        |
|                                   | block), you can save it in a module variable    |
|                                   | with a LET statement in the AFTER GROUP block.  |
+-----------------------------------+-------------------------------------------------+
| [-4363]{#-4363}                   | **The report cannot skip lines while in a loop  |
|                                   | within a header or trailer.\**                  |
|                                   | *Description.* BDL needs to know how many lines |
|                                   | of space will be devoted to the page header and |
|                                   | trailer (otherwise it does not know how many    |
|                                   | detail rows to allow on the page). It cannot    |
|                                   | predict how many times a loop will be executed, |
|                                   | so it has to forbid the use of SKIP statements  |
|                                   | in loops in the PAGE HEADER, PAGE TRAILER, and  |
|                                   | FIRST PAGE HEADER sections.\                    |
|                                   | *Solution:* Review the report header or trailer |
|                                   | to avoid SKIP in loops.                         |
+-----------------------------------+-------------------------------------------------+
| [-4369]{#-4369}                   | **The symbol \'*name*\' does not represent a    |
|                                   | defined variable.\**                            |
|                                   | *Description:* The name shown appears where a   |
|                                   | variable would be expected, but it does not     |
|                                   | match any variable name in a DEFINE statement   |
|                                   | that applies to this context.\                  |
|                                   | *Solution:* Check the spelling of the name. If  |
|                                   | it is the name you intended, look back and find |
|                                   | out why it has not yet been defined. Possibly   |
|                                   | the GLOBALS statement has been omitted from     |
|                                   | this source module, or it names an incorrect    |
|                                   | file. Possibly this code has been copied from   |
|                                   | another module or another function, but the     |
|                                   | DEFINE statement was not copied also.           |
+-----------------------------------+-------------------------------------------------+
| [-4371]{#-4371}                   | **Cursors must be uniquely declared within one  |
|                                   | program module.\**                              |
|                                   | *Description:* In the statement DECLARE         |
|                                   | cursor-name CURSOR, the identifier cursor-name  |
|                                   | can be used in only one DECLARE statement in    |
|                                   | the source file. This is true even when the     |
|                                   | DECLARE statement appears inside a function.    |
|                                   | Although a program variable made with the       |
|                                   | DEFINE statement is local to the function, a    |
|                                   | cursor within a function is still global to the |
|                                   | whole module\                                   |
|                                   | *Solution:* Search for duplicated cursor names  |
|                                   | and change the name to have unique              |
|                                   | identifiers.                                    |
+-----------------------------------+-------------------------------------------------+
| [-4372]{#-4372}                   | **The cursor \'*cursor-name*\' has not yet been |
|                                   | declared in this program.\**                    |
|                                   | *Description:* The name shown appears where the |
|                                   | name of a declared cursor or a prepared         |
|                                   | statement is expected; however, no cursor (or   |
|                                   | statement) of that name has been declared (or   |
|                                   | prepared) up to this point in the program.\     |
|                                   | *Solution:* Check the spelling of the name. If  |
|                                   | it is the name you intended, look back in the   |
|                                   | program to see why it has not been declared.    |
|                                   | Possibly the DECLARE statement appears in a     |
|                                   | GLOBALS file that was not included.             |
+-----------------------------------+-------------------------------------------------+
| [-4374]{#-4374}                   | **This type of statement can only be used       |
|                                   | within a MENU statement.\**                     |
|                                   | *Description:* This statement only makes sense  |
|                                   | within the context of a MENU statement.\        |
|                                   | *Solution:* Review the program in this vicinity |
|                                   | to see if an END MENU statement has been        |
|                                   | misplaced. If you intended to set up the        |
|                                   | appearance of a menu before displaying it, use  |
|                                   | a BEFORE MENU block within the scope of the     |
|                                   | MENU.                                           |
+-----------------------------------+-------------------------------------------------+
| [-4379]{#-4379}                   | **The input file \'*file-name*\' cannot be      |
|                                   | opened.\**                                      |
|                                   | *Description:* Either the file does not exist,  |
|                                   | or, on UNIX, your account does not have         |
|                                   | permission to read it.\                         |
|                                   | *Solution:* Possibly the filename is            |
|                                   | misspelled, or the directory path leading to    |
|                                   | the file was specified incorrectly.             |
+-----------------------------------+-------------------------------------------------+
| [-4380]{#-4380}                   | **The listing file \'*file-name*\' cannot be    |
|                                   | created.\**                                     |
|                                   | *Description:* The file cannot be created.\     |
|                                   | *Solution:* Check that the directory path       |
|                                   | leading to the file is specified correctly and, |
|                                   | on UNIX systems, that your account has          |
|                                   | permission to create a file in that directory.  |
|                                   | Look for other, more explicit, error messages   |
|                                   | from the operating system. Possibly the disk is |
|                                   | full, or you have reached a limit on the number |
|                                   | of open files.                                  |
+-----------------------------------+-------------------------------------------------+
| [-4382]{#-4382}                   | **Record variables that contain array type      |
|                                   | elements may not be referenced by the \".\*\"   |
|                                   | or THROUGH shorthand, or used as a function     |
|                                   | parameter.\**                                   |
|                                   | *Description:* The .\* and THROUGH/THRU         |
|                                   | notation is used to expand a record with an     |
|                                   | array member.\                                  |
|                                   | *Solution:* It is allowed to define a record    |
|                                   | with an array member, but this element must     |
|                                   | always be used with its full designation of     |
|                                   | record.array\[n\]. The .\* or  THROUGH/THRU     |
|                                   | notation only expands simple members of the     |
|                                   | record.                                         |
+-----------------------------------+-------------------------------------------------+
| [-4383]{#-4383}                   | **The elements \'*name-1*\' and \'*name-2*\' do |
|                                   | not belong to the same record.\**               |
|                                   | *Description:* The two names shown are used     |
|                                   | where two components of one record are          |
|                                   | required; however, they are not components of   |
|                                   | the same record.\                               |
|                                   | *Solution:* Check the spelling of both names.   |
|                                   | If they are spelled as you intended, go back to |
|                                   | the definition of the record and see why it     |
|                                   | does not include both names as component        |
|                                   | fields.                                         |
+-----------------------------------+-------------------------------------------------+
| [-4402]{#-4402}                   | **In this type of statement, subscripting may   |
|                                   | be applied only to array.\**                    |
|                                   | *Description:* The statement contains a name    |
|                                   | followed by square brackets, but the name is    |
|                                   | not that of an array variable.\                 |
|                                   | *Solution.* Check the punctuation of the        |
|                                   | statement and the spelling of all names. Names  |
|                                   | that are subscripted must be arrays. If you     |
|                                   | intended to use a character substring in this   |
|                                   | statement, you will have to revise the program. |
+-----------------------------------+-------------------------------------------------+
| [-4403]{#-4403}                   | **The number of dimensions for the variable     |
|                                   | \'*variable-name*\' does not match the number   |
|                                   | of subscripts.\**                               |
|                                   | *Description:* In this statement, the array     |
|                                   | whose name is shown is subscripted by a         |
|                                   | different number of dimensions than it was      |
|                                   | defined to have.\                               |
|                                   | *Solution:* Check the punctuation of the        |
|                                   | subscript. If it is as you intended, then       |
|                                   | review the DEFINE statement where variable-name |
|                                   | is defined.                                     |
+-----------------------------------+-------------------------------------------------+
| [-4414]{#-4414}                   | **The label *label-name* has been used but has  |
|                                   | never been defined within the above main        |
|                                   | program or function.\**                         |
|                                   | *Description:* A GOTO or WHENEVER statement     |
|                                   | refers to the label shown, but there is no      |
|                                   | corresponding LABEL statement in the current    |
|                                   | function or main program.\                      |
|                                   | *Solution:* Check the spelling of the label. If |
|                                   | it is as you intended it, find and inspect the  |
|                                   | LABEL statement that should define it. You      |
|                                   | cannot transfer out of a program block with     |
|                                   | GOTO; labels must be defined in the same        |
|                                   | function body where they are used.              |
+-----------------------------------+-------------------------------------------------+
| [-4415]{#-4415}                   | **An ORDER BY or GROUP item specified within a  |
|                                   | report must be one of the report parameters.\** |
|                                   | *Description:* The names used in a ORDER BY,    |
|                                   | AFTER GROUP OF, or BEFORE GROUP OF statement    |
|                                   | must also appear in the parameter list of the   |
|                                   | REPORT statement. It is not possible to order   |
|                                   | or group based on a global variable or other    |
|                                   | expression.\                                    |
|                                   | *Solution:* Check the spelling of the names in  |
|                                   | the statement and compare them to the REPORT    |
|                                   | statement.                                      |
+-----------------------------------+-------------------------------------------------+
| [-4416]{#-4416}                   | **There is an error in the validation string:   |
|                                   | \'*string*\'.\**                                |
|                                   | *Description:* The validation string in the     |
|                                   | syscolval table is not correct.\                |
|                                   | *Solution:* Change the appropriate DEFAULT or   |
|                                   | INCLUDE value in the syscolval table.           |
+-----------------------------------+-------------------------------------------------+
| [-4417]{#-4417}                   | **This type of statement can be used only in a  |
|                                   | report.\**                                      |
|                                   | *Description:* Statements such as PRINT, SKIP,  |
|                                   | or NEED are meaningful only within the body of  |
|                                   | a report function, where there is an implicit   |
|                                   | report listing to receive output.\              |
|                                   | *Solution:* Remove the report specific          |
|                                   | statement from the code which is not in a       |
|                                   | report body.                                    |
+-----------------------------------+-------------------------------------------------+
| [-4418]{#-4418}                   | **The variable used in the INPUT ARRAY or       |
|                                   | DISPLAY ARRAY statement must be an array.\**    |
|                                   | *Description:* The name following the words     |
|                                   | DISPLAY ARRAY or INPUT ARRAY must be that of an |
|                                   | array of records.\                              |
|                                   | *Solution:* Check the spelling of the name. If  |
|                                   | it is as you intended, find and inspect the     |
|                                   | DEFINE statement to see why it is not an array. |
|                                   | (If you want to display or input a simple       |
|                                   | variable or a single element of an array, use   |
|                                   | the DISPLAY or INPUT statement.)                |
+-----------------------------------+-------------------------------------------------+
| [-4420]{#-4420}                   | **The number of lines printed in the IF part of |
|                                   | an IF-THEN-ELSE statement of a header or        |
|                                   | trailer clause must equal the number of lines   |
|                                   | printed in the ELSE part.\**                    |
|                                   | *Description.* BDL needs to know how many lines |
|                                   | will be filled in header and trailer sections   |
|                                   | (otherwise it could not know how many detail    |
|                                   | rows to put on the page). Because it cannot     |
|                                   | tell which part of an IF statement will be      |
|                                   | executed, it requires that both produce the     |
|                                   | same number of lines of output.\                |
|                                   | *Solution:* Use the same number of occurrences  |
|                                   | of PRINT statements in each block of the IF     |
|                                   | statement.                                      |
+-----------------------------------+-------------------------------------------------+
| [-4425]{#-4425}                   | **The variable \'*var-name*\' has not been      |
|                                   | defined like the table \'*tab-name*\'.\**       |
|                                   | *Description.* The named variable has been used |
|                                   | in the SET clause of an UPDATE statement or in  |
|                                   | the VALUES clause of an INSERT statement, but   |
|                                   | it was not define LIKE the table being          |
|                                   | modified. As a result, then runtime system      |
|                                   | cannot associate record components with table   |
|                                   | columns.\                                       |
|                                   | *Solution:* Make sure the schema file is up to  |
|                                   | date and check that the variable was defined    |
|                                   | like the table. You can also rewrite the UPDATE |
|                                   | or INSERT statement with a different syntax to  |
|                                   | show the explicit relationship between column   |
|                                   | names and record components.                    |
+-----------------------------------+-------------------------------------------------+
| [-4440]{#-4440}                   | **The field \'*field-name-1*\' precedes         |
|                                   | \'*field-name-2*\' in the record                |
|                                   | \'*record-name*\' and must also precede it when |
|                                   | used with the THROUGH shorthand.\**             |
|                                   | *Description:* The THROUGH or THRU shorthand    |
|                                   | requires you to give the starting and ending    |
|                                   | fields as they appear in physical sequence in   |
|                                   | the record.\                                    |
|                                   | *Solution:* Check the spelling of the names; if |
|                                   | they are as you intended, then refer to the     |
|                                   | VARIABLE statement where the record was defined |
|                                   | to see why they are not in the sequence you     |
|                                   | expected.                                       |
+-----------------------------------+-------------------------------------------------+
| [-4447]{#-4447}                   | **\'*key-name*\' is not a recognized key        |
|                                   | value.\**                                       |
|                                   | *Description:* The key name used in an ON KEY   |
|                                   | clause is not known by the compiler.\           |
|                                   | *Solution:* Search the documentation for        |
|                                   | possible key names (F1-F255, Control-?).        |
+-----------------------------------+-------------------------------------------------+
| [-4448]{#-4448}                   | **Cannot open the file \'*file-name*\' for      |
|                                   | reading or writing.\**                          |
|                                   | *Description:* The file cannot be opened.\      |
|                                   | *Solution:* Verify that the filename is         |
|                                   | correctly spelled and that your account has     |
|                                   | permission to read or write to it.              |
+-----------------------------------+-------------------------------------------------+
| [-4452]{#-4452}                   | **The function (or report) \'*name*\' has       |
|                                   | already been defined.\**                        |
|                                   | *Description:* Each function (or report, which  |
|                                   | is similar to a function) must have a unique    |
|                                   | name within the program.\                       |
|                                   | *Solution:* Change the function or report name. |
+-----------------------------------+-------------------------------------------------+
| [-4457]{#-4457}                   | **You may have at most 4 keys in the list.\**   |
|                                   | *Description:* An interactive instruction       |
|                                   | defines a ON KEY() clause with more that 4      |
|                                   | keys.\                                          |
|                                   | *Solution:* Remove keys from the list.          |
+-----------------------------------+-------------------------------------------------+
| [-4458]{#-4458}                   | **One dimension of this array has exceeded the  |
|                                   | limit of 65535.\**                              |
|                                   | *Description:* The program is using a static    |
|                                   | array with a dimension that exceeds the limit.\ |
|                                   | *Solution:* Use a dimension below the 65535     |
|                                   | limit.                                          |
+-----------------------------------+-------------------------------------------------+
| [-4463]{#-4463}                   | **The NEXT FIELD statement can only be used     |
|                                   | within an INPUT or CONSTRUCT statement.\**      |
|                                   | *Description:* The NEXT FIELD statement is used |
|                                   | outside an INPUT, INPUT ARRAY or CONSTRUCT      |
|                                   | statement.\                                     |
|                                   | *Solution:* Remove the NEXT FIELD statement     |
|                                   | from that part of the code.                     |
+-----------------------------------+-------------------------------------------------+
| [-4464]{#-4464}                   | **The number of columns must match the number   |
|                                   | of values in the SET clause of an UPDATE        |
|                                   | statement.\**                                   |
|                                   | *Description:* In an UPDATE statement, the      |
|                                   | number of values used does not match the number |
|                                   | of columns.\                                    |
|                                   | *Solution:* Check for the table definition,     |
|                                   | then either add or remove values or columns     |
|                                   | from the UPDATE statement.                      |
+-----------------------------------+-------------------------------------------------+
| [-4476]{#-4476}                   | **Record members may not be used with database  |
|                                   | column substring.\**                            |
|                                   | *Description:* This statement has a reference   |
|                                   | of the form name1.name2\[\...\]. This is the    |
|                                   | form in which you would refer to a substring of |
|                                   | a column: table.column\[\...\]. However, the    |
|                                   | names are not a table and column in the         |
|                                   | database, so BDL presumes they refer to a field |
|                                   | of a record.\                                   |
|                                   | *Solution:* Inspect the statement and determine |
|                                   | what was intended: a reference to a column or   |
|                                   | to a record. If it is a column reference,       |
|                                   | verify the names of the table and column in the |
|                                   | database. If it is a record reference, verify   |
|                                   | that the record and component are properly      |
|                                   | defined.                                        |
+-----------------------------------+-------------------------------------------------+
| [-4477]{#-4477}                   | **The variable \'*variable-name*\' is an array. |
|                                   | You must specify one of its elements in this    |
|                                   | statement.\**                                   |
|                                   | *Description:* You tried to use an array        |
|                                   | without element specification in a SQL          |
|                                   | statement.*\                                    |
|                                   | Solution*. Use one of the members of the array. |
+-----------------------------------+-------------------------------------------------+
| [-4485]{#-4485}                   | **Only blob variables of tyep BYTE or TEXT may  |
|                                   | be used in a LOCATE statement.\**               |
|                                   | *Description:* The LOCATE statement is using a  |
|                                   | variable defined with a data type different     |
|                                   | from BYTE or TEXT.\                             |
|                                   | *Solution:* Make sure the variables used with   |
|                                   | LOCATE are defined as BYTE or TEXT.             |
+-----------------------------------+-------------------------------------------------+
| [-4488]{#-4488}                   | **The program cannot CONTINUE or EXIT           |
|                                   | *statement-type* at this point because it is    |
|                                   | not immediately within *statement-type*         |
|                                   | statement.\**                                   |
|                                   | *Description:* This CONTINUE or EXIT statement  |
|                                   | is not appropriate in its context.\             |
|                                   | *Solution:* Review your code.  Possibly the     |
|                                   | statement is misplaced, or the statement type   |
|                                   | was specified incorrectly.                      |
+-----------------------------------+-------------------------------------------------+
| [-4489]{#-4489}                   | **A variable used in the above statement must   |
|                                   | be a global variable.\**                        |
|                                   | *Description:* A REPORT routine is defining an  |
|                                   | OUTPUT REPORT TO using a local function         |
|                                   | variable or report parameter.\                  |
|                                   | *Solution:* Review the report clause to use a   |
|                                   | global or module variable instead.              |
+-----------------------------------+-------------------------------------------------+
| [-4490]{#-4490}                   | **You cannot have multiple BEFORE clauses for   |
|                                   | the same field.\**                              |
|                                   | *Description:* You cannot specify more than one |
|                                   | BEFORE FIELD clause for the same field.\        |
|                                   | *Solution:* Review your code to eliminate       |
|                                   | multiple BEFORE FIELD clauses.                  |
+-----------------------------------+-------------------------------------------------+
| [-4491]{#-4491}                   | **You cannot have multiple AFTER clauses for    |
|                                   | the same field.\**                              |
|                                   | *Description:* You cannot specify more than one |
|                                   | AFTER FIELD clause for the same field.\         |
|                                   | *Solution:* Review your code to eliminate       |
|                                   | multiple AFTER FIELD clauses.                   |
+-----------------------------------+-------------------------------------------------+
| [-4534]{#-4534}                   | **Wordwrap may not be used within report        |
|                                   | headers or trailers.\**                         |
|                                   | *Description:* The report routine uses the      |
|                                   | WORDWRAP clause in the FIRST PAGE HEADER, PAGE  |
|                                   | HEADER or PAGE TRAILER sections.\               |
|                                   | *Solution:* Remove the WORDWRAP clause from the |
|                                   | expression.                                     |
+-----------------------------------+-------------------------------------------------+
| [-4631]{#-4631}                   | **Startfield of DATETIME or INTERVAL qualifiers |
|                                   | must come earlier in the time-list than its     |
|                                   | endfield.\**                                    |
|                                   | *Description:* The qualifier for a DATETIME or  |
|                                   | INTERVAL consists of start TO end, where the    |
|                                   | start and end are chosen from this list: YEAR   |
|                                   | MONTH DAY HOUR MINUTE SECOND FRACTION.\         |
|                                   | The keyword for the start field must come       |
|                                   | earlier in the list than, or be the same as,    |
|                                   | the keyword for the end field.\                 |
|                                   | *Solution:* Check the order of the startfield   |
|                                   | and endfield qualifiers. For example,           |
|                                   | qualifiers of DAY TO FRACTION and MONTH TO      |
|                                   | MONTH are valid but one of MINUTE TO HOUR is    |
|                                   | not.                                            |
+-----------------------------------+-------------------------------------------------+
| [-4632]{#-4632}                   | **Parenthetical precision of FRACTION must be   |
|                                   | between 1 and 5. No precision can be specified  |
|                                   | for other time units.\**                        |
|                                   | *Description:* In a DATETIME qualifier only the |
|                                   | FRACTION field may have a precision in          |
|                                   | parentheses, and it must be a single digit from |
|                                   | 1 to 5.\                                        |
|                                   | *Solution:* Check the DATETIME qualifiers in    |
|                                   | the current statement; one of them violates     |
|                                   | these rules. The first field of an INTERVAL     |
|                                   | qualifier may also have a parenthesized         |
|                                   | precision from 1 to 5.                          |
+-----------------------------------+-------------------------------------------------+
| [-4652]{#-4652}                   | **The function \'*function-name*\' can only be  |
|                                   | used within an INPUT or CONSTRUCT statement.\** |
|                                   | *Description:* The function shown is being used |
|                                   | outside of an INPUT or CONSTRUCT statement.     |
|                                   | However, it returns a result that is only       |
|                                   | meaningful in the context of INPUT or           |
|                                   | CONSTRUCT.\                                     |
|                                   | *Solution:* Review the code to make sure that   |
|                                   | an END INPUT or END CONSTRUCT statement has not |
|                                   | been misplaced. Review the operation and use of |
|                                   | the function to make sure you understand it.    |
+-----------------------------------+-------------------------------------------------+
| [-4653]{#-4653}                   | **No more than one BEFORE or AFTER              |
|                                   | INPUT/CONSTRUCT clause can appear in an         |
|                                   | INPUT/CONSTRUCT statement.\**                   |
|                                   | *Description.* There may be only one BEFORE     |
|                                   | block of statements to initialize each of these |
|                                   | statement types.\                               |
|                                   | *Solution:* Make sure that the scope of all     |
|                                   | your INPUT, CONSTRUCT and MENU statements is    |
|                                   | correctly marked with END statements. Then      |
|                                   | combine all the preparation code into a single  |
|                                   | BEFORE block for each one.                      |
+-----------------------------------+-------------------------------------------------+
| [-4656]{#-4656}                   | **CANCEL INSERT can only be used in the BEFORE  |
|                                   | INSERT clause of an INPUT ARRAY statement.\**   |
|                                   | *Description:* The CANCEL INSERT statement is   |
|                                   | being used outside of the BEFORE INSERT clause  |
|                                   | of an INPUT ARRAY.\                             |
|                                   | *Solution:* Review the code to make sure that   |
|                                   | CANCEL INSERT has not been used anywhere except |
|                                   | in the BEFORE INSERT clause.                    |
+-----------------------------------+-------------------------------------------------+
| [-4657]{#-4657}                   | **CANCEL DELETE can only be used in the BEFORE  |
|                                   | DELETE clause of an INPUT ARRAY statement.\**   |
|                                   | *Description:* The CANCEL DELETE statement is   |
|                                   | being used outside of BEFORE DELETE clause of   |
|                                   | an INPUT ARRAY.\                                |
|                                   | *Solution:* Review the code to make sure that   |
|                                   | CANCEL DELETE has not been used anywhere except |
|                                   | in the BEFORE DELETE clause.                    |
+-----------------------------------+-------------------------------------------------+
| [-4668]{#-4668}                   | **The report output, specified by a START       |
|                                   | REPORT statement, is not any of file, pipe,     |
|                                   | screen, printer, pipe in line mode, or pipe in  |
|                                   | form mode.\**                                   |
|                                   | *Description:* The output of a report can be    |
|                                   | sent only to any of file, pipe (in form or line |
|                                   | modes), screen, or printer.\                    |
|                                   | *Solution:* Check the START REPORT instruction  |
|                                   | and make sure that the OUTPUT clause specifies  |
|                                   | one of the supported values.                    |
+-----------------------------------+-------------------------------------------------+
| [-4900]{#-4900}                   | **This syntax is not supported here. Use        |
|                                   | \[screenrecordname.\]screenfieldname.\**        |
|                                   | *Description:* The field name specification in  |
|                                   | a BEFORE FIELD or AFTER FIELD is not valid.\    |
|                                   | *Solution:* Check for the field name and use    |
|                                   | \[screenrecordname.\]screenfieldname syntax.    |
+-----------------------------------+-------------------------------------------------+
| [-4901]{#-4901}                   | **Fatal internal error: %s(%d).\**              |
|                                   | *Description:* This error occurs when an        |
|                                   | incorrect field name is used in a BEFORE FIELD  |
|                                   | or AFTER FIELD statement.\                      |
|                                   | *Solution:* Check if the field name used in the |
|                                   | BEFORE FIELD or AFTER FIELD clause exists.      |
+-----------------------------------+-------------------------------------------------+
| [-6001]{#-6001}                   | **The license manager daemon cannot be          |
|                                   | started.**\                                     |
|                                   | *Description:* This error occurs when a process |
|                                   | creation fails during the start of the license  |
|                                   | manager.\                                       |
|                                   | *Solution:* Increase the maximum number of      |
|                                   | processes allowed (ulimit)                      |
+-----------------------------------+-------------------------------------------------+
| [-6012]{#-6012}                   | **Cannot get license information. Check your    |
|                                   | environment and the license (run \'fglWrt -a    |
|                                   | info\').\**                                     |
|                                   | See error [-6015](#-6015).                      |
+-----------------------------------+-------------------------------------------------+
| [-6013]{#-6013}                   | **Time limited version: time has expired.\**    |
|                                   | *Description:* The license installed is a       |
|                                   | license with time limit and time has expired.   |
|                                   | The program can not start.\                     |
|                                   | *Solution:* Contact your distributor or support |
|                                   | center.                                         |
+-----------------------------------+-------------------------------------------------+
| [-6014]{#-6014}                   | **Your serial number is not valid for this      |
|                                   | version.\**                                     |
|                                   | *Description:* The license serial number is     |
|                                   | invalid for this version of the software.\      |
|                                   | *Solution:* Contact your distributor or support |
|                                   | center.                                         |
+-----------------------------------+-------------------------------------------------+
| [-6015]{#-6015}                   | **Cannot get license information. Check your    |
|                                   | environment and the license (run \'fglWrt -a    |
|                                   | info\').\**                                     |
|                                   | *Description:* It is not possible for the       |
|                                   | application to check the license validity.\     |
|                                   | *Solution:*                                     |
|                                   |                                                 |
|                                   | - License manager:                              |
|                                   |   - The license may not have been installed     |
|                                   |   - The license controller can not communicate  |
|                                   |     with the license manager. Check that the    |
|                                   |     license manager is started and check that   |
|                                   |     the fglprofile entries *flm.server* and     |
|                                   |     *flm.service* contain valid information.    |
|                                   |   - The directory **\$FLMDIR/lock** and all the |
|                                   |     files below must have read/write            |
|                                   |     permission.                                 |
|                                   | - License controller:                           |
|                                   |   - The license may not have been installed.    |
|                                   |   - The directory **\$FGLDIR/lock** and all the |
|                                   |     files below must have read/write            |
|                                   |     permission.                                 |
+-----------------------------------+-------------------------------------------------+
| [-6016]{#-6016}                   | **Cannot get information for license (Error     |
|                                   | %s). Check your environment and the license     |
|                                   | (run \'fglWrt -a info\').\**                    |
|                                   | *Description:* The application is unable to     |
|                                   | check the license validity.\                    |
|                                   | *Solution:* See error -[6015](#-6015).          |
+-----------------------------------+-------------------------------------------------+
| [-6017]{#-6017}                   | **User limit exceeded. Cannot run this          |
|                                   | program.\**                                     |
|                                   | *Description:* The maximum number of users      |
|                                   | allowed by the license has been reached. The    |
|                                   | program can not start.\                         |
|                                   | *Solution:* Contact your distributor or support |
|                                   | center.                                         |
+-----------------------------------+-------------------------------------------------+
| [-6018]{#-6018}                   | **Cannot access internal data file. Cannot      |
|                                   | continue this program. Please, check your       |
|                                   | environment(%s).\**                             |
|                                   | *Description:* When a client computer starts an |
|                                   | application on the server, the application      |
|                                   | stores data in the **\$FGLDIR/lock** directory. |
|                                   | The client must have permission to create and   |
|                                   | delete files in this directory.\                |
|                                   | *Solution:*                                     |
|                                   |                                                 |
|                                   | - Do not remove or modify files contained in    |
|                                   |   the directory \$FGLDIR/lock                   |
|                                   | - Change the permissions of the                 |
|                                   |   **\$FGLDIR/lock**directory, or connect to the |
|                                   |   server with a user name having the correct    |
|                                   |   permissions.                                  |
+-----------------------------------+-------------------------------------------------+
| [-6019]{#-6019}                   | **This demonstration version allows one user    |
|                                   | only.\**                                        |
|                                   | *Description:* The demonstration version is     |
|                                   | designed to run with only one user. Another     |
|                                   | user or another graphical daemon is currently   |
|                                   | active.\                                        |
|                                   | *Solution:* Wait until the user stops the       |
|                                   | current program, or use the same graphical      |
|                                   | daemon.                                         |
+-----------------------------------+-------------------------------------------------+
| [-6020]{#-6020}                   | **Installation: Cannot open \'*file-name*\'.\** |
|                                   | *Description:* A file is missing or the         |
|                                   | permissions are not set for the current user.\  |
|                                   | *Solution:* Check that the file permissions are |
|                                   | correct for the user trying to execute the      |
|                                   | application. If the file is missing, re-install |
|                                   | the compiler package.                           |
+-----------------------------------+-------------------------------------------------+
| [-6022]{#-6022}                   | **Demonstration time has expired. Please, run   |
|                                   | this program again.\**                          |
|                                   | *Description:* The runtime demonstration        |
|                                   | version is valid only for a few minutes after   |
|                                   | you have started a program.\                    |
|                                   | *Solution:* Restart the program.                |
+-----------------------------------+-------------------------------------------------+
| [-6025]{#-6025}                   | **Demonstration time has expired. Please,       |
|                                   | contact your vendor.\**                         |
|                                   | *Description:* The demonstration version of the |
|                                   | product has a time limit of 30 days.\           |
|                                   | *Solution:* Either reinstall a new              |
|                                   | demonstration version, or call your software    |
|                                   | vendor to purchase a permanent license.         |
+-----------------------------------+-------------------------------------------------+
| [-6026]{#-6026}                   | **Bad link for runner demonstration. Please,    |
|                                   | retry or rebuild your runner.\**                |
|                                   | *Description:* The runner is corrupted.         |
+-----------------------------------+-------------------------------------------------+
| [-6027]{#-6027}                   | **Cannot access license server. Please check    |
|                                   | the following:\**                               |
|                                   | - the license server entry in your resource     |
|                                   | file. (service port)\                           |
|                                   | - the license server host.\                     |
|                                   | - the license server program.\                  |
|                                   | *Description:* You have not specified a value   |
|                                   | for the environment variable                    |
|                                   | \[fgllic\|fls\|flm\].server in the              |
|                                   | \$FGLDIR/etc/fglprofile file.\                  |
|                                   | *Solution:* Check the fglprofile file for the   |
|                                   | entry point \[fgllic\|fls\|flm\].server and     |
|                                   | specify the name of the computer that runs the  |
|                                   | License Manager.                                |
+-----------------------------------+-------------------------------------------------+
| [-6029]{#-6029}                   | **Unknown parameter \'*parameter*\' for         |
|                                   | checking.**\                                    |
|                                   | *Description:* The command line of the fglWrt   |
|                                   | or flmprg tool contains an unknown parameter.\  |
|                                   | *Solution:* Check your command-line parameters  |
|                                   | and retry the command.                          |
+-----------------------------------+-------------------------------------------------+
| [-6031]{#-6031}                   | **Temporary license *license-number* has        |
|                                   | expired.\**                                     |
|                                   | *Description:* Your temporary runtime license   |
|                                   | has expired.\                                   |
|                                   | *Solution:* Call your software vendor to get a  |
|                                   | new license.                                    |
+-----------------------------------+-------------------------------------------------+
| [-6032]{#-6032}                   | **%s: illegal option : \'%c\'.\**               |
|                                   | *Description:* You are not using a valid        |
|                                   | option.\                                        |
|                                   | *Solution:* Check your command line and try the |
|                                   | command again.                                  |
+-----------------------------------+-------------------------------------------------+
| [-6033]{#-6033}                   | **%s: \'%c\' option requires an argument.**\    |
|                                   | *Description:* You cannot use this option of    |
|                                   | the fglWrt tool without a parameter.\           |
|                                   | *Solution:* Check your command line and try the |
|                                   | command again.                                  |
+-----------------------------------+-------------------------------------------------+
| [-6034]{#-6034}                   | **Warning! This is a temporary license,         |
|                                   | installation number is                          |
|                                   | \'*installation-number*\'.**\                   |
|                                   | *Description:* You have installed a temporary   |
|                                   | license of 30 days. You will have to enter an   |
|                                   | installation key before the end of this period  |
|                                   | if you want to keep on running the program.\    |
|                                   | *Solution:* This is only a warning message.     |
+-----------------------------------+-------------------------------------------------+
| [-6035]{#-6035}                   | **Cannot read in directory**\                   |
|                                   | *Description:* The compiler cannot access the   |
|                                   | \$FGLDIR/lock directory. The current user must  |
|                                   | have read and write permissions in this         |
|                                   | directory.\                                     |
|                                   | *Solution:* Give the current user read and      |
|                                   | write permissions to the \$FGLDIR/lock          |
|                                   | directory.                                      |
+-----------------------------------+-------------------------------------------------+
| [-6041]{#-6041}                   | **Can not retrieve network interface            |
|                                   | information.**\                                 |
|                                   | *Description:* An error occurred while          |
|                                   | retrieving network interface information.\      |
|                                   | *Solution:* Restart your program. If this does  |
|                                   | not solve your problem, contact your            |
|                                   | distributor.                                    |
+-----------------------------------+-------------------------------------------------+
| [-6042]{#-6042}                   | **MAC Address has changed.**\                   |
|                                   | *Description:* The MAC address of the host has  |
|                                   | changed since the license was first installed.\ |
|                                   | *Solution:* The license must be reinstalled, or |
|                                   | restore the old MAC address.                    |
+-----------------------------------+-------------------------------------------------+
| [-6043]{#-6043}                   | **The testing period is finished. You must      |
|                                   | install a new license.**\                       |
|                                   | *Description:* The test time license of has     |
|                                   | expired.\                                       |
|                                   | *Solution:* Call your software vendor to        |
|                                   | purchase a new license.                         |
+-----------------------------------+-------------------------------------------------+
| [-6044]{#-6044}                   | **IP Address has changed.**\                    |
|                                   | *Description:* The IP Address of the host has   |
|                                   | changed.\                                       |
|                                   | *Solution:* Restore the IP address of the host, |
|                                   | or reinstall the license.\                      |
|                                   | This is no longer checked by the latest         |
|                                   | versions of the license controller.             |
+-----------------------------------+-------------------------------------------------+
| [-6045]{#-6045}                   | **Host name has changed.**\                     |
|                                   | *Description:* The host name has changed.\      |
|                                   | *Solution:* Restore the host name or reinstall  |
|                                   | the license.\                                   |
|                                   | This is no longer checked by the latest         |
|                                   | versions of the license controller.             |
+-----------------------------------+-------------------------------------------------+
| [-6046]{#-6046}                   | **Could not get file reference number           |
|                                   | information.**\                                 |
|                                   | *Description.* The license could not get        |
|                                   | information about the license file.\            |
|                                   | *Solution:* Reinstall the license. Contact your |
|                                   | distributor.                                    |
+-----------------------------------+-------------------------------------------------+
| [-6047]{#-6047}                   | **The device number of the license file has     |
|                                   | changed.**\                                     |
|                                   | *Description:* The license file has been        |
|                                   | touched. The license is no longer valid.\       |
|                                   | *Solution:* Reinstall the license. Contact your |
|                                   | distributor.                                    |
+-----------------------------------+-------------------------------------------------+
| [-6048]{#-6048}                   | **The file reference number of the license file |
|                                   | has changed.**\                                 |
|                                   | *Description:* The license file has been        |
|                                   | touched. The license is no longer valid.\       |
|                                   | *Solution:* Reinstall the license. Contact your |
|                                   | distributor.                                    |
+-----------------------------------+-------------------------------------------------+
| [-6049]{#-6049}                   | **This product is licensed for runtime only. No |
|                                   | compilation is allowed.**\                      |
|                                   | *Description:* You have a runtime license       |
|                                   | installed with this package. You cannot compile |
|                                   | BDL source code modules with this license.\     |
|                                   | *Solution:* If you want to compile 4GL source   |
|                                   | code, you must purchase and install a           |
|                                   | development license. Contact your distributor.  |
+-----------------------------------+-------------------------------------------------+
| [-6050]{#-6050}                   | **Temporary license *license-number* expired.   |
|                                   | Please contact your vendor.**\                  |
|                                   | *Description:* A license with a time limit has  |
|                                   | been installed and the license has expired.\    |
|                                   | *Solution:* Install a new license to activate   |
|                                   | the product. Contact your distributor.          |
+-----------------------------------+-------------------------------------------------+
| [-6051]{#-6051}                   | **Temporary license *license-number* expired.   |
|                                   | Please contact your vendor.**\                  |
|                                   | *Description:* A license with a time limit has  |
|                                   | been installed and the license has expired.\    |
|                                   | *Solution:* Install a new license to activate   |
|                                   | the product. Contact your distributor.          |
+-----------------------------------+-------------------------------------------------+
| [-6052]{#-6052}                   | **Temporary license *license-number* expired.   |
|                                   | Please contact your vendor.**\                  |
|                                   | *Description:* A license with a time limit has  |
|                                   | been installed and the license has expired.\    |
|                                   | *Solution:* Install a new license to activate   |
|                                   | the product. Contact your distributor.          |
+-----------------------------------+-------------------------------------------------+
| [-6053]{#-6053}                   | **Installation path has changed. It must hold   |
|                                   | the original installation path.**\              |
|                                   | *Description:* The value of FGLDIR or the       |
|                                   | location of FGLDIR has been changed.\           |
|                                   | *Solution:* Ask the person who installed the    |
|                                   | product for the location of the original        |
|                                   | installation directory and then set the FGLDIR  |
|                                   | environment variable.                           |
+-----------------------------------+-------------------------------------------------+
| [-6054]{#-6054}                   | **Cannot read a license file. Check             |
|                                   | installation path and your environment. Verify  |
|                                   | if a license is installed.**\                   |
|                                   | *Description:* The file that contains the       |
|                                   | license is not readable by the current user.\   |
|                                   | *Solution:*                                     |
|                                   |                                                 |
|                                   | - License controller: Check that the FGLDIR     |
|                                   |   environment variable is correctly set and     |
|                                   |   that the file \$FGLDIR/etc/f4gl.sn is         |
|                                   |   readable by the current user.                 |
|                                   | - License manager: Check that the file          |
|                                   |   \$FLMDIR/etc/license/lic?????.dat is readable |
|                                   |   by the current user.                          |
+-----------------------------------+-------------------------------------------------+
| [-6055]{#-6055}                   | **Cannot update a license file. Check           |
|                                   | installation path and your environment. Verify  |
|                                   | if a license is installed.**\                   |
|                                   | *Description:* The file that contains the       |
|                                   | license cannot be overwritten by the current    |
|                                   | user.\                                          |
|                                   | *Solution:*                                     |
|                                   |                                                 |
|                                   | - License controller: Check that the FGLDIR     |
|                                   |   environment variable is correctly set and     |
|                                   |   that the file \$FGLDIR/etc/f4gl.sn is         |
|                                   |   writable by the current user.                 |
|                                   | - License manager: Check that the file          |
|                                   |   \$FLMDIR/etc/license/lic?????.dat is writable |
|                                   |   by the current user.                          |
+-----------------------------------+-------------------------------------------------+
| [-6056]{#-6056}                   | **Cannot write into a license file. Please      |
|                                   | check your rights.**\                           |
|                                   | *Description:* The file that contains the       |
|                                   | license cannot be overwritten by the current    |
|                                   | user.\                                          |
|                                   | *Solution:*                                     |
|                                   |                                                 |
|                                   | - License controller: Check that the FGLDIR     |
|                                   |   environment variable is correctly set and     |
|                                   |   that the file \$FGLDIR/etc/f4gl.sn is         |
|                                   |   writable by the current user.                 |
|                                   | - License manager: Check that the file          |
|                                   |   \$FLMDIR/etc/license/lic?????.dat is writable |
|                                   |   by the current user.                          |
+-----------------------------------+-------------------------------------------------+
| [-6057]{#-6057}                   | **Cannot read a license file. Check             |
|                                   | installation path and your environment. Verify  |
|                                   | if a license is installed.**\                   |
|                                   | *Description:* The file that contains the       |
|                                   | license cannot be read by the current user.\    |
|                                   | *Solution:* Check that the current user can     |
|                                   | read the file \$FGLDIR/etc/f4gl.sn. Also check  |
|                                   | that the FGLDIR environment variable is set     |
|                                   | correctly.                                      |
+-----------------------------------+-------------------------------------------------+
| [-6058]{#-6058}                   | **Incorrect license file format. Verify if a    |
|                                   | license is installed.**\                        |
|                                   | *Description:* The file that contains the       |
|                                   | license has been corrupted.\                    |
|                                   | *Solution:* Reinstall the license. If you have  |
|                                   | a backup of the current installation of Genero  |
|                                   | Business Development Language, restore the      |
|                                   | files located in the \$FGLDIR/etc directory.    |
+-----------------------------------+-------------------------------------------------+
| [-6059]{#-6059}                   | **Incorrect license file format. Verify if a    |
|                                   | license is installed.**\                        |
|                                   | *Description:* The file that contains the       |
|                                   | license has been corrupted.\                    |
|                                   | *Solution:* Reinstall the license. If you have  |
|                                   | a backup of the current installation of Genero  |
|                                   | Business Development Language, restore the      |
|                                   | files located in the \$FGLDIR/etc directory.    |
+-----------------------------------+-------------------------------------------------+
| [-6061]{#-6061}                   | **License \'*license-number*\' not              |
|                                   | installed.**\                                   |
|                                   | *Description:* The license shown is not         |
|                                   | installed.\                                     |
|                                   | *Solution:* Reinstall the license.              |
+-----------------------------------+-------------------------------------------------+
| [-6062]{#-6062}                   | **No installed license has been found for       |
|                                   | \'*license-number*\'.***\                       |
|                                   | Description.* The add-user license can not be   |
|                                   | installed. No main license found to add users.\ |
|                                   | *Solution:* Contact your distributor.           |
+-----------------------------------+-------------------------------------------------+
| [-6063]{#-6063}                   | **License \'*license-number*\' is already       |
|                                   | installed.**\                                   |
|                                   | *Description:* The license shown is already     |
|                                   | installed.\                                     |
|                                   | *Solution:* No particular action to be taken.   |
+-----------------------------------+-------------------------------------------------+
| [-6064]{#-6064}                   | **The resource \'flm.license.number\' is        |
|                                   | required to use the license manager.**          |
+-----------------------------------+-------------------------------------------------+
| [-6065]{#-6065}                   | **The resource \'flm.license.key\' is required  |
|                                   | to use the license manager.**                   |
+-----------------------------------+-------------------------------------------------+
| [-6066]{#-6066}                   | **License \'*license-number*\' cannot be        |
|                                   | installed over \'*license-number*\'.**\         |
|                                   | *Description:* The add-user license does not    |
|                                   | match the main license. The add-user license    |
|                                   | can not be installed.\                          |
|                                   | *Solution:* Contact your distributor.           |
+-----------------------------------+-------------------------------------------------+
| [-6067]{#-6067}                   | **You need a installed license if you want to   |
|                                   | add users.**\                                   |
|                                   | *Description:* The add-user license must be     |
|                                   | installed after the main license.\              |
|                                   | *Solution:* Install the main license before the |
|                                   | add-user license. If this does not solve your   |
|                                   | problem, contact your distributor.              |
+-----------------------------------+-------------------------------------------------+
| [-6068]{#-6068}                   | **No license installed.**\                      |
|                                   | *Description:* There is no license installed    |
|                                   | for Genero Business Development Language.\      |
|                                   | *Solution:* Install a license. If a license is  |
|                                   | already installed, check that the \$FGLDIR      |
|                                   | environment variable is set correctly.          |
+-----------------------------------+-------------------------------------------------+
| [-6069]{#-6069}                   | **Cannot uninstall the license.**\              |
|                                   | *Description:* There was a problem during the   |
|                                   | uninstall of the Genero Business Development    |
|                                   | Language license.\                              |
|                                   | *Solution:* Check whether the FGLDIR            |
|                                   | environment variable is correctly set in your   |
|                                   | environment and  the current user has           |
|                                   | permission to delete files in the \$FGLDIR/etc  |
|                                   | directory.                                      |
+-----------------------------------+-------------------------------------------------+
| [-6070]{#-6070}                   | **The license server entry must be set in your  |
|                                   | resource file in order to reach the license     |
|                                   | server.**\                                      |
|                                   | *Description:* You are using the remote license |
|                                   | process and you have set the value of           |
|                                   | fgllic.server, in \$FGLDIR/etc/fglprofile, to   |
|                                   | localhost or to the 127.0.0.1 address.\         |
|                                   | *Solution:* You must use the real IP address of |
|                                   | the computer even if it is the local computer.  |
+-----------------------------------+-------------------------------------------------+
| [-6071]{#-6071}                   | **Cannot use directory \'*directory-name*\'.    |
|                                   | Check installation path and verify if access    |
|                                   | rights are \'drwxrwxrwx\'.**\                   |
|                                   | *Description:* The compiler needs to operate in |
|                                   | the specified directory.\                       |
|                                   | *Solution:* Change the permission of this       |
|                                   | directory.                                      |
+-----------------------------------+-------------------------------------------------+
| [-6072]{#-6072}                   | **Cannot create file in \'*file-name*\'. Check  |
|                                   | installation path and verify if access rights   |
|                                   | are \'drwxrwxrwx\'.**\                          |
|                                   | *Description:* The compiler needs to operate in |
|                                   | the specified directory.\                       |
|                                   | *Solution:* Change the permission of this       |
|                                   | directory to 777 mode.                          |
+-----------------------------------+-------------------------------------------------+
| [-6073]{#-6073}                   | **Cannot change mode of a file in               |
|                                   | \'*file-name*\'. Verify if access rights are    |
|                                   | \'drwxrwxrwx\'.**\                              |
|                                   | *Description:* The compiler needs to operate in |
|                                   | the specified directory.\                       |
|                                   | *Solution:* Change the permission of this       |
|                                   | directory to 777 mode.                          |
+-----------------------------------+-------------------------------------------------+
| [-6074]{#-6074}                   | **\'*file-name*\' does not have \'rwxrwxrwx\'   |
|                                   | rights or isn\'t a directory. Check access      |
|                                   | rights with \'ls -ld                            |
|                                   | \<installation-path\>/lock\' or execute \'rm -r |
|                                   | \<installation-path\>/lock\' if no users are    |
|                                   | connected.**\                                   |
|                                   | *Description:* The compiler needs to operate in |
|                                   | the specified directory.\                       |
|                                   | *Solution:* Change the permission of this       |
|                                   | directory. The \$FGLDIR/lock directory contains |
|                                   | only data needed at runtime by BDL              |
|                                   | applications. When the application is finished, |
|                                   | you can remove this directory. If you delete    |
|                                   | this directory while BDL applications are       |
|                                   | running, the applications will be stopped       |
|                                   | immediately.                                    |
+-----------------------------------+-------------------------------------------------+
| [-6075]{#-6075}                   | **Cannot read from directory                    |
|                                   | \'*directory-name*\'. Check installation path   |
|                                   | and verify if access rights are                 |
|                                   | \'drwxrwxrwx\'.**\                              |
|                                   | *Description:* The compiler needs to operate in |
|                                   | the specified directory.\                       |
|                                   | *Solution:* Change the permission of this       |
|                                   | directory.                                      |
+-----------------------------------+-------------------------------------------------+
| [-6076]{#-6076}                   | **Bad lock tree. Please check your              |
|                                   | environment.**\                                 |
|                                   | *Description:* There is a problem accessing the |
|                                   | \$FGLDIR/lock directory.\                       |
|                                   | *Solution:* Check if the current user has       |
|                                   | sufficient permission to read and write to the  |
|                                   | \$FGLDIR/lock directory. Check also if the      |
|                                   | FGLDIR environment variable is correctly set.   |
+-----------------------------------+-------------------------------------------------+
| [-6077]{#-6077}                   | **Bad lock tree. Please check your              |
|                                   | environment.**\                                 |
|                                   | *Description:* There is a problem accessing the |
|                                   | \$FGLDIR/lock directory.\                       |
|                                   | *Solution:* Check if the current user has       |
|                                   | sufficient permission to read and write to the  |
|                                   | \$FGLDIR/lock directory. Check also if the      |
|                                   | FGLDIR environment variable is correctly set.   |
+-----------------------------------+-------------------------------------------------+
| [-6079]{#-6079}                   | **Cannot get machine name or network IP         |
|                                   | address. Each graphical client must have an IP  |
|                                   | address when using a license server. FGLSERVER  |
|                                   | must hold the IP address or the host name of    |
|                                   | the client.**\                                  |
|                                   | *Description:* You are using the remote license |
|                                   | process and you have set the value of           |
|                                   | fgllic.server, in \$FGLDIR/etc/fglprofile, to   |
|                                   | localhost or to the 127.0.0.1 address.\         |
|                                   | *Solution:* You must use the real IP address of |
|                                   | the computer even if it is the local computer.  |
|                                   | This is also true for the value used with the   |
|                                   | FGLSERVER environment variable.                 |
+-----------------------------------+-------------------------------------------------+
| [-6080]{#-6080}                   | **Cannot get IP address from \'*host-name*\'    |
|                                   | host. Check the \'flm.server\' resource.**\     |
|                                   | *Description:* The system cannot find the IP    |
|                                   | address of the specified host.\                 |
|                                   | *Solution:* This is a configuration issue       |
|                                   | regarding your system. The command ping should  |
|                                   | not reply as well. Correct your system          |
|                                   | configuration and then try to execute your      |
|                                   | program.                                        |
+-----------------------------------+-------------------------------------------------+
| [-6081]{#-6081}                   | **Cannot reach host \'*host-name*\' with ping.  |
|                                   | Check license server entry in your resource     |
|                                   | file. Check your network configuration or       |
|                                   | increase \'flm.ping\' value.**\                 |
|                                   | *Description:* The license server cannot ping   |
|                                   | the client computer, or it does not get the     |
|                                   | response in the time limit specified by the     |
|                                   | fgllic.ping entry in the                        |
|                                   | \$FGLDIR/etc/fglprofile file.\                  |
|                                   | *Solution:* Try to manually ping the specified  |
|                                   | computer. If this works, try to increase the    |
|                                   | value of the fgllic.ping entry in fglprofile.   |
|                                   | If the ping does not respond, fix the system    |
|                                   | configuration problem and then try the program  |
|                                   | again.                                          |
+-----------------------------------+-------------------------------------------------+
| [-6082]{#-6082}                   | **SYSERROR(%d)%s: Cannot set option TCP_NODELAY |
|                                   | on socket. Check the system error message and   |
|                                   | retry.**\                                       |
|                                   | *Description:* There is a problem with the      |
|                                   | socket of the Windows computer.\                |
|                                   | *Solution:* Check that the system is correctly  |
|                                   | configured and retry the program.               |
+-----------------------------------+-------------------------------------------------+
| [-6085]{#-6085}                   | **SYSERROR(%d)%s: Cannot connect to the license |
|                                   | server on host \'*host-name*\'. Check following |
|                                   | things:\                                        |
|                                   | - license server entry.\                        |
|                                   | - the license server machine.\                  |
|                                   | - the license server TCP port.\**               |
|                                   | *Description:* The application cannot check the |
|                                   | license validity. To do so, it tries to         |
|                                   | communicate with the Genero Business            |
|                                   | Development Language license service running on |
|                                   | the computer where the product is installed.\   |
|                                   | *Solution:* Check that the Genero Business      |
|                                   | Development Language License Server is running  |
|                                   | on the computer where the product is installed. |
+-----------------------------------+-------------------------------------------------+
| [-6086]{#-6086}                   | **SYSERROR(%d)%s: Cannot send data to the       |
|                                   | license server. Check the system error message  |
|                                   | and retry.\**                                   |
|                                   | *Description:* There is a problem with the      |
|                                   | socket of the Windows computer.\                |
|                                   | *Solution:* Check that the system is correctly  |
|                                   | configured and retry the program.               |
+-----------------------------------+-------------------------------------------------+
| [-6087]{#-6087}                   | **SYSERROR(%d)%s: Cannot receive data from      |
|                                   | license server. Check the system error message  |
|                                   | and retry.\**                                   |
|                                   | *Description:* There is a problem with the      |
|                                   | socket of the Windows computer.\                |
|                                   | *Solution:* Check that the system is correctly  |
|                                   | configured and retry the program.               |
+-----------------------------------+-------------------------------------------------+
| [-6088]{#-6088}                   | **You are not allowed to be connected for the   |
|                                   | following reason: *description*\**              |
|                                   | *Description:* The program cannot connect to    |
|                                   | the license server because of the specified     |
|                                   | reason.\                                        |
|                                   | *Solution:* Try to fix the problem described    |
|                                   | and rerun your application.                     |
+-----------------------------------+-------------------------------------------------+
| [-6089]{#-6089}                   | **Each graphical client must have an IP address |
|                                   | when using a license server. FGLSERVER must     |
|                                   | hold the IP address or the host name of the     |
|                                   | client (localhost or 127.0.0.1 are not          |
|                                   | allowed).**                                     |
+-----------------------------------+-------------------------------------------------+
| [-6090]{#-6090}                   | **SYSERROR(%d)%s: Cannot create a socket to     |
|                                   | start the license server. Check the system      |
|                                   | error message and retry.**\                     |
|                                   | *Description:* There is a problem with the      |
|                                   | socket of the Windows computer.\                |
|                                   | *Solution:* Check that the system is correctly  |
|                                   | configured and rerun the program.               |
+-----------------------------------+-------------------------------------------------+
| [-6091]{#-6091}                   | **SYSERROR(%d)%s: Cannot bind socket for the    |
|                                   | license server. Check the system error message  |
|                                   | and retry.**\                                   |
|                                   | *Description:* There is a problem with the      |
|                                   | socket of the Windows computer.\                |
|                                   | *Solution:* Check that the system is correctly  |
|                                   | configured and rerun the program.               |
+-----------------------------------+-------------------------------------------------+
| [-6092]{#-6092}                   | **SYSERROR(%d)%s: Cannot listen socket for the  |
|                                   | license server.\**                              |
|                                   | *Description:* There is a problem with the      |
|                                   | socket of the Windows computer.\                |
|                                   | *Solution:* Check that the system is correctly  |
|                                   | configured and rerun the program.               |
+-----------------------------------+-------------------------------------------------+
| [-6093]{#-6093}                   | **SYSERROR(%d)%s: Cannot create a socket to     |
|                                   | search an active client.\**                     |
|                                   | *Description:* There is a problem with the      |
|                                   | socket of the Windows computer.\                |
|                                   | *Solution:* Check that the system is correctly  |
|                                   | configured and rerun the program.               |
+-----------------------------------+-------------------------------------------------+
| [-6094]{#-6094}                   | **SYSERROR(%d)%s: This is a WSAStartup error.   |
|                                   | Check the system error message and retry.\**    |
|                                   | *Description:* There is a problem with the      |
|                                   | socket of the Windows computer.\                |
|                                   | *Solution:* Check that the system is correctly  |
|                                   | configured and rerun the program.               |
+-----------------------------------+-------------------------------------------------+
| [-6095]{#-6095}                   | **License problem: *reason*\**                  |
|                                   | *Description:* License type incompatible. You   |
|                                   | are installing an earlier version, which was    |
|                                   | not designated for use with the current license |
|                                   | server.\                                        |
|                                   | *Solution:* Reinstall and then contact your     |
|                                   | vendor.                                         |
+-----------------------------------+-------------------------------------------------+
| [-6096]{#-6096}                   | **Connection refused by the license server.\**  |
|                                   | *Description:* There is problem connecting the  |
|                                   | client computer to the Windows license server.\ |
|                                   | *Solution:* There is a configuration problem    |
|                                   | with the license server computer. Check the     |
|                                   | configuration of the computers and of the       |
|                                   | products.                                       |
+-----------------------------------+-------------------------------------------------+
| [-6100]{#-6100}                   | **Bad format of line sent by the license        |
|                                   | requester.**                                    |
+-----------------------------------+-------------------------------------------------+
| [-6101]{#-6101}                   | **License number \'*license-number*\' does not  |
|                                   | correspond to license key \'*license-key*\'.**  |
+-----------------------------------+-------------------------------------------------+
| [-6102]{#-6102}                   | **Verify if resource \'flm.license.number\' and |
|                                   | \'flm.license.key\' correspond to a valid       |
|                                   | license.**                                      |
+-----------------------------------+-------------------------------------------------+
| [-6103]{#-6103}                   | **License \'*license-number*\' is no longer     |
|                                   | available from the license server.**            |
+-----------------------------------+-------------------------------------------------+
| [-6107]{#-6107}                   | **User limit exceeded. Please retry later.**\   |
|                                   | *Description:* The maximum number of clients    |
|                                   | that can be run has been reached (due to the    |
|                                   | license installed).\                            |
|                                   | *Solution:* Retry later (when the number of     |
|                                   | current users has decreased) or install a new   |
|                                   | license that allows more users.                 |
+-----------------------------------+-------------------------------------------------+
| [-6108]{#-6108}                   | **Environment is incorrect.**\                  |
|                                   | *Description:* There is no local license, or    |
|                                   | the environment is not set correctly.\          |
|                                   | *Solution:* Check your environment and your     |
|                                   | FGLDIR environment variable.                    |
+-----------------------------------+-------------------------------------------------+
| [-6109]{#-6109}                   | **Cannot add session #%s.**\                    |
|                                   | *Description:* You do not have the permissions  |
|                                   | to create the new session (the directory        |
|                                   | representing the new client).\                  |
|                                   | *Solution:* Check the permissions of the        |
|                                   | dedicated directories.                          |
+-----------------------------------+-------------------------------------------------+
| [-6110]{#-6110}                   | **Cannot add program \'*program-name*\'         |
|                                   | (pid=%d).**\                                    |
|                                   | *Description:* You do not have the permissions  |
|                                   | to create the new application (the file         |
|                                   | representing the new application) for the       |
|                                   | current user .\                                 |
|                                   | *Solution:* Check the permissions of the        |
|                                   | dedicated directories.                          |
+-----------------------------------+-------------------------------------------------+
| [-6112]{#-6112}                   | **Compilation is not allowed: This product is   |
|                                   | licensed for runtime only.**                    |
+-----------------------------------+-------------------------------------------------+
| [-6113]{#-6113}                   | **Compilation is not allowed: Invalid           |
|                                   | license. **                                     |
+-----------------------------------+-------------------------------------------------+
| [-6114]{#-6114}                   | **Cannot start program \'*program-name*\' or    |
|                                   | result of process number is 0.**\               |
|                                   | *Description:* When fglWrt -u is executed to    |
|                                   | find the number of users allowed on this        |
|                                   | installation, the command \"ps\" may be         |
|                                   | launched (only on UNIX).\                       |
|                                   | *Solution:* Check the permissions for ps.       |
+-----------------------------------+-------------------------------------------------+
| [-6116]{#-6116}                   | **Wrong number of characters.**                 |
+-----------------------------------+-------------------------------------------------+
| [-6117]{#-6117}                   | **The entry must be 12 characters long.**       |
+-----------------------------------+-------------------------------------------------+
| [-6118]{#-6118}                   | **Wrong checksum result for this entry.**       |
+-----------------------------------+-------------------------------------------------+
| [-6122]{#-6122}                   | **You must specify entry \'flm.server\' in the  |
|                                   | resource file.**                                |
+-----------------------------------+-------------------------------------------------+
| [-6123]{#-6123}                   | **SYSERROR(%d)%s: Cannot open socket. Check the |
|                                   | system error message and retry.**               |
+-----------------------------------+-------------------------------------------------+
| [-6129]{#-6129}                   | **License uninstalled.**\                       |
|                                   | *Description:* This is an information message.  |
+-----------------------------------+-------------------------------------------------+
| [-6130]{#-6130}                   | **This license requires a full installation.**\ |
|                                   | *Description:* The installed license has not be |
|                                   | activated, but can not be used in temporary     |
|                                   | installation mode.\                             |
|                                   | *Solution:* Contact your vendor to obtain the   |
|                                   | activation key.                                 |
+-----------------------------------+-------------------------------------------------+
| [-6131]{#-6131}                   | **This license number is no more valid. Please, |
|                                   | contact your vendor.**\                         |
|                                   | *Description:* The license number is no longer  |
|                                   | accepted.\                                      |
|                                   | *Solution:* Contact your vendor to obtain a new |
|                                   | license number.                                 |
+-----------------------------------+-------------------------------------------------+
| [-6132]{#-6132}                   | **Incompatible License Controller               |
|                                   | (fglWrt/greWrt) version. The minimum version    |
|                                   | required is %s.**\                              |
|                                   | *Solution:* Upgrade your license controller     |
|                                   | version to the specified version or higher.     |
+-----------------------------------+-------------------------------------------------+
| [-6133]{#-6133}                   | **This product requires a BDL license.\         |
|                                   | The license number should start with the letter |
|                                   | F.\**                                           |
|                                   | *Description:* A BDL license is required for    |
|                                   | this product.\                                  |
|                                   | *Solution:* Call you support center to get a    |
|                                   | BDL license.                                    |
+-----------------------------------+-------------------------------------------------+
| [-6134]{#-6134}                   | **This product requires a Genero license.\      |
|                                   | The license number should start with the letter |
|                                   | T.\**                                           |
|                                   | *Description:* A Genero license is required for |
|                                   | this product.\                                  |
|                                   | *Solution:* Call you support center to get a    |
|                                   | Genero license.                                 |
+-----------------------------------+-------------------------------------------------+
| [-6135]{#-6135}                   | **Invalid license key.\**                       |
|                                   | *Description:* The license key does not         |
|                                   | correspond to the license number.\              |
|                                   | *Solution:* Call you support center to check    |
|                                   | the license key.                                |
+-----------------------------------+-------------------------------------------------+
| [-6136]{#-6136}                   | **The date-limited license has expired.\**      |
|                                   | *Description:* The time limited license has     |
|                                   | expired, the product is blocked.\               |
|                                   | *Solution:* Call you support center to get a    |
|                                   | new license.                                    |
+-----------------------------------+-------------------------------------------------+
| [-6137]{#-6137}                   | **This product requires a GRW license.\**       |
|                                   | *Description:* A GRW license is required for    |
|                                   | this product.\                                  |
|                                   | *Solution:* Call you support center to get a    |
|                                   | GRW license.                                    |
+-----------------------------------+-------------------------------------------------+
| [-6138]{#-6138}                   | **GRW licenses are not accepted by this         |
|                                   | product.\**                                     |
|                                   | *Description:* This product does not accept GRW |
|                                   | licenses.\                                      |
|                                   | *Solution:* Call you support center to check if |
|                                   | the license corresponds to the product.         |
+-----------------------------------+-------------------------------------------------+
| [-6140]{#-6140}                   | **Version *version-number* \**                  |
|                                   | *Description:* This is an information message.  |
+-----------------------------------+-------------------------------------------------+
| [-6142]{#-6142}                   | **Try and buy demonstration time expired.       |
|                                   | Please, restart your application.**\            |
|                                   | *Description:* Applications started with a Try  |
|                                   | and Buy version will stop after few minutes of  |
|                                   | execution.\                                     |
|                                   | *Solution:* Restart your application.           |
+-----------------------------------+-------------------------------------------------+
| [-6143]{#-6143}                   | **This license requires a valid maintenance     |
|                                   | key. Check your environment (run                |
|                                   | \'fglWrt/greWrt -a info\')**\                   |
|                                   | *Description:* Genero 2.20 and higher require a |
|                                   | valid maintenance key.\                         |
|                                   | *Solution:* Update your maintenance key.        |
+-----------------------------------+-------------------------------------------------+
| [-6144]{#-6144}                   | **The DVM build date is greater than the        |
|                                   | maintenance key expiration date. Contact your   |
|                                   | nearest FourJ\'s sales representative to update |
|                                   | the maintenance key.**\                         |
|                                   | *Solution:* Update your maintenance key or      |
|                                   | downgrade your Genero installation to an older  |
|                                   | version.                                        |
+-----------------------------------+-------------------------------------------------+
| [-6148]{#-6148}                   | **Installation path is not known.**\            |
|                                   | *Description:* You are handling licenses but    |
|                                   | the FGLDIR environment variable is not set.\    |
|                                   | *Solution:* Set the FGLDIR environment variable |
|                                   | and retry.                                      |
+-----------------------------------+-------------------------------------------------+
| [-6149]{#-6149}                   | **Problem while installing license              |
|                                   | \'*license-number*\'.**\                        |
|                                   | *Description:* A problem occurred while         |
|                                   | licensing.\                                     |
|                                   | *Solution:* Note the system-specific error      |
|                                   | number and contact your Technical Support.      |
+-----------------------------------+-------------------------------------------------+
| [-6150]{#-6150}                   | **Temporary license not found for this          |
|                                   | version.**\                                     |
|                                   | *Description:* While adding a definitive        |
|                                   | license key, the temporary license has not been |
|                                   | found.\                                         |
|                                   | *Solution:* Re-install the license.             |
+-----------------------------------+-------------------------------------------------+
| [-6151]{#-6151}                   | **Wrong installation key.**\                    |
|                                   | *Description:* While adding a definitive        |
|                                   | license key, the installation key was not       |
|                                   | valid.\                                         |
|                                   | *Solution:* Re-install the license.             |
+-----------------------------------+-------------------------------------------------+
| [-6152]{#-6152}                   | **Problem during license installation.**\       |
|                                   | *Description:* A problem occurred while         |
|                                   | installing the license. Could not write         |
|                                   | information to the disk (either own files or    |
|                                   | system files).\                                 |
|                                   | *Solution:* Check the FGLDIR environment        |
|                                   | variable and the rights of the license files    |
|                                   | (must be able to change them).                  |
+-----------------------------------+-------------------------------------------------+
| [-6153]{#-6153}                   | **License installation failed.**                |
+-----------------------------------+-------------------------------------------------+
| [-6154]{#-6154}                   | **License installation successful.** \          |
|                                   | *Description:* This is an information message.  |
+-----------------------------------+-------------------------------------------------+
| [-6156]{#-6156}                   | **Too many temporary licenses. You must         |
|                                   | reinstall a license.**\                         |
|                                   | *Description:* You installed a temporary        |
|                                   | license too many times.\                        |
|                                   | *Solution:* Contact technical support to get a  |
|                                   | valid license.                                  |
+-----------------------------------+-------------------------------------------------+
| [-6158]{#-6158}                   | **Cannot store temporary information.**\        |
|                                   | *Description:* A problem occurred while         |
|                                   | installing the license. Could not write         |
|                                   | information to the disk (either own files or    |
|                                   | system files).\                                 |
|                                   | *Solution:* Check the FGLDIR environment        |
|                                   | variable and the rights of the license files    |
|                                   | (you must be able to change them).              |
+-----------------------------------+-------------------------------------------------+
| [-6159]{#-6159}                   | **This kind of license is not permitted.**      |
+-----------------------------------+-------------------------------------------------+
| [-6160]{#-6160}                   | **You do not have the permissions to be         |
|                                   | connected.**                                    |
+-----------------------------------+-------------------------------------------------+
| [-6161]{#-6161}                   | **You do not have the permissions to compile.** |
+-----------------------------------+-------------------------------------------------+
| [-6162]{#-6162}                   | **Cannot reach the license server. Please check |
|                                   | if \'flm.server\' is correctly initialized.     |
|                                   | (\'flmprg -a info up\' command should answer    |
|                                   | \'ok\'). The license server is running but no   |
|                                   | autocheck will be done.**                       |
+-----------------------------------+-------------------------------------------------+
| [-6168]{#-6168}                   | **Cannot get information from directory         |
|                                   | \'*directory-name*\'.**                         |
+-----------------------------------+-------------------------------------------------+
| [-6170]{#-6170}                   | **Old request format to license server          |
|                                   | detected. You must install a license program    |
|                                   | version 2.99 or higher.**                       |
+-----------------------------------+-------------------------------------------------+
| [-6171]{#-6171}                   | **A license has been installed temporarily.     |
|                                   | Only the installation key is required. You must |
|                                   | run \'fglWrt -k \<installation-key\>\' to       |
|                                   | install it.**                                   |
+-----------------------------------+-------------------------------------------------+
| [-6172]{#-6172}                   | **Bad parameter: \'*parameter*\' hasn\'t the    |
|                                   | right format.**                                 |
+-----------------------------------+-------------------------------------------------+
| [-6173]{#-6173}                   | **Invalid license number or invalid license     |
|                                   | key.**                                          |
+-----------------------------------+-------------------------------------------------+
| [-6174]{#-6174}                   | **This option is only available for a local     |
|                                   | license. And resource \'flm.server\' was found  |
|                                   | in your configuration.**                        |
+-----------------------------------+-------------------------------------------------+
| [-6175]{#-6175}                   | **License number \'*license-number*\' is        |
|                                   | invalid.**                                      |
+-----------------------------------+-------------------------------------------------+
| [-6176]{#-6176}                   | **In license server, following problem occurs   |
|                                   | with license number \'*license-number*\':       |
|                                   | *problem-description***                         |
+-----------------------------------+-------------------------------------------------+
| [-6177]{#-6177}                   | **Following problem occurs with license number  |
|                                   | \'*license-number*\': *problem-description***   |
+-----------------------------------+-------------------------------------------------+
| [-6178]{#-6178}                   | **Your machine is not allowed to be connected   |
|                                   | on any of your authorized licenses.**           |
+-----------------------------------+-------------------------------------------------+
| [-6179]{#-6179}                   | **License validity time is reached. The users   |
|                                   | control is reactivated.**                       |
+-----------------------------------+-------------------------------------------------+
| [-6180]{#-6180}                   | **CPU limit exceeded. The users control is      |
|                                   | reactivated.**                                  |
+-----------------------------------+-------------------------------------------------+
| [-6181]{#-6181}                   | **Cannot get license extension information.     |
|                                   | Check your environment, the license (run        |
|                                   | \'fglWrt -a info\') and the fglWrt version      |
|                                   | (\'fglWrt -V\' should give *version-number* or  |
|                                   | higher).**                                      |
+-----------------------------------+-------------------------------------------------+
| [-6182]{#-6182}                   | **Your license has \'*restriction-name*\'       |
|                                   | restriction. You are not allowed to run another |
|                                   | mode.**                                         |
+-----------------------------------+-------------------------------------------------+
| [-6183]{#-6183}                   | **Local license controller (fglWrt) may not be  |
|                                   | compatible with this runner. Check its version  |
|                                   | (\'fglWrt -V\' should give *version-number* or  |
|                                   | higher).**                                      |
+-----------------------------------+-------------------------------------------------+
| [-6184]{#-6184}                   | **You are not authorized to run this version of |
|                                   | runner.**                                       |
+-----------------------------------+-------------------------------------------------+
| [-6185]{#-6185}                   | **Protection file is not compatible with this   |
|                                   | version of the runner. You must reinstall your  |
|                                   | license.**                                      |
+-----------------------------------+-------------------------------------------------+
| [-6186]{#-6186}                   | **Demo version initialization.\**               |
|                                   | *Description.* This is an information message.  |
+-----------------------------------+-------------------------------------------------+
| [-6188]{#-6188}                   | **Your evaluation license period has expired.   |
|                                   | Contact your support center.\**                 |
|                                   | *Description:* The software you are using has   |
|                                   | been installed with a demo license that has     |
|                                   | expired.\                                       |
|                                   | *Solution.* Contact your software vendor to     |
|                                   | extend the evaluation period or purchase a      |
|                                   | permanent license.                              |
+-----------------------------------+-------------------------------------------------+
| [-6196]{#-6196}                   | **You are not authorized to delete sessions     |
|                                   | from the license server \'*server-name*\'.**    |
+-----------------------------------+-------------------------------------------------+
| [-6197]{#-6197}                   | **\'*extension-name*\' extension is not allowed |
|                                   | with this license type.**                       |
+-----------------------------------+-------------------------------------------------+
| [-6198]{#-6198}                   | **Product identifier does not correspond to the |
|                                   | license number. **                              |
+-----------------------------------+-------------------------------------------------+
| [-6199]{#-6199}                   | **Cannot create directory \'%s\'. Check         |
|                                   | installation path and verify your access        |
|                                   | rights.**\                                      |
|                                   | *Description:* The specified directory can not  |
|                                   | be created or modified.                         |
+-----------------------------------+-------------------------------------------------+
| [-6200]{#-6200}                   | **Module \'*module-name*\': The function        |
|                                   | *function-signature-1* will be called as        |
|                                   | *function-signature-2*.\**                      |
|                                   | *Description:* An incorrect number of           |
|                                   | parameters are used to call a BDL function.\    |
|                                   | *Solution:* Check your source code and          |
|                                   | recompile your application.                     |
+-----------------------------------+-------------------------------------------------+
| [-6201]{#-6201}                   | **Module \'*module-name*\': Bad version:        |
|                                   | Recompile your sources.\**                      |
|                                   | *Description:* You have compiled your program   |
|                                   | with an old version. The newly compiled version |
|                                   | of your program is not supported.\              |
|                                   | *Solution:* Compile all source files and form   |
|                                   | files again.                                    |
+-----------------------------------+-------------------------------------------------+
| [-6202]{#-6202}                   | **filename \'*file-name*\': Bad magic: Code     |
|                                   | can\'t run with this p code machine.\**         |
|                                   | *Description:* You have compiled your program   |
|                                   | with an old version. The new compiled version   |
|                                   | of your program is not supported. You might     |
|                                   | also have a file with the same name as the      |
|                                   | .42r. You used the fglrun 42r-Name without      |
|                                   | specifying the extension.\                      |
|                                   | *Solution:* To resolve this problem, call       |
|                                   | fglrun with the .42r extension or recompile     |
|                                   | your application.                               |
+-----------------------------------+-------------------------------------------------+
| [-6203]{#-6203}                   | **Module \'*module-name-1*\': The function      |
|                                   | \'*function-name*\' has already been defined in |
|                                   | module \'*module-name-2*\'.\**                  |
|                                   | *Description.* The specified function is        |
|                                   | defined for the second time in the application. |
|                                   | The second occurrence of the function is in the |
|                                   | specified module.\                              |
|                                   | *Solution:* Eliminate one of the two function   |
|                                   | definitions from your source code.              |
+-----------------------------------+-------------------------------------------------+
| [-6204]{#-6204}                   | **Module \'*module-name*\': Unknown opcode.\**  |
|                                   | *Description:* An unknown instruction was found |
|                                   | in the compiled BDL application.\               |
|                                   | *Solution:* Check that the version of the       |
|                                   | Genero Business Development Language package    |
|                                   | executing the compiled application is the same  |
|                                   | as the one that compiled the application. It is |
|                                   | also possible that the compiled module has been |
|                                   | corrupted. If so, you will need to recompile    |
|                                   | your application.                               |
+-----------------------------------+-------------------------------------------------+
| [-6205]{#-6205}                   | **INTERNAL ERROR: Alignment.\**                 |
|                                   | *Description:* This error is internal, which    |
|                                   | should not normally occur.\                     |
|                                   | *Solution:* Contact your Technical Support.     |
+-----------------------------------+-------------------------------------------------+
| [-6206]{#-6206}                   | **The 42m module \'*module-name*\' could not be |
|                                   | loaded, check FGLLDPATH environment             |
|                                   | variable.\**                                    |
|                                   | *Description:* The 42m module is not in the     |
|                                   | current directory or in one of the directories  |
|                                   | specified by the **FGLLDPATH** environment      |
|                                   | variable.\                                      |
|                                   | *Solution:* Set the environment variable        |
|                                   | **FGLLDPATH** with the path to the 42m modules  |
|                                   | to be loaded.                                   |
+-----------------------------------+-------------------------------------------------+
| [-6207]{#-6207}                   | **The dynamic loaded module \'*module-name*\'   |
|                                   | does not contain the function                   |
|                                   | \'*function-name*\'.\**                         |
|                                   | *Description:* A BDL module has been changed    |
|                                   | and recompiled, but the different modules of    |
|                                   | the application have not been linked            |
|                                   | afterward.\                                     |
|                                   | *Solution:* Link the new modules together       |
|                                   | before you execute your application.            |
+-----------------------------------+-------------------------------------------------+
| [-6208]{#-6208}                   | **Module \'*module-name*\' already loaded.\**   |
|                                   | *Description:* A module was loaded twice at     |
|                                   | runtime. This can occur because one module has  |
|                                   | been concatenated with another.\                |
|                                   | *Solution:* Recompile and re-link your BDL      |
|                                   | modules.                                        |
+-----------------------------------+-------------------------------------------------+
| [-6210]{#-6210}                   | **INTERNAL ERROR: exception 2 raised before     |
|                                   | invoking the exception handler for exception    |
|                                   | 1.\**                                           |
|                                   | *Description:* A module was loaded twice at     |
|                                   | runtime. This can occur because one module has  |
|                                   | been concatenated with another.\                |
|                                   | *Solution:* Check for function names, recompile |
|                                   | and re-link your BDL modules.                   |
+-----------------------------------+-------------------------------------------------+
| [-6211]{#-6211}                   | **Link has failed.**\                           |
|                                   | *Description:* A problem occurred while linking |
|                                   | the BDL program.\                               |
|                                   | *Solution.* Check for function names, recompile |
|                                   | and re-link your BDL modules.                   |
+-----------------------------------+-------------------------------------------------+
| [-6212]{#-6212}                   | **Function *function-name*: local variables     |
|                                   | size is too large - Allocation failed.**\       |
|                                   | *Description:* A local function variable is too |
|                                   | large and runtime could not allocate memory.\   |
|                                   | *Solution.* Review the variable data types in   |
|                                   | the function.                                   |
+-----------------------------------+-------------------------------------------------+
| [-6213]{#-6213}                   | **Module *module-name*: Module\'s variable size |
|                                   | is too large - Allocation failed.**\            |
|                                   | *Description:* A module variable is too large   |
|                                   | and runtime could not allocate memory.\         |
|                                   | *Solution.* Review the variable data types in   |
|                                   | the module.                                     |
+-----------------------------------+-------------------------------------------------+
| [-6214]{#-6214}                   | **Global variable *variable-name* size is too   |
|                                   | large - Allocation failed.**\                   |
|                                   | *Description:* A global variable is too large   |
|                                   | and runtime could not allocate memory.\         |
|                                   | *Solution.* Review the variable data types in   |
|                                   | the globals.                                    |
+-----------------------------------+-------------------------------------------------+
| [-6215]{#-6215}                   | **Memory allocation failed. Ending program.**\  |
|                                   | *Description:* Runtime could not allocate       |
|                                   | memory.\                                        |
|                                   | *Solution.* Check for system resources and      |
|                                   | verify if the OS user is allowed to allocate as |
|                                   | much memory as the program needs (check for     |
|                                   | **ulimits** on UNIX systems).                   |
+-----------------------------------+-------------------------------------------------+
| [-6216]{#-6216}                   | **The global \'*name*\' has been redefined with |
|                                   | a different constant-value.**\                  |
|                                   | *Description:* A global constant has been       |
|                                   | defined twice with a different value.\          |
|                                   | *Solution:* A global constant may have only one |
|                                   | value.  Review your code. * *                   |
+-----------------------------------+-------------------------------------------------+
| [-6217]{#-6217}                   | **The global \'*name*\' has been defined as a   |
|                                   | constant and a variable.**\                     |
|                                   | *Description:* The same symbol was used to      |
|                                   | define a constant and a variable.\              |
|                                   | *Solution:* Use a different name for the        |
|                                   | constant and the variable. Review your code.    |
+-----------------------------------+-------------------------------------------------+
| [-6218]{#-6218}                   | **No runtime. You must call fgl_start() before  |
|                                   | calling fgl_call().**\                          |
|                                   | *Description:* This error occurs when a C       |
|                                   | extension has re-defined the main() routine,    |
|                                   | but then does not call fgl_start() to           |
|                                   | initialize the BDL runtime environment.\        |
|                                   | *Solution:* Check the C extension and call      |
|                                   | fgl_start() before any other operation.         |
+-----------------------------------+-------------------------------------------------+
| [-6219]{#-6219}                   | **WHENEVER ERROR CALL: The error-handler        |
|                                   | recursively calls itself.\**                    |
|                                   | *Description:* The exception handler calls a    |
|                                   | function which in turn calls itself             |
|                                   | recursively.\                                   |
|                                   | *Solution:* Review the function called by the   |
|                                   | exception handler.                              |
+-----------------------------------+-------------------------------------------------+
| [-6220]{#-6220}                   | **Could not load C extension library            |
|                                   | \'*library-name*\'.\\nReason: *reason*\**       |
|                                   | *Description:* Runtime system could not find    |
|                                   | the shared library for the reason given.\       |
|                                   | *Solution:* Check if the C extension library    |
|                                   | exists in one of the directories defined by     |
|                                   | FGLLDPATH. If the C extension module depends    |
|                                   | from other shared libraries, make sure that     |
|                                   | these libraries can be found by the library     |
|                                   | loader of the operating system (check the       |
|                                   | LD_LIBRARY_PATH environment variable on UNIX or |
|                                   | the PATH environment variable on Windows).      |
+-----------------------------------+-------------------------------------------------+
| [-6221]{#-6221}                   | **C extension initialization failed with status |
|                                   | *number*.\**                                    |
|                                   | *Description:* C extension failed to initialize |
|                                   | and returned the status shown in the error      |
|                                   | message.\                                       |
|                                   | *Solution:* Check the C extension source or     |
|                                   | documentation.                                  |
+-----------------------------------+-------------------------------------------------+
| [-6222]{#-6222}                   | ***class-name* class not found.\**              |
|                                   | *Description:* The program was compiled with    |
|                                   | the built-in class *class-name* but at          |
|                                   | execution time the class is not found.\         |
|                                   | *Solution:* Check you installation, it is       |
|                                   | possible that you are executing program that    |
|                                   | was compiled with a younger version as the      |
|                                   | version used in the execution context, which    |
|                                   | certainly is missing that class in the runtime  |
|                                   | library.                                        |
+-----------------------------------+-------------------------------------------------+
| [-6300]{#-6300}                   | **Can not connect to GUI.\**                    |
|                                   | *Description:* You have run a GUI application   |
|                                   | but the environment variable FGLSERVER is not   |
|                                   | set correctly, or the Genero client (graphical  |
|                                   | front-end) is not running.\                     |
|                                   | *Solution:* The FGLSERVER environment variable  |
|                                   | should be set to the hostname and port of the   |
|                                   | graphical front end used by the runtime system  |
|                                   | to display the application windows. Check that  |
|                                   | the network connection is still available, make |
|                                   | sure no firewall denies access to the           |
|                                   | workstation, and see whether the front-end is   |
|                                   | still running.                                  |
+-----------------------------------+-------------------------------------------------+
| [-6301]{#-6301}                   | **Can not write to GUI.\**                      |
|                                   | *Description:* You are running a GUI            |
|                                   | application but for an unknown reason the       |
|                                   | front-end no longer responds and the runtime    |
|                                   | system could not write to the GUI socket.\      |
|                                   | *Solution:* Check that the network connection   |
|                                   | is still available, make sure no firewall       |
|                                   | denies access to the workstation, and see       |
|                                   | whether the front-end is still running.         |
+-----------------------------------+-------------------------------------------------+
| [-6302]{#-6302}                   | **Can not read from GUI.\**                     |
|                                   | *Description:* You are running a GUI            |
|                                   | application but for an unknown reason the       |
|                                   | front-end no longer responds and the runtime    |
|                                   | system could not read from the GUI socket.\     |
|                                   | *Solution:* Check that the network connection   |
|                                   | is still available, make sure no firewall       |
|                                   | denies access to the workstation, and see       |
|                                   | whether the front-end is still running.         |
+-----------------------------------+-------------------------------------------------+
| [-6303]{#-6303}                   | **Invalid user interface protocol.**\           |
|                                   | *Description:* You are trying to execute a      |
|                                   | program with a runtime system that uses a       |
|                                   | different AUI protocol version as the           |
|                                   | front-end.\                                     |
|                                   | *Solution:* Install either a new front-end or a |
|                                   | new runtime environment that matches (2.0x with |
|                                   | 2.0x, 1.3x with 1.3x).                          |
+-----------------------------------+-------------------------------------------------+
| [-6304]{#-6304}                   | **Invalid abstract user interface               |
|                                   | definition.\**                                  |
|                                   | *Description:* You are trying to execute a      |
|                                   | program with a runtime system that uses a       |
|                                   | different AUI protocol version as the           |
|                                   | front-end.\                                     |
|                                   | *Solution:* Install either a new front-end or a |
|                                   | new runtime environment that matches (2.0x with |
|                                   | 2.0x, 1.3x with 1.3x).                          |
+-----------------------------------+-------------------------------------------------+
| [-6305]{#-6305}                   | **Can not open char table file. Check your      |
|                                   | fglprofile.\**                                  |
|                                   | *Description:* This error occurs if the         |
|                                   | conversion file defined by the gui.chartable    |
|                                   | entry, in the \$FGLDIR/etc/fglprofile file, is  |
|                                   | not readable by the current user.\              |
|                                   | *Solution:* Check if the gui.chartable entry is |
|                                   | correctly set and if the specified file is      |
|                                   | readable by the current user.                   |
+-----------------------------------+-------------------------------------------------+
| [-6306]{#-6306}                   | **Can not open server file. Check               |
|                                   | installation.\**                                |
|                                   | *Description:* A file on the server side cannot |
|                                   | be sent to the graphical interface.\            |
|                                   | *Solution:* Check the permissions of the file   |
|                                   | located in the \$FGLDIR/etc directory. These    |
|                                   | files must have at least read permission for    |
|                                   | the current user.                               |
+-----------------------------------+-------------------------------------------------+
| [-6307]{#-6307}                   | **GUI server autostart: can not identify        |
|                                   | workstation.**\                                 |
|                                   | *Description:* GUI Server autostart             |
|                                   | configuration is wrong. Either DISPLAY,         |
|                                   | FGLSERVER or fglprofile settings are invalid.\  |
|                                   | *Solution:* Set the required environment        |
|                                   | variables and check for fglprofile autostart    |
|                                   | entries.                                        |
+-----------------------------------+-------------------------------------------------+
| [-6308]{#-6308}                   | **GUI server autostart: unknown workstation:    |
|                                   | check gui.server.autostart entries.**\          |
|                                   | *Description:* The computer described by the    |
|                                   | X11 DISPLAY environment variable is neither the |
|                                   | local host, nor is it listed in the fglprofile  |
|                                   | entries.\                                       |
|                                   | *Solution:* Check if the X11 DISPLAY name is    |
|                                   | correctly set, or review the fglprofile         |
|                                   | entries.                                        |
+-----------------------------------+-------------------------------------------------+
| [-6309]{#-6309}                   | **Not connected. Cannot write to GUI.**\        |
|                                   | *Description:* For unknown reasons there was an |
|                                   | attempt to write on the GUI socket before the   |
|                                   | connection was initiated.\                      |
|                                   | *Solution:* Check the program for invalid GUI   |
|                                   | operations.                                     |
+-----------------------------------+-------------------------------------------------+
| [-6310]{#-6310}                   | **Not connected. Cannot read from GUI.**\       |
|                                   | *Description:* For unknown reasons there was an |
|                                   | attempt to read on the GUI socket before the    |
|                                   | connection was initiated.\                      |
|                                   | *Solution:* Check the program for invalid GUI   |
|                                   | operations.                                     |
+-----------------------------------+-------------------------------------------------+
| [-6311]{#-6311}                   | **No current window.**\                         |
|                                   | *Description:* The program tries to issue a     |
|                                   | MENU instruction with no current window open.\  |
|                                   | *Solution:* Review the program logic and make   |
|                                   | sure a window is open before MENU.              |
+-----------------------------------+-------------------------------------------------+
| [-6312]{#-6312}                   | **The type of the user interface (FGLGUI) is    |
|                                   | invalid.**\                                     |
|                                   | *Description:* While initiating the user        |
|                                   | interface, the runtime system did not recognize |
|                                   | the GUI type and stopped.\                      |
|                                   | *Solution:* Make sure the FGLGUI environment    |
|                                   | variable has a correct value.                   |
+-----------------------------------+-------------------------------------------------+
| [-6313]{#-6313}                   | **The UserInterface has been destroyed.\**      |
|                                   | *Description:* The error occurs when the        |
|                                   | front-end sends a DestroyEvent event,           |
|                                   | indicating some inconsistency with the starting |
|                                   | program. This can happen, for example, when     |
|                                   | multiple StartMenus are used, or when you try   |
|                                   | to run an MDI child without a parent container, |
|                                   | or when two MDI containers are started with the |
|                                   | same name, etc.\                                |
|                                   | *Solution:* Check for inconsistency and fix it. |
+-----------------------------------+-------------------------------------------------+
| [-6314]{#-6314}                   | **Wrong connection string. Check client         |
|                                   | version.**\                                     |
|                                   | *Description:* While starting the program, the  |
|                                   | runtime received a wrong or incorrectly         |
|                                   | constructed answer from the front-end.\         |
|                                   | *Solution:* Make sure you are using a front-end |
|                                   | that is compatible with the runtime system.     |
+-----------------------------------+-------------------------------------------------+
| [-6315]{#-6315}                   | **The form is too complex for the               |
|                                   | console-ui.**\                                  |
|                                   | *Description:* The program tries to display a   |
|                                   | form with a complex layout that can\'t be       |
|                                   | displayed in text mode.\                        |
|                                   | *Solution:* Review the form file and use a      |
|                                   | simple grid with a SCREEN section instead of    |
|                                   | LAYOUT.                                         |
+-----------------------------------+-------------------------------------------------+
| [-6316]{#-6316}                   | **Error *error-number* returned from client:\\n |
|                                   | *description***\                                |
|                                   | *Description:* Front end returned the specified |
|                                   | error during GUI connection initialization.\    |
|                                   | *Solution:* Check the front-end documentation   |
|                                   | for more details.                               |
+-----------------------------------+-------------------------------------------------+
| [-6317]{#-6317}                   | **Invalid or unsupported client protocol        |
|                                   | feature.**\                                     |
|                                   | *Description:* The GUI protocol feature you are |
|                                   | trying to use is not supported by the           |
|                                   | front-end. For example, you are trying to use   |
|                                   | protocol compression but the runtime is not     |
|                                   | able to compress data.\                         |
|                                   | *Solution:* Make sure that the front-end        |
|                                   | component is compatible with the runtime system |
|                                   | (versions must be close). Check the runtime     |
|                                   | system version for supported protocol features. |
|                                   | If compression is enabled, check that the zlib  |
|                                   | library is installed on your system.            |
+-----------------------------------+-------------------------------------------------+
| [-6318]{#-6318}                   | **Choosing the DIALOG implementation by setting |
|                                   | the environment variable FGL_USENDIALOG=0 has   |
|                                   | been de-supported since version 2.20.03.**\     |
|                                   | *Description:* You try to use the old dialog    |
|                                   | implementation by settting FGL_USENDIALOG to    |
|                                   | zero.\                                          |
|                                   | *Solution:* The old dialog implementation has   |
|                                   | been removed, you must unset the FGL_USENDIALOG |
|                                   | environment variable.                           |
+-----------------------------------+-------------------------------------------------+
| [-6319]{#-6319}                   | **Internal error in the database library. Set   |
|                                   | FGLSQLDEBUG to get more details.**\             |
|                                   | *Description:* An unexpected internal error     |
|                                   | occured in the database driver.\                |
|                                   | *Solution:* Set the FGLSQLDEBUG environment     |
|                                   | variable to level 1, 2, 3 or 4 to get detailed  |
|                                   | debug information.                              |
+-----------------------------------+-------------------------------------------------+
| [-6320]{#-6320}                   | **Can\'t open file \'*file-name*\'.**\          |
|                                   | *Description:* The runtime system tried to open |
|                                   | a resource file in FGLDIR but access is denied  |
|                                   | or file no longer exists.\                      |
|                                   | *Solution:* Check for file permissions and      |
|                                   | existence in FGLDIR.                            |
+-----------------------------------+-------------------------------------------------+
| [-6321]{#-6321}                   | **No such interface capability:                 |
|                                   | \'*feature*\'.**\                               |
|                                   | *Description:* The runtime system tried to use  |
|                                   | a front-end protocol capability, but is not     |
|                                   | able to use it.\                                |
|                                   | *Solution:* Check if the front-end is           |
|                                   | compatible with the runtime system.             |
+-----------------------------------+-------------------------------------------------+
| [-6322]{#-6322}                   | **%s wrong version. Expecting %s.**\            |
|                                   | *Description:* Some resource files of FGLDIR    |
|                                   | have been identified as too old for the current |
|                                   | runtime system. \                               |
|                                   | *Solution:* Re-install the runtime system       |
|                                   | environment.                                    |
+-----------------------------------+-------------------------------------------------+
| [-6323]{#-6323}                   | **Can\'t load factory profile                   |
|                                   | \'*file-name*\'.**\                             |
|                                   | *Description:* The default fglprofile file      |
|                                   | located in FGLDIR/etc is missing or is          |
|                                   | unreadable.\                                    |
|                                   | *Solution:* Check the permission of the file.   |
|                                   | If the file is missing, reinstall the           |
|                                   | software.                                       |
+-----------------------------------+-------------------------------------------------+
| [-6324]{#-6324}                   | **Can\'t load customer profile                  |
|                                   | \'*file-name*\'.**\                             |
|                                   | *Description:* The configuration file defined   |
|                                   | by the FGLPROFILE environment variable is       |
|                                   | missing or unreadable.\                         |
|                                   | *Solution:* Check if the FGLPROFILE environment |
|                                   | variable is correctly set and if the file is    |
|                                   | readable by the current user.                   |
+-----------------------------------+-------------------------------------------------+
| [-6325]{#-6325}                   | **Can\'t load application resources             |
|                                   | \'*file-name*\'.**\                             |
|                                   | *Description:* The directory specified by the   |
|                                   | fglrun.default entry in FGLDIR/etc/fglprofile   |
|                                   | is missing or not readable for the current      |
|                                   | user.\                                          |
|                                   | *Solution:* Check if the entry fglrun.default   |
|                                   | is correctly set in FGLDIR/etc/fglprofile and   |
|                                   | if the directory specified is readable by the   |
|                                   | current user.                                   |
+-----------------------------------+-------------------------------------------------+
| [-6327]{#-6327}                   | **Internal error in the run time library file   |
|                                   | *library-name*.**\                              |
|                                   | *Description:* Something unpredictable has      |
|                                   | occurred, generating an error.\                 |
|                                   | *Solution:* Contact your Technical Support.     |
+-----------------------------------+-------------------------------------------------+
| [-6328]{#-6328}                   | **Bad format of resource \'*name*\' value       |
|                                   | \'*value*\': you must use the syntax :\         |
|                                   | %s=\'VARNAME=value\'.\**                        |
|                                   | *Description:* The FGLPROFILE file contains an  |
|                                   | invalid environment variable definition         |
|                                   | format.\                                        |
|                                   | *Solution:* Check the content of the profile    |
|                                   | file.                                           |
+-----------------------------------+-------------------------------------------------+
| [-6329]{#-6329}                   | **All TABLE columns must be defined with the    |
|                                   | same height.\**                                 |
|                                   | *Description:* The form layout defines a TABLE  |
|                                   | with field tags using different heights.\       |
|                                   | *Solution:* Review all cells of the table to    |
|                                   | use the same height in all columns.             |
+-----------------------------------+-------------------------------------------------+
| [-6330]{#-6330}                   | **Syntax error in profile \'*filename*\', line  |
|                                   | number *lineno*, near \'*token*\'.\**           |
|                                   | *Description:* The FGLPROFILE file shown in the |
|                                   | error message contains a syntax error.\         |
|                                   | *Solution:* Check the content of the profile    |
|                                   | file.                                           |
+-----------------------------------+-------------------------------------------------+
| [-6331]{#-6331}                   | **Front end module could not be loaded.\**      |
|                                   | *Description:* A front end call failed because  |
|                                   | the module does not exist.\                     |
|                                   | *Solution:* The front end is probably not       |
|                                   | supporting this module.                         |
+-----------------------------------+-------------------------------------------------+
| [-6332]{#-6332}                   | **Front end function could not be found.\**     |
|                                   | *Description:* A front end call failed because  |
|                                   | the function does not exist.\                   |
|                                   | *Solution:* The front end is probably not       |
|                                   | supporting this function.                       |
+-----------------------------------+-------------------------------------------------+
| [-6333]{#-6333}                   | **Front end function call failed.\**            |
|                                   | *Description:* A front end call failed for an   |
|                                   | unknown reason.\                                |
|                                   | *Solution:* Call the support and report the     |
|                                   | problem.                                        |
+-----------------------------------+-------------------------------------------------+
| [-6334]{#-6334}                   | **Front end function call stack problem.\**     |
|                                   | *Description:* A front end call failed because  |
|                                   | the number of parameter or returning values     |
|                                   | does not match.\                                |
|                                   | *Solution:* Make sure the number of parameters  |
|                                   | and return values are correct.                  |
+-----------------------------------+-------------------------------------------------+
| [-6340]{#-6340}                   | **Can\'t open file.\**                          |
|                                   | *Description:* The channel object failed to     |
|                                   | open the file specified.\                       |
|                                   | *Solution:* Make sure the filename is correct   |
|                                   | and user has permissions to read/write to the   |
|                                   | file.                                           |
+-----------------------------------+-------------------------------------------------+
| [-6341]{#-6341}                   | **Unsupported mode for \'open file\'.\**        |
|                                   | *Description:* You try to open a channel with   |
|                                   | an unsupported mode.\                           |
|                                   | *Solution:* See channel documentation for       |
|                                   | supported modes.                                |
+-----------------------------------+-------------------------------------------------+
| [-6342]{#-6342}                   | **Can\'t open pipe.\**                          |
|                                   | *Description:* The channel object failed to     |
|                                   | open a pipe to execute the command.\            |
|                                   | *Solution:* Make sure the command you try to    |
|                                   | execute is valid.                               |
+-----------------------------------+-------------------------------------------------+
| [-6343]{#-6343}                   | **Unsupported mode for \'open pipe\'.\**        |
|                                   | *Description:* You try to open a channel with   |
|                                   | an unsupported mode.\                           |
|                                   | *Solution:* See channel documentation for       |
|                                   | supported modes.                                |
+-----------------------------------+-------------------------------------------------+
| [-6344]{#-6344}                   | **Can\'t write to unopened file, pipe or        |
|                                   | socket.\**                                      |
|                                   | *Description:* You try to write to a channel    |
|                                   | object which is not open.\                      |
|                                   | *Solution:* First open the channel, then write. |
+-----------------------------------+-------------------------------------------------+
| [-6345]{#-6345}                   | **Channel write error.\**                       |
|                                   | *Description:* An unexpected error occurred     |
|                                   | while writing to the channel.\                  |
|                                   | *Solution:* See system error message for more   |
|                                   | details.                                        |
+-----------------------------------+-------------------------------------------------+
| [-6346]{#-6346}                   | **Cannot read from unopened file, pipe or       |
|                                   | socket.\**                                      |
|                                   | *Description:* You try to read from a channel   |
|                                   | object which is not open.\                      |
|                                   | *Solution:* First open the channel, then read.  |
+-----------------------------------+-------------------------------------------------+
| [-6360]{#-6360}                   | **This runner can\'t execute any SQL.\**        |
|                                   | *Description:* The runtime system is not ready  |
|                                   | for database connections.\                      |
|                                   | *Solution:* Check the configuration of BDL.     |
+-----------------------------------+-------------------------------------------------+
| [-6361]{#-6361}                   | **Dynamic SQL: type unknown: *typename*.\**     |
|                                   | *Description:* The database driver does not     |
|                                   | support this SQL data type.\                    |
|                                   | *Solution:* You cannot use this SQL data type,  |
|                                   | review the code.                                |
+-----------------------------------+-------------------------------------------------+
| [-6364]{#-6364}                   | **Cannot connect to sql back end.\**            |
|                                   | *Description:* The runtime system could not     |
|                                   | initialize the database driver to establish a   |
|                                   | database connection.\                           |
|                                   | *Solution:* Make sure the database driver       |
|                                   | exists.                                         |
+-----------------------------------+-------------------------------------------------+
| [-6365]{#-6365}                   | **Database driver not connected yet.\**         |
|                                   | *Description:* There is an attempt to execute   |
|                                   | an SQL statement, but no database connect is    |
|                                   | established.\                                   |
|                                   | *Solution:* First connect, then execute SQL     |
|                                   | statements.                                     |
+-----------------------------------+-------------------------------------------------+
| [-6366]{#-6366}                   | **Could not load database driver                |
|                                   | *driver-name*.\**                               |
|                                   | *Description:* The runtime system failed to     |
|                                   | load the specified database driver. The         |
|                                   | database driver shared object (.so or .DLL) or  |
|                                   | a dependent library could not be found.\        |
|                                   | *Solution:*  Make sure that the specified       |
|                                   | driver name does not have a spelling mistake.   |
|                                   | If the driver name is correct, there is         |
|                                   | probably an environment problem. Make sure the  |
|                                   | [database client software is                    |
|                                   | installed](Installation.html#INST_SR_DBCLIENT). |
|                                   | Check the UNIX LD_LIBRARY_PATH environment      |
|                                   | variable or the PATH variable on Windows. These |
|                                   | must point to the database client libraries.    |
+-----------------------------------+-------------------------------------------------+
| [-6367]{#-6367}                   | **Incompatible database driver interface.\**    |
|                                   | *Description:* The database driver interface    |
|                                   | does not match the interface expected by the    |
|                                   | runtime system. This can occur if you copy an   |
|                                   | old database driver into a younger FGLDIR       |
|                                   | installation. \                                 |
|                                   | *Solution:* Call the support to get a valid     |
|                                   | database driver.                                |
+-----------------------------------+-------------------------------------------------+
| [-6368]{#-6368}                   | **SQL driver initialization function failed.\** |
|                                   | *Description:* The runtime system failed to     |
|                                   | initialize the database driver, program must    |
|                                   | stop because no database connection can be      |
|                                   | established.\                                   |
|                                   | *Solution:* There is probably an environment    |
|                                   | problem (for example, INFORMIXDIR or            |
|                                   | ORACLE_HOME is not set). Check your environment |
|                                   | and try to connect with a database vendor tool  |
|                                   | (dbaccess, sqlplus) to identify the problem.    |
+-----------------------------------+-------------------------------------------------+
| [-6369]{#-6369}                   | **Invalid database connection mode.\**          |
|                                   | *Description:* You try to mix DATABASE and      |
|                                   | CONNECT statements, but this is not allowed.\   |
|                                   | *Solution:* Use either DATABASE or CONNECT.     |
+-----------------------------------+-------------------------------------------------+
| [-6370]{#-6370}                   | **Unsupported SQL feature.\**                   |
|                                   | *Description:* This SQL command or statement is |
|                                   | not supported with the current database         |
|                                   | driver.\                                        |
|                                   | *Solution:* Review the code and use a standard  |
|                                   | SQL feature instead.                            |
+-----------------------------------+-------------------------------------------------+
| [-6371]{#-6371}                   | **SQL statement error number %d (%d).\**        |
|                                   | *Description:* An SQL error has occurred having |
|                                   | the specified error number.\                    |
|                                   | *Solution:* You can query SQLERRMESSAGE or the  |
|                                   | SQLCA record to get a description of the error. |
+-----------------------------------+-------------------------------------------------+
| [-6372]{#-6372}                   | **General SQL error, check                      |
|                                   | SQLCA.SQLERRD\[2\].\**                          |
|                                   | *Description:*** ** A general SQL error has     |
|                                   | occurred.\                                      |
|                                   | *Solution:* You can query SQLERRMESSAGE or the  |
|                                   | SQLCA record to get a description of the error. |
|                                   | The native SQL error code is in                 |
|                                   | SQLCA.SQLERRD\[2\].                             |
+-----------------------------------+-------------------------------------------------+
| [-6373]{#-6373}                   | **Invalid database connection string.\**        |
|                                   | *Description:* The database connection string   |
|                                   | that you have used is not valid.\               |
|                                   | *Solution:* Verify the format of the connection |
|                                   | string.                                         |
+-----------------------------------+-------------------------------------------------+
| [-6374]{#-6374}                   | **Wrong database driver context.\**             |
|                                   | *Description:* You try to EXECUTE, OPEN, FETCH, |
|                                   | PUT, FLUSH, CLOSE or FREE a cursor that was     |
|                                   | declared or prepared in a different connect and |
|                                   | driver.\                                        |
|                                   | *Solution:* Issue a SET CONNECTION before the   |
|                                   | statement to select the same connection and     |
|                                   | driver as when the cursor was created.          |
+-----------------------------------+-------------------------------------------------+
| [-6375]{#-6375}                   | **LOAD cannot get describe information for      |
|                                   | table columns.\**                               |
|                                   | *Description:* The LOAD instructions needs      |
|                                   | column description to allocate the automatic    |
|                                   | fetch buffers, but the database driver is not   |
|                                   | able to describe the table columns used in the  |
|                                   | INSERT statement.\                              |
|                                   | *Solution:* If the underlying database client   |
|                                   | API does not provide result set column          |
|                                   | description, the LOAD statement cannot be       |
|                                   | supported.                                      |
+-----------------------------------+-------------------------------------------------+
| [-6601]{#-6601}                   | **Can not open Database dictionary \'*name\'*.  |
|                                   | Run database schema extraction tool.\**         |
|                                   | *Description:* The schema file does not exist   |
|                                   | or cannot be found.\                            |
|                                   | *Solution:* If the schema file exists, verify   |
|                                   | that the filename is spelled correctly, and     |
|                                   | that the file is in the current directory or    |
|                                   | the FGLDBPATH environment variable is set to    |
|                                   | the correct path.  If the file does not exist,  |
|                                   | run the database schema extraction tool to      |
|                                   | create a schema file.                           |
+-----------------------------------+-------------------------------------------------+
| [-6602]{#-6602}                   | **Can not open globals file \'*name*\'.\**      |
|                                   | *Description:* The globals file does not exist  |
|                                   | or cannot be found.\                            |
|                                   | *Solution:* Verify that the globals file        |
|                                   | exists. Check the spelling of the filename, and |
|                                   | verify that the path is set correctly.          |
+-----------------------------------+-------------------------------------------------+
| [-6603]{#-6603}                   | **The file \'*name*\' cannot be created for     |
|                                   | writing.\**                                     |
|                                   | *Description:* The compiler failed to create    |
|                                   | the file shown in the error message for         |
|                                   | writing.\                                       |
|                                   | *Solution:* Check for user permissions to make  |
|                                   | sure that the **.42m** file can be created.     |
+-----------------------------------+-------------------------------------------------+
| [-6604]{#-6604}                   | **The function \'*function-name*\' can only be  |
|                                   | used within an INPUT \[ARRAY\], DISPLAY ARRAY   |
|                                   | or CONSTRUCT statement.\**                      |
|                                   | *Description:*  The language provides built-in  |
|                                   | functions that can only be used within specific |
|                                   | interactive statements.\                        |
|                                   | *Solution:* Review your code and make the       |
|                                   | necessary corrections.Check that the function   |
|                                   | is within the interactive statement and that    |
|                                   | appropriate END statements (END                 |
|                                   | INPUT/ARRAY/DISPLAY ARRAY/CONSTRUCT)  have been |
|                                   | used.                                           |
+-----------------------------------+-------------------------------------------------+
| [-6605]{#-6605}                   | **The module \'*name*\' does not contain        |
|                                   | function \'*function-name*\'.\**                |
|                                   | *Description.* The module shown in the error    |
|                                   | message does not hold the function name as      |
|                                   | expected.\                                      |
|                                   | *Solution:* The specified function needs to be  |
|                                   | defined in this module.                         |
+-----------------------------------+-------------------------------------------------+
| [-6606]{#-6606}                   | **No member function \'*name*\' for class       |
|                                   | \'*class-name*\' defined.** *\                  |
|                                   | Description.* The function name is misspelled   |
|                                   | or is not a method of the class for which it is |
|                                   | called. **\**                                   |
|                                   | *Solution:* Review your code and the            |
|                                   | documentation for the method you are attempting |
|                                   | to use. If the function is an object method,    |
|                                   | make sure the referenced object in your code is |
|                                   | of the correct class.                           |
+-----------------------------------+-------------------------------------------------+
| [-6608]{#-6608}                   | **Resource error:%s:parameter expected\**       |
|                                   | *Description.* This is a generic error message  |
|                                   | for resource file problems.                     |
+-----------------------------------+-------------------------------------------------+
| [-6609]{#-6609}                   | **A grammatical error has been found at \'%s\'  |
|                                   | expecting: %s.\**                               |
|                                   | *Description:*  A general syntax error message  |
|                                   | that indicates the location of the problem code |
|                                   | and what code was expected. \                   |
|                                   | *Solution:*  Review your code, particularly for |
|                                   | missing END statements such as END FUNCTION or  |
|                                   | END INPUT, etc.,  and make the necessary        |
|                                   | corrections.                                    |
+-----------------------------------+-------------------------------------------------+
| [-6610]{#-6610}                   | **The function \'*name*\' has already been      |
|                                   | called with a different number of               |
|                                   | parameters.\**                                  |
|                                   | *Description:* Earlier in the program, there is |
|                                   | a call to this same function or event with a    |
|                                   | different number of parameters in the parameter |
|                                   | list.\                                          |
|                                   | *Solution:* Check the correct number of         |
|                                   | parameters for the specified function. Then     |
|                                   | examine all calls to it, and make sure that     |
|                                   | they are written correctly.                     |
+-----------------------------------+-------------------------------------------------+
| [-6611]{#-6611}                   | **Function \'*name*\': unexpected number of     |
|                                   | returned values.\**                             |
|                                   | *Description:* The function shown returned a    |
|                                   | different number of values as expected.\        |
|                                   | *Solution:* Check the body of the function for  |
|                                   | RETURN instructions.                            |
+-----------------------------------+-------------------------------------------------+
| [-6612]{#-6612}                   | **Redeclaration of function \'*name*\'.\**      |
|                                   | *Description:* The function shown was defined   |
|                                   | multiple times.\                                |
|                                   | *Solution:* Change the name of conflicting      |
|                                   | functions.                                      |
+-----------------------------------+-------------------------------------------------+
| [-6613]{#-6613}                   | **The library function \'*name*\' is not        |
|                                   | declared.\**                                    |
|                                   | *Description:* The function shown was not       |
|                                   | declared.\                                      |
|                                   | *Solution:* Change the name of the function.    |
+-----------------------------------+-------------------------------------------------+
| [-6614]{#-6614}                   | **The function \'*name*\' may return a          |
|                                   | different number of values.\**                  |
|                                   | *Description:* The function shown contains      |
|                                   | multiple RETURN instructions which may return   |
|                                   | different number of values.\                    |
|                                   | *Solution:* Review the RETURN instructions to   |
|                                   | return the same number of values.               |
+-----------------------------------+-------------------------------------------------+
| [-6615]{#-6615}                   | **The symbol \'*name*\' is unused.\**           |
|                                   | *Description:* This is a warning indicating     |
|                                   | that the shown symbol is defined but never      |
|                                   | used.\                                          |
|                                   | *Solution:* Useless definition can be removed.  |
+-----------------------------------+-------------------------------------------------+
| [-6616]{#-6616}                   | **The symbol \'*name*\' does not represent a    |
|                                   | defined CONSTANT.\**                            |
|                                   | *Description:* The shown symbol is used as a    |
|                                   | CONSTANT, but it is not a constant.\            |
|                                   | *Solution:* Review your code and check for this |
|                                   | name.                                           |
+-----------------------------------+-------------------------------------------------+
| [-6617]{#-6617}                   | **The symbol \'*name*\' is a VARIABLE.\**       |
|                                   | *Description:* The symbol shown is a VARIABLE   |
|                                   | which cannot be used in the current context.\   |
|                                   | *Solution:* Review your code and check for this |
|                                   | name.                                           |
+-----------------------------------+-------------------------------------------------+
| [-6618]{#-6618}                   | **The symbol \'*name*\' is a CONSTANT.\**       |
|                                   | *Description:* The symbol shown is a CONSTANT   |
|                                   | which cannot be used in the current context.\   |
|                                   | *Solution:* Review your code and check for this |
|                                   | name.                                           |
+-----------------------------------+-------------------------------------------------+
| [-6619]{#-6619}                   | **The symbol \'*name*\' is not an INTEGER       |
|                                   | CONSTANT.\**                                    |
|                                   | *Description:* The symbol shown is used as if   |
|                                   | it was an INTEGER constant, but it is not.\     |
|                                   | *Solution:* Review your code and check for this |
|                                   | name.                                           |
+-----------------------------------+-------------------------------------------------+
| [-6620]{#-6620}                   | **The symbol \'*name*\' is not a REPORT.\**     |
|                                   | *Description:* The symbol shown is used as a    |
|                                   | REPORT, but it is not defined as a REPORT.\     |
|                                   | *Solution:* Review your code and check for this |
|                                   | name.                                           |
+-----------------------------------+-------------------------------------------------+
| [-6621]{#-6621}                   | **The symbol \'*name*\' is not a FUNCTION.\**   |
|                                   | *Description:* The symbol shown is used as a    |
|                                   | FUNCTION, but it is not defined as FUNCTION.\   |
|                                   | *Solution:* Review your code and check for this |
|                                   | name.                                           |
+-----------------------------------+-------------------------------------------------+
| [-6622]{#-6622}                   | **The symbol \'*name*\' does not represent a    |
|                                   | valid variable type.\**                         |
|                                   | *Description:* The symbol shown does not .\     |
|                                   | *Solution:* Review your code and check for this |
|                                   | name.                                           |
+-----------------------------------+-------------------------------------------------+
| [-6623]{#-6623}                   | **The method \'*method-name*\' can\'t be called |
|                                   | without an object.**\                           |
|                                   | *Description:* The specified method is an       |
|                                   | object method of its class.\                    |
|                                   | *Solution:* Review your code. Ensure that the   |
|                                   | required object of the class has been           |
|                                   | instantiated and still exists, and that the     |
|                                   | method is called specifying the object variable |
|                                   | as the prefix, with the period character as a   |
|                                   | separator.                                      |
+-----------------------------------+-------------------------------------------------+
| [-6624]{#-6624}                   | **The method \'*method-name*\' can\'t be called |
|                                   | with an object.\**                              |
|                                   | *Description:* The specified method is a class  |
|                                   | method and cannot be called using an object     |
|                                   | reference. No object has to be created.\        |
|                                   | *Solution:* Review your code. Ensure that the   |
|                                   | method is called using the class name as the    |
|                                   | prefix, with the period character as a          |
|                                   | separator.                                      |
+-----------------------------------+-------------------------------------------------+
| [-6625]{#-6625}                   | **The statement is not Informix compatible.\**  |
|                                   | *Description:* The SQL statement is not         |
|                                   | Informix compatible.\                           |
|                                   | *Solution:* Change the SQL statement by using   |
|                                   | Informix SQL syntax.                            |
+-----------------------------------+-------------------------------------------------+
| [-6627]{#-6627}                   | **The symbol \'*name*\' is not a VARIABLE.\**   |
|                                   | *Description:* The symbol shown is use as a     |
|                                   | variable, but is not defined as a variable.\    |
|                                   | *Solution:* Review your code and check for this |
|                                   | name.                                           |
+-----------------------------------+-------------------------------------------------+
| [-6628]{#-6628}                   | **The GLOBALS file does not contain a GLOBALS   |
|                                   | section.**\                                     |
|                                   | *Description:* The filename specified in a      |
|                                   | GLOBALS statement references a file that does   |
|                                   | not contain a GLOBALS section.\                 |
|                                   | *Solution:* Review your code to make sure that  |
|                                   | the file specified by the filename is a valid   |
|                                   | GLOBALS file, containing the required GLOBALS   |
|                                   | section.                                        |
+-----------------------------------+-------------------------------------------------+
| [-6629]{#-6629}                   | **The type \'type-name\' is too complex to be   |
|                                   | used within a C-extension.**\                   |
|                                   | *Description:* The type of the global variable  |
|                                   | is too complex to be used in a C extension.     |
|                                   | This error can occur when the -G option of      |
|                                   | fglcomp, to generate the C sources to share     |
|                                   | global variables with C extensions, when a      |
|                                   | global variable is defined with complex data    |
|                                   | types without a C equivalent.\                  |
|                                   | *Solution:* Review the definition of the global |
|                                   | variables and use simple types instead,         |
|                                   | corresponding to a C data type. The BYTE, TEXT  |
|                                   | and STRING types are complex types.             |
+-----------------------------------+-------------------------------------------------+
| [-6630]{#-6630}                   | **Memory overflow occurred during p-code        |
|                                   | generation. Simplify the module.**\             |
|                                   | *Description:* A memory overflow occurred       |
|                                   | during compilation to p-code because the 4gl    |
|                                   | source module is too large.\                    |
|                                   | *Solution:* This problem can occur with very    |
|                                   | large source files. You must split the module   |
|                                   | into multiple sources.                          |
+-----------------------------------+-------------------------------------------------+
| [-6631]{#-6631}                   | **incompatible types, found: %s, required:      |
|                                   | %s.**                                           |
+-----------------------------------+-------------------------------------------------+
| [-6632]{#-6632}                   | **cannot find symbol %s, location: %s %s.**     |
+-----------------------------------+-------------------------------------------------+
| [-6633]{#-6633}                   | **%s cannot be dereferenced.**                  |
+-----------------------------------+-------------------------------------------------+
| [-6634]{#-6634}                   | **Incompatible or corrupted database dictionary |
|                                   | \'database-name\'.**\                           |
|                                   | *Description:* The .sch database schema         |
|                                   | \'database-name\' contains incompatible type    |
|                                   | definitions or is corrupted.\                   |
|                                   | *Solution:* Re-generate the .sch file with the  |
|                                   | fgldbsch tool by using the correct command line |
|                                   | options to generate compatible types.           |
+-----------------------------------+-------------------------------------------------+
| [-6773]{#-6773}                   | **The license \'%s\' requires a full            |
|                                   | installation.**\                                |
|                                   | *Description:* Licenses with \'Strict           |
|                                   | licensing\' option require a complete (full)    |
|                                   | install.\                                       |
+-----------------------------------+-------------------------------------------------+
| [-6774]{#-6774}                   | **The license \'%s\' is no more valid. Please   |
|                                   | contact your vendor.**\                         |
|                                   | *Description:* The license number is no longer  |
|                                   | valid.\                                         |
|                                   | *Solution:* Contact your vendor to obtain a new |
|                                   | license number.                                 |
+-----------------------------------+-------------------------------------------------+
| [-6780]{#-6780}                   | **Invalid license request format.\**            |
|                                   | *Description:* The request sent to the license  |
|                                   | manager was not recognized.\                    |
|                                   | *Solution:* Check that the version of the       |
|                                   | license manager is compatible with the runtime  |
|                                   | system.                                         |
+-----------------------------------+-------------------------------------------------+
| [-6781]{#-6781}                   | **Incompatible License Manager (flmprg)         |
|                                   | version. The minimum version required is %s.\** |
|                                   | *Description:* The license manager is too old   |
|                                   | and is not compatible with the current runtime  |
|                                   | system.\                                        |
|                                   | *Solution:* Call the support center to get a    |
|                                   | new version of the license manager.             |
+-----------------------------------+-------------------------------------------------+
| [-6783]{#-6783}                   | **The license number \'%s\' is invalid.\        |
|                                   | Please, contact your vendor.\**                 |
|                                   | *Description:* The license number could not be  |
|                                   | validated by the license server.\               |
|                                   | *Solution:* Call the support center to get a    |
|                                   | new license number.                             |
+-----------------------------------+-------------------------------------------------+
| [-6784]{#-6784}                   | **The license \'%s\' has expired.\              |
|                                   | Please, contact your vendor.\**                 |
|                                   | *Description:* The license is time limited and  |
|                                   | it has expired.\                                |
|                                   | *Solution:* Call the support center to get a    |
|                                   | new license number.                             |
+-----------------------------------+-------------------------------------------------+
| [-6785]{#-6785}                   | **CPU limit exceeded.\                          |
|                                   | Please, contact your vendor.\**                 |
|                                   | *Description:* The license is CPU limited and   |
|                                   | the system has more CPUs as allowed.\           |
|                                   | *Solution:* Call the support center to get a    |
|                                   | new license number.                             |
+-----------------------------------+-------------------------------------------------+
| [-6786]{#-6786}                   | **Report Writer token creation failed.**\       |
|                                   | *Solution:* Check permissions on the lock/token |
|                                   | directory (in FGLDIR or FLMDIR).                |
+-----------------------------------+-------------------------------------------------+
| [-6787]{#-6787}                   | **This GRW license requires a DVM license with  |
|                                   | a valid maintenance date.**\                    |
|                                   | *Description:* GRW licenses with the option     |
|                                   | \'DVM under maintenance\' require that the DVM  |
|                                   | maintenance key expiration date not be          |
|                                   | expired.\                                       |
|                                   | *Solution:* Update the DVM maintenance key.     |
+-----------------------------------+-------------------------------------------------+
| [-6788]{#-6788}                   | **Cannot get GRW report token information.**\   |
|                                   | *Solution:* Contact your support center.        |
+-----------------------------------+-------------------------------------------------+
| [-6802]{#-6802}                   | **Can not open Database dictionary \'*name*\'.  |
|                                   | Run schema extraction tool.**\                  |
|                                   | *Description:* The schema file does not exist   |
|                                   | or cannot be found.\                            |
|                                   | *Solution:* If the schema file exists, verify   |
|                                   | that the filename is spelled correctly, and     |
|                                   | that the file is in the current directory or    |
|                                   | the FGLDBPATH environment variable is set to    |
|                                   | the correct path. If the file does not exist,   |
|                                   | run the database schema extraction tool to      |
|                                   | create a schema file.                           |
+-----------------------------------+-------------------------------------------------+
| [-6803]{#-6803}                   | **A grammatical error has been found at         |
|                                   | \'*line*\', expecting *token*.\**               |
|                                   | *Description:* This is a generic message for    |
|                                   | errors.                                         |
+-----------------------------------+-------------------------------------------------+
| [-6804]{#-6804}                   | **\'*name*\' form compilation was               |
|                                   | successful.\**                                  |
|                                   | *Description:* This is an information message   |
|                                   | indicating that the form was compiled without   |
|                                   | problem.                                        |
+-----------------------------------+-------------------------------------------------+
| [-6805]{#-6805}                   | **Open Form \'*name*\', Bad Version:%s,         |
|                                   | expecting:%s.**\                                |
|                                   | *Description:* You have compiled your form with |
|                                   | a version of the form compiler that is not      |
|                                   | compatible with that used for compiling the     |
|                                   | other source code.\                             |
|                                   | *Solution:* Compile your form file and related  |
|                                   | source code files using the same or compatible  |
|                                   | versions of the compilers.                      |
+-----------------------------------+-------------------------------------------------+
| [-6807]{#-6807}                   | **The label \'*name*\' could not be used as     |
|                                   | column-title.\**                                |
|                                   | *Description:* The form file defines an invalid |
|                                   | TABLE column title.\                            |
|                                   | *Solution:* Check for column titles which are   |
|                                   | not corresponding to column positions.          |
+-----------------------------------+-------------------------------------------------+
| [-6808]{#-6808}                   | **The widget \'*name*\' can not be defined as   |
|                                   | array.\**                                       |
|                                   | *Description:* The form file defines an item    |
|                                   | which is used as a matrix column.\              |
|                                   | *Solution:* Review your form definition.        |
+-----------------------------------+-------------------------------------------------+
| [-6809]{#-6809}                   | **The layout tag \'*name*\' is invalid,         |
|                                   | expecting: *token*.\**                          |
|                                   | *Description:* The form compiler detected an    |
|                                   | invalid layout tag specification.\              |
|                                   | *Solution:* Review your form definition.        |
+-----------------------------------+-------------------------------------------------+
| [-6810]{#-6810}                   | **The attribute \'*attribute*\' is invalid for  |
|                                   | item type \'*name*\'.\**                        |
|                                   | *Description:* The form compiler detected an    |
|                                   | invalid attribute definition for this item      |
|                                   | type.\                                          |
|                                   | *Solution:* Review your form definition and     |
|                                   | check for invalid attributes.                   |
+-----------------------------------+-------------------------------------------------+
| [-6811]{#-6811}                   | **Syntax error near \'%s\', expecting %s.\**    |
|                                   | *Description:* A general syntax error message   |
|                                   | that indicates the location of the problem code |
|                                   | and what code was expected. \                   |
|                                   | *Solution:*  Review your code and make the      |
|                                   | necessary corrections.                          |
+-----------------------------------+-------------------------------------------------+
| [-6812]{#-6812}                   | **Unterminated char constant.\**                |
|                                   | *Description:* The form compiler detected an    |
|                                   | unterminated character constant.\               |
|                                   | *Solution:* Review your form definition and     |
|                                   | check for missing quotes or double-quotes.      |
+-----------------------------------+-------------------------------------------------+
| [-6813]{#-6813}                   | **The element \'*name*\' conflicts with         |
|                                   | group-box \'*name*\'.**\                        |
|                                   | *Description:* You have used the same name for  |
|                                   | an element and for a group-box.\                |
|                                   | *Solution:* Review your form definition and     |
|                                   | ensure that the names used are unique.          |
+-----------------------------------+-------------------------------------------------+
| [-6814]{#-6814}                   | **All members of the SCREEN RECORD \'*name*\'   |
|                                   | must reference the same Table or ScrollGrid.\** |
|                                   | *Description:* The shown screen record          |
|                                   | references multiple tables or scrollgrids in    |
|                                   | your form file.\                                |
|                                   | *Solution:* Review your form definition and use |
|                                   | one unique table for a given screen record.     |
+-----------------------------------+-------------------------------------------------+
| [-6815]{#-6815}                   | **Invalid indentation in between braces.\**     |
|                                   | *Description:* The LAYOUT section of your form  |
|                                   | defines an invalid indentation.\                |
|                                   | *Solution:* Review your form definition and     |
|                                   | check for corresponding indentations.           |
+-----------------------------------+-------------------------------------------------+
| [-6817]{#-6817}                   | **TABLE container defined without a SCREEN      |
|                                   | RECORD in the INSTRUCTION section.\**           |
|                                   | *Description.* The minimum value of the defined |
|                                   | attribute must be lower than the maximum        |
|                                   | value.\                                         |
|                                   | *Solution:* Review your code and make the       |
|                                   | necessary corrections.                          |
+-----------------------------------+-------------------------------------------------+
| [-6818]{#-6818}                   | **Min value must be lower that Max value.\**    |
|                                   | *Description.* The minimum value of the defined |
|                                   | attribute must be lower than the maximum        |
|                                   | value.\                                         |
|                                   | *Solution:* Review your code and make the       |
|                                   | necessary corrections.                          |
+-----------------------------------+-------------------------------------------------+
| [-6819]{#-6819}                   | **Number of elements in the SCREEN RECORD must  |
|                                   | match the number of columns in TABLE            |
|                                   | container.**\                                   |
|                                   | *Description:* The elements defined in the      |
|                                   | screen record differs from the columns used for |
|                                   | the TABLE container.\                           |
|                                   | *Solution:* Review your form definition and add |
|                                   | missing table columns to the screen record,     |
|                                   | order does not matter.                          |
+-----------------------------------+-------------------------------------------------+
| [-6820]{#-6820}                   | **ScrollGrid and/or Group layout tags cannot be |
|                                   | nested.\**                                      |
|                                   | *Description:* The form definition has nested   |
|                                   | ScrollGrid and/or Group layout tags. These tags |
|                                   | cannot be nested.\                              |
|                                   | *Solution:* Review your form definition and     |
|                                   | make the necessary corrections.                 |
+-----------------------------------+-------------------------------------------------+
| [-6821]{#-6821}                   | **HBOX tags cannot be used for ARRAYS.\**       |
|                                   | *Description:* The form definition is using an  |
|                                   | HBOX tag for an array, which is not permitted.\ |
|                                   | *Solution:* Review your form definition and     |
|                                   | make the necessary corrections.                 |
+-----------------------------------+-------------------------------------------------+
| [-6822]{#-6822}                   | **Escaped graphical characters are not accepted |
|                                   | in GRID sections.\**                            |
|                                   | *Description:* You try to use Text User         |
|                                   | Interface graphics in the new GRID container.\  |
|                                   | *Solution:* This is not allowed, use GROUPs     |
|                                   | instead.                                        |
+-----------------------------------+-------------------------------------------------+
| [-6823]{#-6823}                   | **Close tag does not have a matching tag        |
|                                   | above.**\                                       |
|                                   | *Description:* The form definition has a close  |
|                                   | tag without a prior matching open tag. Open     |
|                                   | tags and close tags must match.\                |
|                                   | *Solution:* Review your form definition file    |
|                                   | and make the necessary corrections.             |
+-----------------------------------+-------------------------------------------------+
| [-6824]{#-6824}                   | **The table \'*tablename*\' is empty.**\        |
|                                   | *Description:* The form layout defines a table  |
|                                   | layout tag identified by *tablename*, but       |
|                                   | nothing was found directly under this table     |
|                                   | which could be a column or a column title.\     |
|                                   | *Solution:* Append columns to the table layout  |
|                                   | region.                                         |
+-----------------------------------+-------------------------------------------------+
| [-6825]{#-6825}                   | **The tag \'*tagname*\' overlaps with table     |
|                                   | \'*tablename*\'.**\                             |
|                                   | *Description:* In the form layout, *tagname*    |
|                                   | overlaps the layout region of *tablename* and   |
|                                   | makes it invalid.\                              |
|                                   | *Solution:* Move or remove *tagname*, or        |
|                                   | redefine the layout region of *tablename*.      |
+-----------------------------------+-------------------------------------------------+
| [-6826]{#-6826}                   | **Checked value must be different from          |
|                                   | unchecked value for field \'fieldname\'.**\     |
|                                   | *Description:* The VALUECHECKED and             |
|                                   | VALUEUNCHECKED attributes have the same value.  |
|                                   | This makes no sense because these attributes    |
|                                   | define the values corresponding to the checked  |
|                                   | and unchecked states of a checkbox.\            |
|                                   | *Solution:* Use different values for these      |
|                                   | attributes.                                     |
+-----------------------------------+-------------------------------------------------+
| [-6827]{#-6827}                   | **Duplicated item key found for field           |
|                                   | \'fieldname\'.**\                               |
|                                   | *Description:* The ITEMS attribute of field     |
|                                   | *fieldname* defines item keys with the same     |
|                                   | value.\                                         |
|                                   | *Solution:* Check ITEMS attribute and use       |
|                                   | unique key values. Note that \'\' and NULL are  |
|                                   | equivalent.                                     |
+-----------------------------------+-------------------------------------------------+
| [-6828]{#-6828}                   | **The attribute *attrname* must belong to a     |
|                                   | column of a TABLE.**\                           |
|                                   | *Description:* A form item uses an attribute    |
|                                   | that references a form field which is not       |
|                                   | defined or does not belong to the TABLE.\       |
|                                   | *Solution:* Check the ATTRIBUTES section for    |
|                                   | invalid column references.                      |
+-----------------------------------+-------------------------------------------------+
| [-6829]{#-6829}                   | **The column column-name referenced by the      |
|                                   | attribute-name attribute must belong to the     |
|                                   | TABLE.**\                                       |
|                                   | *Description:* A form item uses an attribute    |
|                                   | that references a form field which is not       |
|                                   | defined or does not belong to the TABLE.\       |
|                                   | *Solution:* Check the ATTRIBUTES section for    |
|                                   | invalid column references.                      |
+-----------------------------------+-------------------------------------------------+
| [-6830]{#-6830}                   | **Not implemented (yet): %s**\                  |
|                                   | *Description:* The feature or syntax you are    |
|                                   | using is not implemented yet.\                  |
|                                   | *Solution:* This feature cannot be used in the  |
|                                   | Genero version you have installed.              |
+-----------------------------------+-------------------------------------------------+
| [-6831]{#-6831}                   | **At least one member of the SCREEN RECORD      |
|                                   | \'name\' must not be a PHANTOM field.**\        |
|                                   | *Description:* A screen record is defined with  |
|                                   | form fields that are all defined as PHANTOM     |
|                                   | fields.\                                        |
|                                   | *Solution:* At least on screen record field     |
|                                   | must not be a PHANTOM field.                    |
+-----------------------------------+-------------------------------------------------+
| [-6832]{#-6832}                   | **Repeated screen tags \'*tagname*\' are        |
|                                   | misaligned, must align on X or Y.**\            |
|                                   | *Description:* The layout defines multiple tags |
|                                   | with the same name, but these are not properly  |
|                                   | aligned in the X or Y direction.\               |
|                                   | *Solution:* Edit the form file and make sure    |
|                                   | that repeated tags are correctly aligned.       |
+-----------------------------------+-------------------------------------------------+
| [-6833]{#-6833}                   | **Invalid TREE definition: the field \'*name*\' |
|                                   | must be an EDIT or LABEL.**\                    |
|                                   | *Description:* The form defines a TREE          |
|                                   | container with the field column defined with a  |
|                                   | wrong item type.\                               |
|                                   | *Solution:* Replace the item type by EDIT or    |
|                                   | LABEL.                                          |
+-----------------------------------+-------------------------------------------------+
| [-6834]{#-6834}                   | **Invalid TREE definition: the field \'*name*\' |
|                                   | must be defined for the SCREEN RECORD.**\       |
|                                   | *Description:* The form defines a TREE          |
|                                   | container with an invalid field set.\           |
|                                   | *Solution:* Check that mandatory fields such as |
|                                   | node name, parent id and node id fields are     |
|                                   | defined.                                        |
+-----------------------------------+-------------------------------------------------+
| [-6835]{#-6835}                   | **The fields specified in the THRU option       |
|                                   | appear in the reverse order.**\                 |
|                                   | *Description:* The form defines a screen record |
|                                   | by using the THRU or THROUGH keyword, but the   |
|                                   | first field is defined after the last field in  |
|                                   | the ATTRIBUTES section.\                        |
|                                   | *Solution:* Exchange the field names specified  |
|                                   | in the screen record definition, or review the  |
|                                   | declaration order in ATTRIBUTES.                |
+-----------------------------------+-------------------------------------------------+
| [-6836]{#-6836}                   | ***item-type*: invalid item type.**\            |
|                                   | *Description:* The .per form defines a form     |
|                                   | item with an invalid item type (the keyword     |
|                                   | before the field tag name).\                    |
|                                   | *Solution:* Review the form definition and use  |
|                                   | a valid item type.                              |
+-----------------------------------+-------------------------------------------------+
| [-6837]{#-6837}                   | ***attribute-name*: invalid attribute name.**\  |
|                                   | *Description:* The .per form defines a form     |
|                                   | item with an invalid attribute.\                |
|                                   | *Solution:* Review the form definition and use  |
|                                   | a valid attribute, following the possible       |
|                                   | attributes allowed for the form item type.      |
+-----------------------------------+-------------------------------------------------+
| [-6838]{#-6838}                   | ***attribute-value*: invalid attribute          |
|                                   | value.**\                                       |
|                                   | *Description:* The .per form defines a form     |
|                                   | item with an invalid attribute value.\          |
|                                   | *Solution:* Review the form definition and use  |
|                                   | one of the allowed values according to the      |
|                                   | attribute definition.                           |
+-----------------------------------+-------------------------------------------------+
| [-6839]{#-6839}                   | **The attribute definition requires a value.**\ |
|                                   | *Description:* The .per form defines a form     |
|                                   | item with an attribute requiring a value, but   |
|                                   | no value is specified.\                         |
|                                   | *Solution:* Review the form definition and      |
|                                   | specify a value for the attribute.              |
+-----------------------------------+-------------------------------------------------+
| [-8000]{#-8000}                   | **Dom: Node not found.\**                       |
|                                   | *Description:* The node could not be found in   |
|                                   | the current document. \                         |
|                                   | *Solution:* Review your code.                   |
+-----------------------------------+-------------------------------------------------+
| [-8001]{#-8001}                   | **Dom: Invalid Document.\**                     |
|                                   | *Description:* The document passed to the DOM   |
|                                   | API is not a valid document.\                   |
|                                   | *Solution:* Review your code.                   |
+-----------------------------------+-------------------------------------------------+
| [-8002]{#-8002}                   | **Dom: Invalid usage of NULL as parameter.\**   |
|                                   | *Description:* NULL cannot be used at this      |
|                                   | place.\                                         |
|                                   | *Solution:* Review your code.                   |
+-----------------------------------+-------------------------------------------------+
| [-8003]{#-8003}                   | **Dom: A node is inserted somewhere it doesn\'t |
|                                   | belong.\**                                      |
|                                   | *Description:* You try to insert a node under a |
|                                   | parent node which does not allow this type of   |
|                                   | nodes.\                                         |
|                                   | *Solution:* Check for the possible nodes and    |
|                                   | review your code.                               |
+-----------------------------------+-------------------------------------------------+
| [-8004]{#-8004}                   | **Sax: Invalid hierarchy.\**                    |
|                                   | *Description:* The SAX handler encountered an   |
|                                   | invalid hierarchy.\                             |
|                                   | *Solution:* Make sure parent/child relations    |
|                                   | are respected.                                  |
+-----------------------------------+-------------------------------------------------+
| [-8005]{#-8005}                   | **Deprecated feature: %s\**                     |
|                                   | *Description:* The feature you are using will   |
|                                   | be removed in a next version.\                  |
|                                   | *Solution:* A replacement for the feature is    |
|                                   | normally available.                             |
+-----------------------------------+-------------------------------------------------+
| [-8006]{#-8006}                   | **The string resource file \'*name*\' cannot be |
|                                   | found.\**                                       |
|                                   | *Description:* The string file shown could not  |
|                                   | be found.\                                      |
|                                   | *Solution:* Check if file exists and if path is |
|                                   | valid.                                          |
+-----------------------------------+-------------------------------------------------+
| [-8007]{#-8007}                   | **The string resource file \'*name*\' cannot be |
|                                   | read.\**                                        |
|                                   | *Description:* The string file shown could not  |
|                                   | be read.\                                       |
|                                   | *Solution:* Check if file exists and if user    |
|                                   | has read permissions.                           |
+-----------------------------------+-------------------------------------------------+
| [-8008]{#-8008}                   | **The string key \'*key*\' has no defined       |
|                                   | value.\**                                       |
|                                   | *Description:* The runtime system could not     |
|                                   | find a string resource corresponding to the     |
|                                   | shown key.\                                     |
|                                   | *Solution:* Check if the key is defined in one  |
|                                   | of the resource files.                          |
+-----------------------------------+-------------------------------------------------+
| [-8009]{#-8009}                   | **String resource syntax error near \'token\',  |
|                                   | expecting token.\**                             |
|                                   | *Description:* The string file compiler         |
|                                   | detected a syntax error.\                       |
|                                   | *Solution:* Check for invalid syntax in the     |
|                                   | **.str** file.                                  |
+-----------------------------------+-------------------------------------------------+
| [-8010]{#-8010}                   | **The included string file \'*name*\' cannot be |
|                                   | found (*filename*:*line*) IGNORE LINE.\**       |
|                                   | *Description:* The string file compiler could   |
|                                   | not find the file to be included.\              |
|                                   | *Solution:* Check file name and path.           |
+-----------------------------------+-------------------------------------------------+
| [-8011]{#-8011}                   | **The included string file \'*name*\' was       |
|                                   | already included (*filename*:*line*) IGNORE     |
|                                   | LINE.\**                                        |
|                                   | *Description:* The string file compiler         |
|                                   | detected that the included file was already     |
|                                   | included.\                                      |
|                                   | *Solution:* Remove the inclusion.               |
+-----------------------------------+-------------------------------------------------+
| [-8012]{#-8012}                   | **Duplicate string key \'*key*\'                |
|                                   | (*filename*:*line*) IGNORE LINE.\**             |
|                                   | *Description:* The string file compiler         |
|                                   | detected duplicated string keys.\               |
|                                   | *Solution:* Review the **.str** file and remove |
|                                   | duplicated keys.                                |
+-----------------------------------+-------------------------------------------------+
| [-8013]{#-8013}                   | **The string file \'*name*\' can not be opened  |
|                                   | for writing.\**                                 |
|                                   | *Description:* The string file compiler could   |
|                                   | not write to the specified string file.\        |
|                                   | *Solution:* Make sure the user has write        |
|                                   | permissions and file name is valid.             |
+-----------------------------------+-------------------------------------------------+
| [-8014]{#-8014}                   | **The string file \'*name*\' can not be         |
|                                   | read.\**                                        |
|                                   | *Description:* The runtime system could not     |
|                                   | read from the specified string file.\           |
|                                   | *Solution:* Make sure the user has read         |
|                                   | permissions.                                    |
+-----------------------------------+-------------------------------------------------+
| [-8015]{#-8015}                   | **Field (*name*) in ON CHANGE clause not found  |
|                                   | in form.\**                                     |
|                                   | *Description:* The field used in the ON CHANGE  |
|                                   | clauses was not found in the form specification |
|                                   | file.\                                          |
|                                   | *Solution:* Make sure the field name of the ON  |
|                                   | CHANGE clause matches a valid form field.       |
+-----------------------------------+-------------------------------------------------+
| [-8016]{#-8016}                   | **You cannot have multiple ON CHANGE clauses    |
|                                   | for the same field.\**                          |
|                                   | *Description:* It is not possible to specify    |
|                                   | multiple ON CHANGE clauses using the same       |
|                                   | field.\                                         |
|                                   | *Solution:* Remove un-necessary ON CHANGE       |
|                                   | clauses.                                        |
+-----------------------------------+-------------------------------------------------+
| [-8017]{#-8017}                   | **SFMT: Invalid % index used.\**                |
|                                   | *Description:* The format string is not valid.\ |
|                                   | *Solution:* Check for invalid % positions.      |
+-----------------------------------+-------------------------------------------------+
| [-8018]{#-8018}                   | **SFMT: Format error.\**                        |
|                                   | *Description:* The format string is not valid.\ |
|                                   | *Solution:* Check for invalid % positions.      |
+-----------------------------------+-------------------------------------------------+
| [-8019]{#-8019}                   | **No more than one ON ROW CHANGE clause can     |
|                                   | appear in an INPUT ARRAY statement.\**          |
|                                   | *Description:* Multiple ON ROW CHANGE clause    |
|                                   | were found in the same INPUT ARRAY.\            |
|                                   | *Solution:* Remove un-necessary ON ROW CHANGE   |
|                                   | clauses.                                        |
+-----------------------------------+-------------------------------------------------+
| [-8020]{#-8020}                   | **Multiple ON ACTION clauses with the same      |
|                                   | action name appear in the statement.\**         |
|                                   | *Description:* It is not possible to specify    |
|                                   | multiple ON ACTION clauses using the same       |
|                                   | action name.\                                   |
|                                   | *Solution:* Remove un-necessary ON ACTION       |
|                                   | clauses.                                        |
+-----------------------------------+-------------------------------------------------+
| [-8021]{#-8021}                   | **Multiple ON KEY clauses with the same key     |
|                                   | name appear in the statement.\**                |
|                                   | *Description:* It is not possible to specify    |
|                                   | multiple ON KEY clauses using the same key.\    |
|                                   | *Solution:* Remove un-necessary ON KEY clauses. |
+-----------------------------------+-------------------------------------------------+
| [-8022]{#-8022}                   | **Dom: Cannot open xml-file.\**                 |
|                                   | *Description:* The file could not be loaded.\   |
|                                   | *Solution:* Check file name and user            |
|                                   | permissions.                                    |
+-----------------------------------+-------------------------------------------------+
| [-8023]{#-8023}                   | **Dom: The attribute \'*name*\' does not belong |
|                                   | to node \'*node*\'.\**                          |
|                                   | *Description:* You try to set an attribute to a |
|                                   | node which does not have such attribute.\       |
|                                   | *Solution:* This is not allowed, review your    |
|                                   | code.                                           |
+-----------------------------------+-------------------------------------------------+
| [-8024]{#-8024}                   | **Dom: Character data can not be created        |
|                                   | here.\**                                        |
|                                   | *Description:* You try to create a character    |
|                                   | node under a node which does not allow such     |
|                                   | nodes.\                                         |
|                                   | *Solution:* This is not allowed, review your    |
|                                   | code.                                           |
+-----------------------------------+-------------------------------------------------+
| [-8025]{#-8025}                   | **Dom: Cannot set attributes of a character     |
|                                   | node.\**                                        |
|                                   | *Description:* You try to set attributes in a   |
|                                   | character node.\                                |
|                                   | *Solution:* This is not allowed, review your    |
|                                   | code.                                           |
+-----------------------------------+-------------------------------------------------+
| [-8026]{#-8026}                   | **Dom: The attribute \'*name*\' can not be      |
|                                   | removed: the node \'*node*\' belongs to the     |
|                                   | user-interface.\**                              |
|                                   | *Description:* You try to remove a mandatory    |
|                                   | attribute from an AUI node.\                    |
|                                   | *Solution:* You can only change the value of    |
|                                   | this attribute, try \'none\' or an empty        |
|                                   | string.                                         |
+-----------------------------------+-------------------------------------------------+
| [-8027]{#-8027}                   | **Sax: can not write.\**                        |
|                                   | *Description:* The SAX handlers could not write |
|                                   | to the destination file.\                       |
|                                   | *Solution:* Make sure the file path is correct  |
|                                   | and the user has write permissions.             |
+-----------------------------------+-------------------------------------------------+
| [-8029]{#-8029}                   | **Multiple inclusion of the source file         |
|                                   | \'*name*\'.\**                                  |
|                                   | *Description:* The preprocessor detected that   |
|                                   | the specified file was included several times   |
|                                   | by the same source.\                            |
|                                   | *Solution:* Remove un-necessary file            |
|                                   | inclusions.                                     |
+-----------------------------------+-------------------------------------------------+
| [-8030]{#-8030}                   | **The full path to the source file \'*name*\'   |
|                                   | is too long.\**                                 |
|                                   | *Description:* The preprocessor does not        |
|                                   | support very long file names.\                  |
|                                   | *Solution:* Rename the file.                    |
+-----------------------------------+-------------------------------------------------+
| [-8031]{#-8031}                   | **The source file \'*name*\' cannot be read.\** |
|                                   | *Description:* The preprocessor could not read  |
|                                   | the file specified.\                            |
|                                   | *Solution:* Make sure the use has read          |
|                                   | permissions.                                    |
+-----------------------------------+-------------------------------------------------+
| [-8032]{#-8032}                   | **The source file \'*name*\' cannot be          |
|                                   | found.\**                                       |
|                                   | *Description:* The preprocessor could not find  |
|                                   | the file specified.\                            |
|                                   | *Solution:* Make sure the file exists.          |
+-----------------------------------+-------------------------------------------------+
| [-8033]{#-8033}                   | **Extra token found after \'*name*\'            |
|                                   | directive.\**                                   |
|                                   | *Description:* The preprocessor detected an     |
|                                   | unexpected token after the shown directive.\    |
|                                   | *Solution:* Review your code and make the       |
|                                   | necessary corrections.                          |
+-----------------------------------+-------------------------------------------------+
| [-8034]{#-8034}                   | ***feature*: This feature is not                |
|                                   | implemented.\**                                 |
|                                   | *Description:* This preprocessor feature is not |
|                                   | supported.\                                     |
|                                   | *Solution:* Review your code and make the       |
|                                   | necessary corrections.                          |
+-----------------------------------+-------------------------------------------------+
| [-8035]{#-8035}                   | **The macro \'*name*\' has already been         |
|                                   | defined.\**                                     |
|                                   | *Description:* The preprocessor found a         |
|                                   | duplicated macro definition.\                   |
|                                   | *Solution:* Review your code and make the       |
|                                   | necessary corrections.                          |
+-----------------------------------+-------------------------------------------------+
| [-8036]{#-8036}                   | **A &else directive found without corresponding |
|                                   | &if,&ifdef or &ifndef directive.\**             |
|                                   | *Description:* The preprocessor detected an     |
|                                   | unexpected **&else** directive.\                |
|                                   | *Solution:* Review your code and make the       |
|                                   | necessary corrections.                          |
+-----------------------------------+-------------------------------------------------+
| [-8037]{#-8037}                   | **A &endif directive found without              |
|                                   | corresponding &if,&ifdef or &ifndef             |
|                                   | directive.\**                                   |
|                                   | *Description:* The preprocessor detected an     |
|                                   | unexpected **&endif** directive.\               |
|                                   | *Solution:* Review your code and make the       |
|                                   | necessary corrections.                          |
+-----------------------------------+-------------------------------------------------+
| [-8038]{#-8038}                   | **Invalid preprocessor directive &*name*        |
|                                   | found.\**                                       |
|                                   | *Description:* The preprocessor directive shown |
|                                   | in the error message does not exist. \          |
|                                   | *Solution:* Review your code and check valid    |
|                                   | macros.                                         |
+-----------------------------------+-------------------------------------------------+
| [-8039]{#-8039}                   | **Invalid number of parameters for macro        |
|                                   | *name*.\**                                      |
|                                   | *Description:* The number of parameters of the  |
|                                   | preprocessor macro shown in the error message   |
|                                   | does not match de number of parameters in the   |
|                                   | definition of this macro. \                     |
|                                   | *Solution:* Review your code and check for the  |
|                                   | number of parameters.                           |
+-----------------------------------+-------------------------------------------------+
| [-8040]{#-8040}                   | **Lexical error : Unclosed string.\**           |
|                                   | *Description:* The compiler detected an         |
|                                   | unclosed string and cannot continue.\           |
|                                   | *Solution:* Review your code and make the       |
|                                   | necessary corrections.                          |
+-----------------------------------+-------------------------------------------------+
| [-8041]{#-8041}                   | **Unterminated condition &if or &else.\**       |
|                                   | *Description:* The preprocessor found an        |
|                                   | un-terminated conditional directive.\           |
|                                   | *Solution:* Review the definition of this       |
|                                   | directive.                                      |
+-----------------------------------+-------------------------------------------------+
| [-8042]{#-8042}                   | **The operator \'##\' can only be used with     |
|                                   | identifiers and numbers. %s is not allowed.\**  |
|                                   | *Description:* The preprocessor found an        |
|                                   | invalid usage of the \## string concatenation   |
|                                   | operator.\                                      |
|                                   | *Solution:* Review the definition of this       |
|                                   | macro.                                          |
+-----------------------------------+-------------------------------------------------+
| [-8043]{#-8043}                   | **Could not run FGLPP, command used :           |
|                                   | *command*\**                                    |
|                                   | *Description:* The compiler could not run the   |
|                                   | preprocessor command shown in the error         |
|                                   | message.\                                       |
|                                   | *Solution:* Make sure the preprocessor command  |
|                                   | exists.                                         |
+-----------------------------------+-------------------------------------------------+
| [-8044]{#-8044}                   | **Lexical error : Unclosed comment.\**          |
|                                   | *Description:* The compiler detected an         |
|                                   | unclosed comment and cannot continue.\          |
|                                   | *Solution:* Review your code and make the       |
|                                   | necessary corrections.                          |
+-----------------------------------+-------------------------------------------------+
| [-8045]{#-8045}                   | **This type of statement can only be used       |
|                                   | within an INPUT, INPUT ARRAY, DISPLAY ARRAY,    |
|                                   | CONSTRUCT or MENU statement.\**                 |
|                                   | *Description:* This statement has not been used |
|                                   | within a valid interactive statement, which     |
|                                   | must be terminated appropriately with END       |
|                                   | INPUT,  END INPUT ARRAY,  END DISPLAY ARRAY,    |
|                                   | END CONSTRUCT, or END MENU.\                    |
|                                   | *Solution:* Review your code and make the       |
|                                   | necessary corrections.                          |
+-----------------------------------+-------------------------------------------------+
| [-8046]{#-8046}                   | **This type of statement can only be used       |
|                                   | within an INPUT, INPUT ARRAY, DISPLAY ARRAY or  |
|                                   | CONSTRUCT statement.\**                         |
|                                   | *Description:* This statement has not been used |
|                                   | within a valid interactive statement, which     |
|                                   | must be terminated appropriately with END       |
|                                   | INPUT,  END INPUT ARRAY,  END DISPLAY ARRAY, or |
|                                   | END CONSTRUCT.\                                 |
|                                   | *Solution:* Review your code and make the       |
|                                   | necessary corrections.                          |
+-----------------------------------+-------------------------------------------------+
| [-8047]{#-8047}                   | **Invalid use of \'dialog\'. Must be used       |
|                                   | within an INPUT, INPUT ARRAY, DISPLAY ARRAY or  |
|                                   | CONSTRUCT statement.\**                         |
|                                   | *Description:* The predefined keyword DIALOG    |
|                                   | has not been used within a valid interactive    |
|                                   | statement, which must be terminated             |
|                                   | appropriately with END INPUT,  END INPUT        |
|                                   | ARRAY,  END DISPLAY ARRAY, or END CONSTRUCT.\   |
|                                   | *Solution:* Review your code and make the       |
|                                   | necessary corrections.                          |
+-----------------------------------+-------------------------------------------------+
| [-8048]{#-8048}                   | **An error occurred while preprocessing the     |
|                                   | file \'*name\'*. Compilation ends.\**           |
|                                   | *Description:* The Genero BDL preprocessor      |
|                                   | could not parse the whole source file and       |
|                                   | stopped compilation.\                           |
|                                   | *Solution:* Review the source code and check    |
|                                   | for not well formed & preprocessor macros.      |
+-----------------------------------+-------------------------------------------------+
| [-8049]{#-8049}                   | **The program cannot ACCEPT                     |
|                                   | (INPUT\|CONSTRUCT\|DISPLAY) at this point       |
|                                   | because it is not immediately within            |
|                                   | (INPUT\|INPUT ARRAY\|CONSTRUCT\|DISPLAY ARRAY)  |
|                                   | statement.\**                                   |
|                                   | *Description:* ACCEPT XXX has not been used     |
|                                   | within a valid interactive statement, which     |
|                                   | must be terminated appropriately with END       |
|                                   | INPUT,  END PROMPT,  or END INPUT ARRAY.\       |
|                                   | *Solution:* Review your code and make the       |
|                                   | necessary corrections.                          |
+-----------------------------------+-------------------------------------------------+
| [-8050]{#-8050}                   | **Dom: Invalid XML data found in source.\**     |
|                                   | *Description:* ACCEPT DISPLAY has not been used |
|                                   | within a valid DISPLAY ARRAY statement, which   |
|                                   | must be terminated with END DISPLAY ARRAY.\     |
|                                   | *Solution:* Review your code and make the       |
|                                   | necessary corrections.                          |
+-----------------------------------+-------------------------------------------------+
| [-8051]{#-8051}                   | **Sax: Invalid processing instruction name.\**  |
|                                   | *Description:* The                              |
|                                   | om.SaxDocumentHandler.processingInstruction()   |
|                                   | does not allow invalid processing instruction   |
|                                   | names such as \'xml\'.\                         |
|                                   | *Solution:* \<?xml ..?\> is not a processing    |
|                                   | instruction, it is reserved to define the XML   |
|                                   | file text declaration. You must use another     |
|                                   | name.                                           |
+-----------------------------------+-------------------------------------------------+
| [-8052]{#-8052}                   | **Illegal input sequence. Check LANG.\**        |
|                                   | *Description:* The compiler encountered an      |
|                                   | invalid character sequence. The source file     |
|                                   | uses a character sequence which does not match  |
|                                   | the locale settings (LANG).\                    |
|                                   | *Solution:* Check source file and locale        |
|                                   | settings.                                       |
+-----------------------------------+-------------------------------------------------+
| [-8053]{#-8053}                   | **Unknown preprocessor directive \'*name*\'.\** |
|                                   | *Description:* The preprocessor directive shown |
|                                   | in the error message is not a known directive.\ |
|                                   | *Solution:* Check for typo errors and read the  |
|                                   | documentation for valid preprocessor            |
|                                   | directives.                                     |
+-----------------------------------+-------------------------------------------------+
| [-8054]{#-8054}                   | **Unexpected preprocessor directive.\**         |
|                                   | *Description:* The preprocessor encountered an  |
|                                   | unexpected directive.\                          |
|                                   | *Solution:* Remove the directive.               |
+-----------------------------------+-------------------------------------------------+
| [-8055]{#-8055}                   | **The resource file \'*name*\' contains         |
|                                   | unexpected data.\**                             |
|                                   | *Description:* The XML resource file shown in   |
|                                   | the error message does not contain the expected |
|                                   | nodes. For example, you try to load a ToolBar   |
|                                   | with ui.Interface.loadActionDefaults().\        |
|                                   | *Solution:* Check if the XML file contains the  |
|                                   | node types expected for this type of resource.  |
+-----------------------------------+-------------------------------------------------+
| [-8056]{#-8056}                   | **XPath: Unclosed quote at position             |
|                                   | *integer*.\**                                   |
|                                   | *Description:* The XPath parser found an        |
|                                   | unexpected quote at the given position.\        |
|                                   | *Solution:* Review the XPath expression.        |
+-----------------------------------+-------------------------------------------------+
| [-8057]{#-8057}                   | **XPath: Unexpected character \'*character*\'   |
|                                   | at position *integer*.\**                       |
|                                   | *Description:* The XPath parser found an        |
|                                   | unexpected character at the given position.\    |
|                                   | *Solution:* Review the XPath expression.        |
+-----------------------------------+-------------------------------------------------+
| [-8058]{#-8058}                   | **XPath: Unexpected token/string \'*name*\' at  |
|                                   | position *integer*.\**                          |
|                                   | *Description:* The XPath parser found an        |
|                                   | unexpected token or string at the given         |
|                                   | position.\                                      |
|                                   | *Solution:* Review the XPath expression.        |
+-----------------------------------+-------------------------------------------------+
| [-8059]{#-8059}                   | **SQL statement or language instruction with    |
|                                   | specific SQL syntax.\**                         |
|                                   | *Description:* The compiler found an SQL        |
|                                   | statement which is using a database specific    |
|                                   | syntax. This statement will probably not run on |
|                                   | other database servers as the current.\         |
|                                   | *Solution:* Review the SQL statement an use     |
|                                   | standard/common syntax and features.            |
+-----------------------------------+-------------------------------------------------+
| [-8060]{#-8060}                   | **Spacer items are not allowed inside a SCREEN  |
|                                   | sections.\**                                    |
|                                   | *Description:* The form contains spacer items   |
|                                   | in a SCREEN section, while these are only       |
|                                   | allowed in LAYOUT.\                             |
|                                   | *Solution:* Review the form specification file. |
+-----------------------------------+-------------------------------------------------+
| [-8061]{#-8061}                   | **A TABLE row should not be defined on multiple |
|                                   | lines.\**                                       |
|                                   | *Description:* All columns of a row in a TABLE  |
|                                   | container must be in a single line.\            |
|                                   | *Solution:* Use a SCROLLGRID if you want to     |
|                                   | show row cells on multiple lines.               |
+-----------------------------------+-------------------------------------------------+
| [-8062]{#-8062}                   | **DOM(ui): insert of removed node is not        |
|                                   | allowed.\**                                     |
|                                   | *Description:* It is not possible to insert a   |
|                                   | removed node in the AUI document.\              |
|                                   | *Solution:* Review the code.                    |
+-----------------------------------+-------------------------------------------------+
| [-8063]{#-8063}                   | **The client connection timed out, exiting      |
|                                   | program.\**                                     |
|                                   | *Description:* The runtime system could not     |
|                                   | establish the connection with the front-end     |
|                                   | after a given time. This can for example happen |
|                                   | during a file transfer, when the front-end      |
|                                   | takes too much time to answer to the runtime    |
|                                   | system.\                                        |
|                                   | *Solution:* Check that your network connection  |
|                                   | is working properly.                            |
+-----------------------------------+-------------------------------------------------+
| [-8064]{#-8064}                   | **File transfer interrupted.\**                 |
|                                   | *Description:* An interruption was caught       |
|                                   | during a file transfer.\                        |
|                                   | *Solution:* File could not be transferred, you  |
|                                   | need to redo the operation.                     |
+-----------------------------------+-------------------------------------------------+
| [-8065]{#-8065}                   | **Network error during file transfer.\**        |
|                                   | *Description:* An socket error was caught       |
|                                   | during a file transfer.\                        |
|                                   | *Solution:* Check that your network connection  |
|                                   | is working properly.                            |
+-----------------------------------+-------------------------------------------------+
| [-8066]{#-8066}                   | **Could not write destination file for file     |
|                                   | transfer.**\                                    |
|                                   | *Description:* The runtime system could not     |
|                                   | write the destination file for a transfer.\     |
|                                   | *Solution:* Make sure the file path is correct  |
|                                   | and check that user has write permissions.      |
+-----------------------------------+-------------------------------------------------+
| [-8067]{#-8067}                   | **Could not read source file for file           |
|                                   | transfer.**\                                    |
|                                   | *Description:* The runtime system could not     |
|                                   | read the source file to transfer.\              |
|                                   | *Solution:* Make sure the file path is correct  |
|                                   | and check that user has read permissions.       |
+-----------------------------------+-------------------------------------------------+
| [-8068]{#-8068}                   | **File transfer protocol error (invalid         |
|                                   | state).**\                                      |
|                                   | *Description:* The runtime system encountered a |
|                                   | problem during a file transfer.\                |
|                                   | *Solution:* A network failure has probably      |
|                                   | raised this error.                              |
+-----------------------------------+-------------------------------------------------+
| [-8069]{#-8069}                   | **File transfer not available.**\               |
|                                   | *Description:* File transfer feature is not     |
|                                   | supported.\                                     |
|                                   | *Solution:* Make sure the front-end supports    |
|                                   | file transfer.                                  |
+-----------------------------------+-------------------------------------------------+
| [-8070]{#-8070}                   | **The localized string file \'*name*\' is       |
|                                   | corrupted.**\                                   |
|                                   | *Description:* The shown string resource file   |
|                                   | is invalid (probably invalid multi-byte         |
|                                   | characters corrupt the file).\                  |
|                                   | *Solution:* Check for locale settings (LANG),   |
|                                   | make sure the .str source uses valid characters |
|                                   | and recompile it.                               |
+-----------------------------------+-------------------------------------------------+
| [-8071]{#-8071}                   | **\'*name*\' is already defined.**\             |
|                                   | *Description:* The form file defines several    |
|                                   | elements of the same type with the same name. \ |
|                                   | *Solution:* Review the form file and use unique |
|                                   | identifiers.                                    |
+-----------------------------------+-------------------------------------------------+
| [-8072]{#-8072}                   | **Statement must terminate with \';\'.**\       |
|                                   | *Description:* An ESQL/C preprocessor directive |
|                                   | is not terminated with a semi-colon.\           |
|                                   | *Solution:* Add a semi-colon to the end of the  |
|                                   | directive.                                      |
+-----------------------------------+-------------------------------------------------+
| [-8073]{#-8073}                   | **Invalid \'include\' directive file name.**\   |
|                                   | *Description:* An include preprocessor          |
|                                   | directive is using an invalid file name.\       |
|                                   | *Solution:* Check the file name.                |
+-----------------------------------+-------------------------------------------------+
| [-8074]{#-8074}                   | **A &elif directive found without corresponding |
|                                   | &if,&ifdef or &ifndef directive.**\             |
|                                   | *Description:* The preprocessor found an        |
|                                   | **&elif** directive with no corresponding       |
|                                   | **&if**.\                                       |
|                                   | *Solution:* Add the **&if** directive before    |
|                                   | the **&elif**, or remove the **&elif**.         |
+-----------------------------------+-------------------------------------------------+
| [-8075]{#-8075}                   | **The compiler plugin *name* could not be       |
|                                   | loaded.**\                                      |
|                                   | *Description:* fglcomp could not load the       |
|                                   | plugin because it was not found.\               |
|                                   | *Solution:* Make sure the plugin exists and can |
|                                   | be loaded.                                      |
+-----------------------------------+-------------------------------------------------+
| [-8076]{#-8076}                   | **The compiler plugin *name* does not implement |
|                                   | the required interface.**\                      |
|                                   | *Description:* fglcomp could not load the       |
|                                   | plugin because the interface is invalid.\       |
|                                   | *Solution:* Check if the plugin corresponds to  |
|                                   | the version of the compiler.                    |
+-----------------------------------+-------------------------------------------------+
| [-8077]{#-8077}                   | **The attribute \'*name*\' has been defined     |
|                                   | more than once.**\                              |
|                                   | *Description:* The variable attribute shown in  |
|                                   | the error message was defined multiple times.\  |
|                                   | *Solution:* Review the variable definition and  |
|                                   | remove duplicated attributes.                   |
+-----------------------------------+-------------------------------------------------+
| [-8078]{#-8078}                   | **The attribute \'*name*\' is not allowed.**\   |
|                                   | *Description:* The variable attribute shown in  |
|                                   | the error message is not allowed for this type  |
|                                   | of variable.\                                   |
|                                   | *Solution:* Review the possible variable        |
|                                   | attributes.                                     |
+-----------------------------------+-------------------------------------------------+
| [-8079]{#-8079}                   | **An error occurred while parsing the XML       |
|                                   | file.**\                                        |
|                                   | *Description:* The runtime system could not     |
|                                   | parse an XML file, which is probably not using  |
|                                   | a valid XML format.\                            |
|                                   | *Solution:* Check for XML format typos and if   |
|                                   | possible, validate the XML file with a DTD.     |
+-----------------------------------+-------------------------------------------------+
| [-8080]{#-8080}                   | **Could not open xml file.**\                   |
|                                   | *Description:* The specified XML file cannot be |
|                                   | opened.\                                        |
|                                   | *Solution:* Make sure the file exists and has   |
|                                   | access permissions for the current user.        |
+-----------------------------------+-------------------------------------------------+
| [-8081]{#-8081}                   | **Invalid multibyte character has been          |
|                                   | encountered.**\                                 |
|                                   | *Description:* A compiler found an invalid      |
|                                   | multi-byte character in the source and cannot   |
|                                   | compile the form or module.\                    |
|                                   | *Solution:* Check locale settings (LANG) and    |
|                                   | verify if there are no invalid characters in    |
|                                   | your sources.                                   |
+-----------------------------------+-------------------------------------------------+
| [-8082]{#-8082}                   | **The item \'*name*\' is used in an invalid     |
|                                   | layout context.**\                              |
|                                   | *Description:* The form item name is used in a  |
|                                   | layout part which does not support this type of |
|                                   | form item. This error occurs for example when   |
|                                   | you try to define a BUTTON as a TABLE column.\  |
|                                   | *Solution:* Review your form definition file    |
|                                   | and use correct item types.                     |
+-----------------------------------+-------------------------------------------------+
| [-8083]{#-8083}                   | **NULL pointer exception.**\                    |
|                                   | *Description:* The program is using calling a   |
|                                   | method thru an object variable which is NULL.\  |
|                                   | *Solution:* You must assign an object reference |
|                                   | to the variable before calling a method.        |
+-----------------------------------+-------------------------------------------------+
| [-8084]{#-8084}                   | **Can\'t open socket.\**                        |
|                                   | *Description:* The channel object failed to     |
|                                   | open a client socket.\                          |
|                                   | *Solution:* Make sure the IP address and port   |
|                                   | are correct.                                    |
+-----------------------------------+-------------------------------------------------+
| [-8085]{#-8085}                   | **Unsupported mode for \'open socket\'.\**      |
|                                   | *Description:*You try to open a channel with an |
|                                   | unsupported mode.\                              |
|                                   | *Solution:* See channel documentation for       |
|                                   | supported modes.                                |
+-----------------------------------+-------------------------------------------------+
| [-8086]{#-8086}                   | **The socket connection timed out.\**           |
|                                   | *Description:* Socket connect could not be      |
|                                   | established and timeout expired.\               |
|                                   | *Solution:* Check all network layers and try    |
|                                   | again.                                          |
+-----------------------------------+-------------------------------------------------+
| [-8087]{#-8087}                   | **File error in BYTE or TEXT readFile or        |
|                                   | writeFile.\**                                   |
|                                   | *Description:* File I/O error occurred while    |
|                                   | reading from or writing to a file.\             |
|                                   | *Solution:* Verify the file name, content and   |
|                                   | access permissions.                             |
+-----------------------------------+-------------------------------------------------+
| [-8088]{#-8088}                   | **The dialog attribute \'*attribute-name*\' is  |
|                                   | not supported.\**                               |
|                                   | *Description:* A dialog instruction was         |
|                                   | declared with an ATTRIBUTES clause containing   |
|                                   | an unsupported option.\                         |
|                                   | *Solution:* Review the ATTRIBUTES clause and    |
|                                   | remove unsupported option.                      |
+-----------------------------------+-------------------------------------------------+
| [-8089]{#-8089}                   | **Action \'*action-name*\' not found in         |
|                                   | dialog.\**                                      |
|                                   | *Description:* You try to use and action name   |
|                                   | that does not exist in the current dialog.\     |
|                                   | *Solution:* Verify if name of the action is     |
|                                   | defined by an ON ACTION clause.                 |
+-----------------------------------+-------------------------------------------------+
| [-8090]{#-8090}                   | **Field \'*field-name*\' already used in this   |
|                                   | DIALOG.\**                                      |
|                                   | *Description:* The DIALOG instruction binds the |
|                                   | same field-name or screen-record multiple       |
|                                   | times.\                                         |
|                                   | *Solution:* Review all sub-dialog blocks and    |
|                                   | check the field-names / screen-records.         |
+-----------------------------------+-------------------------------------------------+
| [-8091]{#-8091}                   | **The clause \'*clause-name*\' appears more     |
|                                   | than once.\**                                   |
|                                   | *Description:* You have defined the same dialog |
|                                   | control block multiple times. For example,      |
|                                   | AFTER ROW was defined twice.\                   |
|                                   | *Solution:* Remove the un-necessary control     |
|                                   | blocks.                                         |
+-----------------------------------+-------------------------------------------------+
| [-8092]{#-8092}                   | **At least one field for this INPUT ARRAY must  |
|                                   | be editable.\**                                 |
|                                   | *Description:* An INPUT ARRAY is executed on    |
|                                   | fields that are read-only. At least one field   |
|                                   | must be editable and active.\                   |
|                                   | *Solution:* Review the form specification file  |
|                                   | or check that at least one field is active.     |
+-----------------------------------+-------------------------------------------------+
| [-8093]{#-8093}                   | **Multi-range selection is not available in     |
|                                   | this context.\**                                |
|                                   | *Description:* You try to use multi-range       |
|                                   | selection but it is not possible in the current |
|                                   | dialog type.\                                   |
|                                   | *Solution:* Disable this feature.               |
+-----------------------------------+-------------------------------------------------+
| [-8094]{#-8094}                   | **Multi-range selection is not available in     |
|                                   | this context.\**                                |
|                                   | *Description:* You try to use multi-range       |
|                                   | selection but it is not possible in the current |
|                                   | dialog type.\                                   |
|                                   | *Solution:* Disable this feature.               |
+-----------------------------------+-------------------------------------------------+
| [-8095]{#-8095}                   | **Cannot change selection flag for this range   |
|                                   | of rows.\**                                     |
|                                   | *Description:* An attempt of selection flag     |
|                                   | modification with DIALOG.setSelectionRange()    |
|                                   | failed because the range is out of bounds or    |
|                                   | because there is no multi-range selection       |
|                                   | available in this context.\                     |
|                                   | *Solution:* Make sure you can use multi-range   |
|                                   | selection, and check the start and end index of |
|                                   | the range.                                      |
+-----------------------------------+-------------------------------------------------+
| [-8096]{#-8096}                   | **General SQL Warning, check SQLCA.SQLERRD\[2\] |
|                                   | or SQLSTATE.\**                                 |
|                                   | *Description:* The last SQL statement has       |
|                                   | generated an SQL warning setting the            |
|                                   | SQLCA.SQLAWARN flags.\                          |
|                                   | *Solution:* Program execution can continue.     |
|                                   | However, you should take care and check the     |
|                                   | native SQL code and the SQL message in          |
|                                   | SQLERRMESSAGE.                                  |
+-----------------------------------+-------------------------------------------------+
| [-8097]{#-8097}                   | **Value too large to fit in a TINYINT.**\       |
|                                   | *Description:* The TINYINT data type can accept |
|                                   | numbers with a value range from -128 to +127.\  |
|                                   | *Solution:* To store numbers that are outside   |
|                                   | this range, redefine the column or variable to  |
|                                   | use the SMALLINT or INTEGER type.               |
+-----------------------------------+-------------------------------------------------+
| [-8098]{#-8098}                   | **ON FILL BUFFER conflicts with DISPLAY ARRAY   |
|                                   | as a tree.**\                                   |
|                                   | *Description:* The DISPLAY ARRAY instruction is |
|                                   | using a treeview as decoration, but it          |
|                                   | implements also an ON FILL BUFFER trigger to do |
|                                   | paged mode. The paged mode is not possible when |
|                                   | using a treeview, because all rows of visible   |
|                                   | nodes are required (i.e. the dialog cannot      |
|                                   | display a tree only with a part of the          |
|                                   | dataset).\                                      |
|                                   | *Solution:* To populate dynamically the array   |
|                                   | for a treeview, use the ON EXPAND to add new    |
|                                   | nodes and ON COLLAPSE to remove nodes.          |
+-----------------------------------+-------------------------------------------------+
| [-8099]{#-8099}                   | **The form \'*name*\' is incompatible with the  |
|                                   | current runtime version. Rebuild you forms.**\  |
|                                   | *Description:* The .42f form was probably       |
|                                   | compiled with an earlier version as the current |
|                                   | runtime system.\                                |
|                                   | *Solution:* Recompile the form with the fglform |
|                                   | compiler corresponding to the current fglrun.   |
+-----------------------------------+-------------------------------------------------+
| [-8100]{#-8100}                   | **Attempt to access a closed dialog.**\         |
|                                   | *Description:* A call to a DIALOG class method  |
|                                   | is done with a dialog object that has           |
|                                   | terminated.\                                    |
|                                   | *Solution:* Review the program logic and call   |
|                                   | the DIALOG methods only for active running      |
|                                   | dialogs.                                        |
+-----------------------------------+-------------------------------------------------+
| [-8101]{#-8101}                   | **The TABLE column tag \'tag-name\' appears     |
|                                   | multiple times in the row definition.**\        |
|                                   | *Description:* A TABLE column can only be used  |
|                                   | once in the row definition, you have probably   |
|                                   | repeated the same screen tag by mistake. \      |
|                                   | *Solution:* Modify the TABLE row definition in  |
|                                   | the layout section in order to use each column  |
|                                   | only once.                                      |
+-----------------------------------+-------------------------------------------------+
| [-8102]{#-8102}                   | **Syntax error in preprocessor directive.**\    |
|                                   | *Description:* The source file contains a       |
|                                   | preprocessor macro with an invalid syntax.\     |
|                                   | *Solution:* Check the preprocessor manual page  |
|                                   | and fix the syntax error.                       |
+-----------------------------------+-------------------------------------------------+
| [-8103]{#-8103}                   | **The source and destination file name of a     |
|                                   | file transfer must not be NULL or empty.**\     |
|                                   | *Description:* The program is doing an          |
|                                   | fgl_getfile() or fgl_putfile() and the source   |
|                                   | or destination file name is NULL or empty.\     |
|                                   | *Solution:* Provide a valid file name for both  |
|                                   | source and destination parameters.              |
+-----------------------------------+-------------------------------------------------+
| [-8200]{#-8200}                   | **apidoc: parameter name \'%s\' is invalid.**\  |
|                                   | *Description:* The compiler has detected a      |
|                                   | comment error while extracting the source       |
|                                   | documentation:\                                 |
|                                   | The \@param variable name is not in the list of |
|                                   | parameters in the next FUNCTION definition.\    |
|                                   | *Solution:* Check the function parameter name.  |
+-----------------------------------+-------------------------------------------------+
| [-8201]{#-8201}                   | **apidoc: tag missing: \@param %s.**\           |
|                                   | *Description:* The compiler has detected a      |
|                                   | comment error while extracting the source       |
|                                   | documentation:\                                 |
|                                   | There is a missing \@param tag that should      |
|                                   | describe a parameter of the next FUNCTION       |
|                                   | definition.\                                    |
|                                   | *Solution:* Check the function parameter name.  |
+-----------------------------------+-------------------------------------------------+
| [-8202]{#-8202}                   | **apidoc: invalid tag name @%s.**\              |
|                                   | *Description:* The compiler has detected a      |
|                                   | comment error while extracting the source       |
|                                   | documentation:\                                 |
|                                   | The @*name* tag is not a known tag name.\       |
|                                   | *Solution:* Check for typo errors in the tag    |
|                                   | name.                                           |
+-----------------------------------+-------------------------------------------------+
| [-8300]{#-8300}                   | **Cannot load java shared library.\             |
|                                   | Reason:%s**\                                    |
|                                   | *Description:* The runtime system could not     |
|                                   | load the JVM shared library (or DLL).\          |
|                                   | *Solution:* Make sure that a JRE is installed   |
|                                   | on the machine and check the environment        |
|                                   | (LD_LIBRARY_PATH on Unix or PATH on Windows).   |
+-----------------------------------+-------------------------------------------------+
| [-8301]{#-8301}                   | **Cannot create java VM.**\                     |
|                                   | *Description:* The runtime system could load    |
|                                   | the JVM shared library (or DLL), but could not  |
|                                   | initialize the Java VM with a call to           |
|                                   | JNI_CreateJavaVM().\                            |
|                                   | *Solution:* Check that the Java requirements    |
|                                   | and resources needs to create a Java VM.        |
+-----------------------------------+-------------------------------------------------+
| [-8302]{#-8302}                   | **Array element type is not a Java type.**\     |
|                                   | *Description:* The fglcomp compiler detected a  |
|                                   | Java Array definition which is not using a Java |
|                                   | type for the elements.\                         |
|                                   | *Solution:* Review the DEFINE statement and use |
|                                   | a Java type.                                    |
+-----------------------------------+-------------------------------------------------+
| [-8303]{#-8303}                   | **Java is not supported.**\                     |
|                                   | *Description:* The platform you are using does  |
|                                   | not support a recent Java version required by   |
|                                   | Genero.\                                        |
|                                   | *Solution:* You cannot use the Java interface   |
|                                   | in this operating system, you must review your  |
|                                   | source code and remove all Java related parts.  |
+-----------------------------------+-------------------------------------------------+
| [-8304]{#-8304}                   | **Cannot assign a value to final variable       |
|                                   | \'*name*\'.**\                                  |
|                                   | *Description:* The program tries to set a Java  |
|                                   | class variable which is not writable.\          |
|                                   | *Solution:* Review the program logic.           |
+-----------------------------------+-------------------------------------------------+
| [-8305]{#-8305}                   | **The Java variable \'*name*\' can not be used  |
|                                   | here.**\                                        |
|                                   | *Description:* The program tries to use a Java  |
|                                   | class variable in an invalid context. For       |
|                                   | example, a Java class variable is used in an    |
|                                   | INPUT instruction.\                             |
|                                   | *Solution:* Review the program logic and use a  |
|                                   | regular Genero BDL variable.                    |
+-----------------------------------+-------------------------------------------------+
| [-8306]{#-8306}                   | **Java exception thrown:                        |
|                                   | *java-exception-text*.**\                       |
|                                   | *Description:* A Java exception has been thrown |
|                                   | while executing Java code.\                     |
|                                   | *Solution:* Check the exception text and review |
|                                   | the code.                                       |
+-----------------------------------+-------------------------------------------------+
| [-8400]{#-8400}                   | ***module.name* has private access.**\          |
|                                   | *Description:* An instruction references a      |
|                                   | module function or module variable which is     |
|                                   | declared as private.\                           |
|                                   | *Solution:* Make the function or variable       |
|                                   | public in the imported module.                  |
+-----------------------------------+-------------------------------------------------+
| [-8401]{#-8401}                   | **Reference to *name* is ambiguous.**\          |
|                                   | *Description:* A function or variable           |
|                                   | referenced without the module prefix, but       |
|                                   | exists in several imported modules. Note that   |
|                                   | this error can also be printed by the compiler  |
|                                   | for Java calls.\                                |
|                                   | *Solution:* Add the module prefix before the    |
|                                   | object name to remove the ambiguity.            |
+-----------------------------------+-------------------------------------------------+
| [-8402]{#-8402}                   | **Cyclic IMPORT FGL involving *module*.**\      |
|                                   | *Description:* Some modules are importing       |
|                                   | eachother and introduce a cyclic reference      |
|                                   | which is impossible to resolve.\                |
|                                   | *Solution:* Extract common language elements    |
|                                   | into a new module.                              |
+-----------------------------------+-------------------------------------------------+
| [-8403]{#-8403}                   | **Module *name* does not exist.**\              |
|                                   | *Description:* The module *name* to be imported |
|                                   | could not be found.\                            |
|                                   | *Solution:* Make sure the module name matches   |
|                                   | the file name.                                  |
+-----------------------------------+-------------------------------------------------+
| [-8404]{#-8404}                   | **Module *name* has not been imported.**\       |
|                                   | *Description:* A statement is referencing       |
|                                   | module *name* which has not been imported.\     |
|                                   | *Solution:* Import the module before usage.     |
+-----------------------------------+-------------------------------------------------+
| [-8405]{#-8405}                   | **Report *module.name* has not been defined.**\ |
|                                   | *Description:* A START REPORT, OUTPUT TO REPORT |
|                                   | or FINISH REPORT is referencing a report with   |
|                                   | module prefix, but the module was not           |
|                                   | imported.\                                      |
|                                   | *Solution:* Import the module containing the    |
|                                   | report routine.                                 |
+-----------------------------------+-------------------------------------------------+
| [-8406]{#-8406}                   | **The function \'*name*\' has not been defined. |
|                                   | This conflicts with IMPORT FGL.**\              |
|                                   | *Description:* When using IMPORT FGL, all       |
|                                   | function calls are verified by the compiled.    |
|                                   | The function *name* is called in the compiled   |
|                                   | module, but none of the imported modules define |
|                                   | that function.\                                 |
|                                   | *Solution:* You must import the module          |
|                                   | containing the function *name*.                 |
+-----------------------------------+-------------------------------------------------+
| [-8407]{#-8407}                   | **The type of the parameter \'*name*\' is not   |
|                                   | an SQL type: cannot be inserted into a          |
|                                   | temporary table used for this report.**\        |
|                                   | *Description:* The REPORT parameter *name* is   |
|                                   | defined with a BDL type that has no SQL         |
|                                   | equivalent and thus cannot be used to create    |
|                                   | the temporary table needed to sort rows for a   |
|                                   | two-pass report.\                               |
|                                   | *Solution:* Define the parameter with an        |
|                                   | SQL-compatible type (CHAR, VARCHAR, INTEGER,    |
|                                   | DECIMAL, etc).                                  |
+-----------------------------------+-------------------------------------------------+
| [-10098]{#-10098}                 | **Incorrectly formed hexadecimal value.**\      |
|                                   | *Description:* You try to load data with LOAD   |
|                                   | or locate a BYTE variable with a file contained |
|                                   | malformed hexadecimal values.\                  |
|                                   | *Solution:* Check the file content and fix the  |
|                                   | typos before loading again.                     |
+-----------------------------------+-------------------------------------------------+
| [-10099]{#-10099}                 | **Invalid delimiter. Do not use \'\\\' or hex   |
|                                   | digits (0-9, A-F, a-f).**\                      |
|                                   | *Description:* You try to LOAD or UNLOAD data   |
|                                   | with an invalid field delimiter.\               |
|                                   | *Solution:* Change the field delimiter to a     |
|                                   | valid character such as \| (pipe) or \^         |
|                                   | (caret).                                        |
+-----------------------------------+-------------------------------------------------+

\

------------------------------------------------------------------------
