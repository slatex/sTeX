# recurse into the directories. 
DISTDIRS = 
MAKEDIRS = $(DISTDIRS) owl2onto reqdoc# mmtlatex 

all package doc clean distclean: 
	@for d in $(MAKEDIRS); do (cd $$d && $(MAKE) -$(MAKEFLAGS) $@) || exit $$?; done
ltds lctan filedate checksum enablechecksum disablechecksum: 
	@for d in $(DISTDIRS); do (cd $$d && $(MAKE) -$(MAKEFLAGS) $@) || exit $$?; done

TDSCOLL = stex
TDS.tex = stex.tex stex.sty stex-logo.sty ctansvn.sty
TDS.doc = README stex.pdf
TDS.src = 
