::: {align="center"}
+---------------------------------------------------+-----------------------------------+
| # Genero Business Development Language User Guide |                                   |
|                                                   |                                   |
|   -----------------------                         |                                   |
|   **Version**: **2.32**                           |                                   |
|   -----------------------                         |                                   |
+---------------------------------------------------+-----------------------------------+
:::

\

::: {align="center"}
+:--------------------------------------------------------:+:------------------------------------------------------------:+:--------------------------------------------:+:------------------------------------------:+
| ## [Genero Business Development Language]{#REFERENCE} {#genero-business-development-language align="center"}                                                                                                        |
+----------------------------------------------------------+--------------------------------------------------------------+----------------------------------------------+--------------------------------------------+
| **General**                                              | **Language Basics**                                          | **Advanced Features**                        | **Upgrading**                              |
+----------------------------------------------------------+--------------------------------------------------------------+----------------------------------------------+--------------------------------------------+
| - [Introduction](User/IntroBDL.html)                     | - [Data Types](User/DataTypes.html)                          | - [Programs](User/Programs.html)             | - [New Features](User/NewFeatures.html)    |
| - [Documentation Conventions](User/DocConv.html)         | - [Literals](User/Literals.html)                             | - [Database                                  | - [I4GL Migration                          |
| - [Language Features](User/LanguageFeatures.html)        | - [Expressions](User/Expressions.html)                       |   Schema](User/DatabaseSchema.html)          |   Guide](User/MigI4GL.html)                |
| - [Common Terms](User/FglTerms.html)                     | - [Basic Syntax Elements](User/Operators.html)               | - [Globals](User/Globals.html)               | - [BDS Migration Guide](User/Mig0000.html) |
| - [Dynamic User Interface](User/DynamicUI.html)          | - [Exceptions](User/Exceptions.html)                         | - [Flow Control](User/FlowControl.html)      | - [1.3x Upgrade Guide](User/Mig0001.html)  |
| - [Installation and Setup](User/Installation.html)       | - [Variables](User/Variables.html)                           | - [Functions](User/Functions.html)           | - [2.0x Upgrade Guide](User/Mig0002.html)  |
| - [Tools and Components](User/Tools.html)                | - [Constants](User/Constants.html)                           | - [Localization](User/Localization.html)     | - [2.1x Upgrade Guide](User/Mig0003.html)  |
| - [FAQ List](User/FAQList.html)                          | - [Records](User/Records.html)                               | - [Localized                                 | - [2.2x Upgrade Guide](User/Mig0004.html)  |
| - [General Index](User/SearchIndex.html)                 | - [Arrays](User/Arrays.html)                                 |   Strings](User/LocalizedStrings.html)       | - [2.3x Upgrade Guide](User/Mig0005.html)  |
|                                                          | - [User Types](User/UserTypes.html)                          | - [Data                                      |                                            |
|                                                          | - [Built-in Classes](User/BuiltInClasses.html)               |   Conversions](User/DataConversions.html)    |                                            |
|                                                          |                                                              | - [Environment                               |                                            |
|                                                          |                                                              |   Variables](User/EnvironmentVariables.html) |                                            |
|                                                          |                                                              | - [FGLPROFILE](User/FglProfile.html)         |                                            |
|                                                          |                                                              | - [Reports](User/Reports.html)               |                                            |
+----------------------------------------------------------+--------------------------------------------------------------+----------------------------------------------+--------------------------------------------+
| **SQL Management**                                       | **User Interface (1)**                                       | **User Interface (2)**                       | **User Interface (3)**                     |
+----------------------------------------------------------+--------------------------------------------------------------+----------------------------------------------+--------------------------------------------+
| - [Database Connections](User/Connections.html)          | - [Interaction Model](User/InteractionModel.html)            | - [Menus](User/Menus.html)                   | - [Toolbars](User/Toolbars.html)           |
| - [Transactions](User/Transactions.html)                 | - [Windows and Forms](User/WindowsAndForms.html)             | - [Record Display](User/RecordDisplay.html)  | - [Topmenus](User/Topmenus.html)           |
| - [Static SQL](User/StaticSql.html)                      | - [Action Defaults](User/ActionDefaults.html)                | - [Record Input](User/RecordInput.html)      | - [Tree Views](User/TreeViews.html)        |
| - [Dynamic SQL](User/DynamicSql.html)                    | - [Presentation Styles](User/PresentationStyles.html)        | - [Array Display](User/DisplayArray.html)    | - [Drag & Drop](User/DragAndDrop.html)     |
| - [Result Sets](User/ResultSets.html)                    | - [Form Specification Files](User/FormSpecFiles.html)        | - [Array Input](User/InputArray.html)        | - [Web Component](User/WebComponent.html)  |
| - [Positioned Updates](User/PositionedUpdates.html)      | - [Form Attributes](User/FSFAttributes.html)                 | - [Query By Example](User/Construct.html)    | - [StartMenus](User/StartMenus.html)       |
| - [Insert Cursors](User/InsertCursors.html)              | - [Form Rendering](User/Layout.html)                         | - [Multiple                                  | - [Canvas](User/Canvas.html)               |
| - [I/O SQL Instructions](User/InOutSql.html)             |                                                              |   Dialogs](User/MultipleDialogs.html)        | - [Message Files](User/MessageFiles.html)  |
| - [SQL Programming](User/SqlProgramming.html)            |                                                              | - [Prompt for Values](User/Prompt.html)      | - [MDI Windows](User/MDIWindows.html)      |
|                                                          |                                                              | - [Displaying                                | - [Front End                               |
|                                                          |                                                              |   Messages](User/MessageDisplay.html)        |   Functions](User/FrontEndFunctions.html)  |
|                                                          |                                                              |                                              | - [Front End                               |
|                                                          |                                                              |                                              |   Protocol](User/FEProtocol.html)          |
+----------------------------------------------------------+--------------------------------------------------------------+----------------------------------------------+--------------------------------------------+
| **Built-in Classes (1)**                                 | **Built-in Classes (2)**                                     | **Programming**                              | **Tutorial**                               |
+----------------------------------------------------------+--------------------------------------------------------------+----------------------------------------------+--------------------------------------------+
| - [base.Application](User/ClassApplication.html)         | - [om.DomDocument](User/ClassDomDocument.html)               | - [Compiling                                 | - [Summary](User/TutIndex.html)            |
| - [base.Channel](User/ClassChannel.html)                 | - [om.DomNode](User/ClassDomNode.html)                       |   Programs](User/CompilingPrograms.html)     | - [Overview](User/TutChap01.html)          |
| - [base.StringBuffer](User/ClassStringBuffer.html)       | - [om.NodeList](User/ClassNodeList.html)                     | - [Debugger](User/Debugger.html)             | - [Using Genero BDL](User/TutChap02.html)  |
| - [base.StringTokenizer](User/ClassStringTokenizer.html) | - [om.SaxAttributes](User/ClassSaxAttributes.html)           | - [Program Profiler](User/Profiler.html)     | - [Displaying Data                         |
| - [base.TypeInfo](User/ClassTypeInfo.html)               | - [om.SaxDocumentHandler](User/ClassSaxDocumentHandler.html) | - [Optimization](User/Optimization.html)     |   (Windows/Forms)](User/TutChap03.html)    |
| - [base.MessageServer](User/ClassMessageServer.html)     | - [om.XmlReader](User/ClassXmlReader.html)                   | - [Preprocessor](User/Preprocessor.html)     | - [Query by Example](User/TutChap04.html)  |
| - [ui.Interface](User/ClassInterface.html)               | - [om.XmlWriter](User/ClassXmlWriter.html)                   | - [File                                      | - [Enhancing the                           |
| - [ui.Window](User/ClassWindow.html)                     |                                                              |   Extensions](User/FileExtensions.html)      |   Form](User/TutChap05.html)               |
| - [ui.Form](User/ClassForm.html)                         |                                                              | - [FGL Errors](User/FglErrors.html)          | - [Add/Update/Delete](User/TutChap06.html) |
| - [ui.Dialog](User/ClassDialog.html)                     |                                                              | - [Automatic source documentation            | - [Array Display](User/TutChap07.html)     |
| - [ui.ComboBox](User/ClassComboBox.html)                 |                                                              |   generator](User/AutoDoc.html)              | - [Array Input](User/TutChap08.html)       |
| - [ui.DragDrop](User/ClassDragDrop.html)                 |                                                              | - [Source code                               | - [Reports](User/TutChap09.html)           |
|                                                          |                                                              |   editing](User/CodeEditing.html)            | - [Localization](User/TutChap10.html)      |
|                                                          |                                                              |                                              | - [Master/Detail](User/TutChap11.html)     |
|                                                          |                                                              |                                              | - [Changing the User Interface             |
|                                                          |                                                              |                                              |   Dynamically](User/TutChap12.html)        |
|                                                          |                                                              |                                              | - [Master/Detail using Multiple            |
|                                                          |                                                              |                                              |   Dialogs](User/TutChap13.html)            |
+----------------------------------------------------------+--------------------------------------------------------------+----------------------------------------------+--------------------------------------------+
| **ODI Adaptation Guides**                                | **Library**                                                  | **Extending the Language**                   |                                            |
+----------------------------------------------------------+--------------------------------------------------------------+----------------------------------------------+--------------------------------------------+
| - [Genero db](User/odiagads.html)                        | - [Built-in Functions](User/BuiltInFunctions.html)           | - [Java Interface](User/JavaBridge.html)     |                                            |
| - [IBM Informix](User/odiagifx.html)                     | - [Utility Functions](User/UtilityFunctions.html)            | - [C-Extensions](User/CExtensions.html)      |                                            |
| - [IBM DB2 UDB](User/odiagdb2.html)                      | - [DDE Support](User/WinDDE.html)                            |                                              |                                            |
| - [Microsoft SQL Server](User/odiagmsv.html)             | - [XML Utilities](User/XmlUtils.html)                        |                                              |                                            |
| - [MySQL](User/odiagmys.html)                            | - [File Manipulation functions](User/Ext_os_Path.html)       |                                              |                                            |
| - [Oracle Server](User/odiagora.html)                    | - [Mathematical functions](User/Ext_util_Math.html)          |                                              |                                            |
| - [PostgreSQL](User/odiagpgs.html)                       |                                                              |                                              |                                            |
| - [SQLite](User/odiagsqt.html)                           |                                                              |                                              |                                            |
| - [Sybase ASE](User/odiagase.html)                       |                                                              |                                              |                                            |
| - [Sybase ASA](User/odiagasa.html)                       |                                                              |                                              |                                            |
+----------------------------------------------------------+--------------------------------------------------------------+----------------------------------------------+--------------------------------------------+
:::
