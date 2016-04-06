########################################################################
# This Makefile automates maintenance and CTAN submission of complex
# LaTeX packages. 
########################################################################

SRCFILES	= bin/sms
DOCDIRS		= example
DTXDIRS 	= sty 
MAKEDIRS 	= $(SRCDIRS) $(DOCDIRS) $(DTXDIRS)

all clean distclean: 
	@for d in $(MAKEDIRS); do (cd $$d && $(MAKE) -$(MAKEFLAGS) $@) done

package doc filedate checksum enablechecksum disablechecksum: 
	@for d in $(DTXDIRS); do (cd $$d && $(MAKE) -$(MAKEFLAGS) $@) done

TDSCOLL = stex
TDS.tex = 
TDS.README = sty/README
TDS.src = 
include sty/make/Makefile.ctan

echo:
	@echo $(TDSCOLL)
