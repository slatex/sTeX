STY = .
SPATH = $(STY:%=../source/%)
DTX =  $(shell ls $(SPATH:%=%/*.dtx))
INS =  $(shell ls $(SPATH:%=%/*.ins))
DOC = stex-doc.pdf
TEXDIR = ../tex
TEXINPUTS = $(TEXDIR)//:

PDFLATEX = pdflatex -interaction=batchmode

all: pack doc

doc: $(DOC)

package:

pack: $(DTX) $(INS)
	@for i in $(SPATH); do cd $$i; make package; done

$(DOC): %.pdf: %.tex pack
	$(PDFLATEX) $<
	biber -q $(basename $<)
	makeindex -s gind.ist -o $(basename $<).ind $(basename $<).idx
	$(PDFLATEX) $<

echo:
	@echo $(SPATH)
