PREFIX = ..
STEXBINDIR = ../../bin
DTX.sty.base = rdfmeta
DTX.cls.base = 
TDSCOLL = stex
CTANPREFIX = /sty
PACKAGE = rdfmeta
EXAMPLE.base = certification
MODS.sms = certification.sms
include $(PREFIX)/make/Makefile.vars
include $(PREFIX)/make/Makefile.in


sms: $(MODS.sms) 

$(MODS.sms): 	%.sms: %.tex $(STEXBINDIR)/sms 
		$(SMSPROG) $<

echo:
	echo $(TEXINPUTS)
