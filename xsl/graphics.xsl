<?xml version="1.0" encoding="utf-8"?>
<!-- An XSL style sheet for transforming LaTeXML islands to OMDoc (Open Mathematical Documents). 
     $Id: graphics.xsl 1858 2011-08-30 16:14:23Z kohlhase $
     $HeadURL: https://svn.kwarc.info/repos/stex/branches/stex+xhtml/xsl/graphics.xsl $
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
  xmlns:xhtml="http://www.w3.org/1999/xhtml"
  xmlns:ltx="http://dlmf.nist.gov/LaTeXML"
  xmlns:dc="http://purl.org/dc/elements/1.1/"
  xmlns:str="http://exslt.org/strings" 
  extension-element-prefixes="str"
  exclude-result-prefixes="xsl omdoc xhtml ltx dc str">

<xsl:output method="xml" indent="yes" cdata-section-elements="data"/>
<xsl:strip-space elements="*"/>

<!-- we do not need to special-case this any more 
<xsl:template match="ltx:graphics|ltx:verbatim">
  <omlet action="display" data="#{generate-id()}" show="embed" style="{translate(@options,'=',':')}">
    <xsl:apply-templates select="@*"/>
  </omlet>
</xsl:template> -->

<xsl:template match="omdoc:tikz">
  <omlet action="display" data="#{generate-id()}" show="embed" style="{translate(@options,'=',':')}">
    <xsl:apply-templates select="@*"/>
  </omlet>
</xsl:template>

<xsl:template match="ltx:figure[ltx:graphics]">
  <omlet action="display" data="#{generate-id(ltx:graphics)}" show="embed" class="float-figure-{@placement}">
   <xsl:if test="@label">
     <xsl:attribute name="xml:id"><xsl:value-of select="@label"/></xsl:attribute> 
   </xsl:if>
   <xsl:if test="ltx:graphics/@options">
     <xsl:attribute name="style"><xsl:value-of select="translate(ltx:graphics/@options,'=',':')"/></xsl:attribute> 
   </xsl:if>
   <xsl:if test="ltx:caption/*|ltx:caption/text()">
     <metadata><dc:title><xsl:apply-templates select="ltx:caption/*|ltx:caption/text()"/></dc:title></metadata>
   </xsl:if>
  </omlet>
</xsl:template>

<xsl:template match="ltx:graphics" mode="extract-data">
  <private>
    <xsl:attribute name="xml:id"><xsl:value-of select="generate-id()"/></xsl:attribute>
    <xsl:variable name="candidates" select="str:tokenize(@candidates,',')"/>
    <xsl:variable name="graphic" select="@graphic"/>
    <xsl:for-each select="$candidates">
      <xsl:variable name="current" select="."/>
      <xsl:variable name="type">
	<xsl:choose>
	  <xsl:when test="$current='jpg'">
	    <xsl:value-of select="'image/jpeg'"/>
	  </xsl:when>
	  <xsl:when test="$current='jpeg'">
	    <xsl:value-of select="'image/jpeg'"/>
	  </xsl:when>
	  <xsl:when test="$current='png'">
	    <xsl:value-of select="'image/png'"/>
	  </xsl:when>
	  <xsl:when test="$current='gif'">
	    <xsl:value-of select="'image/gif'"/>
	  </xsl:when>
	  <xsl:when test="$current='eps'">
	    <xsl:value-of select="'application/postscript'"/>
	  </xsl:when>
	  <xsl:when test="$current='ps'">
	    <xsl:value-of select="'application/postscript'"/>
	  </xsl:when>
	  <xsl:when test="$current='ai'">
	    <xsl:value-of select="'application/postscript'"/>
	  </xsl:when>
	  <xsl:when test="$current='pdf'">
	    <xsl:value-of select="'application/pdf'"/>
	  </xsl:when>
	  <xsl:otherwise>
	    <xsl:value-of select="$current"/>
	  </xsl:otherwise>
	</xsl:choose>
      </xsl:variable>
      <data format="{$type}" href="{$graphic}.{.}"/>
    </xsl:for-each>
  </private>
</xsl:template>

<!--  we do not need to special-case this any more
<xsl:template match="ltx:verbatim" mode="extract-data">
  <private>
    <xsl:attribute name="xml:id"><xsl:value-of select="generate-id()"/></xsl:attribute>
    <data format="text"><xsl:value-of select="text()"/></data>
  </private>
</xsl:template>
-->

<xsl:template match="omdoc:tikz|ltx:tikz" mode="extract-data">
  <private>
    <xsl:attribute name="xml:id"><xsl:value-of select="generate-id()"/></xsl:attribute>
    <data format="tikz"><xsl:value-of select="."/></data>
  </private>
</xsl:template>
</xsl:stylesheet>
