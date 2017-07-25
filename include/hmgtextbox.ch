/*

  MiniGUIQt - módulo para Qt4xHb/Qt5xHb com sintaxe no estilo MiniGUI

  Copyright (C) 2017 Marcos Antonio Gambeta <marcosgambeta AT outlook DOT com>

*/

#xcommand @ <nRow>,<nCol> TEXTBOX <name> [ OBJECT <oObj> ] ;
          [ <dummy:OF,PARENT,DIALOG> <parent> ] ;
          [ WIDTH <nWidth> ] ;
          [ HEIGHT <nHeight> ] ;
          [ TOOLTIP <cToolTip> ] ;
          [ STATUSTIP <cStatusTip> ] ;
          [ WHATSTHIS <cWhatsThis> ] ;
          [ STYLESHEET <cStyleSheet> ] ;
          [ FONT <cFontName> ] ;
          [ SIZE <nFontSize> ] ;
          [ <lBold:BOLD> ] ;
          [ <lItalic:ITALIC> ] ;
          [ <lUnderline:UNDERLINE> ] ;
          [ <lStrikeout:STRIKEOUT> ] ;
          [ VALUE <cValue> ] ;
          [ <lInvisible:INVISIBLE> ] ;
          [ <lDisabled:DISABLED> ] ;
          [ <lNoTabStop:NOTABSTOP> ] ;
          [ ON GOTFOCUS <bOnGotFocus> ] ;
          [ ON LOSTFOCUS <bOnLostFocus> ] ;
          [ ON CHANGE <bOnChange> ] ;
          [ ON EDIT <bOnEdit> ] ;
          [ ON ENTER <bOnEnter> ] ;
          [ MAXLENGTH <nMaxLength> ] ;
          [ <lReadOnly:READONLY> ] ;
          [ <lPassword:PASSWORD> ] ;
          [ <lNoBorder:NOBORDER> ] ;
          [ <lRightAlign:RIGHTALIGN> ] ;
          [ <class:CLASS> <className> ] ;
          => ;
          HMGCore():addObject( [ <oObj> := ] __IIF(<.class.>,<className>,HMGTextBox)():new(;
          <"name">,;
          <"parent">,;
          <nCol>,;
          <nRow>,;
          <nWidth>,;
          <nHeight>,;
          <cToolTip>,;
          <cStatusTip>,;
          <cWhatsThis>,;
          <cStyleSheet>,;
          <cFontName>,;
          <nFontSize>,;
          <.lBold.>,;
          <.lItalic.>,;
          <.lUnderline.>,;
          <.lStrikeout.>,;
          <cValue>,;
          <.lInvisible.>,;
          <.lDisabled.>,;
          <.lNoTabStop.>,;
          <{bOnGotFocus}>,;
          <{bOnLostFocus}>,;
          <{bOnChange}>,;
          <{bOnEdit}>,;
          <{bOnEnter}>,;
          <nMaxLength>,;
          <.lReadOnly.>,;
          <.lPassword.>,;
          <.lNoBorder.>,;
          <.lRightAlign.>;
          ))
