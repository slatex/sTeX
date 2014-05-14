<?xml version="1.0" encoding="utf-8"?>
<!-- An XSL style sheet for transforming LaTeXML islands to OMDoc (Open Mathematical Documents). 
     $Id: math.xsl 1728 2011-02-06 16:22:09Z kohlhase $
     $HeadURL: https://svn.kwarc.info/repos/stex/branches/stex+xhtml/xsl/math.xsl $
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
  xmlns:ltx="http://dlmf.nist.gov/LaTeXML"
  xmlns:om="http://www.openmath.org/OpenMath"
  xmlns:m="http://www.w3.org/1998/Math/MathML"
  exclude-result-prefixes="xsl ltx om">

<xsl:output method="xml" indent="yes" cdata-section-elements="data"/>

<xsl:template match="ltx:equation">
  <xsl:choose>
    <xsl:when test="$math-format='om'">
      <om:OMOBJ style="display:block">
	<xsl:apply-templates select="ltx:Math/m:math/*"/>
      </om:OMOBJ>
    </xsl:when>
    <xsl:when test="$math-format='pmml'">
      <xsl:copy-of select="ltx:Math/m:math"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:message>math.xsl warning: unknown math format <xsl:value-of select="$math-format"/></xsl:message>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- from LaTeXML Math elements we just pick out the OpenMath representation -->
<xsl:template match="ltx:Math">
  <xsl:choose>
    <xsl:when test="$math-format='om'">
      <xsl:apply-templates select="om:OMOBJ"/> 
    </xsl:when>
    <xsl:when test="$math-format='pmml'">
      <xsl:copy-of select="m:math"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:message>math.xsl warning: unknown math format <xsl:value-of select="$math-format"/></xsl:message>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- equationgroups come from eqnarray and eqnarray*, they really need OMDoc-level parallel markup -->
<xsl:template match="ltx:equationgroup">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="ltx:equationgroup/ltx:equation">
  <xsl:choose>
    <xsl:when test="$math-format='om'">
      <om:OMOBJ style="display:block">
	<xsl:apply-templates select="ltx:MathFork/ltx:Math/om:OMOBJ/*"/>
      </om:OMOBJ>
    </xsl:when>
    <xsl:when test="$math-format='pmml'">
      <xsl:copy-of select="ltx:MathFork/ltx:Math/m:math"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:message>math.xsl warning: unknown math format <xsl:value-of select="$math-format"/></xsl:message>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

</xsl:stylesheet>
