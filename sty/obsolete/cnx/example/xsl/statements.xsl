<?xml version="1.0" encoding="utf-8"?>
<!-- a stylesheet for transforming LaTeXML-generated XML files to CNXML 
     $URL: svn://kwarc.faculty.iu-bremen.de/kohlhase/kwarc/projects/content/cnx/xsl/latexml.xsl$ 
     $Revision: 254 $; last modified by $Author: brentmh $ 
     $Date: 2005-01-14 17:39:48 +0100 (Fri, 14 Jan 2005) $
     Copyright (c) 2005 Michael Kohlhase, released under the Gnu Public License 
  -->
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:ltxml="http://dlmf.nist.gov/LaTeXML"
  xmlns="http://cnx.rice.edu/cnxml"
  exclude-result-prefixes="ltxml">

  <xsl:output method="xml" indent="yes" cdata-section-elements="data"/>
  <xsl:strip-space elements="*"/>

  <xsl:template match="ltxml:definition">
    <definition id="{ltxml:idgen()}">
      <term><xsl:value-of select="@for"/></term>
      <meaning><xsl:apply-templates/></meaning>
    </definition>
  </xsl:template>

  <xsl:template match="ltxml:example">
    <example id="{ltxml:idgen()}.ex">
      <para id="{generate-id()}">
        <xsl:apply-templates/>
      </para>
    </example>
  </xsl:template>

  <xsl:template match="ltxml:assertion">
    <rule id="{ltxml:idgen()}">
      <xsl:choose>
        <xsl:when test="@type"><xsl:copy-of select="@type"/></xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="type"><xsl:text>theorem</xsl:text></xsl:attribute>
        </xsl:otherwise>
      </xsl:choose>
      <statement>
	<xsl:apply-templates/>
      </statement>
    </rule>
  </xsl:template>

  <xsl:template match="ltxml:symbol" />

<xsl:template match="ltxml:omtext">
  <para id="{ltxml:idgen()}"><xsl:apply-templates/></para>
</xsl:template>

<xsl:template match="ltxml:statement-group">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="ltxml:quote">
  <note type="quote"><xsl:apply-templates/></note>
</xsl:template>

<xsl:template match="ltxml:notemph">
  <xsl:apply-templates/>
</xsl:template>

<!-- **** fix me  **** -->
<xsl:template match="ltxml:defemph">
  <term>
    <xsl:apply-templates/>
  </term>
</xsl:template>

</xsl:stylesheet>
