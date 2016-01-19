# recurse into the directories. 
DISTDIRS = core 
MAKEDIRS = $(DISTDIRS) obsolete experiments

ltds lctan filedate checksum enablechecksum disablechecksum: 
	@for d in $(DISTDIRS); do (cd $$d && $(MAKE) -$(MAKEFLAGS) $@) || exit $$?; done

all  package doc clean distclean: 
	@for d in $(MAKEDIRS); do (cd $$d && $(MAKE) -$(MAKEFLAGS) $@) || exit $$?; done

TDSCOLL = stex
TDS.tex = stex.tex stex.sty stex.sty.ltxml stex-logo.sty stex-logo.sty.ltxml ctansvn.sty
TDS.doc = README stex.pdf
TDS.src = 

include make/Makefile.ctan

