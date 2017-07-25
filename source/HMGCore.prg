/*

  MiniGUIQt - módulo para Qt4xHb/Qt5xHb com sintaxe no estilo MiniGUI

  Copyright (C) 2017 Marcos Antonio Gambeta <marcosgambeta AT outlook DOT com>

*/

#include "qt5xhb.ch"
#include "hbclass.ch"

/*
  A classe HMGCore é um trabalho em progresso. Conforme o desenvolvimento avançar,
  a classe será aprimorada e, provavelmente, reescrita em C++/Qt para melhor
  desempenho.
*/

// aObjects:
// 1: nome do objeto
// 2: nome do parent
// 3: objeto

// ATENÇÃO: armazenar nomes em minúsculas

STATIC aObjects := {}

//---------------------------------------------------------------------------//

CLASS HMGCore

   METHOD object
   METHOD addObject
   METHOD delObject
   METHOD listObjects

   METHOD doMethod
   METHOD setProperty
   METHOD getProperty

   METHOD isWindowDefined
   METHOD isControlDefined

ENDCLASS

//---------------------------------------------------------------------------//

METHOD object (cName,cParent) CLASS HMGCore

   LOCAL n
   LOCAL o

   IF valtype(cName) == "U"
      cName := ""
   ENDIF

   IF valtype(cParent) == "U"
      cParent := ""
   ENDIF

   cName := lower(cName)
   cParent := lower(cParent)

   IF !empty(cName) .AND. empty(cParent)
      // localiza o objeto pelo nome
      n := ascan(aObjects,{|x|x[1] == cName})
      // se encontrou, retorna o objeto
      IF n > 0
         o := aObjects[n,3]
      ENDIF
   ELSEIF !empty(cName) .AND. !empty(cParent)
      // localiza o objeto pelo nome e pelo parent
      n := ascan(aObjects,{|x|x[1] == cName .AND. x[2] == cParent})
      // se encontrou, retorna o objeto
      IF n > 0
         o := aObjects[n,3]
      ENDIF
   ENDIF

RETURN o

//---------------------------------------------------------------------------//

METHOD addObject (oObject) CLASS HMGCore

   aadd(aObjects,{lower(oObject:cName),lower(oObject:cParentName),oObject})

RETURN NIL

//---------------------------------------------------------------------------//

METHOD delObject (cName,cParent) CLASS HMGCore

   IF valtype(cName) == "U"
      cName := ""
   ENDIF

   IF valtype(cParent) == "U"
      cParent := ""
   ENDIF

   cName := lower(cName)
   cParent := lower(cParent)

   IF !empty(cName) .AND. empty(cParent)
      FOR n := 1 TO len(aObjects)
         IF aObjects[n,1] == cName
            aObjects[n] := {"","",NIL} // remove o objeto de nome 'cName'
         ENDIF
         IF aObjects[n,2] == cName
            aObjects[n] := {"","",NIL} // remove objetos que tem 'cName' como parent
         ENDIF
      NEXT n
   ENDIF

   DO WHILE .T.
      n := ascan(aObjects,{|x|x[3]==NIL})
      IF n == 0
         EXIT
      ELSE
         adel(aObjects,n)
         aObjects := asize(aObjects,len(aObjects)-1)
      ENDIF
   ENDDO

RETURN NIL

//---------------------------------------------------------------------------//

METHOD listObjects () CLASS HMGCore // somente para debug

   LOCAL n

   FOR n := 1 TO len(aObjects)

      ? aObjects[n,1]
      ?? space(1)
      ?? aObjects[n,2]

   NEXT n

RETURN NIL

//---------------------------------------------------------------------------//

METHOD doMethod (...) CLASS HMGCore

   LOCAL cParent
   LOCAL cName
   LOCAL cMethod
   LOCAL n
   LOCAL oObject

   IF pcount() == 2 // janela,método
      // obtém os parâmetros
      cName := lower(pvalue(1))
      cMethod := lower(pvalue(2))
      // localiza o objeto pelo nome
      n := ascan(aObjects,{|x|x[1]==cName})
      // se encontrou, obtém o objeto e executa o método
      IF n > 0
         oObject := aObjects[n,3]
         DO CASE
         CASE cMethod == "activate" ; oObject:activate()
         CASE cMethod == "center"   ; oObject:center()
         CASE cMethod == "release"  ; oObject:release()
         CASE cMethod == "maximize" ; oObject:maximize()
         CASE cMethod == "minimize" ; oObject:minimize()
         CASE cMethod == "restore"  ; oObject:restore()
         CASE cMethod == "show"     ; oObject:show()
         CASE cMethod == "hide"     ; oObject:hide()
         CASE cMethod == "setfocus" ; oObject:setFocus()
         ENDCASE
      ENDIF
   ELSEIF pcount() == 3 // janela,controle,método
      // obtém os parâmetros
      cParent := lower(pvalue(1))
      cName := lower(pvalue(2))
      cMethod := lower(pvalue(3))
      // localiza o objeto pelo nome
      n := ascan(aObjects,{|x|x[1]==cName.AND.x[2]==cParent})
      // se encontrou, obtém o objeto e executa o método
      IF n > 0
         oObject := aObjects[n,3]
         DO CASE
         CASE cMethod == "show"     ; oObject:show()
         CASE cMethod == "hide"     ; oObject:hide()
         CASE cMethod == "setfocus" ; oObject:setFocus()
         ENDCASE
      ENDIF
   ENDIF

