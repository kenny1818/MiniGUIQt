/*

  MiniGUIQt - módulo para Qt4xHb/Qt5xHb com sintaxe no estilo MiniGUI

  Copyright (C) 2017 Marcos Antonio Gambeta <marcosgambeta AT outlook DOT com>

*/

#xcommand DEFINE WINDOW <name> [ OBJECT <oObj> ] ;
          [ <dummy:OF,PARENT> <parent> ] ;
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
          [ TITLE <cTitle> ] ;
          [ <lMain:MAIN> ] ;
          [ <lChild:CHILD> ] ;
          [ ON INIT <bOnInit> ] ;
          [ ON RELEASE <bOnRelease> ] ;
          [ FONTCOLOR <aFontColor> ] ;
          [ BACKCOLOR <aBackColor> ] ;
          [ <class:CLASS> <className> ] ;
          => ;
          HMGCore():addObject( [ <oObj> := ] __IIF(<.class.>,<className>,HMGWindow)():new(;
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
          <.lMain.>,;
          <.lChild.>,;
          <{bOnInit}>,;
          <{bOnRelease}>,;
          <aFontColor>,;
          <aBackColor>;
          ));;
          HMGFILO():add(HMGCore():object(<"name">))

#xcommand END WINDOW => HMGFILO():remove()

#xcommand ACTIVATE WINDOW <name> => HMGCore():doMethod(<"name">,"activate")
#xcommand CENTER WINDOW <name> => HMGCore():doMethod(<"name">,"center")
#xcommand RELEASE WINDOW <name> => HMGCore():doMethod(<"name">,"release")

#xtranslate <window>.activate   => HMGCore():doMethod(<"window">,"activate")
#xtranslate <window>.center     => HMGCore():doMethod(<"window">,"center")
#xtranslate <window>.release    => HMGCore():doMethod(<"window">,"release")
#xtranslate <window>.maximize   => HMGCore():doMethod(<"window">,"maximize")
#xtranslate <window>.minimize   => HMGCore():doMethod(<"window">,"minimize")
#xtranslate <window>.restore    => HMGCore():doMethod(<"window">,"restore")
#xtranslate <window>.show       => HMGCore():doMethod(<"window">,"show")
#xtranslate <window>.hide       => HMGCore():doMethod(<"window">,"hide")
#xtranslate <window>.setFocus   => HMGCore():doMethod(<"window">,"setfocus")

#xtranslate <window>.<control>.show       => HMGCore():doMethod(<"window">,<"control">,"show")
#xtranslate <window>.<control>.hide       => HMGCore():doMethod(<"window">,<"control">,"hide")
#xtranslate <window>.<control>.setFocus   => HMGCore():doMethod(<"window">,<"control">,"setfocus")

//---------------------------------------------------------------------------//

// window - geometry - get
#xtranslate <window>.Row    => HMGCore():GetProperty(<"window">,"row")
#xtranslate <window>.Col    => HMGCore():GetProperty(<"window">,"col")
#xtranslate <window>.Width  => HMGCore():GetProperty(<"window">,"width")
#xtranslate <window>.Height => HMGCore():GetProperty(<"window">,"height")

// window - geometry - set
#xtranslate <window>.Row := <nValue>    => HMGCore():SetProperty(<"window">,"row",<nValue>)
#xtranslate <window>.Col := <nValue>    => HMGCore():SetProperty(<"window">,"col",<nValue>)
#xtranslate <window>.Width := <nValue>  => HMGCore():SetProperty(<"window">,"width",<nValue>)
#xtranslate <window>.Height := <nValue> => HMGCore():SetProperty(<"window">,"height",<nValue>)

// window.control - geometry - get
#xtranslate <window>.<control>.Row    => HMGCore():GetProperty(<"window">,<"control">,"row")
#xtranslate <window>.<control>.Col    => HMGCore():GetProperty(<"window">,<"control">,"col")
#xtranslate <window>.<control>.Width  => HMGCore():GetProperty(<"window">,<"control">,"width")
#xtranslate <window>.<control>.Height => HMGCore():GetProperty(<"window">,<"control">,"height")

// window.control - geometry - set
#xtranslate <window>.<control>.Row := <nValue>    => HMGCore():SetProperty(<"window">,<"control">,"row",<nValue>)
#xtranslate <window>.<control>.Col := <nValue>    => HMGCore():SetProperty(<"window">,<"control">,"col",<nValue>)
#xtranslate <window>.<control>.Width := <nValue>  => HMGCore():SetProperty(<"window">,<"control">,"width",<nValue>)
#xtranslate <window>.<control>.Height := <nValue> => HMGCore():SetProperty(<"window">,<"control">,"height",<nValue>)

//---------------------------------------------------------------------------//

