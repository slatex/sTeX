<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
    version     = "1.0"
    xmlns:xsl   = "http://www.w3.org/1999/XSL/Transform"
    xmlns:ltx   = "http://dlmf.nist.gov/LaTeXML"
    xmlns:stex  = "http://kwarc.info/ns/sTeX"
    xmlns:mml   = "http://www.w3.org/1998/Math/MathML"
    exclude-result-prefixes = "ltx">

  <xsl:import href="urn:x-LaTeXML:XSLT:LaTeXML-xhtml.xsl"/>


  <xsl:template match="/" mode="footer" priority="9"/>

  <xsl:template match="stex:annotation[@visible='false' or (current()='')]">
    <xsl:element name="span" namespace="{$html_ns}"><xsl:copy-of select="@*"/><xsl:attribute name="style">display:none</xsl:attribute>‎<xsl:apply-templates /></xsl:element>
  </xsl:template>

  <xsl:template match="stex:annotation">
    <xsl:element name="span" namespace="{$html_ns}">
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>


  <xsl:template match="stex:annotationenv">
    <xsl:element name="span" namespace="{$html_ns}">
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>


  <xsl:template match="stex:annotationtext[@visible='false' or (current()='')]">
    <xsl:element name="span" namespace="{$html_ns}"><xsl:copy-of select="@*"/><xsl:attribute name="style">display:none</xsl:attribute>‎<xsl:apply-templates /></xsl:element>
  </xsl:template>

  <xsl:template match="stex:annotationtext">
    <xsl:element name="span" namespace="{$html_ns}">
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>

