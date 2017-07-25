/*

  MiniGUIQt - módulo para Qt4xHb/Qt5xHb com sintaxe no estilo MiniGUI

  Copyright (C) 2017 Marcos Antonio Gambeta <marcosgambeta AT outlook DOT com>

*/

#include "qt5xhb.ch"
#include "hbclass.ch"

//---------------------------------------------------------------------------//

CLASS HMGLabel INHERIT HMGWidget

   ACCESS Value INLINE ::oQt:text()
   ASSIGN Value(x) INLINE ::oQt:setText(x)

   METHOD new

ENDCLASS

//---------------------------------------------------------------------------//

METHOD new (cName,cParent,nX,nY,nWidth,nHeight,cToolTip,cStatusTip,cWhatsThis,cStyleSheet,;
            cFontName,nFontSize,lBold,lItalic,lUnderline,lStrikeOut,;
            cValue,lInvisible,aFontColor,aBackColor) CLASS HMGLabel

   LOCAL oParent

   IF !empty(cParent)
      oParent := HMGCore():object(cParent)
   ENDIF

   ::cName := cName

   IF valtype(oParent) == "O"
      ::oQt := QLabel():new(oParent:oQt)
      ::cParentName := oParent:cName
   ELSE
      ::oQt := QLabel():new(HMGFILO():last():oQt)
      ::cParentName := HMGFILO():last():cName
   ENDIF

   ::lCharacters := HMGCore():object(::cParentName):lCharacters

   ::configFont(cFontName,nFontSize,lBold,lItalic,lUnderline,lStrikeOut)

   IF ::lCharacters
      oFontMetrics := QFontMetrics():new(QFont():new(::oQt:font()):setBold(.F.):setItalic(.F.):setUnderline(.F.):setStrikeOut(.F.))
      ::nCharWidth := oFontMetrics:averageCharWidth()
      ::nCharHeight := oFontMetrics:height()
      oFontMetrics:delete()
   ENDIF

   ::configGeometry(nX,nY,nWidth,nHeight)

   ::configTips(cToolTip,cStatusTip,cWhatsThis)

   IF valtype(cStyleSheet) == "C"
      ::oQt:setStyleSheet(cStyleSheet)
   ENDIF

   IF valtype(cValue) == "C"
      ::oQt:setText(cValue)
   ENDIF

   IF valtype(lInvisible) == "L"
      IF lInvisible
         ::oQt:setVisible(.F.)
      ENDIF
   ENDIF

   IF valtype(aFontColor) == "A"
      IF len(aFontColor) == 3
         oPalette := ::oQt:palette()
         oPalette:setColor(QPalette_WindowText, QColor():new(aFontColor[1],aFontColor[2],aFontColor[3]))
      ENDIF
   ENDIF

   IF valtype(aBackColor) == "A"
      IF len(aBackColor) == 3
         ::oQt:setAutoFillBackground(.T.)
         oPalette := ::oQt:palette()
         oPalette:setColor(QPalette_Window, QColor():new(aBackColor[1],aBackColor[2],aBackColor[3]))
      ENDIF
   ENDIF

RETURN self

//---------------------------------------------------------------------------//