// window - font - get
#xtranslate <window>.FontName      => HMGCore():GetProperty(<"window">,"fontname")
#xtranslate <window>.FontSize      => HMGCore():GetProperty(<"window">,"fontsize")
#xtranslate <window>.FontBold      => HMGCore():GetProperty(<"window">,"fontbold")
#xtranslate <window>.FontItalic    => HMGCore():GetProperty(<"window">,"fontitalic")
#xtranslate <window>.FontUnderline => HMGCore():GetProperty(<"window">,"fontunderline")
#xtranslate <window>.FontStrikeOut => HMGCore():GetProperty(<"window">,"fontstrikeout")

// window - font - set
#xtranslate <window>.FontName := <cValue>      => HMGCore():SetProperty(<"window">,"fontname",<cValue>)
#xtranslate <window>.FontSize := <nValue>      => HMGCore():SetProperty(<"window">,"fontsize",<nValue>)
#xtranslate <window>.FontBold := <lValue>      => HMGCore():SetProperty(<"window">,"fontbold",<lValue>)
#xtranslate <window>.FontItalic := <lValue>    => HMGCore():SetProperty(<"window">,"fontitalic",<lValue>)
#xtranslate <window>.FontUnderline := <lValue> => HMGCore():SetProperty(<"window">,"fontunderline",<lValue>)
#xtranslate <window>.FontStrikeOut := <lValue> => HMGCore():SetProperty(<"window">,"fontstrikeout",<lValue>)

// window.control - font - get
#xtranslate <window>.<control>.FontName      => HMGCore():GetProperty(<"window">,<"control">,"fontname")
#xtranslate <window>.<control>.FontSize      => HMGCore():GetProperty(<"window">,<"control">,"fontsize")
#xtranslate <window>.<control>.FontBold      => HMGCore():GetProperty(<"window">,<"control">,"fontbold")
#xtranslate <window>.<control>.FontItalic    => HMGCore():GetProperty(<"window">,<"control">,"fontitalic")
#xtranslate <window>.<control>.FontUnderline => HMGCore():GetProperty(<"window">,<"control">,"fontunderline")
#xtranslate <window>.<control>.FontStrikeOut => HMGCore():GetProperty(<"window">,<"control">,"fontstrikeout")

// window.control - font - set
#xtranslate <window>.<control>.FontName := <cValue>      => HMGCore():SetProperty(<"window">,<"control">,"fontname",<cValue>)
#xtranslate <window>.<control>.FontSize := <nValue>      => HMGCore():SetProperty(<"window">,<"control">,"fontsize",<nValue>)
#xtranslate <window>.<control>.FontBold := <lValue>      => HMGCore():SetProperty(<"window">,<"control">,"fontbold",<lValue>)
#xtranslate <window>.<control>.FontItalic := <lValue>    => HMGCore():SetProperty(<"window">,<"control">,"fontitalic",<lValue>)
#xtranslate <window>.<control>.FontUnderline := <lValue> => HMGCore():SetProperty(<"window">,<"control">,"fontunderline",<lValue>)
#xtranslate <window>.<control>.FontStrikeOut := <lValue> => HMGCore():SetProperty(<"window">,<"control">,"fontstrikeout",<lValue>)

//---------------------------------------------------------------------------//

// window - misc - get
#xtranslate <window>.Enabled => HMGCore():GetProperty(<"window">,"enabled")
#xtranslate <window>.Visible => HMGCore():GetProperty(<"window">,"visible")

// window - misc - set
#xtranslate <window>.Enabled := <lValue> => HMGCore():SetProperty(<"window">,"enabled",<lValue>)
#xtranslate <window>.Visible := <lValue> => HMGCore():SetProperty(<"window">,"visible",<lValue>)

// window.control - misc - get
#xtranslate <window>.<control>.Enabled => HMGCore():GetProperty(<"window">,<"control">,"enabled")
#xtranslate <window>.<control>.Visible => HMGCore():GetProperty(<"window">,<"control">,"visible")

// window.control - misc - set
#xtranslate <window>.<control>.Enabled := <lValue> => HMGCore():SetProperty(<"window">,<"control">,"enabled",<lValue>)
#xtranslate <window>.<control>.Visible := <lValue> => HMGCore():SetProperty(<"window">,<"control">,"visible",<lValue>)

//---------------------------------------------------------------------------//

// window - value - get
//#xtranslate <window>.Value => HMGCore():GetProperty(<"window">,"value")

// window - value - set
//#xtranslate <window>.Value := <xValue> => HMGCore():SetProperty(<"window">,"value",<xValue>)

// window.control - value - get
#xtranslate <window>.<control>.Value => HMGCore():GetProperty(<"window">,<"control">,"value")

// window.control - value - set
#xtranslate <window>.<control>.Value := <xValue> => HMGCore():SetProperty(<"window">,<"control">,"value",<xValue>)

//---------------------------------------------------------------------------//
