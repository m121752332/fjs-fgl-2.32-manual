[Back to Contents](../index.html)

------------------------------------------------------------------------

# [Source Code Editing]{#PAGE_HEADER}

Summary:

- [Introduction](#INTRO)
- [Choosing the correct locale](#LOCALE)
- [Avoiding TABs in screen layouts](#NOTABS)
- [Automatic Code Completion and Syntax Highlighting with VIM](#VIM_AC)

------------------------------------------------------------------------

### [Introduction]{#INTRO}

This page discusses topics concerning Genero BDL source code editing.
You are free to use your preferred source code editor to write your
programs.

------------------------------------------------------------------------

### [Avoid TABs in screen layouts]{#NOTABS}

When editing **.per** form files, pay attention to the
[LAYOUT](FormSpecFiles.html#SECTION_LAYOUT)/[SCREEN](FormSpecFiles.html#SECTION_SCREEN)
section, and try to avoid TAB characters in the curly-brace delimited
grid areas. Different kinds of text or source code editors can expand
TABs differently, according to the configuration settings (like 4 or 8
blanks). As a result, if two programmers are using different TAB
expansion settings, the form layout will display in different ways.

If used in a grid area, a TAB character will be interpreted as 8 blanks
by [fglform](Tools.html#TL_FGLFORM). It is legal to use TABs in the rest
of the .per file or .4gl sources (for example, to indent the code). 

------------------------------------------------------------------------

### [Choosing the correct locale]{#LOCALE}

Before starting to edit source files, you must identify and set the
locale (character set) you want to use in your sources.

Genero BDL supports single-byte and multi-byte character sets. When
developing multi-lingual applications, we recommend that you write
**.per** and **.4gl** source files in ASCII, and externalize
language-dependent messages in string resource files.

For more details, see [Localization](Localization.html).

------------------------------------------------------------------------

### [Automatic Code Completion and Syntax Highlighting with VIM]{#VIM_AC}

If you are using the **vim** editor, Genero BDL provides automatic code
completion and syntax highlighting with [fglcomp](Tools.html#TL_FGLCOMP)
and [fglform](Tools.html#TL_FGLFORM) compilers.

**Warning: In order to use Genero BDL auto completion with vim, you need
at least vim version 7 with the [Omni Completion]{.underline} feature.**

To get the benefit of this feature with the **vim** editor, do the
following:

1.  Copy **\$FGLDIR/lib/fglcomplete.vim** into the  **\~/.vim/autoload**
    directory.\
2.  Copy **\$FGLDIR/lib/fgl.vim** into the  **\~/.vim/syntax**
    directory.\
3.  Copy **\$FGLDIR/lib/per.vim** into the  **\~/.vim/syntax**
    directory.\
4.  According to the version and the default settings of vim, you might
    need to add the following lines to your **\~/.vimrc** file:\
    \
    ` autocmd Filetype fgl setlocal omnifunc=fglcomplete#Complete`\
    ` autocmd Filetype per setlocal omnifunc=fglcomplete#Complete`\
    ` syntax on`\
    ` au BufNewFile,BufRead *.per setlocal filetype=per`

Once these steps are done (make sure that you have set a Genero BDL
environment), you can use automatic code completion; open a **.4gl** or
**.per** file, start to edit the file, and when you are in *vim insert
mode*, press **Control-X** followed by **Control-O** to get a list of
language elements to complete the BDL instruction syntax or expression.

For more details about vim, see <http://www.vim.org>.
