/*

  MiniGUIQt - módulo para Qt4xHb/Qt5xHb com sintaxe no estilo MiniGUI

  Copyright (C) 2017 Marcos Antonio Gambeta <marcosgambeta AT outlook DOT com>

*/

#xcommand @ <nRow>,<nCol> GRID <name> [ OBJECT <oObj> ] ;
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
          [ ITEMS <aItems> ] ;
          [ HEADERS <aHeaders> ] ;
          [ WIDTHS <aWidths> ] ;
          [ <lInvisible:INVISIBLE> ] ;
          [ <lDisabled:DISABLED> ] ;
          [ <lNoTabStop:NOTABSTOP> ] ;
          [ ON GOTFOCUS <bOnGotFocus> ] ;
          [ ON LOSTFOCUS <bOnLostFocus> ] ;
          [ <class:CLASS> <className> ] ;
          => ;
          HMGCore():addObject( [ <oObj> := ] __IIF(<.class.>,<className>,HMGGrid)():new(;
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
          <aItems>,;
          <aHeaders>,;
          <aWidths>,;
          <.lInvisible.>,;
          <.lDisabled.>,;
          <.lNoTabStop.>,;
          <{bOnGotFocus}>,;
          <{bOnLostFocus}>;
          ) )
