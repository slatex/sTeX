<?xml version="1.0" encoding="utf-8"?>
<!-- An XSL style sheet for transforming LaTeXML listings to OMDoc (Open Mathematical Documents). 
     $Id: listings.xsl 1728 2011-02-06 16:22:09Z kohlhase $
     $HeadURL: https://svn.kwarc.info/repos/stex/branches/stex+xhtml/xsl/listings.xsl $
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
  exclude-result-prefixes="omdoc ltx xsl">

<xsl:output method="xml" indent="yes" cdata-section-elements="data"/>
<xsl:strip-space elements="*"/>

<xsl:template match="ltx:text[@class='listing']">
  <omdoc:phrase type='progsnippet'>
    <xsl:apply-templates select="text()|@*|*"/>
  </omdoc:phrase>
</xsl:template>

<xsl:template match="ltx:listingblock">
  <omlet action='display' show='embed' style='display:block'>
    <xsl:apply-templates select="@*"/>
    <code>
      <data format='listingblock'><xsl:apply-templates mode="listing"/></data>
    </code>
  </omlet>
</xsl:template>

<xsl:template match="ltx:tabular" mode="listing">
  <table class="listing"><xsl:apply-templates mode="listing"/></table>
</xsl:template>

<xsl:template match="ltx:tr" mode="listing">
  <tr><xsl:apply-templates mode="listing"/></tr>
</xsl:template>

<xsl:template match="ltx:td" mode="listing">
  <td><xsl:apply-templates mode="listing"/></td>
</xsl:template>

<xsl:template match="ltx:text[not(@*)]" mode="listing">
  <xsl:apply-templates mode="listing"/>
</xsl:template>

<xsl:template match="ltx:text[@font='bold']" mode="listing">
  <keyword><xsl:apply-templates mode="listing"/></keyword>
</xsl:template>

<xsl:template match="ltx:text[@color]" mode="listing">
  <phrase>
    <xsl:attribute name='type'><xsl:text>lstemph</xsl:text></xsl:attribute>
    <xsl:attribute name='style'><xsl:text>color:</xsl:text><xsl:value-of select="@color"/></xsl:attribute>
    <xsl:apply-templates mode="listing"/>
  </phrase>
</xsl:template>

<xsl:template match="ltx:text[@class]" mode="listing">
  <xsl:apply-templates mode="listing"/>
</xsl:template>


<xsl:template match="ltx:*" mode="listing">
  <xsl:message>cannot deal with element <xsl:value-of select="local-name()"/> yet!</xsl:message>
</xsl:template>

</xsl:stylesheet>
