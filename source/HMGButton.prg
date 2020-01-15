/*

  MiniGUIQt - módulo para Qt4xHb/Qt5xHb com sintaxe no estilo MiniGUI

  Copyright (C) 2020 Marcos Antonio Gambeta <marcosgambeta AT outlook DOT com>

*/

#include "qt5xhb.ch"
#include "hbclass.ch"

//---------------------------------------------------------------------------//

CLASS HMGButton INHERIT HMGWidget

   DATA bOnClicked

   ACCESS Caption INLINE ::oQt:text()
   ASSIGN Caption(x) INLINE ::oQt:setText(x)

   METHOD new
   METHOD onClicked

ENDCLASS

//---------------------------------------------------------------------------//

METHOD new (cName,cParent,nX,nY,nWidth,nHeight,cToolTip,cStatusTip,cWhatsThis,cStyleSheet,;
            cFontName,nFontSize,lBold,lItalic,lUnderline,lStrikeOut,;
            cCaption,bAction,lFlat,lDefault,lInvisible,lDisabled,lNoTabStop,bOnGotFocus,bOnLostFocus,aFontColor,aBackColor) CLASS HMGButton

   LOCAL oParent

   IF !empty(cParent)
      oParent := HMGCore():object(cParent)
   ENDIF

   ::cName := cName

   IF valtype(oParent) == "O"
      ::oQt := QPushButton():new(oParent:oQt)
      ::cParentName := oParent:cName
   ELSE
      ::oQt := QPushButton():new(HMGFILO():last():oQt)
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

   IF valtype(cCaption) == "C"
      ::oQt:setText(cCaption)
   ENDIF

   IF valtype(bAction) == "B"
      ::bOnClicked := bAction
   ENDIF

   IF valtype(lFlat) == "L"
      ::oQt:setFlat(lFlat)
   ENDIF

   IF valtype(lDefault) == "L"
      IF lDefault
         ::oQt:setDefault(.T.)
      ENDIF
   ENDIF

   IF valtype(lInvisible) == "L"
      IF lInvisible
         ::oQt:setVisible(.F.)
      ENDIF
   ENDIF

   IF valtype(lDisabled) == "L"
      IF lDisabled
         ::oQt:setEnabled(.F.)
      ENDIF
   ENDIF

   IF valtype(lNoTabStop) == "L"
      IF lNoTabStop
         ::oQt:setFocusPolicy(Qt_NoFocus)
      ENDIF
   ENDIF

   IF valtype(bOnGotFocus) == "B"
      ::bOnFocusInEvent := bOnGotFocus
   ENDIF

   IF valtype(bOnLostFocus) == "B"
      ::bOnFocusOutEvent := bOnLostFocus
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

   ::oQt:onClicked({||::onClicked()})
   ::oQt:onFocusInEvent({||::onFocusInEvent(),.F.})
   ::oQt:onFocusOutEvent({||::onFocusOutEvent(),.F.})

RETURN self

//---------------------------------------------------------------------------//

METHOD onClicked () CLASS HMGButton

   IF valtype(::bOnClicked) == "B"
      eval(::bOnClicked)
   ENDIF

RETURN NIL

//---------------------------------------------------------------------------//
