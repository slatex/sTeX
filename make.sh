cd sty/stex
pdflatex stex.ins
# pdflatex basics.dtx
# pdflatex basics.dtx
# pdflatex mathhub.dtx
# pdflatex mathhub.dtx
cd ../extensions
pdflatex extensions.ins
pdflatex omdoc.dtx
biber omdoc
pdflatex omdoc.dtx
pdflatex mikoslides.dtx
biber mikoslides
pdflatex mikoslides.dtx
pdflatex tikzinput.dtx
biber mikoslides
pdflatex tikzinput.dtx
cd ../../doc
pdflatex stex.tex
biber stex
pdflatex stex.tex
pdflatex manual.tex
biber manual
pdflatex manual.tex
