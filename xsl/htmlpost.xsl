<?xml version="1.0" encoding="utf-8"?>
<!-- An XSL style sheet for transforming LaTeXML islands to OMDoc (Open Mathematical Documents). 
     $Id: omdocpost.xsl 1858 2011-08-30 16:14:23Z kohlhase $
     $HeadURL: https://svn.kwarc.info/repos/stex/branches/stex+xhtml/xsl/omdocpost.xsl $
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
<<<<<<< HEAD
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/1999/xhtml"
	xmlns:o="http://omdoc.org/ns"
	xmlns:ltx="http://dlmf.nist.gov/LaTeXML"
	exclude-result-prefixes="xsl o ltx stex">
=======
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
>>>>>>> updating LaTeXML stylesheets from distributino, first version of htmlpost.xsl

<xsl:output method="xml" indent="yes" cdata-section-elements="data"/>
<!--<xsl:strip-space elements="*"/>-->
<xsl:param name="math-format" select="'om'"/>

<<<<<<< HEAD
<!-- we let LaTeXML do most of the work --> 
<xsl:include href="LaTeXML/LaTeXML-all-xhtml.xsl"/>

=======
>>>>>>> updating LaTeXML stylesheets from distributino, first version of htmlpost.xsl
<!-- the fallback (mostly for LaTeXML-generated XHTML: 
     copy the whole thing recursively, until there is something to do -->
<xsl:template match="*">
  <xsl:copy><xsl:apply-templates select="*|@*|text()"/></xsl:copy>
</xsl:template>
<xsl:template match="@*"><xsl:copy-of select="."/></xsl:template>
<!-- some general LaTeXML attributes we want to lose -->
<xsl:template match="@fragid"/>

<<<<<<< HEAD
<!-- transforming the OMDoc elements into HTML -->

<!-- why is this left over? -->
<xsl:template match="ltx:document">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="o:theory">
  <div class="omdoc:theory" id="{xml:id}">
    <xsl:if test="@xml:id">
      <xsl:attribute name="o:theory-name"><xsl:value-of select="@xml:id"/></xsl:attribute>
      <xsl:apply-templates/>
    </xsl:if>
  </div>
</xsl:template>

<xsl:template match="o:definition">
  <div class="omdoc:definition" id="{xml:id}">
    <xsl:copy-of select="@*"/>
      <xsl:apply-templates/>
  </div>
</xsl:template>

<xsl:template match="o:imports">
  <span class="omdoc:definition" id="{xml:id}">
    <xsl:copy-of select="@*"/>
      <xsl:apply-templates/>
  </span>
</xsl:template>

=======
<xsl:include href="LaTeXML/LaTeXML-all-xhtml.xsl"/>
>>>>>>> updating LaTeXML stylesheets from distributino, first version of htmlpost.xsl
</xsl:stylesheet>
