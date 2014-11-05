<?xml version="1.0" encoding="utf-8"?>
<!-- An XSL style sheet for transforming LaTeXML symbols to OMDoc (Open Mathematical Documents). 
     $Id: symbols.xsl 1858 2011-08-30 16:14:23Z kohlhase $
     $HeadURL: https://svn.kwarc.info/repos/stex/branches/stex+xhtml/xsl/symbols.xsl $
     send bug-reports, patches, suggestions to users@omdoc.org or developers@omdoc.org 

     Copyright (c) 2000 - 2013 Michael Kohlhase, 

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
<!-- this styilesheet cleans up artefacts  of the LaTeXML translation. We would ideally
     not need it at all, and I hope it will disappear when we clean up our
     transformation. 
     -->

<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:om="http://www.openmath.org/OpenMath"
  exclude-result-prefixes="xsl om">

<xsl:output method="xml" indent="yes" cdata-section-elements="data"/>

<!-- we clean up for variable names in \nappa and friends -->
<xsl:template match="om:OMV[contains(@name,'normal-')]">
  <om:OMV name="{substring-after(@name,'normal-')}"/>
</xsl:template>

<xsl:template match="om:OMA[om:OMS[@cd='latexml' and @name='delimited-[]']]">
  <xsl:apply-templates select="*[position()&gt;1]"/>
</xsl:template>

</xsl:stylesheet>
