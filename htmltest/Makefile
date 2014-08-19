all: thm.html thm.ltxml

thm.html: thm.tex
	latexmlc --profile insTeX $< --destination=$@ --log=thm.ltxlog 

thm.ltxml: thm.tex
	latexmlc --profile insTeX $< --destination=$@ --log=thm.ltxmllog  --stylesheet ""

# echo: 
# 	echo $(STEXDIR)
