DTX =  $(shell ls *.dtx)
DOC =  $(DTX:%.dtx=%.pdf)
INS =  stex.ins

PDFLATEX = pdflatex -interaction=batchmode
TEXDIR = ../../tex
TEXINPUTS = $(TEXDIR)//:

all: package doc mvgen

doc: $(DOC)

package: $(DTX) $(INS)
	$(PDFLATEX) $(INS)

$(DOC): %.pdf: %.dtx
	$(PDFLATEX) $<
	biber -q $(basename $<)
	$(PDFLATEX) $<

mvgen: package
	mv *.sty *.cls $(TEXDIR)

echo:
	@echo $(TEXINPUTS)
