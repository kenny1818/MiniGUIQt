/*

  MiniGUIQt - módulo para Qt4xHb/Qt5xHb com sintaxe no estilo MiniGUI

  Copyright (C) 2017 Marcos Antonio Gambeta <marcosgambeta AT outlook DOT com>

*/

#include "qt5xhb.ch"
#include "hbclass.ch"

//---------------------------------------------------------------------------//

CLASS HMGMonthCalendar INHERIT HMGWidget

   ACCESS Value INLINE QDateToDate(::oQt:selectedDate())
   ASSIGN Value(x) INLINE ::oQt:setSelectedDate(QDate():new(year(x),month(x),day(x)))

   METHOD new

ENDCLASS

//---------------------------------------------------------------------------//

METHOD new (cName,cParent,nX,nY,nWidth,nHeight,cToolTip,cStatusTip,cWhatsThis,cStyleSheet,;
            cFontName,nFontSize,lBold,lItalic,lUnderline,lStrikeOut,;
            dValue,lInvisible,lDisabled,lNoTabStop,lWeekNumbers,bOnGotFocus,bOnLostFocus) CLASS HMGMonthCalendar

   LOCAL oParent

   IF !empty(cParent)
      oParent := HMGCore():object(cParent)
   ENDIF

   ::cName := cName

   IF valtype(oParent) == "O"
      ::oQt := QCalendarWidget():new(oParent:oQt)
      ::cParentName := oParent:cName
   ELSE
      ::oQt := QCalendarWidget():new(HMGFILO():last():oQt)
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

   IF valtype(dValue) == "D"
      ::oQt:setSelectedDate(QDate():new(year(dValue),month(dValue),day(dValue)))
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

   IF valtype(lWeekNumbers) == "L"
      IF lWeekNumbers
         ::oQt:setVerticalHeaderFormat(QCalendarWidget_ISOWeekNumbers)
      ELSE
         ::oQt:setVerticalHeaderFormat(QCalendarWidget_NoVerticalHeader)
      ENDIF
   ENDIF

   IF valtype(bOnGotFocus) == "B"
      ::bOnFocusInEvent := bOnGotFocus
   ENDIF

   IF valtype(bOnLostFocus) == "B"
      ::bOnFocusOutEvent := bOnLostFocus
   ENDIF

   ::oQt:onFocusInEvent({||::onFocusInEvent(),.F.})
   ::oQt:onFocusOutEvent({||::onFocusOutEvent(),.F.})

RETURN self

//---------------------------------------------------------------------------//

STATIC FUNCTION QDateToDate (oDate)

   LOCAL cDate := ""

   cDate += strzero(oDate:year(),4)
   cDate += strzero(oDate:month(),2)
   cDate += strzero(oDate:day(),2)

RETURN STOD(cDate)

//---------------------------------------------------------------------------//
