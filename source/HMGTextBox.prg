/*

  MiniGUIQt - módulo para Qt4xHb/Qt5xHb com sintaxe no estilo MiniGUI

  Copyright (C) 2017 Marcos Antonio Gambeta <marcosgambeta AT outlook DOT com>

*/

#include "qt5xhb.ch"
#include "hbclass.ch"

//---------------------------------------------------------------------------//

CLASS HMGTextBox INHERIT HMGWidget

   DATA bOnTextChanged
   DATA bOnTextEdited
   DATA bOnReturnPressed

   ACCESS Value INLINE ::oQt:text()
   ASSIGN Value(x) INLINE ::oQt:setText(x)

   METHOD new
   METHOD onTextChanged
   METHOD onTextEdited
   METHOD onReturnPressed

ENDCLASS

//---------------------------------------------------------------------------//

METHOD new (cName,cParent,nX,nY,nWidth,nHeight,cToolTip,cStatusTip,cWhatsThis,cStyleSheet,;
            cFontName,nFontSize,lBold,lItalic,lUnderline,lStrikeOut,;
            cValue,lInvisible,lDisabled,lNoTabStop,bOnGotFocus,bOnLostFocus,bOnChange,;
            bOnEdit,bOnEnter,nMaxLength,lReadOnly,lPassword,lNoBorder,lRightAlign) CLASS HMGTextBox

   LOCAL oParent

   IF !empty(cParent)
      oParent := HMGCore():object(cParent)
   ENDIF

   ::cName := cName

   IF valtype(oParent) == "O"
      ::oQt := QLineEdit():new(oParent:oQt)
      ::cParentName := oParent:cName
   ELSE
      ::oQt := QLineEdit():new(HMGFILO():last():oQt)
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

   IF valtype(bOnChange) == "B"
      ::bOnTextChanged := bOnChange
   ENDIF

   IF valtype(bOnEdit) == "B"
      ::bOnTextEdited := bOnEdit
   ENDIF

   IF valtype(bOnEnter) == "B"
      ::bOnReturnPressed := bOnEnter
   ENDIF

   IF valtype(nMaxLength) == "N"
      ::oQt:setMaxLength(nMaxLength)
   ENDIF

   IF valtype(lReadOnly) == "L"
      IF lReadOnly
         ::oQt:setReadOnly(.T.)
      ENDIF
   ENDIF

   IF valtype(lPassword) == "L"
      IF lPassword
         ::oQt:setEchoMode(QLineEdit_Password)
      ENDIF
   ENDIF

   IF valtype(lNoBorder) == "L"
      IF lNoBorder
         ::oQt:setFrame(.F.)
      ENDIF
   ENDIF

   IF valtype(lRightAlign) == "L"
      IF lRightAlign
         ::oQt:setAlignment(Qt_AlignRight+Qt_AlignVCenter)
      ENDIF
   ENDIF

   ::oQt:onFocusInEvent({||::onFocusInEvent(),.F.})
   ::oQt:onFocusOutEvent({||::onFocusOutEvent(),.F.})
   ::oQt:onTextChanged({||::onTextChanged()})
   ::oQt:onTextEdited({||::onTextEdited()})
   ::oQt:onReturnPressed({||::onReturnPressed()})

RETURN self

//---------------------------------------------------------------------------//

METHOD onTextChanged () CLASS HMGTextBox

   IF valtype(::bOnTextChanged) == "B"
      eval(::bOnTextChanged)
   ENDIF

RETURN NIL

//---------------------------------------------------------------------------//

METHOD onTextEdited () CLASS HMGTextBox

   IF valtype(::bOnTextEdited) == "B"
      eval(::bOnTextEdited)
   ENDIF

RETURN NIL

//---------------------------------------------------------------------------//

METHOD onReturnPressed () CLASS HMGTextBox

   IF valtype(::bOnReturnPressed) == "B"
      eval(::bOnReturnPressed)
   ENDIF

RETURN NIL

//---------------------------------------------------------------------------//
