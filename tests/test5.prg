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

   DEFINE WINDOW window1 ROW 20 COL 20 WIDTH 640 HEIGHT 480 TITLE "MiniGUIQt - teste 5" MAIN

      @ 10,10 LABEL window1_label1 VALUE "label 1" OF window1
      @ 10,110 TEXTBOX window1_textbox1 VALUE "textbox 1" OF window1

      @ 50,10 LABEL window1_label2 VALUE "label 2" OF window1
      @ 50,110 TEXTBOX window1_textbox2 VALUE "textbox 2" OF window1

      @ 90,10 LABEL window1_label3 VALUE "label 3" OF window1
      @ 90,110 TEXTBOX window1_textbox3 VALUE "textbox 3" OF window1

      @ 130,10 LABEL window1_label4 VALUE "label 4" OF window1
      @ 130,110 EDITBOX window1_editbox1 WIDTH window1_textbox3.width*3 HEIGHT 200 VALUE memoread("test5.prg") OF window1

      @ 370,10 BUTTON window1_button1 CAPTION "button1" ACTION qout("button1 clicked") OF window1
      @ 370,210 BUTTON window1_button2 CAPTION "button2" ACTION qout("button2 clicked")  OF window1

   END WINDOW

   ACTIVATE WINDOW window1

   RELEASE WINDOW window1

   oApp:delete()

RETURN
