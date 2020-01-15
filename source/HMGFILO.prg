/*

  MiniGUIQt - módulo para Qt4xHb/Qt5xHb com sintaxe no estilo MiniGUI

  Copyright (C) 2020 Marcos Antonio Gambeta <marcosgambeta AT outlook DOT com>

*/

#include "qt5xhb.ch"
#include "hbclass.ch"

STATIC aObjects := {}

//---------------------------------------------------------------------------//

CLASS HMGFILO

   METHOD add
   METHOD remove
   METHOD first
   METHOD last
   METHOD count

ENDCLASS

//---------------------------------------------------------------------------//

METHOD add (o) CLASS HMGFILO

   IF valtype(o) == "O"
      aadd(aObjects,o)
   ENDIF

RETURN NIL

//---------------------------------------------------------------------------//

METHOD remove () CLASS HMGFILO

   IF len(aObjects) > 0
      adel(aObjects,len(aObjects))
      aObjects := asize(aObjects,len(aObjects)-1)
   ENDIF

RETURN NIL

//---------------------------------------------------------------------------//

METHOD first () CLASS HMGFILO
RETURN iif(len(aObjects)>0,aObjects[1],NIL)

//---------------------------------------------------------------------------//

METHOD last () CLASS HMGFILO
RETURN iif(len(aObjects)>0,aObjects[len(aObjects)],NIL)

//---------------------------------------------------------------------------//

METHOD count () CLASS HMGFILO
RETURN len(aObjects)

//---------------------------------------------------------------------------//
