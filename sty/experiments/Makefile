# recurse into the directories. 
DISTDIRS = owl2onto reqdoc# mmtlatex 
MAKEDIRS = $(DISTDIRS)

all ltxml package doc filedate checksum enablechecksum disablechecksum clean distclean: 
	@for d in $(MAKEDIRS); do (cd $$d && $(MAKE) -$(MAKEFLAGS) $@) || exit $$?; done

TDSCOLL = stex
TDS.tex = stex.tex stex.sty stex.sty.ltxml stex-logo.sty stex-logo.sty.ltxml ctansvn.sty
TDS.doc = README stex.pdf
TDS.src = 
