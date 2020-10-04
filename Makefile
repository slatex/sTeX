########################################################################
# This Makefile automates maintenance and CTAN submission of complex
# LaTeX packages. 
########################################################################

SRCDIRS		= bin lib
DOCDIRS		= example
TESTDIRS	= example test
DTXDIRS 	= sty 
MAKEDIRS 	= $(DOCDIRS) $(DTXDIRS)

all clean distclean biber: 
	@for d in $(MAKEDIRS); do (cd $$d && $(MAKE) -$(MAKEFLAGS) $@) done

package doc filedate checksum enablechecksum disablechecksum: 
	@for d in $(DTXDIRS); do (cd $$d && $(MAKE) -$(MAKEFLAGS) $@) done

test:
	@for d in $(TESTDIRS); do (cd $$d && $(MAKE) -$(MAKEFLAGS) $@) done

TDSCOLL = stex
TDS.tex = 
TDS.README = sty/README
TDS.src = 
include sty/make/Makefile.ctan

echo:
	@echo $(TDSCOLL)
