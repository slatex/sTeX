<?xml version="1.0" encoding="utf-8"?>
<!-- An XSL style sheet for transforming OMDoc islands in LaTeXML 
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
<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:omdoc="http://omdoc.org/ns"
		xmlns="http://www.w3.org/1999/xhtml"
                exclude-result-prefixes="omdoc">

<xsl:output method="xml" indent="yes"/>

<xsl:include href="LaTeXML/LaTeXML-xhtml.xsl"/>

<!-- the fallback: copy the whole thing recursively, until there is something to do -->
<xsl:template match="*">
  <xsl:copy><xsl:apply-templates select="*|@*|text()"/></xsl:copy>
</xsl:template>
<xsl:template match="@fragid"/>
<xsl:template match="@*"><xsl:copy-of select="."/></xsl:template>

<!-- we convert some OMDoc functionality into html, 
     what a pity the OMDoc stylesheets are in XSLT2.0
     otherwise we could use them here -->
<xsl:template match="omdoc:theory">
  <div class="omdoc-theory" omdoc:id="{@xml:id}">
    <xsl:apply-templates/>
  </div>
</xsl:template>

<xsl:template match="omdoc:symbol">
  <span class="omdoc-symbol" omdoc:name="{@name}"/>
</xsl:template>

<xsl:template match="omdoc:notation"/>

</xsl:stylesheet>
