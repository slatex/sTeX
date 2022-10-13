DTX =  stex.dtx
DOC =  $(DTX:%.dtx=%.pdf)
INS =  stex.ins

PDFLATEX = pdflatex -interaction=batchmode
TEXDIR = ../../tex
TEXINPUTS = $(TEXDIR)//:

all: package doc

doc: $(DOC)

package: $(DTX) $(INS)
	$(PDFLATEX) $(INS)
	mv *.sty *.cls $(TEXDIR)

$(DOC): %.pdf: %.dtx
	$(PDFLATEX) $<
	biber -q $(basename $<)
	makeindex -s gind.ist -o $(basename $<).ind $(basename $<).idx
	$(PDFLATEX) $<

echo:
	@echo $(TEXINPUTS)
