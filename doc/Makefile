STY = stex extensions
SPATH = $(STY:%=../source/%)
DTX =  $(shell ls $(SPATH:%=%/*.dtx))
INS =  $(shell ls $(SPATH:%=%/*.ins))
DOC = stex-doc.pdf stex-manual.pdf
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
	$(PDFLATEX) $<

echo:
	@echo $(SPATH)
