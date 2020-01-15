/*

  MiniGUIQt - módulo para Qt4xHb/Qt5xHb com sintaxe no estilo MiniGUI

  Copyright (C) 2020 Marcos Antonio Gambeta <marcosgambeta AT outlook DOT com>

*/

#include "qt5xhb.ch"
#include "hbclass.ch"

/*
  Classe base para todos os objetos visuais
*/

//---------------------------------------------------------------------------//

CLASS HMGWidget

   DATA oQt

   DATA cName
   DATA cParentName

   ACCESS Name INLINE ::cName
   ASSIGN Name(x) INLINE ::cName := x

   ACCESS Parent INLINE ::cParentName
   ASSIGN Parent(x) INLINE ::cParentName := x

   ACCESS ParentName INLINE ::cParentName
   ASSIGN ParentName(x) INLINE ::cParentName := x

   ACCESS Row INLINE ::oQt:y()
   ASSIGN Row(x) INLINE ::oQt:move(::oQt:x(),x)

   ACCESS Col INLINE ::oQt:x()
   ASSIGN Col(x) INLINE ::oQt:move(x,::oQt:y())

   ACCESS Width INLINE ::oQt:width()
   ASSIGN Width(x) INLINE ::oQt:resize(x,::oQt:height())

   ACCESS Height INLINE ::oQt:height()
   ASSIGN Height(x) INLINE ::oQt:resize(::oQt:width(),x)

   DATA bOnFocusInEvent
   DATA bOnFocusOutEvent

   METHOD show
   METHOD hide
   METHOD setFocus

   METHOD onFocusInEvent
   METHOD onFocusOutEvent

   METHOD configGeometry // método de uso interno
   METHOD configTips     // método de uso interno
   METHOD configFont     // método de uso interno

   DATA lCharacters INIT .F.
   DATA nCharWidth INIT 1
   DATA nCharHeight INIT 1

ENDCLASS

//---------------------------------------------------------------------------//

METHOD show () CLASS HMGWidget

   ::oQt:show()

RETURN NIL

//---------------------------------------------------------------------------//

METHOD hide () CLASS HMGWidget

   ::oQt:hide()

RETURN NIL

//---------------------------------------------------------------------------//

METHOD setFocus () CLASS HMGWidget

   ::oQt:setFocus()

RETURN NIL

//---------------------------------------------------------------------------//

METHOD onFocusInEvent () CLASS HMGWidget

   IF valtype(::bOnFocusInEvent) == "B"
      eval(::bOnFocusInEvent)
   ENDIF

RETURN NIL

//---------------------------------------------------------------------------//

METHOD onFocusOutEvent () CLASS HMGWidget

   IF valtype(::bOnFocusOutEvent) == "B"
      eval(::bOnFocusOutEvent)
   ENDIF

RETURN NIL

//---------------------------------------------------------------------------//

METHOD configGeometry (nX,nY,nWidth,nHeight) CLASS HMGWidget

   IF valtype(nX) == "N"
      ::oQt:move(nX*::nCharWidth,::oQt:y())
   ENDIF

   IF valtype(nY) == "N"
      ::oQt:move(::oQt:x(),nY*::nCharHeight)
   ENDIF

   IF valtype(nWidth) == "N"
      ::oQt:resize(nWidth*::nCharWidth,::oQt:height())
   ENDIF

   IF valtype(nHeight) == "N"
      ::oQt:resize(::oQt:width(),nHeight*::nCharHeight)
   ENDIF

RETURN NIL

//---------------------------------------------------------------------------//

METHOD configTips (cToolTip,cStatusTip,cWhatsThis) CLASS HMGWidget

   IF valtype(cToolTip) == "C"
      ::oQt:setToolTip(cToolTip)
   ENDIF

   IF valtype(cStatusTip) == "C"
      ::oQt:setStatusTip(cStatusTip)
   ENDIF

   IF valtype(cWhatsThis) == "C"
      ::oQt:setWhatsThis(cWhatsThis)
   ENDIF

RETURN NIL

//---------------------------------------------------------------------------//

METHOD configFont (cFontName,nFontSize,lBold,lItalic,lUnderline,lStrikeOut) CLASS HMGWidget

   LOCAL oFont

   IF valtype(cFontName) == "C"
      oFont := QFont():new(cFontName)
   ELSE
      oFont := QFont():new(::oQt:font())
   ENDIF

   IF valtype(nFontSize) == "N"
      oFont:setPointSize(nFontSize)
   ENDIF

   IF lBold
      oFont:setBold(.T.)
   ENDIF

   IF lItalic
      oFont:setItalic(.T.)
   ENDIF

   IF lUnderline
      oFont:setUnderline(.T.)
   ENDIF

   IF lStrikeOut
      oFont:setStrikeOut(.T.)
   ENDIF

   ::oQt:setFont(oFont)

RETURN NIL

//---------------------------------------------------------------------------//
