BINDIR		= ../../../../bin
MODS		= $(shell ls *.tex)
SMS	        = $(MODS:%.tex=%.sms)
PDF		= $(MODS:%.tex=%.pdf)

TEXINPUTS = .:..:../..//:

all:	$(SMS) $(PDF)

sms:	$(SMS)

$(SMS): 	%.sms: %.tex $(BINDIR)/sms 
		$(BINDIR)/sms $<

$(PDF): 	%.pdf: %.tex 
		pdflatex $<
