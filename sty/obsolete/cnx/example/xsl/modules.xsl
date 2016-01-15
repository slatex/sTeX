<?xml version="1.0" encoding="utf-8"?>
<!-- a stylesheet for transforming LaTeXML-generated XML files to CNXML 
     $URL: svn://kwarc.faculty.iu-bremen.de/kohlhase/kwarc/projects/content/cnx/xsl/latexml.xsl$ 
     $Revision: 257 $; last modified by $Author: kohlhase $ 
     $Date: 2005-01-14 18:10:45 +0100 (Fri, 14 Jan 2005) $
     Copyright (c) 2005 Michael Kohlhase, released under the Gnu Public License 
  -->
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://cnx.rice.edu/cnxml"
  xmlns:ltxml="http://dlmf.nist.gov/LaTeXML"
  exclude-result-prefixes="ltxml">

  <xsl:output method="xml" indent="yes" cdata-section-elements="data"/>
  <xsl:strip-space elements="*"/>

<xsl:template match="ltxml:module[*]">
  <section id="{@xml:id}"><xsl:apply-templates/></section>
</xsl:template>
<xsl:template match="ltxml:module"/>

</xsl:stylesheet>
