<?xml version="1.0" encoding="utf-8"?>
<!-- a stylesheet for transforming LaTeXML-generated XML files to CNXML 
     $URL: svn://kwarc.faculty.iu-bremen.de/kohlhase/kwarc/projects/content/cnx/xsl/latexml.xsl$ 
     $Revision: 301 $; last modified by $Author: kohlhase $ 
     $Date: 2005-01-25 07:36:30 +0100 (Tue, 25 Jan 2005) $
     Copyright (c) 2005 Michael Kohlhase, released under the Gnu Public License 
  -->
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:ltxml="http://dlmf.nist.gov/LaTeXML"
  xmlns:func="http://exslt.org/functions" 
  xmlns="http://cnx.rice.edu/cnxml"
  extension-element-prefixes="func"
  exclude-result-prefixes="ltxml func">

  <xsl:output method="xml" 
	      doctype-public="-//CNX//DTD CNXML 0.5 plus MathML//EN" 
	      doctype-system="http://cnx.rice.edu/cnxml/0.5/DTD/cnxml_mathml.dtd" 
	      indent="yes"/>
  <xsl:strip-space elements="*"/>

  <xsl:template match="/">
    <xsl:comment>
      This file has been automatically generated from a LaTeXML source by ltxml2cnx.sty
    </xsl:comment>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="ltxml:document">
    <document id="{ltxml:idgen()}">
      <name>Dummy</name>
      <content><xsl:apply-templates/></content>
    </document>
  </xsl:template>

  <xsl:template match="ltxml:section">
    <section id="{ltxml:idgen()}"><xsl:apply-templates/></section>
  </xsl:template>

  <xsl:template match="ltxml:heading">
    <name><xsl:apply-templates/></name>
  </xsl:template>

  <xsl:template match="ltxml:line-end-comment">
    <note type="line-end-comment" id="{ltxml:idgen()}">
      <xsl:apply-templates/>
    </note>
  </xsl:template>

<func:function name="ltxml:idgen">
  <xsl:choose>
    <xsl:when test="@id"><func:result><xsl:value-of select="@id"/></func:result></xsl:when>
    <xsl:otherwise><func:result><xsl:value-of select="generate-id()"/></func:result></xsl:otherwise>
  </xsl:choose>
</func:function>

</xsl:stylesheet>
