<?xml version="1.0" encoding="utf-8"?>
<!-- a stylesheet for transforming LaTeXML-generated XML files to CNXML 
     $URL: svn://kwarc.faculty.iu-bremen.de/kohlhase/kwarc/projects/content/cnx/xsl/latexml.xsl$ 
     $Revision: 262 $; last modified by $Author: brentmh $ 
     $Date: 2005-01-14 20:05:06 +0100 (Fri, 14 Jan 2005) $
     Copyright (c) 2019 Michael Kohlhase, released under the Gnu Public License 
  -->

<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://cnx.rice.edu/cnxml"
  xmlns:m="http://www.w3.org/1998/Math/MathML"
  xmlns:om="http://www.openmath.org/OpenMath"
  xmlns:ltxml="http://dlmf.nist.gov/LaTeXML"
  exclude-result-prefixes="ltxml om">

  <xsl:output method="xml" indent="yes" cdata-section-elements="data"/>
  <xsl:strip-space elements="*"/>

  <xsl:template match="ltxml:itemize|ltxml:description|ltxml:enumerate">
    <list type="{local-name()}" id="{ltxml:idgen()}">
      <xsl:apply-templates/>
    </list>
  </xsl:template>

  <xsl:template match="ltxml:item">
    <item id="{ltxml:idgen()}"><xsl:apply-templates/></item>
  </xsl:template>

  <xsl:template match="ltxml:centering|ltxml:textstyle">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="ltxml:a">
    <link src="{@href}"><xsl:apply-templates/></link>
  </xsl:template>

  <xsl:template match="ltxml:tabular">
    <table id="{generate-id}">
      <name>dummy</name>
      <tgroup id="{generate-id()}" cols="1">
        <tbody>
          <xsl:comment>losing information here, fix me </xsl:comment>
          <xsl:apply-templates/>
        </tbody>
      </tgroup>
    </table>
  </xsl:template>

  <xsl:template match="ltxml:hline"/>
  <xsl:template match="ltxml:tr"><row><xsl:apply-templates/></row></xsl:template>
  <xsl:template match="ltxml:td"><entry><xsl:apply-templates/></entry></xsl:template>
  
  <xsl:template match="ltxml:p"><para id="{generate-id()}"><xsl:apply-templates/></para></xsl:template>
  <xsl:template match="ltxml:p[ancestor::ltxml:definition or ancestor::ltxml:example]"><xsl:apply-templates/></xsl:template>

  <xsl:template match="ltxml:emph"><emphasis><xsl:apply-templates/></emphasis></xsl:template>

<!-- throw out all the XMath stuff; we are only intersted in OpenMath -->
<xsl:template match="ltxml:Math">
  <xsl:apply-templates select="om:OMOBJ"/>
</xsl:template>

<xsl:template match="om:OMOBJ">
  <m:math><xsl:apply-templates/></m:math>
</xsl:template>


<xsl:template match="om:OMA">
  <m:apply><xsl:apply-templates/></m:apply>
</xsl:template>

<xsl:template match="om:OMIND">
  <m:apply><xsl:apply-templates/></m:apply>
</xsl:template>

<xsl:template match="om:OMBVAR">
  <m:bvar><xsl:apply-templates/></m:bvar>
</xsl:template>

<xsl:template match="om:OMV">
  <m:ci><xsl:value-of select="@name"/></m:ci>
</xsl:template>

<xsl:template match="om:OMI">
  <m:cn><xsl:apply-templates/></m:cn>
</xsl:template>

<xsl:template match="om:OMA[om:OMS[@cd='cmathml' and @name='Cset' and position()=1]]">
  <m:set><xsl:apply-templates select="*[position()&gt;1]"/></m:set>
