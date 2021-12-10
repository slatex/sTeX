DTX =  $(shell ls *.dtx)
DOC =  $(DTX:%.dtx=%.pdf)
INS =  extensions.ins

PDFLATEX = pdflatex -interaction=batchmode

all: package doc

doc: $(DOC)

package: $(DTX) $(INS)
	$(PDFLATEX) $(INS)

$(DOC): %.pdf: %.dtx 
	$(PDFLATEX) $<
	biber -q $(basename $<)
	$(PDFLATEX) $<


echo:
	@echo $(DTX)
