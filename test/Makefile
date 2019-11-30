MAKEDIRS = omdoc

all clean distclean test: 
	@for d in $(MAKEDIRS); do (cd $$d && $(MAKE) -$(MAKEFLAGS) $@) done
