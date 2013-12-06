<?xml version="1.0" encoding="utf-8"?>
<!-- An XSL style sheet for transforming LaTeXML islands to CNXML
     $Id: ltxml2cnx.xsl 1728 2011-02-06 16:22:09Z kohlhase $
     $HeadURL: https://svn.kwarc.info/repos/stex/branches/stex+xhtml/xsl/ltxml2cnx.xsl $
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
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:ltx="http://dlmf.nist.gov/LaTeXML"
  xmlns='http://cnx.rice.edu/cnxml'
  xmlns:m='http://www.w3.org/1998/Math/MathML'
  xmlns:md="http://cnx.rice.edu/mdml/0.4"
  xmlns:bib="http://bibtexml.sf.net/" 
  exclude-result-prefixes="ltx md bib"
  version="1.0">

  <xsl:output method="xml" indent="yes"
    doctype-public="-//CNX//DTD CNXML 0.5 plus MathML//EN"
    doctype-system="http://cnx.rice.edu/cnxml/0.5/DTD/cnxml_mathml.dtd"/>
  
  <xsl:strip-space elements="*"/>

<!-- if there is no other template, give a warning -->
<!--   <xsl:template match="*">
    <xsl:message>Cannot deal with element <xsl:value-of select="local-name()"/> yet! (id=<xsl:value-of select="@xml:id"/>)</xsl:message>
    <xsl:comment>elided element <xsl:value-of select="local-name()"/></xsl:comment>
  </xsl:template> -->

  <xsl:template match="*">
    <xsl:copy><xsl:copy-of select="@*"/><xsl:apply-templates/></xsl:copy>
  </xsl:template>

  <xsl:template match="ltx:Math">
    <xsl:copy-of select="m:math"/>
  </xsl:template>

<xsl:template match="ltx:*">
  <xsl:element name="{local-name()}">
    <xsl:copy-of select="@*"/><xsl:apply-templates/>
  </xsl:element>
</xsl:template>

<xsl:template match="ltx:tabular">
  <table>
    <xsl:copy-of select="@*"/><xsl:apply-templates/>
  </table>
</xsl:template>

</xsl:stylesheet>
