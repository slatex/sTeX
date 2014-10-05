all: thm.html thm.ltxml

thm.html: thm.tex ../xsl/htmlpost.xsl
	latexmlc --profile instex $< --destination=$@ --log=thm.ltxlog 

thm.ltxml: thm.tex
	latexmlc --profile instex $< --destination=$@ --log=thm.ltxmllog  --stylesheet ""

echo: 
	echo $(STEXDIR)
