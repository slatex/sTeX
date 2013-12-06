PREFIX 		= ../
DIRS		= 
TARGET.base	= once #m0039 s0039
TARGET.cnx 	= $(TARGET.base:%=%.cnxml)
TARGET.tex.xml	= $(TARGET.base:%=%.tex.xml)
TARGET.xml	= $(TARGET.base:%=%.xml)
TARGET.pdf 	= $(TARGET.base:%=%.pdf)

LATEXML		= latexml 
LATEXMLPOST	= latexmlpost 

all::		$(TARGET.pdf) $(TARGET.cnx)

$(TARGET.tex.xml): %.tex.xml: %.tex ../sty/cnx.ltxml
		$(LATEXML) $(firstword $<) --path=../sty > $@ 

$(TARGET.xml): %.xml: %.tex.xml 
		$(LATEXMLPOST) --cmml $(firstword $<) > $@ 

$(TARGET.cnx): %.cnxml: %.xml 
		xsltproc -o $@ ../xsl/ltxml2cnx.xsl $(firstword $<) 

$(TARGET.pdf): %.pdf: %.tex 
		pdflatex $(firstword $<) 

