<?xml version="1.0" encoding="utf-8"?>
<!-- An XSL style sheet for transforming LaTeXML islands to OWL2
     $Id: owl2post.xsl 1728 2011-02-06 16:22:09Z kohlhase $
     $HeadURL: https://svn.kwarc.info/repos/stex/branches/stex+xhtml/xsl/owl2post.xsl $
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
  xmlns:ltx="http://dlmf.nist.gov/LaTeXML"
  xmlns:omdoc="http://omdoc.org/ns"
  xmlns:stex="http://kwarc.info/ns/sTeX"
  xmlns="http://www.w3.org/2002/07/owl#"
  xmlns:owl="http://www.w3.org/2002/07/owl#"
  exclude-result-prefixes="xsl omdoc ltx stex owl"> 

<xsl:output method="xml" indent="yes" cdata-section-elements="data"/>

<xsl:template match="/">
  <xsl:comment>This OWL2 ontology is generated from an sTeX-encoded one via LaTeXML, you may want to reconsider editing it.</xsl:comment>
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="*">
  <xsl:copy><xsl:copy-of select="@*"/><xsl:apply-templates/></xsl:copy>
</xsl:template>

<xsl:template match="omdoc:imports">
  <Import><xsl:value-of select="@from"/></Import>
</xsl:template>


<xsl:template match="owl:Axiom">
  <xsl:variable name="anno" select="*[2]"/>
  <xsl:apply-templates select="*[1]">
    <xsl:with-param name="anno" select="$anno"/>
  </xsl:apply-templates>
</xsl:template>

<xsl:template match="ltx:Math|ltx:XMath">
  <xsl:param name="anno"/>
  <xsl:apply-templates>
    <xsl:with-param name="anno" select="$anno"/>
  </xsl:apply-templates>
</xsl:template>

<xsl:template match="ltx:XMApp[ltx:XMTok[position()=1 and @meaning='list']]">
  <xsl:apply-templates select="*[position() &gt; 1]"/>
</xsl:template>

<xsl:template match="ltx:XMApp">
  <xsl:param name="anno"/>
  <xsl:element name="{ltx:XMTok[1]/@meaning}">
    <xsl:copy-of select="$anno"/>
    <xsl:apply-templates select="*[position() &gt; 1]"/>
  </xsl:element>
</xsl:template>

<xsl:template match="ltx:XMTok">
  <Class IRI="{@name}"/>
</xsl:template>

<xsl:template match="ltx:ERROR">
  <Class IRI="{substring-after(ltx:XMTok,'\')}"/>
</xsl:template>
</xsl:stylesheet>
