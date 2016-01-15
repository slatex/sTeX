<?xml version="1.0" encoding="utf-8"?>
<!-- a stylesheet for transforming LaTeXML-generated XML files to CNXML 
     $URL: svn://kwarc.faculty.iu-bremen.de/kohlhase/kwarc/projects/content/cnx/xsl/latexml.xsl$ 
     $Revision: 301 $; last modified by $Author: kohlhase $ 
     $Date: 2005-01-25 07:36:30 +0100 (Tue, 25 Jan 2005) $
     Copyright (c) 2005 Michael Kohlhase, released under the Gnu Public License 
  -->
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="xml" indent="yes" cdata-section-elements="data"/>
  <xsl:strip-space elements="*"/>

  <xsl:include href="cnxmodule.xsl"/>
  <xsl:include href="statements.xsl"/>
  <xsl:include href="modules.xsl"/>
  <xsl:include href="latexml.xsl"/>

  <xsl:template match="*">
    <xsl:message>Cannot deal with element <xsl:value-of select="local-name()"/> yet!</xsl:message>
  </xsl:template>

</xsl:stylesheet>
