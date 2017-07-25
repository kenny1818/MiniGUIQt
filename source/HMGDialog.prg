/*

  MiniGUIQt - módulo para Qt4xHb/Qt5xHb com sintaxe no estilo MiniGUI

  Copyright (C) 2017 Marcos Antonio Gambeta <marcosgambeta AT outlook DOT com>

*/

#include "qt5xhb.ch"
#include "hbclass.ch"

//---------------------------------------------------------------------------//

CLASS HMGDialog INHERIT HMGWindow

   DATA lModal INIT .F.

   METHOD new
   METHOD activate

ENDCLASS

//---------------------------------------------------------------------------//

METHOD new (cName,cParent,nX,nY,nWidth,nHeight,cToolTip,cStyleSheet,;
            cFontName,nFontSize,lBold,lItalic,lUnderline,lStrikeOut,;
            cTitle,lModal,lCharacters,bOnInit,bOnRelease,aFontColor,aBackColor) CLASS HMGDialog

   LOCAL oParent
   LOCAl oFontMetrics

   IF !empty(cParent)
      oParent := HMGCore():object(cParent)
   ENDIF

   ::cName := cName

   IF valtype(oParent) == "O"
      ::oQt := QDialog():new(oParent:oQt)
      ::cParentName := oParent:cName
   ELSE
      ::oQt := QDialog():new()
      ::cParentName := ""
   ENDIF

   ::lCharacters := lCharacters

   ::configFont(cFontName,nFontSize,lBold,lItalic,lUnderline,lStrikeOut)

   IF ::lCharacters
      oFontMetrics := QFontMetrics():new(QFont():new(::oQt:font()):setBold(.F.):setItalic(.F.):setUnderline(.F.):setStrikeOut(.F.))
      ::nCharWidth := oFontMetrics:averageCharWidth()
      ::nCharHeight := oFontMetrics:height()
      oFontMetrics:delete()
   ENDIF

   ::configGeometry(nX,nY,nWidth,nHeight)

   IF valtype(cToolTip) == "C"
      ::oQt:setToolTip(cToolTip)
   ENDIF

   IF valtype(cStyleSheet) == "C"
      ::oQt:setStyleSheet(cStyleSheet)
   ENDIF

   IF valtype(cTitle) == "C"
      ::oQt:setWindowTitle(cTitle)
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

   ::lModal := lModal

RETURN self

//---------------------------------------------------------------------------//

METHOD activate (lMaximized,lMinimized,lFullScreen,lNoShow) CLASS HMGDialog

   IF ::lModal
      ::oQt:exec()
   ELSE
      ::show()
      DO WHILE !::lClose
         QCoreApplication():processEvents()
      ENDDO
   ENDIF

RETURN NIL

//---------------------------------------------------------------------------//
