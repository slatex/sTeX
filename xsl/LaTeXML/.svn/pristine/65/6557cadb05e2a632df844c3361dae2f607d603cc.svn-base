<xsl:stylesheet version="1.0" 
	xmlns="http://www.w3.org/1999/xhtml" 
	xmlns:zbl="http://zentralblatt.org" 
	xmlns:m="http://www.w3.org/1998/Math/MathML" 
	xmlns:ltx="http://dlmf.nist.gov/LaTeXML"
	xmlns:func="http://exslt.org/functions" 
    xmlns:str="http://exslt.org/strings" 
	extension-element-prefixes="func str"
	exclude-result-prefixes="func str"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml" indent="yes"/> 
<xsl:strip-space elements="*"/>

<!-- first the foreign namespaces -->
<xsl:template match="ltx:Math">
  <xsl:copy-of select="m:math"/>
</xsl:template>

<xsl:template match="ltx:equation">
  <div class="equation"><xsl:copy-of select="ltx:Math/m:math"/></div>
</xsl:template>

<!-- then the zbl structure -->
<xsl:template match="/">
  <xsl:comment>This file was automatically created from LaTeX source, do not manually edit!</xsl:comment>
  <html>
    <head>
      <style type="text/css">
        html{border: 0px #006699 solid;border-left-width: 15px}
        body {margin: 15px;padding: 0px;background-color:#ffffff;color:black;
              font-family:helvetica;font-size: 14px;line-height: 1.4em}
        div.volume-title {font-size:24pt;text-align:center;font-weight:bold}
        div.title {font-style:italic;font-weight:bold}
        div.mathics {font-size:larger;font-weight:bold}
        span.mathics-zbl {float:right}
        div.matverw {font-size:smaller}
        div.review {margin:5mm 5mm 5mm 5mm}
        div.aunot {font-weight:bold}
        div.published {font-weight:bold}
		.number {font-style: italic; text-align:right}
        div.reviewer{font-style:italic;text-align:right}
      </style>
      <!--       <link rel="stylesheet" type="text/css" href="zbl.css"/> -->
      <title><xsl:value-of select="/zbl:document/zbl:title"/></title>
    </head>
    <body><xsl:apply-templates/></body>
  </html>
</xsl:template>

<xsl:template match="zbl:document">
  <xsl:apply-templates/>
</xsl:template>
    

<xsl:template match="zbl:title">
  <div class="title"><xsl:apply-templates/></div>
</xsl:template>

<xsl:template match="zbl:title" mode="inline">
  <span class="title"><xsl:apply-templates/></span>
</xsl:template>


<xsl:template match="zbl:document/zbl:title">
  <div class="volume-title"><xsl:apply-templates/></div>
</xsl:template>


<xsl:template match="zbl:mathics">
  <hr/>
  <div class="mathics">
    <xsl:apply-templates select="zbl:number"/>
    <xsl:text> </xsl:text>
    <xsl:apply-templates select="zbl:title" mode="inline"/>
    <span class="mathics-zbl"><xsl:text> Zentralblatt MATH</xsl:text></span>
  </div>
  <hr/>
  <xsl:apply-templates select="*[local-name()!='number' and local-name()!='title']"/>
</xsl:template>

<xsl:template match="zbl:doctype">
  <div class="doctype">
    <xsl:apply-templates/>
  </div>
</xsl:template>

<xsl:template match="zbl:keywords">
  <div class="keywords">
    <xsl:apply-templates/>
  </div>
</xsl:template>

<xsl:template match="zbl:language">
  <div class="language">
    <xsl:apply-templates/>
  </div>
</xsl:template>

<xsl:template match="zbl:language">
  <div class="language">
    <xsl:apply-templates/>
  </div>
</xsl:template>

<xsl:template match="zbl:class">
  <div class="class">
    <xsl:apply-templates/>
  </div>
</xsl:template>


<xsl:template match="zbl:zwigeb">
  <div class="zwigeb">
    <xsl:apply-templates select="zbl:number"/>
    <xsl:text> </xsl:text>
    <xsl:apply-templates select="zbl:title" mode="inline"/>
  </div>
  <xsl:apply-templates select="*[local-name()!='number' and local-name()!='title']"/>
</xsl:template>

<xsl:template match="zbl:matverw">
  <xsl:variable name="num" select="zbl:number"/>
  <xsl:variable name="numbers" select="zbl:numbers/text()"/>
  <div class="matverw">
    <xsl:text>For other publications concerning </xsl:text>
    <xsl:value-of select="$num"/>
    <xsl:text> see: </xsl:text>
    <xsl:for-each select="str:tokenize($numbers,'&#x09;&#x0A;&#x0D;')">
      <span class="matverw-numberref"><xsl:value-of select="."/></span>
    </xsl:for-each>
  </div>
</xsl:template>

<xsl:template match="zbl:review"> 
  <div class="review">
     <div class="aunot"> 
        <xsl:apply-templates select="zbl:author"/>
       <xsl:apply-templates select="zbl:number"/>
     </div>
       <xsl:apply-templates select="zbl:title|zbl:published|zbl:body|zbl:reviewer"/>
  </div>
</xsl:template>

<xsl:template match="zbl:number">
  <xsl:text> Number: </xsl:text>
  <span class='number'><xsl:apply-templates/></span>
</xsl:template>

<xsl:template match="zbl:author">
  <span class='author'><xsl:apply-templates/></span>
</xsl:template>

<xsl:template match="zbl:published">
  <div class="published"><xsl:apply-templates/></div>
</xsl:template>

<xsl:template match="zbl:body">
  <div class="review-body"><xsl:apply-templates/></div>
</xsl:template>

<xsl:template match="zbl:reviewer">
  <div class="reviewer"><xsl:apply-templates/></div>
</xsl:template>


<func:function name="zbl:num2text">
<xsl:param name="num"/>
  <xsl:choose>
    <xsl:when test="$num='00'"><func:result>General</func:result></xsl:when>
    <xsl:when test="$num='01'"><func:result>History and biography</func:result></xsl:when>
    <xsl:when test="$num='03'"><func:result>Mathematical Logic and foundations</func:result></xsl:when>
    <xsl:when test="$num='05'"><func:result>Combinatorics</func:result></xsl:when>
    <xsl:when test="$num='06'"><func:result>Order, lattices, ordered algebraic structures</func:result></xsl:when>
    <xsl:when test="$num='08'"><func:result>General algebraic systems</func:result></xsl:when>
    <xsl:when test="$num='11'"><func:result>Number theory</func:result></xsl:when>
    <xsl:when test="$num='12'"><func:result>Field theory and polynomials</func:result></xsl:when>
    <xsl:when test="$num='13'"><func:result>Commutative rings and algebras</func:result></xsl:when>
    <xsl:when test="$num='14'"><func:result>Algebraic geometry</func:result></xsl:when>
    <xsl:when test="$num='15'"><func:result>Linear and multilinear algebra;  matrix theory (finite and infinite)</func:result></xsl:when>
    <xsl:when test="$num='16'"><func:result>Associative rings and algebras</func:result></xsl:when>
    <xsl:when test="$num='17'"><func:result>Nonassociative rings and algebras</func:result></xsl:when>
    <xsl:when test="$num='18'"><func:result>Category theory,  homological algebra</func:result></xsl:when>
    <xsl:when test="$num='19'"><func:result>K-theory</func:result></xsl:when>
    <xsl:when test="$num='20'"><func:result>Group theory and generalizations</func:result></xsl:when>
    <xsl:when test="$num='22'"><func:result>Topological groups, Lie groups</func:result></xsl:when>
    <xsl:when test="$num='26'"><func:result>Real functions</func:result></xsl:when>
    <xsl:when test="$num='28'"><func:result>Measure and integration</func:result></xsl:when>
    <xsl:when test="$num='30'"><func:result>Functions of a complex variable</func:result></xsl:when>
    <xsl:when test="$num='31'"><func:result>Potential theory</func:result></xsl:when>
    <xsl:when test="$num='32'"><func:result>Several complex variables and  analytic spaces</func:result></xsl:when>
    <xsl:when test="$num='33'"><func:result>Special functions</func:result></xsl:when>
    <xsl:when test="$num='34'"><func:result>Ordinary differential equations</func:result></xsl:when>
    <xsl:when test="$num='35'"><func:result>Partial differential equations</func:result></xsl:when>
    <xsl:when test="$num='37'"><func:result>Dynamical systems and  ergodic theory</func:result></xsl:when>
    <xsl:when test="$num='39'"><func:result>Difference and functional equations</func:result></xsl:when>
    <xsl:when test="$num='40'"><func:result>Sequences, series, summability</func:result></xsl:when>
    <xsl:when test="$num='41'"><func:result>Approximations and expansions</func:result></xsl:when>
    <xsl:when test="$num='42'"><func:result>Fourier analysis</func:result></xsl:when>
    <xsl:when test="$num='43'"><func:result>Abstract harmonic analysis</func:result></xsl:when>
    <xsl:when test="$num='44'"><func:result>Integral transforms</func:result></xsl:when>
    <xsl:when test="$num='45'"><func:result>Integral equations</func:result></xsl:when>
    <xsl:when test="$num='46'"><func:result>Functional analysis</func:result></xsl:when>
    <xsl:when test="$num='47'"><func:result>Operator theory</func:result></xsl:when>
    <xsl:when test="$num='49'"><func:result>Calculus of variations and  optimal control; optimization</func:result></xsl:when>
    <xsl:when test="$num='51'"><func:result>Geometry</func:result></xsl:when>
    <xsl:when test="$num='52'"><func:result>Convex and discrete geometry</func:result></xsl:when>
    <xsl:when test="$num='53'"><func:result>Differential geometry</func:result></xsl:when>
    <xsl:when test="$num='54'"><func:result>General topology</func:result></xsl:when>
    <xsl:when test="$num='55'"><func:result>Algebraic topology</func:result></xsl:when>
    <xsl:when test="$num='57'"><func:result>Manifolds and cell complexes</func:result></xsl:when>
    <xsl:when test="$num='58'"><func:result>Global analysis,  analysis on manifolds</func:result></xsl:when>
    <xsl:when test="$num='60'"><func:result>Probability theory and  stochastic processes</func:result></xsl:when>
    <xsl:when test="$num='62'"><func:result>Statistics</func:result></xsl:when>
    <xsl:when test="$num='65'"><func:result>Numerical analysis</func:result></xsl:when>
    <xsl:when test="$num='68'"><func:result>Computer science</func:result></xsl:when>
    <xsl:when test="$num='70'"><func:result>Mechanics of particles and systems</func:result></xsl:when>
    <xsl:when test="$num='74'"><func:result>Mechanics of deformable solids</func:result></xsl:when>
    <xsl:when test="$num='76'"><func:result>Fluid mechanics</func:result></xsl:when>
    <xsl:when test="$num='78'"><func:result>Optics, electromagnetic theory</func:result></xsl:when>
    <xsl:when test="$num='80'"><func:result>Classical thermodynamics,  heat transfer</func:result></xsl:when>
    <xsl:when test="$num='81'"><func:result>Quantum theory</func:result></xsl:when>
    <xsl:when test="$num='82'"><func:result>Statistical mechanics,  structure of matter</func:result></xsl:when>
    <xsl:when test="$num='83'"><func:result>Relativity and gravitational theory</func:result></xsl:when>
    <xsl:when test="$num='85'"><func:result>Astronomy and astrophysics</func:result></xsl:when>
    <xsl:when test="$num='86'"><func:result>Geophysics</func:result></xsl:when>
    <xsl:when test="$num='90'"><func:result>Operations research,  mathematical programming</func:result></xsl:when>
    <xsl:when test="$num='91'"><func:result>Game theory, economics,  social and behavioral sciences</func:result></xsl:when>
    <xsl:when test="$num='92'"><func:result>Biology and other natural sciences</func:result></xsl:when>
    <xsl:when test="$num='93'"><func:result>Systems theory; control</func:result></xsl:when>
    <xsl:when test="$num='94'"><func:result>Information and communication, circuits</func:result></xsl:when>
    <xsl:when test="$num='97'"><func:result>Mathematical education</func:result></xsl:when>
  </xsl:choose>
</func:function>
</xsl:stylesheet>

