/*

  MiniGUIQt - módulo para Qt4xHb/Qt5xHb com sintaxe no estilo MiniGUI

  Copyright (C) 2017 Marcos Antonio Gambeta <marcosgambeta AT outlook DOT com>

*/

#include "qt5xhb.ch"

//---------------------------------------------------------------------------//

FUNCTION MsgYesNo (cMessage, cTitle)

   LOCAL nRet

   IF valtype(cMessage) == "U"
      cMessage := ""
   ENDIF

   IF valtype(cTitle) == "U"
      cTitle := ""
   ENDIF

   nRet := QMessageBox():question(QApplication():activeWindow(), cTitle, cMessage, QMessageBox_Yes+QMessageBox_No)

RETURN iif(nRet == QMessageBox_Yes, .T., .F.)

//---------------------------------------------------------------------------//

FUNCTION MsgRetryCancel (cMessage, cTitle)

   LOCAL oMsgBox
   LOCAL nRet

   IF valtype(cMessage) == "U"
      cMessage := ""
   ENDIF

   IF valtype(cTitle) == "U"
      cTitle := ""
   ENDIF

   oMsgBox := QMessageBox():new(QMessageBox_Question, cTitle, cMessage, QMessageBox_Retry+QMessageBox_Cancel, QApplication():activeWindow())

   nRet := oMsgBox:exec()

   oMsgBox:delete()

RETURN iif(nRet == QMessageBox_Retry, .T., .F.)

//---------------------------------------------------------------------------//

FUNCTION MsgOkCancel (cMessage, cTitle)

   LOCAL oMsgBox
   LOCAL nRet

   IF valtype(cMessage) == "U"
      cMessage := ""
   ENDIF

   IF valtype(cTitle) == "U"
      cTitle := ""
   ENDIF

   oMsgBox := QMessageBox():new(QMessageBox_Question, cTitle, cMessage, QMessageBox_Ok+QMessageBox_Cancel, QApplication():activeWindow())

   nRet := oMsgBox:exec()

   oMsgBox:delete()

RETURN iif(nRet == QMessageBox_Ok, .T., .F.)

//---------------------------------------------------------------------------//

FUNCTION MsgInfo (cMessage, cTitle)

   IF valtype(cMessage) == "U"
      cMessage := ""
   ENDIF

   IF valtype(cTitle) == "U"
      cTitle := ""
   ENDIF

   QMessageBox():information(QApplication():activeWindow(), cTitle, cMessage)

RETURN NIL

//---------------------------------------------------------------------------//

FUNCTION MsgStop (cMessage, cTitle)

   IF valtype(cMessage) == "U"
      cMessage := ""
   ENDIF

   IF valtype(cTitle) == "U"
      cTitle := ""
   ENDIF

   QMessageBox():critical(QApplication():activeWindow(), cTitle, cMessage)

RETURN NIL

//---------------------------------------------------------------------------//

FUNCTION MsgExclamation (cMessage, cTitle)

   IF valtype(cMessage) == "U"
      cMessage := ""
   ENDIF

   IF valtype(cTitle) == "U"
      cTitle := ""
   ENDIF

   QMessageBox():warning(QApplication():activeWindow(), cTitle, cMessage)

RETURN NIL

//---------------------------------------------------------------------------//
