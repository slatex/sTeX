DTX =  stex-metakeys.dtx
DOC =  $(DTX:%.dtx=%.pdf)
INS =  $(DTX:%.dtx=%.ins)

PDFLATEX = pdflatex -interaction=batchmode

all: package doc

doc: $(DOC)

package: $(DTX) $(INS)
	$(PDFLATEX) $(INS)

$(DOC): %.pdf: %.dtx package
	$(PDFLATEX) $<
	biber -q $(basename $<)
	$(PDFLATEX) $<

echo:
	@echo $(DOC)
