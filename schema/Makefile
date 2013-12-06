MAKEDIRS = rnc rng
CLEANDIRS = rnc rng
RNG = $(shell ls rng/*.rng)

all::
	@for d in $(MAKEDIRS);\
	  do (cd $$d && $(MAKE) -$(MAKEFLAGS) $@); done;
	make omdoc+ltxml.model

omdoc+ltxml.model: $(RNG) compileSchema.pl
	perl compileSchema.pl

clean distclean::
	@for d in $(CLEANDIRS);\
	  do (cd $$d && $(MAKE) -$(MAKEFLAGS) $@); done;