</xsl:template>
  
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Cequal']"><m:eq/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Cfactorial']"><m:factorial/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Cabs']"><m:abs/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Cconjugate']"><m:conjugate/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Carg']"><m:arg/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Creal']"><m:real/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Cimaginary']"><m:imaginary/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Cfloor']"><m:floor/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Cceiling']"><m:ceiling/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Cnot']"><m:not/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Csin']"><m:sin/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Ccos']"><m:cos/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Ctan']"><m:tan/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Csec']"><m:sec/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Ccsc']"><m:csc/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Ccot']"><m:cot/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Csinh']"><m:sinh/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Ccosh']"><m:cosh/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Ctanh']"><m:tanh/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Csech']"><m:sech/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Ccsch']"><m:csch/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Ccoth']"><m:coth/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Carcsin']"><m:arcsin/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Carccos']"><m:arccos/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Carctan']"><m:arctan/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Carccosh']"><m:arccosh/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Carccot']"><m:arccot/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Carccoth']"><m:arccoth/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Carccsc']"><m:arccsc/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Carcsinh']"><m:arcsinh/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Carctanh']"><m:arctanh/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Cexp']"><m:exp/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Cln']"><m:ln/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Clog']"><m:log/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Cdet']"><m:det/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Ctrans']"><m:trans/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Cdivergence']"><m:divergence/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Cgrad']"><m:grad/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Ccurl']"><m:curl/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Claplacian']"><m:laplacian/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Ccard']"><m:card/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Cquotient']"><m:quotient/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Cdivide']"><m:divide/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Cminus']"><m:minus/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Cpower']"><m:power/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Crem']"><m:rem/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Cimplies']"><m:implies/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Cequiv']"><m:equiv/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Capprox']"><m:approx/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Csetdiff']"><m:setdiff/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Cvectproduct']"><m:vectproduct/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Cscalarproduct']"><m:scalarproduct/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Couterproduct']"><m:outerproduct/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Cint']"><m:int/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='CintRelay']"><m:intRelay/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Ccsum']"><m:csum/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='CsumRelay']"><m:sumRelay/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Cprod']"><m:prod/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='CprodRelay']"><m:prodRelay/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Cdiff']"><m:diff/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Cpdiff']"><m:pdiff/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Cforall']"><m:forall/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Cexists']"><m:exists/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Cplus']"><m:plus/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Ctimes']"><m:times/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Cmax']"><m:max/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Cmin']"><m:min/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Cgcd']"><m:gcd/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Clcm']"><m:lcm/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Cmean']"><m:mean/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Csdev']"><m:sdev/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Cvar']"><m:var/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Cmedian']"><m:median/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Cmode']"><m:mode/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Cand']"><m:and/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Cor']"><m:or/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Cxor']"><m:xor/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Cunion']"><m:union/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Cintersect']"><m:intersect/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Ccartprod']"><m:cartesionproduct/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Cset']"><m:set/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Clist']"><m:list/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Cunion']"><m:union/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Cintersect']"><m:intersect/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Cin']"><m:in/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Cnotin']"><m:notin/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Csubset']"><m:subset/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Cprsubset']"><m:prsubset/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Cnotsubset']"><m:notsubset/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Cnotprsubset']"><m:notprsubset/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Csetdiff']"><m:setdiff/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Ccard']"><m:card/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Ccartesianproduct']"><m:cartesianproduct/></xsl:template>

  <xsl:template match="om:OMS[@cd='cmathml' and @name='Cim']"><m:imaginaryi/></xsl:template>
  <xsl:template match="om:OMS[@cd='cmathml' and @name='Cpi']"><m:pi/></xsl:template>

<xsl:template match="om:OMS">
  <m:csymbol definitionURL="#byctx({@name}@{@cd})"/>
</xsl:template>

<xsl:template match="om:OMA[om:OMV[position()=1 and @name='Collection']]">
  <xsl:apply-templates select="*[position()&gt;1]"/>
</xsl:template>

<xsl:template match="om:OMA[om:OMV[@name='Empty']]">
  <xsl:message>hey</xsl:message>
  <xsl:apply-templates select="*[not (@name='Empty')]"/>
</xsl:template>


<xsl:template match="om:OMSTR">
  <m:ci><xsl:apply-templates/></m:ci>
</xsl:template>

  <!-- any XMRefs that we can see are at the text level, so they go to OMDoc refs -->
  <xsl:template match="ltxml:XMRef">
    <ref xref="{@idref}"/>
  </xsl:template>

</xsl:stylesheet>
