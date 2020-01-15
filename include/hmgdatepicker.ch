/*

  MiniGUIQt - módulo para Qt4xHb/Qt5xHb com sintaxe no estilo MiniGUI

  Copyright (C) 2020 Marcos Antonio Gambeta <marcosgambeta AT outlook DOT com>

*/

#xcommand @ <nRow>,<nCol> DATEPICKER <name> [ OBJECT <oObj> ] ;
          [ <dummy1:OF,PARENT,DIALOG> <parent> ] ;
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
          [ VALUE <dValue> ] ;
          [ <lInvisible:INVISIBLE> ] ;
          [ <lDisabled:DISABLED> ] ;
          [ <lNoTabStop:NOTABSTOP> ] ;
          [ ON GOTFOCUS <bOnGotFocus> ] ;
          [ ON LOSTFOCUS <bOnLostFocus> ] ;
          [ ON ENTER <bOnEnter> ] ;
          [ <lRightAlign:RIGHTALIGN> ] ;
          [ <lNoBorder:NOBORDER> ] ;
          [ <lReadOnly:READONLY> ] ;
          [ <class:CLASS> <className> ] ;
          => ;
          HMGCore():addObject( [ <oObj> := ] __IIF(<.class.>,<className>,HMGDatePicker)():new(;
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
          <dValue>,;
          <.lInvisible.>,;
          <.lDisabled.>,;
          <.lNoTabStop.>,;
          <{bOnGotFocus}>,;
          <{bOnLostFocus}>,;
          <{bOnEnter}>,;
          <.lRightAlign.>,;
          <.lNoBorder.>,;
          <.lReadOnly.>;
          ) )
