# recurse into the directories. 
MAKEDIRS = stex  extensions

all package doc: 
	@for d in $(MAKEDIRS); do (cd $$d && $(MAKE) -$(MAKEFLAGS) $@) || exit $$?; done
