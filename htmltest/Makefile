<<<<<<< HEAD
<<<<<<< HEAD
all: thm.html thm.ltxml

thm.html: thm.tex ../xsl/htmlpost.xsl
	latexmlc --profile instex $< --destination=$@ --log=thm.ltxlog 

thm.ltxml: thm.tex
	latexmlc --profile instex $< --destination=$@ --log=thm.ltxmllog  --stylesheet ""

echo: 
	echo $(STEXDIR)
=======
=======
all: thm.html thm.ltxml

>>>>>>> setting up validatino
thm.html: thm.tex
	latexmlc --profile insTeX $< --destination=$@ --log=thm.ltxlog 

thm.ltxml: thm.tex
	latexmlc --profile insTeX $< --destination=$@ --log=thm.ltxmllog  --stylesheet ""

# echo: 
# 	echo $(STEXDIR)
>>>>>>> starting development on html workflow
