SRCDIRS		= bin make schema xsl
DOCDIRS		= example
DTXDIRS 	= sty 
MAKEDIRS 	= $(SRCDIRS) $(DOCDIRS) $(DTXDIRS)

all clean distclean: 
	@for d in $(MAKEDIRS); do (cd $$d && $(MAKE) -$(MAKEFLAGS) $@) done

package doc filedate checksum enablechecksum disablechecksum: 
	@for d in $(DTXDIRS); do (cd $$d && $(MAKE) -$(MAKEFLAGS) $@) done

ci: 
	svn $@ -m'draining'

cleanup: 
	svn $@ 

TDS.tex = 
TDS.doc = README
TDS.src = 
TDSURL		= https://svn.kwarc.info/repos/stex/trunk
include sty/make/Makefile.ctan

echo:
	echo $(PWD)