RETURN NIL

//---------------------------------------------------------------------------//

METHOD setProperty (...) CLASS HMGCore

   LOCAL cName
   LOCAL cParent
   LOCAL cProperty
   LOCAL xValue
   LOCAL n
   LOCAL oObject
   LOCAL oFont
   LOCAL oNewFont
   LOCAL oOldFont

   IF pcount() == 3 // (janela,propriedade,valor)
      // obtém os parâmetros
      cName := lower(pvalue(1))
      cProperty := lower(pvalue(2))
      xValue := pvalue(3)
      // localiza o objeto pelo nome
      n := ascan(aObjects,{|x|x[1]==cName})
      // se encontrou, obtém o objeto
      IF n > 0
         oObject := aObjects[n,3]
      ENDIF
   ELSEIF pcount() == 4 // (janela,controle,propriedade,valor)
      // obtém os parâmetros
      cParent := lower(pvalue(1))
      cName := lower(pvalue(2))
      cProperty := lower(pvalue(3))
      xValue := pvalue(4)
      // localiza o objeto pelo nome e parent
      n := ascan(aObjects,{|x|x[1]==cName.AND.x[2]==cParent})
      // se encontrou, obtém o objeto
      IF n > 0
         oObject := aObjects[n,3]
      ENDIF
   ELSE
      n := 0
   ENDIF

   // altera a propriedade, caso exista um objeto válido
   // e o nome da propriedade e valor estejam corretos

   IF n > 0
      DO CASE
      // geometry
      CASE cProperty == "row" .AND. valtype(xValue) == "N"
         oObject:oQt:move(oObject:oQt:x(),xValue*oObject:nCharHeight)
      CASE cProperty == "col" .AND. valtype(xValue) == "N"
         oObject:oQt:move(xValue*oObject:nCharWidth,oObject:oQt:y())
      CASE cProperty == "width" .AND. valtype(xValue) == "N"
         oObject:oQt:resize(xValue*oObject:nCharWidth,oObject:oQt:height())
      CASE cProperty == "height" .AND. valtype(xValue) == "N"
         oObject:oQt:resize(oObject:oQt:width(),xValue*oObject:nCharHeight)
      // tip's
      CASE cProperty == "tooltip" .AND. valtype(xValue) == "C"
         oObject:oQt:setToolTip(xValue)
      CASE cProperty == "statustip" .AND. valtype(xValue) == "C"
         oObject:oQt:setStatusTip(xValue)
      CASE cProperty == "whatsthis" .AND. valtype(xValue) == "C"
         oObject:oQt:setWhatsThis(xValue)
      // font
      CASE cProperty == "fontname" .AND. valtype(xValue) == "C"
         oNewFont := QFont():new(xValue)
         oOldFont := oObject:oQt:font()
         oNewFont:setPointSize(oOldFont:pointSize())
         oNewFont:setBold(oOldFont:bold())
         oNewFont:setItalic(oOldFont:italic())
         oNewFont:setUnderline(oOldFont:underline())
         oNewFont:setStrikeOut(oOldFont:strikeout())
         oObject:oQt:setFont(oNewFont)
      CASE cProperty == "fontsize" .AND. valtype(xValue) == "N"
         oFont := oObject:oQt:font()
         oFont:setPointSize(xValue)
         oObject:oQt:setFont(oFont)
      CASE cProperty == "fontbold" .AND. valtype(xValue) == "L"
         oFont := oObject:oQt:font()
         oFont:setBold(xValue)
         oObject:oQt:setFont(oFont)
      CASE cProperty == "fontitalic" .AND. valtype(xValue) == "L"
         oFont := oObject:oQt:font()
         oFont:setItalic(xValue)
         oObject:oQt:setFont(oFont)
      CASE cProperty == "fontunderline" .AND. valtype(xValue) == "L"
         oFont := oObject:oQt:font()
         oFont:setUnderline(xValue)
         oObject:oQt:setFont(oFont)
      CASE cProperty == "fontstrikeout" .AND. valtype(xValue) == "L"
         oFont := oObject:oQt:font()
         oFont:setStrikeOut(xValue)
         oObject:oQt:setFont(oFont)
      // misc
      CASE cProperty == "enabled" .AND. valtype(xValue) == "L"
         oObject:oQt:setEnabled(xValue)
      CASE cProperty == "visible" .AND. valtype(xValue) == "L"
         oObject:oQt:setVisible(xValue)
      CASE cProperty == "caretpos" .AND. valtype(xValue) == "N"
         oObject:oQt:setCursorPosition(xValue)
      // value
      CASE cProperty == "value"
         oObject:value := xValue
      //
      ENDCASE
   ENDIF

