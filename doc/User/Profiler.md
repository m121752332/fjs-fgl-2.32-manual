[Back to Contents](../index.html)

------------------------------------------------------------------------

# [The Profiler]{#PAGE_HEADER}

Summary:

- [Basics](#BASICS)
- [Syntax](#SYNTAX)
- [Usage](#USAGE)
  - [Profiler output: Flat profile](#PF_FLAT)
  - [Profiler output: Call graph](#PF_GRAPH)
- [Example](#EXAMPLE)

*See also:* [Programs](Programs.html), [Tools](Tools.html)

------------------------------------------------------------------------

### [Basics]{#BASICS}

The profiler is a tool built in the runtime system that allows you to
know where your program spends time, and which function calls which
function.

The profiler can help to identify pieces of your program that are slower
than expected. 

------------------------------------------------------------------------

### [Syntax]{#SYNTAX}

`fglrun -p `*`program`*[`[`]{.underline}`.42r`[`]`]{.underline}` `[`[`]{.underline}*`argument`*` `[`[`]{.underline}`...`[`]]`]{.underline}

#### Notes:

1.  *program* is the name of the BDL program.
2.  *argument* is a command line argument passed to the program.

------------------------------------------------------------------------

### [Usage]{#USAGE}

In order to use the profiler, you must start the virtual machine with
the **-p** option:

`fglrun -p myprog`

When the program ends, the profiler dumps profiling information to
standard error.

**Warnings:**

1.  Times reported by the profiler can change from one execution to the
    other, depending on the available system resources. You better
    execute the program several times to get an average time.
2.  The profiler does not support parent/child recursive calls, when a
    child function calls its parent function (i.e. Function P calls C
    which calls P again). In this case the output will show negative
    values, because the time spend in the parent function is subtracted
    from the time spend in the child function.

#### [Profiler output: Flat profile]{#PF_FLAT}

The section \"flat profile\" contains the list of the functions called
while the programs was running. It is presented as a five-column table.

+------------+---------------------------------------------------------+
| **Flat profile**                                                     |
+------------+---------------------------------------------------------+
| **Column** | **Description**                                         |
+------------+---------------------------------------------------------+
| `count`    | number of calls for this function                       |
+------------+---------------------------------------------------------+
| `%total`   | Percentage of time spent in this function. Includes     |
|            | time spent in subroutines called from this function.    |
+------------+---------------------------------------------------------+
| `%child`   | Percentage of time spent in the functions called from   |
|            | this function.                                          |
+------------+---------------------------------------------------------+
| `%self`    | Percentage of time spent in this function excluding the |
|            | time spent in subroutines called from this function.    |
+------------+---------------------------------------------------------+
| `name`     | Function name                                           |
+------------+---------------------------------------------------------+

Note : 100% represents the program execution time.

#### [Profiler output: Call graph]{#PF_GRAPH}

The section \"Call graph\" provides for each function: 

1.  The functions that called it, the number of calls, and an estimation
    of the percentage of time spent in these functions.
2.  The functions called, the number of calls, and an estimation of the
    time that was spent in the subroutines called from this function.

+------------+---------------------------------------------------------+
| **Call graph**                                                       |
+------------+---------------------------------------------------------+
| **Name**   | **Description**                                         |
+------------+---------------------------------------------------------+
| `index`    | Each function has an index which appears at the         |
|            | beginning of its primary line.                          |
+------------+---------------------------------------------------------+
| `%total`   | Percentage of time spent in this function. Includes     |
|            | time spent in subroutines called from this function.    |
+------------+---------------------------------------------------------+
| `%self`    | Percentage of time spent in this function excluding the |
|            | time spent in subroutines called from this function.    |
+------------+---------------------------------------------------------+
| `%child`   | Percentage of time spent in the functions called from   |
|            | this function.                                          |
+------------+---------------------------------------------------------+
| `calls/of` | Number of calls / Total number of calls                 |
+------------+---------------------------------------------------------+
| `name`     | Function name                                           |
+------------+---------------------------------------------------------+

Output example:

    index    %total  %self  %child  calls/of    name

    ...
            1.29    0.10    1.18      1/2        <-- main
           24.51    1.18   23.33      1/2        <-- fb
    [4]    25.80    1.29   24.51        2        *** fc
           24.51    1.43   23.08      7/8        --> fa

Description:

- The function **fc** has been called two times (by **main** and **fb**)
  and has called the function **fa** 7 times.
- The function **fa** has been called 8 times in the program.

------------------------------------------------------------------------

### [Example]{#EXAMPLE}

#### Sample program

``` linenumber
01 MAIN
02   DISPLAY "Profiler sample"
03   CALL fB()
04   CALL fC(2)
05 END MAIN
06 
07 FUNCTION fA(from,n_a)
08   DEFINE n_a,i INTEGER
09   DEFINE from STRING
10   FOR i=1 TO n_a
11     DISPLAY "fA "||from||" n:"||i
12   END FOR
13 END FUNCTION
14
15 FUNCTION fB()
16   CALL fA("fB",10)
17   CALL fC(5)
18 END FUNCTION
19
20 FUNCTION fC(n_c)
21   DEFINE n_c INTEGER
22   WHILE n_c > 0
23     CALL fA("fC",2)
24     LET n_c=n_c-1
25   END WHILE
26 END FUNCTION
```

#### Running the profiler

    Flat profile (order by self) 
       count  %total  %child   %self name
          25    88.0     0.0    88.0  rts_display
          72     6.3     0.0     6.3  rts_Concat
           8    85.4    82.0     3.4  fa
           2    25.8    24.5     1.3  fc
           8     0.3     0.0     0.3  rts_forInit
           1    85.6    85.4     0.2  fb
           1    99.9    99.6     0.3  main

    Call graph

    index    %total  %self  %child  calls/of    name
           12.69   12.69    0.00      1/25       <-- main
           75.29   75.29    0.00     24/25       <-- fa
    [1]    87.98   87.98    0.00        25       *** rts_display
    -------------------
            6.35    6.35    0.00     72/72       <-- fa
    [2]     6.35    6.35    0.00        72       *** rts_Concat
    -------------------
           60.90    2.02   58.88      1/8        <-- fb
           24.51    1.43   23.08      7/8        <-- fc
    [3]    85.41    3.45   81.96        8        *** fa
           75.29   75.29    0.00     24/25       --> rts_display
            6.35    6.35    0.00     72/72       --> rts_Concat
            0.33    0.33    0.00      8/8        --> rts_forInit
    -------------------
            1.29    0.10    1.18      1/2        <-- main
           24.51    1.18   23.33      1/2        <-- fb
    [4]    25.80    1.29   24.51        2        *** fc
           24.51    1.43   23.08      7/8        --> fa
    -------------------
            0.33    0.33    0.00      8/8        <-- fa
    [5]     0.33    0.33    0.00        8        *** rts_forInit
    -------------------
           85.61    0.20   85.41      1/1        <-- main
    [6]    85.61    0.20   85.41        1        *** fb
           24.51    1.18   23.33      1/2        --> fc
           60.90    2.02   58.88      1/8        --> fa
    -------------------
           99.94    0.35   99.59      1/1        <-- <top>
    [7]    99.94    0.35   99.59        1        *** main
            1.29    0.10    1.18      1/2        --> fc
           85.61    0.20   85.41      1/1        --> fb
           12.69   12.69    0.00      1/25       --> rts_display
    -------------------

------------------------------------------------------------------------
