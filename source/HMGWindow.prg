/*

  MiniGUIQt - módulo para Qt4xHb/Qt5xHb com sintaxe no estilo MiniGUI

  Copyright (C) 2017 Marcos Antonio Gambeta <marcosgambeta AT outlook DOT com>

*/

#include "qt5xhb.ch"
#include "hbclass.ch"

//---------------------------------------------------------------------------//

CLASS HMGWindow INHERIT HMGWidget

   DATA lMain INIT .F.
   DATA lChild INIT .F.
   DATA lClose INIT .F.

   DATA bOnInit
   DATA bOnRelease

   ACCESS Title INLINE ::oQt:windowTitle()
   ASSIGN Title(x) INLINE ::oQt:setWindowTitle(x)

   METHOD new
   METHOD activate
   METHOD center
   METHOD release
   METHOD maximize
   METHOD minimize
   METHOD restore

ENDCLASS

//---------------------------------------------------------------------------//

METHOD new (cName,cParent,nX,nY,nWidth,nHeight,cToolTip,cStyleSheet,;
            cFontName,nFontSize,lBold,lItalic,lUnderline,lStrikeOut,;
            cTitle,lMain,lChild,bOnInit,bOnRelease,aFontColor,aBackColor) CLASS HMGWindow

   LOCAL oParent
   LOCAL oPalette

   IF !empty(cParent)
      oParent := HMGCore():object(cParent)
   ENDIF

   ::cName := cName

   IF valtype(oParent) == "O"
      ::oQt := QMainWindow():new(oParent:oQt)
      ::cParentName := oParent:cName
   ELSE
      ::oQt := QMainWindow():new()
      ::cParentName := ""
   ENDIF

   ::configGeometry(nX,nY,nWidth,nHeight)

   IF valtype(cToolTip) == "C"
      ::oQt:setToolTip(cToolTip)
   ENDIF

   IF valtype(cStyleSheet) == "C"
      ::oQt:setStyleSheet(cStyleSheet)
   ENDIF

   ::configFont(cFontName,nFontSize,lBold,lItalic,lUnderline,lStrikeOut)

   IF valtype(cTitle) == "C"
      ::oQt:setWindowTitle(cTitle)
   ENDIF

   IF valtype(bOnInit) == "B"
      ::bOnInit := bOnInit
   ENDIF

   IF valtype(bOnRelease) == "B"
      ::bOnRelease := bOnRelease
   ENDIF

   IF valtype(aFontColor) == "A"
      IF len(aFontColor) == 3
         oPalette := ::oQt:palette()
         oPalette:setColor(QPalette_WindowText, QColor():new(aFontColor[1],aFontColor[2],aFontColor[3]))
      ENDIF
   ENDIF

   IF valtype(aBackColor) == "A"
      IF len(aBackColor) == 3
         oPalette := ::oQt:palette()
         oPalette:setColor(QPalette_Window, QColor():new(aBackColor[1],aBackColor[2],aBackColor[3]))
      ENDIF
   ENDIF


   ::lMain := lMain
   ::lChild := lChild

   IF valtype(::bOnInit) == "B"
      eval(::bOnInit)
   ENDIF

RETURN self

//---------------------------------------------------------------------------//

METHOD activate (lMaximized,lMinimized,lFullScreen,lNoShow) CLASS HMGWindow

   ::show()

   // quando uma janela main é ativada, a aplicação entra em execução
   IF ::lMain
      QApplication():exec()
   ENDIF

   // quando uma janela child é ativada, um loop entra em execução até a propriedade lClose ser .T.
   IF ::lChild
      DO WHILE !::lClose
         QCoreApplication():processEvents()
      ENDDO
   ENDIF

RETURN NIL

//---------------------------------------------------------------------------//

METHOD center () CLASS HMGWindow

   LOCAL oApp

   oApp := QApplication():newFrom(QCoreApplication():instance())

   ::oQt:setGeometry(QStyle():alignedRect(Qt_LeftToRight,Qt_AlignCenter,::oQt:size(),oApp:desktop():availableGeometry()))

RETURN NIL

//---------------------------------------------------------------------------//

METHOD release () CLASS HMGWindow

   IF valtype(::bOnRelease) == "B"
      eval(::bOnRelease)
   ENDIF

   ::oQt:disconnectAllSignals(.T.)
   ::oQt:disconnectAllEvents(.T.)
   ::oQt:delete()

   HMGCore():delObject(::cName)

RETURN NIL

//---------------------------------------------------------------------------//

METHOD maximize () CLASS HMGWindow

   ::oQt:showMaximized()

RETURN NIL

//---------------------------------------------------------------------------//

METHOD minimize () CLASS HMGWindow

   ::oQt:showMinimized()

RETURN NIL

//---------------------------------------------------------------------------//

METHOD restore () CLASS HMGWindow

   ::oQt:showNormal()

RETURN NIL

//---------------------------------------------------------------------------//
