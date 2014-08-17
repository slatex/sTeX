MAKEDIRS = rnc rng
CLEANDIRS = rnc rng
RNG = $(shell ls rng/*.rng)
MODELS = omdoc+ltxml.model ltxml+omdoc.model

all::
	@for d in $(MAKEDIRS);\
	  do (cd $$d && $(MAKE) -$(MAKEFLAGS) $@); done;
	make $(MODELS) omdoc+ltxml.model

omdoc+ltxml.model: %.model: $(RNG) compileSchema-omdoc+ltxml.pl
	perl compileSchema-omdoc+ltxml.pl

ltxml+omdoc.model: %.model: $(RNG) compileSchema-ltxml+omdoc.pl
	perl compileSchema-ltxml+omdoc.pl

clean distclean::
	@for d in $(CLEANDIRS);\
	  do (cd $$d && $(MAKE) -$(MAKEFLAGS) $@); done;

