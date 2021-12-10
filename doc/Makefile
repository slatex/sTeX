STY = stex extensions metakeys
SPATH = $(STY:%=../sty/%)
DTX =  $(shell ls $(SPATH:%=%/*.dtx))
INS =  $(shell ls $(SPATH:%=%/*.ins))
DOC = stex.pdf manual.pdf

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
