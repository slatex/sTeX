# recurse into the directories. 
MAKEDIRS = sty doc
DISTDIRS = $(MAKEDIRS) lib

all package doc: 
	@for d in $(MAKEDIRS); do (cd $$d && $(MAKE) -$(MAKEFLAGS) $@) || exit $$?; done
