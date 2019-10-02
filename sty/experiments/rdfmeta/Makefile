PREFIX = ../..
STEXBINDIR = ../../bin
DTX.sty.base = rdfmeta
DTX.cls.base = 
TDSCOLL = stex# lowercase by CTAN rules
CTANPREFIX = sty/
PACKAGE = rfdmeta
DTX = rdfmeta.dtx
EXAMPLE.base = certification
MODS.sms = certification.sms
include $(PREFIX)/make/Makefile.vars
include $(PREFIX)/make/Makefile.in


sms: $(MODS.sms) 

$(MODS.sms): 	%.sms: %.tex $(STEXBINDIR)/sms 
		$(SMSPROG) $<

echo:
	echo $(TEXINPUTS)