<!-- MATH -->

  <xsl:template match="ltx:Math" priority="5">
    <xsl:element name="math" namespace="{$mml_ns}">
      <xsl:call-template name="add_id"/>
      <xsl:call-template name="add_attributes"/>
      <xsl:if test="@mode='display'">
        <xsl:attribute name="display">block</xsl:attribute>
      </xsl:if>
      <xsl:for-each select="./ltx:XMath">
        <xsl:call-template select="." name="maybewrap"/>
      </xsl:for-each>
    </xsl:element>
  </xsl:template>

  <xsl:template name="maybewrap">
    <xsl:choose>
      <xsl:when test="count(*)=1">
        <xsl:apply-templates select="."/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:element name="mrow" namespace="{$mml_ns}">
          <xsl:for-each select="./*">
            <xsl:apply-templates select="."/>
          </xsl:for-each>
        </xsl:element>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- (sub/super)script-->

  <xsl:template match="*[(not(@role) or (@role!='POSTSUBSCRIPT' and @role!='POSTSUPERSCRIPT')) and ((following-sibling::*[1][@role='POSTSUBSCRIPT'] and following-sibling::*[2][@role='POSTSUPERSCRIPT']) or (following-sibling::*[1][@role='POSTSUPERSCRIPT'] and following-sibling::*[2][@role='POSTSUBSCRIPT']))]"
    priority="8">
    <xsl:choose>
      <xsl:when test="@scriptpos='mid'">
        <xsl:element name="munderover" namespace="{$mml_ns}">
          <xsl:apply-templates select="." mode="movablelimits"/>
          <xsl:for-each select="following-sibling::*[@role='POSTSUBSCRIPT'][1]/ltx:XMArg">
            <xsl:apply-templates select="."/>
          </xsl:for-each>
          <xsl:for-each select="following-sibling::*[@role='POSTSUPERSCRIPT'][1]/ltx:XMArg">
            <xsl:apply-templates select="."/>
          </xsl:for-each>
        </xsl:element>
      </xsl:when>
      <xsl:otherwise>
        <xsl:element name="msubsup" namespace="{$mml_ns}">
          <xsl:apply-templates select="." mode="normal"/> 
          <xsl:for-each select="following-sibling::*[@role='POSTSUBSCRIPT'][1]/ltx:XMArg">
            <xsl:apply-templates select="."/>
          </xsl:for-each>
          <xsl:for-each select="following-sibling::*[@role='POSTSUPERSCRIPT'][1]/ltx:XMArg">
            <xsl:apply-templates select="."/>
          </xsl:for-each>
        </xsl:element>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="*[(not(@role) or (@role!='POSTSUBSCRIPT' and @role!='POSTSUPERSCRIPT')) and @scriptpos='mid' and following-sibling::*[1][@role='POSTSUBSCRIPT']]"
    priority="7">
    <xsl:element name="munder" namespace="{$mml_ns}">
      <xsl:apply-templates select="." mode="movablelimits"/>
      <xsl:for-each select="following-sibling::*[1][@role='POSTSUBSCRIPT']/ltx:XMArg">
        <xsl:apply-templates select="."/>
      </xsl:for-each>
    </xsl:element>
  </xsl:template>

  <xsl:template match="*[(not(@role) or (@role!='POSTSUBSCRIPT' and @role!='POSTSUPERSCRIPT')) and following-sibling::*[1][@role='POSTSUBSCRIPT']]" 
    priority="6">
    <xsl:element name="msub" namespace="{$mml_ns}">
      <xsl:apply-templates select="." mode="normal"/>
      <xsl:for-each select="following-sibling::*[1][@role='POSTSUBSCRIPT']/ltx:XMArg">
        <xsl:apply-templates select="."/>
      </xsl:for-each>
    </xsl:element>
  </xsl:template>

  <xsl:template match="*[(not(@role) or (@role!='POSTSUBSCRIPT' and @role!='POSTSUPERSCRIPT')) and @scriptpos='mid' and following-sibling::*[1][@role='POSTSUPERSCRIPT']]" 
    priority="7">
    <xsl:element name="mover" namespace="{$mml_ns}">
      <xsl:apply-templates select="." mode="movablelimits"/>
      <xsl:for-each select="following-sibling::*[1][@role='POSTSUPERSCRIPT']/ltx:XMArg">
        <xsl:apply-templates select="."/>
      </xsl:for-each>
    </xsl:element>
  </xsl:template>

  <xsl:template match="*[(not(@role) or (@role!='POSTSUBSCRIPT' and @role!='POSTSUPERSCRIPT')) and following-sibling::*[1][@role='POSTSUPERSCRIPT']]" 
  priority="6">
    <xsl:element name="msup" namespace="{$mml_ns}">
      <xsl:apply-templates select="." mode="normal"/>
      <xsl:for-each select="following-sibling::*[1][@role='POSTSUPERSCRIPT']/ltx:XMArg">
        <xsl:apply-templates select="."/>
      </xsl:for-each>
    </xsl:element>
  </xsl:template>

  <xsl:template match="ltx:XMApp[@role='POSTSUBSCRIPT']"/>
  <xsl:template match="ltx:XMApp[@role='POSTSUPERSCRIPT']"/>

  <xsl:template match="ltx:XMArg[@role='sTeX']" priority="5" mode="normal">
    <xsl:element name="mrow" namespace="{$mml_ns}">
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>

  <xsl:template match="ltx:XMApp[ltx:XMTok[@role='FRACOP']]" priority="2" mode="normal">
    <xsl:element name="mfrac" namespace="{$mml_ns}">
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>
  <xsl:template match="ltx:XMTok[@role='FRACOP']" priority="5">
  </xsl:template>

  <xsl:template match="ltx:XMApp[*[@role='OVERACCENT']]" priority="2" mode="normal">
    <xsl:element name="mover" namespace="{$mml_ns}">
      <xsl:attribute name="accent">true</xsl:attribute>
      <xsl:for-each select="./*">
        <xsl:sort select="position()" data-type="number" order="descending"/>
        <xsl:choose>
          <xsl:when test="parent[@scriptpos='mid']">
            <xsl:apply-templates select="." mode="movablelimits"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:apply-templates select="."/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:for-each>
    </xsl:element>
  </xsl:template>

    <xsl:template match="ltx:XMApp[*[@role='UNDERACCENT']]" priority="2" mode="normal">
    <xsl:element name="munder" namespace="{$mml_ns}">
      <xsl:attribute name="accentunder">true</xsl:attribute>
      <xsl:for-each select="./*">
        <xsl:sort select="position()" data-type="number" order="descending"/>
        <xsl:choose>
          <xsl:when test="parent[@scriptpos='mid']">
            <xsl:apply-templates select="." mode="movablelimits"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:apply-templates select="."/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:for-each>
    </xsl:element>
  </xsl:template>

  <xsl:template match="ltx:XMTok[@role='SUMOP' or @role='INTOP' or @role='BIGOP']" mode="normal">
    <xsl:element name="mo" namespace="{$mml_ns}">
      <xsl:attribute name="largeop">true</xsl:attribute>
      <xsl:attribute name="symmetric">true</xsl:attribute>
      <xsl:copy-of select="@stretchy"/>
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>

  <xsl:template match="ltx:XMTok[@role='SUMOP' or @role='INTOP' or @role='BIGOP']" mode="movablelimits">
    <xsl:element name="mo" namespace="{$mml_ns}">
      <xsl:attribute name="largeop">true</xsl:attribute>
      <xsl:attribute name="symmetric">true</xsl:attribute>
      <xsl:attribute name="movablelimits">false</xsl:attribute>
      <xsl:copy-of select="@stretchy"/>
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>

  <xsl:template match="ltx:XMTok[@role='METARELOP' or @role='PUNCT' or @role='PERIOD' or @role='ADDOP' or @role='OPEN' or @role='CLOSE' or @role='OPFUNCTION' or @role='SUPOP' or @role='ID' or @role='OPERATOR' or @role='VERTBAR' or @role='FUNCTION' or @role='MULOP' or @role='RELOP' or @role='UNDERACCENT' or @role='OVERACCENT']" mode="normal">
    <xsl:element name="mo" namespace="{$mml_ns}">
      <xsl:copy-of select="@stretchy"/>
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>

  <xsl:template match="ltx:XMTok[@role='METARELOP' or @role='PUNCT' or @role='PERIOD' or @role='ADDOP' or @role='OPEN' or @role='CLOSE' or @role='OPFUNCTION' or @role='SUPOP' or @role='ID' or @role='OPERATOR' or @role='VERTBAR' or @role='FUNCTION' or @role='MULOP' or @role='RELOP' or @role='UNDERACCENT' or @role='OVERACCENT']" mode="movablelimits">
    <xsl:element name="mo" namespace="{$mml_ns}">
      <xsl:copy-of select="@stretchy"/>
      <xsl:attribute name="movablelimits">false</xsl:attribute>
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>

  <xsl:template match="ltx:XMText" mode="normal">
    <xsl:element name="mtext" namespace="{$mml_ns}">
        <xsl:choose>
          <xsl:when test="./ltx:text">
            <xsl:value-of select="./ltx:text"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="."/>
          </xsl:otherwise>
        </xsl:choose>
    </xsl:element>
  </xsl:template>


  <xsl:template match="ltx:XMArg[@stex:visible='false']" mode="normal">
    <xsl:element name="mrow" namespace="{$mml_ns}">
      <xsl:attribute name="style">display:none</xsl:attribute>
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>

  <xsl:template match="ltx:XMArg" mode="normal">
    <xsl:element name="mrow" namespace="{$mml_ns}">
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>

  <xsl:template match="ltx:XMApp" mode="normal">
    <xsl:call-template select="." name="maybewrap"/>
  </xsl:template>

  <xsl:template match="ltx:XMWrap" mode="normal">
    <xsl:element name="mrow" namespace="{$mml_ns}">
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>

  <xsl:template match="ltx:XMHint[@width]" mode="normal">
    <xsl:element name="mspace" namespace="{$mml_ns}">
      <xsl:copy-of select="@width"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="*[ancestor::ltx:XMath]" priority="-9">
    <xsl:apply-templates select="." mode="normal"/>
  </xsl:template>

  <xsl:template match="*[ancestor::ltx:XMath]" mode="movablelimits" priority="-9">
    <xsl:apply-templates select="." mode="normal"/>
  </xsl:template>

  <xsl:template match="ltx:XMTok" mode="normal">
    <xsl:element name="mi" namespace="{$mml_ns}">
    <xsl:choose>
      <xsl:when test="@font='bold'">
        <xsl:call-template name="makeBold"/>
      </xsl:when>
      <xsl:when test="@font='sansserif'">
        <xsl:call-template name="makeSans"/>
      </xsl:when>
      <xsl:when test="@font='fraktur'">
        <xsl:call-template name="makeFrak"/>
      </xsl:when>
      <xsl:when test="@font='caligraphic' or @font='script'">
        <xsl:call-template name="makeCal"/>
      </xsl:when>
      <xsl:when test="@font='typewriter'">
        <xsl:call-template name="makeTT"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
    </xsl:element>
  </xsl:template>

  <xsl:template name="makeBold">
    <xsl:param name="value" select="."/>
    <xsl:value-of select="translate($value,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz','𝐀𝐁𝐂𝐃𝐄𝐅𝐆𝐇𝐈𝐉𝐊𝐋𝐌𝐍𝐎𝐏𝐐𝐑𝐒𝐓𝐔𝐕𝐖𝐗𝐘𝐙𝐚𝐛𝐜𝐝𝐞𝐟𝐠𝐡𝐢𝐣𝐤𝐥𝐦𝐧𝐨𝐩𝐪𝐫𝐬𝐭𝐮𝐯𝐰𝐱𝐲𝐳')"/>
  </xsl:template>

  <xsl:template name="makeSans">
    <xsl:param name="value" select="."/>
    <xsl:value-of select="translate($value,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz','𝖠𝖡𝖢𝖣𝖤𝖥𝖦𝖧𝖨𝖩𝖪𝖫𝖬𝖭𝖮𝖯𝖰𝖱𝖲𝖳𝖴𝖵𝖶𝖷𝖸𝖹𝖺𝖻𝖼𝖽𝖾𝖿𝗀𝗁𝗂𝗃𝗄𝗅𝗆𝗇𝗈𝗉𝗊𝗋𝗌𝗍𝗎𝗏𝗐𝗑𝗒𝗓')"/>
  </xsl:template>

  <xsl:template name="makeTT">
    <xsl:param name="value" select="."/>
    <xsl:value-of select="translate($value,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz','𝙰𝙱𝙲𝙳𝙴𝙵𝙶𝙷𝙸𝙹𝙺𝙻𝙼𝙽𝙾𝙿𝚀𝚁𝚂𝚃𝚄𝚅𝚆𝚇𝚈𝚉𝚊𝚋𝚌𝚍𝚎𝚏𝚐𝚑𝚒𝚓𝚔𝚕𝚖𝚗𝚘𝚙𝚚𝚛𝚜𝚝𝚞𝚟𝚠𝚡𝚢𝚣')"/>
  </xsl:template>

  <xsl:template name="makeFrak">
    <xsl:param name="value" select="."/>
    <xsl:value-of select="translate($value,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz','𝔄𝔅ℭ𝔇𝔈𝔉𝔊ℌℑ𝔍𝔎𝔏𝔐𝔑𝔒𝔓𝔔ℜ𝔖𝔗𝔘𝔙𝔚𝔛𝔜ℨ𝔞𝔟𝔠𝔡𝔢𝔣𝔤𝔥𝔦𝔧𝔨𝔩𝔪𝔫𝔬𝔭𝔮𝔯𝔰𝔱𝔲𝔳𝔴𝔵𝔶𝔷')"/>
  </xsl:template>

  <xsl:template name="makeCal">
    <xsl:param name="value" select="."/>
    <xsl:value-of select="translate($value,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz','𝒜ℬ𝒞𝒟ℰℱ𝒢ℋℐ𝒥𝒦ℒℳ𝒩𝒪𝒫𝒬ℛ𝒮𝒯𝒰𝒱𝒲𝒳𝒴𝒵𝒶𝒷𝒸𝒹ℯ𝒻ℊ𝒽𝒾𝒿𝓀𝓁𝓂𝓃ℴ𝓅𝓆𝓇𝓈𝓉𝓊𝓋𝓌𝓍𝓎𝓏')"/>
  </xsl:template>

  <xsl:template match="*" mode="add_RDFa" priority="2">
    <!-- perhaps we want to disallow these being spread around?
    <xsl:if test="@vocab">
      <xsl:attribute name="vocab"><xsl:value-of select="@vocab"/></xsl:attribute>
    </xsl:if>
    <xsl:if test="@prefix">
      <xsl:attribute name="prefix"><xsl:value-of select="@prefix"/></xsl:attribute>
    </xsl:if>
    -->
    <xsl:if test="@stex:sourceref">
      <xsl:attribute name="stex:sourceref"><xsl:value-of select="@stex:sourceref"/></xsl:attribute>
    </xsl:if>
    <xsl:if test="@about">
      <xsl:attribute name="about"><xsl:value-of select="@about"/></xsl:attribute>
    </xsl:if>
    <xsl:if test="@resource">
      <xsl:attribute name="resource"><xsl:value-of select="@resource"/></xsl:attribute>
    </xsl:if>
    <xsl:if test="@property">
      <xsl:attribute name="property"><xsl:value-of select="@property"/></xsl:attribute>
    </xsl:if>
    <xsl:if test="@rel">
      <xsl:attribute name="rel"><xsl:value-of select="@rel"/></xsl:attribute>
    </xsl:if>
    <xsl:if test="@rel">
      <xsl:attribute name="rel"><xsl:value-of select="@rel"/></xsl:attribute>
    </xsl:if>
    <xsl:if test="@rev">
      <xsl:attribute name="rev"><xsl:value-of select="@rev"/></xsl:attribute>
    </xsl:if>
    <xsl:if test="@typeof">
      <xsl:attribute name="typeof"><xsl:value-of select="@typeof"/></xsl:attribute>
    </xsl:if>
    <xsl:if test="@datatype">
      <xsl:attribute name="datatype"><xsl:value-of select="@datatype"/></xsl:attribute>
    </xsl:if>
    <xsl:if test="@content">
      <xsl:attribute name="content"><xsl:value-of select="@content"/></xsl:attribute>
    </xsl:if>
  </xsl:template>

    <xsl:template match="/" priority="2">
    <xsl:apply-templates select="." mode="doctype"/>
    <html xmlns="http://www.w3.org/1999/xhtml">
      <xsl:apply-templates select="." mode="begin"/>
      <xsl:call-template name="add_RDFa_prefix"/>
      <xsl:if test="*/@xml:lang">
        <xsl:apply-templates select="*/@xml:lang" mode="copy-attribute"/>
      </xsl:if>
      <xsl:apply-templates select="." mode="head"/>
      <xsl:apply-templates select="." mode="body"/>
      <xsl:apply-templates select="." mode="end"/>
      <xsl:text>&#x0A;</xsl:text>
    </html>
  </xsl:template>



  <xsl:output method="xml"
              doctype-public = "-//W3C//DTD XHTML 1.1 plus MathML 2.0//EN"
              doctype-system = "http://www.w3.org/Math/DTD/mathml2/xhtml-math11-f.dtd"
              media-type     = 'application/xhtml+xml'
              encoding       = 'utf-8'/>

  <!-- Note: If you want namespace prefixes (eg. for MathML & SVG),
       Redefine the root template ("/") and add prefixed namespace declarations
       (eg.xmlns:m="http://www.w3.org/1998/Math/MathML") -->

</xsl:stylesheet>
