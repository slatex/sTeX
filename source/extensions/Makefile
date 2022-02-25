DTX =  $(shell ls *.dtx)
DOC =  $(DTX:%.dtx=%.pdf)
INS =  extensions.ins

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
	$(PDFLATEX) $<


echo:
	@echo $(DTX)
