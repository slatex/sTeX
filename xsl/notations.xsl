<?xml version="1.0" encoding="utf-8"?>
<!-- An XSL style sheet for transforming LaTeXML notations to OMDoc (Open Mathematical Documents). 
     $Id: notations.xsl 1728 2011-02-06 16:22:09Z kohlhase $
     $HeadURL: https://svn.kwarc.info/repos/stex/branches/stex+xhtml/xsl/notations.xsl $
     send bug-reports, patches, suggestions to users@omdoc.org or developers@omdoc.org 

     Copyright (c) 2000 - 2002 Michael Kohlhase, 
     XSLT 2.0 port by Christoph Lange 2006

     This library is free software; you can redistribute it and/or
     modify it under the terms of the GNU Lesser General Public
     License as published by the Free Software Foundation; either
     version 2.1 of the License, or (at your option) any later version.

     This library is distributed in the hope that it will be useful,
     but WITHOUT ANY WARRANTY; without even the implied warranty of
     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
     Lesser General Public License for more details.

     You should have received a copy of the GNU Lesser General Public
     License along with this library; if not, write to the Free Software
     Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-->
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://omdoc.org/ns"
  xmlns:omdoc="http://omdoc.org/ns"
  xmlns:ltx="http://dlmf.nist.gov/LaTeXML"
  xmlns:m="http://www.w3.org/1998/Math/MathML"
  exclude-result-prefixes="xsl omdoc ltx m">

<xsl:output method="xml" indent="yes" cdata-section-elements="data"/>

<xsl:template match="omdoc:rendering">
  <xsl:apply-templates select="." mode="rendering"/>
</xsl:template>
<xsl:template match="ltx:Math" mode="rendering">
  <xsl:apply-templates select="m:math/*" mode="rendering"/>
</xsl:template>

<!-- copy where not specified otherwise -->
<xsl:template match="*" mode="rendering">
  <xsl:copy><xsl:apply-templates select="@*[not(name()='argprec')]"/><xsl:apply-templates mode="rendering"/></xsl:copy>
</xsl:template>

<xsl:template match="ltx:text" mode="rendering">
  <omdoc:text><xsl:value-of select="text()"/></omdoc:text>
</xsl:template>

<!-- Template to recover the appropriate argument precedence" -->
<xsl:template name="argument-precedence">
  <xsl:param name="count" select="1"/>
  <xsl:param name="precattr" select="1"/>
  <xsl:choose>
    <xsl:when test="$count > 1">
      <xsl:call-template name="argument-precedence">
	<xsl:with-param name="count" select="$count - 1"/>
	<xsl:with-param name="precattr" select="substring-after($precattr,' ')"/>
      </xsl:call-template>
    </xsl:when>  
    <xsl:otherwise>
      <xsl:value-of select="substring-before($precattr,' ')"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- we have to treat the m:mi that come from an 
     #i argument invocation differently -->
<xsl:template match="m:mi[starts-with(.,'arg:')]|m:mo[starts-with(.,'arg:')]" mode="rendering"> 
  <xsl:variable name="precedence">
    <xsl:call-template name="argument-precedence">
      <xsl:with-param name="count" select="substring-after(.,'arg:')"/>
      <xsl:with-param name="precattr" select="ancestor::omdoc:rendering[1]/@argprec"/>
    </xsl:call-template>
  </xsl:variable>
  <omdoc:render name="arg{substring-after(.,'arg:')}">
    <xsl:choose>
      <xsl:when test="string($precedence)">
	<xsl:attribute name="precedence"><xsl:value-of select="$precedence"/></xsl:attribute>
      </xsl:when>
      <xsl:when test="string(ancestor::omdoc:rendering[1]/@precedence)">
	<xsl:attribute name="precedence"><xsl:value-of select="ancestor::omdoc:rendering[1]/@precedence"/></xsl:attribute>
      </xsl:when>
      <xsl:otherwise/>
    </xsl:choose>
  </omdoc:render>
</xsl:template>


<!-- make an mrow around the generated things. -->
<xsl:template match="omdoc:style[@format='pmml']">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
      <omdoc:element name="mrow" ns="http://www.w3.org/1998/Math/MathML">
	<xsl:apply-templates/>
      </omdoc:element>
    </xsl:copy>
</xsl:template>


<xsl:template match="omdoc:separator/ltx:Math">
    <xsl:apply-templates select="m:math/*" mode="elementize"/>
</xsl:template>

<xsl:template match="omdoc:map/ltx:Math">
    <xsl:apply-templates select="m:math/*" mode="elementize"/>
</xsl:template>


<xsl:template match="text()" mode="elementize">
  <omdoc:text><xsl:value-of select="."/></omdoc:text>
</xsl:template>

<xsl:template match="ltx:text" mode="elementize">
  <omdoc:element name="mtext" ns="http://www.w3.org/1998/Math/MathML">
    <xsl:value-of select="."/>
  </omdoc:element>
</xsl:template>

<xsl:template match="m:*" mode="elementize">
  <omdoc:element name="{local-name()}" ns="{namespace-uri()}">
    <xsl:for-each select="@*">
      <attribute name="{local-name()}" select="'{.}'"/>
    </xsl:for-each>
    <xsl:apply-templates mode="elementize"/>
  </omdoc:element>
</xsl:template>

</xsl:stylesheet>
