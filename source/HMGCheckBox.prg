/*

  MiniGUIQt - módulo para Qt4xHb/Qt5xHb com sintaxe no estilo MiniGUI

  Copyright (C) 2017 Marcos Antonio Gambeta <marcosgambeta AT outlook DOT com>

*/

#include "qt5xhb.ch"
#include "hbclass.ch"

//---------------------------------------------------------------------------//

CLASS HMGCheckBox INHERIT HMGWidget

   DATA bOnStateChanged

   ACCESS Caption INLINE ::oQt:text()
   ASSIGN Caption(x) INLINE ::oQt:setText(x)

   METHOD new
   METHOD onStateChanged

ENDCLASS

//---------------------------------------------------------------------------//

METHOD new (cName,cParent,nX,nY,nWidth,nHeight,cToolTip,cStatusTip,cWhatsThis,cStyleSheet,;
            cFontName,nFontSize,lBold,lItalic,lUnderline,lStrikeOut,;
            cCaption,lValue,lInvisible,lDisabled,lNoTabStop,bOnChange,bOnGotFocus,bOnLostFocus) CLASS HMGCheckBox

   LOCAL oParent

   IF !empty(cParent)
      oParent := HMGCore():object(cParent)
   ENDIF

   ::cName := cName

   IF valtype(oParent) == "O"
      ::oQt := QCheckBox():new(oParent:oQt)
      ::cParentName := oParent:cName
   ELSE
      ::oQt := QCheckBox():new(HMGFILO():last():oQt)
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

   IF valtype(lValue) == "L"
      IF lValue
         ::oQt:setCheckState(Qt_Checked)
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

   IF valtype(bOnChange) == "B"
      ::bOnStateChanged := bOnChange
   ENDIF

   IF valtype(bOnGotFocus) == "B"
      ::bOnFocusInEvent := bOnGotFocus
   ENDIF

   IF valtype(bOnLostFocus) == "B"
      ::bOnFocusOutEvent := bOnLostFocus
   ENDIF

   ::oQt:onStateChanged({||::onStateChanged()})
   ::oQt:onFocusInEvent({||::onFocusInEvent(),.F.})
   ::oQt:onFocusOutEvent({||::onFocusOutEvent(),.F.})

RETURN self

//---------------------------------------------------------------------------//

METHOD onStateChanged () CLASS HMGCheckBox

   IF valtype(::bOnStateChanged) == "B"
      eval(::bOnStateChanged)
   ENDIF

RETURN NIL

//---------------------------------------------------------------------------//