RETURN NIL

//---------------------------------------------------------------------------//

METHOD getProperty (...) CLASS HMGCore

   LOCAL cName
   LOCAL cParent
   LOCAL cProperty
   LOCAL xValue
   LOCAL n
   LOCAL oObject

   IF pcount() == 2 // (janela,propriedade)
      // obtém os parâmetros
      cName := lower(pvalue(1))
      cProperty := lower(pvalue(2))
      // localiza o objeto pelo nome
      n := ascan(aObjects,{|x|x[1]==cName})
      // se encontrou, obtém o objeto e o valor da propriedade
      IF n > 0
         oObject := aObjects[n,3]
      ENDIF
   ELSEIF pcount() == 3 // (janela,controle,propriedade)
      // obtém os parâmetros
      cParent := lower(pvalue(1))
      cName := lower(pvalue(2))
      cProperty := lower(pvalue(3))
      // localiza o objeto pelo nome e parent
      n := ascan(aObjects,{|x|x[1]==cName.AND.x[2]==cParent})
      // se encontrou, obtém o objeto e altera a propriedade
      IF n > 0
         oObject := aObjects[n,3]
      ENDIF
   ELSE
      n := 0
   ENDIF

   // obtém o valor da propriedade, caso exista um objeto válido
   // e o nome da propriedade esteja correto

   IF n > 0
      DO CASE
      // geometry
      CASE cProperty == "row"           ; RETURN int(oObject:oQt:y()/oObject:nCharHeight)
      CASE cProperty == "col"           ; RETURN int(oObject:oQt:x()/oObject:nCharWidth)
      CASE cProperty == "width"         ; RETURN int(oObject:oQt:width()/oObject:nCharWidth)
      CASE cProperty == "height"        ; RETURN int(oObject:oQt:height()/oObject:nCharHeight)
      // tip's
      CASE cProperty == "tooltip"       ; RETURN oObject:oQt:toolTip()
      CASE cProperty == "statustip"     ; RETURN oObject:oQt:statusTip()
      CASE cProperty == "whatsthis"     ; RETURN oObject:oQt:whatsThis()
      // font
      CASE cProperty == "fontname"      ; RETURN oObject:oQt:font():family()
      CASE cProperty == "fontsize"      ; RETURN oObject:oQt:font():pointSize()
      CASE cProperty == "fontbold"      ; RETURN oObject:oQt:font():bold()
      CASE cProperty == "fontitalic"    ; RETURN oObject:oQt:font():italic()
      CASE cProperty == "fontunderline" ; RETURN oObject:oQt:font():underline()
      CASE cProperty == "fontstrikeout" ; RETURN oObject:oQt:font():strikeOut()
      // misc
      CASE cProperty == "enabled"       ; RETURN oObject:oQt:isEnabled()
      CASE cProperty == "visible"       ; RETURN oObject:oQt:isVisible()
      CASE cProperty == "caretpos"      ; RETURN oObject:oQt:cursorPosition()
      // value
      CASE cProperty == "value"         ; RETURN oObject:value
      ENDCASE
   ENDIF

RETURN NIL

//---------------------------------------------------------------------------//

METHOD isWindowDefined (...) CLASS HMGCore

   LOCAL n
   LOCAL l := .F.

   IF pcount() == 1 // janela
      // obtém o parâmetro
      cName := lower(pvalue(1))
      // localiza o objeto pelo nome
      n := ascan(aObjects,{|x|x[1]==cName})
      // se encontrou, retorna .T.
      IF n > 0
         l := .T.
      ENDIF
   ENDIF

RETURN l

//---------------------------------------------------------------------------//

METHOD isControlDefined (...) CLASS HMGCore

   LOCAL n
   LOCAL l := .F.

   IF pcount() == 2 // janela e controle
      // obtém os parâmetros
      cName := lower(pvalue(1))
      cParent := lower(pvalue(2))
      // localiza o objeto pelo nome e parent
      n := ascan(aObjects,{|x|x[1]==cName.AND.x[2]==cParent})
      // se encontrou, retorna .T.
      IF n > 0
         l := .T.
      ENDIF
   ENDIF

RETURN l

//---------------------------------------------------------------------------//
// FUNÇõES
//---------------------------------------------------------------------------//

FUNCTION DoMethod (...)
RETURN HMGCore():doMethod(...)

//---------------------------------------------------------------------------//

FUNCTION GetProperty (...)
RETURN HMGCore():getProperty(...)

//---------------------------------------------------------------------------//

FUNCTION SetProperty (...)
RETURN HMGCore():setProperty(...)

//---------------------------------------------------------------------------//

FUNCTION IsWindowDefined (...)
RETURN HMGCore():isWindowDefined(...)

//---------------------------------------------------------------------------//

FUNCTION IsControlDefined (...)
RETURN HMGCore():isControlDefined(...)

//---------------------------------------------------------------------------//
