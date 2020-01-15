/*

  MiniGUIQt - módulo para Qt4xHb/Qt5xHb com sintaxe no estilo MiniGUI

  Copyright (C) 2020 Marcos Antonio Gambeta <marcosgambeta AT outlook DOT com>

*/

#include "qt5xhb.ch"
#include "hbclass.ch"

//---------------------------------------------------------------------------//

CLASS HMGDatePicker INHERIT HMGWidget

   DATA oActionButton
   DATA bOnReturnPressed

   ACCESS Value INLINE ctod(::oQt:text())
   ASSIGN Value(x) INLINE ::oQt:setText(transform(x,"99/99/9999"))

   METHOD new
   METHOD onReturnPressed
   METHOD showCalendar

ENDCLASS

//---------------------------------------------------------------------------//

METHOD new (cName,cParent,nX,nY,nWidth,nHeight,cToolTip,cStatusTip,cWhatsThis,cStyleSheet,;
            cFontName,nFontSize,lBold,lItalic,lUnderline,lStrikeOut,;
            dValue,lInvisible,lDisabled,lNoTabStop,bOnGotFocus,bOnLostFocus,bOnEnter,;
            lRightAlign,lNoBorder,lReadOnly) CLASS HMGDatePicker

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

   ::oQt:setInputMask("00/00/0000")
   ::oQt:show()
   ::oActionButton := QPushButton():new("...",::oQt:parent())
   ::oActionButton:move(::oQt:x()+::oQt:width(),::oQt:y())
   ::oActionButton:resize(30,::oQt:height())
   ::oActionButton:setFocusPolicy(Qt_NoFocus)
   ::oActionButton:onClicked({||::showcalendar()})

   IF valtype(dValue) == "D"
      ::oQt:setText(transform(dValue,"99/99/9999"))
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

   IF valtype(bOnEnter) == "B"
      ::bOnReturnPressed := bOnEnter
   ENDIF

   IF valtype(lRightAlign) == "L"
      IF lRightAlign
         ::oQt:setAlignment(Qt_AlignRight+Qt_AlignVCenter)
      ENDIF
   ENDIF

   IF valtype(lNoBorder) == "L"
      IF lNoBorder
         ::oQt:setFrame(.F.)
      ENDIF
   ENDIF

   IF valtype(lReadOnly) == "L"
      IF lReadOnly
         ::oQt:setReadOnly(.T.)
      ENDIF
   ENDIF

   ::oQt:onFocusInEvent({||::onFocusInEvent(),.F.})
   ::oQt:onFocusOutEvent({||::onFocusOutEvent(),.F.})
   ::oQt:onReturnPressed({||::onReturnPressed()})

RETURN self

//---------------------------------------------------------------------------//

METHOD onReturnPressed () CLASS HMGDatePicker

   IF valtype(::bOnReturnPressed) == "B"
      eval(::bOnReturnPressed)
   ENDIF

RETURN NIL

//---------------------------------------------------------------------------//

METHOD showCalendar () CLASS HMGDatePicker

   LOCAL oDialog
   LOCAL oCalendar
   LOCAL oPos
   LOCAL dDate

   dDate := ctod(::oQt:text())

   oPos := ::oQt:mapToGlobal(QPoint():new(0,0))

   oPos:setY( oPos:y() + ::oQt:height() )

   oDialog := QDialog():new(::oQt:parent(),Qt_Popup):resize(320,240):move(oPos)

   oCalendar := QCalendarWidget():new(oDialog):move(0,0):resize(320,240)

   IF !empty(dDate)
      oCalendar:setSelectedDate(QDate():new(year(dDate),month(dDate),day(dDate)))
   ENDIF

   oCalendar:onActivated({|pObject,pDate|oDate:=QDate():newFrom(pDate),::oQt:setText(strzero(oDate:day(),2)+"/"+strzero(oDate:month(),2)+"/"+strzero(oDate:year(),4)),oDialog:done(0)})

   oCalendar:setFocus()

   oDialog:exec()

   oCalendar:onActivated()

   oDialog:delete()

   ::oQt:setFocus()

RETURN NIL

//---------------------------------------------------------------------------//
