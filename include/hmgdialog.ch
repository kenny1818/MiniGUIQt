/*

  MiniGUIQt - módulo para Qt4xHb/Qt5xHb com sintaxe no estilo MiniGUI

  Copyright (C) 2020 Marcos Antonio Gambeta <marcosgambeta AT outlook DOT com>

*/

#xcommand DEFINE DIALOG <name> [ OBJECT <oObj> ] ;
          [ <dummy1:OF,PARENT> <parent> ] ;
          [ AT <nRow>,<nCol> ] ;
          [ ROW <nRow> ] ;
          [ COL <nCol> ] ;
          [ WIDTH <nWidth> ] ;
          [ HEIGHT <nHeight> ] ;
          [ TOOLTIP <cToolTip> ] ;
          [ STYLESHEET <cStyleSheet> ] ;
          [ FONT <cFontName> ] ;
          [ SIZE <nFontSize> ] ;
          [ <lBold:BOLD> ] ;
          [ <lItalic:ITALIC> ] ;
          [ <lUnderline:UNDERLINE> ] ;
          [ <lStrikeout:STRIKEOUT> ] ;
          [ <dummy2:TITLE,CAPTION> <cTitle> ] ;
          [ <lModal:MODAL> ] ;
          [ <lCharacters:CHARACTERS> ] ;
          [ ON INIT <bOnInit> ] ;
          [ ON RELEASE <bOnRelease> ] ;
          [ FONTCOLOR <aFontColor> ] ;
          [ BACKCOLOR <aBackColor> ] ;
          [ <class:CLASS> <className> ] ;
          => ;
          HMGCore():addObject( [ <oObj> := ] __IIF(<.class.>,<className>,HMGDialog)():new(;
          <"name">,;
          <"parent">,;
          <nCol>,;
          <nRow>,;
          <nWidth>,;
          <nHeight>,;
          <cToolTip>,;
          <cStyleSheet>,;
          <cFontName>,;
          <nFontSize>,;
          <.lBold.>,;
          <.lItalic.>,;
          <.lUnderline.>,;
          <.lStrikeout.>,;
          <cTitle>,;
          <.lModal.>,;
          <.lCharacters.>,;
          <{bOnInit}>,;
          <{bOnRelease}>,;
          <aFontColor>,;
          <aBackColor>;
          ) );;
          HMGFilo():add(HMGCore():object(<"name">))

#xcommand END DIALOG => HMGFilo():remove()

#xcommand ACTIVATE DIALOG <name> => HMGCore():doMethod(<"name">,"activate")
#xcommand CENTER DIALOG <name> => HMGCore():doMethod(<"name">,"center")
#xcommand RELEASE DIALOG <name> => HMGCore():doMethod(<"name">,"release")
