# recurse into the directories. 
MAKEDIRS = stex  extensions metakeys
DISTDIRS = $(MAKEDIRS) compatibility etc

all package doc: 
	@for d in $(MAKEDIRS); do (cd $$d && $(MAKE) -$(MAKEFLAGS) $@) || exit $$?; done
