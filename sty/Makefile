# recurse into the directories. 
DISTDIRS = stex compatibility extensions metakeys etc
MAKEDIRS = $(DISTDIRS)

all package doc: 
	@for d in $(MAKEDIRS); do (cd $$d && $(MAKE) -$(MAKEFLAGS) $@) || exit $$?; done
