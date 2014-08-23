all: thm.html thm.ltxml

thm.html: thm.tex ../xsl/htmlpost.xsl
	latexmlc --profile insTeX $< --destination=$@ --log=thm.ltxlog 

thm.ltxml: thm.tex
	latexmlc --profile insTeX $< --destination=$@ --log=thm.ltxmllog  --stylesheet ""

echo: 
	echo $(STEXDIR)
