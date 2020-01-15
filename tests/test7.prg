/*

  MiniGUIQt Project - Test Program

  Copyright (C) 2020 Marcos Antonio Gambeta

  E-mail:
  marcosgambeta AT outlook DOT com
  marcosgambeta AT gmail DOT com

  Website:
  https://github.com/marcosgambeta/MiniGUIQt

*/

#include "minigui.ch"

PROCEDURE Main ()

   LOCAL oApp

   oApp := QApplication():new()

   DEFINE WINDOW window1 ROW 20 COL 20 WIDTH 800 HEIGHT 600 TITLE "MiniGUIQt - teste 7" TOOLTIP "janela main" MAIN

      @ 20,10 BUTTON window1_button1 CAPTION "Diálogo" ACTION Dialog("window1") ;
         TOOLTIP "clique aqui para mostrar a janela de diálogo" OF window1

      @ 20,210 BUTTON window1_button2 CAPTION "Fechar" ACTION DoMethod("window1","release") ;
         TOOLTIP "clique aqui para encerrar o programa" OF window1

   END WINDOW

   ACTIVATE WINDOW window1

   RELEASE WINDOW window1

   oApp:delete()

RETURN

STATIC FUNCTION Dialog (parent)

   DEFINE DIALOG dialog1 WIDTH 640 HEIGHT 480 TITLE "Janela de diálogo" TOOLTIP "janela de diálogo" MODAL OF parent

      @ 10,10 LABEL dialog1_label1 VALUE "label 1" TOOLTIP "tooltip do objeto label1" OF dialog1
      @ 10,110 TEXTBOX dialog1_textbox1 VALUE "textbox 1" TOOLTIP "tooltip do objeto textbox1" OF dialog1

      @ 50,10 LABEL dialog1_label2 VALUE "label 2" TOOLTIP "tooltip do objeto label2" OF dialog1
      @ 50,110 TEXTBOX dialog1_textbox2 VALUE "textbox 2" TOOLTIP "tooltip do objeto textbox2" OF dialog1

      @ 90,10 LABEL dialog1_label3 VALUE "label 3" TOOLTIP "tooltip do objeto label3" OF dialog1
      @ 90,110 TEXTBOX dialog1_textbox3 VALUE "textbox 3" TOOLTIP "tooltip do objeto textbox3" OF dialog1

      @ 130,10 LABEL dialog1_label4 VALUE "label 4" TOOLTIP "tooltip do objeto label4" OF dialog1
      @ 130,110 EDITBOX dialog1_editbox1 WIDTH dialog1_textbox3.width*3 HEIGHT 200 ;
         VALUE memoread("test7.prg") TOOLTIP "tooltip do objeto editbox1" OF dialog1

      @ 370,10 BUTTON dialog1_button1 CAPTION "OK" ACTION (qout("OK"),DoMethod("dialog1","release")) ;
         TOOLTIP "tooltip do objeto button1" OF dialog1

      @ 370,210 BUTTON dialog1_button2 CAPTION "Cancelar" ACTION (qout("Cancelar"),DoMethod("dialog1","release")) ;
         TOOLTIP "tooltip do objeto button2" OF dialog1

   END DIALOG

   ACTIVATE DIALOG dialog1

   RELEASE DIALOG dialog1

RETURN NIl
